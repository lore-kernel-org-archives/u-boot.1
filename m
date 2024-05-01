Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4964C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A4788C7C;
	Wed,  1 May 2024 04:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jvN+rv9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A9D88C56; Wed,  1 May 2024 04:45:32 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F44388BE5
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6969388c36fso26833896d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531528; x=1715136328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mLcHlDSTU4pGdnAp+XfPGYCUQJBGwDKHA4aE8fCJuc=;
 b=jvN+rv9xii2KYAhl4oIibx2vpk0R030q7Bdp5qtS+5AQoUJHIBvNa+5VRtMWhD6XPj
 oSc7h9XSFF+v4gAin+QX3MAOnamwhaIPbsH45kwrj+7xNAnw1zetoNvyEZSbDXy1mQHx
 dj3wagV/qfB2CPvVIwHfTfi5h4MKzVIX7PWpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531528; x=1715136328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mLcHlDSTU4pGdnAp+XfPGYCUQJBGwDKHA4aE8fCJuc=;
 b=OrzXVGsFrRaD2lM/FjRBhumnjAdUS6QXNA89iQ+ArRomkdnr+kZmraXB2c920Zpmzx
 TvDPqj2SY72tOe/wqxuIDQScDwG/k0EHQGRXeXL1EPvtgKRQ3A6GIesO2gxkraJqwzqb
 qHtU+R161S/4eMX6Ogi4FE+FQAdSGpLLslcuqCXEJNbQ6oEjQbaEG3OLitxohz8LLvjF
 rRjy0om0uWUC62yKzZ9TcONwEO881AWnoY/hZ1+lss6RyiYWGr87oZCBt9wE9dj47RI0
 N2T1chFCfCSO4yKROSxEaoiTffbapcXfjxmrw3Nf3+mn5moePecmvOUbEB0fLrquC9ji
 Kn6A==
X-Gm-Message-State: AOJu0YyU38pKMvkzyJAoc9NKnYDXXIEhHBa9Y3oE+tJcKx+/fFdbGEp5
 rAhO9CnxO2XiL9lPm/NodJplwrx40E69QPRixB1bnG4QWmoKh1Ab2oj3Y13xvVr7Tam4Szi2IvV
 P6L+y+NE1
X-Google-Smtp-Source: AGHT+IFtcsJioviPi+9TefdHP1rbFdkQ1lF38qlXxzUIgIYK3wrTO2+uJ2CXp6Tx2Z2SNYFIFStDYQ==
X-Received: by 2002:a05:6214:1c43:b0:6a0:b9bf:3cb3 with SMTP id
 if3-20020a0562141c4300b006a0b9bf3cb3mr1336335qvb.34.1714531527912; 
 Tue, 30 Apr 2024 19:45:27 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Henrik Grimler <henrik@grimler.se>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 113/149] board: samsung: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:40 -0600
Message-Id: <20240501024316.1767971-113-trini@konsulko.com>
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
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Henrik Grimler <henrik@grimler.se>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/samsung/arndale/arndale.c          | 2 +-
 board/samsung/arndale/arndale_spl.c      | 1 -
 board/samsung/common/board.c             | 2 +-
 board/samsung/common/exynos5-dt-types.c  | 2 +-
 board/samsung/common/exynos5-dt.c        | 2 +-
 board/samsung/common/gadget.c            | 2 +-
 board/samsung/common/misc.c              | 2 +-
 board/samsung/common/sromc.c             | 1 -
 board/samsung/goni/goni.c                | 1 -
 board/samsung/goni/onenand.c             | 2 +-
 board/samsung/odroid/odroid.c            | 2 +-
 board/samsung/origen/origen.c            | 1 -
 board/samsung/smdk5250/smdk5250_spl.c    | 1 -
 board/samsung/smdk5420/smdk5420_spl.c    | 1 -
 board/samsung/smdkc100/onenand.c         | 1 -
 board/samsung/smdkc100/smdkc100.c        | 2 +-
 board/samsung/smdkv310/smdkv310.c        | 2 +-
 board/samsung/trats/trats.c              | 1 -
 board/samsung/trats2/trats2.c            | 1 -
 board/samsung/universal_c210/onenand.c   | 2 +-
 board/samsung/universal_c210/universal.c | 1 -
 21 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/board/samsung/arndale/arndale.c b/board/samsung/arndale/arndale.c
index 3ebf600e1d7c..e70b4a82687c 100644
--- a/board/samsung/arndale/arndale.c
+++ b/board/samsung/arndale/arndale.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2013 Samsung Electronics
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/samsung/arndale/arndale_spl.c b/board/samsung/arndale/arndale_spl.c
index 6ad0273e0495..c40ca7fa749c 100644
--- a/board/samsung/arndale/arndale_spl.c
+++ b/board/samsung/arndale/arndale_spl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <asm/arch/spl.h>
 
 #define SIGNATURE	0xdeadbeef
diff --git a/board/samsung/common/board.c b/board/samsung/common/board.c
index 5a71982775d0..eed1c2450fa6 100644
--- a/board/samsung/common/board.c
+++ b/board/samsung/common/board.c
@@ -4,7 +4,7 @@
  * Rajeshwari Shinde <rajeshwari.s@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cros_ec.h>
 #include <env.h>
 #include <errno.h>
diff --git a/board/samsung/common/exynos5-dt-types.c b/board/samsung/common/exynos5-dt-types.c
index 9294d36ba358..8328bf427cce 100644
--- a/board/samsung/common/exynos5-dt-types.c
+++ b/board/samsung/common/exynos5-dt-types.c
@@ -4,7 +4,7 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <adc.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index b3e87c937513..56862bcb34da 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <dwc3-uboot.h>
 #include <env.h>
