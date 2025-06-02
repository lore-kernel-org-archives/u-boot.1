Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30ECC5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812AF82AB2;
	Mon,  2 Jun 2025 21:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="itOOJ6BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F5A8212B; Mon,  2 Jun 2025 21:47:11 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B6482103
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e7da03bb0cdso3392698276.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893627; x=1749498427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtOzLP2QL5A65ulegfZg4JrecjDV0HsGTVpYOrej1HE=;
 b=itOOJ6BQZ81q6I4spqmvxqMEblcyGxOuO9PuZy6VJIxQe60CqpRRZoz/Zk5ZO/Z6X9
 IozdE/nXVNS5IryZsOovPePHReB0yAoOwsOPEMS66/RrctVXDS94T8OsFQjzoz0pIQrL
 k/82kRl0XDh8UwCR+rg2Ab3rxqmD/VnMGoSKXl0IfQQfCjT3sP4y+u6zLSV7gXHPS6f9
 ZyfsaeizNXPSakHsO8kcXlI8pmALmqWLAYlkwnijxgq4TiYmGL/+My8NK5Iny2+3aKFs
 oXRNOlgGyg9zp1Q100E6YsOPk6d5kJT1LRiw/ti/hpFI2IFKmeE35I7Y7efdymZtgo8D
 51jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893627; x=1749498427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtOzLP2QL5A65ulegfZg4JrecjDV0HsGTVpYOrej1HE=;
 b=ubVcaL0hUbebtTCnEwXzy1qTWWdxHXO+gNI2ae7M3aaaYoAqtYojuYQOoA27Va/gKR
 bcmVEGX3tGhPJiL//HHum9tj8AaNo3WRYcPcYQdWFl9+YDDGGr3myvO288qlJkWsKgCp
 qtEz1U9i6PwQbtEIIQR7z5yjHjhp8vK+oAW8lddMkyx4YDRKnBw7K4Hcjx7JRkvQ6IQl
 H8tySLSklHVr32INCLqlXdGBLh+tm52Zk5eLwnSRBNoLSW9MeAnPUrgR05PfLtd+ImIp
 PpD3FIBR4KARJbU792Oja+nfTs07qCn8oyT3Y2kknT/A1ypUIt5ugloNl/X4rOVAeNBM
 jTbw==
X-Gm-Message-State: AOJu0YzUBXnQGJ0UV7dsjroExjIzSoUtohqmbOUXYwijhRA+UOHuRX5a
 1hK72A5p/0Fwa+xqdIO0rvtxMaTDvlH09w46Zz4eMsNSWCXVO0LzcRuR7hG+
X-Gm-Gg: ASbGnctO+sMcLjhdrWBFiv4jioAp1C+We6fPHI3BLab+uooQV1lNEIS5APXUBtW3SVi
 mOZ9TacQNPTyHjZUsjrCEkMqjJ7n1UH13R647A0QQHroCyt/R7W/7KyMsfdaP72Y0JsN5L8prES
 ekKI/6AFiZwGjAEtjUEPRbZCEbqOH+QSQOhb71hg/qUSHDWByzs+/rd1GKN/kNq4J4TxrFDeUqt
 mwQ+zzDaO25aoY6qfocdHFlvtXsXXmSvLx09Jk8YljlPvQx0Zql6AVPafVpnTmjrq8JU968KCW2
 OnVxo0Wj3e4GLknWHzQCio1+EQ5zzE0MgHjq1XJWHBDPHsspoIBnn7hVCxcMeyYGt759fBfqOth
 ohA==
X-Google-Smtp-Source: AGHT+IEKuX/UeNAgt7aA2735EGiSqprkDtoYL6q75WiF+Htd4WjDVrkNqO8ZF7m6UH1Kr9N9yEB8Tg==
X-Received: by 2002:a05:690c:6c0b:b0:70d:f29e:9527 with SMTP id
 00721157ae682-71097c2a803mr142814257b3.6.1748893627198; 
 Mon, 02 Jun 2025 12:47:07 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:06 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] board: adi: Add SOMCRR infrastructure
Date: Mon,  2 Jun 2025 15:44:42 -0400
Message-ID: <20250602194507.15159-5-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

