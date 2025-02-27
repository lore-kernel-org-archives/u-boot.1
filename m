Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE49C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 18:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A8881430;
	Thu, 27 Feb 2025 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QzbPG+7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D573A81429; Thu, 27 Feb 2025 19:38:40 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF9B814B6
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 19:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso4504415ab.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740681515; x=1741286315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZESQsqTrJILHhplDr1AxRFNOxksfuFBSrkvWvlraX4w=;
 b=QzbPG+7aFpBxTdljsMsvTK+Ca1dGumSM3wZVn9q4gM4z7d4RF6A26rO7Fgwo2t0zKl
 uPc/w9ZtPrlbGcsMa2/Olv+zCdGmcs6YcCVF/bPQ5pNwFJogIWZqvEkg6RQat56j22L0
 CsQffgijBRFe3PJ3PjZ7fjIXkW1VzSFoBLbi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740681515; x=1741286315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZESQsqTrJILHhplDr1AxRFNOxksfuFBSrkvWvlraX4w=;
 b=FKQEZV0mU9ysjciLG8FMxWpglWNQwtcdYD2lg0eD9lUOUc5W5o6QHMu4inQLDRwQ32
 +GBKZityV7YGOF0lu/bEcmWFC3n9ZR1nDYBhIpICqtdPHzFCl3syCJG3cQ61VDRLTA2d
 RxL4DZSx5k+MFLXiMXg7w8JGdW07svZGe+VLue0xWtN3QppJhZ1XbdaRI1XHabiy/W/x
 IGo/TS/88iZcIYrIkCcxZF0GgGSfcEQYauEmmXdSLw6qBNq5G/9OjbltuEbysR1s4Lkv
 9BG1qLJjalgXi7Mw16dX/N+8qQVVU12tojp0kJ/HACsnQwx7bAXn+RCzA/fYDjdkAI2G
 Zudw==
X-Gm-Message-State: AOJu0YxM0khkko5r8HCc3mw8EOk7vQ1w6dv9u/+WqS5lYxl9RU0JhqZH
 y57807nZkPQRHF60ammeIyYABbPP0Veo+C4VldyGV0E8ZuSeW32G4kf6pS+f78RP4T87MsA7YHE
 =
X-Gm-Gg: ASbGncs+yOacHkS21D7tZTT5daCyTwg9Kskn+aS7DI6etefdTWq0Yb+ynn4wYaEW+4N
 l7CnmOZeQqLQmCyh+3UxkfUMVnLelfbmJ78ER59BI9gIgl0KLlMuhI1oTS5JSaWDfKp5Kc1F/d6
 pUlFdeShVJ/sQdpeogc2R53Oy0S1sNibj6CgVxBQ1iSYGykJfupDyYtWV/qHoeYoK97OcIG3DnC
 1SdCYynzxG5AmFdi/+dkWuDdxYOXe5ZrIijM4IBtIcVbRQHNY8zFmxjZhgEHU9WhL4qFYBtl3Rj
 dl21friNh15MtWVCOZwDEaLJlJ7y+i54RftL0VpOo61YJbqUxqFaVWR3wOZ+fWs=
X-Google-Smtp-Source: AGHT+IHapysw1embRyqCYo5XFEx4rDdpJuiwos6i4NBAu+F2BzRfUM8H0FMbRlSukc7PPM3gniIq/g==
X-Received: by 2002:a05:6e02:13a6:b0:3d2:b34d:a25b with SMTP id
 e9e14a558f8ab-3d3e6f3ca95mr2987185ab.16.1740681515018; 
 Thu, 27 Feb 2025 10:38:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061f797bbsm473947173.123.2025.02.27.10.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 10:38:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Gary Bisson <bisson.gary@gmail.com>, Leo <ycliang@andestech.com>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rick Chen <rick@andestech.com>
Subject: [PATCH v3 3/4] spl: Use CONFIG_VAL() to obtain the SPL stack
Date: Thu, 27 Feb 2025 11:37:56 -0700
Message-ID: <20250227183807.372875-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227183807.372875-1-sjg@chromium.org>
References: <20250227183807.372875-1-sjg@chromium.org>
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

