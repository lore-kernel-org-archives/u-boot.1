Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8782C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4C082BD9;
	Mon,  9 Jun 2025 21:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p7MDQ+o7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HcZky7CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C675D82BAA; Mon,  9 Jun 2025 21:27:29 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2B68144A
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bGMPq4Knkz9srm;
 Mon,  9 Jun 2025 21:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGEv6kd0rzpJCMpA/h4v8z6f+lbLSFj8+QCC5nRHEnk=;
 b=p7MDQ+o7S2/OwBdRab5Ntyuh/Rei0R0qC3+py4gz7F4IVx3tu4smRAafkXwhZMYihb15WI
 3otyyXAwC+08RVU4RgZ5xM+1Jp/5EBzIds2da+MxnJuabkLSplUtKIzNN/FxUKsPSzmydc
 p+j9hJMopb8rVDOA8A3LeVO3b8d68X73nFsOskRAQDBPbmK5SftHrzDx9uuWmhM+Ph9AFf
 3kjBZtYCLauvhnSJc67loGEj8b5Fyp3Si6gCIv9n38zktmzVTBwtii5BzIrVnmjdUvILY2
 uoRThI4a23q8SkGH4Gn6jW4HWBBgouBDMYn5e/mOtRWpAfDZmyjMM9w8JXOxdA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGEv6kd0rzpJCMpA/h4v8z6f+lbLSFj8+QCC5nRHEnk=;
 b=HcZky7CCM2qzHewDELMSIOkkSBug9JW+kWfXQDrtV6PNaYH/18z7WDxZorRPQgPLcwZVxL
 D45n5c7VUwYSX5L35ubR/4pP42aGzdP+xPEXcf/vJ+dfH8HSoIM/J2SqJ/jeZvW2Hvwmwi
 m6hOWXsivoMY8aJdFuh3pydbRUpNReSdXgxCWFG26XsQONDEfJVE99ERJdkvjnJ3rO/I4g
 dbtSPlxSHLNAz1RM1/O9R6LnYmgFpWra4TElYW2i8sFUlYJkgsVEBn/Yf8fupwDzRJRtTu
 dU3Z/xl6FHJ/c/uhBbQArwuTRr7x9d8SYJj8Bo47/3vhDReAERJP7c+i6qJtkw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/8] env: Rename ENV_MMC_PARTITION to ENV_MMC_SW_PARTITION
Date: Mon,  9 Jun 2025 21:26:41 +0200
Message-ID: <20250609192701.20260-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c1bjjgjs7955fgaeq4r4xw8aaszxd1ns
X-MBO-RS-ID: aaf0c632c96b77a72d5
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

Use ENV_MMC_SW_PARTITION to clarify this is the SD/MMC software
partition table entry selector. Update the help text accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Rename to ENV_MMC_SW_PARTITION
---
 doc/device-tree-bindings/config.txt |  2 +-
 env/Kconfig                         | 19 +++++++++++--------
 env/mmc.c                           |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index a617e7f84f8..fffb69e75de 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -76,7 +76,7 @@ u-boot,mmc-env-partition (int)
 	precedence. In that case, only if the partition is not found,
 	mmc-env-offset* will be tried.
 
-	Note that CONFIG_ENV_MMC_PARTITION overrides this device-tree setting.
+	Note that CONFIG_ENV_MMC_SW_PARTITION overrides this device-tree setting.
 
 u-boot,no-apm-finalize (bool)
 	For x86 devices running on coreboot, this tells U-Boot not to lock
diff --git a/env/Kconfig b/env/Kconfig
index 3317f3c5603..52f5cb86584 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -719,17 +719,20 @@ config ENV_MMC_EMMC_HW_PARTITION
 	  partition 0 or the first boot partition, which is 1 or some other defined
 	  partition.
 
-config USE_ENV_MMC_PARTITION
-	bool "use the mmc environment partition name"
+config ENV_MMC_USE_SW_PARTITION
+	bool "Use SD/MMC environment software partition name"
 	depends on ENV_IS_IN_MMC
 
-config ENV_MMC_PARTITION
-	string "mmc environment partition name"
-	depends on USE_ENV_MMC_PARTITION
+config ENV_MMC_SW_PARTITION
+	bool "SD/MMC environment software partition name"
+	depends on ENV_MMC_USE_SW_PARTITION
 	help
-	  MMC partition name used to save environment variables.
-	  If this variable is unset, u-boot will try to get the env partition name
-	  from the device-tree's /config node.
+	  SD/MMC software partition name used to save environment variables.
+	  This is a software partition name, i.e. one in partition table, not
+	  an eMMC HW partition (see ENV_MMC_EMMC_HW_PARTITION for eMMC HW
+	  partition configuration). If this variable is unset, u-boot will
+	  try to get the env partition name from the device-tree's /config
+	  node.
 
 config ENV_MMC_USE_DT
 	bool "Read partition name and offset in DT"
diff --git a/env/mmc.c b/env/mmc.c
index 5d1cb78e5ca..11375bd4464 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -161,8 +161,8 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 	hwpart = mmc_get_env_part(mmc);
 #endif
 
-#if defined(CONFIG_ENV_MMC_PARTITION)
-	str = CONFIG_ENV_MMC_PARTITION;
+#if defined(CONFIG_ENV_MMC_SW_PARTITION)
+	str = CONFIG_ENV_MMC_SW_PARTITION;
 #else
 	/* look for the partition in mmc CONFIG_ENV_MMC_DEVICE_INDEX */
 	str = ofnode_conf_read_str(dt_prop.partition);
-- 
2.47.2

