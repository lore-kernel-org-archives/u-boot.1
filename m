Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4377C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C3680FB9;
	Sun, 16 Feb 2025 21:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9l0vcrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126E7801B0; Sun, 16 Feb 2025 21:45:32 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC1A80FB9
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-851c4ee2a37so269006239f.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738727; x=1740343527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=B9l0vcrciD7cL1MBpDvoSFXGo3c0zf477Wowh4tBOVY2qhsxNYFSqIfCwvqagNb1me
 YEoMpwFwH0nIigY9hgf43DQvtuNMq0c9WfBcJoOAu9wuiNE6N5+txwnevYIwKxlQphlN
 DMD8rDL3DKs3UjLrvjoPwVSsYwz1BMM4plsXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738727; x=1740343527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErlXnG6EQdTs+59Qz5dQTEPO97ua90XC+5Y9FwAuuaU=;
 b=HzYlAcW8L8HQgiBC++RPnMymQz3/Hk9h3fdOgHLHwWEm7r9OYNhBsduZkcpQemP9RH
 SCymC1QRRe2qofGGW9RACtZfBZIY2Kz71mYLqGiPWTELz3WprThvDD3S0/UJc3nsV3aG
 Er362LUwFre74QCQBLxgLiBad/s7/U1FlMT+jO8n0pyOvmZpJDiJdah2PD7Jlhs6E2WQ
 C7Zhd6aD2nwUOmUpMg6K6ubjwSO8w/ZMPwGyNHlADkhGxm4LdN5u6kB0OzVGKOQAJudS
 jllj3P99rrysRovTgr2v8/mncbee8SOpMUxeKym2uJgwltJAQCPgoCyBGCQhkvePGTrP
 GmLw==
X-Gm-Message-State: AOJu0Yyej2IFLJQ+PV6kCO148P0hJAI6vbPVG8PVfNPj6b3p7cM17Zno
 zEqyznhoc/q41E+WGbPm8MGPOtrUKshZp1aCSSfiQmVWJ4KMM61Wu3j4reh6p5knhBRtb5xi9Ls
 =
X-Gm-Gg: ASbGncuaS+6uG5wmExDdiDJHsVopy1nWiw8Y2GA837p0YfTr9hS5ojKyyRx35LdG4lM
 gg6RBYlei0r6MwDnCLXTfgtmi/2904PzKdkcfRfgzdESgZh8wpSR7GDzBSrA2SjEwPDctDsJ+m2
 UT4V4A9rQ4cX9ipx+m8wGsBt8k4u+A+Cp5bUngo81Ey1ud98rs4KF1C5EgfaN9ZdYQ3jCyawB8r
 nd/Tyu2IXz0P7mIdonUD8iBk/GPja+8cXovH9QLTIUGL08eY1NNRMOTz+FXvlWmbq41+DX0Egrb
 4nniLB/LpXSdgDQOjqYHWmZinYH8KCRlL/WeYAT3kxDRj6DDnASe
X-Google-Smtp-Source: AGHT+IGwrA2UIquZB3wAFsTHH8+1kzhQoavXZtE9EeQs/7xu0wLVhWnis+i6QDgFJ/4UXwegdV6O7A==
X-Received: by 2002:a05:6e02:1fc3:b0:3d1:9236:ca4b with SMTP id
 e9e14a558f8ab-3d2807b900amr53315885ab.8.1739738726873; 
 Sun, 16 Feb 2025 12:45:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/28] x86: Use the same GDT when jumping to long mode
Date: Sun, 16 Feb 2025 13:44:01 -0700
Message-ID: <20250216204421.3560012-17-sjg@chromium.org>
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

