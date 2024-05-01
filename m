Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F9C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A398788C27;
	Wed,  1 May 2024 04:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szCIvCi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B690388C28; Wed,  1 May 2024 04:45:15 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B8B88C18
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b730fc89bso25359786d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531512; x=1715136312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MV0ALZCoN8rmXBzi/4u3vqMCnbdR5QE8w/0epuRO8o=;
 b=szCIvCi82+fJrTU9vNKmrXGGNTyLlYyZVgv0lWYzQUNMkwE9l45GZub6deo/LjCcYl
 6htzQrTLYC3o9df/Aw15Z+okwywiGfmDIJ4d9SSG+20PiljbZW0ih1B81jAVvPXXRifR
 PU/VIAAooPYepiq83jqwBWi4P/zKlUbxhHorA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531512; x=1715136312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MV0ALZCoN8rmXBzi/4u3vqMCnbdR5QE8w/0epuRO8o=;
 b=U2eKAObkvqBLheWq9VgRRgUysNmYVdApUlKjOyA39wIFubGnb1RgztmZoGUUuxBCcw
 vutUT9ng9a9PjcvN7KbnfPDd/m+nUuTnNbeBePoS8gjzwknYL3eEsMhElk+GwhEyftfO
 VweCBsYkCoMxJS1LbNuzVxO5e3Dkc9sx0rtQTvUmpaRTVLhsvbaVmSJSv6xIesgNW1Bp
 U2DYlgo21RUwRB1jCy69Ezxh2yl6X6vlWai8y+dDSOxFpQTetuRVK7cgJwPLtZuYcMt3
 LBSTVQFjtD5HUYO5XOcFhu6xk2GTKK0/1qp7Y6x6Z46wDUGHtzUUP55vEC0dpE7LC8ER
 Or8w==
X-Gm-Message-State: AOJu0YzRAVptvmCMgARN0AvZTIiTHRj/6NWsAQ4v7JI9FsGEsqTummXl
 IH+ruedFFBL2npBkK4x67kF40b7Qpsu44iEbrZ9E+rJs5Kdx/A1W40+x6GRRjlarnT8I21U2QVx
 Qg1fGe3or
X-Google-Smtp-Source: AGHT+IE1j9P/M4GsQ5xGK5R5Cw4nAuiPNWH0ubCyQY9+XtC+w1QwvKMxyVTx+bJBScZC3+m63AcEKQ==
X-Received: by 2002:a05:6214:2b0d:b0:6a0:b3ec:9036 with SMTP id
 jx13-20020a0562142b0d00b006a0b3ec9036mr1094632qvb.28.1714531512237; 
 Tue, 30 Apr 2024 19:45:12 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tom Warren <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>,
 Allen Martin <amartin@nvidia.com>
Subject: [PATCH 099/149] board: nvidia: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:26 -0600
Message-Id: <20240501024316.1767971-99-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Warren <twarren@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Allen Martin <amartin@nvidia.com>
---
 arch/arm/include/asm/arch-tegra/gpio.h      | 1 +
 arch/arm/include/asm/arch-tegra/tegra_i2c.h | 1 +
 board/nvidia/beaver/beaver-spl.c            | 1 -
 board/nvidia/cardhu/cardhu-spl.c            | 1 -
 board/nvidia/cardhu/cardhu.c                | 1 -
 board/nvidia/dalmore/dalmore.c              | 1 -
 board/nvidia/harmony/harmony.c              | 1 -
 board/nvidia/jetson-tk1/jetson-tk1.c        | 1 -
 board/nvidia/nyan-big/nyan-big.c            | 1 -
 board/nvidia/p2371-0000/p2371-0000.c        | 1 -
 board/nvidia/p2371-2180/p2371-2180.c        | 1 -
 board/nvidia/p2571/p2571.c                  | 1 -
 board/nvidia/p2771-0000/p2771-0000.c        | 1 -
 board/nvidia/p3450-0000/p3450-0000.c        | 1 -
 board/nvidia/seaboard/seaboard.c            | 1 -
 board/nvidia/venice2/as3722_init.c          | 1 -
 board/nvidia/venice2/venice2.c              | 2 +-
 17 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/gpio.h b/arch/arm/include/asm/arch-tegra/gpio.h
index fe7b3a50e0d9..3c1838cf1372 100644
--- a/arch/arm/include/asm/arch-tegra/gpio.h
+++ b/arch/arm/include/asm/arch-tegra/gpio.h
@@ -6,6 +6,7 @@
 #ifndef _TEGRA_GPIO_H_
 #define _TEGRA_GPIO_H_
 
+#include <linux/types.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
 
 #define TEGRA_GPIOS_PER_PORT	8
diff --git a/arch/arm/include/asm/arch-tegra/tegra_i2c.h b/arch/arm/include/asm/arch-tegra/tegra_i2c.h
index afec6bbdda33..dc8db3912219 100644
--- a/arch/arm/include/asm/arch-tegra/tegra_i2c.h
+++ b/arch/arm/include/asm/arch-tegra/tegra_i2c.h
@@ -10,6 +10,7 @@
 
 #include <asm/io.h>
 #include <asm/types.h>
