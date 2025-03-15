Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00283C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55B881CE7;
	Sat, 15 Mar 2025 15:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X72lxu1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB4081DCA; Sat, 15 Mar 2025 15:27:55 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7AE81A0C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so4243585e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048873; x=1742653673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKuMZ5yZowllXyI5K/LCiC5041k2FKA/KYe67rQrcKM=;
 b=X72lxu1TNOYlsMqopgMtmRbsWT2l0v74YvNsJxpA4aB2yBL7ApHoDAAPo7/Eqsebmj
 BsTQKdkx1uesAvfFQKutXwsKr4P+pAUitixspYGYtS9OOMJnsve676vyhu7ry9upD/61
 Vj0n8mk4MM9IuZArnq722Tzua3qt3ULSiORRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048873; x=1742653673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKuMZ5yZowllXyI5K/LCiC5041k2FKA/KYe67rQrcKM=;
 b=bAl8m8pHKJslEVgUow8ZUxM8ZYx/d0N3t9o7jAjKSxvHJidItwT8Vxmx0ZlMXf3zkH
 kO5tT1V+otJ/EJh1Os/Jup8Zkd6W5cmZ83Ae3xECiGwkIHYHYUKnGXd0q3cC85TzC3kI
 JRMYFSpjT7hjrDGQ1BUYKMsNgZ/LO6U29KYlkA1yEpQJLqdMgdF48QTkpNUH/koNqr7R
 rnCrxo2AEMMoTqljFqV8IMVXlXDW7QEGJkV3wBZOqqtrEt7FRfkt8nOt3ZMsOnU45DJ8
 loVLTsxe5aeBp1h8MJ39jAGPDYUuqTMlK00n32T5vda5R7qQQb6CTGB09f3FeUbR3zdE
 8hxw==
X-Gm-Message-State: AOJu0YyrsZFhJO2PNN9VuloAg+o6j22Es3Mom/8lVbRxv8wdNDumL6Mf
 LP/7+99NaXu9tyjLUb7yMA9H3A5bsz1ldiqkHeSDFu8O108x65M04mCzYp6yvfYz9Ei613bi7wj
 3PA==
X-Gm-Gg: ASbGnctqYHjE8jdMVimjyXKipfmi6koXrU3vn8MwuCd15yrLwDBcqr91HblqwHkMcGo
 ysOGDybmhJ61teDQlXaEQTHZ/yue/Y1gGY5oKu3IzoZGBHMfF+ynEPb3pKvZJDFsYyb5vmxhMmB
 NRqyKgjDKUprRXhkz9wzUFlAS3U+7/l9AhF+0cz3UkgRjqU+l1A5g3qc1Dyemviy8P+xxFhK6ml
 On5PLJh/V8xnPvXIXCa3lbkLSKdQIJoYlFsLqkwaJhDGlPsPVPzc675YzZopRflCAb4qkw9oXdS
 6mQKRuZ+htLBPaCH/nF0Qf8SU38A1ViwGl8jwNIzaA==
X-Google-Smtp-Source: AGHT+IGleMGFQ6GgLjxjXPoWrgv89sFZMs4F4oCjqfArWjuzAry1P+j1M4EFoXEZ5UZRerSAmdwCvw==
X-Received: by 2002:a05:600c:548c:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-43d1ec825dfmr76270555e9.18.1742048872636; 
 Sat, 15 Mar 2025 07:27:52 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 21/46] x86: Support CPU functions in long mode
Date: Sat, 15 Mar 2025 14:25:41 +0000
Message-ID: <20250315142643.2600605-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

