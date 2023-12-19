Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF26C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F410C878D6;
	Tue, 19 Dec 2023 17:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F6GirDt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C5D876F7; Tue, 19 Dec 2023 17:05:19 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BAC87878
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so54020425e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001890; x=1703606690; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CUBcDs0CjJ/QzKirEaKeQiT8xAwh9eBvimoefjP4ltk=;
 b=F6GirDt0SoYB62OCENBggi6csYjaD4xQfgpVITtwSo7Q+AbQjFn2OtRFCYHkv8tt+E
 G7/9hr9TlEWTBanDMTaEDljVds8iIB6ufZEp0FVMe3W1g7yIUi1rNJuC8rqbPn5kttse
 mqFw82rbywyTlO05p8IQJpB1UIHJLX/KRV+gKmMzJAKSEpc8Rm+HFua0JCTHqwRpW6hd
 Qn5je3IbRT7mTpmAGoDdjwWVJwdPkyh6pe/5ndXlnOMptPboYhj5cul7RXQTm3aSwE4u
 +3OvhirTTIK2EL1tqXK1GglpTJJI3h6G4XOK9Cr/DKcjzu2Hi5IqWakGgErSIlUZ4KOA
 nHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001890; x=1703606690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUBcDs0CjJ/QzKirEaKeQiT8xAwh9eBvimoefjP4ltk=;
 b=bPa4r3Ex0+m3xo6x/JQNOBUtS5pzjwtO/Uws1wEuu97v/U+wPjDwgjtrTMAXW9lKmZ
 Rt4pfkWYBQxHPBlRJ0vOxvMGQ+cIDYPStKjNViZr9nmGwuKpIrJR67Mtw0Wx3rQxZUzN
 pp4sIaIHzqHOxjCc2qr6k3n80mLlzTxiVftVurSXsEJmUhBjAz2+ZYtPzrCPMAz7OYr4
 kqmnookvV8UAR1CApWkWzgRP10prDNrXBVjQmF8fKSvLYw23MGY9H5EM2/DvwLSPIgGa
 lpZR5ybRJ/eQEOesjgdYCJYLLo96Ss1lL6J+Uml5GSr9T/5zodP52tQ4QXvfreRUxn8X
 RMXg==
X-Gm-Message-State: AOJu0Yw3rJdGwm5rbugVpqDd9d6dZkgdIOPEN1i6fgVUkKZAk0a/qDn4
 A0qvDWyLSGYsvE7qyYCBfUH1+g==
X-Google-Smtp-Source: AGHT+IF/7H0t75ZvEavaSyyY+OiBkvlwaHHcx8Twm08ONJjvGEOmRyE0n+j9TgCgPLfvs/2mvfYuhw==
X-Received: by 2002:a05:600c:4f91:b0:40c:47c0:cdd7 with SMTP id
 n17-20020a05600c4f9100b0040c47c0cdd7mr4137626wmq.16.1703001890591; 
 Tue, 19 Dec 2023 08:04:50 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:28 +0000
Subject: [PATCH v2 27/32] dts: dragonboard820c: use correct bindings for clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-27-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JAmaHrRcqr4XUcuqtVBcSAFI9CoP2CYlAS9vcDgswSw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SyWEQrX15e+SFh462+p8uYZGndONLK/7Uvrjvgk8
 JbB5U1iRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI7weMDJ1rvfb3L6vhPVpd
 t643c/YL9TNGlWLN6z9MyW1Z/l807DbDX9nwd+s2nr+cUp/Rb8Z1V03Ddco9S6G+gKxvZf+6FPl
 ntgMA
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
2.42.1

