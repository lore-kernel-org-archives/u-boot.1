Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B6CC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 13:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BAC829A0;
	Fri,  4 Apr 2025 15:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dI5uZKCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191D6829C7; Fri,  4 Apr 2025 15:50:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F278B829B8
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 15:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948021a45so19506045e9.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743774656; x=1744379456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi9by1MKh50q+7xZ6MMgeVvB3qppj0ZCwaLDnpWjMIk=;
 b=dI5uZKCgXit0WQpvYpcqgwvQjB+IgCfBKAquNqDD21wnzW9By26vR8+825ZF/U5O7l
 q8+/qc8wnHJWJgG5RRTQfd11nNrazH6+ZmZVorEdYeh1cDeVHbz5YD/F74hbV8cTvVxI
 u9CnpFqaBmZ7+kTXwGRs5YaOmTK2hnJB/1eNuCJmvG0vDHNv21v7sjAQvDghYyXutOcj
 dXLSfF+FW2vRzV04hc/jIoXy4AZEnp0FFa1TFhrqoAmTk8d99NJuftBP/ZIKnT5sX2KJ
 r+pQ8MeL6g159sByGb9x/JjB8DeF+/UdoLziyRNk/PCx84wKbUNTuXjubxSF0aHbpbEw
 tmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743774656; x=1744379456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qi9by1MKh50q+7xZ6MMgeVvB3qppj0ZCwaLDnpWjMIk=;
 b=B7auBIrcPVtjjAYmtoINr+2SRZYWBY4gq+57KjZI3urbF0o8TdqpmVOKz2BtkqdS4F
 /th0GpGxBmaKkf1TcVgE+xxUwNSxqUWvwfocMyo0Ev0Rq93zKAXq1qYXrOW5/KKqzdOF
 WQaWnUtTdG/zAYvUdlUG3RG+01cQTcH4FoSnl5OUtGO8SkbRFCUwon/P9rI7IjQsKSI/
 VCLeg+wQhh26UkHbqEYFyLVAgmhdzmwQEY+L7EppSLdKDJ5OKhqZHPt+TotKcVYbICbU
 55GDAXU/D5yVkmHHiAGHaK6AW/zcHm22+Vue8pi1YYlbLKUGj4bsRHvKUcqKZ6p1y+d5
 P46Q==
X-Gm-Message-State: AOJu0YwVljJZxM7oMixZVrBFpalA/HsAhMem8WtW3iccstPEdFTyUyaH
 jnqsqsmaN6eIQoRcmcixlNFO+e7kAkJa8XWFrHV0za4O1EEbdRMCaF1XxK66roUhp5SDDX39Inx
 wFWRBSw==
X-Gm-Gg: ASbGncvv6yCd4G+/HzuEgFkKc5g9HR3VBxPFmTwByU7sepAdHCB/WjSXUyQNy++Jjoq
 7ECtcjKgyDaTSgGV4TAM90vlp0YxPvXReAbh1LSlnJzrwmEOp8U/sSOBMnirZicrLx9zhh6Go3E
 mMsqBPnZLDHyzvVZtlbPeK968hF3b4339sa2xoYIhcTqf1alqRIheDLuQFKG3847Pf51klCqOie
 NSSPpsVy+5qKLbk3j9HUBHYML7t6gWO1/XmhGmISGf6JOSyQyK+jb6Hx5mHw1LF0zXAnq950obZ
 5B6JZ5osAm8chXCA2DJyL8yzOfpKkPPJZdnWyBjToDdRzcvJ5FaOMA==
X-Google-Smtp-Source: AGHT+IHqdg9GfyzlFBNoCSEv7X3ovPIrXUrP3H+aQ5r4S1tENA2wQNG9hqvnilLKEt+aHe38WEQ7zg==
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43ed0da06f1mr25982425e9.29.1743774656234; 
 Fri, 04 Apr 2025 06:50:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:70d5:66af:ee2d:db3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm4531821f8f.34.2025.04.04.06.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:50:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 1/3] arm: asm/system.h: mrc and mcr need .arm if __thumb2__
 is not set
Date: Fri,  4 Apr 2025 15:50:35 +0200
Message-ID: <20250404135038.2134570-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404135038.2134570-1-jerome.forissier@linaro.org>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
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
index 849b3d0efb7..4c1b81483c9 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -428,11 +428,21 @@ void switch_to_hypervisor_ret(void);
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
@@ -461,11 +471,13 @@ static inline unsigned int get_cr(void)
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
@@ -474,11 +486,11 @@ static inline unsigned int get_cr(void)
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
index dd19bd3e4fb..ed6f15cb570 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/system.h>
 #include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -126,8 +127,8 @@ void invalidate_l2_cache(void)
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

