Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C17CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7E183CF2;
	Tue, 18 Nov 2025 07:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jpNDsktE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8B583CE8; Tue, 18 Nov 2025 07:40:48 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD2D83C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-787d5555274so51103497b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448044; x=1764052844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4HEFSct9Xy5aqhKjffcGaQhQhKlZK9oWb5o+xH2N+4=;
 b=jpNDsktE+pcKxXLmC6nGfRZAky2PNunAADPxz4JToJ1puZ44bi5kax8oHhfmJGJIFP
 Q8fXaJqHUBuYHIVkMSnLrNNU0mXL+5u4IeNQSiNeihyC3jBv7CpNnqsAljmA+JR2em0a
 PLbb6vkpx48o8KaKHs57uGLQoEHGAAjVkytPpfzUhkwqc3LdavNPjfDdGT14ypDL9r8I
 fy0D/CwvxN7o+/07TYEOw7HPj9YEQL6i5tRNHw3eECs1C6KHmlKc7V1BFWvSbXHIP4Ns
 iAkDGJa4fc2s4DalJxrv8cIKmTMK3jdO54MT2Q6D7qM5auKxIiRxvQbMaz7NcifANfk8
 E/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448044; x=1764052844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k4HEFSct9Xy5aqhKjffcGaQhQhKlZK9oWb5o+xH2N+4=;
 b=citV4WlCUpBAfiSAWd+/Y5hB8JQS2eZSnOy0h69N65uIInAnHaGvO+nhuVVudb89Ti
 +5nG8OMkPzVBCB4aOiavOxjdp4l8+AY/Shj6GaymEchkmAruasy5/C50xSD7T76lC6zf
 wLbSEceRaTSuCZA6sa8Ywg1Lw5wtd6v0UWdS64k4yOH1gM38yPmaK2M0JvAos/b7m4zr
 9OcCQnZuL9BiqROnQ0C3iQxH6x1nRUVRG6XtI1KutQT6l22qPqRfe5yLL7ZSC7QNGlHK
 Ll/nyL3W4vEE+/T4nzAsf+8Mo2/WL79BYc0Ngu3E+fM8Bv2p1YQHz8COgz8iSp3gX5PB
 G9OQ==
X-Gm-Message-State: AOJu0YxHAbJOUMTMCWvg0pcsOvd/L9VuvTo3SSNktVWnRYsIRgIzzeBQ
 Efp2VGD4LsyNbvzY6G+Tn+Vx00enMj4ofsoWdgkXlcz2NPy0Pz6pTwWtWU8a
X-Gm-Gg: ASbGncveC5sFm1iUg89ZNnYAl1Z8P8kDXQTThr+EN4XeaeIpVexOT4CFdc7H9EdG66T
 m33aLt+E4B7djZbSmHqZ1UYgD5SFBfH93jSMVBgMoKYIgvZQN5JDUYWJ7jd6OC5AbOpX75tVJnc
 7l6rzNsc8hlEylwXIjXQtlOMtGkJd7sZ8IOxaVB21lJqQ9bsDrkmiUoS5XhEpp1hQnLgC2wjB/j
 Vmd/+iaie/d1UAlcQq0AqwHuGPj5IrCM9YNzbDQ+kC87zmfE3pxXg6BEKJPZNyX6o1V5Weoa9/x
 Blz7N82y3roi+pjswFiM4W0/yKErnZUDUTaKm8T154lurkUlAYo1BaVx8S9+KhMnDlAxJ0JMnrO
 QJVjkAc3C5PjeosZ5BXLD0djZX3XLCRRjQ2Rb7LUv0vdiIJw86DR9LCUFxkpY/fj+vH/kpJa72e
 gR9mol3hhRr9d/kPpxyPUpCe8L7BEIePPZhZxD
X-Google-Smtp-Source: AGHT+IGflRjNHqlVaHzRmPxFZzQxh5/vzs0oORUE6OR/BEEriQT+u8OX1g07JesEijtbp9rVKc7uMw==
X-Received: by 2002:a05:690c:a715:b0:786:3ee8:66e3 with SMTP id
 00721157ae682-78929edc18fmr105498927b3.32.1763448044382; 
 Mon, 17 Nov 2025 22:40:44 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:43 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/12] board: adi: Add SOMCRR infrastructure
Date: Tue, 18 Nov 2025 01:39:39 -0500
Message-ID: <20251118064000.14613-7-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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

