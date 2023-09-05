Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F227C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 10:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248DA86963;
	Tue,  5 Sep 2023 12:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mGNBYLZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D01F86967; Tue,  5 Sep 2023 12:08:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023F68693D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 12:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693908488; x=1725444488;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jNDhi0Hf/pPJURzvVN3yH1QHdsAgKRcWSSfiZVkvq9Y=;
 b=mGNBYLZPxThJHfA5P38gYIDWc1vO3B55KN31yNXn4oSMn9bqPhNdBrjA
 IK6+XNV717ziY8/YO+nrff5EaAqfWuBQ5LpFgPPMFS0FIuMPeW16DmzPu
 i42OgqwNr5LizoCg473jXVZ8Gqj2aQeI8r3WM3ac4RerMwexnOli+wZKU
 T77POqDMdQQRHfju7EMB8wqUeWK8gxXRxV7wGEmHZAXW382bPUZps90qV
 mif3wbQfnRExnbE5tkaq6kj6pL/03da7uU1g1IcPh3b+6CibehWjgH3qB
 4mhZDdl3ZnvoxC0uLYz86ZlXNXJl43M71abYwk+ygGYm5P2pmHoDFEO44 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="374146834"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; d="scan'208";a="374146834"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 03:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806555107"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; d="scan'208";a="806555107"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2023 03:06:53 -0700
From: Fei Wu <fei2.wu@intel.com>
To: rick@andestech.com, ycliang@andestech.com, bmeng.cn@gmail.com,
 sjg@chromium.org, fei2.wu@intel.com, pali@kernel.org, u-boot@lists.denx.de,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com, xypron.glpk@gmx.de
Subject: [PATCH] riscv: enable multi-range memory layout
Date: Tue,  5 Sep 2023 18:09:35 +0800
Message-Id: <20230905100935.428120-1-fei2.wu@intel.com>
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
 configs/qemu-riscv64_smode_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.34.1

