Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F48DC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C66C807E4;
	Fri, 24 Jan 2025 10:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s5aDTxq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91828083F; Fri, 24 Jan 2025 10:10:48 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A638F807FE
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso19130405e9.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 01:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737709846; x=1738314646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiEYD6rNTu7ZePWiTKiGFRsTZBTRUMjnqS8+hmvC/Ps=;
 b=s5aDTxq05rvozX5IP4XKnCBxP0y7cabpMTVeq4F3gbMk/o/3k8eJe9wETyxixYOlp8
 9PxlFdA92C3/Aqc1K58/9aT2ncRZSdlzBKxlocwpyvzLHGspU77O7KrDud6MBXkVXCTi
 n+snmEuIP8zBEAqRqDLK3zvMB3311v+bjC/MfUMbBZ6GdOrqkdKwNBrZqkuntouaCSCC
 31Rvc1s1nK/dbEKKMU5jfSrkTY7IcxisAucgW9qF1rnTwEQXTB/LF7SRRQ4qiTpWxJOR
 TceRto3Gqapah1gvhIfbZ5iJbuasdVb3P9vbDYQ5SVe9Ofc3UaOWT7HhASth0RdynjmX
 EnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709846; x=1738314646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiEYD6rNTu7ZePWiTKiGFRsTZBTRUMjnqS8+hmvC/Ps=;
 b=HgwHb4DJTYWcdBeNGwSO7/9IJe+uh74jMIy5tpOM9uTub2SgqRFigPg6l+r+dC2AFJ
 UGqJ8MBwo6m6KqXg66m0zk8FBX9Fbgdym9ZjacU4BvJQu0cmHoVj6PyMhRMNOq6BAKJV
 J6bU0uIhCLivUnExZfwGDasOkooIuWPIxyNncinjqizLcJB6YDzne4J7/6FwsDAtaPty
 8l+vAgFlHeGrsUqEFEdzSu2Jqya0dwwUvPoqcnUjWWxI5wpo+OXiqb6fONh8G/DUP6vC
 0ys2v7MHiLJ9BqPyokzPJas+N4tRTVj3Oae4O5sxQKmMti+OTs3ZF4EI2JNm2satF57l
 hsFA==
X-Gm-Message-State: AOJu0YyGbZ/6Ptx2XASI/amcv6dDAKzHb8vW2umPKaMRV48vwCvnI/bd
 VLSuEh0PxG72DuWa9QH5GIrd84qqAXB0cGuUkuuH4RS/AbWwPsiktzbXqW5BjeQipn+a3OfKQMg
 bf5cCGQ==
X-Gm-Gg: ASbGnctjyNKTfkF4nbVo0U3qNcn1IecSYvzfmmDMRbc9nJeWPQLDZvwMw6qZVp+TRFU
 8ip9oqmagP06NMMy4UEuvaoNhLG69+WjN/0gleyfCZGboV6JpgBPgLlTzT6bmfjjUfY6RxQC3WL
 /EXQA0+xb55dxgtNtRGOZY/rvp7sekR5USB4I6Wi3Iodj0PzUXBKb/4UZgz9aGRjw/oaspWBNYC
 b/iH11kJgzxYbaLBy1UrxWQJhZjOP5stdn2VBCyQfr3hWQPDpF6LGF/bhug3IgH9TLTJ14j9at1
 Ue3cRp4Q7JUyXw==
X-Google-Smtp-Source: AGHT+IG14OH8pT5uKCCLofSyPU9c06ddsnEES1E03lb+EAvxMRcQvNfoX7Ev3tEDQ7dOdLY+TbFLag==
X-Received: by 2002:a05:600c:1c83:b0:434:a746:9c82 with SMTP id
 5b1f17b1804b1-438913be56bmr274722295e9.5.1737709845713; 
 Fri, 24 Jan 2025 01:10:45 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e9c0:313f:f99a:cc15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm18943385e9.39.2025.01.24.01.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:10:45 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 1/3] arm: asm/system.h: mrc and mcr need .arm if __thumb2__
 is not set
Date: Fri, 24 Jan 2025 10:10:27 +0100
Message-ID: <047259e7e911d039a54a5674ebaa6a2c75008959.1737709089.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737709089.git.jerome.forissier@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
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

