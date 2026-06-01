Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CF0CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18B1848A6;
	Mon,  1 Jun 2026 14:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DU+auwS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C9E84878; Mon,  1 Jun 2026 10:12:57 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1A584839
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 26B5060098;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0AB7C2BCB8;
 Mon,  1 Jun 2026 08:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301571;
 bh=i8d+7dAQc75Ewm6NMQu072GPq4j3ZwA7P19MVfetdSo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DU+auwS4U/dXdFaIKdQ9mPv/QsfsufEZYBanVGddJId4vOuvFFDI0gXNCaM2I3ibs
 uge/OTqxLeyNfhYJm9GPQc3BKdMXEIdZmoEuO5ADM6TSlS5L05pUAsBRZJnc2SqF/y
 GjJuB+WrTX3R7oLeZTNzxAd4h5/7RZ65MuVW2guJTM09QmAKONm+5e3JTLgGmoU/V2
 AbGdI03byXoXoowyswzAUWbCFNhSPry68p0fsEhlFcC2Vcjb7VY/sxNSK4d9mUZHYE
 zG/3/h3C3kn9gDmOiiConlR3Hgvj97vllDuBR8txa9KkLXKrGG3IurJtSnpzW2C9CO
 HtoEYG/mTLD1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B82BFCD5BD1;
 Mon,  1 Jun 2026 08:12:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:42 +1000
Subject: [PATCH RESEND 01/16] serial: msm: UARTDM <1.4 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-1-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=9131;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=JIzytHseE2Qf9US4tgmx17Ro1B1dxtn5zq5Wg7UK264=;
 b=6+1Hj0YD5bjMB1gXst3V0OrCWN+GTczQUVPd1QsoXB7h5px/e0q0zV9VTOioaYBomTmn1aJYz
 WY3LQ3aNE5VDSyOrlIKwCZzWgPEpABWgt25ioB4wkZOe00thA9eN1ai
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Prior to ff701837850e, this driver already operated in the packed FIFO
mode that is supported by all UARTDM versions. In order to work around
longstanding issues with the RX path, it was switched to the simpler
"single char mode", which avoids the necessary CMD_FORCE_STALE usage
that a non-IRQ polled environment like U-Boot requires.

Interestingly, the previous iteration of this driver would already have
worked on older UARTDM versions, except it was referencing the newer 1.4
register layout. The older register layout is supported by *all* UARTDM
versions, so in addition to restoring the packed mode behaviour, the
registers are switched up a bit.

I spoke with Stephan Gerhold about this at length and we decided that,
to ensure there's zero risk of re-introducing the previous issue, we'll
maintain both modes, preferring single-char for 1.4 peripherals, and
packed mode for everything else. This ensures we don't regress the
autoboot behaviour of db410c.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/serial/serial_msm.c | 140 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 18d15b7b15b..10948e2aede 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -23,7 +23,12 @@
 
 #define UARTDM_DMEN			0x3C /* DMA/data-packing mode */
 #define UARTDM_DMEN_TXRX_SC_ENABLE	(BIT(4) | BIT(5))
+#define UARTDM_DMRX             0x34 /* Max RX transfer length */
+#define UARTDM_NCF_TX           0x40 /* Number of chars to TX */
 
+#define UARTDM_RXFS             0x50 /* RX channel status register */
+#define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
+#define UARTDM_RXFS_BUF_MASK    0x7
 #define UARTDM_MR1				 0x00
 #define UARTDM_MR1_RX_RDY_CTL			 BIT(7)
 #define UARTDM_MR2				 0x04
@@ -38,18 +43,30 @@
  * The baud rate is the core clock frequency divided by the fixed divider value
  * programmed into this register (defined in calc_csr_bitrate()).
  */
-#define UARTDM_CSR				 0xA0
+#define UARTDM_CSR				 0x08
 
-#define UARTDM_SR                0xA4 /* Status register */
+#define UARTDM_SR                0x08 /* Status register */
 #define UARTDM_SR_RX_READY       (1 << 0) /* Receiver FIFO has data */
 #define UARTDM_SR_TX_READY       (1 << 2) /* Transmitter FIFO has space */
 #define UARTDM_SR_TX_EMPTY       (1 << 3) /* Transmitter underrun */
+#define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
 
-#define UARTDM_CR                         0xA8 /* Command register */
+#define UARTDM_CR                         0x10 /* Command register */
 #define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
 #define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
 #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
 #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
+#define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
+#define UARTDM_CR_CMD_RESET_STALE_INT     (8 << 4) /* Clears stale irq */
+#define UARTDM_CR_CMD_RESET_TX_READY      (3 << 8) /* Clears TX Ready irq*/
+#define UARTDM_CR_CMD_FORCE_STALE         (4 << 8) /* Causes stale event */
+#define UARTDM_CR_CMD_STALE_EVENT_DISABLE (6 << 8) /* Disable stale event */
+
+#define UARTDM_IMR                0x14 /* Interrupt mask register */
+#define UARTDM_ISR                0x14 /* Interrupt status register */
+#define UARTDM_ISR_TX_READY       0x80 /* TX FIFO empty */
+
+#define MSM_UART_TF_RF		  0x70
 
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
@@ -59,27 +76,97 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct msm_serial_data {
 	phys_addr_t base;
+	u32 chars_cnt; /* number of buffered chars */
+	u32 chars_buf; /* buffered chars */
 	uint32_t clk_rate; /* core clock rate */
+	bool single_char;
 };
 
