Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64723C25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC18884CC;
	Fri, 17 May 2024 14:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N1IC6PGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 706B688495; Fri, 17 May 2024 07:28:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3073882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923689; x=1747459689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c7N/vGlZ17cmTXKaDPsULpJjelWBQvuPP2d9AsLWlvY=;
 b=N1IC6PGiWzr9eCSNwuMmUrAUWki6V6mvvUixYQAz/b39tNTA51Smb5y0
 cQeX2TerwUkd+MQcuUTYdF1lkjSkpg3nBTCDCsSCnzFroujzbBnnVGFIn
 IrIhAhZfWd3dKHumIPH0YdFQHYufLksNRG5uq4o27xwVXZo7vZqdGj9GM
 IW13tOaDm//pPkc5Cr6VwhXW6iKns7Vp9PAW96C++ct1xhMVylDDXUbV0
 +kPdVzsdklfW1greEicURKYLTp8csWRraJCtYT9WhM0SlkFT65Ve4AeDw
 WwYbs7OC6EsBPYXzn/9XiiehfBZT9mjJWVEevl0wjzMMPstY0BNNjSu7r g==;
X-CSE-ConnectionGUID: rPBo6sZDQ+eQFozNj6sf/Q==
X-CSE-MsgGUID: Z9VijCkGQsWOL6lYuSol+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929985"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929985"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:00 -0700
X-CSE-ConnectionGUID: wsoRFhzhT9WOLFA7QS8D+Q==
X-CSE-MsgGUID: 7U5AKwooSGqw5W5wH6rOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188254"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:56 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 07/16] clk: altera: Add
 clock support for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:52 +0800
Message-Id: <20240517052701.12949-8-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Teik Heng Chong <teik.heng.chong@intel.com>

Agilex7 M-series reuse the clock driver from Agilex.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/mach-socfpga/include/mach/clock_manager.h | 2 +-
 arch/arm/mach-socfpga/misc.c                       | 2 +-
 drivers/clk/altera/Makefile                        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
index 6c9d32b9dd..77d97193f5 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
@@ -26,7 +26,7 @@ int cm_set_qspi_controller_clk_hz(u32 clk_hz);
 #include <asm/arch/clock_manager_arria10.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_STRATIX10)
 #include <asm/arch/clock_manager_s10.h>
-#elif defined(CONFIG_TARGET_SOCFPGA_AGILEX)
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #include <asm/arch/clock_manager_agilex.h>
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #include <asm/arch/clock_manager_agilex5.h>
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 79f7887519..5537445e10 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -252,7 +252,7 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-#ifdef CONFIG_TARGET_SOCFPGA_AGILEX
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 	ret = socfpga_get_base_addr("intel,agilex-clkmgr",
 				    &socfpga_clkmgr_base);
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
index 61ffa4179a..858f828e53 100644
--- a/drivers/clk/altera/Makefile
+++ b/drivers/clk/altera/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += clk-agilex.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += clk-agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += clk-arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-n5x.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-mem-n5x.o
-- 
2.25.1

