Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A53C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E6887201;
	Tue,  7 Nov 2023 13:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EACVctje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F7A87239; Tue,  7 Nov 2023 13:41:19 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4CB871DE
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso41157975e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360874; x=1699965674; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wum8FcvdH2bGPQw0CampEGidduAHrn+RPHDhzUNaT68=;
 b=EACVctjeGoCePlPvFyZAhc8Jv4AfY2aX4/LFK+lRcD4pc5PBIWoHa1WLeneHc8rMwF
 Dxu60Oid6bzTmwb7Tq+E8w4IKICum8LVPOUMvZWlExQQzNWFXq4nFyTEpvTVKM6Idzm6
 0BElVatx/47uH0Gwu5EF/ldTTiRerLGd1F+MIAo2ngnGKFwMRXDUmlNeuyZR1WE2bPH3
 1THbg/1GpPs7YV9ZV+OgwLLQhbTwZk0tG49Zx5p4IQNf7Lgq/NkrVjfs/qDCAnOooJLJ
 hiqfm5z/C0Yp4Y2f55ZGYz+LLMd0HIHqdPm8oYYQEhha+Zff88x9WO6ZWAUsfdiW10zn
 I4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360874; x=1699965674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wum8FcvdH2bGPQw0CampEGidduAHrn+RPHDhzUNaT68=;
 b=exlILnVG/8+Y+zgmmpuDu+Eim4dVBn8gNk1fdudhmgHnIaL1ktcaPP3LhDYy91lva0
 ZFcdReC/tD1e/HTShYougJGmoL4QbcyK1SPkeJ2LfOQUyho1MvpEoBGK2FuxndYBKc5D
 QQtgVXZkkj7JFkgVwsxpG8MB8sdpFKcrttBNvxaMye+9a1iB4qR73h86Ij5BNrI9pYpm
 eej9Jhm+en6HWwd7Ogo6ewUhl9r1VZqmfLKfT8UEUAAX1IQ7ntNRh33KVueM6yHzMCxa
 fkO2YCtoMHTFkpIEFUYQaZMcy+gVOV8gdk1AeWPmeLfShXFz4YyyxyaLI21mlI2CVGtw
 h6Mw==
X-Gm-Message-State: AOJu0Yyt+NsIuc90U/tiaweE/GSvjfifQ0r+Kc3vh8/MG1mx1gATkCcn
 dYtMVvQEAkWdzhF/ABLmLyR/Xg==
X-Google-Smtp-Source: AGHT+IEdIcuo8PcC+kWWmMHwRZPPLkm3pbEU4nMV2J6NIvzZ8OmIbs7SepzYA3eB4IfV9/IpQ6X/8g==
X-Received: by 2002:a7b:cb01:0:b0:40a:2796:618f with SMTP id
 u1-20020a7bcb01000000b0040a2796618fmr1847639wmj.40.1699360874388; 
 Tue, 07 Nov 2023 04:41:14 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm2285333wrt.18.2023.11.07.04.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:41:13 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 07 Nov 2023 12:41:00 +0000
Subject: [PATCH v4 2/7] clk/qcom: move ipq4019 driver from mach-ipq40xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-b4-qcom-clk-v4-2-82bbaf1a796d@linaro.org>
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
In-Reply-To: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQvgzStlY2njf/PYbFMuvvpocPEXN5bNwMMZW0K/j7w1
 YxWrn3UUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbyuoiRYdmU3Oh9Aalcz2MN
 TYs7FU9rfIh7eaU1X+kW+7posyml1YwMi/IUt136NHlxsbzvnWNr7+67zaX1uzu4/rnU/bic85c
 PfgMA
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

