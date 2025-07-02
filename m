Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ADEC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5259582A76;
	Wed,  2 Jul 2025 03:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q9uJma2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060B982EB8; Wed,  2 Jul 2025 03:04:04 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA88381E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ef8df09ce9so1860165fac.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418240; x=1752023040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XckH8WK1qhcdaKrUso5pHbdl5Xd7alpTR1UKHJRpFYI=;
 b=Q9uJma2BQVJ8Vr14SpxfyE4yPztqGrSV7HJAMfM+Qug0hoYW9b+0QwVp//Xsjtua+o
 YfvYgHpzFhVAEHFTyRGP+MDRHuPRyEiCj6q0hkgycKp8bwGncakuD+yLbEjB++vPi9Qu
 f2tnNVaf65MzHj1g+WEpwRZ+bMlMI2ooMSMlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418240; x=1752023040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XckH8WK1qhcdaKrUso5pHbdl5Xd7alpTR1UKHJRpFYI=;
 b=YQ5IxdtGWCR9caSlxB1Bib5X71CSFVr+TdoRxPoZkF20/CIjexJOFKVd6P1Dix8GVu
 J5DwcBIriq1j9AoMwesWgBhthPGQ477ggqkMFRLVH3oUdmWU6N6JICuhw7PJIKic3G5A
 eUJRPcz0LYEm07/11DjCkaHcrRZstPJ5BIlqRt1oZE2RAr1HwsKgiPN7sqrWKAGML9S8
 X1gjOETuvJbftCBEr+bJTfnGF/3FzwgJpgI1l+2ohI3w4gpEtfW4LViTAoS6NpZh8Ncv
 V4Cs77AYTJun3wHMZUft77Bj4oUmC1WDhZCtUhVUx+C+2F43X8ulxR/BsMHMoF09Rg37
 KxrA==
X-Gm-Message-State: AOJu0YyXMr481IDNLWYkfDyTcWXkc66KoziqK4ZDKafot6H0XPAjxwxC
 qXiqG8n7HWfXZYNBKMrdCiMc3UkW6rG62L8wgzoN7E7NwKgPd5JRiueKtMp8dihYIHWjv9QRI4a
 8rqHrAIo=
X-Gm-Gg: ASbGncv8aqn+z9QQnhKITy4+jGhAmO0UVEXfCa76k42RqlMz/Hi/OWCSdK/bPDycM1w
 zAZGj1v16lxUI8pHq+jDT47D2fW/jN9TKHHQawplGlIr0RZcjiP/GkkF3zKp3oXpqGdFX9IQ0wB
 2sDSUCQfDt7ix4xiYR0Fk9J6Cz5YiVOCGq2WW8qXwpHGbqQzNsarpANeUgzHW8uEk+XhQPHeHSv
 VzFzsyYWqjrnUBcJeGTh8m56NsKDz4lqp7UpafxOXMJjPWO381YzzyZYOpDM3XYqIfzOaojnm99
 nnib9iqPA0Q2KSbWQpeMzClSlWwfaoWH5P1tWwF5+zqyASgV01SM9++9XbhisqXAtsfPMT3OBXi
 T3phAk7wkohb62DyU4QXckf4=
X-Google-Smtp-Source: AGHT+IG5q8hB07z4K9i6RqQaefdc2ErQ8sQ5dqg6n+fCuaiTut63h/NeiIyP790E873jIsp8vzyNfQ==
X-Received: by 2002:a05:6870:9b07:b0:29e:2594:81e with SMTP id
 586e51a60fabf-2f5a0d3ef65mr762542fac.13.1751418240450; 
 Tue, 01 Jul 2025 18:04:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb10088esm2321380a34.50.2025.07.01.18.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>
Subject: [PATCH] i2c: Kconfig: Tighten some i2c driver dependencies
Date: Tue,  1 Jul 2025 19:03:59 -0600
Message-ID: <20250702010359.18747-1-trini@konsulko.com>
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
Cc: Heiko Schocher <hs@denx.de>
---
 drivers/i2c/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 146bc621c7e4..602ac9a9c704 100644
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
+	depends on MACH_IMX
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

