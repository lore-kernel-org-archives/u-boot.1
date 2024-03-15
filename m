Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A17C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DBB87FEC;
	Fri, 15 Mar 2024 07:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aSbFCWqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5417B87FE5; Fri, 15 Mar 2024 07:44:32 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FFD87FDD
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e94c12cfaso1291806f8f.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485069; x=1711089869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZBcF3CeGjU1fWD9wHn4aKai3FlWH+Vdh/pV7X7yzFQ=;
 b=aSbFCWqJQTvxj9/oEbJH10tnoWVSTgopcnT5hslHG705Nn0Rln3EKxQuPrM/QUCBcn
 RTDS8XqzR6SCYoYkGrRzwm4ZE66mfobmSv+KFoCNYNWVv2yIEJS6S0GZzD42QmEx0jw5
 fFI/Z8ONYbXJgQ4nLAmdsSpSv7PZKFYjth0auqDlW95DfZGaS6S0XKY5UybJjmmF0bmn
 0w5wkfw7UmXAUlxho45YPv2MongqO2NVmI/2F/+uLY9oy8HOcQW/BgxCwDweWwAR80rP
 2Pu4RXSeGPPuWsRPuAZ1TmdHMJJZbTRkM4kgvxXHhE5yhiAFwQe3yPU+vs4/K7BvKS28
 M3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485069; x=1711089869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZBcF3CeGjU1fWD9wHn4aKai3FlWH+Vdh/pV7X7yzFQ=;
 b=S8VTA7gUVjILfi+gFJdnLckb5l88yijqgWDLk3HulnBk1JQ8aEX6mYw0fZQ7KElbIF
 x2k1shyF34wipYXvbvLGTYeqcsZQN20oY6LMwkYCiU65VyRF9C9SCtYBQgX2gsSjlYqQ
 y5/bBfZ5sq6a9L9hq3+n2w6LwbCF102mZXVTFSonhW8ohY6ql2V6LOO3knot4od4ruZe
 l/gAZlBOqPEUQgXVUwxgbwRL2n4xZZ4t1HsI4Rat34XS57JjWrgPYjwlbYuyv1N6F+q/
 omTxseM05U0kgeAAgSBI2xk4wcYYhYfBZv8arnJ38iRTCN+hQneuTfWeqxUUi63b71+V
 Ti1Q==
X-Gm-Message-State: AOJu0YxbKxz3D9gf5YBbmkCk6w88L6/e9t0lj2dCG/H1NrGl76lLLmdJ
 jHGLDDYKXHkBGKxHz28hbrs5X3uE81bUdMhpXN86zel9bzYaXQFitkDjHBL2FTRMIrJxrHityA9
 7
X-Google-Smtp-Source: AGHT+IEpLhz9W9fVSMhR5JX2TZ8DB68iZYH2s0ndeJYSsNojYsAR9YElXDu19TYHRWFX0rFB162Aww==
X-Received: by 2002:adf:ef52:0:b0:33e:790f:c3ed with SMTP id
 c18-20020adfef52000000b0033e790fc3edmr2708916wrp.10.1710485069317; 
 Thu, 14 Mar 2024 23:44:29 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:29 -0700 (PDT)
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
Subject: [PATCH v4 6/7] arm: move image_copy_start/end to linker symbols
Date: Fri, 15 Mar 2024 08:43:50 +0200
Message-Id: <20240315064354.2215266-7-ilias.apalodimas@linaro.org>
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

image_copy_start/end are defined as c variables in order to force the compiler
emit relative references. However, defining those within a section definition
will do the same thing since [0].

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
index 8998c4985eac..ef8af67e11c3 100644
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

