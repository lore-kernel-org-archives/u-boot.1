Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2745FC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFDB83936;
	Sat, 21 Feb 2026 10:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CPVVvVwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC8183E36; Sat, 21 Feb 2026 10:43:09 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B3983E61
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48371119eacso28814135e9.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666987; x=1772271787;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVJjtEbwe5nCMncteEhAFW8OsYXtxdYRfirYYIp13Nc=;
 b=CPVVvVwVOtcIJr5br+mw5XPHXteyel8v7GQMg1xZKNmLCxpz20zD/UqJRSoNzTtvqc
 hCNPE5b40Hmamb8Z0KgpdWt+lRNI4jmnw6P9jArI0OPd+v98z8xs2nopFqcsICWlYk/T
 +b/Esil0wobIalrpgB88nmk7KEgsV9yt/2dVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666987; x=1772271787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVJjtEbwe5nCMncteEhAFW8OsYXtxdYRfirYYIp13Nc=;
 b=YJ9DYUmICCJDQTBH7ewlUbt19fdpE4KnlPJK99P9ha2arnLouroim64/Nbi5NaCCmD
 1MD+1o9oOzEpL9mDonQMsSOX/ya294CEYDmHZcDXNcWrpM/YgYb2TIxxmxaUmWTUu3Oi
 zHVhZpZMlvmv6eWC1ZCocwuAZMl60OOEgVnY11kBaVReswELUY6ESB9f7W/uLyfyi6at
 H7VGs8/aByE6Kp5eZKwYscnfXsLFTmXIJVtslH9+ZgnXu4ef/m0B6g697mPNTgzZC9nX
 dhPbxBA5MuW6dqSGtTi3uOiVhvwAK6nSEQOyAlaJfyyYa+2383+1CtmLnY1ooRMQJXZF
 dRgA==
X-Gm-Message-State: AOJu0Yzo0aCdkoLWx1aJTrnk/Folwj4AhpBCL7kzXyc86XS6Bc7dFF5D
 Jr6rIUMLu6PKOE0R20YTa3e+WIay6fwH4IOgZ2k+nHMxoe+5NXJq0yCYUqPA4g4lghDwQYE+jdG
 jRXhP
X-Gm-Gg: AZuq6aJkgkz+xeJOKL1A0gBEygLPoawTrZZtKlIk8jIsEQ4PTlj1RVFa77hNDp5JwRu
 P2Rp0CcRLUEStil+q7byOGoLk2AP6wLhaJP088eT/KuouGQ4G+LHxLBsEKKWPStUdXr1+xjVdHn
 8Oj+op9k1aFb7DeEnhc5bcUL9cC8fMAwIF+CffyX2T+r5V+gwegc5Cx/PvHFV+vA0Pyd4UJaQgh
 jgf10L/8S8lZ9ngI34pfGCdqF38PmE8bA6NeDQNOKrAQxMxl/30HF3JxKzHfBoQjLHQOYt7MUpi
 T/OCghrqmL6VUx22/TcXf8fo6auTc9I0/YQEHp3aq6ObnNvQnBJXzl2gw6DqQ0PfXZXqcj1EQx9
 g4oPqSK3UnLiPJMc+cuepS4THX5vUE8fo2k9Xvb84O608AI/QdfWAkUZV2RE3wfCN9ukBJU6pzt
 2HoLNafpPlPLE6VQq0kh1KQEuJ9eDBUdYybQioowmi2wcZuQgUVICLla1nBzXsbkWfFcBETK3b0
 WCSJxS4Y6XgtwNKf/ZFSBNhk3uryuUUTycaa7rt4JLF35bWJ9iWFpoZvy/EOJacKllquQNEd4aH
 PzNURRiWLX3vcdsvK11T8CGF
X-Received: by 2002:a05:600c:3553:b0:480:6910:abd1 with SMTP id
 5b1f17b1804b1-483a962e49dmr44613365e9.18.1771666986738; 
 Sat, 21 Feb 2026 01:43:06 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:43:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 6/8] spi: stm32: add support for bits-per-word setting
Date: Sat, 21 Feb 2026 10:42:20 +0100
Message-ID: <20260221094252.3103034-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Implement the set_wordlen operation to allow dynamic bus width
configuration. This is required for peripherals with non-standard
requirements, such as display panels that need 9-bit word transfers
during the initialization and setup phase.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/spi/stm32_spi.c | 62 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index adba97915cd3..39ea69c68174 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -192,6 +192,11 @@ static void stm32_spi_read_rxfifo(struct udevice *bus)
 	log_debug("%d bytes left\n", priv->rx_len);
 }
 
