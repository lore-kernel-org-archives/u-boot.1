Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33D2C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 06:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92AA883F1;
	Tue, 28 May 2024 08:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vbl7HRr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809C4883FE; Tue, 28 May 2024 08:18:35 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42212883F1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e968e77515so4841891fa.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716877112; x=1717481912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WbJfbba4+7V4GIyn1bpcZ++8bK5qZss2u6h7Svoem1E=;
 b=vbl7HRr54TFdVLttK0bEj0Z3nz69D48Ukx7Fyo3g4PaYvjcqqIYNzSgFVujlbihrjj
 7mti6Ml9ChVFcJtfa9TRuBjBQ66rZf+OJ/30llhGL7D4XEMkK4aawDYdb3kXJ/qc50OV
 62SzwewCHf9hB/1fQW85ah5+oDvf8LUFzH8TuV+aa2S1+Ra4B0NPfbbc7IH793SmW04y
 yUxzGHyNf4nqs7zupQGfft4ORJfToNDcsBum17o+nUvzKjgGApgjifspVqRzfHG43PuS
 m7152rReRD8a2RPTAuu1/2Dwux/ulSfNqZ1rJO7uwOMosMsB0HnVdI0zxLs6B4jGTVGc
 +nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716877112; x=1717481912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbJfbba4+7V4GIyn1bpcZ++8bK5qZss2u6h7Svoem1E=;
 b=geWU3ky01PFqoKI2hsmbxQMIocMRxPsxcpW+AgOQ+pRDIdXI4AV5nu7wNWD9bR6ZrL
 54tXsAQFSljCgeBA/m5KerMycuIPzYzZ8+uRb781vB3vwvUZMXBrnXflMNFlst0hauPx
 cHENCzwmvmk9aCymWVwjxzoHgiaOhnRtTk2+JunxgiJjFjAqOEzNt7Lr8Gxm8KYE3rLC
 LsNUoYEjC6fntlRV4yYWbCT9myUt3tyuBjC+ZiDBV4k2fdQN4BeYIkdpiitAECWQTTg+
 rjIyX4FvSAKh4ftOEfMtb1ViGmJztXvnPWgK7m9qWTE6TNuI8MticW+/coD635D1Zii8
 BXcQ==
X-Gm-Message-State: AOJu0YysJIMt8gebM32S0hueSx5mpChbj9WNLmtUt/pEPMTKUT+ZRKgt
 mK29mPfMac6Fp1zrXNL4hm4UwIzT1An19/rR2NaeWat1+zQ+vnOx+O/ZnbOFH0TI1ACxSXVyPo4
 W
X-Google-Smtp-Source: AGHT+IFeeDQu5EZcJNdGOT9kYlVOzRp+Y45CKtu3i8zw2o4qkkZucWfEFy4dZYTqOn/azpw7wDKG1Q==
X-Received: by 2002:a2e:9613:0:b0:2e9:8b66:684 with SMTP id
 38308e7fff4ca-2e98b66071fmr91391fa.3.1716877112284; 
 Mon, 27 May 2024 23:18:32 -0700 (PDT)
Received: from hades.. (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f1ad4bsm163039255e9.19.2024.05.27.23.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:18:31 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de, xypron.glpk@gmx.de, CFSworks@gmail.com,
 trini@konsulko.com
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au, eugen.hristev@collabora.com,
 sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 michal.simek@amd.com, aford173@gmail.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] arm: move _end to linker symbols
Date: Tue, 28 May 2024 09:18:27 +0300
Message-Id: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts")
was cleaning up linker scripts for armv7 and v8 but was leaving
_end and __secure_stack_start/end.

commit d0b5d9da5de2 ("arm: make _end compiler-generated")
was moving _end to be compiler generated. _end is defined as c variable
in its own section to force the compiler emit relative a reference.
However, defining those in the linker script will do the same thing
since [0].

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols.
It's worth noting that _image_binary_end symbol is now redundant and
can be removed in the future.

- SPL

The .end section has been removed from the new binary
[ 5] .end
     PROGBITS         00000000fffdf488  000000000002f488  0
     0000000000000000 0000000000000000  0                 1
     [0000000000000003]: WRITE, ALLOC

$~ bloat-o-meter kria_old/spl/u-boot-spl krina_new/spl/u-boot-spl
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=115980, After=115980, chg +0.00%

$~ readelf -sW kria_old/u-boot kria_new/u-boot | grep -w _end
 12047: 000000000813a0f0     0 OBJECT  GLOBAL DEFAULT   11 _end
 12047: 000000000813a118     0 NOTYPE  GLOBAL DEFAULT   11 _end

$~ readelf -sW kria_old/spl/u-boot-spl kria_new/spl/u-boot-spl | grep -w _end
  1605: 00000000fffdf488     0 OBJECT  GLOBAL DEFAULT    5 _end
  1603: 00000000fffdf498     0 NOTYPE  GLOBAL DEFAULT    4 _end

$~ readelf -sW old/u-boot new/u-boot | grep -w _end
  8847: 0000000000103710     0 OBJECT  GLOBAL DEFAULT   11 _end
  8847: 0000000000103738     0 NOTYPE  GLOBAL DEFAULT   11 _end

$~ readelf -sW old_v7/u-boot new_v7/u-boot | grep -w _end
 10638: 000da824     0 OBJECT  GLOBAL DEFAULT   10 _end
 10637: 000da84c     0 NOTYPE  GLOBAL DEFAULT   10 _end

