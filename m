Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11569C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F4B81D5D;
	Sat, 22 Mar 2025 22:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C0zqmAFC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NpWtb8F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCD481D5A; Sat, 22 Mar 2025 22:56:53 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D45681D0B
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZKtSf55GLz9sNf;
 Sat, 22 Mar 2025 22:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HzdDEn9P+2th8nvu0N8vzk1iUxYp22eNzd4HCYFfX8=;
 b=C0zqmAFCcMOEP/BS5iDn1sHCzYYm2k6kXQAuFDc9CFmQNc5nSTwfag3a1BaoxaJlpStfod
 PFvuYnFeI4TLuxr81S5d2lxDC6DoXr008Flv0J9uFjljxTSzbCVlv0Akv3TnpU2PJsx3El
 2khjfyYL5TuddC22tVwt1qujtkWac/fo4ac3BgMOvauXpEPfrFW/af4PQG4GbJRvJnJA90
 IBBf5p2Jrt/tyhl9VbHJzPPpd9ESdXgkB6HIZcafMdDNY1p/akx65ihgh6W47qSs/5lg23
 aNUw1WXD05LT1VILUznzPZfFw8RJThzruhWGVgyjrsurfMuzCvzgd38k81Mi8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HzdDEn9P+2th8nvu0N8vzk1iUxYp22eNzd4HCYFfX8=;
 b=NpWtb8F3mkYoZLYBDCau6F+sbOjH88957SLKJ6NZHckVh85elqY8tl5VKf16SXQQSUkkeQ
 z/8BLeT7HndmuCpR3YBVbArTL9/lDZSkqxQfd+fTgzmEAm8oQL5iaCAXIrJ+RlwXEFPkIi
 NeToT4VEl88rXYFKQHt4qF08snzC/mQvgo1UaIbw6Wco4vZj3eYfZQ0dknnpC+z8cNgeEp
 8SVVPZX1cnkOtsB2pBkRQW4YdU+QTY3IZRPn5NUfzwuzdodWlxDcKwLm48gnzlRzirF59i
 o3YCUHlE4gFMjjRnggupk3mN5b6Gt0qrmCMdML+Sv2PkUBYPcLVQjLuasafBCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] env: Rename ENV_MMC_PARTITION to ENV_SDMMC_SW_PARTITION
Date: Sat, 22 Mar 2025 22:55:26 +0100
Message-ID: <20250322215624.18994-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mutk4bfahho4ojegxkjjz6wnfartmiip
X-MBO-RS-ID: b37cad8b04f81598c73
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

Rename the variable and add ENV_ prefix, so that all configuration
options which are related to environment would have an CONFIG_ENV_
prefix. No functional change.

Use ENV_SDMMC_SW_PARTITION to clarify this is the SD/MMC software
partition table entry selector. Update the help text accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/device-tree-bindings/config.txt |  2 +-
 env/Kconfig                         | 21 ++++++++++++---------
 env/mmc.c                           |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index 8584cc6dcf4..44443c92d5d 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -76,7 +76,7 @@ u-boot,mmc-env-partition (int)
 	precedence. In that case, only if the partition is not found,
 	mmc-env-offset* will be tried.
 
-	Note that CONFIG_ENV_MMC_PARTITION overrides this device-tree setting.
+	Note that CONFIG_ENV_SDMMC_SW_PARTITION overrides this device-tree setting.
 
 u-boot,no-apm-finalize (bool)
 	For x86 devices running on coreboot, this tells U-Boot not to lock
diff --git a/env/Kconfig b/env/Kconfig
index fbc03777040..19bc34f8663 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -677,7 +677,7 @@ config ENV_SDMMC_DEVICE_INDEX
 	  matches the 'mmc list' command output.
 
 config ENV_SDMMC_EMMC_HW_PARTITION
-	int "mmc partition number"
+	int "eMMC hardware partition number"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT
 	default 0
 	help
@@ -687,17 +687,20 @@ config ENV_SDMMC_EMMC_HW_PARTITION
 	  partition 0 or the first boot partition, which is 1 or some other defined
 	  partition.
 
-config USE_ENV_MMC_PARTITION
-	bool "use the mmc environment partition name"
+config ENV_SDMMC_USE_SW_PARTITION
+	bool "Use SD/MMC environment software partition name"
 	depends on ENV_IS_IN_MMC
 
-config ENV_MMC_PARTITION
-	string "mmc environment partition name"
-	depends on USE_ENV_MMC_PARTITION
+config ENV_SDMMC_SW_PARTITION
+	bool "SD/MMC environment software partition name"
+	depends on ENV_SDMMC_USE_SW_PARTITION
 	help
-	  MMC partition name used to save environment variables.
-	  If this variable is unset, u-boot will try to get the env partition name
-	  from the device-tree's /config node.
+	  SD/MMC software partition name used to save environment variables.
+	  This is a software partition name, i.e. one in partition table, not
+	  an eMMC HW partition (see ENV_SDMMC_EMMC_HW_PARTITION for eMMC HW
+	  partition configuration). If this variable is unset, u-boot will
+	  try to get the env partition name from the device-tree's /config
+	  node.
 
 config ENV_MMC_USE_DT
 	bool "Read partition name and offset in DT"
diff --git a/env/mmc.c b/env/mmc.c
index 4155a5c72f1..f49af88bf5f 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -161,8 +161,8 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	hwpart = mmc_get_env_part(mmc);
 #endif
 
-#if defined(CONFIG_ENV_MMC_PARTITION)
-	str = CONFIG_ENV_MMC_PARTITION;
+#if defined(CONFIG_ENV_SDMMC_SW_PARTITION)
+	str = CONFIG_ENV_SDMMC_SW_PARTITION;
 #else
 	/* look for the partition in mmc CONFIG_ENV_SDMMC_DEVICE_INDEX */
 	str = ofnode_conf_read_str(dt_prop.partition);
-- 
2.47.2

