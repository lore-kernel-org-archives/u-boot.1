Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48753C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA8D87F94;
	Thu, 15 Feb 2024 21:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vU6hjPK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1FC87F15; Thu, 15 Feb 2024 21:54:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEB587F26
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso398800f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030381; x=1708635181; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bAZGfbWoqNKVvi6q8WscUjnpPJa5jw/DgSL1YaMeUHk=;
 b=vU6hjPK++xW3tydFCq/pYsK9k/joIdalI8PPdBz2O846jy4EhwOO5t9TpDYAeJWslP
 W4wWtqpaucA5QwgPIZQxpCRCfqzp8f0Zg3LZLEDAT6/K58HIY2ze83DcCeSYNgw2twg7
 zueW55iYZKmZfBQFz12BR0wKGlXDXrR6WS0iFstNucZdl4BQ8bxsbDKEYFgwczNpaXS8
 /1sRVOet8szf6a64rvESzMvjeOO8q+5ACOno9YlejBS+naoUCJvke+MpH5PqIeYnt11w
 UzbYcnCCoRSM0z2Nl6qWpM1x0nQm4hmxX4lcFR+c5vPg4m8bMAGKUHRUsRPHVNTnCLSo
 5/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030381; x=1708635181;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAZGfbWoqNKVvi6q8WscUjnpPJa5jw/DgSL1YaMeUHk=;
 b=nUiXkgLWcjkf1cwI6amsf2DCC0Peh3L6l4SLiQ2mgWfBW++WXvgDnfnSViCsDgrwj4
 p1vwrEN8nOhvP7omlziA/m6kblDPJB1fw1owm67KFO4LxkC/Im9PWZNVM6HWB7gRIYA4
 AAXZVqXXW7fddOzqH0TsYqxXXPunDiAHY4m9JO3D/bsZq0tkKNDEfGXVyt/+ekzb+5md
 Dc/os3rHJplDrUkRnHxYXiVjyVRVPzTSouo4+iSUH1X39JI78XG0Zjs5ndAoc2aQJO4y
 txEQUuYTmwsYQx5bUXs3TvIaBEO+uwYViG8VDbprnyZaV1nwYEckn0JByaLP5jIJBxZh
 cb8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3cNmgDM7rYfjOxEYes2UeYTEmg4/C7AjR7OpjY+wNQnLqbX+xMl8zTwjakKsyhqpKb9LQMV8dT1/G3pD1ZtgsSut1Fw==
X-Gm-Message-State: AOJu0YzoVVoFKrnIcOP2ZLlC6Wp0+00QIJDT4e4wVIHfGRJYYWfCn/+I
 o7s7z5bNj04Vpc9XT0ye5EgcvD/7ypRaFpvqT/g+NHLlTJQ1S/S4M56w6R6D6EF04vNs8hMTf/Z
 U
X-Google-Smtp-Source: AGHT+IEQzX95JSQrNLAVoWo5YxSPVOi2rEKO8i6R14E+25oGbe6MHQ+QsnnVgkHsiJFkY46HJ3kdsw==
X-Received: by 2002:a5d:65c3:0:b0:33d:136a:8821 with SMTP id
 e3-20020a5d65c3000000b0033d136a8821mr1063727wrw.25.1708030381597; 
 Thu, 15 Feb 2024 12:53:01 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:53:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:53 +0000
Subject: [PATCH v4 35/39] dts: dragonboard820c: use correct bindings for clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-35-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+1ArGX4PaZfWn9L1iVMQQyj25pchQ2ZkjIpI0KIGD+k=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzle3KcwuFb131fHqhb1WzaMSrbKX3VxqO7pOa8/PV+
 10OnjPvdZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJvFBg+F/8rq34cbucxOV7
 mtfstk1ysxRXWvykrzXl7mOTQrYJEicZ/imt6xHnymD7GTcj3++bjMQsv3VGU1ZdTWTcpxrX/ET
 c/x4A
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

Don't use hardcoded clock IDs, use the IDs from the dt-bindings to be
compatible with upstream.

Taken from kernel tag v6.7

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard820c.dts | 5 +++--
 drivers/clk/qcom/clock-apq8096.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 86b7f83d36d6..282c37e28f42 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "skeleton64.dtsi"
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
@@ -78,7 +79,7 @@
 		blsp2_uart2: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x75b0000 0x1000>;
-			clocks = <&gcc 4>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>;
 			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp8_uart>;
@@ -89,7 +90,7 @@
 			reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
 			index = <0x0>;
 			bus-width = <4>;
-			clock = <&gcc 0>;
+			clock = <&gcc GCC_SDCC1_APPS_CLK>;
 			clock-frequency = <200000000>;
 		 };
 
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 1e6fdb5cd42d..a4731613c5e0 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
 
 #include "clock-qcom.h"
 
@@ -107,10 +108,10 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
-	case 0: /* SDC1 */
+	case GCC_SDCC1_APPS_CLK: /* SDC1 */
 		return clk_init_sdc(priv, rate);
 		break;
-	case 4: /*UART2*/
+	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
 		return clk_init_uart(priv);
 	default:
 		return 0;

-- 
2.43.1