diff --git a/board/samsung/common/gadget.c b/board/samsung/common/gadget.c
index 9487f9ec4e0c..c1b4342f4e22 100644
--- a/board/samsung/common/gadget.c
+++ b/board/samsung/common/gadget.c
@@ -4,7 +4,7 @@
  *  Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
+#include <linux/string.h>
 #include <linux/usb/ch9.h>
 
 #define EXYNOS_G_DNL_THOR_VENDOR_NUM	0x04E8
diff --git a/board/samsung/common/misc.c b/board/samsung/common/misc.c
index cc114aaaa6d3..c134a9d70e24 100644
--- a/board/samsung/common/misc.c
+++ b/board/samsung/common/misc.c
@@ -4,7 +4,7 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <env.h>
 #include <libtizen.h>
diff --git a/board/samsung/common/sromc.c b/board/samsung/common/sromc.c
index 76e37dfe262a..689ac8f8c6f7 100644
--- a/board/samsung/common/sromc.c
+++ b/board/samsung/common/sromc.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	UCLASS_ETH
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
diff --git a/board/samsung/goni/goni.c b/board/samsung/goni/goni.c
index c8f5a153bb47..a1047f3fd2a2 100644
--- a/board/samsung/goni/goni.c
+++ b/board/samsung/goni/goni.c
@@ -5,7 +5,6 @@
  *  Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/board/samsung/goni/onenand.c b/board/samsung/goni/onenand.c
index c67c107b16c2..6c7a03624b0a 100644
--- a/board/samsung/goni/onenand.c
+++ b/board/samsung/goni/onenand.c
@@ -4,7 +4,7 @@
  * Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/samsung_onenand.h>
diff --git a/board/samsung/odroid/odroid.c b/board/samsung/odroid/odroid.c
index 99e5613ced92..84d6d919f07f 100644
--- a/board/samsung/odroid/odroid.c
+++ b/board/samsung/odroid/odroid.c
@@ -4,7 +4,7 @@
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
diff --git a/board/samsung/origen/origen.c b/board/samsung/origen/origen.c
index ddf6a2b72fa5..c474a7e54fa3 100644
--- a/board/samsung/origen/origen.c
+++ b/board/samsung/origen/origen.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011 Samsung Electronics
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <asm/arch/cpu.h>
diff --git a/board/samsung/smdk5250/smdk5250_spl.c b/board/samsung/smdk5250/smdk5250_spl.c
index b0ef34dd6aa9..1c78cb6dda4f 100644
--- a/board/samsung/smdk5250/smdk5250_spl.c
+++ b/board/samsung/smdk5250/smdk5250_spl.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/spl.h>
 #include <asm/arch/clk.h>
diff --git a/board/samsung/smdk5420/smdk5420_spl.c b/board/samsung/smdk5420/smdk5420_spl.c
index 84126f5608c7..ccf8b257ec26 100644
--- a/board/samsung/smdk5420/smdk5420_spl.c
+++ b/board/samsung/smdk5420/smdk5420_spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/spl.h>
 #include <asm/arch/clk.h>
diff --git a/board/samsung/smdkc100/onenand.c b/board/samsung/smdkc100/onenand.c
index 04dc04a1a4a1..86ec550aaca9 100644
--- a/board/samsung/smdkc100/onenand.c
+++ b/board/samsung/smdkc100/onenand.c
@@ -4,7 +4,6 @@
  * Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
diff --git a/board/samsung/smdkc100/smdkc100.c b/board/samsung/smdkc100/smdkc100.c
index 4f46911b0b4d..7d0b0fcb0ae1 100644
--- a/board/samsung/smdkc100/smdkc100.c
+++ b/board/samsung/smdkc100/smdkc100.c
@@ -5,7 +5,7 @@
  *  Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <net.h>
 #include <asm/global_data.h>
diff --git a/board/samsung/smdkv310/smdkv310.c b/board/samsung/smdkv310/smdkv310.c
index 47483a26a622..5a4874b29cdf 100644
--- a/board/samsung/smdkv310/smdkv310.c
+++ b/board/samsung/smdkv310/smdkv310.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2011 Samsung Electronics
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
diff --git a/board/samsung/trats/trats.c b/board/samsung/trats/trats.c
index 6a3e5b29b989..6efc6f3831df 100644
--- a/board/samsung/trats/trats.c
+++ b/board/samsung/trats/trats.c
@@ -6,7 +6,6 @@
  * Donghwa Lee <dh09.lee@samsung.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/board/samsung/trats2/trats2.c b/board/samsung/trats2/trats2.c
index 81ccc124c809..612575a50941 100644
--- a/board/samsung/trats2/trats2.c
+++ b/board/samsung/trats2/trats2.c
@@ -5,7 +5,6 @@
  * Piotr Wilczek <p.wilczek@samsung.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/gpio.h>
 #include <asm/arch/pinmux.h>
diff --git a/board/samsung/universal_c210/onenand.c b/board/samsung/universal_c210/onenand.c
index 265a2cde4b48..ba56e86df465 100644
--- a/board/samsung/universal_c210/onenand.c
+++ b/board/samsung/universal_c210/onenand.c
@@ -4,7 +4,7 @@
  * Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/samsung_onenand.h>
diff --git a/board/samsung/universal_c210/universal.c b/board/samsung/universal_c210/universal.c
index 2d61dff89c2c..6bed724153ed 100644
--- a/board/samsung/universal_c210/universal.c
+++ b/board/samsung/universal_c210/universal.c
@@ -5,7 +5,6 @@
  *  Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <spi.h>
-- 
2.34.1

