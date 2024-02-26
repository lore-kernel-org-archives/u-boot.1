Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724B7C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F5287FA1;
	Mon, 26 Feb 2024 18:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6fwCmsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFC987F8E; Mon, 26 Feb 2024 18:26:36 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E7D87F4F
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d6cc6d2fcso2130432f8f.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968389; x=1709573189; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R+mQzgxWg6nWkMmHs4vmX3si8dO4qxGyRGzcnDD8wfY=;
 b=w6fwCmsPTXf1NtU+rHE5v6V5weBUacqFr3/i7B3oQW6VGNohkIuQbsrOYdNlv8AgpB
 HQEvsV5XRdauNDvL600L5jz4tgumnyADTzFoaQBmYZG9aycECz9dkngcW71ovQY/SJ1W
 fZhEE17I9YRLl1iiQGusq3L0rR9cexai4Vo1zpYkO8epOp43GGrX8apNzuBxFnfyuelV
 3jzIe/NyGpKXPkEi3pEho8nYIRlp+O2Yi3U5oQwmHeOa2gKyjN4lE2ZK+orXe+9zx0FO
 OjWRghWb3NtIUjVRiHcrOk7NmqEfDqnOxJQAjs6UOjdIn5nvErVaplkxGh8OaDNwpcW2
 /9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968389; x=1709573189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+mQzgxWg6nWkMmHs4vmX3si8dO4qxGyRGzcnDD8wfY=;
 b=cyehXT6d0R0bI+b3IyjxMu/IjA/0WpABwzoxcoqrMGX05hB9k4VSZYtI3wMCi6RVjm
 Yx+e1KGfYzxAAyjsohq2fj5EhZxP5eQGb+VcGVm/i7Nuj0o3DsN5OJY3JIFQlg/xQBr3
 fFALV2bB+VxKDGWgFVQV8jsQF6rDoIoOfUWS9Xm/qsm/52gSLzXKkL7EMYnmD/RZihdO
 N2OU3pHcdPIqqmd8az130w3mICbLLK0fHNe8T3AYM/8+ejrNDPPUNAyh8KHzSnJVIOxG
 Dw00caODFUW7qED5wqBy1YibnGe+MUB5M7urJ2hA4h9MH7nNAcV6F57WnP+4V97AGeZQ
 aV6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzGheIA8VoSYctmqqo6XhLh74r6LF4qt89xF3CrOKxhOUF6GA8/1h4FNkZPYWgbWbNvkFtU7vGf8qqQ3Isc+E5jxzjpQ==
X-Gm-Message-State: AOJu0YzLcoRcaNfCvkd3RW8efzv+aAxWTi9wBJUqPml8s90IV/50VRZ9
 6xOFSfFtiXofE+GyRHcTO5TCD1IPMuPcuSLx/JhAsTlmYuJIVNLY/sAPHyjdLfQ=
X-Google-Smtp-Source: AGHT+IGKY9gWYdJtQK1FcG/00ubQjkbvMJK6Tmu29jUlEcazJ+oybycPvBf/sAEfDjLcXyTDVPJ6Xw==
X-Received: by 2002:a5d:6087:0:b0:33d:5f6a:60ef with SMTP id
 w7-20020a5d6087000000b0033d5f6a60efmr4768637wrt.55.1708968389610; 
 Mon, 26 Feb 2024 09:26:29 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:29 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:12 +0000
Subject: [PATCH v5 08/39] serial: msm: fix clock handling and pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-8-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=I2Kd+ENmgLeJYDJqeifvxhgJrNUJUTuhTyRWRsJYyMw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3dyFj79t3G9UaDV799L/mkvFdcJ1BPjcOaOOB4ya
 fXhuJPSHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi8tMY/lnO930btuWzpvvP
 n0YhNcqf7TdOE9t2fmvCuRknz6rf0ZBl+F/T0dcrs2211Vr9TzXPnOz36Bk/uKuycY9z/oPXp19
 s5LoMAA==
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
("clocks" instead of "clock"). Drop the call to pinctrl_select_state()
as no boards have a "uart" pinctrl state and this prints confusing
errors.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts |  3 ++-
 arch/arm/dts/dragonboard820c.dts |  3 ++-
 drivers/serial/serial_msm.c      | 25 +++++--------------------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 02c824d0226c..c395e6cc0427 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -83,9 +83,10 @@
 
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
@@ -77,9 +77,10 @@
 
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
index 44b93bd7ff21..ac4280c6c4c2 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -159,31 +159,16 @@ static const struct dm_serial_ops msm_serial_ops = {
 static int msm_uart_clk_init(struct udevice *dev)
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
 	if (ret < 0)
 		return ret;
@@ -217,9 +202,8 @@ static int msm_serial_probe(struct udevice *dev)
 	ret = msm_uart_clk_init(dev);
 	if (ret)
 		return ret;
 
-	pinctrl_select_state(dev, "uart");
 	uart_dm_init(priv);
 
 	return 0;
 }
@@ -250,8 +234,9 @@ U_BOOT_DRIVER(serial_msm) = {
 	.of_to_plat = msm_serial_of_to_plat,
 	.priv_auto	= sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM
 

-- 
2.43.1

