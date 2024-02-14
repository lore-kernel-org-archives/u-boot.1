Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC1BC48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835E487EBD;
	Wed, 14 Feb 2024 17:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ETIXmIMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E915E87E30; Wed, 14 Feb 2024 17:30:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F38B87E22
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUANj101855;
 Wed, 14 Feb 2024 10:30:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928210;
 bh=IkN7Fe2PnCpmumBJXFySA8ScZCziWdz+KxGEbwCLXEA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ETIXmIMyEUX/6WnT09mE9BJraxwYuwsV1JeoEyzKSWeMSHY8MDgPRIFeONO+5jSRs
 idEGvPZbPI43R8Bac0Gpr3kk5ILWTE2+NbKxnLKVgvaxRV5p/qedM6GZ8shzhde7Mb
 z7QSB4Yp2Ck3E9nTi5MidOGzQ+iH/zt7zBBRgegA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUAZV049397
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:10 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:10 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9rs014388;
 Wed, 14 Feb 2024 10:30:10 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
Date: Wed, 14 Feb 2024 10:30:04 -0600
Message-ID: <20240214163009.983034-2-afd@ti.com>
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

There is a default ATF load address that is used for devices that have
ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
of having to override the address in every defconfig, make add a
default for these ATF in DRAM devices.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Kconfig               | 5 +++--
 configs/am62ax_evm_a53_defconfig       | 1 -
 configs/am62x_beagleplay_a53_defconfig | 1 -
 configs/am62x_evm_a53_defconfig        | 1 -
 configs/phycore_am62x_a53_defconfig    | 1 -
 configs/verdin-am62_a53_defconfig      | 1 -
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 03898424c95..0bd3f9fa12d 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -123,10 +123,11 @@ config SYS_K3_SPL_ATF
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
+	default 0x9e780000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
 	default 0x70000000
 	help
-	  The load address for the ATF image. This value defaults to 0x70000000
-	  if not provided in the board defconfig file.
+	  The load address for the ATF image. This value is used to build the
+	  FIT image header that places ATF in memory where it will run.
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 38083586a3e..03b2dea7d51 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM62A7=y
-CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
 CONFIG_TARGET_AM62A7_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 0be20045a97..122c1ba9299 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
-CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
 CONFIG_TARGET_AM625_A53_BEAGLEPLAY=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 457931faf21..e29df6ec523 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
-CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
 CONFIG_TARGET_AM625_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 2d5d906a9d7..5ba08440268 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
-CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
 CONFIG_TARGET_PHYCORE_AM62X_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 956e3a1ad75..2003a530c7d 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -8,7 +8,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
-CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
 CONFIG_TARGET_VERDIN_AM62_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
-- 
2.39.2

