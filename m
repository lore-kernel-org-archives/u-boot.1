Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279E4D10BFA
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 14:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A155888EFD;
	Sat, 26 Oct 2024 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BDwP3s7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D28688F4A; Sat, 26 Oct 2024 16:09:13 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE5A88D13
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 16:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so192595385a.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729951744; x=1730556544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IN0TpSjoub1JC+ExxkU4X0h8PDr9JHEBVNqF04vTAAw=;
 b=BDwP3s7K+48uERIs5SCJoB02reB2+6vT0ZHNd02wRsesV2jRlD9l0MWxs8wI1V+Aw2
 V8EPYWhvQa0iWEM3IqKpHjmBaJfz+PU+L76eVQVkcstiHH/kyU0GvH4PiMuXS6oR7ovu
 ZoHDcC7duuFZ5snWLDnxA1PjXoZ0afnJlYYwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729951744; x=1730556544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IN0TpSjoub1JC+ExxkU4X0h8PDr9JHEBVNqF04vTAAw=;
 b=Z1eaB3+wsCU7OE5g0hAy1wzURo/6my4vItayzIEf+1dqHJldQ/6FkK0Cnhp+BFv75a
 WFLf7zNeKsYrwvSqfG82nP0HiM5VjRmAwpwSkeUxRqCilJcW1xJwKuzkO5eUGwx6TGU4
 5Z+fn+WqXY44BdQIxgWgGVf5+w7eQ3WUXdJi2LZ8yKiElqXfJooA7tRXX75H3gkhO3Pl
 aM7BF8fXGvo6aHRr9UytbiFhcew2cD9DuQyLy255QYYspsw2kWtT+Kf7uWBVGlzqRqD1
 MKAgzNNVGFdezkOj4rQrnzcF+KiaSF4maUJpP6SnsKeByGv6mZSflzTaYMWFmNDy1uwq
 2iTQ==
X-Gm-Message-State: AOJu0Yz2r/p0b0f9f71yw4Yr1HSmunWALipz3QBnPCtAIx3FKpdZzUMw
 qsmfN6R75wtEnPUz5f/PYN/ioVbS1/Go8XYN01soiFiWtsWHs1q5nemXB2dQH4gDj6+ghdOEZBo
 cjbA=
X-Google-Smtp-Source: AGHT+IHTgI2X0Z8+AbbDe892P+hVom693XJYZHdGvo9kA3SNDWKb/RfHHj4E1t3/4YQcuomlUrh/JQ==
X-Received: by 2002:a05:6214:5d93:b0:6c1:6e3a:6d17 with SMTP id
 6a1803df08f44-6d185674992mr53561936d6.6.1729951743748; 
 Sat, 26 Oct 2024 07:09:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2d140sm15621006d6.125.2024.10.26.07.09.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 07:09:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Remove bi_sramstart/bi_sramsize
Date: Sat, 26 Oct 2024 08:09:00 -0600
Message-ID: <20241026140900.1692591-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These fields are currently set on exactly two platforms today, and used
by only one of them. Update pic32mzdask to use CFG_SYS_SRAM* in the one
location it needs it and otherwise drop this field from the bd_info
struct.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig                       | 21 ---------------------
 api/api_platform-powerpc.c    |  1 -
 cmd/bdinfo.c                  |  4 ----
 common/board_f.c              |  7 -------
 include/asm-generic/u-boot.h  |  2 --
 include/configs/pic32mzdask.h |  5 ++++-
 6 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/Kconfig b/Kconfig
index eb55f2511d95..bd63fea2e9ae 100644
--- a/Kconfig
+++ b/Kconfig
@@ -595,27 +595,6 @@ config SYS_MEM_TOP_HIDE
 	  WARNING: Please make sure that this value is a multiple of the OS
 	  page size.
 
-config SYS_HAS_SRAM
-	bool
-	default y if TARGET_PIC32MZDASK
-	default y if TARGET_DEVKIT8000
-	help
-	  Enable this to allow support for the on board SRAM.
-	  SRAM base address is controlled by CONFIG_SYS_SRAM_BASE.
-	  SRAM size is controlled by CONFIG_SYS_SRAM_SIZE.
-
-config SYS_SRAM_BASE
-	hex
-	default 0x80000000 if TARGET_PIC32MZDASK
-	default 0x40200000 if TARGET_DEVKIT8000
-	default 0x0
-
-config SYS_SRAM_SIZE
-	hex
-	default 0x00080000 if TARGET_PIC32MZDASK
-	default 0x10000 if TARGET_DEVKIT8000
-	default 0x0
-
 config SYS_MONITOR_LEN
 	int "Maximum size in bytes reserved for U-Boot in memory"
 	default 1048576 if X86
