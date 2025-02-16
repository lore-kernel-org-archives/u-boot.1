Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90E8C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489D280FDE;
	Sun, 16 Feb 2025 21:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I+zxzYuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D9080FD5; Sun, 16 Feb 2025 21:45:34 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CBC801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso11218895ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738729; x=1740343529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=I+zxzYuMWl/9z4t8yid+iekCTY/YA2ZVfOBPsnJ5CkfIHD4YOcr/Yvz3AJ/4aJ6lGB
 BONAbtuHvysmJMVpafuDWL7gSTgmiZ36WbjfIvvLq1jEWuZaAyqIjqR2/7IcvooX69Jb
 QTcs8oargymSGVcqggE/lvw2Au6x3RjX5gNW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738729; x=1740343529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=P101UuYo5Lu89P5ILqKsrC5GwsoEP9pkRu6VuMfiVF78JyCDt09LkWuKgFrDcAbXWt
 CBoezz7spf1mqXiXkDmRgjp8ZI4ctBd1yRptCQ2lviNmR1AI7glBuddftgPdHWHals4Y
 izidaDKYrXRSk3aIUZZOfwT/KwiAKFzjFdHWZT//jfnDGzp6NllqWEjUNxl7S6vazMUf
 maSBuB15V4H5sRclE4VJJWXCfiErfwar3uMsbfYUEGuUw4az5buTHhHa5FhvLuVanYzE
 ILaXlCHnGXPWDFbdzD2I7xi2ICAmgbawPJtKCSlrN62eeq8YGOtiGi4UeuuN1NPbuVcs
 nMSQ==
X-Gm-Message-State: AOJu0YwsfgI1NJWoWTW7ODboKZ5AmiVbDZAruFTbEqr9V0u/ThDD9hVl
 LDsTg9pi1RPkGfAasegFgJ8mpD61btflfzdD8iB8XVaRUNlRWWpXWXTA/wdd6OfEYA2dQYkMbWA
 =
X-Gm-Gg: ASbGncu6FGPnsKjmjzGoxTnTAX+eL+nLe2a1tkdW36opyYge5uGc4X34vu2BE6wZ/Bd
 0x5wZTnhKzawLXazZ/cZnSXTf+1Mp088uNvs38KFG2EFdLEqQxRtiMipi9EUQAxvZT4PFQcbBTu
 SJwHy4qaC4wyFsUBUQQ2KBRIH/poE6bicJ65w3ISat64B8AW/3mkAsa/hePr/DpXTvTbABrK0kw
 0Gez+3WCh1cV8ECqS/Ob9vKMQZ4hRFu4v15ZmnANpRMr2ryQnqXEZA3AZaicVlgD7zmugZjgEXG
 P81E18qLUrnd1Aug3IsAC2xpmM9OkQFG30fli6OI+2DBHkRsVtBF
X-Google-Smtp-Source: AGHT+IFAOr2IhDWx89mRE03vEMzQCaTcc76uFgD/xLsIsTJl+k+4T9s43Bq27kOzpZjoiPm3BfDzVw==
X-Received: by 2002:a05:6e02:3103:b0:3d0:443d:a5ad with SMTP id
 e9e14a558f8ab-3d280771825mr64836755ab.2.1739738729644; 
 Sun, 16 Feb 2025 12:45:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/28] x86: Use a simple jump into long mode
Date: Sun, 16 Feb 2025 13:44:02 -0700
Message-ID: <20250216204421.3560012-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

With the 64-bit descriptor we can use a jump instruction, rather than
pushing things on the stack.

Since the processor is in 64-bit mode by this point, pop a 64-bit value
from the stack, containing the target address.

This simplifies the code slightly, in particular its use of the stack.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/call64.S | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/cpu/i386/call64.S b/arch/x86/cpu/i386/call64.S
index 3137ec17d31..c6308b92e25 100644
--- a/arch/x86/cpu/i386/call64.S
+++ b/arch/x86/cpu/i386/call64.S
@@ -22,6 +22,7 @@ cpu_call64:
 	 * ecx - target
 	 */
 	cli
+	pushl	$0		/* top 64-bits of target */
 	push	%ecx		/* arg2 = target */
 	push	%edx		/* arg1 = setup_base */
 	mov	%eax, %ebx
@@ -32,7 +33,8 @@ cpu_call64:
 	movl	%eax, %cr0
 
 	/* Enable PAE mode */
-	movl	$(X86_CR4_PAE), %eax
+	movl	%cr4, %eax
+	orl	$X86_CR4_PAE, %eax
 	movl	%eax, %cr4
 
 	/* Enable the boot page tables */
@@ -57,23 +59,18 @@ cpu_call64:
 	 */
 	pop	%esi			/* setup_base */
 
-	pushl	$(X86_GDT_ENTRY_64BIT_CS * X86_GDT_ENTRY_SIZE)
-	leal	lret_target, %eax
-	pushl	%eax
-
 	/* Enter paged protected Mode, activating Long Mode */
 	movl	%cr0, %eax
 	orl	$X86_CR0_PG, %eax
 	movl	%eax, %cr0
 
 	/* Jump from 32bit compatibility mode into 64bit mode. */
-	lret
+	ljmp	$(X86_GDT_ENTRY_64BIT_CS * X86_GDT_ENTRY_SIZE), $lret_target
 
-code64:
+.code64
 lret_target:
-	pop	%eax			/* target */
-	mov	%eax, %eax		/* Clear bits 63:32 */
-	jmp	*%eax			/* Jump to the 64-bit target */
+	pop	%rax			/* target */
+	jmp	*%rax			/* Jump to the 64-bit target */
 
 .globl call64_stub_size
 call64_stub_size:
-- 
2.43.0

