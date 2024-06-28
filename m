Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15268C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 23:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41152882EF;
	Sat, 29 Jun 2024 01:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="fkHWVJb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C50B88453; Sat, 29 Jun 2024 01:17:18 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A15C88258
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 01:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so859202f8f.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1719616635; x=1720221435;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hF4mSRu1IpuBKvMtZaqq8y8GQLQh1Ra9F3KnMf+F+pE=;
 b=fkHWVJb5metmPXx/ThsbdjOB1ErULhu40TT3XZB115KXFnM61vICnlOGy9IXLXbCfD
 Yg60tETCcG9ivDg6OVbvSJ/jTgCoRPdUCzVDEAwtzc76NPTAzrZZvSdSUj76NkJENAz7
 MtTyxafVHNsy6Uf7kKYOvBZ0M22NXR9pwb6fw3NL3Jf1RLdOEgVS5EYWZlw6msp5X6pb
 bX7T4S0TU9I48fH+93Nt70k6Q9lxMDYAeprLKCESbF/TB9C+OrrzRXbOy/3cl2vSpiMo
 YWO/keMhaK/0riU6q5GHM7sDuoBHCXO/gFoYfc/bYgcTKyuAP4Xi7YOWH6grA3BvOq+D
 utFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719616635; x=1720221435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hF4mSRu1IpuBKvMtZaqq8y8GQLQh1Ra9F3KnMf+F+pE=;
 b=TBBtQHyzYm5HAfmxduS1yQyeljhP3ysFi05WnDnqNqorJfqdmNaWaHp6b1pMUtPciX
 MR3G0nBrr7+Ig8eUznKmVhAzldS2fGDxUIb8KEJs+JHQksrgseuXxtJLqaEJx7tuWlt6
 /xhy2ZHTF2FuiO95R08vlsyMxv728rdmO21TzsNze4169m4IMiiRVI4yjmdDOaYqy3ST
 KoHY8t0FuoKHPfRafMipnlEt4d6VNfiZmZQJeVV0fhitW+22Rr6qt7Gqq04txXHF8D8/
 RCV2w6ZG2d1caU3T/IceEPilfZZBxoBMMgkfBaAcOEXvpoXL4ebauxV2xsouvIIc5Oiz
 /ZCw==
X-Gm-Message-State: AOJu0Yz3ZO5AJUMtIHjFCGCYrFWv9YWlHzvGgLRnUmcBFpUcJpei6z/E
 rgmyRCPrbZ+KNCcox4opfpVIx1Bhiv4RnpNuGfSQEl2dZBs7VrDJ1MTSMUj3MwVHOE7Ih2eam+H
 R
X-Google-Smtp-Source: AGHT+IFIXENlVrX8ocD/AnIVkbGqIfv2TbrMUgmzxDvwbbuh/vftPHw2KB/gL9euJWfoY3lI/OXsKQ==
X-Received: by 2002:adf:f247:0:b0:35f:1835:3a76 with SMTP id
 ffacd0b85a97d-366e7a5236bmr11387380f8f.70.1719616634681; 
 Fri, 28 Jun 2024 16:17:14 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1345sm3464133f8f.54.2024.06.28.16.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 16:17:13 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] omap3: igep0x00: Switch to the I2C driver model
Date: Sat, 29 Jun 2024 01:17:04 +0200
Message-ID: <20240628231707.195389-1-javier@dowhile0.org>
X-Mailer: git-send-email 2.45.2
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

From: Javier Martinez Canillas <javierm@redhat.com>

When building with the igep00x0_defconfig, the following warning is shown:

  $ make -j $(nproc)
  ...
    LD      spl/u-boot-spl
    OBJCOPY spl/u-boot-spl-nodtb.bin
    SYM     spl/u-boot-spl.sym
    CAT     spl/u-boot-spl-dtb.bin
    COPY    spl/u-boot-spl.bin
    MKIMAGE MLO
  ===================== WARNING ======================
  This board does not use CONFIG_DM_I2C (Driver Model
  for I2C drivers). Please update the board to use
  CONFIG_DM_I2C before the v2022.04 release. Failure to
  update by the deadline may result in board removal.
  See doc/develop/driver-model/migration.rst for more info.
  ====================================================

The only reason why I2C is enabled for the IGEP boards is that the TWL4030
driver requires it.

But both the TWL4034 and the OMAP I2C controller drivers were converted to
the driver model by commits daa69ffe3d4d ("drivers: i2c: omap24xx_i2c:
adopt omap_i2c driver to driver model") and fb1b7712ad3f power: make most
tps drivers and the twl4030 driver compatible with DM_I2C") respectively.

So there's no reason anymore to keep using the I2C legacy API and instead
the DM_I2C option could just be enabled.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 configs/igep00x0_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 87fd2797eace..473891607b0f 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -68,8 +68,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_NET is not set
 CONFIG_SPL_DM=y
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD=y
 CONFIG_SYS_MTDPARTS_RUNTIME=y
-- 
2.45.2

