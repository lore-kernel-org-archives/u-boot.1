Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC65C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7BC80FC9;
	Sun, 16 Feb 2025 21:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zg0h3VdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDE080FD1; Sun, 16 Feb 2025 21:45:40 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BC880FB6
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8557f4789daso18635139f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738735; x=1740343535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRijniG9KiKhHO/9ozX5moVUniax0UiIrAUpOanPOcM=;
 b=Zg0h3VdE8flYv9NWAV76+eRQiY5ZbGFVGba9kuL1k0QaIHTPGDZqBlAbTSpqiiSnvg
 UYc2Dr+EgH/jMzjCvpLkMgHmFjOPzTeJukdQLtqTsWTDwFlgw/yLQ8qZZFoDPzgZOiYO
 19RtBGVGw61dj8jVay26IPx2sbxtLi4bNItUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738735; x=1740343535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRijniG9KiKhHO/9ozX5moVUniax0UiIrAUpOanPOcM=;
 b=mWgmjPgVuzdTxAg+t9EqWuMV12Vo0h9jwZSDAGSV99xuS8QCCFoh7KrgEMlqOKs6ca
 FCkhK52/nA6HoG60RhuPMFOeHqY1AYyJGUgA6mJdzit1lXexK2AR8G4yoqCRV7geC4mq
 QHbrX4UMw7sZOWJ0L/3mcZozKZFfKY9wzLMqoU7G3qj74Obw+ya7rKJnaFk7D2FbUvj5
 5hifIVvEbGn4SD6CmjjhnYotHw26MqfrM5ySnxfAc9Ll0kvJ8KEiSwVz2MonsUwkMU7a
 gveqDg//CoHWcSYaVVAWRikSp/Qj0g84d6vIFIX6Kj++/Q81BfumabniUNKgywkETnEj
 r6Wg==
X-Gm-Message-State: AOJu0YweQdAahxcuR06Vi2002geLBHbPf4nYF0qlvd6Erc33t0cYghVK
 u1HnG4UtKJ/Oe2y7ZBuOE6suhfTyAip+9d1zrwL72LIXu8UOm7/8R4nHqOCUKqg1/3/BnddJK4M
 =
X-Gm-Gg: ASbGncsKNBg8rfzhGH0vtyS3CYh6kM5NsgFVTNqAojkP1ExY8DULllo+cG+u6IJ6brv
 wnsudWC0hpFVgY3YCuHB8ALP7uhKmUNiNvFN9G92kENzE5TQ5/+bjN6+eFIJYebvBZPeNvQXUKl
 xqq1cb1ea5B6VHhoGbOHlbt0wswqihtZqRE3WHGcXQhS5sZYmnscIZj7bwfs37nkhF540Htp688
 tECsEWs8gMXXE9cdRNvE6Ib2u8eU2/lAALcUm1b9dm9EQgy/cmt2VEYc1BqB0oqPPAWOY85zojt
 c3suBMkd0aSaXRKvgn+y39JA7ah1vsFgAJN9Zch4/Aw2xGFjSWj7
X-Google-Smtp-Source: AGHT+IHLu/R4DgQN9GFdmMOiJhsUk7hQLwWCASQ3lrUmIu60sn7H8pGLN/AX35/Hlxvcu5i1VUvqBg==
X-Received: by 2002:a05:6602:1509:b0:855:1f81:24b6 with SMTP id
 ca18e2360f4ac-8557a0b9a73mr771335339f.4.1739738735342; 
 Sun, 16 Feb 2025 12:45:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/28] x86: Support CPU functions in long mode
Date: Sun, 16 Feb 2025 13:44:04 -0700
Message-ID: <20250216204421.3560012-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to support CPU functions in long mode

 arch/x86/cpu/cpu.c         | 24 ++++++++++++++++++++++++
 arch/x86/cpu/i386/cpu.c    | 23 -----------------------
 arch/x86/cpu/x86_64/cpu.c  |  5 -----
 arch/x86/include/asm/cpu.h | 35 ++++++++++++++++++++++++++++++-----
 4 files changed, 54 insertions(+), 33 deletions(-)

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
index fd389d4024c..53f9226112a 100644
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
@@ -161,12 +165,33 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
-#if !CONFIG_IS_ENABLED(X86_64)
+#if CONFIG_IS_ENABLED(X86_64)
+/* Standard macro to see if a specific flag is changeable */
+static inline int flag_is_changeable_p(u64 flag)
+{
+	u64 f1, f2;
+
+	asm (
+		"pushfq\n\t"
+		"pushfq\n\t"
+		"popq %0\n\t"
+		"movq %0,%1\n\t"
+		"xorq %2,%0\n\t"
+		"pushq %0\n\t"
+		"popfq\n\t"
+		"pushfq\n\t"
+		"popq %0\n\t"
+		"popfq\n\t"
+		: "=&r" (f1), "=&r" (f2)
+		: "ir" (flag));
 
+	return ((f1 ^ f2) & flag) != 0;
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
@@ -181,9 +206,9 @@ static inline int flag_is_changeable_p(uint32_t flag)
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

