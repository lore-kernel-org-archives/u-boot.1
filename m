Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5BAFD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF07D84137;
	Wed, 25 Feb 2026 17:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZjvMfSe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053508405F; Wed, 25 Feb 2026 17:22:39 +0100 (CET)
Received: from mail-wm1-x335.google.com (unknown [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1028410B
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so52869255e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036347; x=1772641147;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaPhWKiMQvyXcHp7drHPqMWTp28rxSNAljsxQHzSH14=;
 b=ZjvMfSe0bc2hsZkU174Hk50+tyd0aIIWSlDg0vCsSjr+AhaX7vYQ5YjSoRbMOGmXSk
 sey7nFe6XaRaw68Yp/ODR2qpoZ+5oBrJnDBHcb6DDdiw2MztPcFLwE6XPtq9JnG1PBsS
 92EI3qEC8l2IQ4PXJ+RUKtXtxBRUQHtZhF/DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036347; x=1772641147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FaPhWKiMQvyXcHp7drHPqMWTp28rxSNAljsxQHzSH14=;
 b=eM+7mUhIwYnmSuQGadtkw9QLbOn+JpXZIMpahZlVSoSwIHygBRx+AeEp83nSdlRhx6
 s0SPpJTA0tXvM9oymQxvHFaGnMAF7eSXXjrcGtlHd3Q/NKertoeVqg410Ee5QgxjmSJu
 uzcD9IXSbDfNyiftR2ZH1ML3YU+KCoL3r5yhsSO0fUYUqBfnmoywnDGDtRncm9R2P/aF
 I/m35wgIk5l4UesDDTX/6JC8RZG/GeO6amrXxwWU+WCB1H4mC01z3asBvXO8smdKFx/p
 1bNrMJPd880ANX+w+FZpp/OK4Zeg+MCIRc6yw87V7lDZDu1Ysq9USuHNTqjT2le/AaEh
 ghiA==
X-Gm-Message-State: AOJu0YyS+Q37Dfj75/Uk+ixJITmvHe0iY3ZgNp3w+6JxUGKmqNBdK7mO
 VAwsub0i4h11d54N2B2XURUjbuReIchaM2s5wY6cM+Ehw0rz9UyuOQT+shcFY0KPrF88BqDqu5l
 PdMON
X-Gm-Gg: ATEYQzww1FXTf/nwR1vCz8citW6VH5p38h67Luq7AcIwx2FskfjuWYxbeLeDe2PvwX5
 ALw0XRPBk80D/hL0x7fWth0pnh1L3a+l5xSl4cOCl8QdxLJ78Sl1AEL8/uXKZXOx3SmPKk8rgGa
 VNeVi5hqklf7mjThHurpr+slDjgQHMJE97izoM1BpTyP0MHlgYcukefafO0UO4uTkfot5IVG3lY
 DfQ6ryas31/6NvVLZvu9crKBSZwKn4RZ/QiJrh2AeRQJnMU61Eu+qEdb8+nkztL4x6xMdoogKp3
 oLeO9HJN6gBDoA86YVrKP/1+wL1VyikrlzjbMlAaTQ2tlMDVJqEl13Lh8dB/vdH9BNInjmPeCJS
 6r3nL4FL46svI2ZpKwwTiowxFhGCxSdrRdXyToS337W/Ez2O+hMnS36b9nuUmeGLm+1FoSMQ6I2
 LkkPLMDrHJcp9mp0FMpcZ89sMd0gGuktAOK2Cw7D1LPlol1n4jNEkU1NhFriBRL9MNe/lsU+LC8
 6qhif6hk9fPnv02w+ashURFa6zqtWSf5WqdzW9Q7Cvo5kkM
X-Received: by 2002:a05:600c:3151:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-483c21aab65mr13522945e9.28.1772036346832; 
 Wed, 25 Feb 2026 08:19:06 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:06 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 7/9] spi: stm32: add support for bits-per-word setting
Date: Wed, 25 Feb 2026 17:16:58 +0100
Message-ID: <20260225161851.2475274-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Move the stm32_spi_is_enabled() implementation in the previous patch

 drivers/spi/stm32_spi.c | 57 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 70eb8735e03d..9d095b280a70 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -384,6 +384,44 @@ static int stm32_spi_set_speed(struct udevice *bus, uint hz)
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
@@ -397,11 +435,19 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
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
 
@@ -409,6 +455,8 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	priv->rx_buf = din;
 	priv->tx_len = priv->tx_buf ? xferlen : 0;
 	priv->rx_len = priv->rx_buf ? xferlen : 0;
+	dev_dbg(bus, "bitlen: %d, xferlen: %d, nb_words: %d\n",
+		bitlen, xferlen, nb_words);
 
 	mode = SPI_FULL_DUPLEX;
 	if (!priv->tx_buf)
@@ -570,9 +618,7 @@ static int stm32_spi_probe(struct udevice *dev)
 	priv->fifo_size = stm32_spi_get_fifo_size(dev);
 	priv->cur_mode = SPI_FULL_DUPLEX;
 	priv->cur_xferlen = 0;
-	priv->cur_bpw = SPI_DEFAULT_WORDLEN;
-	clrsetbits_le32(base + STM32_SPI_CFG1, SPI_CFG1_DSIZE,
-			priv->cur_bpw - 1);
+	_stm32_spi_set_wordlen(dev, SPI_DEFAULT_WORDLEN);
 
 	for (i = 0; i < ARRAY_SIZE(plat->cs_gpios); i++) {
 		if (!dm_gpio_is_valid(&plat->cs_gpios[i]))
@@ -633,6 +679,7 @@ static const struct dm_spi_ops stm32_spi_ops = {
 	.release_bus	= stm32_spi_release_bus,
 	.set_mode	= stm32_spi_set_mode,
 	.set_speed	= stm32_spi_set_speed,
+	.set_wordlen    = stm32_spi_set_wordlen,
 	.xfer		= stm32_spi_xfer,
 };
 
-- 
2.43.0