The mcr and msr instructions are available in Thumb mode only if
Thumb2 is supported. Therefore, if __thumb2__ is not set, make
sure we switch to ARM mode by inserting a .arm directive in the
inline assembly.

Fixes LTO link errors with kirkwood platforms, triggered by a later
commit:

 tools/buildman/buildman -o /tmp/build -eP sheevaplug
 [...]
 {standard input}:24085: Error: selected processor does not support `mrc p15,0,r3,c1,c0,0' in Thumb mode

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/arm/include/asm/system.h             | 22 +++++++++++++++++-----
 arch/arm/lib/cache.c                      |  5 +++--
 arch/arm/mach-kirkwood/include/mach/cpu.h |  9 +++++----
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index dbf9ab43e28..6784a4f25fc 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,11 +394,21 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+#if !defined(__thumb2__)
+/*
+ * We will need to switch to ARM mode (.arm) for some instructions such as
+ * mrc p15 etc.
+ */
+#define asm_arm_or_thumb2(insn) asm volatile(".arm\n\t" insn)
+#else
+#define asm_arm_or_thumb2(insn) asm volatile(insn)
+#endif
+
 static inline unsigned long read_mpidr(void)
 {
 	unsigned long val;
 
-	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+	asm_arm_or_thumb2("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
 
 	return val;
 }
@@ -427,11 +437,13 @@ static inline unsigned int get_cr(void)
 	unsigned int val;
 
 	if (is_hyp())
-		asm volatile("mrc p15, 4, %0, c1, c0, 0	@ get CR" : "=r" (val)
+		asm_arm_or_thumb2("mrc p15, 4, %0, c1, c0, 0	@ get CR"
+								  : "=r" (val)
 								  :
 								  : "cc");
 	else
-		asm volatile("mrc p15, 0, %0, c1, c0, 0	@ get CR" : "=r" (val)
+		asm_arm_or_thumb2("mrc p15, 0, %0, c1, c0, 0	@ get CR"
+								  : "=r" (val)
 								  :
 								  : "cc");
 	return val;
@@ -440,11 +452,11 @@ static inline unsigned int get_cr(void)
 static inline void set_cr(unsigned int val)
 {
 	if (is_hyp())
-		asm volatile("mcr p15, 4, %0, c1, c0, 0	@ set CR" :
+		asm_arm_or_thumb2("mcr p15, 4, %0, c1, c0, 0	@ set CR" :
 								  : "r" (val)
 								  : "cc");
 	else
-		asm volatile("mcr p15, 0, %0, c1, c0, 0	@ set CR" :
+		asm_arm_or_thumb2("mcr p15, 0, %0, c1, c0, 0	@ set CR" :
 								  : "r" (val)
 								  : "cc");
 	isb();
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf..98e14c5c084 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/system.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -125,8 +126,8 @@ void invalidate_l2_cache(void)
 {
 	unsigned int val = 0;
 
-	asm volatile("mcr p15, 1, %0, c15, c11, 0 @ invl l2 cache"
-		: : "r" (val) : "cc");
+	asm_arm_or_thumb2("mcr p15, 1, %0, c15, c11, 0 @ invl l2 cache"
+			  : : "r" (val) : "cc");
 	isb();
 }
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/cpu.h b/arch/arm/mach-kirkwood/include/mach/cpu.h
index 9eec786fe8f..dce190ddee2 100644
--- a/arch/arm/mach-kirkwood/include/mach/cpu.h
+++ b/arch/arm/mach-kirkwood/include/mach/cpu.h
@@ -85,8 +85,9 @@ struct mbus_win {
 static inline unsigned int readfr_extra_feature_reg(void)
 {
 	unsigned int val;
-	asm volatile ("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr":"=r"
-			(val)::"cc");
+
+	asm_arm_or_thumb2("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr":"=r"
+			  (val)::"cc");
 	return val;
 }
 
@@ -96,8 +97,8 @@ static inline unsigned int readfr_extra_feature_reg(void)
  */
 static inline void writefr_extra_feature_reg(unsigned int val)
 {
-	asm volatile ("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr"::"r"
-			(val):"cc");
+	asm_arm_or_thumb2("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr"::"r"
+			  (val):"cc");
 	isb();
 }
 
-- 
2.43.0

