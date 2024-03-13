Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3289C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92AF87EB4;
	Wed, 13 Mar 2024 17:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cEoMUBk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B51787EB4; Wed, 13 Mar 2024 17:23:52 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D038272A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5685d46b199so1803953a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347030; x=1710951830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0FkfxvHNzcPjTU84NdyO0g39dk0XK67ZiNTuPD1TZo=;
 b=cEoMUBk7As5Ffv3YGHtlnNDiTbD0KiDUAyV0kCT6dFlBb25K4jQ1LJOuzr77F4oSGg
 WqrFt3tpTtBSpLB3vehlSrf6EcCDBX175GY3owIMhpbqSjwVe/5DEdFQGYqF44aEIXBb
 lADdIo0zmK9WegC+uo0TXUaLWBfXlZTFiR8CVEn1KDacWZ422HLUG23+UeGZAGTa4q21
 ipKEz6Vv/SY9RQuH0JsGaKE4Cyegor4xSD5Xc9b+1eEjM+p1Uj0q80GP30YrBRqJ5AFV
 OlneGKphWvU8zRPRcVXi7ZLnrNGsEmIR5teMOG8AVWUACE3Hd1fFNFsoGRaCOX/EUxME
 pSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347030; x=1710951830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0FkfxvHNzcPjTU84NdyO0g39dk0XK67ZiNTuPD1TZo=;
 b=KTqIy6gcDxYsBaqF0bVl243XLjRFJmFAxKlkBkRCfHOrv5moS1vGkw4+XVtrd2HevL
 2Ov2a9SzgV4kfyOw5D5IKUPs8OCSwOz01HP+8E4GZCYrhiHqJFJBOLdfZWfJ3wNmmaWP
 BwJixV8wnfzds02OOpiCaEVjEY5oaiaHtV9CArQwKaeapHu7s+YnY2sDGrw3vozdcKVB
 g4U68sdR8/ofrC6h54qqPR9/zG99PPmTuvYbOoF9HTtRTaBhGUwmym5z9O5R//GlvZ85
 KviSgzAcvgbnDIgilmxHB/6mPa2wKBuBJzDbpw5rJ5H14kSv6Wxku0CQk2g4Vu7PHnJf
 6xOQ==
X-Gm-Message-State: AOJu0YxEKt3s38tNh9V507NGeyDBxiTYUtwIhp2wISaeb1lzd2aYYN30
 lnSKOPmO+jxSqa59knCiosTZ8qE0R9M3KOqXjogTR2o9Vnl6psPDg6j6lBI/RUkUTD+uK2nvQnC
 c
X-Google-Smtp-Source: AGHT+IE9i8FY+v7UZ80DbR6Bgx1s6QYrVUCI+TEVHbtaurpN8coIK3NmkEwDPWng0JaQMRQp5Op9vA==
X-Received: by 2002:a17:907:daa:b0:a46:35c9:f239 with SMTP id
 go42-20020a1709070daa00b00a4635c9f239mr6432758ejc.72.1710347029732; 
 Wed, 13 Mar 2024 09:23:49 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:49 -0700 (PDT)
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
Subject: [PATCH v3 4/7] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Date: Wed, 13 Mar 2024 18:23:18 +0200
Message-Id: <20240313162324.2117909-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
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
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot.lds | 16 +++-------------
 arch/arm/cpu/u-boot.lds       | 14 +++-----------
 arch/arm/lib/sections.c       |  2 --
 arch/arm/mach-zynq/u-boot.lds | 14 +++-----------
 4 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 8561e1b3142e..5ba54dcedf24 100644
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
index f19f2812ee91..0682d34207fa 100644
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
index bb0e0ceb32ec..3b1f0d349356 100644
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

