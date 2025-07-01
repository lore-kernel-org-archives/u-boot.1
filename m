Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4431EC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E4782FCA;
	Tue,  1 Jul 2025 20:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WuDe6WMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8B382F83; Tue,  1 Jul 2025 20:42:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABF882B18
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73a4c557d47so2935268a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395373; x=1752000173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4vy8jg/6ySR3pSnTF2yhHLU1pqE1p0iuM8TzG8xS5+4=;
 b=WuDe6WMI2HxUIXWINCR4/ZPgKIVmC0EZcW7zGoTnZDwiHv41aBGkxiohwc5Sjb4tB0
 Yiyu7CRBhiwvy3Y3BVDS2XfMF/yfgTOeUOCNbKhpstP+NufYmgB+wIHyfOVK6BM4LVIZ
 s3blHZgxK9+QESaZnBJNlPwOugvl9dVzNbqGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395373; x=1752000173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vy8jg/6ySR3pSnTF2yhHLU1pqE1p0iuM8TzG8xS5+4=;
 b=hl14QNVswx/zvYGgmaPetfnz1DzFpVAipknhVxhoqY0u9RbdZfieXh3cOv1TtjiuS6
 HHlSNe8yo3wjOgB9fTOF/7G2fKeJfZpmn7ehfPC4ByRODjh9J8D4LorKu9iI4gCMLTU7
 GGbFbTRuaUjlH7s9BF4fEkK1VJUw5sY3mOg+Nw0RMvd6puva2m86aBVGcNgNYmKlZm+h
 1NOHLVJNF56CN7djv80e5Z+8eDs8g6JW0u2/59VW68Loxib9s5Xjj1wpiRrpWad89jXf
 Zvg8VPXBYvavWKUla3lcVw6gPQ5iwreO5cleiAyZQK60dhFwNc2RctQvCVdpdClSSXEM
 Wb3Q==
X-Gm-Message-State: AOJu0YwxTbbFnjXhUxBvyXWFDFz7x4T5P6EY4RtYWvabfkfPs7zSJgpQ
 CljrHIDV3kp2Oj62YWPIHoWjUEnUnhymsPH+i2wB0dyZdtJ9CQDaHeKwOtXGW39wrwd/m7COoib
 FQHi0tnI=
X-Gm-Gg: ASbGncts/pmg4BUSpaS4QuBqrUJtMsoRxwKju5ZogcMHemI9ia9v7k4puh2+jf4ucQF
 HdroCQGiByrpg0ulSlHdaf52gn0GwGZ9P2K9li9qPZavGlF9ZkfWJWrnvs9GyKktSNJsO4KOWGd
 Qj7rmoWxKWmcEaJMjx/BEdobttBhYbTy/1a4EY3tbANdLCt3sJqziUiAeeUsHU1rS/+YhQkBt8f
 0LcDzjU/KALKR5p3qI2eKAO4wWmzXJx97ngGvo6NeZPnkk/wiKxtjuLpw4Tj3A9kvpAYQg2zRyv
 krgShSjcu4M1eqf5ClHq48E1Wh9XOu+ANVtl7TWMOhZRMZE6FNn95yPHagdkP5MGd6NsfF0CSVo
 MSB7bWkNxrIyw779QbDleMsO3xw==
X-Google-Smtp-Source: AGHT+IGS8XgZcGh+vuPqV7KtvZsPbE/3TNY3RMtmxJ4YIEDABfnOc+8G1pej/nle5UiFK5KT2ifQYQ==
X-Received: by 2002:a05:6808:6f97:b0:3f7:e860:b5f3 with SMTP id
 5614622812f47-40b33e34b86mr15403606b6e.22.1751395373576; 
 Tue, 01 Jul 2025 11:42:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e189sm2239234b6e.49.2025.07.01.11.42.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] power: Split *POWER_LEGACY portion of <power/pmic.h> out
 to new header
