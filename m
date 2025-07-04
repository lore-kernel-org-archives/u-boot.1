Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E600DC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8F782A76;
	Fri,  4 Jul 2025 23:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMDpqljd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C4882CFA; Fri,  4 Jul 2025 23:47:39 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E51382063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73caf1152bdso289228a34.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665656; x=1752270456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l0FmR3Aai6vYCH3fp5FM9pE2vjBHL0jmDYYqleB8GmQ=;
 b=HMDpqljd4RdjoYY1Y8yYXtENtdBqMtXpXTwv8Xk2ioW26WyUv0ZFi+Igji48wJcy22
 1QV2gSBRLykfpK1PLZfLSeWAPAuIsee/81qnt9VOhqqjSEWTjVk0k5cYllhsO5TpimPr
 4vaJ0L/ctxtXFjql/q/D465UA+wKu1Rreji3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665656; x=1752270456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0FmR3Aai6vYCH3fp5FM9pE2vjBHL0jmDYYqleB8GmQ=;
 b=nig4CbQsT9eQGxFViY52S4ICuGQOLTZqgEblioZ44hZd/gXEvOHTTdQucOkuoABu0Q
 6a+KvqgM9CDkl7xon1TGdHa1BuiCCVCaKuvFFjcGHaYaiPLm8yk7SkQQFCgZPGS3eFOo
 q4kT+1Js3oL5jtAEPT8ff6NdZJ7qRkCJw9WCeG1J6iVrTDRrVqV57/KSgXE6EbRW/zLF
 tGsQxa+1aTqmNpouExnrriuuuOkz8ugRlX8CmUhPBOiir4UkV+jxP4oNY7ZFCX1nutMV
 zDg3zJCEDlDV/x/yFUQYyLedO60e8bGLNtM0y0APmwmaZPQzU0Tw25gcHrNVbMmX7Der
 SyDw==
X-Gm-Message-State: AOJu0YztkLYX3n1rN38LsHDinL4/1B2zJJU4Zi+HeIJWGoTh0K4zEl1x
 e6iZ196Rbbd7QHfS12HWpSp1dIDc3wEFXwScUA8zTX2ONdDf9sO04cblFmmJs8vhaId5Ah89tuD
 84XSN/Nw=
X-Gm-Gg: ASbGncugh7BGDGPlWU0OJM1IKj057Wec/FHlImXovHxfZDs6k57fUj70HDgkmNT3wKI
 +P/D/Uj4K78VJsgbaJmxV6zkwVSAEWfbCgmqunf7pmJLK0++1WVWjI0A4qP43G97k8pDu9st9ZA
 RVTYFhYN2RaovLM1ltkLMWSZ3jD6M9Jm3Bozkut40/BF+g+Uq8GDPJFq6ZR0VzCe5koMGhRRYJm
 YUE5kfDLUWizcYsOTf+55B1FWjhmoHp44EeVPAhYaqNr1wNK3lrsNUwJJ8fz6+sW45H18a4aIAD
 p9KJnBLzcEVsGRJLjgOIsCgzSw8r1LgGHrnosF7RGzpkcGRYnT1fT+NdntH0D1NuJCTNhjoriOr
 Ub0OyWTW1G6AgJp0M7JajL2U=
X-Google-Smtp-Source: AGHT+IG1kMsUtOBc5e22wveJYLRitJv2S+a+RaCmy0UepMmcOA9x9sktwIJYdceSipN+JEqem3zxqg==
X-Received: by 2002:a05:6808:11c4:b0:403:34b3:c986 with SMTP id
 5614622812f47-40d2b3734dbmr208852b6e.17.1751665656132; 
 Fri, 04 Jul 2025 14:47:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a4593esm431117b6e.17.2025.07.04.14.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:47:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>
Subject: [PATCH v2] i2c: Kconfig: Tighten some i2c driver dependencies
Date: Fri,  4 Jul 2025 15:47:34 -0600
Message-ID: <20250704214734.3419176-1-trini@konsulko.com>
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

A few i2c drivers cannot build without access to some platform specific
header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Correct dependencies on SYS_I2C_MXC

Cc: Heiko Schocher <hs@denx.de>
---
 drivers/i2c/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 146bc621c7e4..9465e61a04c9 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -181,6 +181,7 @@ config SYS_I2C_IPROC
 
 config SYS_I2C_FSL
        bool "Freescale I2C bus driver"
+       depends on M68K || PPC
        help
 	  Add support for Freescale I2C busses as used on MPC8240, MPC8245, and
 	  MPC85xx processors.
@@ -240,7 +241,7 @@ config SYS_I2C_DW
 
 config SYS_I2C_DW_PCI
 	bool "Designware PCI I2C Controller"
-	depends on SYS_I2C_DW && PCI && ACPIGEN
+	depends on SYS_I2C_DW && PCI && ACPIGEN && X86
 	default y
 	help
 	  Say yes here to select the Designware PCI I2C Host Controller.
@@ -277,6 +278,7 @@ config SYS_I2C_INTEL
 
 config SYS_I2C_IMX_LPI2C
 	bool "NXP i.MX LPI2C driver"
+	depends on MACH_IMX
 	help
 	  Add support for the NXP i.MX LPI2C driver.
 
@@ -314,6 +316,7 @@ config SYS_I2C_MICROCHIP
 
 config SYS_I2C_MXC
 	bool "NXP MXC I2C driver"
+	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || MACH_IMX
 	help
 	  Add support for the NXP I2C driver. This supports up to four bus
 	  channels and operating on standard mode up to 100 kbits/s and fast
@@ -485,7 +488,7 @@ endif
 
 config SYS_I2C_NEXELL
 	bool "Nexell I2C driver"
-	depends on DM_I2C
+	depends on DM_I2C && ARCH_NEXELL
 	help
 	  Add support for the Nexell I2C driver. This is used with various
 	  Nexell parts such as S5Pxx18 series SoCs. All chips
@@ -494,6 +497,7 @@ config SYS_I2C_NEXELL
 
 config SYS_I2C_NPCM
 	bool "Nuvoton NPCM I2C driver"
+	depends on ARCH_NPCM
 	help
 	  Support for Nuvoton I2C controller driver.
 
@@ -533,7 +537,7 @@ config SYS_I2C_RCAR_IIC
 
 config SYS_I2C_ROCKCHIP
 	bool "Rockchip I2C driver"
-	depends on DM_I2C
+	depends on DM_I2C && ARCH_ROCKCHIP
 	help
 	  Add support for the Rockchip I2C driver. This is used with various
 	  Rockchip parts such as RK3126, RK3128, RK3036 and RK3288. All chips
@@ -750,6 +754,7 @@ config SYS_I2C_MV
 
 config SYS_I2C_MVTWSI
 	bool "Marvell I2C driver"
+	depends on ARCH_KIRKWOOD || ARCH_MVEBU || ARCH_SUNXI
 	help
 	  Support for Marvell I2C controllers as used on the orion5x and
 	  kirkwood SoC families.
-- 
2.43.0

