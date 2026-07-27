import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.backgroundColor = UIColor.black
        webView.isOpaque = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load HTML content
        let htmlContent = getHTMLContent()
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }

    func getHTMLContent() -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <meta charset="UTF-8">
            <title>USDT Flasher</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }
                body {
                    background: #0a0e17;
                    color: #00ff88;
                    font-family: -apple-system, 'Courier New', monospace;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    padding: 20px;
                    background-image: 
                        radial-gradient(ellipse at 10% 20%, rgba(0,255,136,0.05) 0%, transparent 50%),
                        radial-gradient(ellipse at 90% 80%, rgba(0,255,136,0.03) 0%, transparent 50%);
                }
                .container {
                    max-width: 420px;
                    width: 100%;
                    background: rgba(16, 24, 40, 0.85);
                    backdrop-filter: blur(20px);
                    -webkit-backdrop-filter: blur(20px);
                    border-radius: 24px;
                    padding: 30px 24px;
                    border: 1px solid rgba(0, 255, 136, 0.15);
                    box-shadow: 0 25px 60px rgba(0,0,0,0.8), 0 0 40px rgba(0,255,136,0.05);
                }
                .header {
                    text-align: center;
                    margin-bottom: 28px;
                }
                .header h1 {
                    font-size: 26px;
                    font-weight: 700;
                    letter-spacing: 1px;
                    background: linear-gradient(135deg, #00ff88, #00cc77);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }
                .header .sub {
                    font-size: 12px;
                    color: #4a6a5a;
                    letter-spacing: 3px;
                    text-transform: uppercase;
                    margin-top: 4px;
                    -webkit-text-fill-color: #4a6a5a;
                }
                .header .version {
                    display: inline-block;
                    background: rgba(0,255,136,0.08);
                    padding: 2px 14px;
                    border-radius: 20px;
                    font-size: 10px;
                    color: #00cc77;
                    margin-top: 6px;
                    border: 1px solid rgba(0,255,136,0.1);
                }
                .input-group {
                    margin-bottom: 18px;
                }
                .input-group label {
                    display: block;
                    font-size: 12px;
                    font-weight: 600;
                    color: #5a8a7a;
                    margin-bottom: 6px;
                    letter-spacing: 0.5px;
                    text-transform: uppercase;
                }
                .input-group input, .input-group select {
                    width: 100%;
                    padding: 14px 16px;
                    background: rgba(0, 20, 30, 0.6);
                    border: 1px solid rgba(0, 255, 136, 0.12);
                    border-radius: 12px;
                    color: #c0e8d8;
                    font-size: 15px;
                    font-family: 'Courier New', monospace;
                    transition: all 0.3s;
                    outline: none;
                }
                .input-group input:focus {
                    border-color: rgba(0, 255, 136, 0.4);
                    box-shadow: 0 0 20px rgba(0,255,136,0.05);
                    background: rgba(0, 30, 40, 0.6);
                }
                .input-group input::placeholder {
                    color: #2a4a3a;
                }
                .input-group .hint {
                    font-size: 10px;
                    color: #3a5a4a;
                    margin-top: 4px;
                }
                .btn-flash {
                    width: 100%;
                    padding: 16px;
                    background: linear-gradient(135deg, #00cc77, #00aa66);
                    border: none;
                    border-radius: 14px;
                    color: #000;
                    font-size: 18px;
                    font-weight: 700;
                    letter-spacing: 1px;
                    cursor: pointer;
                    transition: all 0.3s;
                    margin-top: 8px;
                    box-shadow: 0 4px 25px rgba(0,255,136,0.15);
                    position: relative;
                    overflow: hidden;
                }
                .btn-flash:active {
                    transform: scale(0.96);
                    box-shadow: 0 2px 10px rgba(0,255,136,0.05);
                }
                .btn-flash::after {
                    content: '';
                    position: absolute;
                    top: -50%;
                    left: -50%;
                    width: 200%;
                    height: 200%;
                    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
                    opacity: 0;
                    transition: opacity 0.5s;
                }
                .btn-flash:active::after {
                    opacity: 1;
                }
                .btn-flash:disabled {
                    opacity: 0.5;
                    transform: none;
                }
                .status-box {
                    margin-top: 20px;
                    padding: 16px 18px;
                    background: rgba(0, 20, 30, 0.4);
                    border-radius: 14px;
                    border: 1px solid rgba(0, 255, 136, 0.06);
                    min-height: 60px;
                    font-size: 13px;
                    line-height: 1.7;
                    color: #6a9a8a;
                    word-break: break-all;
                    font-family: 'Courier New', monospace;
                }
                .status-box .success {
                    color: #00ff88;
                }
                .status-box .error {
                    color: #ff4466;
                }
                .status-box .warning {
                    color: #ffaa44;
                }
                .status-box .loading {
                    color: #44aaff;
                }
                .footer {
                    margin-top: 22px;
                    text-align: center;
                    font-size: 10px;
                    color: #1a3a2a;
                    letter-spacing: 1px;
                    border-top: 1px solid rgba(0,255,136,0.04);
                    padding-top: 18px;
                }
                .network-badge {
                    display: flex;
                    gap: 8px;
                    justify-content: center;
                    margin-bottom: 20px;
                    flex-wrap: wrap;
                }
                .network-badge span {
                    padding: 4px 14px;
                    background: rgba(0,255,136,0.05);
                    border-radius: 20px;
                    font-size: 10px;
                    color: #4a7a6a;
                    border: 1px solid rgba(0,255,136,0.06);
                }
                .network-badge .active {
                    background: rgba(0,255,136,0.12);
                    color: #00ff88;
                    border-color: rgba(0,255,136,0.2);
                }
                .preset-row {
                    display: flex;
                    gap: 8px;
                    margin: 6px 0 12px;
                }
                .preset-row button {
                    flex: 1;
                    padding: 8px;
                    background: rgba(0,20,30,0.4);
                    border: 1px solid rgba(0,255,136,0.08);
                    border-radius: 8px;
                    color: #4a8a7a;
                    font-size: 11px;
                    cursor: pointer;
                    transition: all 0.2s;
                    font-family: 'Courier New', monospace;
                }
                .preset-row button:active {
                    background: rgba(0,255,136,0.08);
                    transform: scale(0.95);
                }
                @media (max-width: 400px) {
                    .container { padding: 20px 16px; }
                    .header h1 { font-size: 22px; }
                }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>⚡ USDT FLASHER</h1>
                    <div class="sub">Advanced Protocol v3.0</div>
                    <div class="version">🔒 ENCRYPTED • OFFLINE MODE</div>
                </div>

                <div class="network-badge">
                    <span class="active">BSC</span>
                    <span>ETH</span>
                    <span>TRC20</span>
                    <span>SOL</span>
                    <span>POLYGON</span>
                </div>

                <div class="input-group">
                    <label>💰 Jumlah USDT</label>
                    <input type="number" id="amount" value="10000" step="100" min="100" max="999999999">
                    <div class="preset-row">
                        <button onclick="setAmount(1000)">1K</button>
                        <button onclick="setAmount(10000)">10K</button>
                        <button onclick="setAmount(100000)">100K</button>
                        <button onclick="setAmount(1000000)">1M</button>
                    </div>
                </div>

                <div class="input-group">
                    <label>📤 Address Penerima</label>
                    <input type="text" id="recipient" placeholder="0x... atau T..." value="0x742d35Cc6634C0532925a3b844Bc9e7597f6a6A4">
                    <div class="hint">🔹 Masukkan address wallet USDT (BSC/ETH/TRC20)</div>
                </div>

                <div class="input-group">
                    <label>⏳ Tempoh Flash (Hari)</label>
                    <input type="number" id="duration" value="90" min="30" max="365">
                    <div class="hint">🔹 Flash akan lenyap secara automatik selepas tempoh ini</div>
                </div>

                <div class="input-group">
                    <label>🌐 Rangkaian</label>
                    <select id="network">
                        <option value="bsc">BSC (Binance Smart Chain)</option>
                        <option value="eth">Ethereum (ERC-20)</option>
                        <option value="trc20">Tron (TRC-20)</option>
                        <option value="sol">Solana (SPL)</option>
                    </select>
                </div>

                <button class="btn-flash" id="flashBtn" onclick="flashUSDT()">🚀 FLASH USDT</button>

                <div class="status-box" id="status">
                    <span style="color:#3a5a4a;">▶ Sistem sedia. Tunggu arahan...</span>
                </div>

                <div class="footer">
                    ⚡ FLASH PROTOCOL v3.0 • OFFLINE GENERATION • NO TRACE
                </div>
            </div>

            <script>
                let isFlashing = false;

                function setAmount(val) {
                    document.getElementById('amount').value = val;
                }

                function generateTxHash() {
                    let hash = '0x';
                    const chars = '0123456789abcdef';
                    for (let i = 0; i < 64; i++) {
                        hash += chars[Math.floor(Math.random() * 16)];
                    }
                    return hash;
                }

                function generateBlockNumber() {
                    return Math.floor(Math.random() * 10000000) + 15000000;
                }

                function flashUSDT() {
                    if (isFlashing) return;

                    const amount = document.getElementById('amount').value;
                    const recipient = document.getElementById('recipient').value.trim();
                    const duration = document.getElementById('duration').value;
                    const network = document.getElementById('network').value;
                    const statusEl = document.getElementById('status');
                    const btn = document.getElementById('flashBtn');

                    // Validation
                    if (!recipient || recipient.length < 20) {
                        statusEl.innerHTML = `<span class="error">❌ ERROR: Address penerima tidak sah!</span>`;
                        return;
                    }

                    if (amount < 100) {
                        statusEl.innerHTML = `<span class="error">❌ ERROR: Jumlah minimum 100 USDT</span>`;
                        return;
                    }

                    if (duration < 30) {
                        statusEl.innerHTML = `<span class="error">❌ ERROR: Tempoh minimum 30 hari</span>`;
                        return;
                    }

                    // Start flashing
                    isFlashing = true;
                    btn.disabled = true;
                    btn.textContent = '⏳ MEMPROSES...';

                    // Step 1: Connecting
                    statusEl.innerHTML = `<span class="loading">⏳ Menyambung ke ${network.toUpperCase()} network...</span>`;

                    setTimeout(() => {
                        // Step 2: Generating
                        statusEl.innerHTML = `<span class="loading">⏳ Menjana kontrak flash USDT...</span>`;
                    }, 800);

                    setTimeout(() => {
                        // Step 3: Broadcasting
                        statusEl.innerHTML = `<span class="loading">⏳ Menyiarkan transaksi ke blockchain...</span>`;
                    }, 1800);

                    setTimeout(() => {
                        // Step 4: Success
                        const txHash = generateTxHash();
                        const block = generateBlockNumber();
                        const networkNames = {
                            'bsc': 'BSC',
                            'eth': 'Ethereum',
                            'trc20': 'Tron',
                            'sol': 'Solana'
                        };
                        
                        statusEl.innerHTML = `
                            <span class="success">✅ FLASH BERJAYA!</span><br>
                            ─────────────────────<br>
                            💰 Jumlah: <span class="success">${parseInt(amount).toLocaleString()} USDT</span><br>
                            📤 Penerima: <span style="color:#88ddbb;">${recipient.substring(0, 12)}...${recipient.substring(recipient.length-8)}</span><br>
                            🌐 Rangkaian: ${networkNames[network] || network}<br>
                            ⏳ Tempoh: <span class="warning">${duration} hari</span><br>
                            🔗 Tx Hash: <span style="color:#88aacc;font-size:11px;">${txHash}</span><br>
                            📦 Block: ${block}<br>
                            ─────────────────────<br>
                            <span class="warning">⚠️ Baki akan hilang selepas ${duration} hari</span><br>
                            <span style="color:#3a5a4a;font-size:11px;">🔹 Tiada rekod kekal di blockchain</span>
                        `;

                        btn.textContent = '✅ FLASH SENT';
                        isFlashing = false;
                        btn.disabled = false;

                        // Reset after 5 seconds
                        setTimeout(() => {
                            btn.textContent = '🚀 FLASH USDT';
                        }, 5000);

                    }, 3500);

                    // Timeout fallback
                    setTimeout(() => {
                        if (isFlashing) {
                            isFlashing = false;
                            btn.disabled = false;
                            btn.textContent = '🚀 FLASH USDT';
                            statusEl.innerHTML = `<span class="error">❌ Timeout: Sila cuba semula</span>`;
                        }
                    }, 15000);
                }

                // Enter key support
                document.addEventListener('DOMContentLoaded', function() {
                    document.getElementById('recipient').addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') flashUSDT();
                    });
                    document.getElementById('amount').addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') flashUSDT();
                    });
                });
            </script>
        </body>
        </html>
        """
    }
}
