Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACC8C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5837683291;
	Tue,  8 Jul 2025 12:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OjSg7fJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AF380194; Tue,  8 Jul 2025 12:03:53 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285118319F
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2185929f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751969030; x=1752573830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8epdEzDbBiyf+CBI6+hk1Nnm/eYfTNBr2bwLp2zmKo=;
 b=OjSg7fJ6PA9cdT2bfY7t0OdG+/mb8YbLug8U8cQgKEI7QEqC96fo1kwCrldEedYKTG
 ApQAXcjeAwkZe36z8kUgZqLdYHxKE2+xQLCSOnOd2BBBcIY/ZBYOVofLPpcyf2QblDKq
 YMtAIv1IT7fx5JYdNU7iRD9aHJGFJqBKtR5goSfmITL/7txMOzTM3evVA45vT4rH5eTi
 5aSxLgR2YMT8Uo/VYJEvaye4gKy4nF1qZuwWFz3L3JotkeNhVFq6x9qPje2VryqmFvNN
 HVyQ4Mmmw2OK29Jnf7VJsReFbStpWOfZEBRtLTAjFuL3xld4bAvJtP3Iw5DXzC1ElvkX
 Emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969030; x=1752573830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8epdEzDbBiyf+CBI6+hk1Nnm/eYfTNBr2bwLp2zmKo=;
 b=cPMErUmd80M60lJoGzwJCXU8FU17zdn42StiXhG04acd39/97TW5Ba8n0pVNAxifN/
 tB60lW505F96vySqMtBTFqAE49l3xDv4McshGWUs0jz3cSPmy4hnUBfSoB9RWGOQ6lYM
 6iiowvrJmvlxEAs9vsZ7T4mOHNReLaQo4LdjfQ6gcZJYc9iasFJl5za9AQHJJrD6+DVI
 FPTzt8dn7LU133UGscFktXmlU32lqDd9prg4lF1xmDOg5B5A2fu+rbLjKAeVvzHnoRh/
 mlf0GcPayHZdyGKUm5HvafaPrGP+hLkyKkYZDBlhPc7FbZRcXMXKQ2UfAKYcnE6/lpjx
 mrnw==
X-Gm-Message-State: AOJu0YyMOaJLR/0MSYIZKCd7k34I9GvNFg5ox0g9sdbp0hJsYtYZbxa/
 5TAiEg57K9Z9/eO+KzMjwm3lcDdlvst1SuGqt3s0CR5TkRC+Bw9+5csbUyekCx/qH+AgHyLWcA4
 L0A3ujWZIXg==
X-Gm-Gg: ASbGncvPlvD1VC5flNHFtODSI2joxDNTamrv/bseM/yGwL/ZelhF0zqJqkkTvrBKP6i
 OJrt2Le3UHBeJy5UqEoEcmi1iner6MZk9WUAlAJpL8NWF8gbMlYPal2t/Ro7FIA1eirjoRO3Qhf
 b7DcZpp+CcxKhnNIHCChRlZMH49gpsy/Zn4Ub84QUNqBSOBCxHOLRwLyKf9+0hNgEYRN0/54K/w
 6lHc2LeuP9lqiqX3rJx/dH/jYAU+SxluiqqmH/ysT20vSmR/6X3ypwMGhhCkXqxBgZyh4DsZx0D
 H06Vt12TK9/FJaTdcIipEz6OsebK2FAxyzWmdaFW9ynnWDwXLkba5VYP0LBLeWOWAdCH7CyrMsk
 VDvdk
X-Google-Smtp-Source: AGHT+IEaURR8on369XAWwiVvJ2R0SKUwMuiE3bhPQDSrPB1HzSOyQL4C5GZPMUDRW3/Ze9Ho+KVEvA==
X-Received: by 2002:a05:6000:4606:b0:3a8:6260:d321 with SMTP id
 ffacd0b85a97d-3b5dde90d43mr1775779f8f.3.1751969030329; 
 Tue, 08 Jul 2025 03:03:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fc4b:50ea:edb:b51a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm12302261f8f.83.2025.07.08.03.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:03:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 1/4] Revert "arm: asm/system.h: mrc and mcr need .arm if
 __thumb2__ is not set"
Date: Tue,  8 Jul 2025 12:02:47 +0200
Message-ID: <20250708100322.2153533-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708100322.2153533-1-jerome.forissier@linaro.org>
References: <20250708100322.2153533-1-jerome.forissier@linaro.org>
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

