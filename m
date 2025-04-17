Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9654AC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F71830EB;
	Thu, 17 Apr 2025 20:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtNZmpUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B29830F1; Thu, 17 Apr 2025 20:17:06 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA550831A4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so3713485ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913818; x=1745518618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grgPOesqYNYNl4FCRYb75grxLtdquaGlHtoKo6AlrHg=;
 b=TtNZmpUP35dy5UOvzCryEGeZcsKOZu6ElPNl85ZWcSD134yVjqPJ56QvuwDE57k5Zq
 gdcsqSB99P6Rj7tzx0sdcPVr0Xgj9Yn+HutCsIcTpOPfxafYgxrGR/wPYghfPsTLWLhb
 i9BPoUbjJJar5TA+GemC788FS5FyrkYVwdG/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913818; x=1745518618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grgPOesqYNYNl4FCRYb75grxLtdquaGlHtoKo6AlrHg=;
 b=v1GBS3B0zPAzAfd0mI9Q9Hxk82baGFguyR4k3V4jykYUxgQXuqCXHa22Y83ZD/yTXd
 XFYOO5VPv/tJfiRli5OVIrnluA8/P0FqsGzTfX//nXgT2rZS9iUD3C/l4rZj86D4LyWC
 Tc2XFYDATrbNDAO0pXGojOh/cwnvLRCeLrVkJV3e9DlXyQxzGbkphhCgIEZmJkbcTLt/
 8dX+GsoJl+wE3PcPD7JQUwk3Z0g0w8th0ZK7FW7Hfc+DcIxCYCGrssLeEqsuK1ZfUTXa
 sGXl4qFqWT9VGc6l1uPrbqisEJpm85UBw6fclMv+PXs/qVFKYOYMg2xBlyrBWMT8tHhn
 w17A==
X-Gm-Message-State: AOJu0YxJ8NbzsOxtOaeDw3iarxIpfdQvibHTzouqPJ1sBgN+Cu3+zZjL
 xuVzU4mGs+3+TZZ7oTqmP4Y+OlmlbOzG9pesFXPav+e+JlD7mN2u1uFGmqnGQMygH/M197QAPJk
 =
X-Gm-Gg: ASbGnctDm0zv+SQR5h0IA5CeCfK0+jeOJXiNy9xQ4QgBFhscVHpjYmOPzy2+HRnkvFY
 DCkNydMCgx2G5TjaKYkZD7v7BM2qh5yEMTNyYWU9sNA81+ChNPQ9ZdhqckCiNPajYK8LOtfYV4C
 QOMRxT8fU5bt1I3Ox3moaEP2oXNecBtTbtu0AFidFo4aesFOLLDvAE3YpgddRROENTAnLgaiVTj
 ZFozMGNhGTKNtMZbH8TFSl29KfZXdhmLvfXq8dwQ/F9GU4qFd6F3GhsicGuJUEeAlLGAPMRvBHN
 anMyv1nQKiU9aertMLWozV5L9hiq/JyX+31oLMqTCWfOb2bIANfrB5cSyW+ZmdyGcqqNZqQo2A7
 EZg==
X-Google-Smtp-Source: AGHT+IEvIG5XwyNFQJcjqmbkOZVxV2qcQP1sjh8FPkXQpzzH67eVCbb1rdMuumWwqvvBakWuwNADKw==
X-Received: by 2002:a05:6e02:380e:b0:3d8:1d0e:5308 with SMTP id
 e9e14a558f8ab-3d88ed8eb04mr1241155ab.6.1744913818308; 
 Thu, 17 Apr 2025 11:16:58 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: [PATCH v3 10/22] passage: arm: Accept a passage from the previous
 phase
Date: Thu, 17 Apr 2025 12:15:52 -0600
Message-ID: <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

[1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

