Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9523C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BC682B32;
	Sat, 10 May 2025 15:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VYyTQMzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E771082B95; Sat, 10 May 2025 15:43:52 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC63E82893
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so542971366b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884629; x=1747489429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36occY8E+n/hqjaEAyyVh2DeubLNieRPSwZilYpgU3o=;
 b=VYyTQMzdUiMPA98yrHFBirso6QGbHdILuawIaQHWG4d7+8QdZhvokAKh9DUaz0heGm
 T+4jaAbch84hI2fpNoq7lD67gMnoIXYk7OcN1OJ/L1ioH7VURp6sYm+E+JUpFtR8aItf
 5N5xBN1ety7E5G+bXVpornAePDmq0LdQQbWjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884629; x=1747489429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36occY8E+n/hqjaEAyyVh2DeubLNieRPSwZilYpgU3o=;
 b=t/NbHKcyjRzQJX+vzwH6krVsSCS+tuAX57W8hbnxn3UF6eZ5ID7Ph4MonSPaBP4+yJ
 R8V3q9U2JTfPu5cwsrIng9ohcPIXzkoc5WyJtfNMv3plVi0mLjIXw5sWOnkAutJsij9M
 +z/kSsNBzUpLWhD7Ujyi4gJmt41xZYG6tCRHLPOKwirBnk1OPsZOPR0foQYJamLNNunZ
 1ai0L3XSHMFbKnNC0Kwe0o0BPY48V1icuuKnUg1EZ0pozZ28x1obtfwuuLmnR2KTJIZq
 VhAgqO1YKz9npQnFEvAWkBT4AojIIISHg9AE6LMDvb7K/UVeOrLTCAXWLb48fQIgaPhF
 +vGA==
X-Gm-Message-State: AOJu0YzX2tYNtBJZfrxFvQQIlU8zGWcCRKbQnSaER8U+COtVK7rr75aZ
 fqMGXmTxVJvhKLtDhzALqlE2wFmgqUVZN8lg7t5vHRyEPpeiMEdBdEUVYlNNSm320rRX30t9lPw
 VcxURYmCYLSxa
X-Gm-Gg: ASbGnctmeJsU7KJiJIQTEza5IeUUJ0cIte1S7uirXHddyMRL+NNBeQ2avaFTa3bdu6j
 kdImLs28izO0z0o26uVB5j9F3rGXss29R44gF5aNZ1kSs4xK4d9lXblBvaAhfreYNpbh9ATBjEn
 up0pZ4SwchBjttdBh40aa+ZPEmnC2yAO3DVZvOI6PL7C4VmydIr91hH4JHBLaQD3/cYtDfm5oF0
 xcGwc0SPqFz9yOEonyP5iY+xeaOOQbNRub5NxR0M8QT36xXDe8S9Bg9kBbS6yt7W0ApmAJ7lq/f
 zPBIrpyGMtUVaCZ90Gj2Eg92eBssFvf60VuzESLNP0ZlqlgKTBpCkzpB9VXDiUmI63yD
X-Google-Smtp-Source: AGHT+IE5KYxRupZLYrB6p/8UG3E2l881KC/sYgf+B84gtJps4d2rwZ7OrS9p4S0fUSnyR2H8KI+cZg==
X-Received: by 2002:a17:906:494e:b0:ad2:1a64:79c5 with SMTP id
 a640c23a62f3a-ad21a647a4cmr512681166b.7.1746884628579; 
 Sat, 10 May 2025 06:43:48 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: [PATCH v4 09/22] passage: arm: Accept a passage from the previous
 phase
Date: Sat, 10 May 2025 15:42:07 +0200
Message-ID: <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

Accept a bloblist and control devicetree from a previous phase in
registers 0 to 3, as documented in the Firmware Handoff
specification[1].

Note that there is currently a weak function called save_boot_params()
which happens to save the same registers as are needed for this
protocol. But it seems better to implement this feature as a first-class
citizen, if for no other reason than that many boards have their own
version of save_boot_params() which may not happen to save the required
registers. A weak function is not a good basis for an API.

[1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---
While some efforts were made to encourage Intel to adopt this
specification, this has not yet been successful. However I do intend to
use my proposed x86 handoff in U-Boot, once this series is in.

Changes in v4:
- Update commit message to indicate this can only be for ARM at present
- Update commit message to mention why save_boot_params() is not used

Changes in v3:
- Add support for aarch64 also
- Update registers to match the Firmware Handoff protocol

Changes in v2:
- Use three registers instead of two for the entry

 arch/arm/cpu/armv7/start.S | 10 +++++++++-
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 arch/arm/lib/crt0.S        |  6 ++++++
 arch/arm/lib/crt0_64.S     |  6 ++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 959251957de..81cb20987ad 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -40,6 +40,14 @@ reset:
 	/* Allow the board to save important registers */
 	b	save_boot_params
 save_boot_params_ret:
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	# Keep passage information in case it is provided
+	cmp	r0, #0
+	moveq	r6, r1		/* mach */
+	moveq	r7, r2		/* dtb */
+	moveq	r8, r3		/* bloblist */
+	movne	r6, #0
+#endif
 #ifdef CONFIG_POSITION_INDEPENDENT
 	/*
 	 * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
@@ -123,7 +131,7 @@ switch_to_hypervisor_ret:
 	bl	cpu_init_crit
 #endif
 #endif
-
+	# Note: r6-r8 are available to _main in case standard passage is used
 	bl	_main
 
 /*------------------------------------------------------------------------------*/
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 829a620faeb..75d2fd1e271 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -57,6 +57,18 @@ reset:
 	b	save_boot_params
 .globl	save_boot_params_ret
 save_boot_params_ret:
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	# Keep passage information in case it is provided
+	cmp	x2, #0
+	bne	no_passage
+	mov	x19, x1		/* mach */
+	mov	x20, x0		/* dtb */
+	mov	x21, x3		/* bloblist */
+	b	passage_done
+no_passage:
+	mov	x19, #0
+passage_done:
+#endif
 
 #if CONFIG_POSITION_INDEPENDENT && !defined(CONFIG_XPL_BUILD)
 	/* Verify that we're 4K aligned.  */
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a50dde60e8b..ab758ca900f 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -113,6 +113,12 @@ ENTRY(_main)
 	mov	r9, r0
 	bl	board_init_f_init_reserve
 
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	str	r6, [r9, #GD_PASSAGE_MACH]
+	str	r7, [r9, #GD_PASSAGE_DTB]
+	str	r8, [r9, #GD_PASSAGE_BLOBLIST]
+#endif
+
 #if defined(CONFIG_DEBUG_UART) && CONFIG_IS_ENABLED(SERIAL)
 	bl	debug_uart_init
 #endif
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 30950ddaf9b..498fe849f50 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -94,6 +94,12 @@ ENTRY(_main)
 	bl	debug_uart_init
 #endif
 
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	str	x19, [x18, #GD_PASSAGE_MACH]
+	str	x20, [x18, #GD_PASSAGE_DTB]
+	str	x21, [x18, #GD_PASSAGE_BLOBLIST]
+#endif
+
 	mov	x0, #0
 	bl	board_init_f
 
-- 
2.43.0

