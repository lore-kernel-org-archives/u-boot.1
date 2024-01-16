Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE424C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 06:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E3A874B1;
	Tue, 16 Jan 2024 07:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="XYMYeDrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA44874D5; Tue, 16 Jan 2024 07:36:18 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C933387252
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 07:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nylon.chen@sifive.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28c0d8dd88bso6223683a91.2
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 22:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1705386974; x=1705991774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gK0l1hMmXoD7levuP84DusPDgVyXbYoe477DqMAl938=;
 b=XYMYeDrGVXadYU1hFyAHljoYuz3lOmFwiTzXtqm338FN7Y4lXqZs/j73ZEkM009Yxb
 qCK8gQBRtXFAiVVW7KKSI12fVCdJqRLJNCJMeaj3BNm3zukp25m7aLjaCAMEwOrEdzWF
 X/a63lbGCUGd+oW0fkroebQ0PP4KOO8matrK8mf4YESLyUs3k7oM57mI+jvlH2az9uma
 w57nC5fbCWJ7qqRaPVIgBG77Sl3sRFlIs1/4Js77CamumtHPqMsiRcU41R7IzYQZcIFg
 VV4fKW+Zwgv4imDiUpmfF753ibnFmWl1Sj7QRYYeA/9UkGNLIYkwJC+otcSUHjhxs4cj
 ICbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705386974; x=1705991774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gK0l1hMmXoD7levuP84DusPDgVyXbYoe477DqMAl938=;
 b=abZMNo3b+JfQPgNjRgx0/Ra9OUv6phYlKXsDS+m/TcSa5n9XwggE7z6KHwR/VOlO84
 WlsUJyldlYPURip4YmbTFw6OoeFazwvtZ5r8lp20F0a/0HHBJ6di8VwwJDbO5x7et2nh
 /uJdoKlb6+KMyc1jGbeu+WxdL65wm51Cp7RQWwGM1BXBw0mh+zzzrI/3bN/ii/ljZbX7
 RqSZY1dO0aHd9LmE438XwRVTU/54LLckcWJO8respoz8R33BZXY4y4QaJ8kyzh/2fT+7
 1r0ivzN32OPiKw9iwZcvdoW0WciRBClLduU9fhlz1lAWdtwIK4h3XpVQ6DnObRstgMIV
 Z82Q==
X-Gm-Message-State: AOJu0Yz11F6V+0+036PPlFFdc5Ib/PZ53TdLWYVUV2GjSwRp5nxCtHml
 qknyP/czjOHvtgZBj+IV5ZWyZUXZMDN9wagxIQ4xJ/msGfdQCcJBIZ+G1V6oj4Zpc1+GVB7XLoP
 kSddTMTnY84LcuRWRLb2kzyWrczxBUKs1OqCORbeFvDqXSzcdm3tBejsovpwow2X2Q13FZy9zLR
 AvOvAddUs=
X-Google-Smtp-Source: AGHT+IGuMhxPgFKcuST4oKc8tQSffNqA1AgpxWirHhkRIIqeMocgPtRwNa+mAAHQq8aBARWE+Ye+7g==
X-Received: by 2002:a17:90a:2cc1:b0:28d:dfdd:3f03 with SMTP id
 n59-20020a17090a2cc100b0028ddfdd3f03mr3405376pjd.6.1705386973655; 
 Mon, 15 Jan 2024 22:36:13 -0800 (PST)
Received: from hsinchu15.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 qn4-20020a17090b3d4400b0028b3539cd97sm13263175pjb.20.2024.01.15.22.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 22:36:13 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com,
 paul.walmsley@sifive.com, green.wan@sifive.com, vincent.chen@sifive.com
Cc: zong.li@sifve.com, nylon7717@gmail.com, Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH] board: sifive: spl: Initialized the PWM setting in the SPL
 stage
Date: Tue, 16 Jan 2024 14:35:57 +0800
Message-ID: <20240116063557.28763-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
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

From: Vincent Chen <vincent.chen@sifive.com>

LEDs and multiple fans can be controlled by SPL. This patch ensures
that all fans have been enabled in the SPL stage. In addition, the
LED's color will be set to yellow.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Co-developed-by: Nylon Chen <nylon.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
---
 arch/riscv/include/asm/arch-fu740/eeprom.h | 15 +++++++
 board/sifive/unmatched/spl.c               | 52 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/riscv/include/asm/arch-fu740/eeprom.h

