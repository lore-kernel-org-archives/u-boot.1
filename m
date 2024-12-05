Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F49E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7971894AB;
	Thu,  5 Dec 2024 10:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c31yb5sV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8CC89338; Thu,  5 Dec 2024 10:24:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE89892B5
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390680; x=1764926680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EVzPCcETdd4wNKE669MHKnm9JEoy+IIcbAEGlyy8CeM=;
 b=c31yb5sVirSogIsY6NJVIatHt2Dbypkg5iuVLcWksAcVT4GP5PZ0Hebv
 zCnglTpU89nW1+Q5x1tZIwfGUFkErBAZ59v1ovs3AIVCkCr3Jul09514D
 iu51oOZM/S0J49N1LAP7wV0Px+q1wgxHs5cyBtz1i2KYQRhEIC6gu+GFh
 3V0/jC4I+VDERwyd6KdMPSCm897fDthiPcqOg8uM+q9YGGMPBT5LTgP2S
 +IDMGIaa/n4bgL+7RPy2k0L5Mo6nFnvaCg85o56q/NanMvYrxoANx10wE
 O7AmOCk6nhKCwaLehWtbEU95pUyO9WnrAqumtuuiuXEKemkZIXBswl/Jc A==;
X-CSE-ConnectionGUID: j0jRaEizTdyCXf83phm2Ug==
X-CSE-MsgGUID: esmvS2SwSK+9ZbuuZcjh/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610346"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610346"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:38 -0800
X-CSE-ConnectionGUID: 0PU8QTqwR7mko4Q7ofcNbw==
X-CSE-MsgGUID: 2ekcSbnrT9GbgXTF6UJHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121998"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:32 -0800
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
Subject: [resend v2 13/19] drivers: nand: Enabled Kconfig and Makefile for
 cdns-nand
Date: Thu,  5 Dec 2024 17:23:09 +0800
Message-Id: <20241205092315.25060-14-dinesh.maniyam@intel.com>
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

Enable the Kconfig and Makefile for the
Cadence NAND driver for the agilex5 family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/Kconfig  | 9 +++++++++
 drivers/mtd/nand/raw/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 9f3f1267cb..709c85c6e5 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -207,6 +207,15 @@ config SPL_NAND_LOAD
 	def_bool y
 	depends on NAND_DAVINCI && ARCH_DAVINCI && SPL_NAND_SUPPORT
 
+config NAND_CADENCE
+	bool "Support Cadence NAND controller as a DT device"
+	depends on OF_CONTROL && DM_MTD
+	select SYS_NAND_SELF_INIT
+	imply CMD_NAND
+	help
+	  Enable the driver for NAND flash on platforms using a Cadence NAND
+	  controller as a DT device.
+
 config NAND_DENALI
 	bool
 	select SYS_NAND_SELF_INIT
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 46fead6fa4..4ad1a2037f 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_NAND_ATMEL) += atmel_nand.o
 obj-$(CONFIG_DM_NAND_ATMEL) += atmel/
 obj-$(CONFIG_NAND_ARASAN) += arasan_nfc.o
 obj-$(CONFIG_NAND_BRCMNAND) += brcmnand/
+obj-$(CONFIG_NAND_CADENCE) += cadence_nand.o
 obj-$(CONFIG_NAND_DAVINCI) += davinci_nand.o
 obj-$(CONFIG_NAND_DENALI) += denali.o
 obj-$(CONFIG_NAND_DENALI_DT) += denali_dt.o
-- 
2.19.0

