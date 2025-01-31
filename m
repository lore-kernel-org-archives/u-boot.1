Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E2C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 02:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB0E80F67;
	Fri, 31 Jan 2025 03:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mj/IhGYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FF980F4C; Fri, 31 Jan 2025 02:39:13 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC95F80A46
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2163b0c09afso24840125ad.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738287549; x=1738892349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9XtoczfTX4pwDdNNFUKjRCNnkBW9tqjDlPWxhuy/Io=;
 b=mj/IhGYYbYAThWINntyjsdXLcfl5cWMkMinmNEsGT7jukYx6e+8RohoBCpySBXrs1d
 6ZYDdTxP+DcX2MxDbPDOMRxeAXDkwaFLwTzfLDGL4bRdz2doswMXWSo860l1WFta8I4y
 AAZ3thSfIq/7Y4R1bMeVJty5yBodnGEWzIkHJCJOIcEcbwAFmXP4OPRWhNFKMyG2vxuK
 SlPPRUw9zNDtfZrf5lQGyJaP9mlqanDjtwyYC9l2W0J10dnWFe4oghntxV7abVgALE0n
 kmhjqcjXgmRZAIRGcaVbGh8pEQu/bLkwr5R6pLA5pG6POI7jZUdGkaf891IYWMiEQ9tD
 qeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738287549; x=1738892349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9XtoczfTX4pwDdNNFUKjRCNnkBW9tqjDlPWxhuy/Io=;
 b=ZQgef8uUbxYIGPCi5p6N/ObhewlvAERI0DXb6ViGTDF1jigpu+pEnAmnj4uHpxy2Xs
 LaszuOSMV3pSCf/FEXkwg0GoK2rkGIs8Q8fdfWGgCABCNWUGEFDkgtMfYCwHQ4xt1T6Q
 9kY0hghnzjZGHq99N53GgDrjUnymcMkN+1QgsC2Twn98gJmKXCJ2cLad96ENLbcdlXjy
 ZBOz+B8DHVvLk2aVkwE61RwyQesXu/rkCAgfQJHLaGA+sEsHasaSq+vVT7ZeHQRMB2qr
 aWCl9PETTv20tlUr38A+fcnWZ3giTJX3G3HRBfaXXzOCuG7X6Nvqt6MnhVFSILAPoXiW
 maVA==
X-Gm-Message-State: AOJu0YwlAAbLxa3EidoaSOkRmSlj5A/bAvY/0PVslnuWE2CteQnzOtG+
 tijSdPew7ArC3//EDVdrfAyOK+iyg5bm+0OqSx4CET3fFodGK7YT/BFnV7mz
X-Gm-Gg: ASbGncumy5zsHNmPq6M6ZbgkYogKVYzFmo8oPGc82ut8OaYnRSs/W1IUrXr7vtt13JL
 NS1cXbIn8kW2puR4wzuxa3xeGVEaargACZbNMs0fMJyPbuoiG1N8AsDBFbNeA1Zki1ZFP8JqIji
 vrk5DVttX6alzKBXkKK8/vpqiGVEN3rvWOgffhqw8DDoLcP9KWZAvc4f9Qbps+ndCeaLUYlazGZ
 oH9a8Rn1V0CDfg/5AQprxvX7a0bV1SUjiauS/aTeJCv0CI53h6b7rjCUSiHOoNQiGzM7qsq0mLX
 0DszLYXkgIJdJEuiCom1Qye4/hk=
X-Google-Smtp-Source: AGHT+IF2jLuYxoZ3uE6XU+Iqj9s+N+evcTZ7wSTdBreb7crcLnAqC8dBcoErdx2meTgjZlyqwut88g==
X-Received: by 2002:a17:902:e54e:b0:215:b5c6:9ee8 with SMTP id
 d9443c01a7336-21dd7c4628amr143154345ad.7.1738287549084; 
 Thu, 30 Jan 2025 17:39:09 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de31ee01bsm20081385ad.47.2025.01.30.17.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 17:39:08 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: u-boot@lists.denx.de
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Software Engineering <wd@denx.de>
Subject: [PATCH v2 1/1] spi: soft_spi: Add support for SPI_3WIRE
Date: Fri, 31 Jan 2025 10:38:41 +0900
Message-ID: <20250131013843.3844148-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131013843.3844148-1-kikuchan98@gmail.com>
References: <20250131013843.3844148-1-kikuchan98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jan 2025 03:40:28 +0100
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

When 3-wire mode is claimed on the bus, use the MOSI (output) pin to
receive data. In this mode, since the transfer can only be either TX
or RX, return -EINVAL if both are required at the same time.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/spi/soft_spi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index a8ec2f4f7b..50bd7be564 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -124,8 +124,19 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	u8		*rxd = din;
 	int		cpha = !!(priv->mode & SPI_CPHA);
 	int		cidle = !!(priv->mode & SPI_CPOL);
+	int		txrx = plat->flags;
 	unsigned int	j;
 
+	if (priv->mode & SPI_3WIRE) {
+		if (txd && rxd)
+			return -EINVAL;
+
+		txrx = txd ? SPI_MASTER_NO_RX : SPI_MASTER_NO_TX;
+		dm_gpio_set_dir_flags(&plat->mosi,
+				      txd ? GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE :
+					    GPIOD_IS_IN | GPIOD_PULL_UP);
+	}
+
 	debug("spi_xfer: slave %s:%s dout %08X din %08X bitlen %u\n",
 	      dev->parent->name, dev->name, *(uint *)txd, *(uint *)rxd,
 	      bitlen);
@@ -160,7 +171,7 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		 */
 		if (cpha)
 			soft_spi_scl(dev, !cidle);
-		if ((plat->flags & SPI_MASTER_NO_TX) == 0)
+		if ((txrx & SPI_MASTER_NO_TX) == 0)
 			soft_spi_sda(dev, !!(tmpdout & 0x80));
 		udelay(plat->spi_delay_us);
 
@@ -174,8 +185,10 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		else
 			soft_spi_scl(dev, cidle);
 		tmpdin	<<= 1;
-		if ((plat->flags & SPI_MASTER_NO_RX) == 0)
-			tmpdin	|= dm_gpio_get_value(&plat->miso);
+		if ((txrx & SPI_MASTER_NO_RX) == 0)
+			tmpdin |= dm_gpio_get_value((priv->mode & SPI_3WIRE) ?
+							    &plat->mosi :
+							    &plat->miso);
 		tmpdout	<<= 1;
 		udelay(plat->spi_delay_us);
 
-- 
2.48.1

