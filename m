Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC4C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B50E87F10;
	Wed, 13 Mar 2024 17:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="elNXfCor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6008272A; Wed, 13 Mar 2024 17:24:02 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3984287EA8
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5688d7e63adso631210a12.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347040; x=1710951840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaeMqlOXLZXi4MpKQLTK6S1UuPVKPoVkl5mmHX/g864=;
 b=elNXfCorVqBBnK7o0eupFWlTrurJfHn4JrF1uAOH2e6k0Tn8UwWRjUzrr6VaELxla8
 uTrmSXs/r0SPLZzB5aPBs6UhPzE1NcC311s/xsTQrfHl98PnnXkP4q5GYFMUmgiZqGOA
 LilIXRiNsqLoEP+0AnPa1zc6Zx558P2UXNP6mnghgQXzKyHXPeIFvK8TwGv/+n9zTvtK
 BaSvmsBb0YLq3JkBEQAlO45+EU2q2uaAojgbj5w1XuLJhOPXhXPp4dn0DjONz/eMZVK5
 YCzOCJOZ0X6kBDatPUoL3nfISdbXvEo70fOBMPolfa/9L48yAgXodN3ZIiomsb+GbL1q
 JDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347040; x=1710951840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaeMqlOXLZXi4MpKQLTK6S1UuPVKPoVkl5mmHX/g864=;
 b=osl8tXvnLNKvt4fuvH6vP2z+3/BvjlxcIJ4w048NUYvoe5TMyekivqf6INGDNcSpcV
 0W95lnn4DDMp/d/38FJSvkrrRJdjb7NSp24u+uJ++pbNLr7GAd69gW7dWUKuYQlq3B/+
 E+DP1XtUjUwf1MKG/6QgccnYkRyOPEYTVzL5mhmTSmEFlIXEx7p0PKFDpgT3iN1hSbx5
 segBCmGoPeYn6LMIoOXKA/jr0XXY34tgchffyH2Www42w0DvHCHBhG0e/6rrOKwVBkLC
 6z4JUDSq2Qt2kbQToyRAHruoujFhF/5RJ1ZnvuibBc/xV5mYbzAkT/RuP/Wis7V1AUdk
 UPbQ==
X-Gm-Message-State: AOJu0Ywdek1F09YIaX4XblQHqB78nqd4vEzNIrZaKbS/ec6nEVuUZQYq
 f4sG8uSe46b9wcjkcpPbMANg6rSFJ0+HqksoP6cKMrDO6evrG1PdYtQnLtf1ZgrOzqqAHX5tdx0
 M
X-Google-Smtp-Source: AGHT+IE3+5bTjyEFn5sFYf74NCt21YieRu0KsKlyWu11nHEYMj81ggu3JVjbSZ36FMaHrgeIqQ+ZWA==
X-Received: by 2002:a17:906:4750:b0:a44:1a51:a1fd with SMTP id
 j16-20020a170906475000b00a441a51a1fdmr8487671ejs.64.1710347039742; 
 Wed, 13 Mar 2024 09:23:59 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:59 -0700 (PDT)
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
Subject: [PATCH v3 6/7] arm: move image_copy_start/end to linker symbols
Date: Wed, 13 Mar 2024 18:23:20 +0200
Message-Id: <20240313162324.2117909-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
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

image_copy_start/end are defined as c variables in order to force the
compiler emit relative references. However, defining those within a section
definition will do the same thing since [0].

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
a section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot-spl.lds           | 8 +++-----
 arch/arm/cpu/armv8/u-boot.lds               | 8 ++------
 arch/arm/cpu/u-boot-spl.lds                 | 2 +-
 arch/arm/cpu/u-boot.lds                     | 8 ++------
 arch/arm/lib/sections.c                     | 2 --
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 2 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds    | 8 +++-----
 arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
 arch/arm/mach-zynq/u-boot.lds               | 7 ++-----
 9 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 692414fe46fb..2e61f759ee6b 100644
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
@@ -51,10 +51,8 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	} >.sram

-	.image_copy_end : {
-		. = ALIGN(8);
-		*(.__image_copy_end)
-	} >.sram
+	. = ALIGN(8);
+	__image_copy_end = .;

 	.end : {
 		. = ALIGN(8);
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 5ba54dcedf24..147a6e8028d5 100644
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

@@ -123,11 +123,7 @@ SECTIONS
 	}

 	. = ALIGN(8);
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
index 6813d8aeb838..798858e3ed6e 100644
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
@@ -154,11 +154,7 @@ SECTIONS
 	}

 	. = ALIGN(4);
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
index 712c485d4d0b..ad32654085b3 100644
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
@@ -44,10 +44,8 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}

-	.image_copy_end : {
-		. = ALIGN(8);
-		*(.__image_copy_end)
-	}
+	. = ALIGN(8);
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
index 9eac7de0dcbd..f6c99a8ce218 100644
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
@@ -60,10 +60,7 @@ SECTIONS
 	}

 	. = ALIGN(8);
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
+	__image_copy_end = .;

 	.rel.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
--
2.37.2

