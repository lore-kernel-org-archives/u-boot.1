Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BEDC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9EC8808A;
	Wed, 28 Feb 2024 11:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YYZqVqND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7541288007; Wed, 28 Feb 2024 11:48:51 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B432587ECC
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5131c48055cso405158e87.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117326; x=1709722126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scgc+pVaetDvc+SLTh0OKeKO+CQU57WdE9jfttywvow=;
 b=YYZqVqNDO+c63pE/VbrCrrw7IM+U4QuIhmOHpWtUgm0QlbFEv4HLUFVkpyRQ1WNMdT
 uKlWU31RO/8+mwpD4jCUYgQSSelQbAUKjp7WMj3chdM1qSwu//H5sBsrKLJr4zzMpOYK
 L6xnGEFAHZmwpI83mHzDvQsfugQap2sRGhzBsMluX6JyVF87rMs3uRwIx7LD3Ze1u4F9
 Fcyeh5CVJ8thBkqLW+g1dtrDTEjnAU3FUn0d7rggGKMO2km+mwVtuQXQjQLo76yCawWg
 YF3WM54eyC7LoCBHKUaxmMEkx23/xuD+UUH6OSM4xaYciiBo32mDHhIiMi58mduxHkH4
 0Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117326; x=1709722126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Scgc+pVaetDvc+SLTh0OKeKO+CQU57WdE9jfttywvow=;
 b=bhU9Hd7nS06b2t6Kdi3DqcgV+9bWIwnUJGs93843M/FlbVEALrWdn+pAGQE30ER5D/
 zVhanV7CfI18XvkDNO3+aDhzpmOsnbwqMpIBIAmITLGeTZClFGvfJ2LeAGrSMbo3wkdG
 INVz6Xm39Pwk8COVj9tgYNIlmrnAkhslqicX212Sk2dI5DrqEdV2zyNxEDRWi6Ka7dZd
 i0rl6xe6U2qAexcJAKybuF5SDXqbso1GQyRRwawmQLetxh0IJl+/uthnP9LgyboQz61d
 FHH3oVm0oH+s5DofpUiwg49da795z807CDDmxSuC0dJfue7Z7Hq1kY3Ap/V6UdO0vEdF
 +QNQ==
X-Gm-Message-State: AOJu0YygsPL4jRzliwCgGrLyQKghkY752cWzsg06FZh07QCnSPDIRub9
 FbhpnFjCFHKPO8Pr/0Z+2wkj4/l3lmUyd0ErvTMDef56vtUdEGztOJPAuNtSDlx8fh60TF2CEVS
 w6mo=
X-Google-Smtp-Source: AGHT+IF5Hox91fh0ddORqtCb7posn0YWotGIahtd6ECqfe8v/0++PcG59mh9hHhlgPMoQ4aa5yPrNQ==
X-Received: by 2002:a19:644d:0:b0:512:b075:7299 with SMTP id
 b13-20020a19644d000000b00512b0757299mr7873900lfj.35.1709117326056; 
 Wed, 28 Feb 2024 02:48:46 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:45 -0800 (PST)
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
Subject: [RFC PATCH 4/6] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Date: Wed, 28 Feb 2024 12:48:07 +0200
Message-Id: <20240228104811.1366694-5-ilias.apalodimas@linaro.org>
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

commit 47bd65ef057f ("arm: make __rel_dyn_{start, end} compiler-generated")
were moving the __rel_dyn_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code.

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable
type with the value being a fixed offset from the base of a section [0].

[0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds             | 16 +++-------------
 arch/arm/cpu/u-boot.lds                   | 14 +++-----------
 arch/arm/lib/sections.c                   |  2 --
 arch/arm/mach-zynq/u-boot.lds             | 14 +++-----------
 board/qualcomm/dragonboard820c/u-boot.lds | 15 +++------------
 5 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index eccb116d3cfa..e737de761a9d 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -129,20 +129,10 @@ SECTIONS
 		*(.__image_copy_end)
 	}

-	. = ALIGN(8);
-
-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}
-
-	.rela.dyn : {
+	.rela.dyn ALIGN(8) : {
+		__rel_dyn_start = .;
 		*(.rela*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
+		__rel_dyn_end = .;
 	}

 	_end = .;
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 70e78ce46672..7c6e7891d360 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -166,18 +166,10 @@ SECTIONS
 		*(.__image_copy_end)
 	}

-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}
-
-	.rel.dyn : {
+	.rel.dyn ALIGN(4) : {
+		__rel_dyn_start = .;
 		*(.rel*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
+		__rel_dyn_end = .;
 	}

 	.end :
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index ddfde52163fc..1ee3dd3667ba 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -21,8 +21,6 @@

 char __image_copy_start[0] __section(".__image_copy_start");
 char __image_copy_end[0] __section(".__image_copy_end");
-char __rel_dyn_start[0] __section(".__rel_dyn_start");
-char __rel_dyn_end[0] __section(".__rel_dyn_end");
 char __secure_start[0] __section(".__secure_start");
 char __secure_end[0] __section(".__secure_end");
 char __secure_stack_start[0] __section(".__secure_stack_start");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 66a9e37f9198..71dea4a1f60a 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -71,18 +71,10 @@ SECTIONS
 		*(.__image_copy_end)
 	}

-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}
-
-	.rel.dyn : {
+	.rel.dyn ALIGN(8) : {
+		__rel_dyn_start = .;
 		*(.rel*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
+		__rel_dyn_end = .;
 	}

 	.end :
diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
index d3cc5278b610..2969f139bfd2 100644
--- a/board/qualcomm/dragonboard820c/u-boot.lds
+++ b/board/qualcomm/dragonboard820c/u-boot.lds
@@ -69,20 +69,11 @@ SECTIONS
 		*(.__image_copy_end)
 	}

-	. = ALIGN(8);
-
-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}

-	.rela.dyn : {
+	.rela.dyn ALIGN(8) : {
+		__rel_dyn_start = .;
 		*(.rela*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
+		__rel_dyn_end = .;
 	}

 	_end = .;
--
2.37.2

