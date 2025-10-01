Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E525BCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41C78362C;
	Wed,  1 Oct 2025 22:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IhsGV9B6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAC88362A; Wed,  1 Oct 2025 22:30:44 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575DD835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7af791b28b9so233378a34.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350641; x=1759955441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RFreq+YU5kVm2arvFpll2DApVAela6AMeAYkbNIxJig=;
 b=IhsGV9B6Gw9dlsFtQzrUqSCKv4LajGIS9DLXD26Dz1xee0sw6PqFanq5evRC9mZucg
 +hS3ZPPYlNuQH7ADpNou5f//j5deGTPI6lZxRQbExsyw3romY3xkCTCWW6EEXdUiUJbK
 BRd+q0Kx9SlBJMSX6NKkxKAiTkdQ591f+EkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350641; x=1759955441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RFreq+YU5kVm2arvFpll2DApVAela6AMeAYkbNIxJig=;
 b=jMRmw2pKV4LTg3fFfNl6dTcoCHG3K2eeJiBeHzGas/7jjRcwMO0J4Hj2/hRs1Q1Kf6
 MLAzhHvI+PftlGRm315xzTHrS2k8AuXxPPYi0BYm6RO1dZfO97LnYLn1H0brrri/8oQ6
 ZiGOxZ5K/B/7E8daFdISDKDRarjG1HYe/cgDtC7TV4Uq3GkvAaM5zzY/590CWZ8gMw+g
 EnIkrIsw1tGBOIYIrVY9WwtqpCwyUgI6jG3lWk1slDACAd0zPluHpGYAd7lDCt6wj//f
 pobJgBG1h2snfHcbXhHG0USVoKHy4+UB3FDjjY6sG4NEeGnY/a2i2E4WugkKvwl4XRAq
 1pTQ==
X-Gm-Message-State: AOJu0YwPWXy2WrumrYe4Q7KRGH1+Z8AseGw6xm8HMNat819SD6am4Pl/
 nbP4aBjGaO50njw2FAn+/WKwdrMYeC+R0mUaLVIU19hP5nUO9t6beIo+0R9I5sqsNhsUBksFFpK
 lYytUuD4=
X-Gm-Gg: ASbGnctmt4zzd/RkQdNt7DLK248jH3B5JCuoO0JmQ1GjARYTmtbMhyVfpPXz1dcz42/
 KJfxged8e63XXJwxOb+uyYLsKc2H8MlUHGEhyCy2OOobY9NJUfd/Zz7uqw7+8Ido8CFG2VmOrn8
 nyppG4Sk3LfZfycSmeHVeBV+8k1briPY3moUAcS5Yn/uhcsxYxUl5YWTm3AYx/C/9apYIWdZGwP
 jx7A5Nv403H+RggShCYMnd/IXh1lm9Br5Txy+RBP3dGmb6stiCeHop2C1PdrgjcSXixODVFgHv+
 ryW3J6+6Pve53YhAa9jMdmd2XINVGfNMdPXeys8RyvF0g7GIWyLIEQ51kcxQZQkarL5toBj4m/f
 3k1jtK3bOZzwP9HJeHM5cYZouVo72vnyYcdY1ezeKjiJ4laqqimEv5QuOlm275H7RHhnY/cs6Lu
 hqrbjRH1wZRVw4Zu955A==
X-Google-Smtp-Source: AGHT+IHhSxwhQjA/50GEugvTe9hkDgNyMILPTk370KB2RN+GDoj7jl7gWlEhYY34KVbAGzwbAAQpgQ==
X-Received: by 2002:a05:6830:67d6:b0:758:21cc:a45c with SMTP id
 46e09a7af769-7bddcf0e095mr3561689a34.22.1759350641136; 
 Wed, 01 Oct 2025 13:30:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3fdcf8b4sm122463a34.12.2025.10.01.13.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, David Lechner <david@lechnology.com>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] watchdog: Tighten dependencies on WDT_DAVINCI
Date: Wed,  1 Oct 2025 14:30:39 -0600
Message-ID: <20251001203039.2828278-1-trini@konsulko.com>
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

The WDT_DAVINCI driver is not safe to compile on 64bit platforms such as
allyesconfig on a 64bit host. Tighten the dependencies here to the
platforms which could use it today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Note that today no platforms enable it, but based on the compatible
string a number of platforms could, so I'm cc'ing platform maintainers
that may want to enable it.

Cc: Andrew Davis <afd@ti.com>
Cc: David Lechner <david@lechnology.com>
Cc: Adam Ford <aford173@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f646b35eff84..309f9cd4829b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -190,7 +190,7 @@ config WDT_DA9063
 
 config WDT_DAVINCI
 	bool "DaVinci watchdog timer support"
-	depends on WDT
+	depends on WDT && (ARCH_DAVINCI || ARCH_KEYSTONE)
 	help
 	  Select this to enable the watchdog timer for DaVinci SoCs such as the
 	  OMAP-L138.
-- 
2.43.0

