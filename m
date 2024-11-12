Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D76D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4468946B;
	Tue, 12 Nov 2024 15:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nPXNsFG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC748947D; Tue, 12 Nov 2024 15:00:06 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67EA89461
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83abdaf8a26so217592739f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420002; x=1732024802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+yH1t4X/23Sg/WHL3paGyxVRgZzLq5jNwuZ+a56L6Q=;
 b=nPXNsFG3rVwXeKbgBSXrdUnOgCQALmLp702iTYCWPfkyjlTGt240Ibc2VUCVafaI+O
 RdVgZQ7sNAq7Wn3uhgC1UZZO3L6eNDX5CpFB2UjW/NtitFbn0Atu0XiuQrida6wguBxa
 R5pXNPjJYeLXUzMeHsaQOsqT6idICnIycsIKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420002; x=1732024802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+yH1t4X/23Sg/WHL3paGyxVRgZzLq5jNwuZ+a56L6Q=;
 b=MEwUbzI2NJlPCXx+RzvRVUyNT9kP1jRDSHPtYiD7mbogdMNP7CGpwUgu2kf2f6N4gQ
 GBiJT73mv7ef1Ws9r98T0G3vH2h2pKyM9YDMFsi6bI7YuJzbZ+ncgHPkLx1/po/B7CPB
 8IDtNQoDF6SrKPQULc5fE/Y50JvUXznQ9KYFJIrIdZqGmTqRzJjJ+To/FSzs3xS1F6gg
 2/9LhOpn8SeHmXNftTWwW/bl+rI5/X4s/3YC1J2USDM4DLW1NIvLkMUVF+u09+UkqZPz
 Phz2sxFBVRq/RakxTE/MBBjyXjMz+pgC3QMqvM6gNDVkv9cJqbCp0mwVyFdJJmBIA3Aa
 asGA==
X-Gm-Message-State: AOJu0YyksLBeucOkoHRIVlSJ7x2+bxFN+m7M6QNktxtDsjFqhgTiR2pP
 yBBXSKMjB9iWFZE9h+FFc8wTA/w7i7OK3YjOqgjlww5n8Ax/VV9kBR9/4GXFXgZkgp23OvUt/7I
 =
X-Google-Smtp-Source: AGHT+IGJFzo3a1tucBw7Y/gnWoZz268qFrdl+oSmUR7KdFFBuzfJvU1YrfSYDxM2DpVbiJlwJUk5rA==
X-Received: by 2002:a05:6602:2d91:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-83e0329dc3dmr1900325839f.5.1731420001840; 
 Tue, 12 Nov 2024 06:00:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.06.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:00:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/18] x86: Use the same GDT when jumping to long mode
Date: Tue, 12 Nov 2024 06:59:10 -0700
Message-Id: <20241112135911.630586-18-sjg@chromium.org>
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

Make use the existing GDT which now includes entries for 64-bit code.
Leave the interrupt descriptors alone. They can be tidied up once U-Boot
starts up.

With this, kvm mode works with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

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
2.34.1

