Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BBFE77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8BC180735;
	Wed, 15 Jan 2025 02:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMBlgn4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C396280716; Wed, 15 Jan 2025 02:23:35 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850F6806D4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso53777626d6.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736904211; x=1737509011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppSx3aFmsX9Piz9dzlux/P+kWXMOWmJT47tUj/aqWc0=;
 b=HMBlgn4dtbKLTJ78Zur+o0PrszCGdu8Idcz+2zjmiwyDm1Sw+kdg3OF/3wNUsyLv6W
 qDqo+mEwDKh74w4h/3zWkeQv5QsVc7GpGtyjZ1RYT2lSCJEhRFgugpVagBtdHV2DYyPd
 cb+Om0iwwcDReWI4A+7rkxhIRYFGekz5lT2F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736904211; x=1737509011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppSx3aFmsX9Piz9dzlux/P+kWXMOWmJT47tUj/aqWc0=;
 b=MdGGJVsdkBoSedZQErPAb7qDDKYxu8aR5c2WAtCLgyWOun63nSK+Uy2rQhpMfKBw7Y
 cXqpnKF6TgwAyb9gj0a1pm+mZ+udSoxI9v8VtISLAacEimK7pGgis+bFdL/4bhIDMG6T
 bRpkz6ZEBf+tT1EpBpG+mTUrMpJzIXwoHpoRGkqwUg4qW4Dax9S/g9TXyGMktJQfs97l
 UZO5qdkqUUhtqkCmpsrpRagkpxqe+PdEpAl1Tk5u49jdNLPvR0I6XnjNoeR0IbfWmiyI
 u/mBRg7xf4EUuSESiSt0b6tSGRpV/csIstfzobuFLZoPVvrve5wmLiAf008+XA+UAjdH
 0wiw==
X-Gm-Message-State: AOJu0YzgNk36u/EzQHvPu9CFm/XegRTBEhJTC/3QJ/ceE+k1gQkuQxrT
 fjRgK9hmlcmGTAy9SRfX+ZmRnu6dKH4EgAjh9j3J/5eTosmjukNTeHl//W9BxoL0suGdqBpBmEu
 1
X-Gm-Gg: ASbGncvMffJC/pJOAda2YRgtL718TSWKkVcazMgAAZElurU/Zix3E2DKT4Y/jocxbOZ
 Yp2dfRGH9OtUlSLatIugokUNh64IZPKL2tgMXvGmTP3Zftcw8S2svImk86lG4tHBo+8E+6xJJDR
 bN+wRpC+hjER0JcK+MM01kgJGfHx082seu1N4ynVHYj3c+/Cmpg1T3/Y87SHdNx7U0MqwVs57wv
 1O6PkV6rv3YMbIQ4s9Xrrv/wKz5gBYKBXJzFPwFgcaCXIqaRd2u0mKXvRW4cCd100cYxRA6PVzC
X-Google-Smtp-Source: AGHT+IG4W5rz8hs71iF0g5AGzBccToiiy7ca1b58gAlzEWe6C0IR3w/7Z1cEmxBQ9GDoJv479YZM/A==
X-Received: by 2002:a05:6214:2b83:b0:6e0:86ab:4b46 with SMTP id
 6a1803df08f44-6e086ab4bd5mr212120926d6.31.1736904211415; 
 Tue, 14 Jan 2025 17:23:31 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm59817096d6.50.2025.01.14.17.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:23:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCHv2 1/6] drivers/mmc/Kconfig: Remove extraneous BLK dependencies
Date: Tue, 14 Jan 2025 19:22:08 -0600
Message-ID: <20250115012322.215243-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115012322.215243-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
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

At this point in time, we know that with the MMC symbol enabled we will
always also have the BLK symbol enabled, so we do not need to list that
as a dependency for MMC drivers.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Reword the body of the commit to try and be clearer, requested by Quentin
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

