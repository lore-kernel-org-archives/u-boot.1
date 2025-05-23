Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE753C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC6D835CB;
	Sat, 24 May 2025 01:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CiYzpFZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944E283409; Sat, 24 May 2025 00:59:17 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432448334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso411218b3a.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041153; x=1748645953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lKywyqGkWxxTvvjX3Idosd7dFz52wx06hZSRpcDnJ0=;
 b=CiYzpFZfIUBHlAl+lba7UYSVjt6/jJ9cws7EtgYtUcbiFtmrFh2gzoVPifN8AOR3Dv
 mzK5UZlMq6W2BJWUfwmc6S5cLpjnFrquL2MxIC+GBiiyyIvhnM5UsFgpbB8gLhLcozdL
 qm5bfsAmab2R7oaJUmBW5ZaXIyudIKllOFh9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041153; x=1748645953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lKywyqGkWxxTvvjX3Idosd7dFz52wx06hZSRpcDnJ0=;
 b=oSaxdVhZidde84DpSHiwabZNS+cL28TcEa7mWavW5ROWt+kb4DGgAvJH1PHvrZAz/o
 SbX9YfYFDTSrmksjgUTVeOHau/+ThLHIHfSNcDjIrB0OfTmqU28CkRIJovRGf5HIeh23
 4qoTxwMy/zC7uxlj+Um6WvupaNa5DfvlQ0NzuftI0gBdYUrtDsuGODc1sBPE+CaghVSq
 Mdi8kv2msNZlpStWzSmLHJU8WBVzwgptumu4wRGSz1pTYkv1LOttp2Sk92u9iRv2JS5V
 riFuMnN/aJ/HSfrCmGGpozeyuLXcLSZOOS9YyhgSFKPnehpdpDNOrd1JJGAKqkp8d/zn
 167A==
X-Gm-Message-State: AOJu0Yxir/qsAb3R3iExSWsIGuiQFnGUQhfP/M/3eY5vfRBdJc/DD2Vs
 T9dyeddMLg6p2x1L00B9t+oTb6qgyF328Bk6pX3BOnhqVCpsVuaWG0j00qF6Gg1EcRO9bNAe8cM
 Bg4U=
X-Gm-Gg: ASbGncsu7l8WzFxh/+0TGaa1iAo45CVJjRNM8MJZ5zyyw8Ga/9mTtrIwg4Mj+IezQLe
 jAaGdBYDTKpOUKBdGzci/5QxsF4EAR0Ml/5AwpkEBw0lLoWoCinBo0TuOJ6SJqdLeDRmaaNNRiT
 6nDHFdh0JHGAOgmlEw9h/deuAYlb5aAx5Wsqp5VilwE48Rn5+xoM75rfta7a6gKUU5xKTnEZph+
 P4jnv/Rc+7rfhSZlogl1piUMUgSKUCnja+JeoTdt4a7nfYsgemGc2eR0IhWXxrM+UfSOI6KWlWL
 hJPj65Yy3glMaqFJqEjR134aSE1Keo98jeNkVFTVZYwWQJMcSNVVjGFVSD8UNO4CkGIb4pojwOR
 pd07TI8colEDwyE0=
X-Google-Smtp-Source: AGHT+IFh1ZAHUwGUYg6LTdqXkuVnEA2KwaB8IQJxts+5Ym34CEYTLNztB3NEKULmHAxo0qTDyjVVhg==
X-Received: by 2002:a17:903:24a:b0:227:ac2a:1dd6 with SMTP id
 d9443c01a7336-23414f85208mr21422665ad.24.1748041153582; 
 Fri, 23 May 2025 15:59:13 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2341c34f25dsm364945ad.162.2025.05.23.15.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:13 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 17/28] coreboot: Move timestamp parsing to generic place
Date: Fri, 23 May 2025 15:58:32 -0700
Message-ID: <20250523225845.2311989-18-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Move the timestamp code out of x86/cpu/coreboot to lib/coreboot and make
it generic. This lets us migrate the timestamp table from coreboot into
U-Boot's version of boot stage timing and use it on ARM based devices.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/x86/cpu/coreboot/Makefile                      |  1 -
 arch/x86/cpu/coreboot/coreboot.c                    |  6 +-----
 arch/x86/lib/bootm.c                                |  5 ++---
 arch/x86/lib/zimage.c                               |  3 ---
 .../timestamp.h => include/coreboot_timestamp.h     |  7 -------
 lib/coreboot/Makefile                               |  1 +
 lib/coreboot/cb_sysinfo.c                           |  3 +++
 {arch/x86/cpu => lib}/coreboot/timestamp.c          | 13 ++++++++-----
 8 files changed, 15 insertions(+), 24 deletions(-)
 rename arch/x86/include/asm/arch-coreboot/timestamp.h => include/coreboot_timestamp.h (68%)
 rename {arch/x86/cpu => lib}/coreboot/timestamp.c (84%)

diff --git a/arch/x86/cpu/coreboot/Makefile b/arch/x86/cpu/coreboot/Makefile
index a6c7d0e56d50..f7ba346b83cd 100644
--- a/arch/x86/cpu/coreboot/Makefile
+++ b/arch/x86/cpu/coreboot/Makefile
@@ -20,4 +20,3 @@ else
 obj-y += sdram.o
 endif
 obj-y += coreboot.o