Date: Tue,  1 Jul 2025 12:42:51 -0600
Message-ID: <20250701184252.3191485-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The commends in include/power/pmic.h say that once SPL_DM_PMIC exists we
should update things. This has been true for some time, so let us update
this to have the legacy portions in their own header, which should not
be directly included. This cleans up the logic within the file too
slightly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/power/pmic.h        | 88 ++--------------------------------
 include/power/pmic_legacy.h | 94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 85 deletions(-)
 create mode 100644 include/power/pmic_legacy.h

diff --git a/include/power/pmic.h b/include/power/pmic.h
index 636221692d0b..7344b5889cee 100644
--- a/include/power/pmic.h
+++ b/include/power/pmic.h
@@ -19,74 +19,8 @@ enum { PMIC_I2C, PMIC_SPI, PMIC_NONE};
 
 /* TODO: Change to !CONFIG_IS_ENABLED(DM_PMIC) when SPL_DM_PMIC exists */
 #if CONFIG_IS_ENABLED(POWER_LEGACY)
-enum { I2C_PMIC, I2C_NUM, };
-enum { PMIC_READ, PMIC_WRITE, };
-enum { PMIC_SENSOR_BYTE_ORDER_LITTLE, PMIC_SENSOR_BYTE_ORDER_BIG, };
-
-enum {
-	PMIC_CHARGER_DISABLE,
-	PMIC_CHARGER_ENABLE,
-};
-
-struct p_i2c {
-	unsigned char addr;
-	unsigned char *buf;
-	unsigned char tx_num;
-};
-
-struct p_spi {
-	unsigned int cs;
-	unsigned int mode;
-	unsigned int bitlen;
-	unsigned int clk;
-	unsigned int flags;
-	u32 (*prepare_tx)(u32 reg, u32 *val, u32 write);
-};
-
-struct pmic;
-struct power_fg {
-	int (*fg_battery_check) (struct pmic *p, struct pmic *bat);
-	int (*fg_battery_update) (struct pmic *p, struct pmic *bat);
-};
-
-struct power_chrg {
-	int (*chrg_type) (struct pmic *p);
-	int (*chrg_bat_present) (struct pmic *p);
-	int (*chrg_state) (struct pmic *p, int state, int current);
-};
-
-struct power_battery {
-	struct battery *bat;
-	int (*battery_init) (struct pmic *bat, struct pmic *p1,
-			     struct pmic *p2, struct pmic *p3);
-	int (*battery_charge) (struct pmic *bat);
-	/* Keep info about power devices involved with battery operation */
-	struct pmic *chrg, *fg, *muic;
-};
-
-struct pmic {
-	const char *name;
-	unsigned char bus;
-	unsigned char interface;
-	unsigned char sensor_byte_order;
-	unsigned int number_of_regs;
-	union hw {
-		struct p_i2c i2c;
-		struct p_spi spi;
-	} hw;
-
-	void (*low_power_mode) (void);
-	struct power_battery *pbat;
-	struct power_chrg *chrg;
-	struct power_fg *fg;
-
-	struct pmic *parent;
-	struct list_head list;
-};
-#endif /* CONFIG_IS_ENABLED(POWER_LEGACY) */
-
-/* TODO: Change to CONFIG_IS_ENABLED(DM_PMIC) when SPL_DM_PMIC exists */
-#if defined(CONFIG_DM_PMIC) || !CONFIG_IS_ENABLED(POWER_LEGACY)
+#include <power/pmic_legacy.h>
+#else
 /**
  * U-Boot PMIC Framework
  * =====================
@@ -308,23 +242,7 @@ struct uc_pmic_priv {
 	uint trans_len;
 };
 
-#endif /* DM_PMIC */
-
-/* TODO: Change to CONFIG_IS_ENABLED(DM_PMIC) when SPL_DM_PMIC exists */
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-
-/* Legacy API, do not use */
-int pmic_init(unsigned char bus);
-int power_init_board(void);
-int pmic_dialog_init(unsigned char bus);
-int check_reg(struct pmic *p, u32 reg);
-struct pmic *pmic_alloc(void);
-struct pmic *pmic_get(const char *s);
-int pmic_probe(struct pmic *p);
-int pmic_reg_read(struct pmic *p, u32 reg, u32 *val);
-int pmic_reg_write(struct pmic *p, u32 reg, u32 val);
-int pmic_set_output(struct pmic *p, u32 reg, int ldo, int on);
-#endif /* CONFIG_IS_ENABLED(POWER_LEGACY) */
+#endif
 
 #define pmic_i2c_addr (p->hw.i2c.addr)
 #define pmic_i2c_tx_num (p->hw.i2c.tx_num)
