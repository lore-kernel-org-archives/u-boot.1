Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4196E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC85C80762;
	Wed, 15 Jan 2025 02:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OIwdIrrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6927380716; Wed, 15 Jan 2025 02:23:42 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FC88076E
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-468f6b3a439so57007331cf.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736904219; x=1737509019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajO16SdBAGvYRnrK7hYQq/k8cX5Ov/IabPqVCI3ZZOg=;
 b=OIwdIrrNSDDLQqaoBwDnViMe8RaSfciqDf88PejwOQ+TrD/64DQ7qJjufBAWHQ/Rq3
 KSRfYwg5wQ6v7cGQaRgg6Aw0Pqy73yfqWiAwQwdjhOrRU3bd1iXaIo4ciAJKJyCoSIkK
 0O2GObEGGQNCacBfgyrXngfH0nWa6eBP/LkOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736904219; x=1737509019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajO16SdBAGvYRnrK7hYQq/k8cX5Ov/IabPqVCI3ZZOg=;
 b=aTZBDf1/j5GH3cuwOC6nYavzBgYz7OYBuMFcOxBD3UWoIcXqEKMquDx48AfKFLKM17
 hhjIHS7BIjsJcF+twLrmsQ3iegqex/Kj8r02h0kLfQUIWb6tdC5cFG6EtsadN/hOpgTa
 YnrS1BM4+U11YhbEQf/2UpFyXbdmgueAe77xEcdHABrRzHwH/EisJhW/meVaKwRsJIOs
 szGnJfjDsoTEHxOY+JFtuc+SdaZk2/vTFKOGwlZAl5TtDuymf4+aUB0jZiyDE9VfWyOb
 p295/3Wbu2SD7kwASGaslbTVk1efJTrvBa2OfGtkFRXWGgSeXH50q8nTokpkC1NVc6fr
 pjsw==
X-Gm-Message-State: AOJu0YzmtWiaMuUvMefRu3fZFHnbFe+i+ooG2G7jIyWPS0jlsNOTwW4a
 utQeR/noxOIV4Hmq/dvCWLU4C27Kq7a3zq9RowQkpKH7nAw9wL0f57R2gy6g0xcvPs+lq5CYARJ
 1
X-Gm-Gg: ASbGncux54/abbDbadYa6lXl0qMPYkBP9BZMhDF9s6pYsmywwK9hugbNRkH/+A5SQ5H
 NlzPzih/hhoDu3Fwm65T1rnmZ2yXBKTT24qZy/ITWysLobr9o+Ze0jnEM0yibSM0IK+GXqxPdrH
 o9h2uoYFiSg0EmpgrblDBzPFto6DaQ1DLAF2vb52tGo9Pg2IutJc41p0oHE9YFDJhGv0lOa6Ufs
 251ZCr0v1j34a78Hrco65XHC5vKVQH25iLXMuavOHdBtJW+iSSfzG2a6a7oBnTuJedEYiRBwwUo
X-Google-Smtp-Source: AGHT+IGRyWGXshHMCR4rbmNQ3KC3cVOdOD9AmTpLGH1VYkfQ3mVE0Qskqh+g51kNTeX6tqnRIXFhJg==
X-Received: by 2002:ac8:5d0d:0:b0:467:5f17:94d with SMTP id
 d75a77b69052e-46c7109f2bcmr383130731cf.52.1736904218956; 
 Tue, 14 Jan 2025 17:23:38 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm59817096d6.50.2025.01.14.17.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:23:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCHv2 6/6] block: Remove "select BLK" from non-block drivers
Date: Tue, 14 Jan 2025 19:22:13 -0600
Message-ID: <20250115012322.215243-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115012322.215243-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
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

Now that block drivers are all selecting the BLK symbol, there's no need
for other options to be select'ing BLK so that other required
functionality can be enabled. Remove these places.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
Changes in v2:
- None.
---
 arch/arm/Kconfig              | 4 ----
 arch/arm/mach-exynos/Kconfig  | 4 ----
 arch/arm/mach-imx/mx5/Kconfig | 2 +-
 arch/arm/mach-s5pc1xx/Kconfig | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 127241e608c4..314916527c9e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1372,7 +1372,6 @@ config ARCH_VEXPRESS64
 	select PL01X_SERIAL
 	select OF_CONTROL
 	select CLK
-	select BLK
 	select MTD_NOR_FLASH if MTD
 	select FLASH_CFI_DRIVER if MTD
 	select ENV_IS_IN_FLASH if MTD
@@ -1982,7 +1981,6 @@ config ARCH_STM32
 
 config ARCH_STI
 	bool "Support STMicroelectronics SoCs"
-	select BLK
 	select CPU_V7A
 	select DM
 	select DM_RESET
@@ -2029,7 +2027,6 @@ config ARCH_STM32MP
 
 config ARCH_ROCKCHIP
 	bool "Support Rockchip SoCs"
-	select BLK
 	select BINMAN if SPL_OPTEE || SPL
 	select DM
 	select DM_GPIO
@@ -2117,7 +2114,6 @@ config TARGET_POMELO
 	select AHCI
 	select SCSI_AHCI
 	select AHCI_PCI
-	select BLK
 	select PCI
 	select DM_PCI
 	select SCSI
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 7e6959510087..28193039cb84 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,7 +18,6 @@ config ARCH_EXYNOS4
 	bool "Exynos4 SoC family"
 	select BOARD_EARLY_INIT_F
 	select CPU_V7A
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos4 SoC family are based on ARM Cortex-A9 CPU. There
@@ -39,7 +38,6 @@ config ARCH_EXYNOS5
 	imply USB_ETHER_ASIX
 	imply USB_ETHER_RTL8152
 	imply USB_ETHER_SMSC95XX
-	select BLK
 	select MMC
 
 	help
@@ -51,7 +49,6 @@ config ARCH_EXYNOS7
 	bool "Exynos7 SoC family"
 	select ARM64
 	select BOARD_EARLY_INIT_F
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos7 SoC family are based on ARM Cortex-A57 CPU or
@@ -61,7 +58,6 @@ config ARCH_EXYNOS7
 config ARCH_EXYNOS9
 	bool "Exynos9 SoC family"
 	select ARM64
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos9 SoC family are based on ARMv8 Cortex CPU. There are
diff --git a/arch/arm/mach-imx/mx5/Kconfig b/arch/arm/mach-imx/mx5/Kconfig
index 4d1e07b14d32..0dfd68496875 100644
--- a/arch/arm/mach-imx/mx5/Kconfig
+++ b/arch/arm/mach-imx/mx5/Kconfig
@@ -26,7 +26,7 @@ config TARGET_KP_IMX53
 	select DM_I2C
 	select DM_PMIC
 	select DM_SERIAL
-	select BLK
+	select DM_MMC
 	select DM_REGULATOR
 	select MMC
 	select MX53
diff --git a/arch/arm/mach-s5pc1xx/Kconfig b/arch/arm/mach-s5pc1xx/Kconfig
index b15b2e7b6a01..d8b85f80e631 100644
--- a/arch/arm/mach-s5pc1xx/Kconfig
+++ b/arch/arm/mach-s5pc1xx/Kconfig
@@ -7,7 +7,6 @@ choice
 config TARGET_S5P_GONI
 	bool "S5P Goni board"
 	select OF_CONTROL
-	select BLK
 	select MISC_COMMON
 	select MMC
 
-- 
2.43.0

