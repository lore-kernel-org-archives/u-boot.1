Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1669D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBEA8946C;
	Tue, 12 Nov 2024 15:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LLE7lt3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A921189477; Tue, 12 Nov 2024 15:00:04 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0749889479
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83ab94452a7so238012239f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420000; x=1732024800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RKR1jpA0OW5wv35hUobchN/ApR4WMpf0hRqemB2txY=;
 b=LLE7lt3iBJYYEaZtagFURoWAT0Cw0gBbULN8ynh/KS0/z13KQITb6SFDPkuU6fYCZU
 5i6ap8c3DEUY0cehclDJuU26rRVipXhixOVIRz3u8HjMnaUtZ74r0vCFqAQFUPYfzkOt
 gYzXCv8ijp9G4F6ZwA/xJ5TNyxs2hKufsU3ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420000; x=1732024800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RKR1jpA0OW5wv35hUobchN/ApR4WMpf0hRqemB2txY=;
 b=kG0uLG8IBPNrUdrCffDqcDlXibIh8BU1rNtgE9s/oud12518KkmF7zdHXc22O9Nm79
 kAYHCfJrfEYv2pbcoyyNzGk8ak6AoY4sh3wjNQ3mnrnjqIPDvPn650/A2MoWgzfGmtka
 iDBmxpWFrJm0OkwYjqHw+GyYKCPmmlFd5VY+1Sp78sl/3H5hN7Z8XfCtU9O3Ew6J7v+U
 a6tFQ3f6aDXGH/kABxajw/PtYM2E4Ir/AQiN2yDQmh6qOonadUOOiuez2sgr4ODGKmi4
 lds2wGy0rhEM3KQ5+apgBtN+drdyFBvDHMrx0l2Lg6N+wKbs5u+c1p4+Gj75BNiH5zWY
 sQMA==
X-Gm-Message-State: AOJu0Yyj52SIavSgJv9dRX6ai2SEKJaMOPEmUXdYyTe6Bvypm7BtcPEy
 pljOf+xqVYarDgCaMweDsMNfNCQkx+VvaTbprDKF1BFXvwQVFDzo3dQKHg3ogmwe8m2lb+ktCms
 =
X-Google-Smtp-Source: AGHT+IG/8oRXD8RzMnE81mE4cRO2UCenxgdIW0pYSTFx+gxuEy3ASNH9ofE86/OYtP+JVQAlUzoYqQ==
X-Received: by 2002:a05:6602:60c9:b0:83a:b98e:9240 with SMTP id
 ca18e2360f4ac-83e43275d1cmr341499039f.10.1731420000147; 
 Tue, 12 Nov 2024 06:00:00 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/18] x86: Disable paging before changing to long mode
Date: Tue, 12 Nov 2024 06:59:09 -0700
Message-Id: <20241112135911.630586-17-sjg@chromium.org>
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

This is required as part of the procedure. The existing code works
because it changes the GDT at the same time, but this makes kvm
unhappy.

Update the algorithm to disable and then re-enable paging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.34.1

