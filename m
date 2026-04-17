Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B97F8E49E
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545868421D;
	Fri, 17 Apr 2026 04:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB608423E; Fri, 17 Apr 2026 04:21:34 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA448421D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2LAtO015784;
 Fri, 17 Apr 2026 10:21:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:21:10 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>, CL Chin-Long Wang
 <cl634@andestech.com>
Subject: [PATCH 2/8] spi: atcspi200: Improve clock configuration and divider
 logic
Date: Fri, 17 Apr 2026 10:20:58 +0800
Message-ID: <20260417022104.3973576-3-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417022104.3973576-1-ycliang@andestech.com>
References: <20260417022104.3973576-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2LAtO015784
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

- Add default clock source (100 MHz) and max frequency (40 MHz)
  fallbacks when DT properties are missing
- Read spi-max-frequency from DT to cap the operating frequency
- Use improved round-up divider formula that selects the closest
  available frequency not exceeding the target
- Add SCLK_DIV_BYPASS (0xFF) and SCLK_DIV_MAX (0xFE) constants
- Remove mtiming field and timing restore in stop(), which was
  incorrectly resetting clock settings after every transfer
- Change clock fields from ulong to unsigned int

Signed-off-by: CL Chin-Long Wang <cl634@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/spi/atcspi200_spi.c | 57 +++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 8cae96ee23c..33cf7583581 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -18,6 +18,8 @@
 #define MAX_TRANSFER_LEN	512
 #define CHUNK_SIZE		1
 #define SPI_TIMEOUT		0x100000
+#define SPI_DEF_SRC_CLK		100000000
+#define SPI_DEF_MAX_CLK		40000000
 
 /* Register offsets */
 #define ATCSPI200_REG_FORMAT	0x10
@@ -61,15 +63,17 @@
 
 /* TIMING register fields */
 #define SCLK_DIV_MASK		GENMASK(7, 0)
+#define SCLK_DIV_BYPASS		0xFF
+#define SCLK_DIV_MAX		0xFE
 
 struct atcspi200_priv {
 	void		*regs;
 	int		to;
 	unsigned int	freq;
-	ulong		clock;
+	unsigned int	src_clk;
+	unsigned int	max_clk;
 	unsigned int	mode;
 	u8		num_cs;
-	unsigned int	mtiming;
 	size_t		cmd_len;
 	u8		cmd_buf[16];
 	size_t		data_len;
@@ -93,22 +97,28 @@ static inline void atcspi200_write(struct atcspi200_priv *priv, u32 offset,
 static int atcspi200_hw_set_speed(struct atcspi200_priv *priv)
 {
 	u32 tm;
-	u8 div;
+	u32 div;
+	u32 spi_sclk;
 
-	tm = atcspi200_read(priv, ATCSPI200_REG_TIMING);
-	tm &= ~SCLK_DIV_MASK;
+	tm = atcspi200_read(priv, ATCSPI200_REG_TIMING) & ~SCLK_DIV_MASK;
 
-	if (priv->freq >= priv->clock) {
-		div = 0xff;
+	spi_sclk = min(priv->freq, priv->max_clk);
+
+	/*
+	 * SCLK_DIV = 0xFF bypasses the divider, giving SCLK = src_clk.
+	 * Otherwise SCLK = src_clk / (2 * (SCLK_DIV + 1)).
+	 */
+	if (spi_sclk >= priv->src_clk) {
+		div = SCLK_DIV_BYPASS;
 	} else {
-		for (div = 0; div < 0xff; div++) {
-			if (priv->freq >= priv->clock / (2 * (div + 1)))
-				break;
+		div = DIV_ROUND_UP(priv->src_clk, spi_sclk * 2) - 1;
+		if (div > SCLK_DIV_MAX) {
+			pr_err("Unsupported SPI clock %u\n", spi_sclk);
+			return -EINVAL;
 		}
 	}
 
-	tm |= div;
-	atcspi200_write(priv, ATCSPI200_REG_TIMING, tm);
+	atcspi200_write(priv, ATCSPI200_REG_TIMING, tm | div);
 
 	return 0;
 }
@@ -166,7 +176,6 @@ static int atcspi200_hw_start(struct atcspi200_priv *priv)
 
 static int atcspi200_hw_stop(struct atcspi200_priv *priv)
 {
-	atcspi200_write(priv, ATCSPI200_REG_TIMING, priv->mtiming);
 	while ((atcspi200_read(priv, ATCSPI200_REG_STATUS) & SPIBSY) &&
 	       priv->to--)
 		if (!priv->to)
@@ -353,14 +362,21 @@ static int atcspi200_spi_get_clk(struct udevice *bus)
 	int ret;
 
 	ret = clk_get_by_index(bus, 0, &clk);
-	if (ret)
-		return -EINVAL;
-
-	clk_rate = clk_get_rate(&clk);
-	if (!clk_rate)
-		return -EINVAL;
+	if (ret) {
+		dev_warn(bus, "no clock node, using default %d Hz\n",
+			 SPI_DEF_SRC_CLK);
+		priv->src_clk = SPI_DEF_SRC_CLK;
+	} else {
+		clk_rate = clk_get_rate(&clk);
+		if (!clk_rate) {
+			dev_err(bus, "invalid clock rate\n");
+			return -EINVAL;
+		}
+		priv->src_clk = clk_rate;
+	}
 
-	priv->clock = clk_rate;
+	priv->max_clk = dev_read_u32_default(bus, "spi-max-frequency",
+					      SPI_DEF_MAX_CLK);
 
 	return 0;
 }
@@ -371,7 +387,6 @@ static int atcspi200_spi_probe(struct udevice *bus)
 
 	priv->to = SPI_TIMEOUT;
 	priv->max_transfer_length = MAX_TRANSFER_LEN;
-	priv->mtiming = atcspi200_read(priv, ATCSPI200_REG_TIMING);
 	atcspi200_spi_get_clk(bus);
 
 	return 0;
-- 
2.34.1

