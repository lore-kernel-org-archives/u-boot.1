Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE9BC54E4A
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1484387FB5;
	Mon, 26 Feb 2024 18:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sM36bwPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC19B88035; Mon, 26 Feb 2024 18:27:18 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2223587FA0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso190851f8f.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968416; x=1709573216; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N8ebA8zI0/m3pqLWFxyvOjpqwVIa0Co3e2G+k+l0Pp0=;
 b=sM36bwPFLN6Bm1nlvoe4zFf0tCJMXsEwgmLLT0CYuZCDUx2JttavidNDcjcmrG7KfQ
 SDTK1+usyHIUQ+tNozpXjm9Y1tZtdUSoZRVhtx2qgejSODj7+UiR0eO6SwKK2zYjV36w
 j95weSxRa8CXglV3G2Lo8UrdlSJ1SBhrCqEQIFUf44En5u5XNBfv+WKGcK5KqnDuGMj4
 jcYt/53P5+nZoCCmK8c2QKqo541qoZm9dK3/zsISSDzd/JMRCXEvwWmGBr1gzIZcSkUO
 G8qIn68Wdg+zP5rg1IutNToR+XYbe6l6q5ebvqEvtP11muxCiT1VLpNH12SOM/D847Ir
 ME7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968416; x=1709573216;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8ebA8zI0/m3pqLWFxyvOjpqwVIa0Co3e2G+k+l0Pp0=;
 b=bafaCBlPuUXGELIYXOtlFgred94HuZeEMYR83LnaTaekXXh4LcynWjqMEOoCiLBNoW
 hG04bBz13j3mZlLkedU7qrmXHatqXisuRMb+KDj84xMGSrC9VyOJIH72+2cXFvjZDpfA
 hB4XkTB7FqcIKsa8uaJTunVFpgJ//QHmohcAj7rGjwBJOPgRNPT4o1s3yc2vTiHo/aFS
 WqoT091SR4ny75hLdgIO+HaWk5PtvH58gdCNCt69gkaOip16IAGLdes+YmZEbyHrM5hx
 qWhKyicej4eBe3QFG5aB7sQljWJ70qOEYQuBuFY+EC3qGiaDdjmf02fHeQwsFL0myjWN
 /KFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUheRQqVetS2pUNLPXphOY0Rs1MZJJa6pzCe8OS1VZkRql2H3Ogh0/5q3o/YBWZZCcKBUZ0A+NBgiuVkbD9uxW6+6Jizw==
X-Gm-Message-State: AOJu0YzVSRz4pYsWyrYx8pOEwyBFZLhOMBqz8EqfSpvv5YorXRD357fz
 xY+RSMn1BPC3EJLS2b7iRNc1tdOW5uxAMT4l8BdfQfEnXGq0CUtW/Qkr9aAobqo=
X-Google-Smtp-Source: AGHT+IEGoc4a6gzw3HTmPub1Qi3E9yx4Pvweqy3tilNT2+lePkQDeGn9WJGXTvW8S9w8OwLOgNu1OQ==
X-Received: by 2002:a5d:44c6:0:b0:33b:62c0:6181 with SMTP id
 z6-20020a5d44c6000000b0033b62c06181mr4882207wrr.42.1708968416721; 
 Mon, 26 Feb 2024 09:26:56 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:56 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:39 +0000
Subject: [PATCH v5 35/39] dts: dragonboard820c: use correct bindings for clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-35-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Xs+XkXLP/c9jecUy+kteFP1vOQtaDmx5AvpzRoRBFzk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J/ds/GD87l5n57v4FUa64gujaouWG3i9e7Ulp/my0
 H+H9Z2TOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEntkxMmwRO1Fr/9gyjrtv
 x4Mpij+n7tzhdvf0jVzxOptm0zuTppsw/E/eddHh9A+7p18U5q3qUnlhKhK3hrVkuUG0/rmoDTv
 llE4DAA==
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard820c.dts | 5 +++--
 drivers/clk/qcom/clock-apq8096.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 86b7f83d36d6..282c37e28f42 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -7,8 +7,9 @@
 
 /dts-v1/;
 
 #include "skeleton64.dtsi"
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
 	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
@@ -77,9 +78,9 @@
 
 		blsp2_uart2: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x75b0000 0x1000>;
-			clocks = <&gcc 4>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>;
 			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp8_uart>;
 		};
@@ -88,9 +89,9 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
 			index = <0x0>;
 			bus-width = <4>;
-			clock = <&gcc 0>;
+			clock = <&gcc GCC_SDCC1_APPS_CLK>;
 			clock-frequency = <200000000>;
 		 };
 
 		spmi_bus: spmi@400f000 {
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 1e6fdb5cd42d..a4731613c5e0 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -12,8 +12,9 @@
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
 
 #include "clock-qcom.h"
 
 /* Clocks: (from CLK_CTL_BASE)  */
@@ -106,12 +107,12 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 {
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
 	}

-- 
2.43.1

