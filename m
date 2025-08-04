Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177AFC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D502783FE6;
	Mon,  4 Aug 2025 23:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHslcGv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0828E83FF8; Mon,  4 Aug 2025 23:57:32 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C798B84002
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3e3faafe30fso36946035ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344647; x=1754949447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcATjIIP2JvyMrrE8SHjGagJ0pc4lnMQyeNdesfSM34=;
 b=cHslcGv3j3OA0W9PJFu3wzQXDnw+L6u/W0lCRy3uRoS6Chn38/9dQbB5q80ekuvopy
 vs4H8oHZ/qqvXx3Bo7TMdXzwLcVpBWKH0g5rZLhfEvjOtZ2hdtimnIj1b9Ylf31RAatd
 fMxu8wo3/KKbOfl9hThtePRq3ZwsfHYKQ77TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344647; x=1754949447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcATjIIP2JvyMrrE8SHjGagJ0pc4lnMQyeNdesfSM34=;
 b=Tctx3cztwFRIOcHO2vbSlz0vhGfYCZeTy0YiRcMHuGfPEFSETI+V0OcXZbGpPwjj6J
 bm9cizEAEx1hq1Fi1nSzIbRyYEvalOcElLEtpSEGoCsCPCgv0wBrwovNcsZqDR7NR6Aa
 aJkX4qd+ixIXV68ZkDoyu1e77WupDEnvT1H0fZtzF6DBOZzwbSwdbuBeW5dG/V96dsiP
 UQQbOThl5XJCHtEc1Ni4LjoBehNr/aebHYmwhwERRsycxWK2UFxb4kOHKzB33grOGR0F
 HjkpI68ry1RouwODJqkM6vQ/JDpy2mZ7qKQCA4vkW4yimrIti24+HwQ2wiiityBgKUvw
 FKpA==
X-Gm-Message-State: AOJu0Yx5GYFUWr9OrbxDv20Flijou8MdJjioeoOK4ver6pz3SNCckHfl
 0OtwKbM2hWlISI7sg7KkgmVYIb0LlO1cPTOYa6EW37rL4h5TnbgE9fKCYiiXlFBqIsILJs5oOXn
 vLjS95FQ=
X-Gm-Gg: ASbGncsdy07x9iw5ByaBNzoySsSkAdEe0dMTswc0KkPFB12XcukMT9bhY02ISQW0pK7
 BxEPNHxxh8ElM2JI0sK61nf4fzcyat11+zQcVd+9fN+kaZ2lnsw3CphWCwhsXGu3I5rdVSnMD8B
 rScovN+5JlrEPEpSpS6kGTW4Egl0kqjqfr5nCt3pYEV6W28IhP6xqMwTweGepvw4PWOsUfz6rb7
 MW5R6L+DLOGmrA5KqqvhckJZwYQLPwchbDRrd3o9PYxr1Y+DJJq+N4C7zAB1MJ7YxQiWX/EI7My
 mQpmyV1cWQ/xdg1W17bbQyp8dObOl2IScZOv13inSF7PIB/IhNfQpfVxu6LRDtQ8Z4Y2GSWmlrN
 gI6lLmnkrStLEuXVZbaWvKSaaB0wpr4CvB1oJM1vmhPU8BKvJfHvFt7c/GlkEkPnp4w9F
X-Google-Smtp-Source: AGHT+IGEFBO96bPF8jxV8LUiyzge8TAWUoJDZGThACmIpccRi+vu19srVoV1LCnGiyHjdha1He9LKQ==
X-Received: by 2002:a05:6e02:1705:b0:3e0:4f66:310a with SMTP id
 e9e14a558f8ab-3e416199a4amr176599935ab.16.1754344647513; 
 Mon, 04 Aug 2025 14:57:27 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] spi: Tighten some spi driver dependencies
Date: Mon,  4 Aug 2025 15:57:17 -0600
Message-ID: <20250804215719.1413106-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

A few spi drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/spi/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1ae36b5a348b..243d93faee32 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -452,6 +452,7 @@ config ROCKCHIP_SFC
 
 config ROCKCHIP_SPI
 	bool "Rockchip SPI driver"
+	depends on ARCH_ROCKCHIP
 	help
 	  Enable the Rockchip SPI driver, used to access SPI NOR flash and
 	  other SPI peripherals (such as the Chrome OS EC) on Rockchip SoCs.
@@ -495,7 +496,7 @@ config SANDBOX_SPI_MAX_CS
 
 config SPI_ASPEED_SMC
 	bool "ASPEED SPI flash controller driver"
-	depends on DM_SPI && SPI_MEM
+	depends on DM_SPI && SPI_MEM && ARCH_ASPEED
 	help
 	  Enable ASPEED SPI flash controller driver for AST2500
 	  and AST2600 SoCs.
@@ -614,6 +615,7 @@ config ZYNQ_SPI
 
 config ZYNQ_QSPI
 	bool "Zynq QSPI driver"
+	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	imply SPI_FLASH_BAR
 	help
 	  Enable the Zynq Quad-SPI (QSPI) driver. This driver can be
@@ -623,6 +625,7 @@ config ZYNQ_QSPI
 
 config ZYNQMP_GQSPI
 	bool "Configure ZynqMP Generic QSPI"
+	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	help
 	  This option is used to enable ZynqMP QSPI controller driver which
 	  is used to communicate with qspi flash devices.
-- 
2.43.0

