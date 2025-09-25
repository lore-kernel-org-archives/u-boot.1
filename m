Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CF4CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D206F835B9;
	Thu, 25 Sep 2025 22:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XnvG2XfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4247D835BF; Thu, 25 Sep 2025 22:51:38 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D0C833ED
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-746d3b0f7e5so1466990a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833495; x=1759438295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j6Eo8x3BYFADI0DQq5/mr6IpofpCN6bhyJM/Ll5Qq30=;
 b=XnvG2XfAp77XlBJIkLQ5YMEEjP1LxAyUcwajKHYzeBSNfOIwazDQE4jppRKI15uirx
 /P31dwHokD6P+2rsxW+uB8Vetah4TjwCzpSVgimoEFguIN0ET4mFzg34HTVXvmg9cU/v
 BphPgDDDldxTnSrfMJkjPPTgHbSCPEnchqHDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833495; x=1759438295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6Eo8x3BYFADI0DQq5/mr6IpofpCN6bhyJM/Ll5Qq30=;
 b=i2U3/jhrLKzbk1gScKQZZfQACmRQWMppcEtN9C3tce2xs2NCh56Ee/Yklfw3jSHC7c
 0pGhhYQUhcqauY1D3jGNNPho9kUTTE7bvTdcHLN8w/wYusnVKoG8Md9Tay9EWv6zXhFX
 iWrMRQTcEon/bVcizFESRDARUh2i2sqtnzVHWYOTkaBrAHeIJWqqGDQ/wxlSvT1dEHB2
 mF+f7KGJShIdnugpbXuLOeo26aC8pSFkqhiBgQOkvcvQmnXqPKqPOtrHZvsNC0qsXMa8
 fJreVdcv1WXyTsU+rAwq0rF3XVa9ExUpSwvELuq3QEwuN2qa5lER4UoSl39/HZLg8O0v
 fdzg==
X-Gm-Message-State: AOJu0YyIuDvlZnxYo5fT0uuXnfdXIIER9hIiRWJezwTqCIUOomLboqm/
 CpYjXSjkklF+OlfKV5et4FFzXH9drg4ieT5X2sA6Cs9emGbBvr3Yht6vAfjBG6wRACHfvUd2fRm
 nwv1e9NE=
X-Gm-Gg: ASbGnctnsBEp97LhfWH8IlrrYsSmKp/g71Gp8+3lHKg6ZkebDKIV3Xp8JtTE9NCRtsh
 dyYdZFK5dg3NpBn9AVdyK/XrZYTBEYp4YYN0DHX5qwmNzRHH51jbMQcy9qNz50l53PmEK6QgPuN
 z9nGXwY33LaDVdTSLQEcfTTkKbX4NdOw9yjwaK1BMdNEKTChgnob3NzDZDZWohcRpSFrMXjBD4J
 uv4e72yoy6vhWc7JbcXwFbmIGjAQ7AghQMYpTacOWzg7pMDWQEhyUk3ZAI5cefVeUKE7bIH0x6z
 4MeZdu3qQs5wS0FTom20OKplZHtIHgldu9mKv1XL1CuXRCTTnsrA9Glk1GBzTRHe+ClC0407FY/
 IX2w/MFbCj4iGX0vYlbmS7mwEypVNf0szBbUglFpvoCReo3RZYjlsqJGpxkWqg0Xgozfo4g==
X-Google-Smtp-Source: AGHT+IFIPvxB+tvJtRuMMNLK80UGEqA4tecvvvsgnO7vDB1J0s4BoEkzMD8EseOzeVlAo86FSKJoBQ==
X-Received: by 2002:a05:6808:188a:b0:43f:179f:9d02 with SMTP id
 5614622812f47-43f4cec1af6mr2360116b6e.42.1758833494997; 
 Thu, 25 Sep 2025 13:51:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23fa4c6afsm606081a34.29.2025.09.25.13.51.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Update dependencies on CMD_IRQ
Date: Thu, 25 Sep 2025 14:51:32 -0600
Message-ID: <20250925205132.3561964-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

For CMD_IRQ to function, we need enable/disable_interrupt functions as
well as do_irqinfo functions to be defined. Only NIOS2, PowerPC and X86
implement the latter, so correct dependencies to be opt-in not out-out
here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c457cc8e5c42..5e5252ef1347 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2997,7 +2997,7 @@ config CMD_EVENT
 
 config CMD_IRQ
 	bool "irq - Show information about interrupts"
-	depends on !ARM && !MIPS && !RISCV && !SH
+	depends on NIOS2 || PPC || X86
 	help
 	  This enables two commands:
 
-- 
2.43.0

