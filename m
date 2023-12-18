Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5D1C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AB287DD7;
	Mon, 18 Dec 2023 08:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uWs1FDd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A347287DDB; Mon, 18 Dec 2023 08:25:02 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3A587DC7
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28b436f6cb9so1920484a91.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884297; x=1703489097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i3Z+uj8sOIKALQYqBqrCrfHFp8GRgc4559iPiy+ZKI=;
 b=uWs1FDd4hcASNPhhtiVSpvdVKgMSylEHvIpoFXdkWeEQ95J5lbRY9uFZDEYZi4yj69
 Gy7atgYpuhkcJAQ0LH7jMl6ZG5xb1OLGKQL5lj8lrnLNQuaj7Y/srNKr1tEKwcWeWZYE
 7111mWIgsbZnC+aGOpFQhp/+j1lCAwEeCFSFcWQ0RnowQvvo60mFUmLlFuOqecEllPvy
 WO0b9r2u5bJvgpW5O0CSGyF2fWqjVX/CAZmyXWxHOExSOb+K5nKuiL92wS26seRLIlYt
 2VvPusDpGNJD0ALCUvGjQKwU0dr3ijERNB2gSFqj5uesy5ajYm0tuSE2AhXev3+/YJXZ
 6knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884297; x=1703489097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7i3Z+uj8sOIKALQYqBqrCrfHFp8GRgc4559iPiy+ZKI=;
 b=AhXhR0gucWMWYnph8qf0jiX2vIEMP1sNfqgb1cC1gF5rDZ6BXTARTWecUOTEflbd2n
 7bg+YGLQruQjNjAs2NLiaCyTf0MSLdKvSSLGtHLrOloKG8CZ1BSDBUv2k30yODv8aIz/
 Y9k4SCaP7uFvU45diLMh5+E531SigSUt4wt0g2aWBCq1kz5vQxYlfXcPwu/tNBF8OJXz
 od2LmkyZ6foQ9l1uXHodsKqxbvmtou49sAdFXzcndHyKkZzIB/0hX/44Od859fb/TFWy
 CBH30JamMP2dNvDLVQKGfRglVU8WYydQtuHyy+hfIcId3xubrfr4cGKByYhS0NW/i1gw
 Vedw==
X-Gm-Message-State: AOJu0YzDATLpwjZwquRqwkpBnVfL6pS7jhdpahV9ug39NuxeUpkw9Nck
 pHjtL2+6hkYZbkWa/Q3WhJtMa3g9NCtbs21M4A9ktw==
X-Google-Smtp-Source: AGHT+IEJtzVYrM0ifcE3akZykrIWxes2tBy6srM7bopYuvAnF2oidz+XssZeBEOSO4d/fIN90KHPWg==
X-Received: by 2002:a17:90a:c691:b0:28b:612c:e67a with SMTP id
 n17-20020a17090ac69100b0028b612ce67amr839802pjt.28.1702884296950; 
 Sun, 17 Dec 2023 23:24:56 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:24:56 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 2/7] serial_msm: Add support for RS232 GPIOs
Date: Mon, 18 Dec 2023 12:54:23 +0530
Message-Id: <20231218072428.1802969-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/serial/serial_msm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index a22623c316e..43e58595dc2 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -16,6 +16,7 @@
 #include <serial.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
@@ -210,6 +211,7 @@ static int msm_serial_probe(struct udevice *dev)
 {
 	int ret;
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	struct gpio_desc rs232_0, rs232_1;
 
 	/* No need to reinitialize the UART after relocation */
 	if (gd->flags & GD_FLG_RELOC)
@@ -219,6 +221,11 @@ static int msm_serial_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (!gpio_request_by_name(dev, "gpios", 0, &rs232_0, GPIOD_IS_OUT))
+		dm_gpio_set_value(&rs232_0, 1);
+	if (!gpio_request_by_name(dev, "gpios", 1, &rs232_1, GPIOD_IS_OUT))
+		dm_gpio_set_value(&rs232_1, 0);
+
 	pinctrl_select_state(dev, "uart");
 	uart_dm_init(priv);
 
-- 
2.34.1