diff --git a/api/api_platform-powerpc.c b/api/api_platform-powerpc.c
index 3a04a9f691c5..2c1ab043af65 100644
--- a/api/api_platform-powerpc.c
+++ b/api/api_platform-powerpc.c
@@ -43,7 +43,6 @@ int platform_sys_info(struct sys_info *si)
 
 	platform_set_mr(si, gd->ram_base, gd->ram_size, MR_ATTR_DRAM);
 	platform_set_mr(si, gd->bd->bi_flashstart, gd->bd->bi_flashsize, MR_ATTR_FLASH);
-	platform_set_mr(si, gd->bd->bi_sramstart, gd->bd->bi_sramsize, MR_ATTR_SRAM);
 
 	return 1;
 }
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 4c0e2adabc32..ae9e1923eacf 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -140,10 +140,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 #endif
 	bdinfo_print_num_l("boot_params", (ulong)bd->bi_boot_params);
 	print_bi_dram(bd);
-	if (IS_ENABLED(CONFIG_SYS_HAS_SRAM)) {
-		bdinfo_print_num_l("sramstart", (ulong)bd->bi_sramstart);
-		bdinfo_print_num_l("sramsize", (ulong)bd->bi_sramsize);
-	}
 	bdinfo_print_num_l("flashstart", (ulong)bd->bi_flashstart);
 	bdinfo_print_num_l("flashsize", (ulong)bd->bi_flashsize);
 	bdinfo_print_num_l("flashoffset", (ulong)bd->bi_flashoffset);
diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d0..ebc934ab8105 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -637,13 +637,6 @@ __weak int arch_setup_bdinfo(void)
 
 int setup_bdinfo(void)
 {
-	struct bd_info *bd = gd->bd;
-
-	if (IS_ENABLED(CONFIG_SYS_HAS_SRAM)) {
-		bd->bi_sramstart = CONFIG_SYS_SRAM_BASE; /* start of SRAM */
-		bd->bi_sramsize = CONFIG_SYS_SRAM_SIZE;  /* size  of SRAM */
-	}
-
 	return arch_setup_bdinfo();
 }
 
diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
index 70303acd5581..8c619c1b74a1 100644
--- a/include/asm-generic/u-boot.h
+++ b/include/asm-generic/u-boot.h
@@ -30,8 +30,6 @@ struct bd_info {
 	unsigned long	bi_flashstart;	/* start of FLASH memory */
 	unsigned long	bi_flashsize;	/* size	 of FLASH memory */
 	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
-	unsigned long	bi_sramstart;	/* start of SRAM memory */
-	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
 #ifdef CONFIG_ARM
 	unsigned long	bi_arm_freq; /* arm frequency */
 	unsigned long	bi_dsp_freq; /* dsp core frequency */
diff --git a/include/configs/pic32mzdask.h b/include/configs/pic32mzdask.h
index 0ae4fc55a97b..8de930eab543 100644
--- a/include/configs/pic32mzdask.h
+++ b/include/configs/pic32mzdask.h
@@ -19,8 +19,11 @@
  */
 /* Initial RAM for temporary stack, global data */
 #define CFG_SYS_INIT_RAM_SIZE	0x10000
+#define CFG_SYS_SRAM_BASE	0x80000000
+#define CFG_SYS_SRAM_SIZE	0x00080000
+
 #define CFG_SYS_INIT_RAM_ADDR	\
-	(CONFIG_SYS_SRAM_BASE + CONFIG_SYS_SRAM_SIZE - CFG_SYS_INIT_RAM_SIZE)
+	(CFG_SYS_SRAM_BASE + CFG_SYS_SRAM_SIZE - CFG_SYS_INIT_RAM_SIZE)
 
 /* SDRAM Configuration (for final code, data, stack, heap) */
 #define CFG_SYS_SDRAM_BASE		0x88000000
-- 
2.43.0

