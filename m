Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E891CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B63686CB1;
	Tue, 17 Oct 2023 20:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEAevLFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3150C86F0F; Tue, 17 Oct 2023 20:24:27 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2F586F0F
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2b1b25547so2787295b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697567062; x=1698171862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtEzSWmWImGAtWgB1KStDSqeyZu/cONW4seYzWlD3VY=;
 b=dEAevLFZRt6JFvHyUekYFMGZdA2JiaZjlhbcMRdwQdLoqxkfTBydEYscnnL8WYEmU4
 4m9Wcu/YpsFuEDxCbxc0oZPcHNXQ6LT/3BitG6KfTR5XMlk1+WBSaWSXm3W10U06lutr
 pl4EtLuDcVdj7FaP85OCxQFXc9duilRdXNVPf0zF0N+JycEjtswKL8Jk7ZqcDBssdG/B
 LxuZLbSkuApYX8D40iyc9cG/w8H/G0dnPvOewoRdvGpuPU4ORUrgnUCzKcaNdrs+4iqP
 gCF0se/SuiMojAS/cESdXKyE4GuqxWcSMVhoKsn6B0TIidITCw2iRzpcKeRaN1wXPzna
 1LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697567062; x=1698171862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtEzSWmWImGAtWgB1KStDSqeyZu/cONW4seYzWlD3VY=;
 b=rtO1/DhIP8vYHZWl1RUS2jHNCe6v4PKkaDVtd6HadJhEvdYwWQ5IsXI6DBbWrAsVJI
 gTAOV/xbXtGiC+GA9MaCD280opbyhNShNi1P/z/+Y7MVsI2F0csRHtFhHxP9d6JGd28h
 vIm2RBVgFOOoDuqklSLFCyRlhkmvA9C3eezUp9dRnMpgXNg1+VUDvx5YWQLnd1kLIAve
 Xd6UwMRwprNNOnO39YP6kYbHxIBurgCm0FxRjVH6CPgleSNYbxCFTlcxbM9cQfp6/+Tf
 FUz4WmGrtXmdAAjhj/pvwURK2iyCASihIhX+p+drW/QTIyUfnMlCKICUrk3sdIwocJDE
 VTIA==
X-Gm-Message-State: AOJu0YwIRBnsgvPSGcmlYLXXpSizvXYwa5XVE0JscLtm39AJQleBFDtH
 jvQhhjEBX6pQApyv+2dfm2+SCAepG3M=
X-Google-Smtp-Source: AGHT+IEKUlcx0ERA+EVf84AFkK3loh2cHTBGB36ehfr1AnLIb97jEWYh2ZlRj3yqpNu3DktbEwbmzQ==
X-Received: by 2002:a05:6808:1a11:b0:3ad:fd8e:7809 with SMTP id
 bk17-20020a0568081a1100b003adfd8e7809mr3846284oib.49.1697567061773; 
 Tue, 17 Oct 2023 11:24:21 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 6-20020aca0b06000000b003a3860b375esm340312oil.34.2023.10.17.11.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 11:24:21 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3] board: rockchip: Add Maskrom Mode for Anbernic RGxx3
Date: Tue, 17 Oct 2023 13:24:13 -0500
Message-Id: <20231017182414.321411-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017182414.321411-1-macroalpha82@gmail.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
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

Add support for users to enter maskrom mode by holding the function
button when they power up the device.

Since the device has soldered eMMC and sometimes does not expose a clk
pin on the mainboard there is a small chance that a user who flashes a
bad bootloader may not be able to recover if the headers themselves
are valid. As a result this check is done during spl_early_init() to
ensure that it runs as early as possible, and it does so by directly
manipulating the ADC hardware in lieu of loading the ADC driver.

Ideally, once we have an open source TPL stage we can move this to
the TPL stage, so it will run even earlier.

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

