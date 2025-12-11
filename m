Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECEDD41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5216483CF2;
	Thu, 11 Dec 2025 09:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVrm9Pic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D7F83C08; Thu, 11 Dec 2025 09:05:58 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9084E83CD3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-641e9422473so568094d50.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440354; x=1766045154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFMQT9UKIfgua+VxhMGaz0wIiXKiswFPijcIUUiLPD4=;
 b=FVrm9PichpV8Pn2IdFdPENU9KY7pEDLOW7wMOmMS8hCxo+DpAyzgJmmPFkjJU+P8Tl
 sPgt30as1iqBytGYu+eXQee2GtpUO9u+b44fESL3SISIA72vBqB89+qwVxg7XEx2BWos
 OQRQBuKbUV9Emfw5XYuy99b9o1B+rtK6bScaGJhBg18tH0SvM8Y+r/50O1m6Hz3LFhVD
 DXehhj1+cKFSDXWQT/1tkG0mbUK+fzUmsbekTK0LYn0nCO0A9OjIYBhuHynQkgOB7byV
 7eAcUeSKkMaUrEqBVxfw5ThLaHatAGvdCskN6PeO0DQNDGAOEoLamBHLD3E9kw54k2gT
 18eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440354; x=1766045154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QFMQT9UKIfgua+VxhMGaz0wIiXKiswFPijcIUUiLPD4=;
 b=bjclrx9M7s1dsNsluAJGIHZT9OfW+VYyjIQSlKIuwHfqijOUFLOMHz9eN+++dtZQzA
 HHtConzI0SlIFddaRzWWJgFwEc2kAa/1QKZoXTgly3NrgLRBFJKnuQpnUxBRCgUKbcqh
 FrDx9K9v342K9KRt3/wmr4qy0qmMN1Onrc5KgJENAt6BU98MWGZkiHVDHEEL+EOYs4Xz
 qFC1RJ62d9dt5B/dmhy352qPK5TRUu4JIX3kC/V4M4LeawgoPblEgrMeI92GB+sbk0mC
 xkYGBi33VLq3Q9pgCBbitPfSSRC8b+aNdabHycYyXh5gr4UNyuIoPaC8TqSmxRxYY1d6
 2afQ==
X-Gm-Message-State: AOJu0Yy67gD+/wbGQWHs38HYwMvB0hN3//5jG8kEcGFu/zekyhuOzRfo
 MFP/h/Mi/s+gU7h0Phz0ulKfq5WKmiFDpaza+P5uJMnGMDqIdkp+UqCa0r0H
X-Gm-Gg: AY/fxX7nMybm7xdWstxaylpaS1f+WSufs21pvGy4IIXyB6WZoHJob4leMpyem9LfLTI
 GQ3VziVEU6xyLlUAZrA+3iL4jIMCQj6YZGUN4NyNjX1E/H2lG0MHfAsEiOZ/Zh/gm6LuRyirHay
 Zc8SLG1jYQJ8Pxxt3z8he33adNIF42HZVUTUb5SGdTbWlNbuG/S+IvCP75vkG5ymqKiinZ+xcu7
 jtruBoXzR6NuMa484eaLnmAmtQQndNp4EAbgpEBPp5zNq5LlktpixB9kbS9L5CJNFWnLrUUY996
 OXFqTdD0Nh22DaI38SkXMSJYHxczwTlmONMxQc8OnVCZwzoSH4gWgWjAO5Xkp71djwFlXpaoWF4
 jhSB6C6JIKoQkuJPalefk8QQOml1Jah9e46VqbyruzA6ytIi0IWkWI0MroB5o68Frctah/UvoFe
 /l0zD88VW9DV38At1/3OVGEquflCqE3ZzZ8FFc
X-Google-Smtp-Source: AGHT+IHuUxKf4YiHbe7xJoz9j95a+kNOrdrJpCnbpTkdWRPBIU9JPPKeKNVwi9htE5jbxM295ZpW9g==
X-Received: by 2002:a05:690c:a58f:b0:78d:1130:78a with SMTP id
 00721157ae682-78d113012e8mr66608587b3.45.1765440353748; 
 Thu, 11 Dec 2025 00:05:53 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:52 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/12] board: adi: Add SOMCRR infrastructure
Date: Thu, 11 Dec 2025 03:03:57 -0500
Message-ID: <20251211080414.5363-7-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

(no changes since v2)

Changes in v2:
- GPIO names and polarities adjusted to match logical usage

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
index 00000000000..8b4d6a96c18
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
+	gpio_hog_lookup_name("eth1-en", &eth1);
+	gpio_hog_lookup_name("eth1-reset", &eth1_reset);
+	gpio_hog_lookup_name("gige-reset", &gige_reset);
+
+	dm_gpio_set_value(eth1, 1);
+	dm_gpio_set_value(eth1_reset, 0);
+	dm_gpio_set_value(gige_reset, 0);
+}
+
+void adi_somcrr_disable_ethernet(void)
+{
+	struct gpio_desc *eth1;
+	struct gpio_desc *eth1_reset;
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("eth1-en", &eth1);
+	gpio_hog_lookup_name("eth1-reset", &eth1_reset);
+	gpio_hog_lookup_name("gige-reset", &gige_reset);
+
+	dm_gpio_set_value(eth1, 0);
+	dm_gpio_set_value(eth1_reset, 1);
+	dm_gpio_set_value(gige_reset, 1);
+}
diff --git a/board/adi/carriers/somcrr_ezlite.c b/board/adi/carriers/somcrr_ezlite.c
new file mode 100644
index 00000000000..c0655574bab
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
+	gpio_hog_lookup_name("eth0-reset", &gige_reset);
+	dm_gpio_set_value(gige_reset, 0);
+}
+
+void adi_somcrr_disable_ethernet(void)
+{
+	struct gpio_desc *gige_reset;
+
+	gpio_hog_lookup_name("eth0-reset", &gige_reset);
+	dm_gpio_set_value(gige_reset, 1);
+}
-- 
2.49.1

