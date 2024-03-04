Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30B7C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA37D87F92;
	Mon,  4 Mar 2024 10:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LUyOtNj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C7887F6E; Mon,  4 Mar 2024 10:01:40 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CB187F28
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5133bd7eb47so1865389e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542894; x=1710147694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miWJzpqurM+VmlP/r9jZ19udSDm22BVr4HHLpQPkrYQ=;
 b=LUyOtNj8mcr+YekZL19byosEjBatYmtkSvhFXOIFEJ0mQOgfjjABxvXBoSl1rTaZXD
 ZiJ0wr88dHqbXQgQZ5KRE5lJnMAxgR4nIYID600Vqb003/xfuvz/PKa1uFZO9Ocwfkdw
 mY3UYu4jp/i8v5ehStrO6xyXV4Ppv46WsxBXeUEI/bTQqcnuZXO2LmPNRI/rCSG9Hn9P
 5mVD/2PLsPFXqcFJOPqCovukqZfDf8sHCIR+NUXkRyl1CU5js7CrJcpxsWTzbg1Luwr/
 TXTLVuIZGm4e1dN15ttoZQp8MyxchB9XimQR7uuvp3NVUoJl4I5F+zma+w8eTuQQrMLu
 cH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542894; x=1710147694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miWJzpqurM+VmlP/r9jZ19udSDm22BVr4HHLpQPkrYQ=;
 b=Uoehwf25NLXOBCJcnpvr7Heb9JxOpJeOa6LfhalLzWiyRomQCXjRMXD0Ic3yfedBbq
 cpclNYxmtVgGMTtOG/NttyFrXShiSIPTP7iLp0suptT+rZtqurEDjS4wKop8x3uleS1R
 pU2Uv17hEXhTcETlvWX+ssoMBUVLoGxGJwX/pyQjCN6ReFtCegM1mRADbqh4CeHd69Tw
 dw8fycsYqLx2Tdrz3YYBCT18Vx0wRckK2Z0l0CVd1/1mdIa7RaOqN8X5qtY/JVN0nrqD
 ZgZhbGFd1EjXcV9fGeKwdMvRHuaq5y2KgXUduzIbjpHllIymYVF1GQK3cnmIgX6cMBFl
 kxCw==
X-Gm-Message-State: AOJu0YwloW8juNMvOvmv8zfvapcUZU+KXszBepYvoyPwo1wkc0sxUpOP
 0HN/5nBr2GJMvhfAkdWgkbMNVVOHZWlEMGjaVxHQatZWk5Oeh1Zsr87dffg70C+29OzvVJAEUV1
 i8F0=
X-Google-Smtp-Source: AGHT+IFLIN8wH5M6p9XRMKQYXIuHZj29Fd4yrJYO7qwNM1phtZZRPmuAsyzocf4XKLEPtwO8y3fzkA==
X-Received: by 2002:ac2:46dc:0:b0:511:a4c9:a010 with SMTP id
 p28-20020ac246dc000000b00511a4c9a010mr4226181lfo.38.1709542893433; 
 Mon, 04 Mar 2024 01:01:33 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:33 -0800 (PST)
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
Subject: [PATCH 4/6] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Date: Mon,  4 Mar 2024 11:01:09 +0200
Message-Id: <20240304090113.1410575-5-ilias.apalodimas@linaro.org>
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

commit 47bd65ef057f ("arm: make __rel_dyn_{start, end} compiler-generated")
were moving the __rel_dyn_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code and linker bugs back then
prevented us from doing so.

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable
type with the value being a fixed offset from the base of a section [0].
This have been fixed since 2016 [1]

[0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
[1] commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds | 16 +++-------------
 arch/arm/cpu/u-boot.lds       | 14 +++-----------
 arch/arm/lib/sections.c       |  2 --
 arch/arm/mach-zynq/u-boot.lds | 14 +++-----------
 4 files changed, 9 insertions(+), 37 deletions(-)

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
-- 
2.37.2

