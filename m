Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE0CC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9D184006;
	Mon,  4 Aug 2025 23:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BWGrv2/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732EC84002; Mon,  4 Aug 2025 23:57:28 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B61C83FDE
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8818be8d6e4so56844239f.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344644; x=1754949444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8NnQMj9/m2YQtBKnZoSlibFqXCz6VCkFkcHGqo/OO8k=;
 b=BWGrv2/BPRR+DFX1EOIhRYAbcgg4dk4w1KkDEmotnWoQyEAdFhOavunvbIms2t7gnr
 aTnqGMDWpqvx9WbUp/EJTfhvwun2te54qbV8V2MvOiwmVG3Lr86Dmf7voY6BR5MULC2O
 0eAqZkro2ARewXAF9KLGmR20ri0W6MKKdtUyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344644; x=1754949444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NnQMj9/m2YQtBKnZoSlibFqXCz6VCkFkcHGqo/OO8k=;
 b=MxaSUH5ho2p2JQJhHdXh95krUHNi+UK9CQpzTkhhQuNHC5ojyJxYqOzqh5tMROgLJd
 dTCgOHTc3F8aEaZmUIE9Xmom4t7XeSq1LML+G5cLVT+kryK2bpNTwkL68UG4icte65+O
 5kmNOr9H/CpFUDHCQ5DNunvKbDq52n5d2BLAGwOYMpi23KYsq2P2SHu1/fTHn8n+Kg0X
 IDnl/1jBuizbZKDGCWGAwCwMKV7vQt+oOTxY9Qxs8F+WMkrNIrq/7v9RdeQkcJ4TPBWF
 7SMHbasllPhicZoD2lj9nPI8S/orjb08e0klWgPFXLBMTBO/dq0mFpknke5kBuz0wZFh
 OQsA==
X-Gm-Message-State: AOJu0YxtveErO8Po+j8eojuzWASOoTMOJneAlBsXDCfQRjrIoR5hjXm5
 pX550mClhFp3Y/UYf+2TxPgNac9i+7ZDmwRbC4FsX4ETYAOy/sbQzExcH+yEPEt34wUnHR8gXPb
 HORcUTQs=
X-Gm-Gg: ASbGnctZM2Btun0OxRzPXZeHYaG3jw6Ghuty5Cb65JnrActha3iR+XV/p17LEhb6n36
 y3pt/ndXS15OKmNhVMGll2fwaStzf03Ypafw7dMRQGlOecrxiIzEDoPEsK7hketDXZpwzZoTAaH
 goLvIkwIEYHbfgMucdpP3RSJWw2fp1h9rCkO65rKQN5KRqXBJxfjjHhKoyF5faQlHhFXXzpgct2
 /IgLEIDnvUWmO5o3fwA5D8ES5Y9JhBRy7K8XoKDTv/XbamRjSjrs14YdawajXF1FluwS+K13npY
 o/ieAXILaXk3lIf8+eqYBglv7a8nv9tK3RuHVd2/p7bVc3PlgJwqitVTPNrT6GiMM0X9acYpUJ5
 0eXFw+JwtMl3Aa9TRhHSleud8y9ixoM6TagG68ZnGU2Cufc7I/k5n/3JGjUY2fv9Co9FfVljDLF
 2ljNw=
X-Google-Smtp-Source: AGHT+IEzQT6I4BNVghbbsw/14L3oqg4seg1yNDrmwPfRKE01thO6SxlI9eorLLNL3PmyCjWbc4ig8w==
X-Received: by 2002:a05:6602:1648:b0:881:82bb:94b2 with SMTP id
 ca18e2360f4ac-88182bb99c3mr956274839f.13.1754344643843; 
 Mon, 04 Aug 2025 14:57:23 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] serial: Tighten some serial driver dependencies
Date: Mon,  4 Aug 2025 15:57:13 -0600
Message-ID: <20250804215719.1413106-4-trini@konsulko.com>
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

A few serial drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 1f2f2468eb0b..d7d59e02dd0a 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -665,6 +665,7 @@ config ARM_DCC
 
 config ATMEL_USART
 	bool "Atmel USART support"
+	depends on ARCH_AT91
 	help
 	  Select this to enable USART support for Atmel SoCs. It can be
 	  configured in the device tree, and input clock frequency can
@@ -703,8 +704,8 @@ config BCM6345_SERIAL
 
 config COREBOOT_SERIAL
 	bool "Coreboot UART support"
-	depends on DM_SERIAL
-	default y if SYS_COREBOOT
+	depends on DM_SERIAL && SYS_COREBOOT
+	default y
 	select SYS_NS16550
 	help
 	  Select this to enable a ns16550-style UART where the platform data
@@ -724,7 +725,7 @@ config COREBOOT_SERIAL_FROM_DBG2
 
 config CORTINA_UART
 	bool "Cortina UART support"
-	depends on DM_SERIAL
+	depends on DM_SERIAL && TARGET_PRESIDIO_ASIC
 	help
 	  Select this to enable UART support for Cortina-Access UART devices
 	  found on CAxxxx SoCs.
@@ -738,6 +739,7 @@ config FSL_LINFLEXUART
 
 config FSL_LPUART
 	bool "Freescale LPUART support"
+	depends on MACH_IMX || ARCH_LS1021A || ARCH_LS1028A
 	help
 	  Select this to enable a Low Power UART for Freescale VF610 and
 	  QorIQ Layerscape devices.
@@ -748,12 +750,14 @@ config LPUART
 
 config MVEBU_A3700_UART
 	bool "UART support for Armada 3700"
+	depends on ARCH_MVEBU
 	help
 	  Choose this option to add support for UART driver on the Marvell
 	  Armada 3700 SoC. The base address is configured via DT.
 
 config MCFUART
 	bool "Freescale ColdFire UART support"
+	depends on M68K
         help
           Choose this option to add support for UART driver on the ColdFire
           SoC's family. The serial communication channel provides a full-duplex
@@ -879,7 +883,7 @@ config PL01X_SERIAL
 
 config ROCKCHIP_SERIAL
 	bool "Rockchip on-chip UART support"
-	depends on DM_SERIAL
+	depends on DM_SERIAL && ARCH_ROCKCHIP
 	select SYS_NS16550
 	help
 	  Select this to enable a debug UART for Rockchip devices when using
@@ -1110,7 +1114,7 @@ config MTK_SERIAL
 
 config MT7620_SERIAL
 	bool "UART driver for MediaTek MT7620 and earlier SoCs"
-	depends on DM_SERIAL
+	depends on DM_SERIAL && SOC_MT7620
 	help
 	  Select this to enable UART support for MediaTek MT7620 and earlier
 	  SoCs. This driver uses driver model and requires a device tree
-- 
2.43.0

