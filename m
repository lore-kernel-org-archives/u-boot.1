Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C542C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E63287F4E;
	Thu, 15 Feb 2024 21:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fgZbJ8yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D38687F3D; Thu, 15 Feb 2024 21:53:07 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7B487E01
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso398530f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030353; x=1708635153; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l6WYKOqLvYvzDXJxb1X9H2+sNPvmQE+2eGLcWk7k/oY=;
 b=fgZbJ8yvIr4V/6tZXn/lvCBulZJjbyiHLlTfNaxGaSEahmm3J9kt606+BL2FgNoWmM
 Icg1QLujKWhxuFHqUerVZtlgwpPewrJlMBWjMl1iK3+eqGTvR7IUOcE+L0+X5UOjjQYh
 ihvPO3d7uTsFio3gD1GJldjT0d6k476oPx17WbN7t2yGZC9eQ7zgCSxydar+tva8k3Dv
 Y+8d1wdYaOwW+ZG4+85zT2omLcR2o1w4xAH9sYOi96NovYgZpceQ4vcPSw5kwkXHpa7E
 VD4eQCfEfqScRH97b7q9Vx3HR7yI+VscohGascISbQPNjShnlhjsKmY7tndj+sfubbHV
 ScJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030353; x=1708635153;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6WYKOqLvYvzDXJxb1X9H2+sNPvmQE+2eGLcWk7k/oY=;
 b=v0a4o+GgZUXEjCWNl2C0ZjpGitaK+hzqz+Z12vIKOpSqtZXA/cNFEHq8s4Hcu2xaeh
 Lvs51T4bp248snIi6hkF+EZvSsHz68iLFUS9CdmxLoXIPRv+OASi1EwYdKJPkh7e8Yua
 ha8QZZ0zmwfwEry/7/eo5fJlIA/3R+2TkDSwB1Noal99VlN8wpnaz12l7vOmBUh9kAcy
 hc2dNwJcnmXSKpgQLJKHGAajRowLl1HJrBOf3/yXluRVF/QT50R0aOKp4CsNYkf5DDaJ
 /+C/wx8RuoiOQ4DgLquhNI5+AKSGtQBRDtTw/zaS58zXg84f5evSmhemdY1xqKmAdUx7
 ONPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JLvHrOmgxu3mpmU/d0JCbOLcuP+YgF/AhgGLtO3M5zROd2rn4P20YtC1aP9zzjJwtogniqa9Yyz50qknNPWCt7CpPw==
X-Gm-Message-State: AOJu0YyIH7k9yjn833CIc6ZUsFHgTEssPvLtgY0K8sm2wd5sU26CPESW
 fKvsucQbLmLTXq6l63KjkzsMfBZCycM3Vbm+qRD6P0o/xk0ZiOSNTaVp2/o3aSd4CjVMNmpWCYt
 D
X-Google-Smtp-Source: AGHT+IF5YTru8DuHrnkGgp0n8x2NrBYsAzVyJrtXIjEpr+0A+odsVrdxM0kVVupVedwitCssqPVJSA==
X-Received: by 2002:adf:f6c4:0:b0:33b:37f5:f41d with SMTP id
 y4-20020adff6c4000000b0033b37f5f41dmr1850063wrp.70.1708030353351; 
 Thu, 15 Feb 2024 12:52:33 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:26 +0000
Subject: [PATCH v4 08/39] serial: msm: fix clock handling and pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-8-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vwwKNPE/rCfeopqHAkTWDML+TXlzX81EnHEcDPZPvhM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS2lRfbMv641bcn6c5Ejsu23tKGHjp+lgeoW6cydV
 hM/P2fpKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABP5vpDhD7cRqwfT8017Pl5d
 f+oBxxLR5ppLh3Zlc7ebtS1efvfKSx6Gfwp+G0/of7wbw6NzTZR5QVvLRLfojK3pAuUNyz9sCPD
 V+wsA
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
index 44b93bd7ff21..ac4280c6c4c2 100644
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
 	if (ret < 0)
@@ -218,7 +203,6 @@ static int msm_serial_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	pinctrl_select_state(dev, "uart");
 	uart_dm_init(priv);
 
 	return 0;
@@ -251,6 +235,7 @@ U_BOOT_DRIVER(serial_msm) = {
 	.priv_auto	= sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM

-- 
2.43.1