+static bool stm32_spi_is_enabled(void __iomem *base)
+{
+	return !!(readl(base + STM32_SPI_CR1) & SPI_CR1_SPE);
+}
+
 static int stm32_spi_enable(void __iomem *base)
 {
 	log_debug("\n");
@@ -381,6 +386,44 @@ static int stm32_spi_set_speed(struct udevice *bus, uint hz)
 	return 0;
 }
 
+static int _stm32_spi_set_wordlen(struct udevice *bus, unsigned int wordlen)
+{
+	struct stm32_spi_priv *priv = dev_get_priv(bus);
+	struct stm32_spi_plat *plat = dev_get_plat(bus);
+	void __iomem *base = plat->base;
+	bool spi_enabled;
+
+	if ((wordlen - 1) < SPI_CFG1_DSIZE_MIN ||
+	    (wordlen - 1) > SPI_CFG1_DSIZE) {
+		dev_err(bus, "Cannot set wordlen to %u [%d - %d]\n",
+			wordlen, SPI_CFG1_DSIZE_MIN + 1,
+			SPI_CFG1_DSIZE + 1);
+		return -EINVAL;
+	}
+
+	spi_enabled = stm32_spi_is_enabled(plat->base);
+	if (spi_enabled)
+		stm32_spi_disable(plat->base);
+
+	dev_dbg(bus, "bits_per_word=%d\n", wordlen);
+
+	priv->cur_bpw = wordlen;
+	clrsetbits_le32(base + STM32_SPI_CFG1, SPI_CFG1_DSIZE,
+			priv->cur_bpw - 1);
+
+	if (spi_enabled)
+		stm32_spi_enable(plat->base);
+
+	return 0;
+}
+
+static int stm32_spi_set_wordlen(struct udevice *slave, unsigned int wordlen)
+{
+	struct udevice *bus = dev_get_parent(slave);
+
+	return _stm32_spi_set_wordlen(bus, wordlen);
+}
+
 static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			  const void *dout, void *din, unsigned long flags)
 {
@@ -394,11 +437,19 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	u32 xferlen;
 	u32 mode;
 	int xfer_status = 0;
+	int nb_words;
 
 	xferlen = bitlen / 8;
 
-	if (xferlen <= SPI_CR2_TSIZE)
-		writel(xferlen, base + STM32_SPI_CR2);
+	if (priv->cur_bpw <= 8)
+		nb_words = xferlen;
+	else if (priv->cur_bpw <= 16)
+		nb_words = DIV_ROUND_UP(xferlen * 8, 16);
+	else
+		nb_words = DIV_ROUND_UP(xferlen * 8, 32);
+
+	if (nb_words <= SPI_CR2_TSIZE)
+		writel(nb_words, base + STM32_SPI_CR2);
 	else
 		return -EMSGSIZE;
 
@@ -406,6 +457,8 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	priv->rx_buf = din;
 	priv->tx_len = priv->tx_buf ? xferlen : 0;
 	priv->rx_len = priv->rx_buf ? xferlen : 0;
+	dev_dbg(bus, "bitlen: %d, xferlen: %d, nb_words: %d\n",
+		bitlen, xferlen, nb_words);
 
 	mode = SPI_FULL_DUPLEX;
 	if (!priv->tx_buf)
@@ -567,9 +620,7 @@ static int stm32_spi_probe(struct udevice *dev)
 	priv->fifo_size = stm32_spi_get_fifo_size(dev);
 	priv->cur_mode = SPI_FULL_DUPLEX;
 	priv->cur_xferlen = 0;
-	priv->cur_bpw = SPI_DEFAULT_WORDLEN;
-	clrsetbits_le32(base + STM32_SPI_CFG1, SPI_CFG1_DSIZE,
-			priv->cur_bpw - 1);
+	_stm32_spi_set_wordlen(dev, SPI_DEFAULT_WORDLEN);
 
 	for (i = 0; i < ARRAY_SIZE(plat->cs_gpios); i++) {
 		if (!dm_gpio_is_valid(&plat->cs_gpios[i]))
@@ -630,6 +681,7 @@ static const struct dm_spi_ops stm32_spi_ops = {
 	.release_bus	= stm32_spi_release_bus,
 	.set_mode	= stm32_spi_set_mode,
 	.set_speed	= stm32_spi_set_speed,
+	.set_wordlen    = stm32_spi_set_wordlen,
 	.xfer		= stm32_spi_xfer,
 };
 
-- 
2.43.0

