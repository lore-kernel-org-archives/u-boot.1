Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6879AC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954D888A9F;
	Fri, 16 Aug 2024 05:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QeTShd3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFDE88A82; Fri, 16 Aug 2024 05:22:35 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDFB88A9F
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-201d9a78011so1390075ad.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723778545; x=1724383345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bhacBiM4YcoWHCUe5XecgNMPjpJGQQ8P1v3hz/fX+/Q=;
 b=QeTShd3Jtl47R0hoSxYdS7KjPATczsc6EdT1iLpYFTmmB/0suuZeZlE8R1De7wZ3kP
 UrWreYTywXyJ+bH2s5Dbgw8mVLMEsZEfFp2bZwnlGULmZMAULm2qGlO7VEL4Qt2TKpU2
 cpTIUhvD1MG2HiLyPe+8YaCscqAZ9V5sA1NPptMhx8f9JNsOzQckOFnlqXJn8h/onO+e
 93p8HwGPQz9ssa2dplwhKIddh2Bz2by5C4wyctlzetl/GGrADIv5OVoj2y31mzC1ou9L
 esgmq4+w8h5SmMsRqX4XnG4s07AccrLUE2bBbrAiUXZpo+ziqCchhiQJxp6y9hx9Luiy
 IufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723778545; x=1724383345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhacBiM4YcoWHCUe5XecgNMPjpJGQQ8P1v3hz/fX+/Q=;
 b=R6CfG0Pgnf7gbPSSeKRbK2qeEdclOAHCX1SUrg+d/ealb3cLMFWktKoCiDAgMTyuuR
 T8uXhFIxJfeAkYncsIdrQMGqg/IfqYeIKVuTnJ3KjOKVrM3sLfuTzg/HipF2JipB2AYL
 /mJQJ8uZbzM4W5CIBftzjPIl1QY9xgvDWHtyJUu1Q9MTZ1JDTKzxS02pBMEgL/hvG/J1
 LlctsD5AJMi3NGQeiNcdibUstHelIluSwvOYSLW3SRnb1gGRKjU3StI7yTDexeuYPLEl
 3HggO93kkCdziQFPL4DdANuyyUGhnqQ9Y6AIzmmqFDrUCN1gACCCqM66Z7p2PzX2uLxq
 vDeg==
X-Gm-Message-State: AOJu0YzPMZ71O5WGIFGOzaiQK733regXE4w+R5Dl6gb690qXs3KuptJU
 mkHUa9V78MhEYvBHpaeLnuHgbu4S5SmT0DdTG6wCkMoegcjagTG8X1B3hg==
X-Google-Smtp-Source: AGHT+IGHqqxBoVhZ/cUK5N+b3RgDSXU82fMjaeZ5br3LcrVdtVEeWwIXB259VckqmoTzdJAom/iWWw==
X-Received: by 2002:a17:902:da8a:b0:1fb:1ff1:89d2 with SMTP id
 d9443c01a7336-20203f21a2amr11373185ad.6.1723778545005; 
 Thu, 15 Aug 2024 20:22:25 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e9dd:de2d:53cf:88e2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0300522sm16913635ad.6.2024.08.15.20.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:22:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: tharvey@gateworks.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] gw_ventana: Remove unneeded comments
Date: Fri, 16 Aug 2024 00:22:17 -0300
Message-Id: <20240816032217.267689-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Remove several comments that do not apply anymore to
the current file content.

While at it, write 'PMIC' into a single line for consistency.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 include/configs/gw_ventana.h | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/include/configs/gw_ventana.h b/include/configs/gw_ventana.h
index ebc5d03d0d5..3e720a6e0af 100644
--- a/include/configs/gw_ventana.h
+++ b/include/configs/gw_ventana.h
@@ -6,55 +6,26 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-/* SPL */
-/* Location in NAND to read U-Boot from */
-
-/* Falcon Mode */
-
-/* Falcon Mode - MMC support: args@1MB kernel@2MB */
-
 #include "mx6_common.h"
 
 /* Serial */
 #define CFG_MXC_UART_BASE	       UART2_BASE
 
-/* NAND */
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
 
-/*
- * PCI express
- */
-
-/*
- * PMIC
- */
+/* PMIC */
 #define CFG_POWER_PFUZE100_I2C_ADDR	0x08
 #define CFG_POWER_LTC3676_I2C_ADDR  0x3c
 
-/* Various command support */
-
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)
 #define CFG_MXC_USB_FLAGS      0
 
-/* Miscellaneous configurable options */
-
-/* Memory configuration */
-
 /* Physical Memory Map */
 #define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
 #define CFG_SYS_SDRAM_BASE          PHYS_SDRAM
 #define CFG_SYS_INIT_RAM_ADDR       IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE       IRAM_SIZE
 
-/*
- * MTD Command for mtdparts
- */
-
-/* Persistent Environment Config */
-
-/* Environment */
-
 #endif			       /* __CONFIG_H */
-- 
2.34.1

