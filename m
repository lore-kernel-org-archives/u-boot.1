Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACA7C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB3D82F30;
	Fri,  4 Jul 2025 23:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pa96g34Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D85182CFA; Fri,  4 Jul 2025 23:50:29 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8E282CFA
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so526417fac.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665826; x=1752270626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zWXMOMWk7Gg1qYNfGbVk8JM+YbuV1hk0tb+bH02rvk4=;
 b=Pa96g34ZimJv5ynfxBH/9LEVJxAsNcmU+C8rqcwoqg1R0Z85KLTotLm7gCjT0smYoy
 QnAH0rkRKoON7ybkHUpR5LeBY9NCx0zpBr0Pk340CQToV0y7YhBJKqzsFWfJCJVmYvin
 RvBTaha6ezz0bZlTWbKP9ywi+uh6tA6uZrLbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665826; x=1752270626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWXMOMWk7Gg1qYNfGbVk8JM+YbuV1hk0tb+bH02rvk4=;
 b=W8DWkFuKLWOBl2GWe8TzySru920Y7UF2cPk2bRRZ65ifQD8ggILpvHeOa9p0Um4dJM
 lFTyS6ItMrJB7MJnkGKxfnN5ojTINcSktZ7IO5Rlc9ntfdL79ikvW2pEhbPEu8m/N+dF
 8LrI8J7dCEh3uHvnyFXkh9xz0EPfdOpCUE354wLWTngrKG0j9w9Xs027+Cu7+6EK1PW0
 Z+ZzTFvLC+H7ovMJUNlNZigOWxsSJyLFYLgsdPuGuadevfOy3zEbTVwpFjI8GwefDbaG
 V8If9Kr+dQUoZ+AnfUUf7/ExWFqRR7FhAanO7SS3Ztk8U0xFf4ZOyBQs6UvGtc1ZWPCQ
 IVXA==
X-Gm-Message-State: AOJu0Yz/Kf2qPmI6j16nnwOsDcMDP+pzKV7KCb+o0JTBm45JVSl8Ifln
 gvL/RJHs0smaA1JPJIaEMjfVaMS4TlvqVaw12lzSZinMaxK/uwkC17KYlkx2rr7lEEdQ7jQQQBD
 g4WDJaXc=
X-Gm-Gg: ASbGncvD2MorS6zZbAkB+zcO/T03XispsBR0i4Gf76jxHMLYqdx3r6WCD6dAxEtz3th
 tjiDv1n7FTarvMcobwNYXNRXEWrsG+BuSQFk17RHCTLf/g29A9hNaWDa8GP1fr9w8DCsOC1Pmla
 msislxDQbjBbDllHhwlVk7NzZ/aV2PUZYUMP9lTq5B11HXORXpVelrauDyMBo1XN2crCW2iZKZB
 DtFxS+F24VnvuEjWHh0rMpLeC5CNKWHkPnRj0kPePg2PXv2RS7N76u+9h6xFkrlv1wbdl742Hwx
 vWlpVIMxQPNxe/bh3wIni9Vls4V7drCufVZnV6Fl1hDXYEYxr9zBgM0PYRFWukOcfGqrv404c+L
 0/pgzFl/HuEe5iBdHsqiTIoM=
X-Google-Smtp-Source: AGHT+IHEJFqOfz3KabCYIf1ndfw4B/bC7yh930puAY/E0n1gmUggO21Dpr8RmxAQni77WcYLoV38xw==
X-Received: by 2002:a05:6871:204:b0:2d9:3868:b310 with SMTP id
 586e51a60fabf-2f7afed031cmr219266fac.11.1751665825517; 
 Fri, 04 Jul 2025 14:50:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f79020c84asm739414fac.36.2025.07.04.14.50.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:50:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] power: Split *POWER_LEGACY portion of <power/pmic.h>
 out to new header
Date: Fri,  4 Jul 2025 15:50:21 -0600
Message-ID: <20250704215021.3419863-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704215021.3419863-1-trini@konsulko.com>
References: <20250704215021.3419863-1-trini@konsulko.com>
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
Changes in v2:
- Remove one more now incorrect comment
---
 include/power/pmic.h        | 89 ++---------------------------------
 include/power/pmic_legacy.h | 94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 86 deletions(-)
 create mode 100644 include/power/pmic_legacy.h

diff --git a/include/power/pmic.h b/include/power/pmic.h
index 636221692d0b..4aee07383a98 100644
--- a/include/power/pmic.h
+++ b/include/power/pmic.h
@@ -17,76 +17,9 @@
 
 enum { PMIC_I2C, PMIC_SPI, PMIC_NONE};
 
-/* TODO: Change to !CONFIG_IS_ENABLED(DM_PMIC) when SPL_DM_PMIC exists */
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
@@ -308,23 +241,7 @@ struct uc_pmic_priv {
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

