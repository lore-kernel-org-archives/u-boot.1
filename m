Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F37EDE981
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 05:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043C486C51;
	Thu, 14 Sep 2023 07:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iyTyu2uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1EC86CF0; Thu, 14 Sep 2023 07:27:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90ED586BA2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 07:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694669249; x=1726205249;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WIzRiW4ngXNb9LPBNLju9PR+WA0STMuRFDkQxNiK0N8=;
 b=iyTyu2ucCZET3Qcs52JN9bTjDefiU/gq4DEwL89IcTqicoyAqeVZocTO
 y/yTmzYwFZLXeb9YTJULGn4o24NgyOc5Jrb1e0eUEsiD8qVlfqopIE0ww
 0vPWTWnLkcHLc1LhOPaDzHDz059yG6jMWyYau30qZ3aAKOevUNowP+bI5
 q0Ffp/OrhSdEXglGOfP2oNW1gpwK0SCcrSDcr7YW2K+y4NavhnNDaM0g/
 z1AFj2iqxr/dMDGU+pSwBe7gC8WF0r/nafqLJSpiPnNP474rHS8vdYyOr
 VTQmNjmBk05BJXScWFqIunzTrgvEAXgCaQdW7SeCqlMIriE8f6/sgCiv3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369129550"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="369129550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 22:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814527080"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="814527080"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 22:27:24 -0700
From: Fei Wu <fei2.wu@intel.com>
To: xypron.glpk@gmx.de, rick@andestech.com, ycliang@andestech.com,
 bmeng.cn@gmail.com, sjg@chromium.org, pali@kernel.org,
 u-boot@lists.denx.de, andrei.warkentin@intel.com, sunilvl@ventanamicro.com
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH v2] riscv: enable multi-range memory layout
Date: Thu, 14 Sep 2023 13:30:55 +0800
Message-Id: <20230914053055.745507-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
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

In order to enable PCIe passthrough on qemu riscv, the physical memory
range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
ram_top to 4G - 1 if the gd->ram_top is above 4G in
board_get_usable_ram_top(), but that address is not backed by ram. This
patch selects the lowest range instead.

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 arch/riscv/cpu/generic/dram.c        | 2 +-
 configs/qemu-riscv64_defconfig       | 2 +-
 configs/qemu-riscv64_smode_defconfig | 2 +-
 configs/qemu-riscv64_spl_defconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
index 44e11bd56c..fb53a57b4e 100644
--- a/arch/riscv/cpu/generic/dram.c
+++ b/arch/riscv/cpu/generic/dram.c
@@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	return fdtdec_setup_mem_size_base_lowest();
 }
 
 int dram_init_banksize(void)
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index 9a8bbef192..aa55317d26 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 1d0f021ade..de08a49dab 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index bb10145e6e..66dc2a1dd9 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x800000
-CONFIG_NR_DRAM_BANKS=1
+CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
-- 
2.34.1

