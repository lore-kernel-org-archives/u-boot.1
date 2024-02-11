Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06AFC4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E43587C69;
	Sun, 11 Feb 2024 18:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s0l2XPjO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NxkqgNko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B1F87EBA; Sun, 11 Feb 2024 18:35:07 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F1287C4D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TXvqY1JlPz9sSH;
 Sun, 11 Feb 2024 18:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f71TIWjiuz3yPf8O5AAepoj8SLUU8GZRfgeGgwE1wVY=;
 b=s0l2XPjO6UjX3+5Qciw7xAHejgzJ5veVU9tRIWQlZqgMpabhXrfssc1xg/QLqD74jeNASw
 CTD7tRh9ss79N61jTuoyJJV6Z4/TkNvBbWxeDKREPb/stQs2mJdkSbrdgT9VM55WCfPKd7
 WcfbYJpG1zorNGkRufv7NaeTB/is4nf56Rf0Z8U5hCwhSf6AyBcgnDGixIL0oaR9e0xtXb
 Qw3BRRIfFqVPgqEgHPVZDT/Fdp41sOyFhJN0Ro6Btc/3h7rryQZUWlWRI/8TVJVB9J4VI9
 d9QqF+ysddkNTcGFxoYWSTb+Xirt36G5lK3+b6X9604fjfyX4J9fxdoHXBqqBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f71TIWjiuz3yPf8O5AAepoj8SLUU8GZRfgeGgwE1wVY=;
 b=NxkqgNkoy/dc6dM1I/h1QndXLWPdSoS2EqHFsjwsndL/yygunuF0ARLlUQaLYy203WiJxV
 EPlvzrkQLmaBv/guHOMtEiT+8jV+Q7R7lR1pd7OC+ETPquaOT7xfnrq+bTKk3hEAlhE6Sj
 /M0j+VDsFdL+iEV/52M1h+Sa6F0TJpgO8g9QbtHTHCEhHk1nQnLRSrI8T+T0oXFwTwEOgM
 K+eatyiwPEFDL1ah+oFfSYjc/GlNIPEkb27btVFzg+5Q/DJ5feMRrrE6zYABbGTTgzRApp
 k/Gt3wSggrgEVWKGLY2pHSGRAeVOM1jnkksgHIBLQQ6PkdKC56Q6kkIzoplv8g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 1/3] ARM: renesas: Disable EFI on R-Car Gen2
Date: Sun, 11 Feb 2024 18:34:28 +0100
Message-ID: <20240211173446.7162-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1ee6979da65d402844d
X-MBO-RS-META: kbekip31ju6w9uz5tbj79ze969kizinh
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

These systems are unlikely to use EFI as this functionality has not been
enabled until it got pulled in by Kconfig default. This functionality
does add some 60-70 kiB to the u-boot.img size, which overflows the size
limit. Disable it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 configs/alt_defconfig     | 2 ++
 configs/blanche_defconfig | 2 ++
 configs/gose_defconfig    | 2 ++
 configs/koelsch_defconfig | 2 ++
 configs/lager_defconfig   | 2 ++
 configs/porter_defconfig  | 2 ++
 configs/silk_defconfig    | 2 ++
 configs/stout_defconfig   | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index 31f38bd3a5b..35707a65960 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -106,3 +107,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
index 59e9b3af846..f328af84dfa 100644
--- a/configs/blanche_defconfig
+++ b/configs/blanche_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
@@ -82,3 +83,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index 4220b9349b7..92bb5911765 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -104,3 +105,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index d39533cc393..8d9c3b94499 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -104,3 +105,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index da2ba58c6b0..d00314c60e4 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -106,3 +107,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index 0a805deff65..a343c8e83de 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -104,3 +105,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 7c6b5b59c93..5f08ae0fcf9 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -106,3 +107,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 8fad272cf55..0375630adea 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k(u-boot-env2),768k(u-boot),-(user)"
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -105,3 +106,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
-- 
2.43.0

