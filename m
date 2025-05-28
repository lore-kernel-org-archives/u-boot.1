Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EDC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CFD8399C;
	Wed, 28 May 2025 10:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WjeJC7xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFF783966; Wed, 28 May 2025 10:26:28 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1DB839CA
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3dc75fe4e9bso2202005ab.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420784; x=1749025584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwKT/m4msj1g/ZcUG5uXUt8ZmpmL5HrJ9QY+ioD+jVU=;
 b=WjeJC7xeyKVpcVbD4bBYA9jt7cBPo0ZURwsMLuFZ0zKqLGMgK6iACw6yfXQ4zNerSZ
 h8rZyv+4GsjY/rN7tCyWzw+oy5XVjbh0yOp7lnbhrTVwRzZk9vuSbqFHlHyr9hLq5mBg
 iiMuXH+gj1hIbqZ/pdUglc2d/X/VyRUeK2h5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420784; x=1749025584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwKT/m4msj1g/ZcUG5uXUt8ZmpmL5HrJ9QY+ioD+jVU=;
 b=IBnW/lqioWyM39GdQnWaLvZyK8dpvepxq9nVpp4EzTWWiQ7+Ts+6CFLvQagotSGyPe
 NxdxjTHr0xFwLqFGt3RZMih9eMwSe/D0s3ljSEV2YVrPjRu7g/LWw8bFojOh5G31IPhJ
 x+FxX7bducY9ecImluJcS7FXEMiyISMv5209tKy20ITc/VICGd8hpAyIZGGzHIWH+81W
 gmfDEvfWcQuryP13D1/nnPmYAX++FcYL/eSRkmqt5lLqDa9FaGd1wNjmJ2fXBoMtg28v
 785pE9WBfBdthbDywisKtmlFnu8lHumZs9aQc9e9y6G9LYws9vaBJmK++HxzBgA/gV+k
 cW0A==
X-Gm-Message-State: AOJu0YxVtPIst0FNBGYrMLXP8RgSeCXTOE6+hdYCwNd6k6cVTrB2yd+v
 8aLPRfZSDB58mLXbiQp/tQYuJswalS/XpIwbH7zSdi8CZxHzCfH3N/+uZKJIRjhsMj7Ryid/1/M
 aNr5R5eRA
X-Gm-Gg: ASbGncv6pJKT0HFkcx+Fs9hP09ZeSXrVSkeeaEFTSjM0F//fPFXqhSVQXN5Jh0CvaCO
 X1VHi5oJqAYX0h00bDJ70c2BPxSg53v2i39TSuA2N6KCTgrSmVe3Hp9F1tsY1o8LhwB4xi0C8tp
 KNOV+sSLMpeZ0nG6FNtk88cOCn/pk9e95630jM4sZtKS48Oolmj7uMZPPU1WrPJDJvYno7yxy/R
 DLroywPMZppeCupAT2n1o38+HgOU9wYujRnwYWqVW9bv7MNgwHP7kcXoiPr2qXP2B5zP4HEeFy5
 OrQYxUGtclaoFlG+4jGFqjOd9wIl7jVB5U8w93gSHPzip0I8nmFdHkWprDSlerebAXneIVp8fja
 KORvTCuLiVqCt
X-Google-Smtp-Source: AGHT+IEs7Wxshf2PW6b1v8MBwbzptbAFx5GUN+4xYcvAtXNo0q9FzofoFMtXi9sjJCRHKYdMDBKyuw==
X-Received: by 2002:a05:6e02:238a:b0:3dd:8136:a687 with SMTP id
 e9e14a558f8ab-3dd8767cd50mr32694495ab.8.1748420784375; 
 Wed, 28 May 2025 01:26:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/27] x86: efi: Sync up the two link scripts somewhat
Date: Wed, 28 May 2025 02:24:45 -0600
Message-ID: <20250528082520.152391-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

The 32- and 64-bit scripts are more different than they need to be.
Make some changes to both so that it is easier to see the necessary
differences.

For the 32-bit script this is mostly just whitespace. For the 64-bit
script the eh_frame section is discarded and the .data section is
reordered.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/elf_ia32_efi.lds   | 26 ++++++++++++++------------
 arch/x86/lib/elf_x86_64_efi.lds | 25 +++++++++----------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/x86/lib/elf_ia32_efi.lds b/arch/x86/lib/elf_ia32_efi.lds
