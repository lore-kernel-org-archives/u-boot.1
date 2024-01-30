Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80F2C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDDB87E48;
	Tue, 30 Jan 2024 15:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A75lygmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E05487DFC; Tue, 30 Jan 2024 15:06:02 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297B487E1D
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51031ae95a1so3787550e87.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623541; x=1707228341; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EoPrJBfcdVTmMgaiIE05PQxdTHe+wKIeBsph+OkEYcE=;
 b=A75lygmyNto5fk4yWc7ZZMjcCKgX131hyDHjU9e0Kz1AwKQh+Jx+hKHgfJ13jJkhI8
 R6Ro8/EjMna7PIzvCIpvGZzVf+JZkvlApwdhx5tJDv4VPuB/UzkU7dY/iNW4QT4eCLYN
 7BXJKk1BYOSuCYJiQ0GLXKCUFknCC/heaY91GRMTOUiG9pdHzM0phYRll1nYuZ4HrWuU
 OoFjtXvILdnGlI1C9raTn1FFkVVjqMGAps1z/MecdDzEQkkYLazUj/n0kKT2MkfOxan6
 UOBOG++aezOGYPrh+V09vVz2Ny6ugmjtpWo7mS//TLVm2NMNkP0NfIeTm04J+q0oQb+m
 dZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623541; x=1707228341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoPrJBfcdVTmMgaiIE05PQxdTHe+wKIeBsph+OkEYcE=;
 b=Q2hGOEF1iyNFnYv2afZoWymt0dGGFWTMycrIrjHx0wNQvrdFGYcvNDvzz5nzBomhR8
 UenSj1DNR+ZdBKs/aZqIT8mA53uJYGh9RLueLFS7H66wYdBl+ubuarSI1NNI5jm+YibA
 puKUf/7x7ap+XXI/RZcwqJWZ6oOYd7EidWn15O2Cnb9nGQz5zlGBcTMGM/BVVaIusTlV
 ToiNQaRMS5g1fufArHff7VJFDudHPJk8QrjhzFSZqiyExjexTrEBV9X7uHEzPGZLX+JN
 +FQU6BsyxRQl4Roc1G/apUdXitn2GGXX/zURMmfPP8SvQC3HbTCCTSAWy0BgVeGXpsSK
 BWYQ==
X-Gm-Message-State: AOJu0YyFhXy9hqQAbqgHE85wXQ6Qmv7eIYkvhbl25fGyzwXzxh1ilMLY
 ptirA9YpnegQqW3GVNyPYM3RYMeSXsnb6q8qMkh3uJNFWW1avRiBXuNMZHRpDYA=
X-Google-Smtp-Source: AGHT+IGpq8/Wi5zcq5j/YbFOvhq/33XS8xMt72WWE5YTwWGNhHH+r1w9CDuhj3QTBtKISKqL6RdE7Q==
X-Received: by 2002:a05:6512:348b:b0:50e:d1f:8221 with SMTP id
 v11-20020a056512348b00b0050e0d1f8221mr5907491lfr.10.1706623541606; 
 Tue, 30 Jan 2024 06:05:41 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:18 +0000
Subject: [PATCH v3 30/36] dts: dragonboard820c: use correct bindings for clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-30-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KHl8NwQjAEmv8odcmEIHsEOQPaSRTdu+Dug0m/whdbo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTELpe8Pu7n/JHvX+g+gVl+uNVyVe/y26FHf7Cu/vU
 y/WM8Yd7yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATeXKK4Z/BhiXciiJfJcOO
 3THwMlE/VObi61VnfPDTCq5/Vl6fp85i+F/XF/DC6nmf8vtjbI/Vfb15XQNnZlgWhdRdz16/9YR
 MYzMA
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
2.43.0

