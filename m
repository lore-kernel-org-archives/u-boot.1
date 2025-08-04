Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62715C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60A683D40;
	Mon,  4 Aug 2025 23:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nPipfltw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1344783FED; Mon,  4 Aug 2025 23:54:30 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC9383B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3e3f378ea68so33105825ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344467; x=1754949267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iJPDlkHbvWcbxYwNdQa22psbsKb5iEEDSg42Z60s8xg=;
 b=nPipfltw2iy6haveUK4FYUJse3M4yz3fnGS8/u/L7NoG1V0RZeHfXT62YRl01t/CVG
 W18WMNzo8LaBKISDRxEldk24mL0FtRwG47iChGhqB7y1SbF6sFN242PVaKdJejRIWV1S
 atwd6U/ePczR8+7H9IqIAwkCyNramnjvThgkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344467; x=1754949267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJPDlkHbvWcbxYwNdQa22psbsKb5iEEDSg42Z60s8xg=;
 b=n5CKqNkrcfCi12eIdPOr68dRwRVFLCpRhOkXVyVg5cfDRcO5Sdc5D7QWCEmcjEiPJy
 4i8aFlZKGDVpThpGRz/r2zumygSIrjU3KuKYRGaH/hvc8puWlY6z84NCQs/gCxuOR2pM
 qXrEX1WabfEjMj2V/bu1E3cr8w31GDPtdQkhD8PaLMqjXwKqb5ztMPlHCFwiEFpJWC3V
 7dwb5V2kEg8WFUhDBQ9/r2o8aPPEVIHFijhvkeGAL9AoKUR2LH3wSPNkCCPoQNZ0WR0a
 CQGFLe/rtdYPVLEgy99sFCkAOc7LQlzqsuGyAFci8UZ+UWQZ9pt9RpVIY24N+el+RnVY
 wxKw==
X-Gm-Message-State: AOJu0YxxC8SuR3+jqNWxgcKGv0/C/5YS8g1ALIi+N8GuNmpdDNU3nKy5
 wHjOWvQvTEUjjTDzkL0wv+uJYP2SvZHqJ7CxnwHdZ9slTmrU8omGMseyXTfJEN58XQOSy+DGyTJ
 dGkouAig=
X-Gm-Gg: ASbGnctBPYt5aaC9RajURBTdmvcdhJ0+2LN4XTbs1ieWpxwo00e2E4zfANMcuZqOmFE
 5yKkWPpVK/q/+ctJ0lh7dSLs+Hr+ucPEs6JJGfDRZzTtcloQQ7wO9ENasTu2zD7YBrb9zjalAIE
 +XdNRB0fXebeY9K5o7xvVLALr3ZVMaTT3oIoUzjhY23LfdaIRejbBhJiHpWWTOQGqCYeZZLJWh3
 vms0a2BqGDtJ1cFdNL+OID7tWEJ/iwcY9V1FTQQ4qk8d8Nsbibh+G8wyIYjVJoSu3mj3mtxAL1Y
 i+dywnAXntbo/C1TSRoxqU6AFMlNnBSgmdC/5QZGnqcyV2rpfIpdJtaMZY86bjvviG+/9e2cFN+
 aRq3UyOiHV2K9LsG9/XOm0CXPmSpn7R3AEqTv2uNh0I0ldOHlWOyZlB7m9PBYIlBriKyG
X-Google-Smtp-Source: AGHT+IEal8fxbZHSAmxrl4oQTVPBuTapEdUg14VikSu2AMYyMG3EUo6TMKu0mpiyuS7Bl/twFTySvw==
X-Received: by 2002:a92:d30c:0:b0:3e3:f914:d774 with SMTP id
 e9e14a558f8ab-3e4161b2256mr136106145ab.17.1754344466715; 
 Mon, 04 Aug 2025 14:54:26 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a7ff89f02sm1996337173.31.2025.08.04.14.54.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:54:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] ram: Tighten some ram driver dependencies
Date: Mon,  4 Aug 2025 15:54:23 -0600
Message-ID: <20250804215425.1412704-1-trini@konsulko.com>
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

A few ram drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/ram/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index edb8e254d5b3..d69644973091 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -39,7 +39,7 @@ config VPL_RAM
 
 config STM32_SDRAM
 	bool "Enable STM32 SDRAM support"
-	depends on RAM
+	depends on RAM && ARCH_STM32
 	help
 	  STM32F7 family devices support flexible memory controller(FMC) to
 	  support external memories like sdram, psram & nand.
@@ -47,7 +47,7 @@ config STM32_SDRAM
 
 config MPC83XX_SDRAM
 	bool "Enable MPC83XX SDRAM support"
-	depends on RAM
+	depends on RAM && MPC83xx
 	help
 	  Enable support for the internal DDR Memory Controller of the MPC83xx
 	  family of SoCs. Both static configurations, as well as configuring
@@ -67,7 +67,7 @@ config K3_AM654_DDRSS
 
 config K3_DDRSS
 	bool "Enable K3 DDRSS support"
-	depends on RAM
+	depends on RAM && ARCH_K3
 
 choice
 	depends on K3_DDRSS
-- 
2.43.0

