Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A37C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8FC88026;
	Wed, 28 Feb 2024 11:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJRMU1uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA54B88007; Wed, 28 Feb 2024 11:48:45 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04468807C
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so75605461fa.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117322; x=1709722122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCjEZk+hn7YNvUHPw/I6m4Ni9W92nQmew7vxuOthRyA=;
 b=FJRMU1ucFh0EprrSU+gO16Z0QSOgpOhEpvFhoR49GGTJM4e1XhM5FEXp1kXDMq8rjI
 jDmXSwAcEffyWp2WmUfLPbZKO0dEKyDtdHUf7xM1syJAP/l6ezZ+krX7Qe9Stop5FuE+
 GitaOZKRzUIYkDr40dxJ8yABygrBAD6cQW7iiR/7n3NrB6rO6nLO38Lo2cWm0L+YSYg9
 ExIy+5vLXsOQBeVvQfZkCgN4FylIwn7BO8a27qc0JG5Y2iis58JNSFlzb3g9NDd+k/4H
 0CUi9mj0rLLIniugNrZh97J8GswrY+KYiqRKSLgwGQfAUJf0fuA3IzEZSZLL/oKsiMP8
 bxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117322; x=1709722122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCjEZk+hn7YNvUHPw/I6m4Ni9W92nQmew7vxuOthRyA=;
 b=NH1VPGxk2WjhNVosXb18loGHTXbK0OfID2VJs7+9Wyy4+rgPSEylaoAKLnBJBbVWTN
 AyF4qdd+EwcRahd6UUndyo+LX9ezJakM2tQPG2hgL8Nu9SiJWJISw1ADveT775WM8EoW
 94zfjXX+RUxIO+Tuzp5yV1l+lyB/+6ngmDvY0vgGy0KxIijU2uZrUb+TepzF6vxlDGuK
 04h+vi6MJd0lG7vXcMqhBHmQd2LP/EJjwrDs9DUVbZBuDubdbT+J72H9IvhsVLkWS5zH
 93bEIvT1HLZ2eTPDsqHZi17PmAcsKxO4NcozxPreV+5FifaDRpwgeHjFhcezX17CcEy2
 Jprw==
X-Gm-Message-State: AOJu0Yw569i5L7X3q3iZa7FNT1wGjfam1pYd3vYnyM03DhM02pEdyYSh
 m1mlRIqa25BEKskwGWs4lbzYTnkETqirkTPy0sDju6hpxWGc6wxWc5YsoDwUQH1wQm5ffraHeJN
 WKpQ=
X-Google-Smtp-Source: AGHT+IHqCuh9rN/Ne4Dy+ZbfMOzqnIA8biK+z800JPzlwWiejIA4BA99LfFP7gWUDbGvMmIxxd24dQ==
X-Received: by 2002:a2e:8e90:0:b0:2d2:2e7a:e070 with SMTP id
 z16-20020a2e8e90000000b002d22e7ae070mr7500431ljk.10.1709117321898; 
 Wed, 28 Feb 2024 02:48:41 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:41 -0800 (PST)
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
Subject: [RFC PATCH 3/6] arm: fix __efi_runtime_rel_start/end definitions
Date: Wed, 28 Feb 2024 12:48:06 +0200
Message-Id: <20240228104811.1366694-4-ilias.apalodimas@linaro.org>
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

__efi_runtime_rel_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing. On top of that
the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

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
index 90d329b1ebe0..70e78ce46672 100644
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
index 8d3259821719..66a9e37f9198 100644
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

