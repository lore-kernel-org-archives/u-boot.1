Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB84C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FEB81A0C;
	Thu,  6 Mar 2025 17:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hw8p+4qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63326819FF; Thu,  6 Mar 2025 17:05:29 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9E8187B
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85af841eeffso69167439f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277125; x=1741881925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=hw8p+4quy3P1ApGxSbmD/ER/n+Gh2GbaSY3LQMa2Cvy4IfNytgmDr/hwDuyuNWOlu6
 x9f8+eORRnmMka9Jg9WIjpDEi02EGmJp+AiaDZfId7QeAK28PjQmK75Hq4YWSoKbTOSj
 lTOfxnnuzqLSJlw4aQNltScp17ou48Ar61qbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277125; x=1741881925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=qLZ8qXp8G4n5P5oPBmlQbvhUxQce5FyZ68J4IlGo1FXunCqGdwQMhfCpUW8nxrjWpz
 dcTdG6RHuQ8V2c2/AsyWYB4I7Q5I+hMkhZ+4FZSxX7eqUtxNaNYXTKhQou3UFF0til8M
 gjwIHiMRjz9+CFj/JF1u30FS0JtpOsYKoTiHa4t7a4q/++lNfLc5KTPvJq1Dwm8oj7M3
 9gmkMwBWRLZf355/PXe68XawvsY9OxAR0qrDQTUU64mMAcD90WsTBLzHDFZmDgon+PDc
 Vy4DQ5JiJ+HkZGkQlmpXr+BqppWAzXd3B5/0Tl9+xrXa4K/xUGWPKkFqfbIZ93Yqdlm0
 /6yg==
X-Gm-Message-State: AOJu0YyNBQDQkcbfL/TKS+1GiUAxS/sOc2jECHOKwV+XUJgMXXpA4MkW
 mhrrQdTzUvt1OYOSBzVHJ2ehfb7VBxOMYma2+eCe4Sfu7X7cfzocBx963fsuQlcBR0ZKtRWjZpI
 =
X-Gm-Gg: ASbGncu4iKuBTA3srWmlhHxkda4oKh8pP9Xgavw7BbuGAWZ9NYZe5cmAqew2/pJm4gY
 0E3RLRZ0mkesW9c1T9+jSeMlLSL5IS+DMC9/HlWkw0OJ0wDaC33Ov9b9QBKcTGUzk/CM9J179El
 NdILHYq91qjA05UIczO3VEtyNar4E58rMfENtL7hS4I0fAT8T9G66wPzstp48xTJVW5RYZZnSeE
 5eActvRHjVRZo5sslBLFqhLPsIHpqu6JrotDzKNFInNMq+oTZT5cRTT4m4sh7lluTPdH36ljXQP
 /gWYpQj/da2Xs4zse3enxdc/6w9prgXJndHpHriSUeZ3C9BkD0yZpmbweki63ubu+BSrfD8yPW1
 6+IMHdA==
X-Google-Smtp-Source: AGHT+IHoIIS0K2tcs0WUfCL1NIVXtVtiwpqyWHuAckr06sMvWEEu2zixYCB7qAQNOLkgnJII+eeGeQ==
X-Received: by 2002:a05:6602:3607:b0:85a:e19c:d101 with SMTP id
 ca18e2360f4ac-85b1cfa8d7emr7174439f.6.1741277124605; 
 Thu, 06 Mar 2025 08:05:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 18/47] x86: Use the same GDT when jumping to long mode
Date: Thu,  6 Mar 2025 09:03:45 -0700
Message-ID: <20250306160428.3041057-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

