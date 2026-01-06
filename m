Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCFFCEFD19
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD32B83FFF;
	Tue,  6 Jan 2026 23:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VuACTFp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBAA83B32; Tue,  6 Jan 2026 23:06:01 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DA683935
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-450b5338459so906428b6e.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767737157; x=1768341957;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1tuFlbzekHFfGLCFhBCZOPy8CXDx8YpXjdJgkifbm9s=;
 b=VuACTFp0jN1v9izFNWPLdQBd9fEFwL+1bYBuGtaET1xFCa8EXV+MdN7hnYU1AndrRC
 +U7z8aKHNzJeBnKNr95qW1VDXWOubnwFhk8Kqgr8a4W7Weo38ML3N1pKN8JxJIB6/ibM
 1IZ0nOl8XmrmNyDNeYRMMsM+wnJ6Zj9YqpbAfCZEjnRoTsiwPGVjPWUFRoJmde0NfsJW
 vnu1nUwqP1014j8sW2oMCPLNJHANZz1qoK7gS4+sy0fk9X9rVnZCkCVWtVW8wEBpm2tr
 OWhx/wxJL5nXJ2P9V2HMmMlz0aiJIdwaVXCSa9JFwse4/lXdTJI4Dja7w0XvDfWVEqjK
 TMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767737157; x=1768341957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1tuFlbzekHFfGLCFhBCZOPy8CXDx8YpXjdJgkifbm9s=;
 b=kWqMwU1I9TR2hezy/jE0mihkx3qWTSog/9oEOWGsZndkzQ0r+o1sFsohP3WHRcHpOC
 9AHz3du9cyhgi61on68VxJ1Gxnt4afYVsq0XWrv7s3OJXPlpO2taW2UYNMUTqYHBRf8G
 U4jLy/AI0feVsWfKHNqXOc5zEc+cS9+Y/Hc5s6yyV6WjInHrr4TQ84hCPbH3e79PNsvg
 wMWHPJuEG4RvJ+jdAAhz8nPSW2gisFrfHEBHTRsrnVMKDOO2UkaYbQ1qYlQs2BqNRIfp
 9wlbMiv/aJy4zbKc+etL+nbNiNQIpL+26e2kLinEtZ8/NSuFYkRji19s9quQRzoHaMYF
 jEUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWavcBz8PQtfczv0Z4ubgzhLTXJe8fp70g2BR9Iez9Mk/uxhfutEZgvPLsIDlxvepaWOYo7Jzo=@lists.denx.de
X-Gm-Message-State: AOJu0YzmfGbpcqzC0a55awhEWWmBCnxGxP2qR8X/HxUXX08cS28Co6Ft
 ghVwGMYSzTVEukyhWJDimqWllMJY5XAliq76UJjaAFKkXdtYoJn6MjnlgEKadXO+5bU=
X-Gm-Gg: AY/fxX4Go5BBrOFp/rCjH/Xy2X85qf3CQATiOeampCzBSEImXeno9cpDMfwoqmBRRPI
 IOtWEcBVdbqA/JbPbYeEueZQ1Noghge1sdEnVadJjzfmzgQqcVYNkpLDcIfL+DE3uYfHmKIvHLl
 zT2FwHuqr4/YnTkQQGJrU0pKBkq7Izh91iQocaFU/snQsyCzhDbTo3dRG3OsF74f4dopUM3/FjQ
 eIqF6RzZ7AJ6RfEgmX4Z133lFe2/sC6Xvm1RpU0WzASG2UovpvJoRKHsztAEjBULQsbDu+DK/QK
 DrsAuC3TT1CWkjsHM0CeVJ+vWkVtxi1OAISaGmXZb6olwc3fjusl2H4ukINewDan4Dmll6HULoD
 wvhNq4PmPhw/wj5+3l0lYKgtFXTILNiEsenaD2O+J0KojfsUqZCA5QoHk/oPUcMpV/IbKrx6Uji
 xLHWhc257YbbweTW0=
X-Google-Smtp-Source: AGHT+IGeMIKICh9mACprgD9p971CJ3+s3IY3yALO13QwrI4qmBF2OvywMW9Yinn9YzyW/T8KTG1BnQ==
X-Received: by 2002:a05:6808:d4b:b0:449:39e0:f3ce with SMTP id
 5614622812f47-45a6bd4a2d1mr287883b6e.28.1767737157134; 
 Tue, 06 Jan 2026 14:05:57 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f98:2205:4ba4:3e65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183916sm1575124b6e.5.2026.01.06.14.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:05:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Jan 2026 16:05:20 -0600
