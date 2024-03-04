Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43343C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8310487F83;
	Mon,  4 Mar 2024 10:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B0S22Y3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4583386FCE; Mon,  4 Mar 2024 10:01:49 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7509187F28
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d23d301452so46281081fa.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542902; x=1710147702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ba2b40JJAidxDBZft3tGbXqFh+NaL3j2Px1KpWXlUIg=;
 b=B0S22Y3kPAu2nIK8GJ8GTxc3kZL/AcHLJ9GwCk3T2LLhUhdNelj0I/WkwDsV8mPalC
 gVk3Ykr+LvbDMkztZMktrgtNlCi/KfhsU0+3jJUKxgVgYFbZZph70ASWm4JDd2N/2CJX
 gG3S85rHuuWMUa4gMTuPOvbWllTxfEtSi1bPMYuF0yh9GEHcJlgFkc33ohyzy8hN4OGM
 fadIOAC7YmvKhg1me5FDY0elhmhcQ9VMWjr/6XfMH/QBUuFQKdjxJ0+WTzrW/G2g6Vun
 vhjoD3ZaCUHWV1wghoBuEBM0vT0qplOyWmDlS6QXl92HaS51FeDxAJD82US29Mc9ChxE
 7N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542902; x=1710147702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ba2b40JJAidxDBZft3tGbXqFh+NaL3j2Px1KpWXlUIg=;
 b=b8zL7QwvKjc+/qb6EuMPxPcGhWeY93besFdR6OMHPOMZaCtzrFcOh3w+XODPPUjfIg
 89m3xJnZ4lLUT8xx69OTtOY3NH/Z1bigPxzcRCwEBkNK4faaDkGHilkqzWFjrMA/YJku
 7jX3XtgluLWg73pAcahdFVJmnsY1kPTbT2kk12goreCfNcBzic2c16nmuLOYttdwa+PZ
 Sv64xcDPBsgkR3T0CbVIir+MwhvtQehmubYPxlNOKeOW+57uhqoHnx0AEN/vWc/KVpsb
 pOk/6L67fB3KWBZay0vb1xPqhTbPLXDHenXlEmay7PfXXJ9xy0eNrChkCBqRU2cHZlUv
 WT7A==
X-Gm-Message-State: AOJu0Yzwxx8fxdItb/WIUYKt+DGinPneajJFWqdDa9l17vnDU+Qj2KAR
 xZKotkjXOwB5po8lOLkd/PaFyAjkRc5lubGgB1+urS+WOYa7k2e7eWEAa6ndniS7tsHOlGWlJKe
 S5+I=
X-Google-Smtp-Source: AGHT+IHw1KC7RNJPTP/FhZUfa6H2ztMmrfXKtvALZICf6HXz0kcMe+L9EXiK9QV3xiznzmI1Ey36Ww==
X-Received: by 2002:a2e:9b0e:0:b0:2d2:e51f:2ba2 with SMTP id
 u14-20020a2e9b0e000000b002d2e51f2ba2mr6161208lji.21.1709542901813; 
 Mon, 04 Mar 2024 01:01:41 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:41 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 6/6] arm: move image_copy_start/end to linker symbols
Date: Mon,  4 Mar 2024 11:01:11 +0200
Message-Id: <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
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
 arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
 arch/arm/cpu/u-boot.lds                  | 10 ++--------
 arch/arm/lib/sections.c                  |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
 arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
 5 files changed, 8 insertions(+), 31 deletions(-)

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
-- 
2.37.2

