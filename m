Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5EFC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 15:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6111E87467;
	Fri,  3 Nov 2023 16:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xcvxI+JN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B48870F9; Fri,  3 Nov 2023 16:39:39 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651888710F
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 16:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c594196344so29791901fa.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025972; x=1699630772; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wum8FcvdH2bGPQw0CampEGidduAHrn+RPHDhzUNaT68=;
 b=xcvxI+JN5cao7pc/QJUok6PnA1T0rIvkezBJEdk7aERYSEmn2r2CObO/s0WoCK5wFs
 xoOzP8Q798ABUBcKgzB0wL/K07D5b6Z4ucOuxdXDOt1LKb6kGTZG3xvwmSC7ZgETOZPm
 /tHoldOWHSiQYOpbxTHaJcOaIQq6EIgQMjNK2+wbcFFj5vTpLd2y17MzISh8Nv1kBIYr
 uB9vR+u3xoqzsTLczzJAMMEtQgykoRjlldXHxRjLdS82aJlHbZLZd/I2jDpyLyu1vwqF
 gX8JuUzU+W3+bb3gK3cpe4VsACDU0IP7ZT2UWOaGC8tQNQCX+BbkWM2K3IOGWRr7vuW9
 4f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025972; x=1699630772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wum8FcvdH2bGPQw0CampEGidduAHrn+RPHDhzUNaT68=;
 b=QIsxKHbeyq9qWo0JrFGEDh/E5uU4jmYrpax7eO9mhk9NIJl40wXo2xZm/xwFQByIpe
 sVH08HmLNQ8XeE090ceU9kN8m6b4fQsBdYAqk66g+OFDxN3V1a92fB6gSV8fcvVr6Ha4
 HRa0iVuxvZ++77PPjuTB5/4AXmOmf50DWO80WztjG3FixoUGA+6vxtRE755i4IfwKFeC
 cp4KtkDyI4Jd9/RCUvlRfEHI+cNmnOAw9lT9lu9jT/drCKwav3fgi6U1jx54wlMYg++k
 d+qbcPc1Jf7h41uOVcH53Gq90u0l0MXio5pAoaubk0fnDSVjU/2T9OXfbQYnzvSq2NHx
 4fCA==
X-Gm-Message-State: AOJu0YyKSXLeZMjyRyxx4X/RBJVi83ivKR+K7uwpqqvH0zYUJ+evY+i0
 kqASPTlLcrpAkp8eCX/0fZg9BQ==
X-Google-Smtp-Source: AGHT+IGjECyOPCE9rgUNWUQ3UNx0EoDdpXJpLTZPqzImOzeKGMclfu/kp5hHz5zJm+CHgZztK1Scjw==
X-Received: by 2002:a2e:3c12:0:b0:2c5:1542:57e9 with SMTP id
 j18-20020a2e3c12000000b002c5154257e9mr18538319lja.41.1699025972656; 
 Fri, 03 Nov 2023 08:39:32 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm2928334wmb.41.2023.11.03.08.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:39:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 03 Nov 2023 15:39:26 +0000
Subject: [PATCH v3 2/7] clk/qcom: move ipq4019 driver from mach-ipq40xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-b4-qcom-clk-v3-2-8d2d460ece84@linaro.org>
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
In-Reply-To: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4632;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iYFPT2lJUrsBSjeNthaSCN9/BiAzK2lKNsXZEWPQhqE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRXEQMLVu64Zd48yob7630Nmj8f2G97TvZ86Yr1N/V2F
 JvfOvano5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEwkzYCRof2vasJlg0UptoZK
 GjUVLCcKRI5W+pausMyPKfiwrVzlEcNv9mTOfY0m12/8q5zrpdr87ebr4+HsZrwHPv+z2X184h7
 7cgA=
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

