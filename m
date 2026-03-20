Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7861099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBD883FDC;
	Fri, 20 Mar 2026 21:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nzEFMgs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9D983F00; Fri, 20 Mar 2026 21:53:28 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2622883CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7c76e1951so2102399a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040004; x=1774644804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zq2KNTAK/52/e96ianUPl+CfMH4tDSDgf3EtDSVqbBs=;
 b=nzEFMgs8XRBn26e5zQ1EEGUrCvyQ/tmKCPQLMSK/Vje42Jn4FBqASXnrQ7hPe1jzS4
 BGssRUa7N3Y5SyWbj4S94M7ulKcz+fRM3/DP/JzINrVmJlve+0fKugFos94V6+CMFGNH
 E4HlD4H8e1nOHGpKnw3g4mFrnQadJoZQJsWws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040004; x=1774644804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zq2KNTAK/52/e96ianUPl+CfMH4tDSDgf3EtDSVqbBs=;
 b=kc+YphzBdk2gA1/gPmi6IGdXa3MlKjhpiMMhE4SW7qG1eJED76vcF1evUxtdWzWc8y
 e81kDcHk8VTU8Eufkt5gWo/EOFvlDFNcb//O3BDmCTqDUyd1muaQQHzcAUc6Rlh0FqcU
 FUFKHuK7yIR+t4TdZZn/U0tE85zdf7pQt+vWKtnpzHtJHHNpjkWvVh2P2mWl4mWewGms
 8/XinRSo6spSq4gry5yVm/IFx16/QH+ogIvgCO2vohAIevP+Zb6k6gm6a5lizSNFRCvp
 fQN7A8GazuIxBMAuMreVIffpB4bW1khgpJZvNDvW7vDveOWlOw32syJ6AIDtNrrx6Ry+
 I0uQ==
X-Gm-Message-State: AOJu0Ywuq892u2/90rp7PA2+jh7MtHYoSh+xupIv8lNESAtmXP0ESIy8
 5fh6dswAmLNXft9FM/vM3ifS4nRofSfW2eC7WXpQSPSW9z9z524s9L45MSY7YFLlScBYqg4Znpy
 3gUvMPh0=
X-Gm-Gg: ATEYQzw01xCZJ3WnmU0AVJqacNuyqMRIh6VGgLgvEgsbCOFHhDcWl1Xbqgz6p7/ChOn
 nPO7YCTeyXzyl+Y0MZlZUld3e2MfW7v2neeA9uAc5n46Q6m37A6ABk1+3HlOtEAWpmB2LflJYxR
 +iEd7G9L9RalvQIEQbXVOJ9X2MeR4gld2N1PwqB+ctEAOiYaV1yB5q6FB/GVgcqs7HMrHxQYJv9
 UqcdGISXMpAwGZZSDHzJHEWTyIsAiZea+R4rr4YD8AzL08qwhGtMeGHyMRceDL3vZl0W+pwh7aZ
 fUDRsJUys6yr/pf78osjQ0ujYlH3jBkJG8w+X7DF3ppksHYuOLHzEbhBWPF23SFpCOr3Qo25twq
 hFovHvZ6otef0be/G4uLUmgxkIIr7CdZAUMwTT4r0Bch/KIm9zpTqShpNdK46YdwIX7EKF4GRYN
 ivlNMV+2LwJryRFhZBsNXyr9JViZlsmOmcTD71JH+Zw0wsUuQ/vL4zFFa5AaqkuFd5PSZwidRDD
 ZFMDSjAyiaEF2q8OS2f6H/x5449ad+ZqaCexSWHu6grX7tbnwI=
X-Received: by 2002:a05:6830:2112:b0:7d7:cba0:8b75 with SMTP id
 46e09a7af769-7d7eb0215f0mr3023997a34.32.1774040004253; 
 Fri, 20 Mar 2026 13:53:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac1747csm3051264a34.8.2026.03.20.13.53.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Audit Kconfig usage of PARTITION_TYPE_GUID
Date: Fri, 20 Mar 2026 14:53:22 -0600
Message-ID: <20260320205322.3788575-1-trini@konsulko.com>
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

