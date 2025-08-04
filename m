Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392C5C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB8A83FF9;
	Mon,  4 Aug 2025 23:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ohR23zlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0895583FED; Mon,  4 Aug 2025 23:54:32 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA96883FE9
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e3e4c564ffso32184525ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344468; x=1754949268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oj00U459fv75J5wso52WEca0eopORwbgTxfzvXiT7RE=;
 b=ohR23zlHBp8WhZFod1Iyh2Liw/t/Mv47CZzAw+hKTw3N9UFeH8mT/q0h2P/F8D6k20
 XtP2vWUp0uriVZENJvr+zHUgq0tuDbINRZtPrjkD9UZBYPykgwSca02gMiJcyz3mBjKC
 90EDC/HkS8+qZpZ7YH3LYt7yZXloAJILDpCOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344468; x=1754949268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oj00U459fv75J5wso52WEca0eopORwbgTxfzvXiT7RE=;
 b=eWaUDgbFPrOaUkC5DvZmdRAKwi1sz7UCycb2IX9Nfhnz98rLdsFLkYCA6ZhISW3oVZ
 TuvOJoaEFfVcpJ9Bpsvi6aMMbFIVOZWcX8QSuUJTWKmVNGANH9gU+2UFOauERBQUUK06
 310FBpDzoQnMlXbbpyvPK0u6AhBiLr7XyI2W9S7OhfdKG/tuBi6lrBhlsRMuWICkL+eB
 Qq6DCOmZNxiweW0PZU8Bthws1RkBxSNSes285EhbYdkENBjfZVeI2bxRnNe6E+2QjWTr
 UgsvsZEpBD053NOHCZxVLhJJtweg7v4hwLBkd4b35B1ikYMnSiuqJ8RIQ4Wv45T0uzIv
 XL8w==
X-Gm-Message-State: AOJu0YwZmUTgHxEecoZGr/Jbm5e1TXeD16slhdPnUqJ3FhsKjUAH26EF
 AjRHCriutrUNateLytFlYEEpq4/tpjgyRgo3XdzrzPRxu8c2qIxKTxffCRt4Q4gM0RmymTc4hxL
 qfYFXszs=
X-Gm-Gg: ASbGncu+DulNayTqm/5SBRvKXToGD3GvWW2dO6Ii+Rp1qlZhi8fdn4s7E4/4zRUguWy
 c8aDlP/JAHdK0Ht+1cXYImetu82OURONbUULsbx/c4VEazB0lyaCXCE/IPYkoMDbd7l7jboB3rt
 X6sjpugSlJNcq3/d7ADKAhYnaOYWr1W7veCfy/Ej2DZbdRIkYCeG1pilrmZ/FcGbQbQftwWKpod
 oq7r/VEM9XArg72eaC5fIO1esU1VwwUassLY1INU6vRtxXr2WCTS+kK0c6VihQAPl65gexJ8NBs
 YuaMocbo0pQTARdEfUPGpDAS3k8PZ9Mi7RVjvkgYd7LykWoyo12mmwlN/WMJXmmpxzGPgbIgals
 QoNjiqh6a7ZWJ108JGyLIIURcuHJJcLwQtPjJKAlOosK8mbJsuFvNthcSD2ATJYfKBY8P
X-Google-Smtp-Source: AGHT+IFDw4C+izul8hG/6DOgIczt22ytqX/BoRz+l9ptt7gd9Y9Y5bpZYwsEMu86jnYycK96oqCTIw==
X-Received: by 2002:a05:6e02:2683:b0:3e3:d515:cf98 with SMTP id
 e9e14a558f8ab-3e4161cc26amr200756105ab.20.1754344468487; 
 Mon, 04 Aug 2025 14:54:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a7ff89f02sm1996337173.31.2025.08.04.14.54.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:54:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] reset: Tighten some reset driver dependencies
Date: Mon,  4 Aug 2025 15:54:25 -0600
Message-ID: <20250804215425.1412704-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215425.1412704-1-trini@konsulko.com>
References: <20250804215425.1412704-1-trini@konsulko.com>
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

A few reset drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/reset/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index e92bb8a7c39d..74c267dfc4e5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -74,8 +74,8 @@ config RESET_UNIPHIER
 
 config RESET_AST2500
 	bool "Reset controller driver for AST2500 SoCs"
-	depends on DM_RESET
-	default y if ASPEED_AST2500
+	depends on DM_RESET && ASPEED_AST2500
+	default y
 	help
 	  Support for reset controller on AST2500 SoC.
 	  Say Y if you want to control reset signals of different peripherals
@@ -83,8 +83,8 @@ config RESET_AST2500
 
 config RESET_AST2600
 	bool "Reset controller driver for AST2600 SoCs"
-	depends on DM_RESET
-	default y if ASPEED_AST2600
+	depends on DM_RESET && ASPEED_AST2600
+	default y
 	help
 	  Support for reset controller on AST2600 SoC.
 	  Say Y if you want to control reset signals of different peripherals
@@ -223,7 +223,7 @@ config RESET_ZYNQMP
 
 config RESET_DRA7
 	bool "Support for TI's DRA7 Reset driver"
-	depends on DM_RESET
+	depends on DM_RESET && ARCH_OMAP2PLUS
 	help
 	  Support for TI DRA7-RESET subsystem. Basic Assert/Deassert
 	  is supported.
-- 
2.43.0