diff --git a/include/power/pmic_legacy.h b/include/power/pmic_legacy.h
new file mode 100644
index 000000000000..7c244060b4ab
--- /dev/null
+++ b/include/power/pmic_legacy.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright (C) 2014-2015 Samsung Electronics
+ *  Przemyslaw Marczak <p.marczak@samsung.com>
+ *
+ *  Copyright (C) 2011-2012 Samsung Electronics
+ *  Lukasz Majewski <l.majewski@samsung.com>
+ */
+
+#ifndef __POWER_PMIC_LEGACY_H__
+#define __POWER_PMIC_LEGACY_H__
+
+#ifndef __CORE_PMIC_H_
+#error "Do not include <power/pmic_legacy.h> directly"
+#endif
+
+enum { I2C_PMIC, I2C_NUM, };
+enum { PMIC_READ, PMIC_WRITE, };
+enum { PMIC_SENSOR_BYTE_ORDER_LITTLE, PMIC_SENSOR_BYTE_ORDER_BIG, };
+
+enum {
+	PMIC_CHARGER_DISABLE,
+	PMIC_CHARGER_ENABLE,
+};
+
+struct p_i2c {
+	unsigned char addr;
+	unsigned char *buf;
+	unsigned char tx_num;
+};
+
+struct p_spi {
+	unsigned int cs;
+	unsigned int mode;
+	unsigned int bitlen;
+	unsigned int clk;
+	unsigned int flags;
+	u32 (*prepare_tx)(u32 reg, u32 *val, u32 write);
+};
+
+struct pmic;
+struct power_fg {
+	int (*fg_battery_check) (struct pmic *p, struct pmic *bat);
+	int (*fg_battery_update) (struct pmic *p, struct pmic *bat);
+};
+
+struct power_chrg {
+	int (*chrg_type) (struct pmic *p);
+	int (*chrg_bat_present) (struct pmic *p);
+	int (*chrg_state) (struct pmic *p, int state, int current);
+};
+
+struct power_battery {
+	struct battery *bat;
+	int (*battery_init) (struct pmic *bat, struct pmic *p1,
+			     struct pmic *p2, struct pmic *p3);
+	int (*battery_charge) (struct pmic *bat);
+	/* Keep info about power devices involved with battery operation */
+	struct pmic *chrg, *fg, *muic;
+};
+
+struct pmic {
+	const char *name;
+	unsigned char bus;
+	unsigned char interface;
+	unsigned char sensor_byte_order;
+	unsigned int number_of_regs;
+	union hw {
+		struct p_i2c i2c;
+		struct p_spi spi;
+	} hw;
+
+	void (*low_power_mode) (void);
+	struct power_battery *pbat;
+	struct power_chrg *chrg;
+	struct power_fg *fg;
+
+	struct pmic *parent;
+	struct list_head list;
+};
+
+/* Legacy API, do not use */
+int pmic_init(unsigned char bus);
+int power_init_board(void);
+int pmic_dialog_init(unsigned char bus);
+int check_reg(struct pmic *p, u32 reg);
+struct pmic *pmic_alloc(void);
+struct pmic *pmic_get(const char *s);
+int pmic_probe(struct pmic *p);
+int pmic_reg_read(struct pmic *p, u32 reg, u32 *val);
+int pmic_reg_write(struct pmic *p, u32 reg, u32 val);
+int pmic_set_output(struct pmic *p, u32 reg, int ldo, int on);
+
+#endif
-- 
2.43.0

