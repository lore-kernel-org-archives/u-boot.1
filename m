Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71E1C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8468E80F9C;
	Sun, 16 Feb 2025 21:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NPMawsNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D6880F9A; Sun, 16 Feb 2025 21:45:28 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4132380FC9
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8557b84dc10so38949739f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738724; x=1740343524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=NPMawsNjgVweaByyxVGkRVAlv7kMvrwCLlajWyu1R1vCexN4WhVJMnOpqJqJQSvr7B
 BJeFkGoeDOJtQ6JIsGgk5auTGuXt0nVqTV7FPHzknJorBI7mzzZ/ySDC9mH/MBrx9raR
 uH8is1AXEjUTtUTLNW70ALNNM4PEXjP0uT/JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738724; x=1740343524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaT0YAhqjbX6ARSHMMZa3f1w6D3V3f9OlKDgYEA95Q=;
 b=UdOxTK6pZCUZieixl8fYoO0UHyGtch9+R9xf0xncKnkn03XmZ3rZPYbQduO56fqsRx
 eMtlUA/ppVJDM4+IVGwewqiMBbKXaGS/uDxrJ2d0WSMg27yMGng1n3h+BvwnC/Q824uU
 e7IAigi1uSUToeTuRUFBJvr+Jn1NLgrItbxw6zyLnNRSiavzuT0vJ9PPD7qWnWLLR8uf
 obloeefJKY3/b3KVNk6P2VIsvjuUW6rP+C8zxz1kgz9SwHu4dvalk2x4Yl5uurvcwZvo
 FX82BPMcN8OhZYniiSBFx5u1YpnZ528HOaKiLPqRkmmaKYj+ZLbRt/whlTQDes/EbGiD
 QSxA==
X-Gm-Message-State: AOJu0Yyryobzz4ZoAjEL0iyv56R3Bvt0C8UoAsF/WZa2A0lmINHzxI54
 +Vh80lPyH7LEOd40x+TpYOP+DDBB3YfRleWg2M16IHzRH4cjfqns+TVidh9gw3L/yfBKstquGS8
 =
X-Gm-Gg: ASbGncsRWE844UTgVpun4Go44xbGcBZ0PeRg2TJVHzfDXAMoAVJ6PpDs2Eh2/c1kTQ5
 L0ugmgwWejlPJk8W+FFhC/ZfEyGQWLALgsfyzCWCj4iop1RehIncdYogHjVw/uuaqvuAh1bfvck
 SYyvY5ljnAjfiIzzU8DU47bRogLtQ7Ngo1/6PaRejx7+dQw8SRB39fYG7RQwrK3tOdteJVO+S2s
 JDyhZLvJF7MXMYWi5lvkQWhzSft85kzWMivafcm93H9eaaFUzjsS5RiYWYsMGc6EFNzngJJ2VRa
 JiYt3T+F4GVLJDlU3Uuxq2ZSDHz2jcMmZigT9zCm9eZxgYTStVTY
X-Google-Smtp-Source: AGHT+IHL1y+aA4JjGo+7ZBoNvvCgQvu+Y/mwZQ2bWTXlwQtHr6UDm6Kgg/yBKqIq/WxtoxgObfEgBA==
X-Received: by 2002:a05:6e02:138e:b0:3d1:b762:4d40 with SMTP id
 e9e14a558f8ab-3d28082f38dmr44502395ab.6.1739738724052; 
 Sun, 16 Feb 2025 12:45:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/28] x86: Disable paging before changing to long mode
Date: Sun, 16 Feb 2025 13:44:00 -0700
Message-ID: <20250216204421.3560012-16-sjg@chromium.org>
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

