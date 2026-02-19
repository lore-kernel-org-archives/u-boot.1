Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3AE9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCCA83D0B;
	Thu, 19 Feb 2026 18:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FvjkqJIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8760C83D0B; Thu, 19 Feb 2026 18:52:16 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FBE983E21
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so11655905e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523534; x=1772128334;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=533B30VEdaP+E4Na1aeGiCFVM50K9If5sXJTZgVBYao=;
 b=FvjkqJIkaNNUSNoBGLk9g9JipXFLo5K8k6HqJsOOm+VcOIwFpVkRcSn34gk0+vrLTA
 SSeGTB2Q2xfE9beRFmPZMp/nprEUzmWBdVMOIUgZjv/y7HAxUDfR6SPk1alXduaQeLBU
 W+tAx12P9FiX4eTTzf0nxtMkwzPqRAPxUwxf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523534; x=1772128334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=533B30VEdaP+E4Na1aeGiCFVM50K9If5sXJTZgVBYao=;
 b=R0UfwRElmqewwHeHLTTlhNXlIT5fS51lxzVuVtYa9ThLqtuaELatbQzfz7r2PGsCnU
 NT9HgYhzbjKpoulhcEaWNp8p7YH4gydH6/igVDQZKBBt321tykt8eIqXlXmsODRKiEPa
 t/WCNZGoPzA07PF+IYdKJP28u8XzruJyLigAwL7M5iBp1hHqZeLkW15snpLQYVo8kNqM
 ZlIJj6QGYalQIKmQNY5UOGPe24Fo8i24yZ3xzBgLB0zn5/y5CJWdvhs7HbZPxtRoVvXy
 CwZ86gTcxUXY+3g4RU5vW6HdnRUrKXAll7tyV376rQNH4Zxh1LWGrk5nDoyslT6u1KZd
 wxJA==
X-Gm-Message-State: AOJu0Yzq0TkXujJPH5HJ034VSPevPW6YDzJZwv4QOWl4QgX63pJJCTMb
 j6lUir+Ztaxe7NChtfRoqzyZ8Fkeq+XOur+xh9uV6F6SYB+0BZHKV1qWFggFE2ahwPVgfAwpTHu
 xRYuB
X-Gm-Gg: AZuq6aL0imdHawHaW307TXIuoL2oKWS7luIbETalbmfoNQBQ+Ji4PKwklsiVIl9yCaa
 5cxsVGwHBrtCkGyV0SIhEbZAgFkcfJJQ/VeeLa9zy8RM+OPrxr8gny3zYm6TPIDumvD94U3oWYY
 ODBM04zliJdZh00H4Z5BWyXWeuejl6XvuvqsTMRh3du0SgtPzbP9MDTtlwqvZBqz22ZGrz7/dd7
 cQ8M3WcmF1Am2cM5eTpsP/G4ddya9D4N6s/m8tX5oTFiKzTen+JCgT3JySVDI4aE6j73JL6m0ha
 XLlCf5eXaAe7cbub6rjFKvdqV8mln9+/p0dBUDsK9xqUESE6hDsHpAWXY+3NqSKJ8JOLNx0GiVx
 mAD6ggFKKNGaYOIqDrBQV1DQSNFavJbBrmRfbS94L4EEF9TePu0izzzYjbWFWt1xAW2O/RGIhYl
 BQhfquJNKrj2pRwfZHz/qdn3IaEmFT+gkLzsfwTqQxPByTJGDj5KvBbWwnnUTxxG7zOKhj+myT9
 QQ+JmNzpfUlaUFUCiBHQ6g4SFxMdPcNkTnDR06ESTxY1HmJEuitYXRppPTJCHe9a5LQHRvg8YHC
 UxIXvZgT8zV8CItkKwQ/xWFy
X-Received: by 2002:a05:600c:6990:b0:483:8f38:a928 with SMTP id
 5b1f17b1804b1-4838f38a961mr158805545e9.34.1771523533689; 
 Thu, 19 Feb 2026 09:52:13 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:52:13 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 6/8] spi: stm32: add support for bits-per-word setting
Date: Thu, 19 Feb 2026 18:51:17 +0100
Message-ID: <20260219175130.2839234-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

