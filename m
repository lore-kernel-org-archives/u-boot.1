Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A8EC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2473687ECC;
	Wed, 28 Feb 2024 11:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1/ReKJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DE087D6B; Wed, 28 Feb 2024 11:48:58 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE06688082
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412a3371133so24253185e9.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117334; x=1709722134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUnSc/D4gSPARvE0QDoHE4cFvXwZ0/qZG6/9oqeUf7U=;
 b=Z1/ReKJ+LI8j/HkudaToxMn7WY5F4yR2ZJhb8Do0rhSlzNH3wIM0ES26++uTaoZFna
 cfB1Nr0nrZKkYLpa7DPVhp2yHTHbRUihafzi0jh7UK+Amq9nk/qLEc5tQr00JPcXtxpx
 jcF/5C4KUqFYwwGh5PCaichba2Rq/vHD1e46u/nd2tgEZXQ1ADVAW/wDcktF1no1xAze
 vmmG/RB7Q87X7oSM4vmPXy/2UN/AnKLgKMN0+mErADsLjh/bPTV5zu2Im09z9Dowd1KY
 y6E2Md1MkOxUfu9O4TRh9nbt8hVSxwETETzuL9L/uujxQRCLWvHz0R6DIj/3ybJLmiFr
 Nzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117334; x=1709722134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUnSc/D4gSPARvE0QDoHE4cFvXwZ0/qZG6/9oqeUf7U=;
 b=f6GxQnk/oMBS88Z49agAtegLGspD8YW+GdVxOnxJPJnL35CdqYeAK9CPGMS+5249FB
 42Zds7bKhrSptcTZjWTnhqOtIIc3AAXYzSuT5T8GBVL2eH92qd3ax0nxWa9GYbm+M3yK
 aZ8t/cGvQlFEh3Evxp9H3lMxrHAb6RQDi1+MGVLnqO3O78HEyDRU18FbXTaxZ86YV9g3
 Ydve0pVtVjW/TWn86CcD+gPGPjAPWme7SUVIjpAdu22pMVckkfMPlvGjmzAYe8T5e1PH
 BjUaEeSFqlTkdLwPrzvDtCSYy2AhHsSH/HsJK46oab4qMF88vr0p75w/EOaM/ACxCZO9
 sqxA==
X-Gm-Message-State: AOJu0YziLBsNJiqIs/hZtzKGUkGq0p3StgLs6Z8jvJbMSzC+n4+DvCUl
 34JHw+jUr6cuSfrtOPyvjOUUIwTcaCzfzMLb+WPGjoZ/FwELnYt4UYdFC8IKna56uPDl3tJ+3BQ
 KDac=
X-Google-Smtp-Source: AGHT+IH7lgYTtooYnNWqznuYTlhYPnNWJwo7DesuWEBncmKDyZsldYk9+AlPTLEOQfyWAGLp3buDGw==
X-Received: by 2002:a05:600c:138f:b0:411:a5f9:26f5 with SMTP id
 u15-20020a05600c138f00b00411a5f926f5mr10541180wmf.38.1709117334311; 
 Wed, 28 Feb 2024 02:48:54 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:54 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [RFC PATCH 6/6] arm: move image_copy_start/end to linker symbols
Date: Wed, 28 Feb 2024 12:48:09 +0200
Message-Id: <20240228104811.1366694-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
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

image_copy_start/end are defined as c variables in order to force the compiler
emit relative references. However, defining those within a section definition
will do the same thing.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
a section.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds             | 10 ++--------
 arch/arm/cpu/u-boot.lds                   | 10 ++--------
 arch/arm/lib/sections.c                   |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds  |  8 ++------
 arch/arm/mach-zynq/u-boot.lds             |  9 ++-------
 board/qualcomm/dragonboard820c/u-boot.lds | 11 ++---------
 6 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index e737de761a9d..340acf5c043b 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -23,7 +23,7 @@ SECTIONS
 	. = ALIGN(8);
 	.text :
 	{
-		*(.__image_copy_start)
+		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
 	}

@@ -120,13 +120,7 @@ SECTIONS
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
                 __efi_runtime_rel_stop = .;
-	}
-
-	. = ALIGN(8);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
+		__image_copy_end = .;
 	}

 	.rela.dyn ALIGN(8) : {
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index df55bb716e35..7c4f9c2d4dd3 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -37,7 +37,7 @@ SECTIONS
 	. = ALIGN(4);
 	.text :
 	{
-		*(.__image_copy_start)
+		__image_copy_start = .;
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 	}
@@ -151,13 +151,7 @@ SECTIONS
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
 		__efi_runtime_rel_stop = .;
-	}
-
-	. = ALIGN(4);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
+		__image_copy_end = .;
 	}

 	.rel.dyn ALIGN(4) : {
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index a4d4202e99f5..db5463b2bbbc 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -19,8 +19,6 @@
  * aliasing warnings.
  */

-char __image_copy_start[0] __section(".__image_copy_start");
-char __image_copy_end[0] __section(".__image_copy_end");
 char __secure_start[0] __section(".__secure_start");
 char __secure_end[0] __section(".__secure_end");
 char __secure_stack_start[0] __section(".__secure_stack_start");
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index b7887194026e..4b480ebb0c4d 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -24,7 +24,7 @@ SECTIONS

 	.text : {
 		. = ALIGN(8);
-		*(.__image_copy_start)
+		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
 		*(.text*)
 	}
@@ -42,11 +42,7 @@ SECTIONS
 	__u_boot_list : {
 		. = ALIGN(8);
 		KEEP(*(SORT(__u_boot_list*)));
-	}
-
-	.image_copy_end : {
-		. = ALIGN(8);
-		*(.__image_copy_end)
+		__image_copy_end = .;
 	}

 	.end : {
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index fcd0f42a7106..553bcf182272 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -16,7 +16,7 @@ SECTIONS
 	. = ALIGN(4);
 	.text :
 	{
-		*(.__image_copy_start)
+		__image_copy_start = .;
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 	}
@@ -57,12 +57,7 @@ SECTIONS
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
 		__efi_runtime_rel_stop = .;
-	}
-
-	. = ALIGN(8);
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
+		__image_copy_end = .;
 	}

 	.rel.dyn ALIGN(8) : {
diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
index 2969f139bfd2..f8d3c030ef32 100644
--- a/board/qualcomm/dragonboard820c/u-boot.lds
+++ b/board/qualcomm/dragonboard820c/u-boot.lds
@@ -17,7 +17,7 @@ SECTIONS
 	. = ALIGN(8);
 	.text :
 	{
-		*(.__image_copy_start)
+		__image_copy_start = .;
 		board/qualcomm/dragonboard820c/head.o (.text*)
 		CPUDIR/start.o (.text*)
 	}
@@ -60,16 +60,9 @@ SECTIONS
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
                 __efi_runtime_rel_stop = .;
+		__image_copy_end = .;
 	}

-	. = ALIGN(8);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
-
-
 	.rela.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
 		*(.rela*)
--
2.37.2

