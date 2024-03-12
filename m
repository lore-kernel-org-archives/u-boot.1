Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AB7C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549A887FA0;
	Tue, 12 Mar 2024 15:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YQYoSpHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3EED87F8C; Tue, 12 Mar 2024 15:09:09 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F9B87FA0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5684c3313cdso3224407a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252547; x=1710857347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaScewqBQfQe1ZYJSJupnjWvoj3IezG3YAWy8EhJX64=;
 b=YQYoSpHgIXuFHcDWlNkpgafJZnAp/ofW3toU05xiAHfhwiRO78J3iYnW9/huRAJ/63
 H9xhHNZ9fN9+SFLTrQGmo4Kp4e2fXoojRsWOeKLtiEO+bQMW32bKJ6CcDipzCXNZHx/i
 SOQnfpWPShN5px8kTufo4hCB95HXUfEmIV2hDRghqopBZe98f2rQgmF+TQkqJ48uJL5f
 srxJUf6RnTykjTE/B34T3oJQkTIXj6B2xm3MZzAeEUlDRTEjFbdsNVuYqSVxoXrflfBZ
 xmMuZCMIOmOWncyqXhe1FdyX2HTGeOSOJe29fHTCYGwmncGT1bfd7n9otyphgX6ZAS7X
 1tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252547; x=1710857347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZaScewqBQfQe1ZYJSJupnjWvoj3IezG3YAWy8EhJX64=;
 b=DLQ+agHjy4WCyVUnjfiGrVOYlSkHlqHOT74TxAVdePJiFpQmERK4yB5K7ZDL5STR8E
 8yqPGEmSs/2z8Z0Lnmt1ULCAus8D+61N8pkDaeQmmRqgc8UMZgKjiehEONenzeTnRFBB
 C9Xo89OHj1kmE4qpIe/CU6V5iENYwjuPWcjCsfNMFxT/KIcxOz4b1u20HFWzjOCOwBcn
 WHs2wtL2ww8iG/libTlEyo47kq1/NJlLhnwxk+BlMYsH5XQizQZ8oEqgJ3JDjfs2FqCh
 zEbudxbUIWZqjJ5vAmO7092ZausSHE7+kfCb9RLsvSaXt8mvP1XSpI8eJ+8blxayvvTB
 fHDw==
X-Gm-Message-State: AOJu0Yxs6eFHIrgiWP1asexKxK4q2qSyksx5NCIChiPokJOc0gsfgNiG
 9MeL+GIc+wS8n3ibcftAkF8JMa9hRDywTbRuArXu3fjo1KRU0N8IPPUtxVi+Vr2SELQRY42qYUk
 seD8=
X-Google-Smtp-Source: AGHT+IE1Rjogc2md/TeplFuUrfeTQiBSDTYPkTEmoi1u9/73u2LTKveWqXpZpEmslxfJmnh5dE9nrA==
X-Received: by 2002:a50:8717:0:b0:567:9ddd:65c3 with SMTP id
 i23-20020a508717000000b005679ddd65c3mr6884379edb.29.1710252546958; 
 Tue, 12 Mar 2024 07:09:06 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:09:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 6/7 v2] arm: move image_copy_start/end to linker symbols
Date: Tue, 12 Mar 2024 16:08:28 +0200
Message-Id: <20240312140832.1968215-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
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
will do the same thing since [0].

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
a section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
---
 arch/arm/cpu/armv8/u-boot-spl.lds           | 7 ++-----
 arch/arm/cpu/armv8/u-boot.lds               | 9 ++-------
 arch/arm/cpu/u-boot-spl.lds                 | 2 +-
 arch/arm/cpu/u-boot.lds                     | 9 ++-------
 arch/arm/lib/sections.c                     | 2 --
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 2 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds    | 7 ++-----
 arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
 arch/arm/mach-zynq/u-boot.lds               | 8 ++------
 9 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 16fddb46e9cb..6417cbd08e2c 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -21,9 +21,9 @@ OUTPUT_ARCH(aarch64)
 ENTRY(_start)
 SECTIONS
 {
+	__image_copy_start = ADDR(.text);
 	.text : {
 		. = ALIGN(8);
-		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
 		*(.text*)
 	} >.sram
@@ -51,10 +51,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	} >.sram

-	.image_copy_end : {
-		. = ALIGN(8);
-		*(.__image_copy_end)
-	} >.sram
+	__image_copy_end = .;

 	.end : {
 		. = ALIGN(8);
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index e737de761a9d..33f4624b561d 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -21,9 +21,9 @@ SECTIONS
 	. = 0x00000000;

 	. = ALIGN(8);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		*(.__image_copy_start)
 		CPUDIR/start.o (.text*)
 	}

@@ -122,12 +122,7 @@ SECTIONS
                 __efi_runtime_rel_stop = .;
 	}

-	. = ALIGN(8);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
+	__image_copy_end = .;

 	.rela.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index fb2189d50dea..9ed62395a9c5 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -14,9 +14,9 @@ SECTIONS
 	. = 0x00000000;

 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		__image_copy_start = .;
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 		*(.text*)
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index df979986a5ef..b6b19a4174fe 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -35,9 +35,9 @@ SECTIONS
 	. = 0x00000000;

 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		*(.__image_copy_start)
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 	}
@@ -153,12 +153,7 @@ SECTIONS
 		__efi_runtime_rel_stop = .;
 	}

-	. = ALIGN(4);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
+	__image_copy_end = .;

 	.rel.dyn ALIGN(4) : {
 		__rel_dyn_start = .;
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
diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index 37f0ccd92201..ada6570d9712 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -22,9 +22,9 @@ SECTIONS
 	. = 0x00000000;

 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		__image_copy_start = .;
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 		*(.text*)
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index b7887194026e..8ff35b5c17cf 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -22,9 +22,9 @@ SECTIONS
 {
 	. = 0x00000000;

+	__image_copy_start = ADDR(.text);
 	.text : {
 		. = ALIGN(8);
-		*(.__image_copy_start)
 		CPUDIR/start.o (.text*)
 		*(.text*)
 	}
@@ -44,10 +44,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}

-	.image_copy_end : {
-		. = ALIGN(8);
-		*(.__image_copy_end)
-	}
+	__image_copy_end = .;

 	.end : {
 		. = ALIGN(8);
diff --git a/arch/arm/mach-zynq/u-boot-spl.lds b/arch/arm/mach-zynq/u-boot-spl.lds
index 8c18d3f91f4b..d96a57702886 100644
--- a/arch/arm/mach-zynq/u-boot-spl.lds
+++ b/arch/arm/mach-zynq/u-boot-spl.lds
@@ -18,9 +18,9 @@ ENTRY(_start)
 SECTIONS
 {
 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		__image_copy_start = .;
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 		*(.text*)
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index fc0ba0ed9a84..f739d1cfce85 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -14,9 +14,9 @@ SECTIONS
 	. = 0x00000000;

 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text :
 	{
-		*(.__image_copy_start)
 		*(.vectors)
 		CPUDIR/start.o (.text*)
 	}
@@ -59,11 +59,7 @@ SECTIONS
 		__efi_runtime_rel_stop = .;
 	}

-	. = ALIGN(8);
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
+	__image_copy_end = .;

 	.rel.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
--
2.37.2

