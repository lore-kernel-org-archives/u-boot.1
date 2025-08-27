Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EDDCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 12:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084E383192;
	Wed, 27 Aug 2025 14:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xy40S6Fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84462831BB; Wed, 27 Aug 2025 14:24:27 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591BB8307F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 14:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ef2efc0341so13884365ab.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756297464; x=1756902264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gPR1USmVIKdXedPpLlSbbJqbUst7MYtFjvmhPABKXoY=;
 b=Xy40S6FypRTrv/aCNmfrWQhrw3K3FL8E4F0lhq4oYSOonp+55tSbIMNWhXzZwkTvHC
 Y5eCSx6TTIPoES82a1XFC4czMWYbh3x/Jx3EVMB1UZxHXAdHgtJVKmcQJSjrXBZ48T/6
 Gxz64AtF3U2Z2FPaVVo8Hms342vlGWSRdOOJq4enp84bKxgjyMepkAPbfZz8gtV+15+u
 IqKWpYqaZhihcLTtzuHm7t7hKVJRytFSL0SvKU5sczNzl8DClEQS+eLsDW1pW6xCnr9v
 EV03f3tBuLEl+vO5+nUKnzwnPP8KEyGsO51BXbhETZSsaLJ3uD88WPfVnLM3sWIEG4e6
 1XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756297464; x=1756902264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gPR1USmVIKdXedPpLlSbbJqbUst7MYtFjvmhPABKXoY=;
 b=dDOepqh+NjTKT4ZJ0IGjd0g55Y3/kGCDMvoyplgpSilI8GT5MM10BUu9g+yAvZIVuq
 H7d6ndnmmq9KKIXMSufIefcFYanr42ZvzmggGGWp4ukAHZn+utT1vdR/z6Ju/lbJPOEm
 fkfKOEOIe1diSZHK2yw2b752f8LSWRh6ynNcuOF8ETh4zk7B1SFlIXh/jnFCswQyVIb5
 rIrBPwytCBCV98cRn88k0/33Ths9aTwiskuDKSdfBR9b3vjkUy4EIG9XvwUgq26WWVUN
 +WRFQMwsEMX/wT+ydJQrIF5HVAefMpzns99IKsL3h8zKLLuAxmN4hP9MS1X1eykeBWmZ
 ne5w==
X-Gm-Message-State: AOJu0YydyH3nZuIIpaNZ/p5/KoVFz10At1s3oww/2AcAaxyRnTk05EAi
 gCzIpcpODIqatNxurXAaHDbwDPp5JzYbwEZo41cSu1x020U8qSjBqedbAY4l+SlWMjk=
X-Gm-Gg: ASbGncsg5pm2qL4drkNYOHQiLjv7IL07rC7TGK6HJagoVfg1Vt8Vf3vTvZ7lQiH6axN
 57Kz4zVLI1nzDAVkJG0vIzR+vdKfz7oFEKfpnIhC0oONe5n9C+fl115ZGk4CNrjlXz8vJIpbV1S
 /okx08RkWhQp9oPy2q4A4ByZNq0lW80+ffgJJGvk7SvxiHGw+ka8aBpFTZv/cpRyAQdmiQtUDZF
 tk+MtodqHTM3zm2ZAbWhOMplPo1N6KwmstgCn5p3ze5M/IBjB4akHLVRojyiW1eyeH62TBUwJqQ
 sKPcYNcLd6dbbMPj19d4GztyDk19uRPgVXfxYoZavbkdUuNx7mMtiuO7rvsTIYIazAvgyAbbC6r
 O73mi3cnLv5Zxp1+mnQKou8WGWhneXaAMDzNeOmCdol4=
X-Google-Smtp-Source: AGHT+IGjK4WosvFhaP+oSP108iE5QuYWFN8DVU0XSrY6pcMiEDJDp16L+Lk2vJno/jivylYS0THuew==
X-Received: by 2002:a05:6e02:16c5:b0:3e5:5357:6de7 with SMTP id
 e9e14a558f8ab-3e91fc22397mr110675695ab.4.1756297463588; 
 Wed, 27 Aug 2025 05:24:23 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([104.168.88.190])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3efde58fab3sm14451415ab.44.2025.08.27.05.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 05:24:23 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add support for Dosilicon DS25Q4CB/DS25Q4DN
Date: Wed, 27 Aug 2025 20:24:03 +0800
Message-Id: <20250827122403.20159-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add support for DS25Q4CB and DS25Q4DN

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/Kconfig       | 5 +++++
 drivers/mtd/spi/spi-nor-ids.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index ca60a425ba3..f32a7b015cb 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -228,6 +228,11 @@ config SPI_FLASH_XMC
 	  Add support for various XMC (Wuhan Xinxin Semiconductor
 	  Manufacturing Corp.) SPI flash chips (XM25xxx)
 
+config SPI_FLASH_DOSILICON
+	bool "Dosilocon SPI flash support"
+	help
+	  Add support for various Dosilocon SPI flash chips (DS25xxx)
+
 config SPI_FLASH_XTX
 	bool "XTX SPI flash support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0383175beb5..c6348d60f89 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -648,6 +648,13 @@ const struct flash_info spi_nor_ids[] = {
 	/* Zbit Semiconductor Inc. */
 	{ INFO("zb25vq128", 0x5e4018, 0, 64 * 1024, 256,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+#endif
+#ifdef CONFIG_SPI_FLASH_DOSILICON
+	/* Dosilicon Co., Ltd*/
+	{ INFO("DS25Q4CB", 0xe5301a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ |
+	       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("DS25Q4DN", 0xe5301b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ |
+           SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 	{ },
 };
-- 
2.34.1

