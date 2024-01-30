Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A77C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE4B87CEA;
	Tue, 30 Jan 2024 15:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cweJZu5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811F887DD9; Tue, 30 Jan 2024 15:05:21 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAB387D07
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51028acdcf0so4935247e87.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623516; x=1707228316; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+Z/itasEdVl+93wmdY3Hqkz2ZxgLcPT57V/RsMNa8o=;
 b=cweJZu5FWJlOeyBh6z5FV5t790XtCdj22VjgIaiCAAbZAd1nSF01GyHgpitF9AEjMZ
 elEwlHuFzDWrrRxEKIK1wFoIlP4mdhP1QmN6r/OgNq2WNRjD3ePl/ig8rTy2YBm+Y8eO
 NXSethJ9an/6K2XFS36gLcdtmDm/Cm+OTTZ+ALESgW2gOjh8hf+121NxhwOQtsGs3boP
 Or6Fw9KdBJvq5rokL8eTIQ6F71pHqHFmfZVayr5/UALDwq2toNAaVxNd9v4G9mr2xzyd
 SDB3rszEJ1tyoWH/ZPPofnbk8ehYNfgMR5Bwd4DuK/BboAxxBwV82ZgqkWF/wKiRxxPK
 Y8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623516; x=1707228316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+Z/itasEdVl+93wmdY3Hqkz2ZxgLcPT57V/RsMNa8o=;
 b=wZRcWNeOrUEefnAQl7Qi2qa9B1FFJOM3jYTf1GWnircmz7utGWWQONC/vj3FxC/Z3e
 Fbgb5acGwnxJtFTaPjRr28pcb63ALWW9549hRwsOCr92/BbGTRfJPF0L3vQTHK0Zwfvi
 ub2HIIgrn5SoJplSHIR6PzetjRcqRhxvO3OcA8DcAeZQwl3hzev4N1C8uSMNPg1WZgvY
 4BXdZP7eP5RduotzjI+YBGB7XdI1J0+4rmXhmR6nWNrZzHfUL/zDYMjIQDBKw4tvRV5Z
 HyLijJH0xKa6g1z5JoXyliQAsISXhFKA05jIJMA/KDFq3sGifIUtksbjmggpoQYSQfnJ
 WzEQ==
X-Gm-Message-State: AOJu0Yy6fCd/hfJDoj+6/VQCacvCbGSLyn2YfBb1I+BiDJc/q9kJ++2Y
 Osz8z/m7oG3nGw+gghvbvkLVj6fhzwf7WGNeYy9WDcXMmTW8XRVmiixIyewex9w=
X-Google-Smtp-Source: AGHT+IHMdrtA6dQHFHLEc3I6ksp7xoFUFsUINWNcyjdbduMqpr9yowUbnEP74uG5VTW0y1TZV565Tg==
X-Received: by 2002:a19:2d1c:0:b0:510:28a9:9b31 with SMTP id
 k28-20020a192d1c000000b0051028a99b31mr5229602lfj.59.1706623516074; 
 Tue, 30 Jan 2024 06:05:16 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:55 +0000
Subject: [PATCH v3 07/36] serial: msm: add debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-7-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=RaT7eBsp95EvNEXnKYsIOkzZtK/fF0MvZbISQ03N2mA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAJrmNzPbS7zeMjz/l458zTp3CsPev7oSX9gs52WG
 cnFaZ/fUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYSu5SRYW3yNbtdCctaPjM2
 +5aqx0vl7xc98n/zydP1GjITL0bNFGFkWHHXv/Zfy91XacqOgapMu5XW8r/68colNaRqxZdfJ8W
 aJwIA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce support for early debugging. This relies on the previous stage
bootloader to initialise the UART clocks, when running with U-Boot as
the primary bootloader this feature doesn't work. It will require a way
to configure the clocks before the driver model is available.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/Kconfig      |  8 ++++++++
 drivers/serial/serial_msm.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 26460c4e0cab..fbd351a47859 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -319,6 +319,14 @@ config DEBUG_UART_S5P
 	  will need to provide parameters to make this work. The driver will
 	  be available until the real driver-model serial is running.
 
+config DEBUG_UART_MSM
+	bool "Qualcomm QUP UART debug"
+	depends on ARCH_SNAPDRAGON
+	help
+	  Select this to enable a debug UART using the serial_msm driver. You
+	  will need to provide parameters to make this work. The driver will
+	  be available until the real driver-model serial is running.
+
 config DEBUG_UART_MSM_GENI
 	bool "Qualcomm snapdragon"
 	depends on ARCH_SNAPDRAGON
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index a22623c316ed..19a5a3a788f7 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -253,3 +253,35 @@ U_BOOT_DRIVER(serial_msm) = {
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
 };
+
+#ifdef CONFIG_DEBUG_UART_MSM
+
+static struct msm_serial_data init_serial_data = {
+	.base = CONFIG_VAL(DEBUG_UART_BASE),
+	.clk_bit_rate = UART_DM_CLK_RX_TX_BIT_RATE,
+};
+
+#include <debug_uart.h>
+
+static inline void _debug_uart_init(void)
+{
+	uart_dm_init(&init_serial_data);
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	struct msm_serial_data *priv = &init_serial_data;
+
+	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
+	       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
+		;
+
+	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
+
+	writel(1, priv->base + UARTDM_NCF_TX);
+	writel(ch, priv->base + UARTDM_TF);
+}
+
+DEBUG_UART_FUNCS
+
+#endif

-- 
2.43.0

