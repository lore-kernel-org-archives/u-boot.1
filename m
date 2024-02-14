Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9446C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887A187EDC;
	Wed, 14 Feb 2024 17:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wij67gM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA5887ED1; Wed, 14 Feb 2024 17:30:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD3387E2C
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUBIj101831;
 Wed, 14 Feb 2024 10:30:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928211;
 bh=q9PYcIbc5mbFVYs//fQGylQuUxk/4gjs1QyYKyoOmXE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Wij67gM23LGCf63/9rmF8hQQ2L93iOCgzfYvYCTRqVtfzlFFnx3wDQbFJVdMwbWPm
 /3epvTvkhjq82CsdZMY/82OEIKTP02RsdvBew37zg4bZtsXd2InHkLeO68mpNZVYHo
 wnO94BEiVAn7YQyXOgQO0KfQ6kYxQT3CdfWbQuBk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUBhm079724
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:11 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:10 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9ru014388;
 Wed, 14 Feb 2024 10:30:10 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/6] arm: mach-k3: am62: Enable OF_SYSTEM_SETUP for all boards
Date: Wed, 14 Feb 2024 10:30:06 -0600
Message-ID: <20240214163009.983034-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214163009.983034-1-afd@ti.com>
References: <20240214163009.983034-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The fixups provided by ft_system_setup() are applicable for all AM62 based
boards. Select this at the target selection level for all AM62 boards and
remove it from any specific defconfig.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am62x/Kconfig    | 3 +++
 configs/verdin-am62_a53_defconfig | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 935d596c879..7c9bac2ece8 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -13,6 +13,7 @@ config TARGET_AM625_A53_EVM
 	bool "TI K3 based AM625 EVM running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 
 config TARGET_AM625_R5_EVM
 	bool "TI K3 based AM625 EVM running on R5"
@@ -29,6 +30,7 @@ config TARGET_PHYCORE_AM62X_A53
 	bool "PHYTEC phyCORE-AM62x running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 
 config TARGET_PHYCORE_AM62X_R5
 	bool "PHYTEC phyCORE-AM62x running on R5"
@@ -45,6 +47,7 @@ config TARGET_VERDIN_AM62_A53
 	bool "Toradex Verdin AM62 running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 
 config TARGET_VERDIN_AM62_R5
 	bool "Toradex Verdin AM62 running on R5"
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 2003a530c7d..902c437d734 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -37,7 +37,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_SYS_BOOTM_LEN=0x40000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
-- 
2.39.2

