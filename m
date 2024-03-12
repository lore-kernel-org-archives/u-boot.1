Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607EC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC6C87F56;
	Tue, 12 Mar 2024 15:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gBcIsTB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C1987F3F; Tue, 12 Mar 2024 15:08:51 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3086687F80
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5684073ab38so24038a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252526; x=1710857326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjSMhR61rU2pWAjQF3ZKkg2Bp7YMbHLjGk3M7dJ2SI8=;
 b=gBcIsTB6072JGuHQmUl9bmv24GFXO7whtqT+D5Mahhc6+VgCU5a2YlhDPECoRO2j+E
 Ur55z2yaDv2rddnUE8yb1x07FA19FaGK/nzvcsU7M9tHfuUa9rquODWbS0cvQzKpr+//
 85Hxbv18SWNDQPR8scqL1LTVDa6cH8uSPBmtflJ2IB6PrY3h19xY71Dy5DA7Vw7ykF63
 eJUKp5IdJtfrOj5Cu2Bh6zaZ8eRdcHkdV1Wg7NkIdVm0bJmlM8TPFBynkSDyRo/akMGj
 kzrWn9HTuMnrpIrxcutqXr4bUpxzJ53BKCqqNTE2tEg4RWEa53U9t4eBGdGoRwTkWLKF
 yGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252526; x=1710857326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjSMhR61rU2pWAjQF3ZKkg2Bp7YMbHLjGk3M7dJ2SI8=;
 b=eyVbul6zB3CzWiQGiXRQtCqyNXK/g9dDyi/epFtadObrmzHAL+lb/xGPQIE6kFLBfb
 1cAN9QYuqz6KsHkS670GuMHARhly3sHsUF/TdCSMBKcnwaU2/Ew+DMXfWoiuLmn/BnJI
 YgAyMI79N5AQaWwNe8mcjVrviRBrRix4y9V3RLbewnpx67gWMQNJhHA0xQqBxNg39giW
 ckhvyFjEUz+86ZChEi/wT8LWf6erYEq5CLj5z45f3ehWzOC789ZBEDoOhlNanYidIUfs
 U6aELBqBqyEA5DEaus6fT3y07/sucpkcFEY0QAeEma8TnM6nsT4ePq1Vd4WDsWOrivhc
 QaXA==
X-Gm-Message-State: AOJu0YwHo0uGsJACdE89LaGKtk7LRFe5jRU+7m8dqE82eltCCxwXHTXN
 DBN2/43qs2J5RTiplaeDLY6DTuefWPvqK31Xkrgs402Jw1OYY+EAHNdScBRw96hFeEsVPsPnbpU
 4Sr4=
X-Google-Smtp-Source: AGHT+IH5bABDA9belQ8RPBu3NVg53ntpykfCS5HzyEJScSvMVQ9vSf60/LcLtafvN3kooHwbITmIng==
X-Received: by 2002:a50:d595:0:b0:568:335d:1192 with SMTP id
 v21-20020a50d595000000b00568335d1192mr10171004edi.13.1710252526732; 
 Tue, 12 Mar 2024 07:08:46 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:08:46 -0700 (PDT)
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
Subject: [PATCH 2/7 v2] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Date: Tue, 12 Mar 2024 16:08:24 +0200
Message-Id: <20240312140832.1968215-3-ilias.apalodimas@linaro.org>
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

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
---
 arch/arm/cpu/armv8/u-boot-spl.lds        | 14 +++-----------
 arch/arm/cpu/armv8/u-boot.lds            | 15 +++------------
 arch/arm/cpu/u-boot.lds                  | 21 ++++++---------------
 arch/arm/lib/sections.c                  |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 14 +++-----------
 arch/arm/mach-zynq/u-boot.lds            | 21 ++++++---------------
 6 files changed, 21 insertions(+), 66 deletions(-)

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
index 7724c9332c3b..01accb109fad 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -207,23 +207,14 @@ SECTIONS
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
index 3b7c9d515f8b..25c81b21018b 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -103,23 +103,14 @@ SECTIONS
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
+		__bss_end = .;
 	}

 	/*
--
2.37.2

