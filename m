Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA93E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61F580352;
	Fri, 20 Dec 2024 23:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yso9UZ6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FBC8034E; Fri, 20 Dec 2024 23:26:21 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C834803B5
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so17534196d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733578; x=1735338378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=//JHBXauOlKELGgJimFZE5vkWUkxtmEzqDD7CCe4cZs=;
 b=Yso9UZ6De93qDeqUtBr1zPbYNL1vdVrFwKp92M7DVH3cMON11+C3m0ELnXCXuCKGJJ
 XkQAlDEWNWLYTOsJY+xIKZpHEOgifNgLW1iKjSQNlQo17GCxrYU/Lg9Djq5DYkrAs0tg
 oYj3rQ4SB076slntD9gFh0dfQEZwFi5PxnFco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733578; x=1735338378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//JHBXauOlKELGgJimFZE5vkWUkxtmEzqDD7CCe4cZs=;
 b=wCIqD+RfGbNldjlEWWNM349kzhNS4ULoeQRHbCTDkbA2uc2FWSW0fo4m/c1lVc2j7C
 SfTTkf4VD7GKghmQgK7wydTlM3AcjqdJaQKkZ2Lvha3G/Ws6sVS0TEu9bGLuU8dh7D99
 d+FF4Qrgm8p2cjl6VHtZX51sdf9EZsOTSDldyA2+ih8ZvUwSXPUq+A5Fx8yA3ntT/PXO
 JI9vx5Wu/A17lLNFO60j+ESRxB3EO3b4C77SCzXsetmhe6oDiFCP9yLDKJEtasQhOsgK
 kiwu0bUg2zv+zJNjZtjXkjmAG54Wd+pSiX2GgICM/vAm8+pGdXe3azbGfJDSlPcEWMHf
 nV1w==
X-Gm-Message-State: AOJu0YyMc/UpHKS+w+AuI7spjuBXjV6J1Jrnw6J7LH8BwMaqNgtb7+rQ
 4ffO9b0aofIxAR0khFneKWxqvmSNxVAK7w/ysPHoo5Y+ESXntyJZhkkBNvIYDo3LcjJN0BYCbws
 CVUU=
X-Gm-Gg: ASbGnctuL7q256WaULcaxmJjxoWXE49kDEW9LPWA+qxxLoWM1NW5+DHxQTpOe80Bi12
 p61IiJrvdY68ToXAKFPiS2V6rQGUqo1zotXpp9kPsN3XZWwolqjoCGzDKEwWROSSo6yy2u32GmI
 UAtHWwZggaDXJzAkuInZRvvtFExoCvkdbSbPdgS6mWTECVYSJvrFqR/31dg/pEit1GikuMnLgPe
 TEMg1LPMBNGokWpgsF59MACFjdAJ4m8pXuSZWU/WyFkE/WCW5OK0CoRJlDYXcqfpFDonLc9q1T7
 bSc=
X-Google-Smtp-Source: AGHT+IGX1zDkavH3oKIsedN/Ntng0rBigSRBtHgmBFAbxfsGuD26qvaY0caXkACjUD/I7uqLcCcV9Q==
X-Received: by 2002:a05:6214:1c81:b0:6d8:a946:eee5 with SMTP id
 6a1803df08f44-6dd2334b6b8mr89190486d6.23.1734733578406; 
 Fri, 20 Dec 2024 14:26:18 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/6] drivers/mmc/Kconfig: Remove extraneous BLK dependencies
Date: Fri, 20 Dec 2024 16:22:17 -0600
Message-ID: <20241220222612.1757884-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
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

At this point in time, MMC will always have BLK enabled, so we do not
need to list that as a dependency for MMC drivers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f4fdf15242ce..9f2fecce3826 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -338,7 +338,7 @@ config MMC_MXC
 
 config MMC_OWL
 	bool "Actions OWL Multimedia Card Interface support"
-	depends on ARCH_OWL && DM_MMC && BLK
+	depends on ARCH_OWL && DM_MMC
 	help
 	  This selects the OWL SD/MMC host controller found on board
 	  based on Actions S700/S900 SoC.
@@ -633,7 +633,7 @@ config MMC_SDHCI_AM654
 	bool "SDHCI Controller on TI's Am654 devices"
 	depends on ARCH_K3
 	depends on MMC_SDHCI
-	depends on DM_MMC && OF_CONTROL && BLK
+	depends on DM_MMC && OF_CONTROL
 	depends on REGMAP
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -716,7 +716,7 @@ config MMC_SDHCI_PIC32
 config MMC_SDHCI_ROCKCHIP
 	bool "Arasan SDHCI controller for Rockchip support"
 	depends on ARCH_ROCKCHIP
-	depends on DM_MMC && BLK
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	help
 	  Support for Arasan SDHCI host controller on Rockchip ARM SoCs platform
@@ -764,7 +764,7 @@ config MMC_SDHCI_XENON
 
 config MMC_SDHCI_TANGIER
 	bool "Tangier SDHCI controller support"
-	depends on DM_MMC && BLK
+	depends on DM_MMC
 	depends on MMC_SDHCI
 	help
 	  This selects support for SDHCI controller on Tanginer
@@ -800,7 +800,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
 
 config MMC_SDHCI_ZYNQ
 	bool "Arasan SDHCI controller support"
-	depends on DM_MMC && OF_CONTROL && BLK
+	depends on DM_MMC && OF_CONTROL
 	depends on MMC_SDHCI
 	help
 	  Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs platform
@@ -842,7 +842,7 @@ config MMC_SUNXI_HAS_MODE_SWITCH
 
 config MMC_PITON
 	bool "MMC support for OpenPiton SoC"
-	depends on DM_MMC && BLK
+	depends on DM_MMC
 	help
 	  This selects support for the SD host controller on OpenPiton SoC.
 	  Note that this SD controller directly exposes the contents of the
-- 
2.43.0

