Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2175FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03DC87F71;
	Tue, 12 Mar 2024 15:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+U+usi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DD187F8E; Tue, 12 Mar 2024 15:08:59 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7065D87F71
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5684f95cc9bso4243931a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252537; x=1710857337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMOxHHM+Unoaq3XyIs2oq1LjRVh47AY5Cd39Hcukh3E=;
 b=J+U+usi1nUPEF3LGPJmDy9IZJS4HkjH0ZGu5hwlwU+m1MPh5up3QDlmyNCnPWRI21s
 +Lm71YxmP2ESqWfsenbHaK54BKKE1OnGf8VizSuqIyWWdIxxW3DuVVOe/awmGH3rAXLf
 TgamCjBkadZdxEfXDlPlCQIwGX7yOoGM4njnMBa+6tiN3bEruLDeRz9gi3jtfLLg/Y9w
 xCM9jdHnWPIkFmFtcmkUyzYM3m0OdfbF+ND5WLj/JvAeh3OZVUAvX6DZ9E1SZluB4pOP
 JOak60sUHn261akyoCPCc4DypnZY4xpFI/fj/ztY+k/jH6MzFAcyHF4NMhKZp4Y5lkcg
 rdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252537; x=1710857337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMOxHHM+Unoaq3XyIs2oq1LjRVh47AY5Cd39Hcukh3E=;
 b=GU6drGqG2Dhix+xG0zPJljk1Q122+W+8HO8Ob3wO9C6DfHE/Bbnp56eIv+h9wSiURF
 KBLTWm7vO4Lw94enq/gUAeBuK0OVAZH76+Vfp8SbRQv5V8j0Q3jgwd/te1GSxsw1aTgE
 y9pxms2FXXhrblNCGrSUi4RUUqUm/ZtUl6hHw/3dVwQT7DpYUgchoGuxVSHJ6ixFz3S8
 hLGhQTUJynOXW8e4LXLA8Y7wOsEXWCoyOsW7DPJIBfk98sFXr3ErPRXvkAv7I2yB7m2i
 0p6WuJZwYhBVplXSlC7FXq/JrCUlfAmrVUIDtUjgYEYaaKvlstbO2WFC180u+8MaDrGo
 DR0A==
X-Gm-Message-State: AOJu0Yw0lbIKU3xyrnIh/V6zabrCT5L9KHrOcohL3Gy7y0Ad9vpXZvPT
 pRKIWU0R0isPKvCNWxTNKZsHA7rqbmopomJFz/PF8l+Wuu9MimWK6vbu220QFBB3Oq13fB851tR
 rQQg=
X-Google-Smtp-Source: AGHT+IECegzFFndq5BpTGNLtjNaNTglGEI4NIcB6k0CQ/MXkHQtNt/11drU3NQ9+rhcQ9YRf95RADw==
X-Received: by 2002:a50:d782:0:b0:567:f475:6c6b with SMTP id
 w2-20020a50d782000000b00567f4756c6bmr10048088edi.8.1710252536840; 
 Tue, 12 Mar 2024 07:08:56 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:08:56 -0700 (PDT)
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
Subject: [PATCH 4/7 v2] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Date: Tue, 12 Mar 2024 16:08:26 +0200
Message-Id: <20240312140832.1968215-5-ilias.apalodimas@linaro.org>
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

commit 47bd65ef057f ("arm: make __rel_dyn_{start, end} compiler-generated")
were moving the __rel_dyn_start/end on c generated variables that were
injected in their own sections. The reason was that we needed relative
relocations for position independent code and linker bugs back then
prevented us from doing so [0].

However, the linker documentation pages states that symbols that are
defined within a section definition will create a relocatable
type with the value being a fixed offset from the base of a section [1].

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
[1] https://sourceware.org/binutils/docs/ld/Expression-Section.html

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
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
index 37f4cd27d79a..b1065ec8063d 100644
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
index 11b6e7278a9c..16245fd4ac2f 100644
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

