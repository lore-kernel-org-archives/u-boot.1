Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E293ECE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73C4890D7;
	Thu, 19 Sep 2024 05:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DIxWHdNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223D2890E4; Thu, 19 Sep 2024 05:57:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E9E890D4
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718216; x=1758254216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NInivPxO5vSzvq3aLM4WUkqaiM30Tn9Yd0OoshttlQc=;
 b=DIxWHdNmRgXyg9M22A/7NmZcUkOJAi1ypPZTZdELP4mq7e5k8wUo75v4
 iBENnFurJH5LJYb3KbF8/pIe04Bj8ICrv1pZ9IbIR0v8w6DyFKJoliQlD
 O771Ae8BHjlzQGx0l+0oAeFTAOLyqi0YMS+BCS7elBHqRjZh2a5IQi6Dm
 N6FPFEsMkEVUxsBsemeLVa+7Zl5pj1FVaiKhQE5smNHmTF3cvi5L5yRDW
 rwKdGUxuCFBxWvjt3fpuA+Vnoag4spYtD3Ocp4Mj3kooBdbJTfFFYXYek
 qALC3ahAot9aFd/M74pekyZnmXKWCtTcbkcTOA2/IUd3t/m8MNTdjrrWM A==;
X-CSE-ConnectionGUID: +fSDZnfeSvenB+nXRPbQQg==
X-CSE-MsgGUID: 91pe588IR/mElXd+tRixJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178127"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178127"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:56 -0700
X-CSE-ConnectionGUID: 6OHb+eLFQ6WC+o04Tw7AXg==
X-CSE-MsgGUID: Ph/YwdJoTHathWvgEKxUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253935"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:51 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 17/19] drivers: mtd: nand: Enabled Kconfig and Makefile for
 Cadence-SPL
Date: Thu, 19 Sep 2024 11:55:10 +0800
Message-Id: <20240919035512.13854-18-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

This patch is to enable the Kconfig and Makefile for the Cadence-Nand
SPL support in agilex5 family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/Kconfig  | 7 +++++++
 drivers/mtd/nand/raw/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 709c85c6e5..a9515c7b74 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -801,6 +801,13 @@ config SPL_NAND_AM33XX_BCH
 	  so those platforms should use CONFIG_SPL_NAND_SIMPLE for enabling
 	  SPL-NAND driver with software ECC correction support.
 
+config SPL_NAND_CADENCE
+	bool "Support Cadence NAND controller for SPL"
+	depends on SPL_NAND_SUPPORT
+	help
+	  This is a small implementation of the Cadence NAND controller
+	  for use on SPL.
+
 config SPL_NAND_DENALI
 	bool "Support Denali NAND controller for SPL"
 	depends on SPL_NAND_SUPPORT
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 4ad1a2037f..58fde3272f 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -10,6 +10,7 @@ NORMAL_DRIVERS=y
 endif
 
 obj-$(CONFIG_SPL_NAND_AM33XX_BCH) += am335x_spl_bch.o
+obj-$(CONFIG_SPL_NAND_CADENCE) += cadence_spl.o
 obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
 obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
 obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
-- 
2.26.2

