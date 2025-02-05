Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D96BC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41911800B3;
	Wed,  5 Feb 2025 02:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P23qhF+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9DD80087; Wed,  5 Feb 2025 02:56:27 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A275780040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f4c111991bso213188eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720582; x=1739325382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOt0b0mH1BK8cVbF7jaM0+0FSK7pJbFDEwCGBqAsPco=;
 b=P23qhF+MxFpH3xJXhADeW2AMOMfsuOVn/TMcpQFVNtRc5eIjXQeHiCWdFS5RAZ4l3B
 8GMOCqYa0h0oSQwe2yYCNR/4TLS0OAKHq8bwRAVVODgvPjLTRNVc5UV7EWvQY/2bvNT5
 ShFh/M5X+ET4eTj6JlIkfhJR7fQstwiJtaLIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720582; x=1739325382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOt0b0mH1BK8cVbF7jaM0+0FSK7pJbFDEwCGBqAsPco=;
 b=BEduptRQoymAn6BNN0diK1ALJyidWR1RC8uUSqevgI9erx7/6s8AFlZsvaHb+bfr6c
 edYFY4MCHbs91NayyWk9AQJRAnNckSK8SNlKEMnMcaBIm/0t5mQT3/Y0axQW7sawd/DB
 A35sJ06+Q+uiBPOK/9D5K/qC3jP57fcyRn01ndvgjk6ah9+RT70K+eDTSNPzkoqzcyJK
 tSFW0mlAD1Mb1E7IaKRnuaSvqyZsUiFGLkYbWYxxnF9zD9P1oM/8GN2FW+byLFz077lZ
 Da6aHgSZho41cQU+jh1fQQfbA0Exrp5zXh1jzTdgUo18Svg7tvDaCoHm08AEk7BUh1iL
 36Nw==
X-Gm-Message-State: AOJu0Yx6KGNqnFTLXJqYijYZkRvdqjK60tBshvU/eZhgDYyusDIxhtIP
 who9OTd1kUPxmM07BZnIHmiTcAWjf/nBEIIsWpM9RiA8XGaU2Wfa6I3t3A9QApWrYGxWNQP6+RU
 =
X-Gm-Gg: ASbGnctx2V2PhQVQ9FR784Ojd69K+9j3RNzkWHHm6XHBg/q2tg3hRtfsDLr3S14+2QN
 OCLJXrUNpbYqhwZ3RipmrQWlG4kTBp5jE9g1NfiOVayS8s/8L8OQafbK1dfhagrNFLsGRlM4ASs
 f+IWW7sDrWpta/yg+3XP488HRAhbxSLCO59juvBrpyuTtg6xl/Hllecb4Onr/n28iujvmK6lZif
 D4uduIt2Fl0+adNsBg0JfhnATjobWRkf+9+ZVKFTmYgzQpZjF5LpScaOm/OpeHbSUDskcZ1+hks
 94bwHl1/R1JeQq8GCrekjfMugKlm+T9rbVH8YA6tHJz48Hh/IrPg
X-Google-Smtp-Source: AGHT+IEk4u4MAI/e7kUbgVzbys9j6ey0+y5AACg0TmHmJwFzGl4stvYFmxqNXoM7fp+wKdT5kMbQqg==
X-Received: by 2002:a4a:c816:0:b0:5f2:b1cb:3efe with SMTP id
 006d021491bc7-5fc3bf86f09mr3286666eaf.4.1738720582459; 
 Tue, 04 Feb 2025 17:56:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/29] arm: Support a separate stack for VPL
Date: Tue,  4 Feb 2025 18:54:51 -0700
Message-ID: <20250205015606.2686149-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

VPL has the same needs as TPL in situations where the stack is at the
top of SRAM. Add an option for this and implement it for arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/crt0_64.S |  4 +++-
 common/spl/Kconfig.vpl | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 32401f544a7..122e0217470 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -71,7 +71,9 @@ ENTRY(_main)
  */
 #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
 	ldr	x0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#elif defined(CONFIG_VPL_BUILD) && defined(CONFIG_VPL_NEEDS_SEPARATE_STACK)
+	ldr	x0, =(CONFIG_VPL_STACK)
+#elif defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
 	ldr	x0, =(CONFIG_SPL_STACK)
 #elif defined(CONFIG_INIT_SP_RELATIVE)
 #if CONFIG_POSITION_INDEPENDENT
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index cf6b36c8e38..d4d4a00d99f 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -252,6 +252,12 @@ config VPL_SYS_MALLOC_SIMPLE
 	  this will make the VPL binary smaller at the cost of more heap
 	  usage as the *_simple malloc functions do not re-use free-ed mem.
 
+config VPL_NEEDS_SEPARATE_STACK
+	bool "VPL needs a separate initial stack-pointer"
+	help
+	  Enable, if the VPL stage should not inherit its initial
+	  stack-pointer from the settings for the TPL stage.
+
 config VPL_TEXT_BASE
 	hex "VPL Text Base"
 	default 0x0
@@ -266,6 +272,13 @@ config VPL_MAX_SIZE
 	  The maximum size (in bytes) of the TPL stage. This size is determined
 	  by the amount of internal SRAM memory.
 
+config VPL_STACK
+	hex "Address of the initial stack-pointer for the TPL stage"
+	depends on VPL_NEEDS_SEPARATE_STACK
+	help
+	  The address of the initial stack-pointer for the TPL stage.
+	  Usually this will be the (aligned) top-of-stack.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.43.0

