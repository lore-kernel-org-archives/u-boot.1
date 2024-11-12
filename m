Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A8D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993208942F;
	Tue, 12 Nov 2024 15:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hexA0eGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB335893C2; Tue, 12 Nov 2024 15:00:08 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8C78947A
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83aa3ced341so212293139f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420003; x=1732024803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2Z0gmtHtSovh/pZ69sAg7Nagb3NXeZnmLDGxbBwNew=;
 b=hexA0eGz4uReGTIbXMkLiwAqubDGhDc8VxkMv9yeBeVsiSAt42PRUqEQ/67nmhrN81
 1ZREvPJrQ1pV6t2hcGAZuCPjchq0mVtea6mFynIjvMnPB0zELlwp8aIBXJt8IvP4DIub
 icDowRAT58depwTbFHlha3cRaIbB4TXBYzvtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420003; x=1732024803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2Z0gmtHtSovh/pZ69sAg7Nagb3NXeZnmLDGxbBwNew=;
 b=jruwbgcXhvC7f24fTNO8R7d70GDPOV5EVVfc0D7yw6oyFsN1Gwr3zKT4MMFKb7kEuX
 mgbWSbO5YQK9UKiYyvCfQqvDCkcFQMHB2waTSTyidbZBHpWPUCy7FczjfRbYKqe/nEp4
 IDQ10ECGQBsA1sMT7wNf4tXwvm8+Y9Etwtnz65TRsIxUa1n3hwNBD1kdqGAopFSHuOzO
 j+yDgeqtI8jhm/+2j8wTJkbGL8V/6y3pySDd+XcHhyUxVs0IcYMyd4hXvEAOJGVEYhoV
 SDawekRKizk86PhzZJ+VJ90zt1Vhv4N1Rfy+0BDMxet7KbgSCkCsOhKdy3MCgCnL8y8l
 TxSA==
X-Gm-Message-State: AOJu0YyVWk0ScozgYccHBAELm+E/nvlF9xeyjJcvutibYZ0Tn3ySTl9H
 fYAA2oTWbd5JzZHhQaF48vbulduKjAUVdwnUEqTTJSicPYeYHJ01Aq5LiuO6LfdnQm+vkzJt1QI
 =
X-Google-Smtp-Source: AGHT+IGC3QitBvdJxgxUB2UrgwSI0Va9CK7+6ImnSyYG4qSiRobVx0dgaI9rVZMTPGSqZ1GjeOtL6g==
X-Received: by 2002:a05:6602:160e:b0:832:40d0:902a with SMTP id
 ca18e2360f4ac-83e032a1a31mr1539659539f.6.1731420003491; 
 Tue, 12 Nov 2024 06:00:03 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.06.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:00:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/18] x86: Use a simple jump into long mode
Date: Tue, 12 Nov 2024 06:59:11 -0700
Message-Id: <20241112135911.630586-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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
2.34.1

