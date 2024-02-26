Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520DFC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D6887F62;
	Mon, 26 Feb 2024 18:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jlfZkiQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E9387F23; Mon, 26 Feb 2024 18:26:34 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4053187F42
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso1781708f8f.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968389; x=1709573189; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/upDeB2lHfVp43bmnJiD8NyAJ4g/kBSf+1n7Si5I7eo=;
 b=jlfZkiQwSd1lpMNUJM6RSaJrv3DfKpNXa+rKwpV7+NtgVwcwT5C8khjOhWFjBpSgxW
 SkUyiyCOsZZJ2Izq6xqFe7EYK0UGn35Dc3OVBK27S14zBPZ6sBXXkE5WfpXvq6cUAGYG
 cPXB+1tInjxLn1wZAUc5hnXQ7UYBPitBnFBCHKoVq6CT9dX6vrUH+RlUfYvI2AailUUr
 TrMT8+7zl+nMlCFtBkYxGh18g2ScFjx6dZkz6KGfHUNF6X6BbYbj5ujjbOy7Ul3aJ4fX
 KJv2DTgHz8OOH0k7A/H9i1Yte0ZJdyyib561ZVLuQ3AXJsCHDIgRa81Fcavgvt6eJacZ
 bOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968389; x=1709573189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upDeB2lHfVp43bmnJiD8NyAJ4g/kBSf+1n7Si5I7eo=;
 b=CeWXY+axbTXkAS80VVk3l6NjzoiL+36oXmbE8krkb0R0aAAeeLmqmasyCT/6/Mf7Vs
 5WzVt9Xhz1vSYa2hqYxvSbWe19IGhzYbXjhA9WR6Yq6j17UIgFr0xY3T/xfYBtSf7cWE
 FdL7pkw9X5yZh/RNekkIl8+c6pa7x+8A6C0ul1m2NEv6b95ilZRArbuhqJxub4/mGXRM
 FXLgBJOb+1z+nkp+ctn6m7QgXWHT27CiZ20dKJ9KFw8DG62NduQFwluy+Z474WWowjJX
 gPb6N222kfkNh5f8d++x5hZsj+6ccsdtdLuHQLnc/kPEFSxJwiZBzVjkFY7ZGLwmCQ0q
 BqmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgpcY6CnodisCmE2jj0KjhSRK4Wuz9aM8hsHTMZIIp0AHbp5Is1K1JCckKQyfLgwPEup8COR+Pi7YgEyilG4tLy0bzSQ==
X-Gm-Message-State: AOJu0YwPS/gwWFxa7gGwoGynSWd08/oGvNCT2f27U0NRYOVohI8wDlIo
 yvdg7J+K4vNjBS6ZRWhjsh4eIZw2x1DDVZH+LB7aQxXoXX9Un5tv6aJZ3E9u+OY=
X-Google-Smtp-Source: AGHT+IHx9hskVzhsFRUf+NUeRMNRFUG76n/sOaOoUJU5qrS12OWgiScltQnABE4T4Ip8BeXvGVnLrQ==
X-Received: by 2002:a5d:588b:0:b0:33d:d96b:2614 with SMTP id
 n11-20020a5d588b000000b0033dd96b2614mr2550414wrf.54.1708968388791; 
 Mon, 26 Feb 2024 09:26:28 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:11 +0000
Subject: [PATCH v5 07/39] serial: msm: add debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-7-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=DTL9xs/a1a+3CQMGSxdYloLxj2TEW0WrylD20y7MFKA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3cGff9hojFTcvXb7cwH9k9eGOiSYPl1j9o3WSWts
 5WdV8WvdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJOO1hZJhXbVe0eOtJ1lO7
 mX2bSmYm1z45pi9RwX5MfOaD3l3WAvWMDNPeXjnze/fN3F0BT3MfSP9pDQ2bfVKnrXi5566TvJ/
 2MzYDAA==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/Kconfig      |  8 ++++++++
 drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 26460c4e0cab..fbd351a47859 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -318,8 +318,16 @@ config DEBUG_UART_S5P
 	  Select this to enable a debug UART using the serial_s5p driver. You
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
 	help
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index f4d96313b931..44b93bd7ff21 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -251,4 +251,41 @@ U_BOOT_DRIVER(serial_msm) = {
 	.priv_auto	= sizeof(struct msm_serial_data),
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

