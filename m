Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E769C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC785826AA;
	Fri, 11 Jul 2025 17:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lGvO0tF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01628277D; Fri, 11 Jul 2025 17:15:57 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10CA82063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2f77591f208so939091fac.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246954; x=1752851754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7ab9Xb5XhjfTBMHmPKnFMDrOAaIZs3Qlqqp96kdaXU=;
 b=lGvO0tF+lcCwcv2lJ2nHD4YxXA9/FL8eBzQDuHHAyiy/UVtRByyE5+yafKLbD9ddev
 L+G7rthndTId7/zXBsXC4+vrT684I9ecettvCThJiNqY27/YgJo1dfX7KqrAU7IZzLLC
 YFaclVafy1hQM0E80X3aiECNsUbnXJ5k3zsyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246954; x=1752851754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7ab9Xb5XhjfTBMHmPKnFMDrOAaIZs3Qlqqp96kdaXU=;
 b=RNqsBdHZRpUimh6oxhqMHqRD5nDvH4cJbzAHjZlWOnO3+sRjr5X4+0vtC4YkeCANX8
 uzBtvAi1taAZRjUFHdXowcCRTCZa9VS3Nn2hr7dOidf0z2Y8MKioBLzERPZ1LCMpsBF1
 P3PBtMOu3OSNjaP69vlFRFILCY0xp3veRJhMk+xCYpcM27+FTTRwIPJycTfC4ADo0X59
 q7RrpMueuiND6DpYaXR7lAjiiLCLpWc0XTKOnj2ffkYZ15WXMfz4CVbBbWeN0nT10s8E
 NwSnpjWBcM/BRZAy4xS9PqstpCk9lkqhKtI6324dXM+5Ss+khUxlqdJnkaISQC0jwqBE
 POrg==
X-Gm-Message-State: AOJu0YwTTkPGBIv2VsIGZJUdNg5rbJkq3Vmvkbmv6VpO4Ge6NXOr25Fe
 /kTZ62ZESvtNIkN+OkXeT6BXA0yow/OHMY283dUz7qs7CKeGCKg5iBKLcp5jAObPckyTkUXSgE4
 gsQf/GOs=
X-Gm-Gg: ASbGncv4aTU1Nt83bS9hQ450klcI2rXVpiMRG40yMvZejvjK3ZdqkbJ61XtId80WYJC
 52EtPhF7sgiV5pIh6Ggt1owMwSdI5PiLANTqu00nl4lw0nrt/orzCZHq0JYOp9+uzf2ymT2Jr46
 wADyERxBV0nKLRYFb/M8YbESigCwlDkEVPFqFMpAnaqlb9mKjMa+HmzSiNxABkPVFfK1qTWuefo
 YVr8thGzxadgdIgprO50oQOWsWIpsBQsy9ir2vcFGzybUyhpbPpMRTZ9Z+8ec4yCVpkCxTBMuhW
 zA0V9eNj0kOIoYPFHMsFcv978m6Hz8slsoJUzp2wmY4EbT8wXYoTIBE/EPOeEPcAHyBmc3QaMVF
 0HXYXo0oNiHbAMja8TQhl/Z0IVu4SD1I5ELR7Uvg+u9IQnoo2AIRbEVyvZ3Q=
X-Google-Smtp-Source: AGHT+IHul+/wZOIeYruHrTv42K7FWrxI4D82jAeeljQobSXfM9AkGs3MEXig1l2CJkd6rGda/QjvHw==
X-Received: by 2002:a05:6870:2151:b0:2eb:a2ef:901b with SMTP id
 586e51a60fabf-2ff2671375amr2895472fac.14.1752246954071; 
 Fri, 11 Jul 2025 08:15:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1172e5c8sm760230fac.44.2025.07.11.08.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:15:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH] brppt2: Use the correct MMC driver
Date: Fri, 11 Jul 2025 09:15:52 -0600
Message-ID: <20250711151552.2224176-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As part of splitting the i.MX parts of FSL_ESDHC out from the more
legacy parts, the FSL_ESDHC_IMX symbol was added. This platform is the
only one which was not converted correctly.

Fixes: e37ac717d796 ("Convert to use fsl_esdhc_imx for i.MX platforms")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---
 configs/brppt2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index 04defac9a71a..7774f7b23884 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -80,7 +80,7 @@ CONFIG_BOOTCOUNT_ALTBOOTCMD="setenv b_mode 0; run b_default;"
 CONFIG_SYS_I2C_MXC=y
 CONFIG_MMC_BROKEN_CD=y
 # CONFIG_SPL_DM_MMC is not set
-CONFIG_FSL_ESDHC=y
+CONFIG_FSL_ESDHC_IMX=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
-- 
2.43.0

