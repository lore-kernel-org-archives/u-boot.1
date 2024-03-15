Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6295C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B0987FC8;
	Fri, 15 Mar 2024 07:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oGUhgSbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AF087B89; Fri, 15 Mar 2024 07:44:16 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA5D87FAA
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-413fffc0a4dso2475755e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485054; x=1711089854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vofYHfUuo96XOLh3kZm4X4xcfUxGHEq5/wWQPpI0sjw=;
 b=oGUhgSbeZjAfjcHKVe0e23KMllZmJh8y6OrNzw0eBWfRLhgrDDPjLIufwwXk0r5KWH
 Ao2d9UYk/I+8nvheONmNd0mO4O2Omsil30/SU7oPUojpsrEC5DgttNcRzabvZ27rb437
 qt8woZxY9jGP7TDVxdThMTxxrTKDwhBjPx4G1Ze88ripVU2ZV4j326BK8PgTTqfjqoOQ
 cVR0u+zFs/MyMNB/vc6rjIuI2G9w3+SrcmVBClGtEGDKzvmpVA8xYK08s73ulu5z4eV0
 GDArYhr4NrY2Mypy4E1NqDNm3SZZVlL98Efz2vX//a7wdqr5aYluKAzF5HazWbK9sYVK
 xPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485054; x=1711089854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vofYHfUuo96XOLh3kZm4X4xcfUxGHEq5/wWQPpI0sjw=;
 b=YDpNuaQTiwPVnYIAksPcZLjiC22wsMJcXdhirJmmqKpSmWvofD92EBXG1ZNKXGLIlR
 xymdeMIUZvn+MOjVfg1JIzdSj1a/0xgCYERHKxgYaKBsTL9Z14WALNciHvidNmtMwa/1
 CwNnI/DDnuNRKkZDO/JS/Jd4MAcokiEAl1dckwG3FBpb4GqTdXqw/tYRu4SBPtCLSdyb
 pWTXybLb0UXxN6K8gaDf+3OjxYkVSS+0PmPAL9T/Z7KQuFXb0gZpzMV+aLuaMLbEXOiv
 UfHHWwUjSRK6JyjS3l4Vzia/mn7TuADVofRGtUHgPGauhzLm289Fyz8DDBoI3Q5PHb1u
 FqHw==
X-Gm-Message-State: AOJu0Yz5kgvtnaNWPvV9oIBGaHNkWyJW+ZOQ3t8lWBid8ZeuLimUqT38
 bSzjuPdGFijhKtK+aA642WOtB4PG0/QCoqcTHYOwnOJCVgR4txTbXIix+GBI/waFnhoQMXnQMam
 q
X-Google-Smtp-Source: AGHT+IF4ROZkX/JTLPkNJBA3z1kqzzBfehGOI59xbRK8wiaijiM9bhFoA0rL62rNZmR5wUPsHkcSIw==
X-Received: by 2002:adf:fa87:0:b0:33e:7946:4cd2 with SMTP id
 h7-20020adffa87000000b0033e79464cd2mr1513694wrr.10.1710485054447; 
 Thu, 14 Mar 2024 23:44:14 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:14 -0700 (PDT)
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
Subject: [PATCH v4 3/7] arm: fix __efi_runtime_rel_start/end definitions
Date: Fri, 15 Mar 2024 08:43:47 +0200
Message-Id: <20240315064354.2215266-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
References: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
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