This reverts commit 6fe50e39508043f386fc1bd40bbc02b8a75c1940 which does
not work with LTO and for which a workaround was introduced in commit
410d59095a9f ("arm: kirkwood: fix freeze on boot").

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 arch/arm/include/asm/system.h             | 22 +++++-----------------
 arch/arm/lib/cache.c                      |  5 ++---
 arch/arm/mach-kirkwood/include/mach/cpu.h |  9 ++++-----
 3 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 4c1b81483c9..849b3d0efb7 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -428,21 +428,11 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
-#if !defined(__thumb2__)
-/*
- * We will need to switch to ARM mode (.arm) for some instructions such as
- * mrc p15 etc.
- */
-#define asm_arm_or_thumb2(insn) asm volatile(".arm\n\t" insn)
-#else
-#define asm_arm_or_thumb2(insn) asm volatile(insn)
-#endif
-
 static inline unsigned long read_mpidr(void)
 {
 	unsigned long val;
 
-	asm_arm_or_thumb2("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
 
 	return val;
 }
@@ -471,13 +461,11 @@ static inline unsigned int get_cr(void)
 	unsigned int val;
 
 	if (is_hyp())
-		asm_arm_or_thumb2("mrc p15, 4, %0, c1, c0, 0	@ get CR"
-								  : "=r" (val)
+		asm volatile("mrc p15, 4, %0, c1, c0, 0	@ get CR" : "=r" (val)
 								  :
 								  : "cc");
 	else
-		asm_arm_or_thumb2("mrc p15, 0, %0, c1, c0, 0	@ get CR"
-								  : "=r" (val)
+		asm volatile("mrc p15, 0, %0, c1, c0, 0	@ get CR" : "=r" (val)
 								  :
 								  : "cc");
 	return val;
@@ -486,11 +474,11 @@ static inline unsigned int get_cr(void)
 static inline void set_cr(unsigned int val)
 {
 	if (is_hyp())
-		asm_arm_or_thumb2("mcr p15, 4, %0, c1, c0, 0	@ set CR" :
+		asm volatile("mcr p15, 4, %0, c1, c0, 0	@ set CR" :
 								  : "r" (val)
 								  : "cc");
 	else
-		asm_arm_or_thumb2("mcr p15, 0, %0, c1, c0, 0	@ set CR" :
+		asm volatile("mcr p15, 0, %0, c1, c0, 0	@ set CR" :
 								  : "r" (val)
 								  : "cc");
 	isb();
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index ed6f15cb570..dd19bd3e4fb 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -10,7 +10,6 @@
 #include <malloc.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/system.h>
 #include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -127,8 +126,8 @@ void invalidate_l2_cache(void)
 {
 	unsigned int val = 0;
 
-	asm_arm_or_thumb2("mcr p15, 1, %0, c15, c11, 0 @ invl l2 cache"
-			  : : "r" (val) : "cc");
+	asm volatile("mcr p15, 1, %0, c15, c11, 0 @ invl l2 cache"
+		: : "r" (val) : "cc");
 	isb();
 }
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/cpu.h b/arch/arm/mach-kirkwood/include/mach/cpu.h
index dce190ddee2..9eec786fe8f 100644
--- a/arch/arm/mach-kirkwood/include/mach/cpu.h
+++ b/arch/arm/mach-kirkwood/include/mach/cpu.h
@@ -85,9 +85,8 @@ struct mbus_win {
 static inline unsigned int readfr_extra_feature_reg(void)
 {
 	unsigned int val;
-
-	asm_arm_or_thumb2("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr":"=r"
-			  (val)::"cc");
+	asm volatile ("mrc p15, 1, %0, c15, c1, 0 @ readfr exfr":"=r"
+			(val)::"cc");
 	return val;
 }
 
@@ -97,8 +96,8 @@ static inline unsigned int readfr_extra_feature_reg(void)
  */
 static inline void writefr_extra_feature_reg(unsigned int val)
 {
-	asm_arm_or_thumb2("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr"::"r"
-			  (val):"cc");
+	asm volatile ("mcr p15, 1, %0, c15, c1, 0 @ writefr exfr"::"r"
+			(val):"cc");
 	isb();
 }
 
-- 
2.43.0

