Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE4EC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398E280FD8;
	Tue, 18 Feb 2025 09:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XY+c+r7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 125A880FD0; Tue, 18 Feb 2025 09:36:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BBB807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867772; x=1771403772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h2iL9fpWKmJ3kx7OpMIBu0Z7zFYHSvyMD73loKWde9U=;
 b=XY+c+r7aZE7FeemcXfiEzS+hSBIOfDO6HSTShZYRmj3V7TQvTKd1dhIt
 Zuoql3PnPCbdj749V1sXBe0ALc1cjMlDlb/TqNrhxnh0IptTp2i9+I3La
 EQtVOOwKrRfWrk4o8nKam/fWvz0xI+V/ynaElrmfGI1KxhDwqabYsmoFL
 khL0mIt2R+EsKnrv2UYrvJi5tZgH2PmDuJttBSqN/MM6/7kAanNww5gXZ
 XukI0cTvj08G4R6Bx167/IaeJ+OzWeT3sJmrOcEAAILiHcQ9cVQ8PAbQ7
 pKF/YWlkUcnJH+90u/+xMiAwtQKdaHYRS+VooExF+eFfgcuuZP30UMJi8 A==;
X-CSE-ConnectionGUID: Ipv71VBRRWuR3d7hplYYaQ==
X-CSE-MsgGUID: kKnjlfQZTwKaAvaLWNT4hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028206"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028206"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:12 -0800
X-CSE-ConnectionGUID: l98BN5YSTr+I+4RPJUfmsA==
X-CSE-MsgGUID: QvZMqHuYRJmbanXsw9urVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237819"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:10 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 21/26] arm: armv8: Improve SPL data save and restore
 implementation
Date: Tue, 18 Feb 2025 16:35:06 +0800
Message-Id: <20250218083511.29249-22-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Introduce a new symbol in the beginning of .data section in
the common ARMv8 linker script and use that as a reference
for data save and restore.

Previously, the code would rely on calculating the start of
the .data section address via data size, however, we observed
that the data size does not really reflect the SPL mapped
addresses.

In our case, the binman_sym section size was not included in
the data size, which will result in a wrong address for the
.data start section, which prevents us from properly saving
and restoring SPL data.

This approach skips the calculation for the starting address
of the .data section, and instead just defines the beginning
address of the .data section and calling the symbol as needed,
in which we think as a simpler and much more robust method.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- Use common ARMv8 start.S script, introduce new symbol to
  preserve Agilex5 warm reset behaviour
---
 arch/arm/cpu/armv8/spl_data.c       | 13 +++++++++----
 arch/arm/cpu/armv8/u-boot-spl.lds   |  1 +
 arch/arm/mach-socfpga/spl_agilex5.c | 21 +++++++++++++++++++++
 configs/socfpga_agilex5_defconfig   |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/spl_data.c b/arch/arm/cpu/armv8/spl_data.c
index 259b49ff364..492353c93df 100644
--- a/arch/arm/cpu/armv8/spl_data.c
+++ b/arch/arm/cpu/armv8/spl_data.c
@@ -5,23 +5,28 @@
 
 #include <spl.h>
 
+char __data_start[0] __section(".__data_start");
 char __data_save_start[0] __section(".__data_save_start");
 char __data_save_end[0] __section(".__data_save_end");
 
 u32 cold_reboot_flag = 1;
 
+u32 __weak reset_flag(void)
+{
+	return 1;
+}
+
 void spl_save_restore_data(void)
 {
 	u32 data_size = __data_save_end - __data_save_start;
+	cold_reboot_flag = reset_flag();
 
 	if (cold_reboot_flag == 1) {
 		/* Save data section to data_save section */
-		memcpy(__data_save_start, __data_save_start - data_size,
-		       data_size);
+		memcpy(__data_save_start, __data_start, data_size);
 	} else {
 		/* Restore the data_save section to data section */
-		memcpy(__data_save_start - data_size, __data_save_start,
-		       data_size);
+		memcpy(__data_start, __data_save_start, data_size);
 	}
 
 	cold_reboot_flag++;
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index fed69644b55..c4f83ec9cfc 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -37,6 +37,7 @@ SECTIONS
 
 	.data : {
 		. = ALIGN(8);
+		*(.__data_start)
 		*(.data*)
 	} >.sram
 
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index c87e9ed1641..3451611082d 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -21,11 +21,32 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+u32 reset_flag(void)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 	struct udevice *dev;
 
+	/* Enable Async */
+	asm volatile("msr daifclr, #4");
+
+#ifdef CONFIG_SPL_BUILD
+	spl_save_restore_data();
+#endif
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 10686a0a7b3..61ce065a2bf 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -97,3 +97,4 @@ CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_BLOBLIST_ADDR=0x7e000
 CONFIG_HANDOFF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
-- 
2.25.1

