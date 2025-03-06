Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802FEC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0896F819B1;
	Thu,  6 Mar 2025 17:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QvgdO2QH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FFB80E94; Thu,  6 Mar 2025 17:05:37 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F43B805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso2604205ab.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277131; x=1741881931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKuMZ5yZowllXyI5K/LCiC5041k2FKA/KYe67rQrcKM=;
 b=QvgdO2QHCUswKsAymclmdC7Ln7ASpbPkpIrWjZzKDmGL0E4oOE2SCpatwWwZ0rdQja
 wxWp226Zpy5SK67Kd5CQxHETK5oPa83Ki5wXvVsm7g9VwfpsttW7C+6fpHBlnhG39k2n
 rswDQVWEX/kQe0xNwOFANZJHcfKKEaiJ3t8ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277131; x=1741881931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKuMZ5yZowllXyI5K/LCiC5041k2FKA/KYe67rQrcKM=;
 b=MP6LVAXjr8cxYACRmICvCvNxiRmiL6cxMNaRxtSPWnFhmYPNppE3ISY8+Yow7YCNGv
 kjf8oWY/jLAy2qakhYHOuGcuJDxxSk/FSnz+fgSGUav33CjQqGEMM1sF8Lk8rWS09OdN
 aqAkaCDJPZBCpuKx52kOINFdaopyYZEQgpl9fqoYPLKxA3MuDSKxcuf6a1ZKxrxoz/00
 dZ3Jz6yDvIxSsZtYAU6Rx0e2GEmudCZT5Vu7y2ZxaBA9PiLxcisNj+ml+NRBWFxun/vt
 FtBid1HnJ08aJaUZ6r41FpbwE0SJIV9RBIWXi9W0QWguyaEL+gOg3RAewAkUQbNTlxSY
 sotw==
X-Gm-Message-State: AOJu0YxlfO/KsJCETovKNJjmbHQdeP2qP0opHlsxZtkV+11h2IKRhHYe
 0du9hYxQBuSX7ICLhprGKg7c8ZdOCcEFBUZcc+O/blUBv0op4SKrOJnmhleUSufFTpcMJgpdWFY
 =
X-Gm-Gg: ASbGncv1/aKMhel+OlrGbmqCK2S4g60bEZzNQiZVVvjS2kLbudZdXJNAg4UNUOBkJ9m
 YkSe5y9XpP5bFxXNdkgquTkLgbloFR3OpQv7Vjp3KtUEMzfB1W+bqWWoxFS6OXmsA1PV1T+C19r
 iaPHbPQS5mfQVpDln175dWXnFm9jsLqw9oFl8Hyzjm9VAnMblbMa4n61yQawMN6ygCrCxVnEnrb
 FdLdrtAf1KiR+ydBQ2DLtq97e3iLScqC+LMdekr591PflwO3TSkgYjzfqGfGbH5/mvi61O4wUsw
 aJ4wl5k3H5Y1h0gwlWPTFAxsWgvbMK/eAF2AZ03svqGkNUuabzGgYsN7vr0GO1vvNVsxqT4vzfd
 tkmN+mw==
X-Google-Smtp-Source: AGHT+IEZYA9Iy0U+JsYPGPwt9traVbzpshuUd/8KRKCyBIiGMnrI110b/Hf463Q0iwJmyXse9S3jgg==
X-Received: by 2002:a05:6e02:18ce:b0:3d2:b766:dd9a with SMTP id
 e9e14a558f8ab-3d44181cf4amr995585ab.0.1741277131083; 
 Thu, 06 Mar 2025 08:05:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 21/47] x86: Support CPU functions in long mode
Date: Thu,  6 Mar 2025 09:03:48 -0700
Message-ID: <20250306160428.3041057-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

At present it is not possible to find out the physical-address size in
long mode, so a predefined value is used.

Update the macros to support this properly, since it is important when
programming MTRRs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Always return true from flag_is_changeable_p() on amd64