This driver is just a stub, but it's necessary to support the upcoming
reset driver changes.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                                   |  1 +
 arch/arm/mach-ipq40xx/Makefile                     |  1 -
 drivers/clk/qcom/Kconfig                           |  8 +++++
 drivers/clk/qcom/Makefile                          |  1 +
 .../clk/qcom}/clock-ipq4019.c                      | 41 ++--------------------
 drivers/clk/qcom/clock-qcom.c                      |  1 +
 6 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c9842..8833ee3e8654 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -766,6 +766,7 @@ config ARCH_IPQ40XX
 	select CLK
 	select SMEM
 	select OF_CONTROL
+	select CLK_QCOM_IPQ4019
 	imply CMD_DM
 
 config ARCH_KEYSTONE
diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
index 08a65b8854d3..b36a935c6f9f 100644
--- a/arch/arm/mach-ipq40xx/Makefile
+++ b/arch/arm/mach-ipq40xx/Makefile
@@ -4,6 +4,5 @@
 #
 # Author: Robert Marko <robert.marko@sartura.hr>
 
-obj-y += clock-ipq4019.o
 obj-y += pinctrl-snapdragon.o
 obj-y += pinctrl-ipq4019.o
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a884f077d9b9..0df0d1881a49 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -23,6 +23,14 @@ config CLK_QCOM_APQ8096
 	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCS404
 	bool "Qualcomm QCS404 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 44d55583596d..cb179fdac583 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -6,4 +6,5 @@ obj-y += clock-qcom.o
 obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
 obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/arch/arm/mach-ipq40xx/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
similarity index 56%
rename from arch/arm/mach-ipq40xx/clock-ipq4019.c
rename to drivers/clk/qcom/clock-ipq4019.c
index c1d5c4ecdd81..04c99964df15 100644
--- a/arch/arm/mach-ipq40xx/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -12,12 +12,9 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
-
 #include <dt-bindings/clock/qcom,ipq4019-gcc.h>
 
-struct msm_clk_priv {
-	phys_addr_t base;
-};
+#include "clock-qcom.h"
 
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
@@ -30,23 +27,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
 	}
 }
 
-static int msm_clk_probe(struct udevice *dev)
-{
-	struct msm_clk_priv *priv = dev_get_priv(dev);
-
-	priv->base = dev_read_addr(dev);
-	if (priv->base == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	return 0;
-}
-
-static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
-{
-	return msm_set_rate(clk, rate);
-}
-
-static int msm_enable(struct clk *clk)
+int msm_enable(struct clk *clk)
 {
 	switch (clk->id) {
 	case GCC_BLSP1_QUP1_SPI_APPS_CLK: /*SPI1*/
@@ -68,21 +49,3 @@ static int msm_enable(struct clk *clk)
 	}
 }
 
-static struct clk_ops msm_clk_ops = {
-	.set_rate = msm_clk_set_rate,
-	.enable = msm_enable,
-};
-
-static const struct udevice_id msm_clk_ids[] = {
-	{ .compatible = "qcom,gcc-ipq4019" },
-	{ }
-};
-
-U_BOOT_DRIVER(clk_msm) = {
-	.name		= "clk_msm",
-	.id		= UCLASS_CLK,
-	.of_match	= msm_clk_ids,
-	.ops		= &msm_clk_ops,
-	.priv_auto	= sizeof(struct msm_clk_priv),
-	.probe		= msm_clk_probe,
-};
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 5667abeb89a4..5914616fba5d 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -166,6 +166,7 @@ static const struct udevice_id msm_clk_ids[] = {
 	{ .compatible = "qcom,gcc-apq8016" },
 	{ .compatible = "qcom,gcc-msm8996" },
 	{ .compatible = "qcom,gcc-apq8096" },
+	{ .compatible = "qcom,gcc-ipq4019" },
 	{ .compatible = "qcom,gcc-sdm845" },
 	{ .compatible = "qcom,gcc-qcs404" },
 	{ }

-- 
2.42.0