+#include <asm/arch/tegra.h>
 
 struct udevice;
 
diff --git a/board/nvidia/beaver/beaver-spl.c b/board/nvidia/beaver/beaver-spl.c
index b5d0c14854dd..c6956ff9f582 100644
--- a/board/nvidia/beaver/beaver-spl.c
+++ b/board/nvidia/beaver/beaver-spl.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/nvidia/cardhu/cardhu-spl.c b/board/nvidia/cardhu/cardhu-spl.c
index de2fa300f1c8..80912a65a194 100644
--- a/board/nvidia/cardhu/cardhu-spl.c
+++ b/board/nvidia/cardhu/cardhu-spl.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/nvidia/cardhu/cardhu.c b/board/nvidia/cardhu/cardhu.c
index 6848e3400466..ab0dc61ebe54 100644
--- a/board/nvidia/cardhu/cardhu.c
+++ b/board/nvidia/cardhu/cardhu.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
diff --git a/board/nvidia/dalmore/dalmore.c b/board/nvidia/dalmore/dalmore.c
index 72511e401e3c..c00c6343eaa0 100644
--- a/board/nvidia/dalmore/dalmore.c
+++ b/board/nvidia/dalmore/dalmore.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
diff --git a/board/nvidia/harmony/harmony.c b/board/nvidia/harmony/harmony.c
index 52236792e24d..da14e09c40cc 100644
--- a/board/nvidia/harmony/harmony.c
+++ b/board/nvidia/harmony/harmony.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/board/nvidia/jetson-tk1/jetson-tk1.c b/board/nvidia/jetson-tk1/jetson-tk1.c
index 7f3cdd70fe77..da6edb42c1eb 100644
--- a/board/nvidia/jetson-tk1/jetson-tk1.c
+++ b/board/nvidia/jetson-tk1/jetson-tk1.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <linux/printk.h>
diff --git a/board/nvidia/nyan-big/nyan-big.c b/board/nvidia/nyan-big/nyan-big.c
index 06a36f8ed387..e15f31dcfd7f 100644
--- a/board/nvidia/nyan-big/nyan-big.c
+++ b/board/nvidia/nyan-big/nyan-big.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/board/nvidia/p2371-0000/p2371-0000.c b/board/nvidia/p2371-0000/p2371-0000.c
index b819b049f4b4..edf2b1adb7c6 100644
--- a/board/nvidia/p2371-0000/p2371-0000.c
+++ b/board/nvidia/p2371-0000/p2371-0000.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/gpio.h>
diff --git a/board/nvidia/p2371-2180/p2371-2180.c b/board/nvidia/p2371-2180/p2371-2180.c
index 816c7bec6ae4..5f203d8ffaa8 100644
--- a/board/nvidia/p2371-2180/p2371-2180.c
+++ b/board/nvidia/p2371-2180/p2371-2180.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <i2c.h>
diff --git a/board/nvidia/p2571/p2571.c b/board/nvidia/p2571/p2571.c
index a4c4259eeaee..4056f986483b 100644
--- a/board/nvidia/p2571/p2571.c
+++ b/board/nvidia/p2571/p2571.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/gpio.h>
diff --git a/board/nvidia/p2771-0000/p2771-0000.c b/board/nvidia/p2771-0000/p2771-0000.c
index 5ff89c45423e..12eaa7a1e53d 100644
--- a/board/nvidia/p2771-0000/p2771-0000.c
+++ b/board/nvidia/p2771-0000/p2771-0000.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <i2c.h>
diff --git a/board/nvidia/p3450-0000/p3450-0000.c b/board/nvidia/p3450-0000/p3450-0000.c
index fb1a224daa72..530c438a2e30 100644
--- a/board/nvidia/p3450-0000/p3450-0000.c
+++ b/board/nvidia/p3450-0000/p3450-0000.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <i2c.h>
 #include <linux/bitops.h>
diff --git a/board/nvidia/seaboard/seaboard.c b/board/nvidia/seaboard/seaboard.c
index 829751112f1c..a646dcc96b52 100644
--- a/board/nvidia/seaboard/seaboard.c
+++ b/board/nvidia/seaboard/seaboard.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/arch/tegra.h>
diff --git a/board/nvidia/venice2/as3722_init.c b/board/nvidia/venice2/as3722_init.c
index 395bdd99c789..b89e03703b21 100644
--- a/board/nvidia/venice2/as3722_init.c
+++ b/board/nvidia/venice2/as3722_init.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/tegra_i2c.h>
diff --git a/board/nvidia/venice2/venice2.c b/board/nvidia/venice2/venice2.c
index d89bbe5ecce2..fa10cda4870e 100644
--- a/board/nvidia/venice2/venice2.c
+++ b/board/nvidia/venice2/venice2.c
@@ -4,7 +4,7 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/pinmux.h>
 #include "pinmux-config-venice2.h"
-- 
2.34.1

