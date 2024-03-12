Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D491C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D76487F80;
	Tue, 12 Mar 2024 15:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A/oaeD9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD6B87F80; Tue, 12 Mar 2024 15:08:54 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5370487F69
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5683089d4bbso5442713a12.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252532; x=1710857332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6pvg5Oa7u0dLpTLS16+tVIbHYHC3s3NEBv9Yf4lmgo=;
 b=A/oaeD9l5ZdFHsCwaP0iigaKq/7trpyiSoBFB/5RMYsGyxTjOXfUlhDWA8S5GGXWJ/
 blmw5lW2RCyL/BPfFUYMbXEBlvAYpF9d17LtwwbdtB+UsFRfCySgnLH1gMqSWvJVhxGy
 tP1atVK33ht8p5eg8UrMh1XPDCGpmLb4rvxHh8x0/Tzi8dnnQ2fCCH8D9D4pq/pXjiFr
 HYenqsXZj9eRwkptvjmPZdtd9Q2/3yWp4jtET8I5QKz6Vvql4YVOxAEiTx3ncParzfCj
 pQVMldMAvSDqsLAXZ7fSn0J8MUPnNixq2fFYWbFLZ8KONHp9HMrcjgGEiuPnPWlS71So
 Gg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252532; x=1710857332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6pvg5Oa7u0dLpTLS16+tVIbHYHC3s3NEBv9Yf4lmgo=;
 b=HI/UV/62HFWmBbv0JAKH4T3gzN01ln7nwVlHLvU93F8cvthLXNyxu0+h5cqaecSRL/
 3wF7/wzTXrUuj1IJZ/65snCun5eTT5EXZPm221NgzGP4ZcYu7hi5WHg923GavNcG9ufJ
 evuDjS0YQyUnfbFYrKhSKIBYJxqeVSZLIMxTfgY2t9XtQI1rWYw7NaiRMVPchnGIV+tN
 EKg+xAj/fdhHs/FkVIobs5OPawNJZ7oNsuC6IQIdkNiBaYEKJibXRNCwTBVeapsPhXsl
 jx3IyXHYZgHOpY/OEHsoZUs8PJYAkI76Hpt4OGhtr2IBg8j57aRamGZZ3zrJMR8n0fA8
 ePsw==
X-Gm-Message-State: AOJu0YzTC0SlIqpPTHqoVw81/c1IZxQCb342dp8KzPpE1cS/Qu0ePCYa
 4xKIM9VJCQY3Zg7XMJliN7zP1QAlRDAaMBzUvVM4bPJhrg+LbrfRJltHoljC/hBmyRh9XVTewXD
 tTTs=
X-Google-Smtp-Source: AGHT+IEtdpmXJL7Chht9lGl3NCxrb0yB75mXrak5HbOw6mFnYCgJn1Nrf0GaQKJiVAjrm5Sg0OE+Bg==
X-Received: by 2002:a50:8e17:0:b0:565:6c72:40a9 with SMTP id
 23-20020a508e17000000b005656c7240a9mr6050407edw.28.1710252531701; 
 Tue, 12 Mar 2024 07:08:51 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:08:51 -0700 (PDT)
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
Subject: [PATCH 3/7 v2] arm: fix __efi_runtime_rel_start/end definitions
Date: Tue, 12 Mar 2024 16:08:25 +0200
Message-Id: <20240312140832.1968215-4-ilias.apalodimas@linaro.org>
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

__efi_runtime_rel_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing since [0].
On top of that the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
---
 arch/arm/cpu/armv8/u-boot.lds  |  4 +---
 arch/arm/cpu/u-boot.lds        | 16 +++-------------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 16 +++-------------
 include/asm-generic/sections.h |  2 ++
 lib/efi_loader/efi_runtime.c   |  1 +
 6 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index c4ee10ebc3ff..eccb116d3cfa 100644
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
index 01accb109fad..37f4cd27d79a 100644
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
index 25c81b21018b..11b6e7278a9c 100644
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

