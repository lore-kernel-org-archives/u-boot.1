Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80F3E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E7689282;
	Thu,  5 Dec 2024 10:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AsV9xffm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9678870D; Thu,  5 Dec 2024 10:24:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588FE894A3
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390683; x=1764926683;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DQDs0BjuLdDaXgLGg41GJY/mvM6b/YR24aI/IEKATUo=;
 b=AsV9xffmqs8u0vGo2FP7AYmaNnPlSp8hkbvZDujXB/4po9z1gmayvaAH
 bZC2vxRcPv9sA7TLVanNEKlNXRQ8/Nb4Bhi52UbdTGBvDtGRwmHYU6x+B
 oLbyCPfglkl/zOdQW3Q726tFJPwwQRmbe12YT1nUGf2fV8pCmLnNPj1uq
 M8CRyhXyptAJ2WV0b1Yvdnxz2+k4gsrOk1cxO2IMKW/gEZJBtrtDnxBlM
 tIHUpeTnL/VL2YJcTtcfNTuOAk0Q5Z/DNOil55PpNQLEBcJTH/1MKHvtT
 wgWNT9ix0vWIIx78WurbdUmBj2LRT6qafHxKeWTEXzMww2YPzAhNmw8k5 w==;
X-CSE-ConnectionGUID: ow1KoxdtSuS8Op2loFoPyA==
X-CSE-MsgGUID: ydS6kXfZRjOR1FsorfiUsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610365"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:43 -0800
X-CSE-ConnectionGUID: UhB4ZlUlRyGq4UeU5TYobQ==
X-CSE-MsgGUID: il+ZkpzMR1mniIqyPfmBeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122026"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:38 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v2 14/19] configs: nand2_defconfig: Enable configs for nand
 boot
Date: Thu,  5 Dec 2024 17:23:10 +0800
Message-Id: <20241205092315.25060-15-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Enable configs for nand boot.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
- using #include mechanism to keep track of the variant
- add maintainer
---
---
 board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
 configs/socfpga_agilex5_nand2_defconfig | 33 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig

diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index b696f788c8..30d8815d20 100644
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -2,7 +2,9 @@ SOCFPGA BOARD
 M:	Tien Fong Chee <tien.fong.chee@intel.com>
 M:	Teik Heng Chong <teik.heng.chong@intel.com>
 M:	Jit Loon Lim <jit.loon.lim@intel.com>
+M:	Dinesh Maniyam <dinesh.maniyam@intel.com>
 S:	Maintained
 F:	board/intel/agilex5-socdk/
 F:	include/configs/socfpga_agilex5_socdk.h
 F:	configs/socfpga_agilex5_defconfig
+F:	configs/socfpga_agilex5_nand2_defconfig
diff --git a/configs/socfpga_agilex5_nand2_defconfig b/configs/socfpga_agilex5_nand2_defconfig
new file mode 100644
index 0000000000..3bfe6270fd
--- /dev/null
+++ b/configs/socfpga_agilex5_nand2_defconfig
@@ -0,0 +1,33 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
+CONFIG_OF_UPSTREAM=y
+CONFIG_BOOTARGS="earlycon panic=-1 root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1"
+CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=y
+CONFIG_PHY_CADENCE_COMBOPHY=n
+CONFIG_SPL_PHY_CADENCE_COMBOPHY=n
+# CONFIG_MMC_DW is not set
+CONFIG_SPL_MTD=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_MTDIDS_DEFAULT="nand0=10b80000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=10b80000.nand.0:2m(u-boot),-(root)"
+CONFIG_CMD_UBIFS=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_LIMIT=20
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
+CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x100000
+CONFIG_UBI_SILENCE_MSG=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_CADENCE=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_FRAMEWORK=y
+CONFIG_SPL_NAND_CADENCE=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
+CONFIG_SYS_NAND_PAGE_SIZE=0x800
-- 
2.19.0

