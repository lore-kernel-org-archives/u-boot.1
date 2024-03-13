Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7646C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF3A87EDA;
	Wed, 13 Mar 2024 17:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ri50Mf2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAED287EA9; Wed, 13 Mar 2024 17:23:42 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF6A8272A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso759966b.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347020; x=1710951820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyLkay206iddxamxOCfXexi6LBePtQTgH0CLz5GnYw8=;
 b=ri50Mf2d4N8SuFqVjJ/ZnJ5c7wyU0RJC5NgwXNeVzXA3anEd0jHrj7LJuVyWdXV6o9
 8CBlIYmwD6k5XIh+RdkrOaZ14e/NvfuqUB8VB3O4JgvGadSqIoWFHCFfF9/jvNwO5Y5V
 VClTMdav707VNEPSOUQg+xBYOI6Jl239YdveEOyd5oHY4Si9P62qRp0Qwxub8BWwHgh8
 aeJGjoNqJbstsk3gK8Vwm8djtY4Ct0F8s43gjX2A/xWIuBFOk9J9ap1YxtSRyPasB0rN
 p0Nzu/K4Q0MhyndjTsRNX1JAWkG8QcDBm9Uv7NFnlXtk/eIQvxnHM0oB/XWKJXILIoOZ
 oFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347020; x=1710951820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyLkay206iddxamxOCfXexi6LBePtQTgH0CLz5GnYw8=;
 b=baettrfhmAKsPlpGqQW0ASdbIUHsrQu3PGG3+LdGBky7L788jYe7VEdR8mVsMeuaH3
 mDRoflEUnYuZvcYlvXCrGBaBpm+ShF13g0s7gC1MS75cM+CCIVae5iadXLVRq7mCFw+y
 yBSFm2lC2zIn8D1Gb8Cqf3UMccfK6kwokjN0k5Tj9EjarGK1/RUyn5GZK/8PTien8K9Q
 v3QJiaPCz/2O29NHD8hzRApvDTklidQ7gqyCNXDYlE+qFt79RhJ0BMmoMRcfhMrKYj4G
 k9KLttAIw0Knf4uvZWkalQQK5JPoGVel6FPa0qRiuB7shx2ZwOSfqS61o6mu2cY2VwnT
 n10g==
X-Gm-Message-State: AOJu0YwwnpZlcIAlu/YgwVWi3uCFM1A4pbuoRSnk0Ld0RJbdGiOd7a6W
 /AWIMt/f0DYo6nk165iRjK2+NzirxMtL8MKgDGjCvXEIlCju0SQnJPv3scTfPfYxcsWj/FEFmtF
 L
X-Google-Smtp-Source: AGHT+IFZRJgzx4IhUY7HwJk+MLjnKZvfsRwjmrTF8Bctapz+vluXtKZlzsWcdMyD12g0tyTKpWMEOA==
X-Received: by 2002:a17:907:7b06:b0:a46:5ac2:8506 with SMTP id
 mn6-20020a1709077b0600b00a465ac28506mr1601979ejc.25.1710347019752; 
 Wed, 13 Mar 2024 09:23:39 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:39 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Date: Wed, 13 Mar 2024 18:23:16 +0200
Message-Id: <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
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

commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
and
commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
were moving the bss_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code and linker bugs back then
prevented us from doing so [0].

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable type with
the value being a fixed offset from the base of a section [1].
So let's start cleaning this up starting with the bss_start and bss_end
variables. Convert them into symbols within the .bss section definition.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
[1] https://sourceware.org/binutils/docs/ld/Expression-Section.html

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot-spl.lds        | 18 +++++++-----------
 arch/arm/cpu/armv8/u-boot.lds            | 16 ++++------------
 arch/arm/cpu/u-boot.lds                  | 22 +++++++---------------
 arch/arm/lib/sections.c                  |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 15 ++++-----------
 arch/arm/mach-zynq/u-boot.lds            | 22 +++++++---------------
 6 files changed, 29 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 7cb9d731246d..692414fe46fb 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -63,18 +63,11 @@ SECTIONS
 
 	_image_binary_end = .;
 