Subject: [PATCH 2/3] pinctrl: mediatek: add pinctrl driver for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-pinctl-mtk-mt8365-v1-2-0ca3eb382468@baylibre.com>
References: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
In-Reply-To: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20887;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=J70SQgvOY/DAB5KDN2tu4+2Tj4dkcLOrDKjcF82+Hqs=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXYczO5w+jziENlAQpFmfVgA9oPRzwOLhQdFgo
 MBYhvH0qneJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV2HMxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A75YH/38T3Av1CadxEcZC3Bg8nYBohMOPE5MQ8TUkKmC
 Y7E3IVji+Kgnea7JeE4/8xuUxzb0/2pT868ljJkUQBMnv/bmZ381tWoSe3FNPYYNPfOjrZkuYNG
 mkeQJML3GzyAC8WfeR8nAzs2l9wzcyWWlrtMCHjVKuukqmKOrxJqacMicEcloGYf750xQpK1igJ
 ysV61PTrgyBgKOKkWvYRlivTjll24Usj+r4LmyHfr4se//FJpwl/6XWQYmxRY7HPPEMxMYpl1nc
 jXSy6yQcxsGk2e7vLHur8Kjg3Hbhg2utSlWtU6xhp/sNcN9+xtVmEBjdoju6lmx9R4vf/YrV1oe
 Y6Ls=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 06 Jan 2026 23:57:11 +0100
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

From: Vitor Sato Eschholz <vsatoes@baylibre.com>

Add pinctrl support for MT8365 SoC.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Note: It was pointed out in [1] that `select PINCTRL_MTK` in the Kconfig
is not correct. I've kept it as is for now to match other drivers that
have the same problem. We will fix them all at the same time in a
separate patch (assuming this gets picked up first - otherwise I'll fix
it in a later revision of this series).

[1]: https://lore.kernel.org/u-boot/20260102213740.GA285761@bill-the-cat/
---
 drivers/pinctrl/mediatek/Kconfig          |   4 +
 drivers/pinctrl/mediatek/Makefile         |   1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 469 ++++++++++++++++++++++++++++++
 3 files changed, 474 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 8b9180bd2aa..4a698568a7e 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -32,6 +32,10 @@ config PINCTRL_MT7988
 	bool "MT7988 SoC pinctrl driver"
 	select PINCTRL_MTK
 
+config PINCTRL_MT8365
+	bool "MT8365 SoC pinctrl driver"
+	select PINCTRL_MTK
+
 config PINCTRL_MT8512
 	bool "MT8512 SoC pinctrl driver"
 	select PINCTRL_MTK
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index b25e74e4e00..565279157f9 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_MT7981) += pinctrl-mt7981.o
 obj-$(CONFIG_PINCTRL_MT7986) += pinctrl-mt7986.o
 obj-$(CONFIG_PINCTRL_MT7987) += pinctrl-mt7987.o
 obj-$(CONFIG_PINCTRL_MT7988) += pinctrl-mt7988.o
+obj-$(CONFIG_PINCTRL_MT8365) += pinctrl-mt8365.o
 obj-$(CONFIG_PINCTRL_MT8512) += pinctrl-mt8512.o
 obj-$(CONFIG_PINCTRL_MT8516) += pinctrl-mt8516.o
 obj-$(CONFIG_PINCTRL_MT8518) += pinctrl-mt8518.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
