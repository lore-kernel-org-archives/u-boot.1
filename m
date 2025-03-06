Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AE2C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A614817EC;
	Thu,  6 Mar 2025 17:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LfGpANMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEAA58198A; Thu,  6 Mar 2025 17:05:26 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C118980E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85ad9632156so62929539f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277123; x=1741881923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=LfGpANMuEm3ccX4m+h54YSD8Nyn1Y/0qFYuaPR3hPBLYMljfW40nvXMkabJ9pVy3n9
 BpKZTxY3EhoKejkYIm/xcPn0636oOCAjJmvOrXUPHprv4RK0/iX8FwCYxY/M6Md88FS8
 neiwvW7xlo7QfLRFa1PKd1pwyp/ZyesHfOyWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277123; x=1741881923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=scQpzzBGY/ej8Ve93uf1sR/3Ws89AT/2tncUNuqNZqnGpfzildSXm9h6ubo8vswiJl
 WX1vM2581lnJl22hIQRe/AD57rSYkitgZ+hz6ElvoVO0nin1q99b5xJp0VVNPsvFCWgB
 9ZmR69JGvCQm7p+OlchzADQUldvF6UnHJxG1T5LbRxdsCT1SGFDJ33EPIRe7ItxnLhgR
 rbvqsMnN796bbozup++ha61/lDWyw/NKmotwe9Dao8ZQbyuE98yHi0KQL8LCgGHExddP
 FG0tYhw0dSYdgythO8e8lMx/tQ6KGEOrphHjpGYUDvdBKMsK7mKpP8laU3U1LzUqQNhb
 NxXQ==
X-Gm-Message-State: AOJu0YwtkOjxd9W4WPE7sgm1Wh9VAiwV2bHOFs/yZTRVMLfBFncQAx6q
 8VMMFPhcwxgm2eHj6pRHlCCEk8jpALJ5tZjpwTTcoe0XRXoqLZ0PC8GTgbgVy9GGbjVJMr3nYPY
 =
X-Gm-Gg: ASbGncsNk23Kv1/dJ8Hojut3OggFWfgckz9myY9YB5CJad63/Dv13KwihiKQfKwjSBc
 8FzDTs4nppydeskET8ZmQpuToURDIm9eSAhruG5ner2wy1uESZ0U9WtuhuPF4IsLHMdSIF20J3i
 divFjHvyYHcmMrpuJRVCTD4xonf8wX7dh+cYstnFhwjFqa72iyq9PAT4Mv4vdPwgHEGIX9WHoO/
 2pFZJpx5L1RQ8DP6pUio/WtIJGK2GcfaIXQTDtxqU4bXYNQFZWkOQzjbXG7k4yUte+HNhG1OkwM
 DT2xeh38OOtMeiBbHlcJ6tF1pE5gNCZxw84r0Gf3S9UxI/aP5aMjyz8UFwBVkLdoHcKuXyhG/fS
 eqfqsyw==
X-Google-Smtp-Source: AGHT+IExAN6lgTxFSjb+OPdeQmnguuE6XXudDLzGhnbHtYFp06CFxd12GWoMgFuubXC8hlYLRdk6Eg==
X-Received: by 2002:a05:6602:6a97:b0:85b:11a0:a03f with SMTP id
 ca18e2360f4ac-85b1cfaadc8mr5425039f.5.1741277122935; 
 Thu, 06 Mar 2025 08:05:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/47] x86: Disable paging before changing to long mode
Date: Thu,  6 Mar 2025 09:03:44 -0700
Message-ID: <20250306160428.3041057-18-sjg@chromium.org>
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

