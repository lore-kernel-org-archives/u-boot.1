Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB41C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB8B88C0C;
	Thu,  2 May 2024 03:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c+oCEe96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969B588C01; Thu,  2 May 2024 03:31:57 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D35888B98
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-61e04fcf813so9418077b3.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613513; x=1715218313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UFRqozu29SY3vFEA3Ua9Qs7FT+LyKdeEt8vkFM4HKo=;
 b=c+oCEe96d2XrzIrY2tyQwEvwoUNCC+Af1kP+Zr9q6LHpseFhTQ8hvmy1nHPDoKtHhr
 B/w4z2c8qmaVRfbE/YTzB8blRUdbSLsogFpK9HM/fmi6LC4JZyUd6Ks5rBVvOe7Cs0bS
 KAJuWsKo1rmiNajyHTZUEA7pWmY7t5O+w3l9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613513; x=1715218313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UFRqozu29SY3vFEA3Ua9Qs7FT+LyKdeEt8vkFM4HKo=;
 b=ZPyZIWkmIBSBdZCLQRme2Mqd084ZDyQBXXcvBnVmaW2oy1OvwvG6E54Sum+1b8HQs8
 Tbw3bLicy9ygsDqo6x5ABVxsr50qPHkaHMEyqWfaLHVOPe9Qc7haSWW571qRJh2DlsT6
 0Zd51vIEF/iYZ542C0snS4Ugq4KyKfwA63QehGnTZtE5M9w6FIxIHVEPGPYLxvFVe3mF
 ECknuPJrKtN8fGqidOmj6Iws7S5hWbUJxavmQAu7/l5kJ6U0JKBoUxz5pQOYP3s0kD50
 MF8FHF3fXN2BNhfRxq6oo7VXpknJuBRg3Qo6PeoRmIRkwxGcGTV6exQaYMr+n46yIaiL
 5yNQ==
X-Gm-Message-State: AOJu0YxlTFLAs8dmZBApEr5svqMkCnZJvasV6xpfZ35iY2FYg1cTUvuu
 RKiVdwUg8eF/ZuteBsKg8I3R6bp2xn7Xt0JRIDWq7NOlWpqU0TkKnojfY3Vg8qJRiSvVwYGb6gk
 9qdkYjrXQ
X-Google-Smtp-Source: AGHT+IHJ3bkyRc6DOm6Vi+0GPeqPguYFzp55SiLx8MMKFNtSw1tYTHba9wh6wtoVYgFvGyvQQAj3ZA==
X-Received: by 2002:a05:690c:3811:b0:615:3996:5c86 with SMTP id
 jx17-20020a05690c381100b0061539965c86mr5144199ywb.21.1714613512787; 
 Wed, 01 May 2024 18:31:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Luca Ellero <l.ellero@asem.it>,
 Haibo Chen <haibo.chen@nxp.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH 10/81] adc: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:27 -0600
Message-Id: <20240502013138.2383421-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Luca Ellero <l.ellero@asem.it>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Johan Jonker <jbx6244@gmail.com>
---
 drivers/adc/adc-uclass.c      | 1 -
 drivers/adc/exynos-adc.c      | 1 -
 drivers/adc/imx93-adc.c       | 1 -
 drivers/adc/meson-saradc.c    | 1 -
 drivers/adc/rockchip-saradc.c | 1 -
 drivers/adc/sandbox.c         | 1 -
 drivers/adc/stm32-adc-core.c  | 1 -
 drivers/adc/stm32-adc.c       | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/adc/adc-uclass.c b/drivers/adc/adc-uclass.c
index 1b35bf22014f..16600be821c9 100644
--- a/drivers/adc/adc-uclass.c
+++ b/drivers/adc/adc-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_ADC
 
-#include <common.h>
 #include <errno.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/adc/exynos-adc.c b/drivers/adc/exynos-adc.c
index 2bda733af90d..ecc564cd219a 100644
--- a/drivers/adc/exynos-adc.c
+++ b/drivers/adc/exynos-adc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Samsung Electronics
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <adc.h>
diff --git a/drivers/adc/imx93-adc.c b/drivers/adc/imx93-adc.c
index 41d04e0426cd..f593fb6447b3 100644
--- a/drivers/adc/imx93-adc.c
+++ b/drivers/adc/imx93-adc.c
@@ -6,7 +6,6 @@
  * Originally based on NXP linux-imx kernel v5.15 drivers/iio/adc/imx93_adc.c
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <linux/bitfield.h>
diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index c15c7fea47fe..60e348968fb5 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -7,7 +7,6 @@
  * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
  */
 
-#include <common.h>
 #include <adc.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 10ded1b088f3..f6832ab30731 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -5,7 +5,6 @@
  * Rockchip SARADC driver for U-Boot
  */
 
-#include <common.h>
 #include <adc.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/adc/sandbox.c b/drivers/adc/sandbox.c
index 43cad34ffebf..24d4af63bd9b 100644
--- a/drivers/adc/sandbox.c
+++ b/drivers/adc/sandbox.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Samsung Electronics
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <adc.h>
diff --git a/drivers/adc/stm32-adc-core.c b/drivers/adc/stm32-adc-core.c
index 6c176961f17a..af340b8b273b 100644
--- a/drivers/adc/stm32-adc-core.c
+++ b/drivers/adc/stm32-adc-core.c
@@ -6,7 +6,6 @@
  * Originally based on the Linux kernel v4.18 drivers/iio/adc/stm32-adc-core.c.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
diff --git a/drivers/adc/stm32-adc.c b/drivers/adc/stm32-adc.c
index 1fba707c6f7d..d50f00f1233e 100644
--- a/drivers/adc/stm32-adc.c
+++ b/drivers/adc/stm32-adc.c
@@ -6,7 +6,6 @@
  * Originally based on the Linux kernel v4.18 drivers/iio/adc/stm32-adc.c.
  */
 
-#include <common.h>
 #include <adc.h>
 #include <dm.h>
 #include <asm/io.h>
-- 
2.34.1

