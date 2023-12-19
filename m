Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C474C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2050187834;
	Tue, 19 Dec 2023 17:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8RiN+md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A89B877CD; Tue, 19 Dec 2023 17:04:35 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7F3876B4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so2603046f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001868; x=1703606668; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DnsakWEJLcIxjNw0M1gp+v7NCwHhgVMsyuPucdhq7S0=;
 b=f8RiN+mdL4CZT44uvtEFasFZgyMlSl7uACLfu5NoTPZnym7bKNBNcs000RM7oHWKs2
 Z28QvOYSEQaoGr7O7UESeog7LMs0FFfuKl/PwGs6+N49S+IhVkJzTBi587x5nBY0Tx9i
 YES2lodauAVsZ5GbKjBzLMkE/Q7x8PiH0v5u6iCc8oR4kZ9T+u18zDvgw3leS8YR1MAr
 xExQ2+LFHQyfAhLTCGlDGNFEFFiL2sUDOJMDAAPHnQnV4gKpR6p7Op97bfJ8jn3xEHPY
 /7A6/21OftXUx6+2X9xT59DI20mMej7gQX+6Fj3xgtebdPnOYdPUH05PKU8MlC5MmUeU
 Od5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001868; x=1703606668;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnsakWEJLcIxjNw0M1gp+v7NCwHhgVMsyuPucdhq7S0=;
 b=OOCCBymFSRp/+hViilGVPb7PVzFF3wUJtoNmqcBc+K+3iypUHkQoQ6rh+2OKp0GQrF
 3d2159A0wBUcHlcxLdae2ALIgxovYzQcWw3XKivvyfk3Ddzho/hsh0/EY5l1/FXI+Ise
 HKmOhNl1HyAbSLuoudsOKJkNNZV2oaww0iOrYzTc7oSJoSlMRM+jR/Qr3Dn4lPM8BVZ4
 pgxjLumIPR0PK2e/GFAIFgfKw0TN0RGMi8ihIoSMewivYvx56L6aumYp7GT+1jsb2pZ8
 EViYPSv+rt7G/oaBInmRHXoNiO9Oh9tnE6h1verz9nCU4qIIFPcvSgO3z3rfLq/zH3jH
 zNfQ==
X-Gm-Message-State: AOJu0YyckVsuv04NExGnsx+IV8rq+PEdCY+xDO+An6Wyo9gFb4SKGySv
 ok5aE5yrymOfCxLTKMfA3VrYvA==
X-Google-Smtp-Source: AGHT+IF7zO1fJ4ODoN1ZsOY4Jd02aR18vogKUv4e/bb0GnLcOjsJUa1uMeF7ccsI9zzxsghokRGApw==
X-Received: by 2002:a1c:7717:0:b0:40b:5e4a:233d with SMTP id
 t23-20020a1c7717000000b0040b5e4a233dmr687294wmi.63.1703001868393; 
 Tue, 19 Dec 2023 08:04:28 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:27 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:07 +0000
Subject: [PATCH v2 06/32] serial: msm: add debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jH+8AF/fIJAGRi1jWugRZ+jpQNpEajJizlbvZdgxoXc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Uyc2k+ZM3dx3/wp+6v6srOO5/LHO3QWBbxdXW/P9
 E1w7kaJjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRanVGhgnzbTfetMnuCpgW
 f2GpbB2DbmrL31yt3mPKCz9LbnCMOsLwT4v9p0EW9yTRWbLPrj/gbZ97+8h/luPBxje7/60NuRf
 Hpw0A
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
 drivers/serial/serial_msm.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
2.42.1

