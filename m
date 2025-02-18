Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DBFC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7C380C72;
	Tue, 18 Feb 2025 09:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HmdrDcEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71A7809A4; Tue, 18 Feb 2025 09:36:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0BC80FBA
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867759; x=1771403759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SUJUAKpDIvTi6IcCvsFOvGrlj2qFjnO0I/RNbqcA6Ak=;
 b=HmdrDcEyWSpI/0XzAiUY0nRQeKl5B901JZDdhOvymSp4lQv9bQxqkNaQ
 pKdNa8nsvwLde2bn7Lpkw2empMk+naD2mqR+Y/fCi8+bEUuagYHGiB2AP
 mKO9P0cKtSmw+icvSPNGbeFLtjXu+SNjywvwrcqAbj7RJeofT1elesl1q
 nRkx6gCPoG56ElpxJX5I1NXVUy95hM8ON5TUOvrmXTqxSqD/qOAkKUNe+
 2uRxVdazvIYHqctSDrUGZuzSHaHqrwhESKLkTkgwImawMGNwZ1T5BdT9V
 COG9weFTmnSq/x7YiNiSTU497s0i0rFThYvqFng1AanMfxKP63aMnAvcZ Q==;
X-CSE-ConnectionGUID: iOyUZl60RZSa5H+doSQngQ==
X-CSE-MsgGUID: DAEj1VjTS1eE5r8WYapXmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028174"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:58 -0800
X-CSE-ConnectionGUID: ITHVVa3OR7+q4gyl3hjFfw==
X-CSE-MsgGUID: tb1gwLwwSKWz8XsQA6ZNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237765"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:56 -0800
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
Subject: [PATCH v2 16/26] arm: socfpga: Export board ID as U-Boot environment
Date: Tue, 18 Feb 2025 16:35:01 +0800
Message-Id: <20250218083511.29249-17-alif.zakuan.yuslaimi@intel.com>
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

Board ID is exported as environment variable for use to boot Linux with FIT
configuration.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- use env_set_ulong() instead of env_set()
---
 arch/arm/mach-socfpga/board.c              |  1 +
 arch/arm/mach-socfpga/include/mach/board.h | 11 +++++++++++
 arch/arm/mach-socfpga/misc_soc64.c         |  6 ++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/board.h

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 24a15f7903f..d07b3fc3618 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -6,6 +6,7 @@
  */
 
 #include <config.h>
+#include <asm/arch/board.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
diff --git a/arch/arm/mach-socfpga/include/mach/board.h b/arch/arm/mach-socfpga/include/mach/board.h
new file mode 100644
index 00000000000..2c3127e629f
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/board.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#ifndef BOARD_H_
+#define BOARD_H_
+
+u8 socfpga_get_board_id(void);
+
+#endif /* _BOARD_H_ */
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index 573a8f79cae..793b8b8e390 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -6,6 +6,7 @@
  */
 
 #include <altera.h>
+#include <asm/arch/board.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
@@ -57,10 +58,15 @@ int print_cpuinfo(void)
 int arch_misc_init(void)
 {
 	char qspi_string[13];
+	unsigned long id;
 
 	sprintf(qspi_string, "<0x%08x>", cm_get_qspi_controller_clk_hz());
 	env_set("qspi_clock", qspi_string);
 
+	/* Export board_id as environment variable */
+	id = socfpga_get_board_id();
+	env_set_ulong("board_id", id);
+
 	return 0;
 }
 #endif
-- 
2.25.1

