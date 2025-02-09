Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D25C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAAB8091A;
	Sun,  9 Feb 2025 22:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ncJBjks/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4F880836; Sun,  9 Feb 2025 22:15:29 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B7F80A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso39531965ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135724; x=1739740524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Bl4CDzCc3iRq79lR1wzgRBIcWs0t9uZ5b6QLabADC0=;
 b=ncJBjks/t1nFV7AHtpClrKLpHhUZXtel/KeO7WT+2LupdXVFz+ZLFggX6ZIR7jgiTz
 kzUUtCUv7nLF+AyaLP4hi1Pp/flLRHCIWTtdUi8s6GR6djtu5elaUUEVdqiLw9Yhtrju
 5VJwJuDSij3iV3RyAQ2ub8yRNTnQStJgncfu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135724; x=1739740524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Bl4CDzCc3iRq79lR1wzgRBIcWs0t9uZ5b6QLabADC0=;
 b=nv3dMnxYlcDEbWP3EfzkPRmt6ikPt4JWf2iajK3ZANGDgsjaYV//Ja2gF3fzThauZ3
 pz/PSwKgpxbsXBRjD0mHzMTqWker+xw2/1i2N5Y5ORrVvn6pYpx1JI7lx7Zv6xQAnnva
 7ovC6qeYtMQfv4vf3sMAOBAgIL53WwSJlhbdko013FOd3fYSh3C5y8oslu9U8g4J/BGd
 dmR+rF94I+VQXoUHS/SdCZuL4aHzv4as8jJ8heEHmccKLPvO+E04bxTZm+LBtgSdCjB6
 I1ys5DqnwrTfMJJOeVEnpo2Neb0ZfeiG+YAMV6XW16v70AauvnGy7eLv5A97yQWfwnwA
 oD2g==
X-Gm-Message-State: AOJu0YwpfWzlFyKCY8owj7F0VtkjokxsXbvH6OGXD2X1uwgQT3WB+Bds
 wjZL5ow53KhusmCYipdlEjq6TurDiAm5rdV6iPayJCXeuUxR8TxQoFOg0tuFu7H5kSY0GnoH5yI
 =
X-Gm-Gg: ASbGnctWwK9MByCPv/f4SczeEkbOzY7M/m2A9B7UMMgTIzs7hzXIkSHVEV1COsO90Mu
 dqONXtLE48w9NWAfQojKSSrApCbglzDW/ppOSMYyxMXX+RLFIkcJ/h0qMk3hogM+Pqdh+8L9v05
 Yoe9Cunyn9YzHHfnhYZOC6G1WnJaDQ186wPfvJbRfjB/q8NC/xQttHbj+8joicnTp64hX658/q4
 cEJBzEzz+okBFq+Jo8i1xdfOjd8SEfdDd7kqO5Jmx51veEFFQlNq1JsaOw00TtcY80feaQzFe4B
 NlWoNJVyoKY6Z96Ya7W0tEbd7tWHWGNsnvnfhDFkdKEheiNpA5/l
X-Google-Smtp-Source: AGHT+IGPiRl0ZmQ1ydu5+RutWpVGli2scRnJKnPYQSYNZO6S8Si15/zHlmQs7N7J7xhfjkURBEUf8w==
X-Received: by 2002:a05:6e02:1c0e:b0:3d0:28d3:e4ba with SMTP id
 e9e14a558f8ab-3d13dfa700amr105433335ab.18.1739135724098; 
 Sun, 09 Feb 2025 13:15:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>
Subject: [PATCH v2 03/35] spl: Use CONFIG_VAL() to obtain the SPL stack
Date: Sun,  9 Feb 2025 14:14:24 -0700
Message-ID: <20250209211502.2299245-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Now that we have the same option for SPL and VPL, simplify the logic for
determining the initial stack.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add new patch to use CONFIG_VAL() to obtain the SPL stack

 arch/arm/cpu/armv7/lowlevel_init.S | 4 ++--
 arch/arm/cpu/armv7/start.S         | 4 ++--
 arch/arm/lib/crt0.S                | 6 ++----
 arch/arm/lib/crt0_64.S             | 6 ++----
 arch/riscv/cpu/start.S             | 4 ++--
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
index c2a0fe061a3..72b7b7d082c 100644
--- a/arch/arm/cpu/armv7/lowlevel_init.S
+++ b/arch/arm/cpu/armv7/lowlevel_init.S
@@ -26,8 +26,8 @@ WEAK(lowlevel_init)
 	/*
 	 * Setup a temporary stack. Global data is not available yet.
 	 */
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
-	ldr	sp, =CONFIG_SPL_STACK
+#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
+	ldr	sp, =CONFIG_VAL(STACK)
 #else
 	ldr	sp, =SYS_INIT_SP_ADDR
 #endif
diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 3394db46953..959251957de 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -279,8 +279,8 @@ ENTRY(cpu_init_cp15)
 	orr	r2, r4, r2		@ r2 has combined CPU variant + revision
 
 /* Early stack for ERRATA that needs into call C code */
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
-	ldr	r0, =(CONFIG_SPL_STACK)
+#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
+	ldr	r0, =CONFIG_VAL(STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
 #endif
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 007e89407a8..8ef18ce17e4 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -100,10 +100,8 @@ ENTRY(_main)
  * Set up initial C runtime environment and call board_init_f(0).
  */
 
-#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
-	ldr	r0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
-	ldr	r0, =(CONFIG_SPL_STACK)
+#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
+	ldr	r0, =CONFIG_VAL(STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
 #endif
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 1b6782b06ed..30950ddaf9b 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -69,10 +69,8 @@ ENTRY(_main)
 /*
  * Set up initial C runtime environment and call board_init_f(0).
  */
-#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
-	ldr	x0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
-	ldr	x0, =(CONFIG_SPL_STACK)
+#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
+	ldr	x0, =CONFIG_VAL(STACK)
 #elif defined(CONFIG_INIT_SP_RELATIVE)
 #if CONFIG_POSITION_INDEPENDENT
 	adrp	x0, __bss_start     /* x0 <- Runtime &__bss_start */
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index c8526dd82fd..7bafdfd390a 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -90,8 +90,8 @@ _start:
  * Set stackpointer in internal/ex RAM to call board_init_f
  */
 call_board_init_f:
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
-	li	t0, CONFIG_SPL_STACK
+#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
+	li	t0, CONFIG_VAL(STACK)
 #else
 	li	t0, SYS_INIT_SP_ADDR
 #endif
-- 
2.43.0

