Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85629C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7037C80FDA;
	Sat, 15 Mar 2025 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jka5vv3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9562E8129F; Sat, 15 Mar 2025 15:27:52 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B89380FDA
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948021a45so6377725e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048866; x=1742653666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=jka5vv3/sZqwXmnZcu2HpuojPxCrQ8YCjC3kxGNzaPS5QDiXwqa/oii73bAZ1zhVEf
 xi/CRr9gfwtDHHOKStPoF44A7cNWxdzeyKF8xG2HdLfGf7iM2gxsTCWd0ZD1Vx864kTH
 zqMC6RHiu0hhTwNUAi/Qbibl3ntkroN7E+snk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048866; x=1742653666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=NX7QCSvJyXwdObhN4kFJNxkq/w47IlbFpr5/nVuKYmpL8fSgO3rQGJd+S7cEprrwxH
 nJY9WzjnWkTg3gdJSXQHCh2nZn4ar3Dal4OIyhT8c1SMmJiEzNonuApdDrI3nVq5w4ji
 ZN36c+92p7U1OoZx+xk8JNzXT23VfTYZTkHIrouG8EeHJknf1jdFDvDJVkw44hAzGah9
 DFDogvVtQxs9xnumqx62eBsJ8gsJhqZPJG5+pi+XVJMruly63q2PL7wSilmu0ZNeZ6qB
 0J01DfvyHLgbda8PhED8qM4h1RPgcevY07ykodtc9aKQeHvDNZBJej+2BeK2E9c9MSSP
 syqA==
X-Gm-Message-State: AOJu0YyJBNXg9p+oesMtCFw+MNOILWK55JTKUeBrKaXJrW983+2qECWw
 uX5Kk4xca/pX42BkPMD9w6o6xGRFNZm9MYCHJn02Y4S2+VkJqgQtHK3I7aAKrZ6ei2zZsISrK8P
 sjg==
X-Gm-Gg: ASbGncsY6jkbQFkayt2fHurf/Oy8/XK8OQn1dfv/KzkQMF9ITojKsgEcwt6LM6Rdhgu
 iK2cmj2V6qrjhjimxUdR/nE1RusVetSXtNu23+8J70lY0MiHvD1X2+zeVRX6QSBBaactvIeRxdC
 OcsAu/wX2rGeplJJS8DtnCs70yGRcdxJH2yKNl+uM6NEzFj74e+cdio+Piun/G8DMK1VMppHBcw
 ZlT7WCkzjt9QqlhfNgDn+s2866Pl6+xYO8CO4FXTS9sezy57bzqGBqyPezwfvIrzQCy314x3tuX
 yxNrvlxA88wON+xGZzeTTsrDe51+nROa9XtWXirCbQ==
X-Google-Smtp-Source: AGHT+IHeYxFuVoOUQDe/8RcQ9eonNqWhpfbnhU+W9S2/kJndbfkZI9z3m37ymb6zBMsB3vDJcJv1RA==
X-Received: by 2002:a05:600c:4583:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-43d1ecd034amr72799205e9.26.1742048866563; 
 Sat, 15 Mar 2025 07:27:46 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 18/46] x86: Use the same GDT when jumping to long mode
Date: Sat, 15 Mar 2025 14:25:38 +0000
Message-ID: <20250315142643.2600605-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Make use the existing GDT which now includes entries for 64-bit code.
Leave the interrupt descriptors alone. They can be tidied up once U-Boot
starts up.

With this, kvm mode works with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

(no changes since v1)

 arch/x86/cpu/i386/call64.S | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/cpu/i386/call64.S b/arch/x86/cpu/i386/call64.S
index e5a0420d1ba..3137ec17d31 100644
--- a/arch/x86/cpu/i386/call64.S
+++ b/arch/x86/cpu/i386/call64.S
@@ -7,6 +7,7 @@
  */
 
 #include <asm/msr-index.h>
+#include <asm/processor.h>
 #include <asm/processor-flags.h>
 
 .code32
@@ -30,11 +31,6 @@ cpu_call64:
 	andl	$~X86_CR0_PG, %eax
 	movl	%eax, %cr0
 
-	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	leal	gdt, %eax
-	movl	%eax, gdt+2
-	lgdt	gdt
-
 	/* Enable PAE mode */
 	movl	$(X86_CR4_PAE), %eax
 	movl	%eax, %cr4
@@ -49,12 +45,6 @@ cpu_call64:
 	btsl	$_EFER_LME, %eax
 	wrmsr
 
-	/* After gdt is loaded */
-	xorl	%eax, %eax
-	lldt	%ax
-	movl    $0x20, %eax
-	ltr	%ax
-
 	/*
 	 * Setup for the jump to 64bit mode
 	 *
@@ -67,7 +57,7 @@ cpu_call64:
 	 */
 	pop	%esi			/* setup_base */
 
-	pushl	$0x10
+	pushl	$(X86_GDT_ENTRY_64BIT_CS * X86_GDT_ENTRY_SIZE)
 	leal	lret_target, %eax
 	pushl	%eax
 
-- 
2.43.0

