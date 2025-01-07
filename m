Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF439E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A528060A;
	Tue,  7 Jan 2025 14:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GY/+PxFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1368801C3; Tue,  7 Jan 2025 10:26:13 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65595801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so22718338a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736241970; x=1736846770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIc0EoGDGCchV4vL6lrP8ajdSdbiishZgFFhvI5FnYI=;
 b=GY/+PxFcrYTUWKs+9g3pVmDwMqJ341BxLB1ZEJSUzgwFCp5b2YRWi60W/Wrut5QoYY
 W/BetG19rXK7Q2xoBDgpxTTLsMwJ3Gr5Tf6cXYohz5YILuUwrqA2/Lzcw2Ny8PtEptDI
 4V1J2Pv6WTom4vRndofRYbM8JJAlKUV3QR7GXxb0WSlwg3r86t4PIw4OadYWfHCj0SFa
 oFs+QEhc0vRvwL+uLqbYfRQtSl+nBrh6LgMfW1U/2HlBrXAqnqbRBov96xDV+eFuQNIW
 YB7FqZ7n9ZWzUoA/4WkkaizYV+czeTcgXrZFKFyGiFUFCq9hBsHn1sEtJ+L4Uu+7CSUw
 OYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241970; x=1736846770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIc0EoGDGCchV4vL6lrP8ajdSdbiishZgFFhvI5FnYI=;
 b=W6kfc7Rtum1p72chUHOOL4UY2mHT1EpHV++m1eL8Cpe+0K5pjd9jaT0SQnYHzQw5WF
 f9JfecN70FjWqsx5blvN1aHvW31+d4rRjgzHqSdRBG2B8Jt0Wj52Gac/TxaJSTOtEXws
 J4Hnc+7nGLxtUiWgoJcQpLpuvMQbc8Tg3+pS7Oz7TVfgIOFBTUGYW43i+A5eG2Nb6Mby
 W+fzkpMObsTmmy1X1wJhIDKlFx/nBrxlrVwyiuWPcBUivQft7mngnRM4bMG2DaMap4hJ
 6xIuUvU0N/1qSgmMfJi6v1D3JJG2Fx6phJh5D4bzNyjhYneSTNHJSFMC1XZ8r/FtOehU
 hbqw==
X-Gm-Message-State: AOJu0Yz01Ub+VS4XcCZN0GX/NyMQHxUTcdo1CRKiYVrwtNBkf0m5fF9X
 6NQkfkeUYww6f/X4VjzO78WtZ35RWHNl8Q+VIMfnx3mMLvTHagRxTp/WCbJw
X-Gm-Gg: ASbGncuUJqfiBS1CNChgWwmTlVOYiqCRHLjLGhylS/8K+7/wAADTYhQ+r7dlQ3dlTj6
 tZw6rxQPBVKVMjWQ69ZgqUHpHOk4w3OUTmS85hYiqIZhgH3kLDhzrmWLT+omi+lgx94aJPmH0iv
 tzNSwxICcovNaqQS1VhGVhTn2qXmNCLWjlqDD6p7rhvTsnAW71EJ0JnGo6Azmb2Cev7ErQrD7jm
 0sdRKa8I0QgRnosKX8YiQODmecDWYFgoobkCJdxMbtrapj3I1dWMc6XHTqKLdC6+A6o0KE=
X-Google-Smtp-Source: AGHT+IEliEl5UZZTSClFh5f47xIcpZ1kW58Fs6lUz8l8UTS8yy9yxazjXvjXOAf+9nKtiyvOwAnCcA==
X-Received: by 2002:a05:6a00:1c8c:b0:72a:9ab2:4d90 with SMTP id
 d2e1a72fcca58-72abdf1034fmr79386867b3a.26.1736241969756; 
 Tue, 07 Jan 2025 01:26:09 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb09sm33806352b3a.121.2025.01.07.01.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:26:09 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: u-boot@lists.denx.de
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Custom IDEAS <vanbaren@cideas.com>, Software Engineering <wd@denx.de>
Subject: [PATCH 2/2] spi: soft_spi: Add support for SPI_3WIRE
Date: Tue,  7 Jan 2025 18:25:40 +0900
Message-ID: <20250107092544.1798497-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107092544.1798497-1-kikuchan98@gmail.com>
References: <20250107092544.1798497-1-kikuchan98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jan 2025 14:15:02 +0100
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
index a8ec2f4f7b..ae444dad8a 100644
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
+					    GPIOD_IS_IN);
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
2.47.1

