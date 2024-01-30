Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9929C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3325487E20;
	Tue, 30 Jan 2024 15:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iPrT3FVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5056D87E02; Tue, 30 Jan 2024 15:05:23 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6B187E07
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so13401795e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623517; x=1707228317; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=realiZdHx1OrLetmCJ1K0dhXFJXY9ecpfyb7A8FbSIg=;
 b=iPrT3FVZCXVA1lBI1gOuiTh3w5yp/JJhneuy+FA7AhvlVcOPSxaxyVUPYOhbh+EJxP
 38M08rkRv6fmdJhWO8jVy6NiKjTqE8Bx1AjZsqEx0qwFQVh0ASena919CNnqAd/h2IeE
 FIgi87a+y8rNFfIjcl4YUALwBlizBQ7rDZ1f+REa9PgGJOKFSNReCfmgQKtA6Iyi0q4h
 MAktEpWP4qzoVf9Jf2wFg0PpkLAYRTyhahzyZpXUfLZfYym9f3zEBQLXrLw+0y6P+t6n
 4n9FSimP/czir0l2zlEuqtsPeHbaO/WvCFsrw/t0t35VzPUWN/LZDXh+Jyr2X05xp6FS
 nkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623517; x=1707228317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=realiZdHx1OrLetmCJ1K0dhXFJXY9ecpfyb7A8FbSIg=;
 b=O13b5B0KnHCOdToCiI3xDdPqsWhE2OHhgd04QGhg8dFajBOZq8naV84FlZNeob5CJy
 Ag+fxQjJNC39sgvLTAjk3BIdMyxpFrAOWFwXnAoaGewsdhV/rjhXdN1Y+JzdOdC979Pn
 +rCjrOBkoTLrgz+RYmh/HH5q5Mndub1uAmVBoV4iLTpQt3kCB6y9FQPFTDILr2nvQXQy
 LEkC2mmf+Zara7T/mY1bdZ/V6p8s6MuNgxkRHslIkC3I4szXUjwrK1Y/kJFa/TGO5jC1
 OdQiCTxro9piJbFZBJ7dhZ/vpjG30ssvpR2G/ECMm5mSo4tYvqGrQEHsjl2dRhDMc9k8
 4VsQ==
X-Gm-Message-State: AOJu0YxBdGYkD7GkH2tH9hot6imzo/qeK/qiHv054dv7bJD/c6Tl55A7
 ARZ2yRhax1XU+DJP3ZU7SWlIR1Y/+wNJb45XgaS/WxjkLAzXmTXRRtlkoEKZaRU=
X-Google-Smtp-Source: AGHT+IFgjweGX5ODQzAXPTf+y+jnyWh64J99uenlnE4j1LmHDJFRaGeC3DUTTUUBUuI4mkv5P2csKQ==
X-Received: by 2002:a05:600c:4fd0:b0:40e:aebd:7ce4 with SMTP id
 o16-20020a05600c4fd000b0040eaebd7ce4mr1588069wmq.3.1706623517003; 
 Tue, 30 Jan 2024 06:05:17 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:16 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:56 +0000
Subject: [PATCH v3 08/36] serial: msm: fix clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-8-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VNHxu6yHKbpNtQyx20QKLuF+3g+xmwFTuyqnmdpoXoU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAJdJpMWMO6QdfZerV5+vja5Xfte9oqHZrN8bu9+f
 XOh+7O2jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjAR19uMDP1Mjxwn9LNGzHs4
 jT+rzGha5PsXrQ6ewQwJ5ptKV4VPbGH4p7jJ6nP6E+mN4YGvBI9tkT9RVpIgFOpeovxU5CRLaP3
 aIAA=
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
index 19a5a3a788f7..0148ddb54df6 100644
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
2.43.0