-	.bss_start (NOLOAD) : {
-		. = ALIGN(8);
-		KEEP(*(.__bss_start));
-	} >.sdram
-
-	.bss (NOLOAD) : {
+	.bss : {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(8);
-	} >.sdram
-
-	.bss_end (NOLOAD) : {
-		KEEP(*(.__bss_end));
+		. = ALIGN(8);
+		__bss_end = .;
 	} >.sdram
 
 	/DISCARD/ : { *(.rela*) }
@@ -89,3 +82,6 @@ SECTIONS
 #include "linux-kernel-image-header-vars.h"
 #endif
 }
+ASSERT(CONFIG_SPL_BSS_START_ADDR % 8 == 0, \
+       "CONFIG_SPL_BSS_START_ADDR must be 8-byte aligned");
+
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f7..9640cc7a04b8 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -149,19 +149,11 @@ SECTIONS
 
 	_end = .;
 
-	. = ALIGN(8);
-
-	.bss_start : {
-		KEEP(*(.__bss_start));
-	}
-
-	.bss : {
+	.bss ALIGN(8): {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(8);
-	}
-
-	.bss_end : {
-		KEEP(*(.__bss_end));
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 7724c9332c3b..0dfe5f633b16 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -207,23 +207,15 @@ SECTIONS
 	}
 
 /*
- * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
- * __bss_base and __bss_limit are for linker only (overlay ordering)
+ * These sections occupy the same memory, but their lifetimes do
+ * not overlap: U-Boot initializes .bss only after applying dynamic
+ * relocations and therefore after it doesn't need .rel.dyn any more.
  */
-
-	.bss_start __rel_dyn_start (OVERLAY) : {
-		KEEP(*(.__bss_start));
-		__bss_base = .;
-	}
-
-	.bss __bss_base (OVERLAY) : {
+	.bss ADDR(.rel.dyn) (OVERLAY): {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(4);
-		 __bss_limit = .;
-	}
-
-	.bss_end __bss_limit (OVERLAY) : {
-		KEEP(*(.__bss_end));
+		. = ALIGN(4);
+		__bss_end = .;
 	}
 
 	.dynsym _image_binary_end : { *(.dynsym) }
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 857879711c6a..8e8bd5797e16 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -19,8 +19,6 @@
  * aliasing warnings.
  */
 
-char __bss_start[0] __section(".__bss_start");
-char __bss_end[0] __section(".__bss_end");
 char __image_copy_start[0] __section(".__image_copy_start");
 char __image_copy_end[0] __section(".__image_copy_end");
 char __rel_dyn_start[0] __section(".__rel_dyn_start");
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 74618eba591b..712c485d4d0b 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -56,18 +56,11 @@ SECTIONS
 
 	_image_binary_end = .;
 
-	.bss_start (NOLOAD) : {
-		. = ALIGN(8);
-		KEEP(*(.__bss_start));
-	}
-
-	.bss (NOLOAD) : {
+	.bss ALIGN(8) : {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(8);
-	}
-
-	.bss_end (NOLOAD) : {
-		KEEP(*(.__bss_end));
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3b7c9d515f8b..3c5008b57392 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -103,23 +103,15 @@ SECTIONS
 	_image_binary_end = .;
 
 /*
- * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
- * __bss_base and __bss_limit are for linker only (overlay ordering)
+ * These sections occupy the same memory, but their lifetimes do
+ * not overlap: U-Boot initializes .bss only after applying dynamic
+ * relocations and therefore after it doesn't need .rel.dyn any more.
  */
-
-	.bss_start __rel_dyn_start (OVERLAY) : {
-		KEEP(*(.__bss_start));
-		__bss_base = .;
-	}
-
-	.bss __bss_base (OVERLAY) : {
+	.bss ADDR(.rel.dyn) (OVERLAY): {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(8);
-		 __bss_limit = .;
-	}
-
-	.bss_end __bss_limit (OVERLAY) : {
-		KEEP(*(.__bss_end));
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/*
-- 
2.37.2