It is not functionally possible to use the code enabled by
PARTITION_TYPE_GUID without having EFI_PARTITION be enabled as well. Not
all users of the former had ensured that the latter was enabled however,
so audit all current users and then as appropriate select or imply
EFI_PARTITION as needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig                                | 2 +-
 arch/arm/mach-rockchip/Kconfig              | 2 +-
 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig | 1 +
 board/sifive/unleashed/Kconfig              | 2 +-
 board/sifive/unmatched/Kconfig              | 2 +-
 board/starfive/visionfive2/Kconfig          | 2 +-
 boot/Kconfig                                | 1 +
 lib/fwu_updates/Kconfig                     | 1 +
 8 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ba99d251737d..10755fec8bbe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -254,7 +254,7 @@ config SANDBOX
 	imply AVB_VERIFY
 	imply LIBAVB
 	imply CMD_AVB
-	imply PARTITION_TYPE_GUID
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
 	imply SCP03
 	imply CMD_SCP03
 	imply UDP_FUNCTION_FASTBOOT
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 9f1f77ee5b3c..108713488af1 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -284,7 +284,7 @@ config ROCKCHIP_RK3399
 	imply OF_LIBFDT_OVERLAY
 	imply OF_LIVE
 	imply OF_UPSTREAM
-	imply PARTITION_TYPE_GUID
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
 	imply PHY_GIGE if GMAC_ROCKCHIP
 	imply PRE_CONSOLE_BUFFER
 	imply RNG_ROCKCHIP
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
index 490097e98be8..647e0a4c2bf4 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
@@ -3,6 +3,7 @@ config CMD_STM32PROG
 	select DFU
 	select DFU_RAM
 	select DFU_VIRT
+	select EFI_PARTITION
 	select PARTITION_TYPE_GUID
 	imply CMD_GPT if MMC
 	imply CMD_MTD if MTD
diff --git a/board/sifive/unleashed/Kconfig b/board/sifive/unleashed/Kconfig
index 2fcc788ba53f..36cf756e3f3b 100644
--- a/board/sifive/unleashed/Kconfig
+++ b/board/sifive/unleashed/Kconfig
@@ -35,7 +35,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_FAT
 	imply CMD_FS_GENERIC
 	imply CMD_GPT
-	imply PARTITION_TYPE_GUID
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
 	imply CMD_NET
 	imply CMD_PING
 	imply CMD_SF
diff --git a/board/sifive/unmatched/Kconfig b/board/sifive/unmatched/Kconfig
index 5071af129c62..9245873927bc 100644
--- a/board/sifive/unmatched/Kconfig
+++ b/board/sifive/unmatched/Kconfig
@@ -36,7 +36,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_FAT
 	imply CMD_FS_GENERIC
 	imply CMD_GPT
-	imply PARTITION_TYPE_GUID
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
 	imply CMD_NET
 	imply CMD_PING
 	imply CMD_SF
diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
index 185f94190b5c..b4bf59676ac9 100644
--- a/board/starfive/visionfive2/Kconfig
+++ b/board/starfive/visionfive2/Kconfig
@@ -45,7 +45,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply EFI_PARTITION
 	imply MII
 	imply ISO_PARTITION
-	imply PARTITION_TYPE_GUID
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
 	imply PHY_LIB
 	imply PHY_MSCC
 
diff --git a/boot/Kconfig b/boot/Kconfig
index bfed452d77e3..a56b7aa2f378 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -563,6 +563,7 @@ config BOOTMETH_ANDROID
 	select CMD_BCB
 	imply CMD_FASTBOOT
 	imply FASTBOOT if !NET_LWIP
+	select EFI_PARTITION
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
 	help
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index a722107c1290..b38808e3463b 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -1,6 +1,7 @@
 menuconfig FWU_MULTI_BANK_UPDATE
 	bool "Enable FWU Multi Bank Update Feature"
 	depends on EFI_CAPSULE_ON_DISK
+	select EFI_PARTITION
 	select PARTITION_TYPE_GUID
 	select FWU_MDATA
 	imply EFI_CAPSULE_ON_DISK_EARLY
-- 
2.43.0

