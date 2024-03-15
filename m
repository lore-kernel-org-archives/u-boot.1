Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AEBC54E66
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53A587F8F;
	Fri, 15 Mar 2024 07:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FRPCqkll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CE187B89; Fri, 15 Mar 2024 07:44:12 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF8187FA7
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ec8f13c62so977797f8f.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485049; x=1711089849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8hGzCIBbvwzy4XqlUTV3kP+YuKho4u2EeBDL6jmh30=;
 b=FRPCqkllSyNY9+fwH4KXgLcYaJrbU0tAgMykHn+Ni03VtfOH9PBFcj/PUh5qMaUXfj
 1zW6a7X8djuAdqe78H3mhPnuRLiJn+cTpwWQM1zTiFA9T/psLsNwZVICtl18tH7kVXbv
 BT5GN/+kK8KfrurJMVlapUYDVaRryMgBda1+NmxiutzNZoJnIlfXaPmfowLGpWkLar5e
 AOcg1ygvucsxzrZjFaRiL2KJXcXsE7iQVs05tgIJcCebPeagx0ttz/53GQaBh82f2O5G
 kS+QR8uu35MB1lTbdeugY3tamL4psWuZ9E/CrZv7io+YOwcXmQc8gnco+97u/UR1XvIS
 t9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485049; x=1711089849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8hGzCIBbvwzy4XqlUTV3kP+YuKho4u2EeBDL6jmh30=;
 b=bwBm/k+s/cZEmNERpyRf2mfsy5YDLvfxvWfK7CRNDDdTZjJViMT05NPmOUSscNwssi
 mYU9CE2fpivS3zAS+VSe9KYHMuPB+upd2Dt1ULtHxJoWHR1gkjTOROC2lutTGOEKW0Ra
 vY0okkarqcasBx14FB7YSMPEklqxeasQEO1fmCNqqzcqBFc3WppkzymKXwN6slNPisdF
 NNn3uJshmCvOKpBpFNQ0fXq4Vmg/G+OUe+yeSFSqfEPl0ww204/9pk/3ZyMiptQld8qo
 cZkB9/uGEO1WHyvukx7qgd6ZVOwI9VanyXf5tM4EuQ7AWNHRvcU98Tl3p3QZeCYtAB3W
 aonQ==
X-Gm-Message-State: AOJu0YytQb9FhjCfyJ70nNit6Krk5sGpgUXFCZUF50QY7TFFcpCKuJ7L
 tfaHeGWpq8Nn9MjgDIv17sUfxHNcw0SLnVocR09jJ4T+gULVy4LBfuZ0o1Sh+Bhq5slBXXfoLSu
 z
X-Google-Smtp-Source: AGHT+IFsYnsJV3Bwsam2JtcHS53VB3dTjxu6sg6csapkgM98MxyoLcR/G1IeUfisBJa4NyPeul20+A==
X-Received: by 2002:a5d:468e:0:b0:33d:c5c5:9bc6 with SMTP id
 u14-20020a5d468e000000b0033dc5c59bc6mr1641446wrq.54.1710485049492; 
 Thu, 14 Mar 2024 23:44:09 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:09 -0700 (PDT)
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
Subject: [PATCH v4 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Date: Fri, 15 Mar 2024 08:43:46 +0200
Message-Id: <20240315064354.2215266-3-ilias.apalodimas@linaro.org>
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

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot-spl.lds        | 18 +++++++-----------
 arch/arm/cpu/armv8/u-boot.lds            | 16 ++++------------
 arch/arm/cpu/u-boot.lds                  | 22 +++++++---------------
 arch/arm/lib/sections.c                  |  2 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 15 ++++-----------
 arch/arm/mach-zynq/u-boot.lds            | 22 +++++++---------------
 6 files changed, 29 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 7cb9d731246d..8998c4985eac 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -63,18 +63,11 @@ SECTIONS
 
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
+		. = ALIGN(8);
+		__bss_end = .;
 	} >.sdram
 
 	/DISCARD/ : { *(.rela*) }
@@ -89,3 +82,6 @@ SECTIONS
 #include "linux-kernel-image-header-vars.h"
 #endif
 }
+
+ASSERT(ADDR(.bss) % 8 == 0, \
+       ".bss must be 8-byte aligned");
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index fb6a30c922f7..9640cc7a04b8 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -149,19 +149,11 @@ SECTIONS
 
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
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 7724c9332c3b..0dfe5f633b16 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -207,23 +207,15 @@ SECTIONS
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
+		. = ALIGN(4);
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
index 74618eba591b..712c485d4d0b 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -56,18 +56,11 @@ SECTIONS
 
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
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/DISCARD/ : { *(.dynsym) }
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 3b7c9d515f8b..3c5008b57392 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -103,23 +103,15 @@ SECTIONS
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
+		. = ALIGN(8);
+		__bss_end = .;
 	}
 
 	/*
-- 
2.37.2