new file mode 100644
index 00000000000..0eae85b0078
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 BayLibre, SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm.h>
+
+#include "pinctrl-mtk-common.h"
+
+#define PIN_FIELD(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits) \
+	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits, 32, false)
+
+#define PIN_FIELD_DEFAULT(_s_pin, _e_pin, _s_addr) \
+	PIN_FIELD(_s_pin, _e_pin, _s_addr, 0x10, 0, 1)
+
+#define PIN_FIELD_MODE(_s_pin, _e_pin, _s_addr) \
+	PIN_FIELD(_s_pin, _e_pin, _s_addr, 0x10, 0, 3)
+
+#define PIN_FIELD_IES_SMT(_s_pin, _e_pin, _s_addr, _s_bit) \
+	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, 0x10, _s_bit, 1, 32, true)
+
+#define PIN_FIELD_DRV(_s_pin, _e_pin, _s_addr, _s_bit) \
+	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, 0x10, _s_bit, 4, 32, true)
+
+static const struct mtk_pin_field_calc mt8365_pin_mode_range[] = {
+	PIN_FIELD_MODE(0,   9,   0x1e0),
+	PIN_FIELD_MODE(10,  19,  0x1f0),
+	PIN_FIELD_MODE(20,  29,  0x200),
+	PIN_FIELD_MODE(30,  39,  0x210),
+	PIN_FIELD_MODE(40,  49,  0x220),
+	PIN_FIELD_MODE(50,  59,  0x230),
+	PIN_FIELD_MODE(60,  69,  0x240),
+	PIN_FIELD_MODE(70,  79,  0x250),
+	PIN_FIELD_MODE(80,  89,  0x260),
+	PIN_FIELD_MODE(90,  99,  0x270),
+	PIN_FIELD_MODE(100, 109, 0x280),
+	PIN_FIELD_MODE(110, 119, 0x290),
+	PIN_FIELD_MODE(120, 129, 0x2a0),
+	PIN_FIELD_MODE(130, 139, 0x2b0),
+	PIN_FIELD_MODE(140, 144, 0x2c0),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_dir_range[] = {
+	PIN_FIELD_DEFAULT(0, 144, 0x140),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_di_range[] = {
+	PIN_FIELD_DEFAULT(0, 144, 0x0),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_do_range[] = {
+	PIN_FIELD_DEFAULT(0, 144, 0xa0),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_ies_range[] = {
+	PIN_FIELD_IES_SMT(0,   3,   0x410, 0),
+	PIN_FIELD_IES_SMT(4,   7,   0x410, 1),
+	PIN_FIELD_IES_SMT(8,   11,  0x410, 2),
+	PIN_FIELD_IES_SMT(12,  15,  0x410, 3),
+	PIN_FIELD_IES_SMT(16,  18,  0x410, 4),
+	PIN_FIELD_IES_SMT(19,  19,  0x410, 5),
+	PIN_FIELD_IES_SMT(20,  21,  0x410, 6),
+	PIN_FIELD_IES_SMT(22,  22,  0x410, 7),
+	PIN_FIELD_IES_SMT(23,  25,  0x410, 8),
+	PIN_FIELD_IES_SMT(26,  29,  0x410, 9),
+	PIN_FIELD_IES_SMT(30,  34,  0x410, 10),
+	PIN_FIELD_IES_SMT(35,  40,  0x410, 11),
+	PIN_FIELD_IES_SMT(41,  44,  0x410, 12),
+	PIN_FIELD_IES_SMT(45,  48,  0x410, 13),
+	PIN_FIELD_IES_SMT(49,  56,  0x410, 14),
+	PIN_FIELD_IES_SMT(57,  58,  0x410, 15),
+	PIN_FIELD_IES_SMT(59,  60,  0x410, 16),
+	PIN_FIELD_IES_SMT(61,  62,  0x410, 17),
+	PIN_FIELD_IES_SMT(63,  64,  0x410, 18),
+	PIN_FIELD_IES_SMT(65,  70,  0x410, 19),
+	PIN_FIELD_IES_SMT(71,  79,  0x410, 20),
+	PIN_FIELD_IES_SMT(80,  80,  0x410, 21),
+	PIN_FIELD_IES_SMT(81,  81,  0x410, 22),
+	PIN_FIELD_IES_SMT(82,  82,  0x410, 23),
+	PIN_FIELD_IES_SMT(83,  83,  0x410, 24),
+	PIN_FIELD_IES_SMT(84,  84,  0x410, 25),
+	PIN_FIELD_IES_SMT(85,  85,  0x410, 26),
+	PIN_FIELD_IES_SMT(86,  86,  0x410, 27),
+	PIN_FIELD_IES_SMT(87,  87,  0x410, 28),
+	PIN_FIELD_IES_SMT(88,  88,  0x410, 29),
+	PIN_FIELD_IES_SMT(89,  89,  0x410, 30),
+	PIN_FIELD_IES_SMT(90,  90,  0x410, 31),
+	PIN_FIELD_IES_SMT(91,  91,  0x420, 0),
+	PIN_FIELD_IES_SMT(92,  92,  0x420, 1),
+	PIN_FIELD_IES_SMT(93,  93,  0x420, 2),
+	PIN_FIELD_IES_SMT(94,  94,  0x420, 3),
+	PIN_FIELD_IES_SMT(95,  95,  0x420, 4),
+	PIN_FIELD_IES_SMT(96,  96,  0x420, 5),
+	PIN_FIELD_IES_SMT(97,  97,  0x420, 6),
+	PIN_FIELD_IES_SMT(98,  98,  0x420, 7),
+	PIN_FIELD_IES_SMT(99,  99,  0x420, 8),
+	PIN_FIELD_IES_SMT(100, 100, 0x420, 9),
+	PIN_FIELD_IES_SMT(101, 101, 0x420, 10),
+	PIN_FIELD_IES_SMT(102, 102, 0x420, 11),
+	PIN_FIELD_IES_SMT(103, 103, 0x420, 12),
+	PIN_FIELD_IES_SMT(104, 104, 0x420, 13),
+	PIN_FIELD_IES_SMT(105, 109, 0x420, 14),
+	PIN_FIELD_IES_SMT(110, 113, 0x420, 15),
+	PIN_FIELD_IES_SMT(114, 116, 0x420, 16),
+	PIN_FIELD_IES_SMT(117, 119, 0x420, 17),
+	PIN_FIELD_IES_SMT(120, 122, 0x420, 18),
+	PIN_FIELD_IES_SMT(123, 125, 0x420, 19),
+	PIN_FIELD_IES_SMT(126, 128, 0x420, 20),
+	PIN_FIELD_IES_SMT(129, 135, 0x420, 21),
+	PIN_FIELD_IES_SMT(136, 144, 0x420, 22),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_smt_range[] = {
+	PIN_FIELD_IES_SMT(0,   3,   0x410, 0),
+	PIN_FIELD_IES_SMT(4,   7,   0x410, 1),
+	PIN_FIELD_IES_SMT(8,   11,  0x410, 2),
+	PIN_FIELD_IES_SMT(12,  15,  0x410, 3),
+	PIN_FIELD_IES_SMT(16,  18,  0x410, 4),
+	PIN_FIELD_IES_SMT(19,  19,  0x410, 5),
+	PIN_FIELD_IES_SMT(20,  21,  0x410, 6),
+	PIN_FIELD_IES_SMT(22,  22,  0x410, 7),
+	PIN_FIELD_IES_SMT(23,  25,  0x410, 8),
+	PIN_FIELD_IES_SMT(26,  29,  0x410, 9),
+	PIN_FIELD_IES_SMT(30,  34,  0x410, 10),
+	PIN_FIELD_IES_SMT(35,  40,  0x410, 11),
+	PIN_FIELD_IES_SMT(41,  44,  0x410, 12),
+	PIN_FIELD_IES_SMT(45,  48,  0x410, 13),
+	PIN_FIELD_IES_SMT(49,  56,  0x410, 14),
+	PIN_FIELD_IES_SMT(57,  58,  0x410, 15),
+	PIN_FIELD_IES_SMT(59,  60,  0x410, 16),
+	PIN_FIELD_IES_SMT(61,  62,  0x410, 17),
+	PIN_FIELD_IES_SMT(63,  64,  0x410, 18),
+	PIN_FIELD_IES_SMT(65,  70,  0x410, 19),
+	PIN_FIELD_IES_SMT(71,  79,  0x410, 20),
+	PIN_FIELD_IES_SMT(80,  80,  0x410, 21),
+	PIN_FIELD_IES_SMT(81,  81,  0x410, 22),
+	PIN_FIELD_IES_SMT(82,  82,  0x410, 23),
+	PIN_FIELD_IES_SMT(83,  83,  0x410, 24),
+	PIN_FIELD_IES_SMT(84,  84,  0x410, 25),
+	PIN_FIELD_IES_SMT(85,  85,  0x410, 26),
+	PIN_FIELD_IES_SMT(86,  86,  0x410, 27),
+	PIN_FIELD_IES_SMT(87,  87,  0x410, 28),
+	PIN_FIELD_IES_SMT(88,  88,  0x410, 29),
+	PIN_FIELD_IES_SMT(89,  89,  0x410, 30),
+	PIN_FIELD_IES_SMT(90,  90,  0x410, 31),
+	PIN_FIELD_IES_SMT(91,  91,  0x420, 0),
+	PIN_FIELD_IES_SMT(92,  92,  0x420, 1),
+	PIN_FIELD_IES_SMT(93,  93,  0x420, 2),
+	PIN_FIELD_IES_SMT(94,  94,  0x420, 3),
+	PIN_FIELD_IES_SMT(95,  95,  0x420, 4),
+	PIN_FIELD_IES_SMT(96,  96,  0x420, 5),
+	PIN_FIELD_IES_SMT(97,  97,  0x420, 6),
+	PIN_FIELD_IES_SMT(98,  98,  0x420, 7),
+	PIN_FIELD_IES_SMT(99,  99,  0x420, 8),
+	PIN_FIELD_IES_SMT(100, 100, 0x420, 9),
+	PIN_FIELD_IES_SMT(101, 101, 0x420, 10),
+	PIN_FIELD_IES_SMT(102, 102, 0x420, 11),
+	PIN_FIELD_IES_SMT(103, 103, 0x420, 12),
+	PIN_FIELD_IES_SMT(104, 104, 0x420, 13),
+	PIN_FIELD_IES_SMT(105, 109, 0x420, 14),
+	PIN_FIELD_IES_SMT(110, 113, 0x420, 15),
+	PIN_FIELD_IES_SMT(114, 116, 0x420, 16),
+	PIN_FIELD_IES_SMT(117, 119, 0x420, 17),
+	PIN_FIELD_IES_SMT(120, 122, 0x420, 18),
+	PIN_FIELD_IES_SMT(123, 125, 0x420, 19),
+	PIN_FIELD_IES_SMT(126, 128, 0x420, 20),
+	PIN_FIELD_IES_SMT(129, 135, 0x420, 21),
+	PIN_FIELD_IES_SMT(136, 144, 0x420, 22),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_pullen_range[] = {
+	PIN_FIELD_DEFAULT(0, 144, 0x860),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_pullsel_range[] = {
+	PIN_FIELD_DEFAULT(0, 144, 0x900),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_drv_range[] = {
+	PIN_FIELD_DRV(0,   3,   0x710, 0),
+	PIN_FIELD_DRV(4,   7,   0x710, 4),
+	PIN_FIELD_DRV(8,   11,  0x710, 8),
+	PIN_FIELD_DRV(12,  15,  0x710, 12),
+	PIN_FIELD_DRV(16,  18,  0x710, 16),
+	PIN_FIELD_DRV(19,  19,  0x710, 20),
+	PIN_FIELD_DRV(20,  21,  0x710, 24),
+	PIN_FIELD_DRV(22,  22,  0x710, 28),
+	PIN_FIELD_DRV(23,  25,  0x720, 0),
+	PIN_FIELD_DRV(26,  29,  0x720, 4),
+	PIN_FIELD_DRV(30,  34,  0x720, 8),
+	PIN_FIELD_DRV(35,  40,  0x720, 12),
+	PIN_FIELD_DRV(41,  44,  0x720, 16),
+	PIN_FIELD_DRV(45,  48,  0x720, 20),
+	PIN_FIELD_DRV(49,  56,  0x720, 24),
+	PIN_FIELD_DRV(57,  58,  0x720, 28),
+	PIN_FIELD_DRV(59,  60,  0x730, 0),
+	PIN_FIELD_DRV(61,  62,  0x730, 4),
+	PIN_FIELD_DRV(63,  64,  0x730, 8),
+	PIN_FIELD_DRV(65,  70,  0x730, 12),
+	PIN_FIELD_DRV(71,  79,  0x730, 16),
+	PIN_FIELD_DRV(80,  80,  0x730, 20),
+	PIN_FIELD_DRV(81,  81,  0x730, 24),
+	PIN_FIELD_DRV(82,  85,  0x730, 28),
+	PIN_FIELD_DRV(86,  86,  0x740, 12),
+	PIN_FIELD_DRV(87,  87,  0x740, 16),
+	PIN_FIELD_DRV(88,  88,  0x740, 20),
+	PIN_FIELD_DRV(89,  92,  0x740, 24),
+	PIN_FIELD_DRV(93,  96,  0x750, 8),
+	PIN_FIELD_DRV(97,  97,  0x750, 24),
+	PIN_FIELD_DRV(98,  98,  0x750, 28),
+	PIN_FIELD_DRV(99,  99,  0x760, 0),
+	PIN_FIELD_DRV(100, 103, 0x750, 8),
+	PIN_FIELD_DRV(104, 104, 0x760, 20),
+	PIN_FIELD_DRV(105, 109, 0x760, 24),
+	PIN_FIELD_DRV(110, 113, 0x760, 28),
+	PIN_FIELD_DRV(114, 116, 0x770, 0),
+	PIN_FIELD_DRV(117, 119, 0x770, 4),
+	PIN_FIELD_DRV(120, 122, 0x770, 8),
+	PIN_FIELD_DRV(123, 125, 0x770, 12),
+	PIN_FIELD_DRV(126, 128, 0x770, 16),
+	PIN_FIELD_DRV(129, 135, 0x770, 20),
+	PIN_FIELD_DRV(136, 144, 0x770, 24),
+};
+
+static const struct mtk_pin_reg_calc mt8365_reg_cals[] = {
+	[PINCTRL_PIN_REG_MODE]    = MTK_RANGE(mt8365_pin_mode_range),
+	[PINCTRL_PIN_REG_DIR]     = MTK_RANGE(mt8365_pin_dir_range),
+	[PINCTRL_PIN_REG_DI]      = MTK_RANGE(mt8365_pin_di_range),
+	[PINCTRL_PIN_REG_DO]      = MTK_RANGE(mt8365_pin_do_range),
+	[PINCTRL_PIN_REG_IES]     = MTK_RANGE(mt8365_pin_ies_range),
+	[PINCTRL_PIN_REG_SMT]     = MTK_RANGE(mt8365_pin_smt_range),
+	[PINCTRL_PIN_REG_PULLSEL] = MTK_RANGE(mt8365_pin_pullsel_range),
+	[PINCTRL_PIN_REG_PULLEN]  = MTK_RANGE(mt8365_pin_pullen_range),
+	[PINCTRL_PIN_REG_DRV]     = MTK_RANGE(mt8365_pin_drv_range),
+};
+
+static const struct mtk_pin_desc mt8365_pins[] = {
+	MTK_PIN(0,   "GPIO0",          DRV_GRP4),
+	MTK_PIN(1,   "GPIO1",          DRV_GRP4),
+	MTK_PIN(2,   "GPIO2",          DRV_GRP4),
+	MTK_PIN(3,   "GPIO3",          DRV_GRP4),
+	MTK_PIN(4,   "GPIO4",          DRV_GRP4),
+	MTK_PIN(5,   "GPIO5",          DRV_GRP4),
+	MTK_PIN(6,   "GPIO6",          DRV_GRP4),
+	MTK_PIN(7,   "GPIO7",          DRV_GRP4),
+	MTK_PIN(8,   "GPIO8",          DRV_GRP4),
+	MTK_PIN(9,   "GPIO9",          DRV_GRP4),
+	MTK_PIN(10,  "GPIO10",         DRV_GRP4),
+	MTK_PIN(11,  "GPIO11",         DRV_GRP4),
+	MTK_PIN(12,  "GPIO12",         DRV_GRP4),
+	MTK_PIN(13,  "GPIO13",         DRV_GRP4),
+	MTK_PIN(14,  "GPIO14",         DRV_GRP4),
+	MTK_PIN(15,  "GPIO15",         DRV_GRP4),
+	MTK_PIN(16,  "GPIO16",         DRV_GRP4),
+	MTK_PIN(17,  "GPIO17",         DRV_GRP4),
+	MTK_PIN(18,  "GPIO18",         DRV_GRP4),
+	MTK_PIN(19,  "DISP_PWM",       DRV_GRP4),
+	MTK_PIN(20,  "LCM_RST",        DRV_GRP4),
+	MTK_PIN(21,  "DSI_TE",         DRV_GRP4),
+	MTK_PIN(22,  "KPROW0",         DRV_GRP4),
+	MTK_PIN(23,  "KPROW1",         DRV_GRP4),
+	MTK_PIN(24,  "KPCOL0",         DRV_GRP4),
+	MTK_PIN(25,  "KPCOL1",         DRV_GRP4),
+	MTK_PIN(26,  "SPI_CS",         DRV_GRP4),
+	MTK_PIN(27,  "SPI_CK",         DRV_GRP4),
+	MTK_PIN(28,  "SPI_MI",         DRV_GRP4),
+	MTK_PIN(29,  "SPI_MO",         DRV_GRP4),
+	MTK_PIN(30,  "JTMS",           DRV_GRP4),
+	MTK_PIN(31,  "JTCK",           DRV_GRP4),
+	MTK_PIN(32,  "JTDI",           DRV_GRP4),
+	MTK_PIN(33,  "JTDO",           DRV_GRP4),
+	MTK_PIN(34,  "JTRST",          DRV_GRP4),
+	MTK_PIN(35,  "URXD0",          DRV_GRP4),
+	MTK_PIN(36,  "UTXD0",          DRV_GRP4),
+	MTK_PIN(37,  "URXD1",          DRV_GRP4),
+	MTK_PIN(38,  "UTXD1",          DRV_GRP4),
+	MTK_PIN(39,  "URXD2",          DRV_GRP4),
+	MTK_PIN(40,  "UTXD2",          DRV_GRP4),
+	MTK_PIN(41,  "PWRAP_SPI0_MI",  DRV_GRP4),
+	MTK_PIN(42,  "PWRAP_SPI0_MO",  DRV_GRP4),
+	MTK_PIN(43,  "PWRAP_SPI0_CK",  DRV_GRP4),
+	MTK_PIN(44,  "PWRAP_SPI0_CSN", DRV_GRP4),
+	MTK_PIN(45,  "RTC32K_CK",      DRV_GRP4),
+	MTK_PIN(46,  "WATCHDOG",       DRV_GRP4),
+	MTK_PIN(47,  "SRCLKENA0",      DRV_GRP4),
+	MTK_PIN(48,  "SRCLKENA1",      DRV_GRP4),
+	MTK_PIN(49,  "AUD_CLK_MOSI",   DRV_GRP4),
+	MTK_PIN(50,  "AUD_SYNC_MOSI",  DRV_GRP4),
+	MTK_PIN(51,  "AUD_DAT_MOSI0",  DRV_GRP4),
+	MTK_PIN(52,  "AUD_DAT_MOSI1",  DRV_GRP4),
+	MTK_PIN(53,  "AUD_CLK_MISO",   DRV_GRP4),
+	MTK_PIN(54,  "AUD_SYNC_MISO",  DRV_GRP4),
+	MTK_PIN(55,  "AUD_DAT_MISO0",  DRV_GRP4),
+	MTK_PIN(56,  "AUD_DAT_MISO1",  DRV_GRP4),
+	MTK_PIN(57,  "SDA0",           DRV_GRP4),
+	MTK_PIN(58,  "SCL0",           DRV_GRP4),
+	MTK_PIN(59,  "SDA1",           DRV_GRP4),
+	MTK_PIN(60,  "SCL1",           DRV_GRP4),
+	MTK_PIN(61,  "SDA2",           DRV_GRP4),
+	MTK_PIN(62,  "SCL2",           DRV_GRP4),
+	MTK_PIN(63,  "SDA3",           DRV_GRP4),
+	MTK_PIN(64,  "SCL3",           DRV_GRP4),
+	MTK_PIN(65,  "CMMCLK0",        DRV_GRP4),
+	MTK_PIN(66,  "CMMCLK1",        DRV_GRP4),
+	MTK_PIN(67,  "CMPCLK",         DRV_GRP4),
+	MTK_PIN(68,  "CMDAT0",         DRV_GRP4),
+	MTK_PIN(69,  "CMDAT1",         DRV_GRP4),
+	MTK_PIN(70,  "CMDAT2",         DRV_GRP4),
+	MTK_PIN(71,  "CMDAT3",         DRV_GRP4),
+	MTK_PIN(72,  "CMDAT4",         DRV_GRP4),
+	MTK_PIN(73,  "CMDAT5",         DRV_GRP4),
+	MTK_PIN(74,  "CMDAT6",         DRV_GRP4),
+	MTK_PIN(75,  "CMDAT7",         DRV_GRP4),
+	MTK_PIN(76,  "CMDAT8",         DRV_GRP4),
+	MTK_PIN(77,  "CMDAT9",         DRV_GRP4),
+	MTK_PIN(78,  "CMHSYNC",        DRV_GRP4),
+	MTK_PIN(79,  "CMVSYNC",        DRV_GRP4),
+	MTK_PIN(80,  "MSDC2_CMD",      DRV_GRP4),
+	MTK_PIN(81,  "MSDC2_CLK",      DRV_GRP4),
+	MTK_PIN(82,  "MSDC2_DAT0",     DRV_GRP4),
+	MTK_PIN(83,  "MSDC2_DAT1",     DRV_GRP4),
+	MTK_PIN(84,  "MSDC2_DAT2",     DRV_GRP4),
+	MTK_PIN(85,  "MSDC2_DAT3",     DRV_GRP4),
+	MTK_PIN(86,  "MSDC2_DSL",      DRV_GRP4),
+	MTK_PIN(87,  "MSDC1_CMD",      DRV_GRP4),
+	MTK_PIN(88,  "MSDC1_CLK",      DRV_GRP4),
+	MTK_PIN(89,  "MSDC1_DAT0",     DRV_GRP4),
+	MTK_PIN(90,  "MSDC1_DAT1",     DRV_GRP4),
+	MTK_PIN(91,  "MSDC1_DAT2",     DRV_GRP4),
+	MTK_PIN(92,  "MSDC1_DAT3",     DRV_GRP4),
+	MTK_PIN(93,  "MSDC0_DAT7",     DRV_GRP4),
+	MTK_PIN(94,  "MSDC0_DAT6",     DRV_GRP4),
+	MTK_PIN(95,  "MSDC0_DAT5",     DRV_GRP4),
+	MTK_PIN(96,  "MSDC0_DAT4",     DRV_GRP4),
+	MTK_PIN(97,  "MSDC0_RSTB",     DRV_GRP4),
+	MTK_PIN(98,  "MSDC0_CMD",      DRV_GRP4),
+	MTK_PIN(99,  "MSDC0_CLK",      DRV_GRP4),
+	MTK_PIN(100, "MSDC0_DAT3",     DRV_GRP4),
+	MTK_PIN(101, "MSDC0_DAT2",     DRV_GRP4),
+	MTK_PIN(102, "MSDC0_DAT1",     DRV_GRP4),
+	MTK_PIN(103, "MSDC0_DAT0",     DRV_GRP4),
+	MTK_PIN(104, "MSDC0_DSL",      DRV_GRP4),
+	MTK_PIN(105, "NCLE",           DRV_GRP4),
+	MTK_PIN(106, "NCEB1",          DRV_GRP4),
+	MTK_PIN(107, "NCEB0",          DRV_GRP4),
+	MTK_PIN(108, "NALE",           DRV_GRP4),
+	MTK_PIN(109, "NRNB",           DRV_GRP4),
+	MTK_PIN(110, "PCM_CLK",        DRV_GRP4),
+	MTK_PIN(111, "PCM_SYNC",       DRV_GRP4),
+	MTK_PIN(112, "PCM_RX",         DRV_GRP4),
+	MTK_PIN(113, "PCM_TX",         DRV_GRP4),
+	MTK_PIN(114, "I2S_DATA_IN",    DRV_GRP4),
+	MTK_PIN(115, "I2S_LRCK",       DRV_GRP4),
+	MTK_PIN(116, "I2S_BCK",        DRV_GRP4),
+	MTK_PIN(117, "DMIC0_CLK",      DRV_GRP4),
+	MTK_PIN(118, "DMIC0_DAT0",     DRV_GRP4),
+	MTK_PIN(119, "DMIC0_DAT1",     DRV_GRP4),
+	MTK_PIN(120, "DMIC1_CLK",      DRV_GRP4),
+	MTK_PIN(121, "DMIC1_DAT0",     DRV_GRP4),
+	MTK_PIN(122, "DMIC1_DAT1",     DRV_GRP4),
+	MTK_PIN(123, "DMIC2_CLK",      DRV_GRP4),
+	MTK_PIN(124, "DMIC2_DAT0",     DRV_GRP4),
+	MTK_PIN(125, "DMIC2_DAT1",     DRV_GRP4),
+	MTK_PIN(126, "DMIC3_CLK",      DRV_GRP4),
+	MTK_PIN(127, "DMIC3_DAT0",     DRV_GRP4),
+	MTK_PIN(128, "DMIC3_DAT1",     DRV_GRP4),
+	MTK_PIN(129, "TDM_TX_BCK",     DRV_GRP4),
+	MTK_PIN(130, "TDM_TX_LRCK",    DRV_GRP4),
+	MTK_PIN(131, "TDM_TX_MCK",     DRV_GRP4),
+	MTK_PIN(132, "TDM_TX_DATA0",   DRV_GRP4),
+	MTK_PIN(133, "TDM_TX_DATA1",   DRV_GRP4),
+	MTK_PIN(134, "TDM_TX_DATA2",   DRV_GRP4),
+	MTK_PIN(135, "TDM_TX_DATA3",   DRV_GRP4),
+	MTK_PIN(136, "CONN_TOP_CLK",   DRV_GRP4),
+	MTK_PIN(137, "CONN_TOP_DATA",  DRV_GRP4),
+	MTK_PIN(138, "CONN_HRST_B",    DRV_GRP4),
+	MTK_PIN(139, "CONN_WB_PTA",    DRV_GRP4),
+	MTK_PIN(140, "CONN_BT_CLK",    DRV_GRP4),
+	MTK_PIN(141, "CONN_BT_DATA",   DRV_GRP4),
+	MTK_PIN(142, "CONN_WF_CTRL0",  DRV_GRP4),
+	MTK_PIN(143, "CONN_WF_CTRL1",  DRV_GRP4),
+	MTK_PIN(144, "CONN_WF_CTRL2",  DRV_GRP4),
+};
+
+/* DISP PWM */
+static const char *const mt8365_disp_pwm_groups[] = { "disp_pwm" };
+
+static const int mt8365_disp_pwm_pins[] = { 19 };
+static const int mt8365_disp_pwm_funcs[] = { 1 };
+
+/* DPI */
+static const int mt8365_dpi_enable_pins[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static const int mt8365_dpi_enable_funcs[] = {
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
+};
+
+static const int mt8365_dpi_sleep_pins[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static const int mt8365_dpi_sleep_funcs[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+
+static const char *const mt8365_dpi_groups[] = { "dpi_enable", "dpi_sleep" };
+
+/* I2C */
+static const int mt8365_i2c0_pins[] = { 57, 58, };
+static const int mt8365_i2c0_funcs[] = { 1, 1, };
+static const int mt8365_i2c1_pins[] = { 59, 60, };
+static const int mt8365_i2c1_funcs[] = { 1, 1, };
+static const int mt8365_i2c2_pins[] = { 61, 62, };
+static const int mt8365_i2c2_funcs[] = { 1, 1, };
+static const int mt8365_i2c3_pins[] = { 63, 64, };
+static const int mt8365_i2c3_funcs[] = { 1, 1, };
+
+static const char *const mt8365_i2c_groups[] = { "i2c0", "i2c1", "i2c2", "i2c3" };
+
+static const struct mtk_group_desc mt8365_groups[] = {
+	PINCTRL_PIN_GROUP("disp_pwm",	mt8365_disp_pwm),
+	PINCTRL_PIN_GROUP("dpi_enable", mt8365_dpi_enable),
+	PINCTRL_PIN_GROUP("dpi_sleep",	mt8365_dpi_sleep),
+	PINCTRL_PIN_GROUP("i2c0",       mt8365_i2c0),
+	PINCTRL_PIN_GROUP("i2c1",	mt8365_i2c1),
+	PINCTRL_PIN_GROUP("i2c2",       mt8365_i2c2),
+	PINCTRL_PIN_GROUP("i2c3",       mt8365_i2c3),
+};
+
+static const struct mtk_function_desc mt8365_functions[] = {
+	{"disp", mt8365_disp_pwm_groups, ARRAY_SIZE(mt8365_disp_pwm_groups)},
+	{"dpi", mt8365_dpi_groups, ARRAY_SIZE(mt8365_dpi_groups)},
+	{"i2c", mt8365_i2c_groups, ARRAY_SIZE(mt8365_i2c_groups)},
+};
+
+static const struct mtk_pinctrl_soc mt8365_data = {
+	.name      = "mt8365_pinctrl",
+	.reg_cal   = mt8365_reg_cals,
+	.pins      = mt8365_pins,
+	.npins     = ARRAY_SIZE(mt8365_pins),
+	.grps      = mt8365_groups,
+	.ngrps     = ARRAY_SIZE(mt8365_groups),
+	.funcs     = mt8365_functions,
+	.nfuncs    = ARRAY_SIZE(mt8365_functions),
+	.gpio_mode = 0,
+	.rev       = MTK_PINCTRL_V1,
+};
+
+static int mtk_pinctrl_mt8365_probe(struct udevice *dev)
+{
+	return mtk_pinctrl_common_probe(dev, &mt8365_data);
+}
+
+static const struct udevice_id mt8365_pctrl_match[] = {
+	{ .compatible = "mediatek,mt8365-pinctrl" },
+	{ }
+};
+
+U_BOOT_DRIVER(mt8365_pinctrl) = {
+	.name      = "mt8365_pinctrl",
+	.id        = UCLASS_PINCTRL,
+	.of_match  = mt8365_pctrl_match,
+	.ops       = &mtk_pinctrl_ops,
+	.probe     = mtk_pinctrl_mt8365_probe,
+	.priv_auto = sizeof(struct mtk_pinctrl_priv),
+};

-- 
2.43.0

