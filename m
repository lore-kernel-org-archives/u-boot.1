Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F3FC5AD4C
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30A886E42;
	Fri, 17 Nov 2023 22:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TUb2cHpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8948004E; Fri, 17 Nov 2023 22:15:20 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA5786EEE
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1ef370c2e12so1308695fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700255712; x=1700860512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9mVb/jt3JVc8Ypdn8czBVUyg2YOXPeJCYI4uM/mC0s=;
 b=TUb2cHpRvnV0Nu39LmJPmzra97muspjPo3PQGS0TsINd/R6EDMV8py/07wqxy5NbTC
 /fDhifZXfhpVeqeX8UYrddpCq/sqZtKi4k8Oa+P0SSmtLMLEqay+O8YKD56+M0+7acwq
 z/ezMwWY91Cs3lP+W00tZelvmoXQQwUcBGNMKF4Z5L413A7zpBg6qT0WgMs0s9N8Ms3L
 54HQ+RCzlNKtUW2ZzIqTD5+yhZEGhpYMfVGIYgXowZAdW+NTXJSvkwvd0Syj9RV3RzUr
 BKt2wVAhvcyYL4T4FIhbSDSgNEik0+jVR9K3I4w1GR8slGWRGDY4nZgYsO5lTuJDHGjD
 85iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700255712; x=1700860512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9mVb/jt3JVc8Ypdn8czBVUyg2YOXPeJCYI4uM/mC0s=;
 b=oxoWVnvWGnhPAm1T53PQhssvuXtsyYQGMIqYLrgiyKTZYw7Zsf5/PjvuP3aOE/B++z
 87ZVHrxqbcmdO9uqgLFbTsBJNzdBQC8SFh8UQ+Gao7c1Y2w3RdMh2Ir06jAL7hB4Oxxv
 mMwoVSGkejJ0MbAj7MoMuWaxduBUU6hOuT6vZKusY6KjkpEWDTgX/vTA5MRFNR4Nz9c1
 8k92d46oY/3EMAE7V26VuSyJJ0dA7lPf6x/zwtT5NwmWBAR9Jb/b3UcQ/VNOosB1oYTk
 2/agHE+u/OM16fnYts5PyaWJKFeXVPl+8stKjx/MQITgP7gp05qVtSgLghHLNix5YGi7
 Ws8Q==
X-Gm-Message-State: AOJu0YyJm0MR2Xx0fwZcnVSH02OfEMkDWzMoG3YZqmtuLSX9Cr2yFgHw
 mmksBWa0D7lHmjdfTCVe1wT/x/A0tFU=
X-Google-Smtp-Source: AGHT+IG5+/zNgXydUM0fMHzEGTTQvwbqG1YtBmneB4rBvt+VUhG/pEqXuOrvxzRjFuyPEz5v+De9WQ==
X-Received: by 2002:a05:6870:f728:b0:1e9:ae68:fda1 with SMTP id
 ej40-20020a056870f72800b001e9ae68fda1mr483845oab.1.1700255712334; 
 Fri, 17 Nov 2023 13:15:12 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 zl3-20020a0568716d8300b001d6e9bb67d2sm415378oab.7.2023.11.17.13.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:15:12 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 2/4] board: rockchip: Add Recovery Button for Anbernic RGxx3
Date: Fri, 17 Nov 2023 15:15:04 -0600
Message-Id: <20231117211506.1396929-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117211506.1396929-1-macroalpha82@gmail.com>
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for users to enter recovery mode by holding the function
button when they power up the device.

Since the device has soldered eMMC and sometimes does not expose a clk
pin on the mainboard there is a small chance that a user who flashes a
bad bootloader may not be able to recover if the headers themselves
are valid. As a result this check is done during spl_early_init() to
ensure that it runs as early as possible, and it does so by directly
manipulating the ADC hardware in lieu of loading the ADC driver.

Ideally, once we have an open source TPL stage we can move this to
the TPL stage, so it will run even earlier. It may also be possible
to make this code "more portable", but at the tradeoff of requiring
to be run later in the boot process. For now it's done in a board
specific way to err on the side of "do it early".

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 3d0c614623..a93b11cd47 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -6,12 +6,14 @@
 #include <abuf.h>
 #include <adc.h>
 #include <asm/io.h>
+#include <command.h>
 #include <display.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <mipi_dsi.h>
 #include <mmc.h>
 #include <panel.h>
@@ -20,6 +22,8 @@
 #include <stdlib.h>
 #include <video_bridge.h>
 
+#define BOOT_BROM_DOWNLOAD	0xef08a53c
+
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
 #define GPIO_SWPORT_DR_L	0x0000
@@ -33,6 +37,14 @@
 
 #define GPIO_WRITEMASK(bits)	((bits) << 16)
 
+#define SARADC_BASE		0xfe720000
+#define SARADC_DATA		0x0000
+#define SARADC_STAS		0x0004
+#define SARADC_ADC_STATUS	BIT(0)
+#define SARADC_CTRL		0x0008
+#define SARADC_INPUT_SRC_MSK	0x7
+#define SARADC_POWER_CTRL	BIT(3)
+
 #define DTB_DIR			"rockchip/"
 
 struct rg3xx_model {
@@ -118,12 +130,64 @@ static const struct rg353_panel rg353_panel_details[] = {
 	},
 };
 
+/*
+ * The device has internal eMMC, and while some devices have an exposed
+ * clk pin you can ground to force a bypass not all devices do. As a
+ * result it may be possible for some devices to become a perma-brick
+ * if a corrupted TPL or SPL stage with a valid header is flashed to
+ * the internal eMMC. Add functionality to read ADC channel 0 (the func
+ * button) as early as possible in the boot process to provide some
+ * protection against this. If we ever get an open TPL stage, we should
+ * consider moving this function there.
+ */
+void read_func_button(void)
+{
+	int ret;
+	u32 reg;
+
+	/* Turn off SARADC to reset it. */
+	writel(0, (SARADC_BASE + SARADC_CTRL));
+
+	/* Enable channel 0 and power on SARADC. */
+	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
+	       (SARADC_BASE + SARADC_CTRL));
+
+	/*
+	 * Wait for data to be ready. Use timeout of 20000us from
+	 * rockchip_saradc driver.
+	 */
+	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
+				 !(reg & SARADC_ADC_STATUS), 20000);
+	if (ret) {
+		printf("ADC Timeout");
+		return;
+	}
+
+	/* Read the data from the SARADC. */
+	reg = readl((SARADC_BASE + SARADC_DATA));
+
+	/* Turn the SARADC back off so it's ready to be used again. */
+	writel(0, (SARADC_BASE + SARADC_CTRL));
+
+	/*
+	 * If the value is less than 30 the button is being pressed.
+	 * Reset the device back into Rockchip download mode.
+	 */
+	if (reg <= 30) {
+		printf("download key pressed, entering download mode...");
+		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+	}
+};
+
 /*
  * Start LED very early so user knows device is on. Set color
  * to red.
  */
 void spl_board_init(void)
 {
+	read_func_button();
+
 	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
 	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
-- 
2.34.1

