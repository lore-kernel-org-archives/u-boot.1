Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4808CF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41878935D;
	Fri, 20 Sep 2024 09:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cpVic82g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB05089357; Fri, 20 Sep 2024 09:03:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCA889335
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815801; x=1758351801;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6jEZJdZBfmJahnrvovtMiP40dOZAkk1vqYwRoIie+Yo=;
 b=cpVic82ggR0ZKde1ny0vAD1Mff/H1kMSOUuPLq/xOhqYQ95stutI9AkS
 Gpqw9VIrdRBZILGaisbFAh42ZEp9d5AJWhBxN0Yf3V4m0Jo46bVONRpLI
 XzWM+acDau++iGu1ynhNqIga0j21gK0WN5FcW+znzSn+YYzXiqXXYCcrq
 35cQfk/OHKPYoNr6XV2HxLOgIWdR6VYvVqO3uNLjs4bwj95U/cpik1BC0
 0oEpZ6tO4NMrThhwDfqIbfvDRhMc9mtivDXDqZLnFOAAfbPUogbvRhwb4
 890MVbmTvRIRw7tSwfY7aLeif/qAUk8SrvQPiS8A5TF3OBQJ9fRjAytnI A==;
X-CSE-ConnectionGUID: +elygl0WQv2oOLGGw8RrcA==
X-CSE-MsgGUID: a8eq2SJVT2GQ/5f7Yn/1dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961030"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:19 -0700
X-CSE-ConnectionGUID: owzXq8XLT0WtP+ht7wKMCQ==
X-CSE-MsgGUID: k9s8ujm7T3aoEJwCu3JrvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235037"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:17 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
Date: Fri, 20 Sep 2024 15:02:25 +0800
Message-Id: <20240920070242.20884-4-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Add a new .data section for preserving the original state of the
.data section of SoC64 SPL. This new .data section is required to
make SPL reentrant after warm reset.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/u-boot-spl-soc64.lds | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/u-boot-spl-soc64.lds

diff --git a/arch/arm/mach-socfpga/u-boot-spl-soc64.lds b/arch/arm/mach-socfpga/u-boot-spl-soc64.lds
new file mode 100644
index 00000000000..91cf8dd3139
--- /dev/null
+++ b/arch/arm/mach-socfpga/u-boot-spl-soc64.lds
@@ -0,0 +1,80 @@
+/*
+ * (C) Copyright 2013
+ * David Feng <fenghua@phytium.com.cn>
+ *
+ * (C) Copyright 2002
+ * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
+ *
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *	Aneesh V <aneesh@ti.com>
+ *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+MEMORY { .sram : ORIGIN = CONFIG_SPL_TEXT_BASE,
+		LENGTH = CONFIG_SPL_MAX_SIZE }
+MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
+		LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
+
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+OUTPUT_ARCH(aarch64)
+ENTRY(_start)
+SECTIONS
+{
+	__image_copy_start = ADDR(.text);
+	.text : {
+		. = ALIGN(8);
+		CPUDIR/start.o (.text*)
+		*(.text*)
+	} >.sram
+
+	.rodata : {
+		. = ALIGN(8);
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+	} >.sram
+
+	.data : {
+		. = ALIGN(8);
+		/* Run time .data section starting at this location */
+		__data_start = .;
+		*(.data*)
+		/* Run time .data section ending at this location */
+		__data_end = .;
+	} >.sram
+
+	. = ALIGN(8);
+	/* Preserve original .data section starting at this location */
+	__preserve_data_start = .;
+	. = __preserve_data_start + (__data_end - __data_start);
+	/* Preserve original .data section ending at this location */
+	__preserve_data_end = .;
+
+	. = ALIGN(8);
+	__u_boot_list . : {
+		KEEP(*(SORT(__u_boot_list*)));
+	} >.sram
+
+	. = ALIGN(8);
+	__image_copy_end = .;
+
+	_end = .;
+
+	_image_binary_end = .;
+
+	.bss : {
+		__bss_start = .;
+		*(.bss*)
+		. = ALIGN(8);
+		__bss_end = .;
+	} >.sdram
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu*) }
+}
-- 
2.25.1