diff --git a/arch/riscv/include/asm/arch-fu740/eeprom.h b/arch/riscv/include/asm/arch-fu740/eeprom.h
new file mode 100644
index 0000000000..aaa02c6d2b
--- /dev/null
+++ b/arch/riscv/include/asm/arch-fu740/eeprom.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 SiFive, Inc.
+ *
+ * Zong Li <zong.li@sifve.com>
+ */
+
+#ifndef _ASM_RISCV_EEPROM_H
+#define _ASM_RISCV_EEPROM_H
+
+#define PCB_REVISION_REV3      0x3
+
+u8 get_pcb_revision_from_eeprom(void);
+
+#endif /* _ASM_RISCV_EEPROM_H */
diff --git a/board/sifive/unmatched/spl.c b/board/sifive/unmatched/spl.c
index 7c0beedc08..6f459bd651 100644
--- a/board/sifive/unmatched/spl.c
+++ b/board/sifive/unmatched/spl.c
@@ -15,6 +15,29 @@
 #include <asm/gpio.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/spl.h>
+#include <linux/io.h>
+#include <asm/arch/eeprom.h>
+
+struct pwm_sifive_regs {
+	unsigned int cfg;       /* PWM configuration register */
+	unsigned int pad0;      /* Reserved */
+	unsigned int cnt;       /* PWM count register */
+	unsigned int pad1;      /* Reserved */
+	unsigned int pwms;      /* Scaled PWM count register */
+	unsigned int pad2;      /* Reserved */
+	unsigned int pad3;      /* Reserved */
+	unsigned int pad4;      /* Reserved */
+	unsigned int cmp0;      /* PWM 0 compare register */
+	unsigned int cmp1;      /* PWM 1 compare register */
+	unsigned int cmp2;      /* PWM 2 compare register */
+	unsigned int cmp3;      /* PWM 3 compare register */
+};
+
+#define PWM0_BASE               0x10020000
+#define PWM1_BASE               0x10021000
+#define PWM_CFG_INIT            0x1000
+#define PWM_CMP_ENABLE_VAL      0x0
+#define PWM_CMP_DISABLE_VAL     0xffff
 
 #define UBRDG_RESET	SIFIVE_GENERIC_GPIO_NR(0, 7)
 #define ULPI_RESET	SIFIVE_GENERIC_GPIO_NR(0, 9)
@@ -26,6 +49,33 @@
 #define MODE_SELECT_SD		0xb
 #define MODE_SELECT_MASK	GENMASK(3, 0)
 
+void spl_pwm_device_init(void)
+{
+	struct pwm_sifive_regs *pwm0, *pwm1;
+
+	pwm0 = (struct pwm_sifive_regs *)PWM0_BASE;
+	pwm1 = (struct pwm_sifive_regs *)PWM1_BASE;
+	writel(PWM_CMP_DISABLE_VAL, (void *)&pwm0->cmp0);
+
+	/* Set the 3-color PWM LEDs to yellow in SPL */
+	writel(PWM_CMP_ENABLE_VAL, (void *)&pwm0->cmp1);
+	writel(PWM_CMP_ENABLE_VAL, (void *)&pwm0->cmp2);
+	writel(PWM_CMP_DISABLE_VAL, (void *)&pwm0->cmp3);
+	writel(PWM_CFG_INIT, (void *)&pwm0->cfg);
+
+	/* Turn on all the fans, (J21), (J23) and (J24), on the unmatched board */
+	/* The SoC fan(J21) on the rev3 board cannot be controlled by PWM_COMP0,
+	 *            so here sets the initial value of PWM_COMP0 as DISABLE */
+	if (get_pcb_revision_from_eeprom() == PCB_REVISION_REV3)
+		writel(PWM_CMP_DISABLE_VAL, (void *)&pwm1->cmp1);
+	else
+		writel(PWM_CMP_ENABLE_VAL, (void *)&pwm1->cmp1);
+
+	writel(PWM_CMP_ENABLE_VAL, (void *)&pwm1->cmp2);
+	writel(PWM_CMP_ENABLE_VAL, (void *)&pwm1->cmp3);
+	writel(PWM_CFG_INIT, (void *)&pwm1->cfg);
+}
+
 static inline int spl_reset_device_by_gpio(const char *label, int pin, int low_width)
 {
 	int ret;
@@ -90,6 +140,8 @@ int spl_board_init_f(void)
 		goto end;
 	}
 
+	spl_pwm_device_init();
+
 	ret = spl_gemgxl_init();
 	if (ret) {
 		debug("Gigabit ethernet PHY (VSC8541) init failed: %d\n", ret);
-- 
2.34.1