index 37a6c386b81..a3ff0068b40 100644
--- a/arch/x86/lib/elf_ia32_efi.lds
+++ b/arch/x86/lib/elf_ia32_efi.lds
@@ -13,12 +13,12 @@ SECTIONS
 	image_base = .;
 	.hash : { *(.hash) }	/* this MUST come first, EFI expects it */
 	. = ALIGN(4096);
-	.text :
-	{
+	.text : {
 		*(.text)
 		*(.text.*)
 		*(.gnu.linkonce.t.*)
 	}
+
 	. = ALIGN(4096);
 	.sdata :
 	{
@@ -29,9 +29,9 @@ SECTIONS
 		*(.sbss)
 		*(.scommon)
 	}
+
 	. = ALIGN(4096);
-	.data :
-	{
+	.data : {
 		*(.rodata*)
 		*(.data)
 		*(.data1)
@@ -57,7 +57,8 @@ SECTIONS
 	}
 
 	. = ALIGN(4096);
-	.dynamic  : { *(.dynamic) }
+	.dynamic : { *(.dynamic) }
+
 	. = ALIGN(4096);
 	.rel :
 	{
@@ -71,18 +72,19 @@ SECTIONS
 		*(.data.rel*)
 		*(.rel__u_boot_list*)
 	}
+
 	. = ALIGN(4096);
-		.reloc :	/* This is the PECOFF .reloc section! */
-	{
-	*(.reloc)
+	.reloc : {	/* This is the PECOFF .reloc section! */
+		*(.reloc)
 	}
+
 	. = ALIGN(4096);
-	.dynsym   : { *(.dynsym) }
+	.dynsym : { *(.dynsym) }
 	. = ALIGN(4096);
-	.dynstr   : { *(.dynstr) }
+	.dynstr : { *(.dynstr) }
 	. = ALIGN(4096);
-	/DISCARD/ :
-	{
+
+	/DISCARD/ : {
 		*(.rel.reloc)
 		*(.eh_frame)
 		*(.note.GNU-stack)
diff --git a/arch/x86/lib/elf_x86_64_efi.lds b/arch/x86/lib/elf_x86_64_efi.lds
index cb656ac46ea..5e1e8714351 100644
--- a/arch/x86/lib/elf_x86_64_efi.lds
+++ b/arch/x86/lib/elf_x86_64_efi.lds
@@ -13,12 +13,6 @@ SECTIONS
 	image_base = .;
 	.hash : { *(.hash) }	/* this MUST come first, EFI expects it */
 	. = ALIGN(4096);
-	.eh_frame : {
-		*(.eh_frame)
-	}
-
-	. = ALIGN(4096);
-
 	.text : {
 		*(.text)
 		*(.text.*)
@@ -26,21 +20,21 @@ SECTIONS
 	}
 
 	. = ALIGN(4096);
-
 	.reloc : {
 		*(.reloc)
 	}
 
 	. = ALIGN(4096);
-
 	.data : {
 		*(.rodata*)
-		*(.got.plt)
-		*(.got)
 		*(.data*)
 		*(.sdata)
-		/* the EFI loader doesn't seem to like a .bss section, so we stick
-		 * it all into .data: */
+		*(.got.plt)
+		*(.got)
+		/*
+		 * the EFI loader doesn't seem to like a .bss section, so we
+		 * stick it all into .data:
+		 */
 		*(.sbss)
 		*(.scommon)
 		*(.dynbss)
@@ -57,8 +51,8 @@ SECTIONS
 
 	. = ALIGN(4096);
 	.dynamic : { *(.dynamic) }
-	. = ALIGN(4096);
 
+	. = ALIGN(4096);
 	.rela : {
 		*(.rela.data*)
 		*(.rela.got)
@@ -72,10 +66,9 @@ SECTIONS
 	.dynstr : { *(.dynstr) }
 	. = ALIGN(4096);
 
-        /DISCARD/ : { *(.eh_frame) }
-
-	.ignored.reloc : {
+	/DISCARD/ : {
 		*(.rela.reloc)
+		*(.eh_frame)
 		*(.note.GNU-stack)
 	}
 
-- 
2.43.0

