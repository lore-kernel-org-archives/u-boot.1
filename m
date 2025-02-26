Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5D0C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC80811E0;
	Wed, 26 Feb 2025 17:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SSAZj/g+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5830C8004F; Wed, 26 Feb 2025 17:20:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADF481197
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586798; x=1772122798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L2jRVli/6GQsjEPqqhBvSsX7limjMyv8RUxWkV9iaYU=;
 b=SSAZj/g+qLzS+2kOvEnt4WPi+wB1wrxH6wCvfZQPuFYC4d9gw+xbUXaK
 k4SoLTCs6TBtW/ruR1/jWEcQE4Xohjy9r66mzCh+48urkLYXPQSQ6gPNO
 CFdZIl3fvwmpp8FsbdyCCsyS/8gTPS2fTBGx3CAL/FkwKMkbCPuhnF/OD
 q5wimB9/xlrG6OHWqaN9BMHv1gX7ku++bolXbYo6fJy3tzkaCTFUX+HKj
 zYSmlV6qOo/RHpFEjoaMIKbybksl7avRe6IxNkz6okEJfTNelYWSswOHL
 5QqmzMtkzkxzXytMuYbCuiErHrqnfAr6jgCtyd8+/TpRtS3srXAru6jxS A==;
X-CSE-ConnectionGUID: NarumpL9SyuFw1omqskP7Q==
X-CSE-MsgGUID: 0Q5jMSiDThGE5HzDyITSJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640184"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640184"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:57 -0800
X-CSE-ConnectionGUID: /M/DxpCiTB6FppxrO2vw2g==
X-CSE-MsgGUID: wuhIbm60RyKtQTP+1vI0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602809"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:53 -0800
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
Subject: [resend v3 13/19] configs: nand2_defconfig: Enable configs for nand
 boot
Date: Thu, 27 Feb 2025 00:18:27 +0800
Message-Id: <20250226161833.53689-14-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

v3:
- remove CONFIG_OF_UPSTREAM to correctly locate the dts to perform
  compilation for nand2_defconfig
---
---
 board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
 configs/socfpga_agilex5_nand2_defconfig | 32 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
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
index 0000000000..37f40d6786
--- /dev/null
+++ b/configs/socfpga_agilex5_nand2_defconfig
@@ -0,0 +1,32 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
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

