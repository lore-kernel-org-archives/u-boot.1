Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC15EC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E58B87636;
	Tue, 21 Nov 2023 18:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vqaKfi+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B3287655; Tue, 21 Nov 2023 18:09:47 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5190F875FD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c464daso26775935e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586577; x=1701191377; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DL9E6BhHWqdN3Ci5Tly4OxfsM6GCl83Iyqtdn8GR8dA=;
 b=vqaKfi+cEdnit2BzlymgM2hN89E2cKMoI1THDfMTlMpvlIuvjgBJZCAquQNIKjbh7Y
 ZiVtToavQnByxhmbL9khZ1WBb+iXHFG3xeu3q6nv4y9BiM52DLTp6YDkaefnkXKOG/Ke
 GZWeRQ6WptGD6lIbaLWOhql08G+uugDnm079zytuL3ufVRm6aM/8ekOLbo/EbYpnv5UP
 qzwPYp0/tO5bhWONjrRkQAwxAenfjAwjOsoLO8gZtXQnXcbr3e2YLfjfbkKrSaCP3njT
 /VaFnlidl/Ba45ZEh8HG+m1DWxvzd5DMRKrL50ZZ/q86q91jXeH4HJ1qGrI9Vi9GSRt6
 V7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586577; x=1701191377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DL9E6BhHWqdN3Ci5Tly4OxfsM6GCl83Iyqtdn8GR8dA=;
 b=q5jnrAc29pOhAO9Yg1yfOiLHhgdqL8Zr/R5moFyjTFLqScUOlWiq4YF6t0sH19O+Yf
 63Leu9UUTi/ePc6o1ZBzGBJqcZZ2oaI0sv3M7SLe8e+P3D4FBp/dSNgARj12f0cgjkbn
 CPS5omp5r99xghOPp0retyYBuGyJv0O8G3fw4F2rlgZOPtaP2ZWavbyGHxdfzOLKk3bW
 cSgZ3hX85bnHYmWYqP8rO1ZSpd8cEVCGbmPngoYf3l/WMzrXIJ29yUQPiLUMvMjqluCr
 vQTJ90Phri37awRwXwntM+fN2mkmnlfZ/YOZFeaiDBPZ1AZhmrdCYdC6/pdLE5KhWYUT
 qM0A==
X-Gm-Message-State: AOJu0YwG1daqHEevhvIEgGH2SZOsll5wTlsXAAeIH9XGLP9P8Q2Vqver
 DyhgBAlv1dQyXIIEysJhnkowBw==
X-Google-Smtp-Source: AGHT+IEngqS4ixIljq4Wvwx2m9PUbiaj6ua5xfWhB0Mhg5ywjWWRQGqKf30eaBh64a1BQj+kip0l2Q==
X-Received: by 2002:a05:600c:4f49:b0:40b:2a15:9b30 with SMTP id
 m9-20020a05600c4f4900b0040b2a159b30mr1754263wmq.1.1700586576755; 
 Tue, 21 Nov 2023 09:09:36 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:36 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:31 +0000
Subject: [PATCH 08/21] serial: msm: fix clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-8-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ysTP6ngjGaKt+0hwsD1x+h29oTuDc0z7mVCcxs//FPw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ27JIqnax4J9ux7sKJCd6PxxCgNDTwWrbLXAyW87r
 15ak2XQUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSV8rwzyZF/0bY88dcS3bL
 tk/e2aiSeFzVev6luOypO6ZMTXf/FsPwV9I+LMktmU9334Hu33cPf3Q6I6q38eJ52+83q3PUe1b
 +LAQA
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

Use the modern helpers to fetch the clock and use the correct property
("clocks" instead of "clock")

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts |  3 ++-
 arch/arm/dts/dragonboard820c.dts |  3 ++-
 drivers/serial/serial_msm.c      | 24 +++++-------------------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 02c824d0226c..c395e6cc0427 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -84,7 +84,8 @@
 		serial@78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4";
 			reg = <0x78b0000 0x200>;
-			clock = <&clkc 4>;
+			clocks = <&clkc 4>;
+			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp1_uart>;
 		};
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 146a0af8aafe..86b7f83d36d6 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -78,7 +78,8 @@
 		blsp2_uart2: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x75b0000 0x1000>;
-			clock = <&gcc 4>;
+			clocks = <&gcc 4>;
+			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp8_uart>;
 		};
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 6a4d6f1d96fd..d58f9d85d38c 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -160,29 +160,14 @@ static int msm_uart_clk_init(struct udevice *dev)
 {
 	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
 					"clock-frequency", 115200);
-	uint clkd[2]; /* clk_id and clk_no */
-	int clk_offset;
-	struct udevice *clk_dev;
 	struct clk clk;
 	int ret;
 
-	ret = fdtdec_get_int_array(gd->fdt_blob, dev_of_offset(dev), "clock",
-				   clkd, 2);
-	if (ret)
-		return ret;
-
-	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
-	if (clk_offset < 0)
-		return clk_offset;
-
-	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
-	if (ret)
-		return ret;
-
-	clk.id = clkd[1];
-	ret = clk_request(clk_dev, &clk);
-	if (ret < 0)
+	ret = clk_get_by_name(dev, "core", &clk);
+	if (ret < 0) {
+		pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
 		return ret;
+	}
 
 	ret = clk_set_rate(&clk, clk_rate);
 	clk_free(&clk);
@@ -252,6 +237,7 @@ U_BOOT_DRIVER(serial_msm) = {
 	.priv_auto	= sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM

-- 
2.42.1