Changes in v2:
- Add new patch to support CPU functions in long mode

 arch/x86/cpu/cpu.c         | 24 ++++++++++++++++++++++++
 arch/x86/cpu/i386/cpu.c    | 23 -----------------------
 arch/x86/cpu/x86_64/cpu.c  |  5 -----
 arch/x86/include/asm/cpu.h | 20 ++++++++++++++------
 4 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index a8b21406ac0..c373b14df30 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -364,3 +364,27 @@ long locate_coreboot_table(void)
 
 	return addr;
 }
+
+static bool has_cpuid(void)
+{
+	return flag_is_changeable_p(X86_EFLAGS_ID);
+}
+
+static uint cpu_cpuid_extended_level(void)
+{
+	return cpuid_eax(0x80000000);
+}
+
+int cpu_phys_address_size(void)
+{
+	if (!has_cpuid())
+		return 32;
+
+	if (cpu_cpuid_extended_level() >= 0x80000008)
+		return cpuid_eax(0x80000008) & 0xff;
+
+	if (cpuid_edx(1) & (CPUID_FEATURE_PAE | CPUID_FEATURE_PSE36))
+		return 36;
+
+	return 32;
+}
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index b108f724c51..ee6dbeb5c48 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -35,10 +35,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define CPUID_FEATURE_PAE	BIT(6)
-#define CPUID_FEATURE_PSE36	BIT(17)
-#define CPUID_FEAURE_HTT	BIT(28)
-
 /*
  * Constructor for a conventional segment GDT (or LDT) entry
  * This is a macro so it can be used in initialisers
@@ -412,25 +408,6 @@ static void setup_identity(void)
 	}
 }
 
-static uint cpu_cpuid_extended_level(void)
-{
-	return cpuid_eax(0x80000000);
-}
-
-int cpu_phys_address_size(void)
-{
-	if (!has_cpuid())
-		return 32;
-
-	if (cpu_cpuid_extended_level() >= 0x80000008)
-		return cpuid_eax(0x80000008) & 0xff;
-
-	if (cpuid_edx(1) & (CPUID_FEATURE_PAE | CPUID_FEATURE_PSE36))
-		return 36;
-
-	return 32;
-}
-
 static void setup_mtrr(void)
 {
 	u64 mtrr_cap;
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 71bc07f872a..25ae92c702f 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -59,11 +59,6 @@ int x86_cpu_reinit_f(void)
 	return 0;
 }
 
-int cpu_phys_address_size(void)
-{
-	return CONFIG_CPU_ADDR_BITS;
-}
-
 int x86_cpu_init_f(void)
 {
 	return 0;
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index fd389d4024c..1f1b545ea50 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -58,6 +58,10 @@ enum {
 	X86_SYSCON_PUNIT,	/* Power unit */
 };
 
+#define CPUID_FEATURE_PAE	BIT(6)
+#define CPUID_FEATURE_PSE36	BIT(17)
+#define CPUID_FEAURE_HTT	BIT(28)
+
 struct cpuid_result {
 	uint32_t eax;
 	uint32_t ebx;
@@ -161,12 +165,16 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
-#if !CONFIG_IS_ENABLED(X86_64)
-
+#if CONFIG_IS_ENABLED(X86_64)
+static inline int flag_is_changeable_p(u32 flag)
+{
+	return 1;
+}
+#else
 /* Standard macro to see if a specific flag is changeable */
-static inline int flag_is_changeable_p(uint32_t flag)
+static inline int flag_is_changeable_p(u32 flag)
 {
-	uint32_t f1, f2;
+	u32 f1, f2;
 
 	asm(
 		"pushfl\n\t"
@@ -181,9 +189,9 @@ static inline int flag_is_changeable_p(uint32_t flag)
 		"popfl\n\t"
 		: "=&r" (f1), "=&r" (f2)
 		: "ir" (flag));
-	return ((f1^f2) & flag) != 0;
+	return ((f1 ^ f2) & flag) != 0;
 }
-#endif
+#endif /* X86_64 */
 
 /**
  * cpu_enable_paging_pae() - Enable PAE-paging
-- 
2.43.0

