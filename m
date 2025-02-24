Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D77C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494C681113;
	Tue, 25 Feb 2025 00:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvS3dobt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9696810F2; Tue, 25 Feb 2025 00:07:36 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A97F80F12
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso51197045ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438451; x=1741043251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=bvS3dobtVGgfsb5sCEERpPk+IUeeTh6OFiNYgKFYA076GTZGl2PsyM9HSwczFLl20W
 bLJYYLMbUKVQaolfYXHpi3sJEJar3r0YppeLqbP01vJ0qTjkh7B48vhYgId5E+icRsla
 kZpYMS3heDW27pb7DK+lKA8IJxBNkx/lIVNwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438451; x=1741043251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=rS6bb2JjM7m41xEEFkgkvFQNLspqp3KvECjjEvmwBYY6cxzGEg7m8xhBV2ZkWDG2Wg
 ge13U6fMRW3Wl8VN7/ZGXM4Y1Qe+E9MqinqmW1K0/k1N3+L5HcdOTwznCd9hNhwJDVqz
 IXYD0vtIEX/ikITL4zysSVoNIQbzVP407GirS8adihkKT2T9Blr4DIYZeCmXYHUcbZLH
 Mmw996V0a3WouXBm2/AvGLGGjVcelzSjD78qFI26+yLyFR5M1E+mITYTsGfYAJQGZsB7
 pL5a0WulTFDKtNe05s6EUsO/wTEslHkhlq4/aimQf/yc3DL6nQDNt9QVoKhgcdQSe9BE
 UHNQ==
X-Gm-Message-State: AOJu0YxnX7keNPge0it9gAZzcYF5LmvRX2RUvpRTCu/et193XxFu1H3K
 Qe0oA0cTH0f6cf4cxJHQKmkw/aeW3AokV/4fGDaxqv7mFVB45z6Rsch1AmJ7vPDoRYWZXOZEx/0
 =
X-Gm-Gg: ASbGncttfeqaVtGJ0OMPoOeF+mecgCNve7QuMkDx/nHub+vQ1mZPnYjfMU7u5TJg5An
 skCFswleb6vWyukhxqzCivGVUeVmMqiwhJr11fkwE29kO8Bzp0NQsGKpXUdiDSi+kCmhU4yPFiq
 MzYqUV/CtR3Yw5ZlcDsH4evUqPl7AZBG5A4cQUyQ/N4bSXHyqFsJ0nGQZLvYgpYAL2H+3RAaidX
 /1/AtG7Z4Zvxpb/Gqrhe8156WDNcR7E1VNpAMfSibdn5OClpcftjY//bRHR8iiJFuFCI4u6z6Rd
 NlqCj9nqx3pHrSxF06XZBqKG4coUBnmMo6SVfr6tNFdIStuM647t3lN8p4/KNq4=
X-Google-Smtp-Source: AGHT+IFnQuIJi6tV9KYfCubRzMcmjZQKFtJ0W/6bzMOUtbCnQr0/P4gEKiAr0U68Eo2JzBdp08KcGw==
X-Received: by 2002:a05:6e02:3212:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d2fc0ec02fmr16293235ab.12.1740438451216; 
 Mon, 24 Feb 2025 15:07:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/44] x86: Use the same GDT when jumping to long mode
Date: Mon, 24 Feb 2025 16:06:05 -0700
Message-ID: <20250224230640.2665206-17-sjg@chromium.org>
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

