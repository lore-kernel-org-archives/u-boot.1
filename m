Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEDDC19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861D81426;
	Wed, 26 Feb 2025 23:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fu2OHouk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9A2810F2; Wed, 26 Feb 2025 23:16:33 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57DA81109
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2234e5347e2so3308885ad.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608189; x=1741212989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fci2s5lz4x1onWeKF45cxgSuxhQhS94vF4MouKoW9ds=;
 b=fu2OHouksIDFwM6MUmhgyamm/x20JB0jW85sNzt/COz8DseFEpAfvAMKjd8DRLLsxV
 bV5OLggO8O/7tgCf7JLWYzSCHMZrbHjnmkyl2+UurVfZtNOv6Av2x0GtiKYkKn7+lI4M
 b9aaSxamIvSPpuNwp3gLcIC6YgsH90HlbCz9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608189; x=1741212989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fci2s5lz4x1onWeKF45cxgSuxhQhS94vF4MouKoW9ds=;
 b=lrss49JNs4SkQAZG0t3SI8mX7S2ddBTWFFZ1Fs2oZrRTA71uu3HsLoGcHvqvZ6O3Zk
 uISjRksmgG5j034GE9dynRgrsfLC8eMVuaQzHYEE/dtFHYrzV9TPkNaVgLcah4/a/tJF
 CQLsvb7vl78NFhLb8BUBE09aMO71Mh72Aqz6WXKd114hD8yOoBYP6AOCRoV/SDFGNwxj
 zCh8bnfFGEAv7rdKDIGdr5vQQbgTQoN5z3eN3/goajWfXw2TwrQMK6zajjPq9x55rg+z
 7XocspMvq98KMlcU1PKdaru5F4UkGnzm8j6i3oX0NwEFiWmtCiRDey5XdevSmvFD7cMG
 vbHA==
X-Gm-Message-State: AOJu0Yw7Gci6R/VJfPnHKNWpunK7QeqIxxXk4kvfO+ILqUpXCXMBEWY8
 sBfjRowiaRWorFErIaqoQ337EJVMurA36Cb6uKsxF18Y5puocKqQDkABrN/qr4YF+0L7XDvdDrI
 =
X-Gm-Gg: ASbGncsKlG/TMP2Q5RCpbVZxg2qyydSCDN5VJ8pRNNii0KddbMjlo1NPKYVlKjFvzi3
 8EGCMXrWjCIzptkm76l9BdK3rkKc5TcmQlQiBlWHg2AtN5/rvG8QTCdyeGP+jX2Iybsr0r3q9OP
 BZ99X9sruJwwyYawM5lPRuYvuRayQbOPG2Ett95a6Y2eF8A/djFMwFt84LWcIyJeiHvzxAbFYZa
 XZekwiHihSNrOFVR1AEQpoRdqHDEHd/aHaqBUzEOGsg212KP3kWUTZoqCS04x2ppwwPGQUeMUg2
 WrfPDcQMXqzZhTPTOA6ZBkxB10jwETNVkUcp0n5Dz0wWeLWhCC5Ny55kvNSOPer2Hw==
X-Google-Smtp-Source: AGHT+IGxektur3sVVYh2maLvb6zbsN6gyk6TWieBUjVlodlsJ0Cmfpb3Ya4fDSdfKw27mlvHzS9aNw==
X-Received: by 2002:a05:6a20:7286:b0:1f0:e8a3:719 with SMTP id
 adf61e73a8af0-1f10ae8de07mr8022248637.30.1740608189083; 
 Wed, 26 Feb 2025 14:16:29 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-aee7df0dc9asm19174a12.77.2025.02.26.14.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:28 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 12/15] coreboot: Move timestamp parsing to generic place
Date: Wed, 26 Feb 2025 14:15:58 -0800
Message-ID: <20250226221607.1283592-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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
index a092e8a27027..4e253c10726b 100644
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
index 2eece34a073c..5e74fd46ace7 100644
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
index 0f5cb90a056e..daeebc6654e3 100644
--- a/lib/coreboot/Makefile
+++ b/lib/coreboot/Makefile
@@ -15,3 +15,4 @@ obj-y += cb_sysinfo.o
 ifndef CONFIG_XPL_BUILD
 obj-y += sdram.o
 endif
+obj-y += timestamp.o
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 7226b658c0d3..85348df4407b 100644
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

