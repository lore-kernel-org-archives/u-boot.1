Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97615C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A7587F10;
	Thu, 15 Feb 2024 21:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bPb4A00x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2A687EEE; Thu, 15 Feb 2024 21:52:47 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E166087E77
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so571718f8f.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030352; x=1708635152; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aGbqXIl9VZSZrwBlBpAv9oCc/IXQ4KQr7eWYNfHcCMg=;
 b=bPb4A00xITfP5UQ3B+rUl5hh8ZbEAosFtuv+7fqoXXAxSMO9J+ySpz0fvXZoRb0XSq
 cFa1hxz6NaCaHjcN7gl6f1+JegPDQpj+qfmpy2IxZfnJKDsaJeKYVE4oji9oYUJLq/Ob
 72TuYqXYttCUKKYUIyjhJVqWJh8mfKoZ0+X0Nx+yKrGGflXCJmKnwcLMn7JMV/lBvRPx
 ZKxpuLw0RhZrZgC6wWLUcK997ttnZKT50Wm0Cii7KjJhXeaCbXIz+IXsPUxztRXtsCRc
 vm0mR2iEu57TzoV+wRk7Pc6/t2wtZ1w+6WrVppruF9ExNKsXR94xOSqAAvxtJgMaU0gu
 HZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030352; x=1708635152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGbqXIl9VZSZrwBlBpAv9oCc/IXQ4KQr7eWYNfHcCMg=;
 b=TmYLyK+xyYvzC5N2swuwIenac6FS+PaslS9OUuaN6215VTR24kZT1JvOBBa3DCW1OH
 tJLER1OGpRlwJZMC5v3DCB+KPUmqHpCuP0ZeuEzq23A6r45GQ4VS3oGlwlb3191P+RW4
 HpqtzYfEqVpw8fjn+Al1Yp1/yuRwmwnB8bG/bSqKLSpy0fVvHYaUMZdnOfGbSDt65om+
 xQUT8AFBNda1MvJtombsNEBLCzAc2MvlkdrHsKALVuSrbR2IHAI/GXpg2yCMFTjglvh7
 9upba87YhpAXkWLPz8A5t6BYrU87x/6wlvcutPIAs0OTCFmB61ceDmqtV5MrwATYiRdw
 ycYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtP1zoAkku2bDuf9UJG+LMHaVWELH2RgGfBwuiHs2vWm6I5GmPYxCUlqCTkUGeh8TyoORWpHlcZILp2R/+CsmrrMfHsg==
X-Gm-Message-State: AOJu0YwLrmgO8KNZFjuSjOGyBvovVhBjKrzooQXRyDahYt7JXllW+rzD
 i/pBIDIeNJznZxPLj/JKfA5re/Kuvu9ICEJ3gu22hkV4P4YxUchSUIHOAqhodTNakOT5kCdNF51
 N
X-Google-Smtp-Source: AGHT+IE504X0hW57MdvzdQnF+VccplvYYB3rdWMa39VucbtLy7QaWWacWs3mtfk92ws6JyZOGXlTJw==
X-Received: by 2002:a5d:54c4:0:b0:33c:e309:4710 with SMTP id
 x4-20020a5d54c4000000b0033ce3094710mr1758961wrv.29.1708030352139; 
 Thu, 15 Feb 2024 12:52:32 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:25 +0000
Subject: [PATCH v4 07/39] serial: msm: add debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=28+/+RqbPXrPC+wi8o9pedZ1JKAX///zAEs1REjS7WI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS0brqTpT+FziZXyvtgXz63J6nmj707vWc4lrQm9Z
 rtTZt3rKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABMJ28rwz0Ku5vmkKzzybQI6
 RTvcQjZvqzrg67gga8Wqwpn6/k+4GBgZNjNfrNt+8Pfe+W1+aUcnhCYZFiuf3hZ1d4ZIxtUkn0t
 FSQA=
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
 drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

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
index f4d96313b931..44b93bd7ff21 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -252,3 +252,40 @@ U_BOOT_DRIVER(serial_msm) = {
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
 };
+
+#ifdef CONFIG_DEBUG_UART_MSM
+
+static struct msm_serial_data init_serial_data = {
+	.base = CONFIG_VAL(DEBUG_UART_BASE),
+	.clk_rate = 7372800,
+};
+
+#include <debug_uart.h>
+
+/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
+//int apq8016_clk_init_uart(phys_addr_t gcc_base);
+
+static inline void _debug_uart_init(void)
+{
+	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
+	//apq8016_clk_init_uart(0x1800000);
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
2.43.1

