Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3679BC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72483811DF;
	Fri, 28 Feb 2025 13:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E/KER1QJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C299C809D4; Fri, 28 Feb 2025 13:21:07 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7201E81111
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-852050432a8so63684039f.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740745263; x=1741350063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LY5FXtOxbSHn9cNHiB5WeNogw3j69s1Sz6PNXOlZgk=;
 b=E/KER1QJRyA1MDAn3J/UvpiA5qGk+pD9iIQA1yJPDQPa390LDqg8UlfxzIE5hzUbY5
 a8q2UWjbaopS2And/xfnKzru4m483kczgu6imeHuIVJvFAcpVRGkrDHhYUFKJmdnqyFI
 rDs67XeqlrK67TRdFld5EA9RXC4fTl7Vuxs/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745263; x=1741350063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LY5FXtOxbSHn9cNHiB5WeNogw3j69s1Sz6PNXOlZgk=;
 b=KZe/L1Xkq9KuRykXzLf08Qjq+gVUpC0DHp990ZBWG1CVC/5gQ4Uhx8X7PWwu/yhna1
 XS4JPn2GehcTg5PebTHtaxwxjjNBtqUdnjP1JCDepgZ8+9pXxwrUFAGVuN9gKSQ0qU1U
 RGt1ZqNXJwnOMN5gNa0D3Di7xP/rK0hH4KOoPNylxVH0U7rfypuLZh5uIrsyOwUD0y/O
 CLmvpItOwGfEAyWe8hwsa9uUftTXrsx6G+upLIpo2JFW6+o1k1nZNnLlIt9VyLFuqYe1
 ml2Vq7m5/nqDezDPQTTbtCnC12apS5IuMPO4k8s/Pnim3oKPf15cypqih03Un/OyV/Ku
 H8tA==
X-Gm-Message-State: AOJu0YwzuHrxEXS6Jm7FqXnnxQeaoy/VsJ4AaaY+McENN1sNrbl+aJ9x
 /vML2RjfR4ZF5MDBEIh6T562WfiIHiq72ex0HouUR/FHAj2KC5BgRAL+LtngNrMfFF2yUi4WiMw
 =
X-Gm-Gg: ASbGncsECc6cNwO7ZZxtwh2dMoKCe9X4vPrhbZuVtmgZD0CyHbKxqohv71SCZnEwZu0
 Wuk3OMdJLu+Uc3ui7XGeQOoj6ZrOA9AuKHf3s/OGLpWuQTf/JVf32nm6nzBcDQdzLQDYTRFrD52
 G/QSn9v7t6iaajaZU07VGR4SVBFrflTg6TuZZ5+NTxcsesx+mN3TbjpimOZaxCtT3UFWdCYElmb
 4B6Er3nYM157PM4fzQoliUtpe2Avovn7a/wkxp5XP50RmSWxw4qL8fdz892zdlreDtWG+TPEG6Q
 BCcKrBytiyEnkqjxf+Dw2DfUpAlz1vrL+91lOBpDgkHW7sB6VJ2RAf8BG1Z8qss=
X-Google-Smtp-Source: AGHT+IFY8ZsWrHBd3tmYir7zPjSMtVGR6g42axIh3ab0vPO3RGldD17VtgN0kPMaol4Ie1/AWs+mDw==
X-Received: by 2002:a5e:8a0a:0:b0:856:290e:6399 with SMTP id
 ca18e2360f4ac-85870ec35fbmr694564439f.3.1740745263602; 
 Fri, 28 Feb 2025 04:21:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061fa91e3sm863801173.138.2025.02.28.04.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:21:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Gary Bisson <bisson.gary@gmail.com>,
 Leo <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>
Subject: [PATCH v4 3/4] spl: Use CONFIG_VAL() to obtain the SPL stack
Date: Fri, 28 Feb 2025 05:20:25 -0700
Message-ID: <20250228122042.1277079-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228122042.1277079-1-sjg@chromium.org>
References: <20250228122042.1277079-1-sjg@chromium.org>
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

Now that we have the same option for SPL and TPL, simplify the logic for
determining the initial stack.

Note that this changes behaviour as current SPL_STACK is a fallback for
TPL. However, that was likely unintended and can be handled with Kconfig
defaults if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Fixed 'VPL' typo
- Update commit message to mention the behaviour change
- Update TPL_HAVE_INIT_STACK to drop the SPL fallback

Changes in v2:
- Add new patch to use CONFIG_VAL() to obtain the SPL stack

 arch/arm/cpu/armv7/lowlevel_init.S | 4 ++--
 arch/arm/cpu/armv7/start.S         | 4 ++--
 arch/arm/lib/crt0.S                | 6 ++----
 arch/arm/lib/crt0_64.S             | 6 ++----
 arch/riscv/cpu/start.S             | 4 ++--
 common/spl/Kconfig.tpl             | 4 ++--
 6 files changed, 12 insertions(+), 16 deletions(-)

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
index 0248606906a..a50dde60e8b 100644
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
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 421352f9396..a535b61ecd3 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -138,8 +138,8 @@ config TPL_HAVE_INIT_STACK
 	bool "TPL requires a initial, fixed, stack-pointer location"
 	help
 	  Enable if the TPL phase should not inherit its initial
-	  stack-pointer from the settings for U-Boot proper (or SPL if
-	  SPL_STACK is defined), but should set its own value.
+	  stack-pointer from the settings for U-Boot proper, but should set its
+	  own value.
 
 config TPL_STACK
 	hex "Address of the initial stack-pointer for the TPL phase"
-- 
2.43.0