This adds infrastructure and shared library code for building targets
that use the ADI SOMCRR-EZKIT and SOMCRR-EZLITE carrier boards. These
are not used directly as board targets in their own right.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 board/adi/carriers/Makefile        |  8 +++++++
 board/adi/carriers/somcrr.h        | 14 +++++++++++
 board/adi/carriers/somcrr_common.c | 19 +++++++++++++++
 board/adi/carriers/somcrr_ezkit.c  | 38 ++++++++++++++++++++++++++++++
 board/adi/carriers/somcrr_ezlite.c | 24 +++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 board/adi/carriers/Makefile
 create mode 100644 board/adi/carriers/somcrr.h
 create mode 100644 board/adi/carriers/somcrr_common.c
 create mode 100644 board/adi/carriers/somcrr_ezkit.c
 create mode 100644 board/adi/carriers/somcrr_ezlite.c

diff --git a/board/adi/carriers/Makefile b/board/adi/carriers/Makefile
new file mode 100644
index 00000000000..cefd2cc837f
--- /dev/null
+++ b/board/adi/carriers/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2024 - Analog Devices, Inc.
+#
+
+obj-y += somcrr_common.o
+obj-$(CONFIG_ADI_CARRIER_SOMCRR_EZKIT) += somcrr_ezkit.o
+obj-$(CONFIG_ADI_CARRIER_SOMCRR_EZLITE) += somcrr_ezlite.o
diff --git a/board/adi/carriers/somcrr.h b/board/adi/carriers/somcrr.h
new file mode 100644
index 00000000000..01e908c67f8
--- /dev/null
+++ b/board/adi/carriers/somcrr.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ *
+ */
+
+#ifndef BOARD_ADI_CARRIERS_SOMCRR_H
+#define BOARD_ADI_CARRIERS_SOMCRR_H
+
+void adi_somcrr_init_ethernet(void);
+void adi_somcrr_enable_ethernet(void);
+void adi_somcrr_disable_ethernet(void);
+
+#endif
diff --git a/board/adi/carriers/somcrr_common.c b/board/adi/carriers/somcrr_common.c
new file mode 100644
index 00000000000..34ae48f31d2
--- /dev/null
+++ b/board/adi/carriers/somcrr_common.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <linux/delay.h>
+
+#include "somcrr.h"
+
+void adi_somcrr_init_ethernet(void)
+{
+	adi_somcrr_enable_ethernet();
+	mdelay(20);
+	adi_somcrr_disable_ethernet();
+	mdelay(90);
+	adi_somcrr_enable_ethernet();
+	mdelay(20);
+}
diff --git a/board/adi/carriers/somcrr_ezkit.c b/board/adi/carriers/somcrr_ezkit.c
new file mode 100644
index 00000000000..34572ba847e
--- /dev/null
+++ b/board/adi/carriers/somcrr_ezkit.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <asm/gpio.h>
+
+#include "somcrr.h"
+
+void adi_somcrr_enable_ethernet(void)
+{
+	struct gpio_desc *eth1;
+	struct gpio_desc *eth1_reset;
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("~eth1-en", &eth1);
+	gpio_hog_lookup_name("~eth1-reset", &eth1_reset);
+	gpio_hog_lookup_name("~gige-reset", &gige_reset);
+
+	dm_gpio_set_value(eth1, 1);
+	dm_gpio_set_value(eth1_reset, 0);
+	dm_gpio_set_value(gige_reset, 1);
+}
+
+void adi_somcrr_disable_ethernet(void)
+{
+	struct gpio_desc *eth1;
+	struct gpio_desc *eth1_reset;
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("~eth1-en", &eth1);
+	gpio_hog_lookup_name("~eth1-reset", &eth1_reset);
+	gpio_hog_lookup_name("~gige-reset", &gige_reset);
+
+	dm_gpio_set_value(eth1, 1);
+	dm_gpio_set_value(eth1_reset, 0);
+	dm_gpio_set_value(gige_reset, 0);
+}
diff --git a/board/adi/carriers/somcrr_ezlite.c b/board/adi/carriers/somcrr_ezlite.c
new file mode 100644
index 00000000000..010f36823ea
--- /dev/null
+++ b/board/adi/carriers/somcrr_ezlite.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <asm/gpio.h>
+
+#include "somcrr.h"
+
+void adi_somcrr_enable_ethernet(void)
+{
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("~eth0-reset", &gige_reset);
+	dm_gpio_set_value(gige_reset, 1);
+}
+
+void adi_somcrr_disable_ethernet(void)
+{
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("~eth0-reset", &gige_reset);
+	dm_gpio_set_value(gige_reset, 0);
+}
-- 
2.45.2