- For both QEMU instances
$~ bloat-o-meter old/u-boot new/u-boot
add/remove: 0/0 grow/shrink: 1/0 up/down: 20/0 (20)
Function                                     old     new   delta
version_string                                50      70     +20
Total: Before=656915, After=656935, chg +0.00%

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/arm1136/u-boot-spl.lds            | 6 +-----
 arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      | 6 +-----
 arch/arm/cpu/armv8/u-boot-spl.lds              | 7 +------
 arch/arm/cpu/u-boot-spl.lds                    | 6 +-----
 arch/arm/cpu/u-boot.lds                        | 6 +-----
 arch/arm/lib/sections.c                        | 1 -
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 6 +-----
 arch/arm/mach-at91/arm926ejs/u-boot-spl.lds    | 7 +------
 arch/arm/mach-at91/armv7/u-boot-spl.lds        | 7 +------
 arch/arm/mach-omap2/u-boot-spl.lds             | 7 +------
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds       | 7 +------
 arch/arm/mach-zynq/u-boot.lds                  | 6 +-----
 board/davinci/da8xxevm/u-boot-spl-da850evm.lds | 7 +------
 board/samsung/common/exynos-uboot-spl.lds      | 6 +-----
 14 files changed, 13 insertions(+), 72 deletions(-)

diff --git a/arch/arm/cpu/arm1136/u-boot-spl.lds b/arch/arm/cpu/arm1136/u-boot-spl.lds
index f83988fd7e6a..b7af29183a97 100644
--- a/arch/arm/cpu/arm1136/u-boot-spl.lds
+++ b/arch/arm/cpu/arm1136/u-boot-spl.lds
@@ -33,11 +33,7 @@ SECTIONS
 	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
 	. = ALIGN(4);
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	}
+	_end = .;
 
 	.bss :
 	{
diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
index 7e20448f8108..7c6309246f8b 100644
--- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
+++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
@@ -49,11 +49,7 @@ SECTIONS
 		__bss_end = .;
 	}
 
-	.end :
-	{
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 	.dynsym _image_binary_end : { *(.dynsym) }
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index ef8af67e11c3..215cedd69a8c 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -53,12 +53,7 @@ SECTIONS
 
 	. = ALIGN(8);
 	__image_copy_end = .;
-
-	.end : {
-		. = ALIGN(8);
-		*(.__end)
-	} >.sram
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss : {
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index 9ed62395a9c5..eee463a1b1c6 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -53,12 +53,8 @@ SECTIONS
 		__rel_dyn_end = .;
 	}
 
-	.end :
-	{
-		*(.__end)
-	}
-
 	_image_binary_end = .;
+	_end = .;
 
 	.bss __rel_dyn_start (OVERLAY) : {
 		__bss_start = .;
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 707b19795f08..2f50087f57a9 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -166,11 +166,7 @@ SECTIONS
 		__rel_dyn_end = .;
 	}
 
-	.end :
-	{
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 	/*
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index db5463b2bbbc..07efabaa7dc8 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -23,4 +23,3 @@ char __secure_start[0] __section(".__secure_start");
 char __secure_end[0] __section(".__secure_end");
 char __secure_stack_start[0] __section(".__secure_stack_start");
 char __secure_stack_end[0] __section(".__secure_stack_end");
-char _end[0] __section(".__end");
diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index ada6570d9712..9502a7384b53 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -61,11 +61,7 @@ SECTIONS
 		__rel_dyn_end = .;
 	} > .nor
 
-	.end :
-	{
-		*(.__end)
-	} > .nor
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss : {
diff --git a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
index 1a8bf94dee0c..09cf838cf96e 100644
--- a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
+++ b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
@@ -33,12 +33,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	} >.sram
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss :
diff --git a/arch/arm/mach-at91/armv7/u-boot-spl.lds b/arch/arm/mach-at91/armv7/u-boot-spl.lds
index 6ca725fc4ce0..460a91d93ec4 100644
--- a/arch/arm/mach-at91/armv7/u-boot-spl.lds
+++ b/arch/arm/mach-at91/armv7/u-boot-spl.lds
@@ -40,12 +40,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	} >.sram
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss :
diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
index 1d6e5d45b468..3bb759d8a1c8 100644
--- a/arch/arm/mach-omap2/u-boot-spl.lds
+++ b/arch/arm/mach-omap2/u-boot-spl.lds
@@ -39,12 +39,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss :
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index ad32654085b3..958a1b70aefe 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -46,12 +46,7 @@ SECTIONS
 
 	. = ALIGN(8);
 	__image_copy_end = .;
-
-	.end : {
-		. = ALIGN(8);
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss ALIGN(8) : {
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3e0c96c50556..f52523edf490 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -68,11 +68,7 @@ SECTIONS
 		__rel_dyn_end = .;
 	}
 
-	.end :
-	{
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 /*
diff --git a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
index 7e0f09f3b5b1..56d6f4f114b9 100644
--- a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
+++ b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
@@ -46,12 +46,7 @@ SECTIONS
 	} >.sram
 
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	}
-
+	_end = .;
 	_image_binary_end = .;
 
 	.bss :
diff --git a/board/samsung/common/exynos-uboot-spl.lds b/board/samsung/common/exynos-uboot-spl.lds
index 73cd97a1b1de..9d3b57e98dbb 100644
--- a/board/samsung/common/exynos-uboot-spl.lds
+++ b/board/samsung/common/exynos-uboot-spl.lds
@@ -41,11 +41,7 @@ SECTIONS
 	. = ALIGN(4);
 
 	__image_copy_end = .;
-
-	.end :
-	{
-		*(.__end)
-	} >.sram
+	_end = .;
 
 	.bss :
 	{
-- 
2.40.1

