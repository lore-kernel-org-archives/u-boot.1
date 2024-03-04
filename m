Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBADC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1C987F64;
	Mon,  4 Mar 2024 10:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oS5Ezkkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8208187DAB; Mon,  4 Mar 2024 10:01:33 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F321787DAB
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412d501fb96so12006445e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542885; x=1710147685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZqVrolZtjKa0HX67bS1C989QteOSIVgzjajjrEykwY=;
 b=oS5EzkkbwWtF0Rn0CUPXI1j+PYF1tV6m/6aVueQUCsT5mvN1J/8fAFAbpcT+teHjF0
 kpo1o62maU544IF82i9I3gWEp3YnlC3piPLxnC7IxIxo1ZoEvA0FT0xEIwdHZT212RKn
 AFRKdCfjOu2x1NsIBJDtX+8rIlSGytiqRo+JbDWfFZaEuCxRONb40ht2/B8aS1mmZ7Zk
 t0Jl7Xy5iyJYffrakgPpn8mScisw9yqGHkO5ilHjKInRvYtLrnYunWDfsgkqSfdj9zYV
 Qfx+d4O8Bz6czvd/rBcnKMVaO6f9cj1W40d7231QmUPs5aGwdjzQF3esPU78nulpEa9T
 +m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542885; x=1710147685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZqVrolZtjKa0HX67bS1C989QteOSIVgzjajjrEykwY=;
 b=ZiniL+rU/X6Rsl9njLLzxlCpFj1T+Hj4VzZZWGIfPRjzOkio3d++dCS5cVa9c5s5U8
 VR3WGmUddqe+XFr4tPIhHpU9Sxch8R21SDKFGKNHkFxcCQKE4QzokZkcBWqqjcEa6UFG
 h4h+hpwTW7PbqNI8Ia72jeGXTtMkEkPi6Wve5ZAE3/qfAwY1BFoMXETeo9kWX7KX+qGL
 RjKZLtkxfn0HLKdSRpN0AxX7bLGBGMLsqBhNfZHNXNwSMp17iFpsUKs+bkhwWuKKdR7e
 1/lkeFMlgmF+vvKlPMATkvqCFZS0HicYbQSS26BGQKb5q1KZtTpMoJJUmnCRPEw2AU9H
 UqgQ==
X-Gm-Message-State: AOJu0YzC6a3dF4Z2LZDLO5y9zf1Hewah/ZjkzfR2ZWS0oJY70WERBrD6
 nJS34jC/duJtgF3POoFCKvrDP+J0T1r1+OReooABIgNCP1soQomxuDQd5LJtnzSGUSYAibKpRlB
 Vpc0=
X-Google-Smtp-Source: AGHT+IHz35TxCnc85IekKQe+1wdv3dWq4FDddeulZ7+Yw2od4Z3wwBn2JB4S7KbNCJSgibstI5A93g==
X-Received: by 2002:a05:600c:538b:b0:412:b8db:2fd9 with SMTP id
 hg11-20020a05600c538b00b00412b8db2fd9mr6457876wmb.9.1709542885353; 
 Mon, 04 Mar 2024 01:01:25 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:24 -0800 (PST)
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
Subject: [PATCH 2/6] arm: clean up v7 and v8 linker scripts for bss_start/end
Date: Mon,  4 Mar 2024 11:01:07 +0200
Message-Id: <20240304090113.1410575-3-ilias.apalodimas@linaro.org>
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

commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
and
commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
were moving the bss_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code and linker bugs back then
prevented us from doing so.

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable
type with the value being a fixed offset from the base of a section.
This have been fixed since 2016 [1]. So let's start cleaning this up
starting with the bss_start and bss_end variables. Convert them into
symbols within the .bss section definition.

[0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
[1] commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
---
 arch/arm/cpu/armv8/u-boot-spl.lds        | 14 +++-----------
 arch/arm/cpu/armv8/u-boot.lds            | 15 +++------------
 arch/arm/cpu/u-boot.lds                  | 22 ++++------------------
 arch/arm/lib/sections.c                  |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 14 +++-----------
 arch/arm/mach-zynq/u-boot.lds            | 21 +++------------------
 6 files changed, 16 insertions(+), 72 deletions(-)

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
-- 
2.37.2

