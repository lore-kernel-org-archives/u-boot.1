Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C9C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68081818C7;
	Thu,  6 Mar 2025 17:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QUdwW9SC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22EE80E94; Thu,  6 Mar 2025 17:05:31 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC9BC819AA
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so68324439f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277127; x=1741881927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=QUdwW9SCgy/8YzgFWED2XmCZJEH8CVIGcp0mDnLp4GNAknvVroOqsgf89OyDMkoA2o
 uWUd+Hh5zgs2/naYauCS1yq9ffk3hQwfDocO0pB99uL38GQ4niTgM4q8b+aKDPx1Stti
 bRmFLnu4uhxcn4yGNPJdfpN9WR/vQWqei6jhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277127; x=1741881927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=NbMxBzdFUd6xp0Mm8r/FnXUzZ96CxEzvpfQhR4i/a/crzRvcnLkrl9GYAeAHKzNAgm
 X+HPC9J7GY2f7swAojKiwGusRSoy5mg7v5bcz8FHhUPqTo+DwW8p9uSvXaF/d/Qxbb72
 du3+KNXN9dw5jBmSNIHZSVSD4AjtMEIPiWYOnfKyflIHvyIaS7fYK+v+Ku/4CJokgM0N
 57FmGeoenczVE+lB993o8kWY56wer8pbDu+Sy+a8MYBjGy11FDER7HadTd9YlmP0se2V
 1oM3yQmFbxeTAqFDs5mFOVF4hI0DFA8N4gjHdkuhQkFLdgNgK7+kWKc8hnajHuZPyN+H
 5CkQ==
X-Gm-Message-State: AOJu0YwgvzG3BGMjYbcUpIeZf19z18fEPSX3nPlFkk8HOezytQZFhFq5
 rqq0RdAz6ogZukgVzsnAbnDiPw5Iw7tVnsB0byTH/1yRZEea86BrZAKhDK/qdlU+JlhKbqLTwCk
 =
X-Gm-Gg: ASbGncs2WyoWhR+i2eVvhzflfX88bMnpBb1ay7WtegnP6XuQAAPw/6whefWPSFVfuZT
 gUErlx1BraO3YPHrD8E0IvEbHBehP3noN2Am27creTXpZ4827E1T1c10kh6am8/0FfHVsO/RzVa
 YVd5Bi1zaHAxOuXdxwCCmRIM7BkBU9NMoaj1F2MGfBKDZFYdEofLHyi7yeyR178/av6wwReTTIa
 Hh0YLK+d8vT5rZQ2vnv9kRtPi1e/l0liHqdX6X6wj7IZr66oFIEbuPbR/t7CTa9WE9wsBX9UBpC
 fbb+dYiw5xjQfiyIlHXAI6iFfM7t3Yy5c5rdzLv9z0iGoxeIiwONoQ0CLilSq/1bMpYD1MgILYT
 +P6zgXQ==
X-Google-Smtp-Source: AGHT+IGZj44IRQq13ZPzC7TDMOImJyMUUOPFjZ19G87jsblWWRYLKruJfoTvvhACqEY5MLrBDznsHg==
X-Received: by 2002:a05:6602:2c15:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-85b1d059cf1mr3160339f.12.1741277126849; 
 Thu, 06 Mar 2025 08:05:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/47] x86: Use a simple jump into long mode
Date: Thu,  6 Mar 2025 09:03:46 -0700
Message-ID: <20250306160428.3041057-20-sjg@chromium.org>
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