-obj-y += timestamp.o
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index e1dbce4f0b29..33e37376e9f4 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -6,6 +6,7 @@
  */
 
 #include <cb_sysinfo.h>
+#include <coreboot_timestamp.h>
 #include <cpu_func.h>
 #include <event.h>
 #include <fdtdec.h>
@@ -15,7 +16,6 @@
 #include <asm/io.h>
 #include <asm/msr.h>
 #include <asm/mtrr.h>
-#include <asm/arch/timestamp.h>
 #include <dm/ofnode.h>
 
 int arch_cpu_init(void)
@@ -35,8 +35,6 @@ int arch_cpu_init(void)
 	gd_set_acpi_start(map_to_sysmem(lib_sysinfo.rsdp));
 	gd_set_smbios_start(lib_sysinfo.smbios_start);
 
-	timestamp_init();
-
 	return 0;
 }
 
@@ -74,8 +72,6 @@ static void board_final_init(void)
 
 static int last_stage_init(void)
 {
-	timestamp_add_to_bootstage();
-
 	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return 0;
 
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 0827a884b1d2..f46d78946929 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -10,6 +10,8 @@
 #include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
+#include <coreboot_tables.h>
+#include <coreboot_timestamp.h>
 #include <efi.h>
 #include <hang.h>
 #include <log.h>
@@ -24,9 +26,6 @@
 #include <asm/cpu.h>
 #include <asm/byteorder.h>
 #include <asm/zimage.h>
-#ifdef CONFIG_SYS_COREBOOT
-#include <asm/arch/timestamp.h>
-#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 2ea9bcf59c27..8d40714dad0b 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -31,9 +31,6 @@
 #include <asm/bootparam.h>
 #include <asm/efi.h>
 #include <asm/global_data.h>
-#ifdef CONFIG_SYS_COREBOOT
-#include <asm/arch/timestamp.h>
-#endif
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
diff --git a/arch/x86/include/asm/arch-coreboot/timestamp.h b/include/coreboot_timestamp.h
similarity index 68%
rename from arch/x86/include/asm/arch-coreboot/timestamp.h
rename to include/coreboot_timestamp.h
index 227316975047..8f34d801037d 100644
--- a/arch/x86/include/asm/arch-coreboot/timestamp.h
+++ b/include/coreboot_timestamp.h
@@ -14,11 +14,4 @@ void timestamp_init(void);
 void timestamp_add(enum timestamp_id id, uint64_t ts_time);
 void timestamp_add_now(enum timestamp_id id);
 
-/**
- * timestamp_add_to_bootstage - Add important coreboot timestamps to bootstage
- *
- * Return: 0 if ok, -1 if no timestamps were found
- */
-int timestamp_add_to_bootstage(void);
-
 #endif
diff --git a/lib/coreboot/Makefile b/lib/coreboot/Makefile
index a0027bdfa505..c81f2eae58b9 100644
--- a/lib/coreboot/Makefile
+++ b/lib/coreboot/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO) += cb_sysinfo.o
 ifndef CONFIG_XPL_BUILD
 obj-y += sdram.o
 endif
+obj-$(CONFIG_$(XPL_)COREBOOT_SYSINFO) += timestamp.o
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 0155b72ff37e..ec9a47242e34 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -7,6 +7,7 @@
  */
 
 #include <cb_sysinfo.h>
+#include <coreboot_timestamp.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <mapmem.h>
@@ -491,6 +492,8 @@ int get_coreboot_info(struct sysinfo_t *info)
 	gd->arch.coreboot_table = addr;
 	gd->flags |= GD_FLG_SKIP_LL_INIT;
 
+	timestamp_init();
+
 	return 0;
 }
 
diff --git a/arch/x86/cpu/coreboot/timestamp.c b/lib/coreboot/timestamp.c
similarity index 84%
rename from arch/x86/cpu/coreboot/timestamp.c
rename to lib/coreboot/timestamp.c
index 18be969ccea6..192a28d7188a 100644
--- a/arch/x86/cpu/coreboot/timestamp.c
+++ b/lib/coreboot/timestamp.c
@@ -7,10 +7,12 @@
 
 #include <bootstage.h>
 #include <cb_sysinfo.h>
+#include <coreboot_tables.h>
+#include <coreboot_timestamp.h>
+#include <event.h>
 #include <errno.h>
-#include <asm/arch/timestamp.h>
-#include <asm/u-boot-x86.h>
 #include <linux/compiler.h>
+#include <time.h>
 
 void timestamp_init(void)
 {
@@ -33,10 +35,10 @@ void timestamp_add(enum timestamp_id id, uint64_t ts_time)
 
 void timestamp_add_now(enum timestamp_id id)
 {
-	timestamp_add(id, rdtsc());
+	timestamp_add(id, get_ticks());
 }
 
-int timestamp_add_to_bootstage(void)
+static int timestamp_add_to_bootstage(void)
 {
 	const struct sysinfo_t *info = cb_get_sysinfo();
 	const struct timestamp_table *ts_table = info->tstamp_table;
@@ -69,9 +71,10 @@ int timestamp_add_to_bootstage(void)
 		if (name) {
 			bootstage_add_record(0, name, BOOTSTAGEF_ALLOC,
 					     tse->entry_stamp /
-							get_tbclk_mhz());
+							(get_tbclk() / 1000000));
 		}
 	}
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, timestamp_add_to_bootstage);
-- 
Sent by a computer, using git, on the internet

