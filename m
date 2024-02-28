Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33502C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D4488077;
	Wed, 28 Feb 2024 11:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOlztfsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF0887ECC; Wed, 28 Feb 2024 11:48:40 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C558806B
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412b3a69f67so3668845e9.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117318; x=1709722118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1GTVQUn09aQo/8dXfGQL60VoZCH6/FjPHxNOQTK990=;
 b=QOlztfsfLFO69zAyiUavMtQoS5tiJXho26hDlyw0TScLHOvn1GfCZS/RvfhSc+qa7u
 3gz7VuDcjckuTnQAIkwMarbL2qI+10StlSBmEm6X9+H1o4YOg6A2d5UWhZAunEhslSxU
 FUy8jOldoy9pdiaSO7PLLaODdnko9dTzpUMhb/dF27A2tPg/mC8aok9plRfAo4ALNw9P
 YCbcUL1epMUCRORGcDrf7k3gUaxchSpUJ9FwgUbRg5/nCpE94Xdithj0tCcB1HeJbP0A
 Bk+hPYGB8GwK4aRzduSKEsozN75gFZcSDmLdLO/qL2o7gqSHtKFmHPnwY9W8WhVXQ6i1
 z4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117318; x=1709722118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1GTVQUn09aQo/8dXfGQL60VoZCH6/FjPHxNOQTK990=;
 b=aH22EOYgWTozYQe6goEFP4PYHA/Sa5+5UwjPkrZHWr1+ay+sqcZDfwzD36jH7iO61q
 i3ntcwfCg38G06Cavx28Z7EV0L2648b6x258uaD598oFbdcCcS/O8MMcvSgWwfmoMxsv
 ngNVMNgsp8o+hPLA8x9DCxrHrCJ86tB3OxRpgabmXnZMNhkMovZVhNJCATIFj+HmWFhS
 /h4EdWRbeMFPi01JUAhweEd5XUxrw/bFR8jHu+PJJzQEGz5oxnOtioA5CKn6XLX8NNXG
 E4+kYW7kqDp9xn6anyjuWfSPjR0hej+6cEdF2t3LNXrTePAj3j1bIHqYOoxVr7q+0ptq
 8XtA==
X-Gm-Message-State: AOJu0YxkYaJW8noGmYaCFoq0I0MlQeBR8nCMeDYf3oNtopddGuX1p25T
 E54PsmVlMd8o7hwh4rqaJQY3L32v41pAh2id60zSqFQPLjLLW8qq3adyaMR/bevOt0dfQ3rS03Z
 qmYw=
X-Google-Smtp-Source: AGHT+IFeA9rgXFMnFxMhB7dIgXJ9czDoPFeqwmRIy6C8TIApWl9nhDGg42lvDz9GBLB/laclmvljfQ==
X-Received: by 2002:a05:600c:5592:b0:412:6de0:69a9 with SMTP id
 jp18-20020a05600c559200b004126de069a9mr8121961wmb.39.1709117317722; 
 Wed, 28 Feb 2024 02:48:37 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:37 -0800 (PST)
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
Subject: [RFC PATCH 2/6] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Date: Wed, 28 Feb 2024 12:48:05 +0200
Message-Id: <20240228104811.1366694-3-ilias.apalodimas@linaro.org>
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

commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
and
commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
were moving the bss_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code.

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable
type with the value being a fixed offset from the base of a section.

So let's start cleaning this up starting with the bss_start and bss_end
variables. Convert them into symbols within the .bss section definition.

[0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot-spl.lds         | 14 +++-----------
 arch/arm/cpu/armv8/u-boot.lds             | 15 +++------------
 arch/arm/cpu/u-boot.lds                   | 22 ++++------------------
 arch/arm/lib/sections.c                   |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds  | 14 +++-----------
 arch/arm/mach-zynq/u-boot.lds             | 21 +++------------------
 board/qualcomm/dragonboard820c/u-boot.lds | 15 +++------------
 7 files changed, 19 insertions(+), 84 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 7cb9d731246d..16fddb46e9cb 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -63,18 +63,10 @@ SECTIONS

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
+		__bss_end = .;
 	} >.sdram

 	/DISCARD/ : { *(.rela*) }
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f7..c4ee10ebc3ff 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -149,19 +149,10 @@ SECTIONS

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
+		__bss_end = .;
 	}

 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 7724c9332c3b..90d329b1ebe0 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -206,27 +206,13 @@ SECTIONS
 		*(.mmutable)
 	}

-/*
- * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
- * __bss_base and __bss_limit are for linker only (overlay ordering)
- */
-
-	.bss_start __rel_dyn_start (OVERLAY) : {
-		KEEP(*(.__bss_start));
-		__bss_base = .;
-	}
-
-	.bss __bss_base (OVERLAY) : {
+	.bss ALIGN(4): {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(4);
-		 __bss_limit = .;
-	}
-
-	.bss_end __bss_limit (OVERLAY) : {
-		KEEP(*(.__bss_end));
+		__bss_end = .;
 	}

-	.dynsym _image_binary_end : { *(.dynsym) }
+	.dynsym  : { *(.dynsym) }
 	.dynbss : { *(.dynbss) }
 	.dynstr : { *(.dynstr*) }
 	.dynamic : { *(.dynamic*) }
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
index 74618eba591b..b7887194026e 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -56,18 +56,10 @@ SECTIONS

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
+		__bss_end = .;
 	}

 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3b7c9d515f8b..8d3259821719 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -102,26 +102,11 @@ SECTIONS

 	_image_binary_end = .;

-/*
- * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
- * __bss_base and __bss_limit are for linker only (overlay ordering)
- */
-
-	.bss_start __rel_dyn_start (OVERLAY) : {
-		KEEP(*(.__bss_start));
-		__bss_base = .;
-	}
-
-	.bss __bss_base (OVERLAY) : {
+	.bss ALIGN(4): {
+		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(8);
-		 __bss_limit = .;
-	}
-
-	.bss_end __bss_limit (OVERLAY) : {
-		KEEP(*(.__bss_end));
+		__bss_end = .;
 	}
-
 	/*
 	 * Zynq needs to discard these sections because the user
 	 * is expected to pass this image on to tools for boot.bin
diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
index 5251b59fbe76..d3cc5278b610 100644
--- a/board/qualcomm/dragonboard820c/u-boot.lds
+++ b/board/qualcomm/dragonboard820c/u-boot.lds
@@ -87,19 +87,10 @@ SECTIONS

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
+		__bss_end = .;
 	}

 	/DISCARD/ : { *(.dynsym) }
--
2.37.2

