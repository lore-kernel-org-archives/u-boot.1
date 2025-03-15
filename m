Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9946BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C278281D0B;
	Sat, 15 Mar 2025 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UF8TUhC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EC180FDA; Sat, 15 Mar 2025 15:27:52 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C9681A0C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso3939795e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048869; x=1742653669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=UF8TUhC50+E3Z8EQI8ipl/gs6wconR4t9Oy3ejgSfQ36ZXb4AQV4bRvyaQkwZ8e0q0
 hGikDygsCWO4WO2dPi2AiYbKy9V7bR6zDGpqYqROuuj4Xkg5uMvddKJab9whRNe/PjbN
 UTPELFxd7/XhMHuG75Xide9Hlxb+jtvDKQCt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048869; x=1742653669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQFVrYR87grtG8o/wLSObf9baBN1ABJyrIEgTIkbxhQ=;
 b=BXbhrpFxGrln57ywdN9T2ZK9I3Tj3m2PJmWTFM9pxeNgYpghdI/Xm5geT0IaeBaAfy
 SLoTmuBoqYULP2rF3ZJmiTXCCwiWrN0y3tLdF4i/Bxw8Axe7ChlWv3YDsjhF0rejDxpm
 qUdouyl+dvhAsAz9ZzLPoK6NEumzzEUjFR41lpV+jhiyVooZxfRJ+OBViq+4N5qJjOwB
 56wjjo8ScSsk1dxyEMMJsNkv99DrC0J2zhjLpsIySU16aujQKEvJt+rOz8oz2W8jGtZh
 yjov9R1SId0ZBnRW93NQzMmon7UJz9M2lpemC3w/7sP3eU6s48HcpAt8lZTTnohSlcS6
 pDWA==
X-Gm-Message-State: AOJu0YwVdNgH6H66x2lS0Cd9I8rkQVFDEn4uDYEiOM98NZmaxuXgpWl1
 i+8Q4zwFdozw3A6Z9X3AporRmGFVXiVjrMzjP4epFaMW6iJhL0c38TnHW1WOpgFe2WUBJzNwso3
 szA==
X-Gm-Gg: ASbGncsIcPC8OHYxxiCJTVmUYqtAVlFUiZ1BxTYlVFGf1xQy5T3K1/Odj7ARcaeleby
 WdbFNXGdfztrMI0q1pJwgoBPldOEA68QvIoVqfk3SdCyXTPG0vtaHwDKnx8kH8bj5xn+wWGue72
 qOTUPkZqMmaHK/tBALxjU47gc78KgnAiMwn/sTQ36Ps0JT7RY5MU0/wgceJw54f8FpIzJQ8cwDR
 HRD3es7eAS4TX2Qe570wKrRma9HgMMZ0GT6zOUhK1Ix6fkcdfMWhaFNRvghQaCXZlWMAMmU99H7
 dYwBOztEDjk/SPbCl3c87JKzkBm2fI++ebWJoG+jhg==
X-Google-Smtp-Source: AGHT+IEo/grCk8LFBSbweOVooLK/Pp1meBXf/b2y6Obps79HdAZCkgdzxSGfGKxt0uP08MTwoAlUxQ==
X-Received: by 2002:a05:600c:21d1:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-43d1f0a3936mr89927515e9.14.1742048868833; 
 Sat, 15 Mar 2025 07:27:48 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 19/46] x86: Use a simple jump into long mode
Date: Sat, 15 Mar 2025 14:25:39 +0000
Message-ID: <20250315142643.2600605-20-sjg@chromium.org>
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

