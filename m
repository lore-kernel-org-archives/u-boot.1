Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D70FC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1680FD1;
	Tue, 25 Feb 2025 00:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bncAEkHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB57A81100; Tue, 25 Feb 2025 00:07:37 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9815780FD1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso43779825ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438453; x=1741043253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=bncAEkHFWKLqD2AkCCB1PZTpIWKlmL0CM4w33Wd6JUxq7waf/vMcp2AzUTXdFVmTY6
 qurzyzqqG0uYlK74gR8dDPsg33P9J3VBQWEg5vbhAoACsX6iBDwXeAW8/ETdWYQD8m91
 bddNkgi/STBtMKwalKpALwRlKcf7BrwhcVvpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438453; x=1741043253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=wtx+i2GTZb/0bcl2uIZDyDmITRnoPTPtXgeBjHSUmjg6Kgz8I4DVBYGzfxn6JkefB/
 mVyEAfiCStOSBbn+D99m8InBw/FOE/k8uPmC0IrDmeOedO2l13ZAhrpmIH3FNg/JSmzR
 He3hArmK15SFjRCQrd0VHeYWzU/0C1C4mqXC0GzUm9KyJ20PcF+bI05AUI/Fy28mV83C
 /Yxzttc/hLcjmSD0R1A0pGEb0v0oyjgCusW4LTy+/V1fEcujdmmA5GClMqSGXZZKSWn1
 jzPtREMQlMaqeRhWbPDqa2CJl2YQh1GEjqhJXq8mRdOvzSG+WM4yJ8IuuYIPqdaqiIgw
 W3Kw==
X-Gm-Message-State: AOJu0YyKVogG1JsQoyg5I45ONBPtLTk7BaX+kM10mn+LjpqDggoYwErB
 L6HjAiX8d80TK475ZJX5a0O1N9t7/qyP19un8VWjNlTA6hmvvMyZ2/AWLmfpvGSsI264u8l/AtM
 =
X-Gm-Gg: ASbGncsv2uCevXlxs9e8atxR04yrxZmWVzUSmKU6GSm9M/XCDnZr/zku9OW8u4ZL7zA
 dPI6HUHPSSek+uCHtCvdWNYd2nXaoVyCICBCnIJlpbCuLz12sxnbtp/k9PHgboGMrjlN7DSrtPW
 4tJtnkvjmu9/p/Nk5pIUe+7MO9BGtnGJH04BGOt+DDCqxvHGquC51eyOh+R8SOdxQzL2zkRaTEK
 nePiHCdtnjXFZTqy259m2ASPJa43EQ/hcJSxLS76+P4LBlci5i+fKYMmEKqMloaHTA8ewtRh6kG
 EeRreHDCKtABO4cLQ14OFYjqYIIpQb3tLbxtNpYSk5dnLjM6Z7EywobdD5qgxwc=
X-Google-Smtp-Source: AGHT+IEvtxVxusf96zLgxRurfAmq0vvqMM1afdW+4abOo5JfxTstVzdDmce7s2RCfMkZegv+R4IAMQ==
X-Received: by 2002:a05:6e02:3e06:b0:3d2:a5a0:8b02 with SMTP id
 e9e14a558f8ab-3d2cae6b894mr141364055ab.6.1740438453120; 
 Mon, 24 Feb 2025 15:07:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/44] x86: Use a simple jump into long mode
Date: Mon, 24 Feb 2025 16:06:06 -0700
Message-ID: <20250224230640.2665206-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

