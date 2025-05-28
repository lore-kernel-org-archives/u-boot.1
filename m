Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A6C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB5B83A8D;
	Wed, 28 May 2025 14:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kORDZE+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58D483A98; Wed, 28 May 2025 14:33:43 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C51D8397A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso117171439f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435619; x=1749040419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gWQbfA2QmiDZTQ3Uk/c6g0T24Z+jvrEuviFCMU2l+s=;
 b=kORDZE+VC0yZy9fCBawutgRu/iT5E35Rf7e7wuasa8JvGcdGilQ9/aYbnm+huDMNrZ
 yZcnaoPHAhpz5ggmb3Kj5p8Ii9iFJPywyKgrtUdDZKkHh6r7TjbR8uiHOtDsnXz9IvOi
 Jp/azP5r10M2ecz5qMThclYDZtxt55IhhPw7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435619; x=1749040419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gWQbfA2QmiDZTQ3Uk/c6g0T24Z+jvrEuviFCMU2l+s=;
 b=xUHzuZWbjvJ/eGa3GudJg94kD5U43PhNz/1UXIkNVMyMxuQf1fqiSQKl41bUWWkh6J
 r+G6FvXZ3M7DKS0jm3lQBIpA0jYe+6UGrrLIoPVxfFg0F+yU9krsE+0WDB4Aghw0dSQU
 NLotGdm+mCDD0oRiAQKuU4uU3BQZi+FMyn09kWbucJYwLklEWx1z6tOwAkaRxF5nd555
 WYo+z+7Xye9SoEvo0HgLR/wvDySfXv7j3jHEs6tsDaz5HtlVfzzn/BFBNQc14lHGjzoB
 7zzBAyB+5qmZoCU6lo1TiKlnYH80IppXzEgZg2nF/ccAZ8QGY7IMlW8Va3njY1ghZJg1
 dU6Q==
X-Gm-Message-State: AOJu0Yw2v0ZhUpcSrK+sJwpbuEylHx6Rpdww+w2dwv0/2v/jDQ0d9t/P
 /i1VzZFo4HKbvdjrEYsHRp3xswGJtA1/CN0qCupozgkDHAGgfxyLOFze60cigO6SvCfB+aKXTxt
 VSaQoTz1/WMA=
X-Gm-Gg: ASbGncs6lcGWXpgkWQ65OFuJCw5gqhlzm469fx517GpdhHDbMf8FgH7PuAcHfDXZ6i+
 kvA695OFVz5VXNtLQljvuaD0psMCFryGiJHJKI8NcIDMJzyovimIZxPkxi8fBG0zd8Dbav2/TY/
 v5uqIvbbTHRjqs0td0E92vCIhSywyyWSPPIg1LgUA2sMp+vYRGgQz6XfDb7Gy4ttvNwrIH1AMbN
 9M8ImCM+1x0dzuW0AxFPfGp7/3CMJ5D99mPZdby6RLGrWLCComw5xFjbIQN+iRGkLPIyKAJuW9H
 dZdIQw5/3y86pUxA8rnwySylpKJB1Tp35ESFMY1Rb58S5TYIkj91bEtL1X7HoU5dle1kW7z2L8J
 rIbc5AVfQjjK8+s4WAeV8m2M=
X-Google-Smtp-Source: AGHT+IF2QsUvQxy5TF34GhTFfOXZddcsupdkXqsPbfapFdA7LIdLrxvDq/pakGFz/R2HfUOuM9M8jg==
X-Received: by 2002:a05:6e02:2513:b0:3dc:79fa:ed5b with SMTP id
 e9e14a558f8ab-3dc9b6884fbmr142382005ab.11.1748435618680; 
 Wed, 28 May 2025 05:33:38 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: [PATCH v5 12/25] passage: arm: Accept a passage from the previous
 phase
Date: Wed, 28 May 2025 06:32:14 -0600
Message-ID: <20250528063224.v5.12.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

(no changes since v4)

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

