Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA00C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646E987ED1;
	Wed, 13 Mar 2024 17:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PK94tZ4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E3087EA9; Wed, 13 Mar 2024 17:23:47 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C4D87EE3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so8376151a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347025; x=1710951825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vofYHfUuo96XOLh3kZm4X4xcfUxGHEq5/wWQPpI0sjw=;
 b=PK94tZ4b83o01c/aDWEjGDxmXCb2eKEQ3Uo3Xr4EiuK8WrxmqczMS05fnUM9QVMRe8
 ee5uXC0wmVxaEdM3q39BtMySymAIs8wsFZHCuZ/sTMvx1dlKM1OJnEc1Wvv8LRqzM805
 gQNF/y1WfIXo3EEtRiMJGABrDeGMjPNIjb2zwjpG/Et5tfogrNzewhQo7PAbMJx+sKty
 e01XXaf6I4c7JNKy4MzLFv0YhbvaYtUYA32E5Q0AGaMJPn896AoJxOB3s9m9ktlGtJfN
 8Y9mKxXinwcygLT/YuX5jPuElUIcALd3bZgn3FO+c7JyrcisbYiSQDA8LAXJ4gS/F1iD
 9XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347025; x=1710951825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vofYHfUuo96XOLh3kZm4X4xcfUxGHEq5/wWQPpI0sjw=;
 b=iSDvcKFdbqSqtRVGCQLkRMcK5CGRvJZ4N+LA8e5vE+LhZcLgDZPf+gUZU7z4GEikD8
 SlLN1+q+e4URKf0b1G4zIHdTHx12WRrIx79FGGFozDw0QzLdtL+8sq1tlV8uLSEO4ngR
 vnzmNjqplOzuPuIQIfRtDZRHttm0JAoNPOoFU6PbR/+TwpntrczQMBJm7EE/DIl5mznb
 eFHcFPu1XPwlHsAi3y1ib36QIUzETDfbockHjZj1t5OLoZtqSnrZKBV4X+OfYKqAL3BE
 1nM6pb+vo1S/IQQ01lZ9Agj9ndBnXAxuqfJ4b6O0VHEIHWA/7sq0g/QkRH2fzPCYl50i
 AqKA==
X-Gm-Message-State: AOJu0YyJjaSSYZ9leKWFTbKm6O03RZbkLi6MNZBpQeK3tlA9bP6W+gr6
 MBFb86J7SJG4E9UOqwunVO3+Hq7GaSJOx6C02M7YKFf9Nx5s9AnNSGiZWgf4ER3WB6F2/VFzTKK
 T
X-Google-Smtp-Source: AGHT+IHpgxLQjxn3UIUP6GFTA8OsWyFlTXjkPpnFqUbR+bKhbX+wdDE8KkdOCfHgPjlEDzF5cMcjkQ==
X-Received: by 2002:a17:906:d189:b0:a44:4c9e:8809 with SMTP id
 c9-20020a170906d18900b00a444c9e8809mr2315668ejz.32.1710347024716; 
 Wed, 13 Mar 2024 09:23:44 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:44 -0700 (PDT)
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
Subject: [PATCH v3 3/7] arm: fix __efi_runtime_rel_start/end definitions
Date: Wed, 13 Mar 2024 18:23:17 +0200
Message-Id: <20240313162324.2117909-4-ilias.apalodimas@linaro.org>
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

__efi_runtime_rel_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing since [0].
On top of that the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds  |  4 +---
 arch/arm/cpu/u-boot.lds        | 16 +++-------------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 16 +++-------------
 include/asm-generic/sections.h |  2 ++
 lib/efi_loader/efi_runtime.c   |  1 +
 6 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 9640cc7a04b8..8561e1b3142e 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -115,9 +115,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(8);
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(8) : {
                 __efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 0dfe5f633b16..f19f2812ee91 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -152,21 +152,11 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(4);
-
-	.efi_runtime_rel_start :
-	{
-		*(.__efi_runtime_rel_start)
-	}
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(4) : {
+		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
-	}
-
-	.efi_runtime_rel_stop :
-	{
-		*(.__efi_runtime_rel_stop)
+		__efi_runtime_rel_stop = .;
 	}
 
 	. = ALIGN(4);
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 8e8bd5797e16..ddfde52163fc 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -29,6 +29,4 @@ char __secure_stack_start[0] __section(".__secure_stack_start");
 char __secure_stack_end[0] __section(".__secure_stack_end");
 char __efi_runtime_start[0] __section(".__efi_runtime_start");
 char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
-char __efi_runtime_rel_start[0] __section(".__efi_runtime_rel_start");
-char __efi_runtime_rel_stop[0] __section(".__efi_runtime_rel_stop");
 char _end[0] __section(".__end");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3c5008b57392..bb0e0ceb32ec 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -58,21 +58,11 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(4);
-
-	.efi_runtime_rel_start :
-	{
-		*(.__efi_runtime_rel_start)
-	}
-
-	.efi_runtime_rel : {
+	.efi_runtime_rel ALIGN(4) : {
+		__efi_runtime_rel_start = .;
 		*(.rel*.efi_runtime)
 		*(.rel*.efi_runtime.*)
-	}
-
-	.efi_runtime_rel_stop :
-	{
-		*(.__efi_runtime_rel_stop)
+		__efi_runtime_rel_stop = .;
 	}
 
 	. = ALIGN(8);
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 1e1657a01673..60949200dd93 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -34,6 +34,8 @@ extern char __priv_data_start[], __priv_data_end[];
 /* Start and end of .ctors section - used for constructor calls. */
 extern char __ctors_start[], __ctors_end[];
 
+extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
+
 /* function descriptor handling (if any).  Override
  * in asm/sections.h */
 #ifndef dereference_function_descriptor
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 18da6892e796..9185f1894c47 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -15,6 +15,7 @@
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
+#include <asm/sections.h>
 
 /* For manual relocation support */
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.37.2

