Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA873C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FFF281428;
	Sat, 15 Mar 2025 15:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VgbcIQ/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CF581C64; Sat, 15 Mar 2025 15:27:50 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C225481D0B
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso2572047f8f.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048864; x=1742653664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=VgbcIQ/gpqz5NVz4XMksP3SCy21P8XgorGP/MwIzUxkjXwJVUg5pZ5DvTLTyCefTK0
 WBMpsLi98DbwQV9Z6K1jc/jDRIYJW2lOm4/vnDGqOS1qZcTVIIVMd2zh68FbNBdstYVl
 PtFnu4ojQS8ZIQTlAMOPWHJz3zxn24hZR/c/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048864; x=1742653664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=NB8cFD0kpsQKpRm2RWNFhUtHWPCstuMwB+OGCpqDLuzkDHEwyNk1ilYO33mavTV6N5
 N72plxx530hmUxFZHb+EKgOalqz65YftoSQN0bcN9lXuEEeuiUXic7A3a3vgQOiflFDP
 7UYTqZoCKHI2mqJ8qb1ftx9pWXb6fkfol15yVRrPutDFKQ0tB+WX2PJ3HO2l1WUzWJ8e
 DEZira/lA4EWZYHXu9PiExBp97UJ1uPdJUisKBz0SUfKahSYVCEOGUCBcTb18BPGj0jr
 UckH5kRXtfA81bsrKCM7Qd2aoenQqjgMhGoVUgwdkjTBL+ux2nwavBc06t32U1aeR2x6
 r+EA==
X-Gm-Message-State: AOJu0YyXJuEpvOoVaf6G8lP2j8FMq5DFUqvBWFlfNlj6CdZPRQluD4iB
 +PVgMOLiM260uor6rqLbnXY93QKGlOtP7z1dbrTBt9wsntNxK1oLINqu+Ac/QAocFqn8x18Kyw8
 2QQ==
X-Gm-Gg: ASbGnctJpHTWrgsOe0YUknGT00JuR3OyssgvEDFzTM0wUY9e7+UeNamswgqnF5jqNTV
 bTKuePg19wiPEgVKVKwCfgESpRj8QA4ArGaXNfPxM7eizqslcdtNTVyxYD/Ekdpcjc6wC2kv3GB
 0IfjGxOgW3sF2//w/SnSX+boACGzpakyl830/m8i0S0/vPgFdu2g7MsF4ju7QYS3C7vZojvrv0e
 2nW+JpVqvXpgzGe0pefM7kdHQZiuCchLor0vL9HeWndWiNbifVCgyXNi9zCtcQtship/HnFRXMx
 GvD7tQ9NaKRLESefROjm5QteAiUmu+Vn09I3ysiiHxIXUDV3bKGR
X-Google-Smtp-Source: AGHT+IHsf66IV0DfgEQ32hbdUuOPhrJ1mhHz6LEQ2B/B0HX+Op2GAjWo2hT2niwKxkWWfdfeZqUO1Q==
X-Received: by 2002:a5d:6d81:0:b0:391:1199:22b5 with SMTP id
 ffacd0b85a97d-395b758f9afmr10103386f8f.10.1742048864362; 
 Sat, 15 Mar 2025 07:27:44 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 17/46] x86: Disable paging before changing to long mode
Date: Sat, 15 Mar 2025 14:25:37 +0000
Message-ID: <20250315142643.2600605-18-sjg@chromium.org>
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

