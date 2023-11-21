Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E3C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCAA87632;
	Tue, 21 Nov 2023 18:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W9+cUf4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F53E8761F; Tue, 21 Nov 2023 18:09:43 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D2287624
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so3668624e87.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586576; x=1701191376; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u9aeloiXHTjsBzM14O5Gpf5BpwOpZ7BuQ1SD9ZKNIsw=;
 b=W9+cUf4BctsJqMlRPGyUL4JuNkzFobGUX04tpTxN4hx9XfMkeEMzifaopN3vDCEzF7
 LdQfhB3qoAKnh9udgWW/irCM+f6YWzqXnvnpo2GZ3mQZ5+iw/xPuZDOn9dDn7vgouJKH
 xIaqC/UJ4eXkezBnQo8JkGmQeEYdOurTEMub/WcC6BPXGjTdMfQEs4Nkp11shkSdbKF/
 LAD5LtgG5QAjtouzZkbTOAL1ycCh/uPhRcMUgLeSeyYrujOIoPY6DNITGTWJla3fbM2Z
 XFAQFODwEmNR78pSBDPbuzyB4cyg7VUJnMqt5eDafnrBojudv/OkmfA5Gj/lvLoXQmk+
 03lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586576; x=1701191376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9aeloiXHTjsBzM14O5Gpf5BpwOpZ7BuQ1SD9ZKNIsw=;
 b=ffmqTQKa5kdL7836xcUggmimT0VZ5UVWoXj3OPLaEmZI/8QognJARzsfs3lFfViiZz
 f8GMA4MgU9Zs4poPnysYykGa+shZoiUKrLEAAIGYCYsf3zr2QLmGFFUEu6u6U6UDoiR1
 BDAZOZ7SwytdMRuiJEL/36toWHvW6Hni1sc+ajL+n+J2t2fZZIxNy5Jm36qWibedcBn/
 TMPs37E0c0WGU5c9ULuUoBwm0B9+CiCdRZor5WN4k3pWv90zP17PIZOP+JRDvWg1Qbms
 bIvCwVnAy21SMPFMYdAh6NgkWKd0i6m7T2qohoZ2gaf8rQyrR4uNXLgIXvu00ix5Fzz+
 G7sw==
X-Gm-Message-State: AOJu0YxDm9hjU8s3Rq9jyoXCDEXmNL+r2qPEMp9YkK4y1M1bhkdAPX2l
 fNY8YS1y4GFO4H8TI6IMXAKF3Q==
X-Google-Smtp-Source: AGHT+IGc/5kd+bB+IsRzt9tx5PRgEL0p/eoqalcWIGs3W0hcRLRtDoLL9je/k8yUrJlckH0hCcmXgA==
X-Received: by 2002:a05:6512:312a:b0:500:99a9:bc40 with SMTP id
 p10-20020a056512312a00b0050099a9bc40mr7938917lfd.69.1700586575879; 
 Tue, 21 Nov 2023 09:09:35 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:30 +0000
Subject: [PATCH 07/21] serial: msm: add debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-7-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iZMX3WTQwWkftwxEO909KjKpMPyY+4JCE+jpVMlsoRs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ26T3L9aGeZvTrlqet5Bu4p/SWVPW2Bl9iO9/FtCo
 jJLb7V0lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlskGX4H/z9qnKx90RLKa2J
 ++R3b1xjeaxon0b69nqz1Xt6865YJzD8D9jRy/p5qcPNJK2zLI/jnAOZZEsipC5lMdoHpjbsOa8
 pAQA=
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

Introduce support for early debugging.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/Kconfig      |  8 ++++++++
 drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 81fdac047824..20713812c839 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -304,6 +304,14 @@ config DEBUG_UART_S5P
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
index a22623c316ed..6a4d6f1d96fd 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -253,3 +253,40 @@ U_BOOT_DRIVER(serial_msm) = {
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
+/* Serial dumb device, to reuse driver code */
+static struct udevice init_dev = {
+	.priv_ = &init_serial_data,
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
2.42.1

