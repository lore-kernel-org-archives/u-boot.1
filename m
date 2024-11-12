Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7DED42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DB789484;
	Tue, 12 Nov 2024 15:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SYVvkWok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CD38947B; Tue, 12 Nov 2024 15:00:02 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B968946C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ab00438acso169127639f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419998; x=1732024798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bw9gQy45Ne6QtwImv3ClcPZuj9Dfgu1fUJPZemJfyrc=;
 b=SYVvkWoke65/GL5BVBb6COzLnmpp9x5G/UQVXJCym9cgPUPVqjHN4soMaIJ9Cc0Nfn
 dVTkslRkTYfQ2CsYNx7GLC/eShQa1DWZCure55wQYyvZDzMsEXO+bTMdATs1y8deEK5+
 lk84uPgIWg/UobwOsLTBRGAVI+7+fdQjEV6+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419998; x=1732024798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bw9gQy45Ne6QtwImv3ClcPZuj9Dfgu1fUJPZemJfyrc=;
 b=ZrURztOIpnEz4v/yKCYBsemn9qQ1IKbujp66A+L2LuOsiRjggrXAq03v24AFkm3ncx
 7+pRwwy9OzwLNV1CrklJ8TzAxyeZaY7gnTyg7PdMiY0Er4JGTdB5i4c0cGqoWERZimTx
 gbzs2PbKypZki0uu0ICrnm0R+GZE8q4f9GL4pzYT3JRPNwn036go2XSmQ7j5fYR+Lkli
 Ovd7PyGbRPUFDX/V3+TIw5NGsMEeeh4+P6dIUf9UPbxEin5/jBFdxNOE5R4X1hxwUtpR
 GABmRmvUSBlxzn0eu9LQt4g7KNmcYRYo/Q3il2IwKvRKh4hqnVOt+VWsVlGhyGjZNy5G
 XbRg==
X-Gm-Message-State: AOJu0Yyam/MrF6cpB4VNxkzUfbb8qZuDzy7LAZebrk3gTmBHaP1QQHGB
 GXSZq/P9sl0Pc5XSKUmIR8dM5GbIs+lMF5+0zxbwpJ0ENjkle7dp42Kh5M+tfvqAX8GdqArsGCo
 =
X-Google-Smtp-Source: AGHT+IFrGfVyPrPIRR90+hDBMDnmZAChmEqPWSvVr1Vt1KpLEnnH0yBeLJypwbGrkJvL7eCeDaN8cA==
X-Received: by 2002:a05:6602:3cd:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-83e03523c78mr1269447839f.8.1731419998409; 
 Tue, 12 Nov 2024 05:59:58 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/18] x86: Tidy up the GDT size in start/16.S
Date: Tue, 12 Nov 2024 06:59:08 -0700
Message-Id: <20241112135911.630586-16-sjg@chromium.org>
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

Use a symbol to select the size of the GDT, rather than hard-coding a
value. This matches how it is done in start64

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/start.S   | 4 +++-
 arch/x86/cpu/start16.S | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/start.S b/arch/x86/cpu/start.S
index 0ef27cc5a00..385a691265e 100644
--- a/arch/x86/cpu/start.S
+++ b/arch/x86/cpu/start.S
@@ -254,7 +254,7 @@ multiboot_header:
 	 * GDT is setup in a safe location in RAM
 	 */
 gdt_ptr2:
-	.word	0x1f		/* limit (31 bytes = 4 GDT entries - 1) */
+	.word	gdt2_end - gdt_ptr2 - 1
 	.long	gdt_rom2	/* base */
 
 	/* Some CPUs are picky about GDT alignment... */
@@ -313,4 +313,6 @@ gdt_rom2:
 	.byte	0x93		/* access */
 	.byte	0xcf		/* flags + limit_high */
 	.byte	0x00		/* base_high */
+gdt2_end:
+
 #endif
diff --git a/arch/x86/cpu/start16.S b/arch/x86/cpu/start16.S
index 865a49731e5..8d9acb193e0 100644
--- a/arch/x86/cpu/start16.S
+++ b/arch/x86/cpu/start16.S
@@ -61,7 +61,7 @@ idt_ptr:
 	 * GDT is setup in a safe location in RAM
 	 */
 gdt_ptr:
-	.word	0x1f		/* limit (31 bytes = 4 GDT entries - 1) */
+	.word	gdt_end - gdt_rom - 1
 	.long	BOOT_SEG + gdt_rom	/* base */
 
 	/* Some CPUs are picky about GDT alignment... */
@@ -120,3 +120,4 @@ gdt_rom:
 	.byte	0x93		/* access */
 	.byte	0xcf		/* flags + limit_high */
 	.byte	0x00		/* base_high */
+gdt_end:
-- 
2.34.1