+static int msm_serial_fetch(struct udevice *dev)
+{
+	struct msm_serial_data *priv = dev_get_priv(dev);
+	u32 sr;
+
+	if (priv->chars_cnt)
+		return priv->chars_cnt;
+
+	/* Clear error in case of buffer overrun */
+	if (readl(priv->base + UARTDM_SR) & UARTDM_SR_UART_OVERRUN)
+		writel(UARTDM_CR_CMD_RESET_ERR, priv->base + UARTDM_CR);
+
+	/* We need to fetch new character */
+	sr = readl(priv->base + UARTDM_SR);
+
+	if (sr & UARTDM_SR_RX_READY) {
+		/* There are at least 4 bytes in fifo */
+		priv->chars_buf = readl(priv->base + MSM_UART_TF_RF);
+		priv->chars_cnt = 4;
+	} else {
+		/* Check if there is anything in fifo */
+		priv->chars_cnt = readl(priv->base + UARTDM_RXFS);
+		/* Extract number of characters in UART packing buffer*/
+		priv->chars_cnt = (priv->chars_cnt >>
+				   UARTDM_RXFS_BUF_SHIFT) &
+				  UARTDM_RXFS_BUF_MASK;
+		if (!priv->chars_cnt)
+			return 0;
+
+		/* There is at least one character, move it to fifo */
+		writel(UARTDM_CR_CMD_FORCE_STALE,
+		       priv->base + UARTDM_CR);
+
+		priv->chars_buf = readl(priv->base + MSM_UART_TF_RF);
+		writel(UARTDM_CR_CMD_RESET_STALE_INT,
+		       priv->base + UARTDM_CR);
+		writel(0x7, priv->base + UARTDM_DMRX);
+	}
+
+	return priv->chars_cnt;
+}
+
 static int msm_serial_getc(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	char c;
+
+	if (priv->single_char) {
+		if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
+			return -EAGAIN;
+
+		return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
+	}
 
-	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
+	if (!msm_serial_fetch(dev))
 		return -EAGAIN;
 
-	return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
+	c = priv->chars_buf & 0xFF;
+	priv->chars_buf >>= 8;
+	priv->chars_cnt--;
+
+	return c;
 }
 
 static int msm_serial_putc(struct udevice *dev, const char ch)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 
-	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+	if (priv->single_char) {
+		if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+			return -EAGAIN;
+
+		writel(ch, priv->base + UARTDM_TF);
+		return 0;
+	}
+
+	if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
+	    !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
 		return -EAGAIN;
 
-	writel(ch, priv->base + UARTDM_TF);
+	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
+
+	writel(1, priv->base + UARTDM_NCF_TX);
+	writel(ch, priv->base + MSM_UART_TF_RF);
+
 	return 0;
 }
 
@@ -87,10 +174,21 @@ static int msm_serial_pending(struct udevice *dev, bool input)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 
-	if (input)
-		return !!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY);
-	else
-		return !(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY);
+	if (priv->single_char) {
+		if (input)
+			return !!(readl(priv->base + UARTDM_SR) &
+				  UARTDM_SR_RX_READY);
+		else
+			return !(readl(priv->base + UARTDM_SR) &
+				 UARTDM_SR_TX_EMPTY);
+	}
+
+	if (input) {
+		if (msm_serial_fetch(dev))
+			return 1;
+	}
+
+	return 0;
 }
 
 static const struct dm_serial_ops msm_serial_ops = {
@@ -156,8 +254,12 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
 
-	/* Enable single character mode */
-	writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
+	if (priv->single_char)
+		/* Enable single character mode */
+		writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
+	else
+		/* Make sure BAM/single character mode is disabled */
+		writel(0x0, priv->base + UARTDM_DMEN);
 
 	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
@@ -200,6 +302,8 @@ static int msm_serial_of_to_plat(struct udevice *dev)
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	priv->single_char = device_is_compatible(dev, "qcom,msm-uartdm-v1.4");
+
 	ret = dev_read_u32(dev, "clock-frequency", &priv->clk_rate);
 	if (ret < 0) {
 		log_debug("No clock frequency specified, using default rate\n");
@@ -211,7 +315,7 @@ static int msm_serial_of_to_plat(struct udevice *dev)
 }
 
 static const struct udevice_id msm_serial_ids[] = {
-	{ .compatible = "qcom,msm-uartdm-v1.4" },
+	{ .compatible = "qcom,msm-uartdm" },
 	{ }
 };
 
@@ -254,10 +358,14 @@ static inline void _debug_uart_putc(int ch)
 {
 	struct msm_serial_data *priv = &init_serial_data;
 
-	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
+	       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
 		;
 
-	writel(ch, priv->base + UARTDM_TF);
+	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
+
+	writel(1, priv->base + UARTDM_NCF_TX);
+	writel(ch, priv->base + MSM_UART_TF_RF);
 }
 
 DEBUG_UART_FUNCS

-- 
2.54.0


