Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED5EC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867CB87FC6;
	Fri, 15 Mar 2024 07:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E0m0uUg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5636A87FC6; Fri, 15 Mar 2024 07:44:23 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3FD87FBC
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e9ba0eadcso1342661f8f.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485059; x=1711089859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0FkfxvHNzcPjTU84NdyO0g39dk0XK67ZiNTuPD1TZo=;
 b=E0m0uUg5n5eEqMAopgfUcTXIAo0YVwtXH6lj7nRiuMNTeY8+cFUvLgUYwkdQnE1/5h
 XHTc49OasG4gYCtevp8P71tWMPVeXtEWUJhZdN8O/d+UBXGZMDRZOg4KkOWru0MbCcA9
 KTKmL1sNdx6LM5vhJctO71QMr3odRAi/xLRA94KIfDRz1r1NrFN9d9BFhSjFhPdQGJwD
 nY1oY3Hp4tt+PvA/qBBvWGwO/2fTq5Zpcs90ePrhV2GiOHb8eqfrIw9wKk5TJjHOAzMt
 9upi94J9qLbi8OQElPMEZf7b4H0gjZI7Y6Ih/R7hAwEHC72kjaZIqzkyDZnEHLUV2Ri7
 NUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485059; x=1711089859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0FkfxvHNzcPjTU84NdyO0g39dk0XK67ZiNTuPD1TZo=;
 b=mwjzO+rut7k0jOJLvIKk50M/NLctXCQvOjZz8kLMaz/N6Yji3801GoGqg6hqkQBons
 VSDYEQ5spwYPM3XutLl8OhR/o/8SR+8fzUL6lF5nbAfJwVT2Ogyzb1Yd2ncDq0e11uDn
 jHbVIQqaq2dARyFXO623A/TbHtqQgzbyLLKxwyQpYEgFrQECy2BO/IIn2s0z44kzBglw
 JTzreX0LFc8eVO/xrjK6THUj02J3xlXlTwffksdYZelQk+O9L5M/1NxY6du0pBZA6Trj
 mrk78IFiztAhTTazsvpWrjiPBUrJymZrCbogIphaR4XnwW5+sTchXxBYtANTHXDOO+im
 Ytwg==
X-Gm-Message-State: AOJu0Yz1aIY1HekC7ddSSqDZsNRiM2SL+fGUrc19AJLr8vMy0B5eKQHA
 GPffALwlf8KXDaSBrUonBqLMUquPZEhYCDRYQn1JYFhWU0yVSsQsIY96hIJ0UV8LXXPvlzvKhp1
 B
X-Google-Smtp-Source: AGHT+IF2pmBhOXKKGe7kqOCP7yRudB50N7HmiXynV7p1KqtPy9iyNFhL5PJdN1In6xugvZT4u05/cg==
X-Received: by 2002:adf:fc0b:0:b0:33e:6ce2:88ab with SMTP id
 i11-20020adffc0b000000b0033e6ce288abmr2668142wrr.46.1710485059307; 
 Thu, 14 Mar 2024 23:44:19 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:19 -0700 (PDT)
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
Subject: [PATCH v4 4/7] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Date: Fri, 15 Mar 2024 08:43:48 +0200
Message-Id: <20240315064354.2215266-5-ilias.apalodimas@linaro.org>
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

