Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB42C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA2A810FE;
	Tue, 25 Feb 2025 00:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CsndDYuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCF780FD1; Tue, 25 Feb 2025 00:07:35 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D05781110
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-855b77783e9so151786939f.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438449; x=1741043249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=CsndDYuZji85RZyjABKDKhS1whO2Q/lb2dbgvAL9nLStGDWJT0c41XtGlyRn2Klqqt
 gt21wNT9C3HrfN3et9r0ga4f0rALcPdAxTzPRKLyWUpfj+5FBp6eE6pFGLtgSt8xLgKM
 WxU+hbndpQrgjkk4fo0sL/KL5HD0mfjQnNYC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438449; x=1741043249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=hXGpe9W+7oBxEFv6iJpUmSBrXxIzKMNA58jFj1CCcDC6nGB3ECKLO1Cfg6xj///HlX
 dgGXhGGXcng2AXe9Q+GNqxL/DAxhjXN4qYVyQoxhW4k8lZdoozLRpAfSLyEMouPAr2Cg
 nwdddLN5imqny96y9LCpZtqhAVzj2i3WWRhKp8MvyDLF2MchN8Z8urr0SxIDTxCyO/2W
 BL1cLn86ap4/TFE/JRtDaJ8Vk34XhpwrL+5AtI1gT/FLuG0uke+XU90m4IKwUiS0lRhx
 FH3r3wVkAJuMi5CFB6NWlrHNKUeoXtMo+e6qeJnzzC0J7jE7sknQ+kmhBJGfHiorbe1n
 axdw==
X-Gm-Message-State: AOJu0Yx1ZgOLG30Dw1NRx5dsV8XacWnfQHvw2hh+GxM0oqLbURgWaybN
 zUIz985Vx0tvMdK3z0XdnQFzmqj6d/C3i4rdgR6Qc53R20VchS1fWefG7cfY7w/NRwjWtZ66uU4
 =
X-Gm-Gg: ASbGncvm2Nu5iXbKtlBiYyE39WX1xpuHhqnWD1LaSLjrdvNc9KoXSZ9Qmi2/TvEFBHH
 NAgUInDKCS2CAOl/Sl8awNvNgPY66y2HKPXcxvSgecF3y7OIYK7KL0vM31+oYji30ZCkhZO2ny9
 Ul1FfFhvAiFwt+ZC4ZUp9sFcJchxotu0tOrc75jstIqIrBHLwEERW+qRqa7tPkiyghaxYyq6sEs
 25D4NUMm8u3MDFwV7H0n5jGQiqhKxmeMEMBVT12EtOI/WS1/jX7VxTs/bQwF4Uhvzi0yT8LEtjQ
 I5RoofS9N91R9xJfmjguAQo8AQF6ltxjaYl+j4xRat560NUA3+/ykKLDAqMlYtk=
X-Google-Smtp-Source: AGHT+IEBgXWvuydsOmqmcvPXHcohDZLjbUC/XE/OmSaGqbFf3PzOWx3wXrIUhQZjWJkbHfL2kAJSLA==
X-Received: by 2002:a05:6e02:3a0d:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d2cb5153a9mr166614065ab.18.1740438449034; 
 Mon, 24 Feb 2025 15:07:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/44] x86: Disable paging before changing to long mode
Date: Mon, 24 Feb 2025 16:06:04 -0700
Message-ID: <20250224230640.2665206-16-sjg@chromium.org>
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

This is required as part of the procedure. The existing code works
because it changes the GDT at the same time, but this makes kvm
unhappy.

Update the algorithm to disable and then re-enable paging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/call64.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/i386/call64.S b/arch/x86/cpu/i386/call64.S
index d81bcc6f8f4..e5a0420d1ba 100644
--- a/arch/x86/cpu/i386/call64.S
+++ b/arch/x86/cpu/i386/call64.S
@@ -25,6 +25,11 @@ cpu_call64:
 	push	%edx		/* arg1 = setup_base */
 	mov	%eax, %ebx
 
+	# disable paging
+	movl	%cr0, %eax
+	andl	$~X86_CR0_PG, %eax
+	movl	%eax, %cr0
+
 	/* Load new GDT with the 64bit segments using 32bit descriptor */
 	leal	gdt, %eax
 	movl	%eax, gdt+2
@@ -67,7 +72,8 @@ cpu_call64:
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	movl	%cr0, %eax
+	orl	$X86_CR0_PG, %eax
 	movl	%eax, %cr0
 
 	/* Jump from 32bit compatibility mode into 64bit mode. */
-- 
2.43.0

