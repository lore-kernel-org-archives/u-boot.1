Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60507C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B581874A9;
	Tue, 24 Oct 2023 22:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UyPzDxUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44EC0879CC; Tue, 24 Oct 2023 22:24:08 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3E0879D2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso41547525e9.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179041; x=1698783841; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R6EhdbhhwzfS9gFdoUtNgaRTsoNrPlTY6+Uhm1rjNnc=;
 b=UyPzDxUcQAwrlRzLLA0Pg/XUB0uyGVWwfMeW9wZsgFXMUBYS6QXa6kjdb5aPjiMnAF
 xImKIJp3d7L6t+1F3nqYj3mmPNFbBBNzzn/PhbVQg4Aw9qnYtOM+jG98chOOsKGiXJQQ
 HLU9skDzo5Zg1cJhm4FLaps8dlJDHzQz3vO0YHiiszDVHbBuezenywiBYDcx4UEZvYfC
 DSYGOUsyiuqrWEIMQ946jL2edMqvTQAsZNBtXGacfrNclYRbd8H+pvQs/IsJbg920y8a
 M2w30JjBVTPAxkI6mgUE9p6pbAMIvok59lgIv+1sMhorC/eqoIYNv9GvA4OlZI4X+s9/
 QJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179041; x=1698783841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6EhdbhhwzfS9gFdoUtNgaRTsoNrPlTY6+Uhm1rjNnc=;
 b=q9yuoZRIOxlZ2crU1lt0MaCewfEkktBCSPBoNqvC4JUYFxliQFgRoVhHfjkIv/mXn1
 nLiRoQtYGEF3vM71VfYrZoWPEJGNcMhSOYRVBHRmrPKQpNMvzKTOakX/GAhIlgdJ7MUr
 KfcJVVHRdqWQw2Ts3u0sEw34FadIYuFb0S97S8wErD04x/R3vgQ28g/+b3i7v74Wa2Vw
 lW5giIbwgXrONJyD29MTHnoF9tcabf5k3oLcXiBeKnZRBDU+jganlJ7rA8y/jRdMu34+
 ISJki1M+5ZCZUdNyAqXZiXdneAU9zFgk/pf+6HURupjBZOsETwwUe2q0Ihu7S1MLoYOo
 LZeQ==
X-Gm-Message-State: AOJu0YytXVKvxcaqweWbSEUZlWtz2fT1uJqusVa+KiVzU77rhdTIILUD
 TJKrxnpG0Suo2gTWW8DZCBsN5gTp1DXHnc9NLTc05A==
X-Google-Smtp-Source: AGHT+IH+fVaOyTAL3XOCD3aJRzN3GixpRikHN4qJEtdeSa/Opu5pzQ4bwc0kUCPGE2eVlo/4UA1D9Q==
X-Received: by 2002:adf:f30e:0:b0:32d:a98c:aa1f with SMTP id
 i14-20020adff30e000000b0032da98caa1fmr9007932wro.1.1698179040961; 
 Tue, 24 Oct 2023 13:24:00 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:24:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:55 +0100
Subject: [PATCH 4/8] clk/qcom: handle resets and clocks in one device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-4-9d96359b9a82@linaro.org>
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=30594;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ugbbM/21NiDfKeW35nc21U8UWCcWpbckJZDiMa8lbUc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9Vu9ugkefRqnq899bev1UD5877pX5aM/dTvt9nCF8
 Ww63lLUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYSNIfhn8Xip5sC2bbu2yPh
 LtOU052YGup5ql37+6QH07+9Y2Kvn87wm2VP0fErH87F97ltMOPfUtW267Dqy2dBG2xtTdPF3vl
 /SwMA
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Qualcomm's clock controller blocks are actually do much more than it
says on the tin.. They provide clocks, resets and power domains.
Currently, U-Boot required one to spawn 2 separate devices for
controlling clocks and resets, both spanning the same register space.
Refactor the code to make it work with just a single DT node, making
it compatible with upstream Linux bindings and dropping the dedicated
reset driver in favour of including it in the clock driver.

While at it, take the liberty of slowly renaming 'msm' and 'snapdragon'
to 'qcom' and drop unused compatibles.

Heavily inspired by Renesas code for a similar hw block.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
[caleb: moved drivers to clk/qcom, added reset driver and adjusted bind
logic]
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                 |   1 +
 arch/arm/dts/qcom-ipq4019.dtsi   |  14 +--
 arch/arm/dts/qcs404-evb.dts      |  19 ++--
 drivers/clk/qcom/clock-apq8016.c |  23 ++++-
 drivers/clk/qcom/clock-apq8096.c |  22 ++++-
 drivers/clk/qcom/clock-ipq4019.c |  95 +++++++++++++++++++
 drivers/clk/qcom/clock-qcom.c    | 122 ++++++++++++++++++++----
 drivers/clk/qcom/clock-qcom.h    |  22 +++--
 drivers/clk/qcom/clock-qcs404.c  |  54 ++++++++++-
 drivers/clk/qcom/clock-sdm845.c  |  55 ++++++++++-
 drivers/reset/Kconfig            |   7 --
 drivers/reset/Makefile           |   1 -
 drivers/reset/reset-qcom.c       | 195 ---------------------------------------
 13 files changed, 370 insertions(+), 260 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5aaf7e5e32af..faccfaf720a8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1067,6 +1067,7 @@ config ARCH_SNAPDRAGON
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
+	select DM_RESET
 	select GPIO_EXTRA_HEADER
 	select MSM_SMEM
 	select OF_CONTROL
diff --git a/arch/arm/dts/qcom-ipq4019.dtsi b/arch/arm/dts/qcom-ipq4019.dtsi
index 0850ae56e9a8..f9489e42ea2c 100644
--- a/arch/arm/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/dts/qcom-ipq4019.dtsi
@@ -66,14 +66,6 @@
 			status = "disabled";
 		};
 
-		reset: gcc-reset@1800000 {
-			compatible = "qcom,gcc-reset-ipq4019";
-			reg = <0x1800000 0x60000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			bootph-all;
-		};
-
 		soc_gpios: pinctrl@1000000 {
 			compatible = "qcom,ipq4019-pinctrl";
 			reg = <0x1000000 0x300000>;
@@ -136,7 +128,7 @@
 			#phy-cells = <0>;
 			reg = <0x9a000 0x800>;
 			reg-names = "phy_base";
-			resets = <&reset USB3_UNIPHY_PHY_ARES>;
+			resets = <&gcc USB3_UNIPHY_PHY_ARES>;
 			reset-names = "por_rst";
 			status = "disabled";
 		};
@@ -146,7 +138,7 @@
 			#phy-cells = <0>;
 			reg = <0xa6000 0x40>;
 			reg-names = "phy_base";
-			resets = <&reset USB3_HSPHY_POR_ARES>, <&reset USB3_HSPHY_S_ARES>;
+			resets = <&gcc USB3_HSPHY_POR_ARES>, <&gcc USB3_HSPHY_S_ARES>;
 			reset-names = "por_rst", "srif_rst";
 			status = "disabled";
 		};
@@ -179,7 +171,7 @@
 			#phy-cells = <0>;
 			reg = <0xa8000 0x40>;
 			reg-names = "phy_base";
-			resets = <&reset USB2_HSPHY_POR_ARES>, <&reset USB2_HSPHY_S_ARES>;
+			resets = <&gcc USB2_HSPHY_POR_ARES>, <&gcc USB2_HSPHY_S_ARES>;
 			reset-names = "por_rst", "srif_rst";
 			status = "disabled";
 		};
diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
index 8d7893c11695..84224a8a3d39 100644
--- a/arch/arm/dts/qcs404-evb.dts
+++ b/arch/arm/dts/qcs404-evb.dts
@@ -208,11 +208,6 @@
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
 			#clock-cells = <1>;
-		};
-
-		reset: gcc-reset@1800000 {
-			compatible = "qcom,gcc-reset-qcs404";
-			reg = <0x1800000 0x80000>;
 			#reset-cells = <1>;
 		};
 
@@ -245,8 +240,8 @@
 			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
 				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
 			clock-names = "ahb", "pipe";
-			resets = <&reset GCC_USB3_PHY_BCR>,
-				 <&reset GCC_USB3PHY_PHY_BCR>;
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
 			reset-names = "com", "phy";
 		};
 
@@ -257,8 +252,8 @@
 			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
 				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
 			clock-names = "ahb", "sleep";
-			resets = <&reset GCC_USB_HS_PHY_CFG_AHB_BCR>,
-				 <&reset GCC_USB2A_PHY_BCR>;
+			resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+				 <&gcc GCC_USB2A_PHY_BCR>;
 			reset-names = "phy", "por";
 		};
 
@@ -269,8 +264,8 @@
 			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
 				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
 			clock-names = "ahb", "sleep";
-			resets = <&reset GCC_QUSB2_PHY_BCR>,
-				 <&reset GCC_USB2_HS_PHY_ONLY_BCR>;
+			resets = <&gcc GCC_QUSB2_PHY_BCR>,
+				 <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
 			reset-names = "phy", "por";
 		};
 
@@ -335,7 +330,7 @@
 				 <&gcc GCC_ETH_PTP_CLK>,
 				 <&gcc GCC_ETH_RGMII_CLK>;
 
-			resets = <&reset GCC_EMAC_BCR>;
+			resets = <&gcc GCC_EMAC_BCR>;
 			reset-names = "emac";
 
 			snps,tso;
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 90f2a93d9ed5..e3b9b8c1b91b 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+
 #include "clock-qcom.h"
 
 /* GPLL0 clock control registers */
@@ -49,7 +50,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 };
 
 /* SDHCI */
-static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
+static int clk_init_sdc(struct qcom_cc_priv *priv, int slot, uint rate)
 {
 	int div = 8; /* 100MHz default */
 
@@ -75,7 +76,7 @@ static const struct bcr_regs uart2_regs = {
 };
 
 /* UART: 115200 */
-static int clk_init_uart(struct msm_clk_priv *priv)
+static int clk_init_uart(struct qcom_cc_priv *priv)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
@@ -95,7 +96,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
 
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
-	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case 0: /* SDC1 */
@@ -116,3 +117,19 @@ int msm_enable(struct clk *clk)
 {
 	return 0;
 }
+
+static const struct udevice_id gcc_apq8016_of_match[] = {
+	{
+		.compatible = "qcom,gcc-apq8016",
+		/* TODO: add reset map */
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_apq8016) = {
+	.name		= "gcc_apq8016",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_apq8016_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index d5388c69aefe..dc64d11ca979 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -41,7 +41,7 @@ static struct vote_clk gcc_blsp2_ahb_clk = {
 	.vote_bit = BIT(15),
 };
 
-static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
+static int clk_init_sdc(struct qcom_cc_priv *priv, uint rate)
 {
 	int div = 3;
 
@@ -62,7 +62,7 @@ static const struct bcr_regs uart2_regs = {
 	.D = BLSP2_UART2_APPS_D,
 };
 
-static int clk_init_uart(struct msm_clk_priv *priv)
+static int clk_init_uart(struct qcom_cc_priv *priv)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(priv->base, &gcc_blsp2_ahb_clk);
@@ -82,7 +82,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
 
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
-	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case 0: /* SDC1 */
@@ -99,3 +99,19 @@ int msm_enable(struct clk *clk)
 {
 	return 0;
 }
+
+static const struct udevice_id gcc_apq8096_of_match[] = {
+	{
+		.compatible = "qcom,gcc-apq8096",
+		/* TODO: add reset map */
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_apq8096) = {
+	.name		= "gcc_apq8096",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_apq8096_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index 04c99964df15..6636af98132d 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <dt-bindings/clock/qcom,ipq4019-gcc.h>
+#include <dt-bindings/reset/qcom,ipq4019-reset.h>
 
 #include "clock-qcom.h"
 
@@ -49,3 +50,97 @@ int msm_enable(struct clk *clk)
 	}
 }
 
+static const struct qcom_reset_map gcc_ipq4019_resets[] = {
+	[WIFI0_CPU_INIT_RESET] = { 0x1f008, 5 },
+	[WIFI0_RADIO_SRIF_RESET] = { 0x1f008, 4 },
+	[WIFI0_RADIO_WARM_RESET] = { 0x1f008, 3 },
+	[WIFI0_RADIO_COLD_RESET] = { 0x1f008, 2 },
+	[WIFI0_CORE_WARM_RESET] = { 0x1f008, 1 },
+	[WIFI0_CORE_COLD_RESET] = { 0x1f008, 0 },
+	[WIFI1_CPU_INIT_RESET] = { 0x20008, 5 },
+	[WIFI1_RADIO_SRIF_RESET] = { 0x20008, 4 },
+	[WIFI1_RADIO_WARM_RESET] = { 0x20008, 3 },
+	[WIFI1_RADIO_COLD_RESET] = { 0x20008, 2 },
+	[WIFI1_CORE_WARM_RESET] = { 0x20008, 1 },
+	[WIFI1_CORE_COLD_RESET] = { 0x20008, 0 },
+	[USB3_UNIPHY_PHY_ARES] = { 0x1e038, 5 },
+	[USB3_HSPHY_POR_ARES] = { 0x1e038, 4 },
+	[USB3_HSPHY_S_ARES] = { 0x1e038, 2 },
+	[USB2_HSPHY_POR_ARES] = { 0x1e01c, 4 },
+	[USB2_HSPHY_S_ARES] = { 0x1e01c, 2 },
+	[PCIE_PHY_AHB_ARES] = { 0x1d010, 11 },
+	[PCIE_AHB_ARES] = { 0x1d010, 10 },
+	[PCIE_PWR_ARES] = { 0x1d010, 9 },
+	[PCIE_PIPE_STICKY_ARES] = { 0x1d010, 8 },
+	[PCIE_AXI_M_STICKY_ARES] = { 0x1d010, 7 },
+	[PCIE_PHY_ARES] = { 0x1d010, 6 },
+	[PCIE_PARF_XPU_ARES] = { 0x1d010, 5 },
+	[PCIE_AXI_S_XPU_ARES] = { 0x1d010, 4 },
+	[PCIE_AXI_M_VMIDMT_ARES] = { 0x1d010, 3 },
+	[PCIE_PIPE_ARES] = { 0x1d010, 2 },
+	[PCIE_AXI_S_ARES] = { 0x1d010, 1 },
+	[PCIE_AXI_M_ARES] = { 0x1d010, 0 },
+	[ESS_RESET] = { 0x12008, 0},
+	[GCC_BLSP1_BCR] = {0x01000, 0},
+	[GCC_BLSP1_QUP1_BCR] = {0x02000, 0},
+	[GCC_BLSP1_UART1_BCR] = {0x02038, 0},
+	[GCC_BLSP1_QUP2_BCR] = {0x03008, 0},
+	[GCC_BLSP1_UART2_BCR] = {0x03028, 0},
+	[GCC_BIMC_BCR] = {0x04000, 0},
+	[GCC_TLMM_BCR] = {0x05000, 0},
+	[GCC_IMEM_BCR] = {0x0E000, 0},
+	[GCC_ESS_BCR] = {0x12008, 0},
+	[GCC_PRNG_BCR] = {0x13000, 0},
+	[GCC_BOOT_ROM_BCR] = {0x13008, 0},
+	[GCC_CRYPTO_BCR] = {0x16000, 0},
+	[GCC_SDCC1_BCR] = {0x18000, 0},
+	[GCC_SEC_CTRL_BCR] = {0x1A000, 0},
+	[GCC_AUDIO_BCR] = {0x1B008, 0},
+	[GCC_QPIC_BCR] = {0x1C000, 0},
+	[GCC_PCIE_BCR] = {0x1D000, 0},
+	[GCC_USB2_BCR] = {0x1E008, 0},
+	[GCC_USB2_PHY_BCR] = {0x1E018, 0},
+	[GCC_USB3_BCR] = {0x1E024, 0},
+	[GCC_USB3_PHY_BCR] = {0x1E034, 0},
+	[GCC_SYSTEM_NOC_BCR] = {0x21000, 0},
+	[GCC_PCNOC_BCR] = {0x2102C, 0},
+	[GCC_DCD_BCR] = {0x21038, 0},
+	[GCC_SNOC_BUS_TIMEOUT0_BCR] = {0x21064, 0},
+	[GCC_SNOC_BUS_TIMEOUT1_BCR] = {0x2106C, 0},
+	[GCC_SNOC_BUS_TIMEOUT2_BCR] = {0x21074, 0},
+	[GCC_SNOC_BUS_TIMEOUT3_BCR] = {0x2107C, 0},
+	[GCC_PCNOC_BUS_TIMEOUT0_BCR] = {0x21084, 0},
+	[GCC_PCNOC_BUS_TIMEOUT1_BCR] = {0x2108C, 0},
+	[GCC_PCNOC_BUS_TIMEOUT2_BCR] = {0x21094, 0},
+	[GCC_PCNOC_BUS_TIMEOUT3_BCR] = {0x2109C, 0},
+	[GCC_PCNOC_BUS_TIMEOUT4_BCR] = {0x210A4, 0},
+	[GCC_PCNOC_BUS_TIMEOUT5_BCR] = {0x210AC, 0},
+	[GCC_PCNOC_BUS_TIMEOUT6_BCR] = {0x210B4, 0},
+	[GCC_PCNOC_BUS_TIMEOUT7_BCR] = {0x210BC, 0},
+	[GCC_PCNOC_BUS_TIMEOUT8_BCR] = {0x210C4, 0},
+	[GCC_PCNOC_BUS_TIMEOUT9_BCR] = {0x210CC, 0},
+	[GCC_TCSR_BCR] = {0x22000, 0},
+	[GCC_MPM_BCR] = {0x24000, 0},
+	[GCC_SPDM_BCR] = {0x25000, 0},
+};
+
+static struct qcom_cc_data ipq4019_data = {
+	.resets = gcc_ipq4019_resets,
+	.num_resets = ARRAY_SIZE(gcc_ipq4019_resets),
+};
+
+static const struct udevice_id gcc_ipq4019_of_match[] = {
+	{
+		.compatible = "qcom,gcc-ipq4019",
+		.data = (ulong)&ipq4019_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq4019) = {
+	.name		= "gcc_ipq4019",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq4019_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 5667abeb89a4..b0416a05789d 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -1,8 +1,13 @@
-// SPDX-License-Identifier: BSD-3-Clause
+// SPDX-License-Identifier: BSD-3-Clause AND GPL-2.0
 /*
- * Clock drivers for Qualcomm APQ8016, APQ8096
+ * Clock and reset drivers for Qualcomm platforms Global Clock
+ * Controller (GCC).
  *
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2020 Sartura Ltd. (reset driver)
+ *     Author: Robert Marko <robert.marko@sartura.hr>
+ * (C) Copyright 2022 Linaro Ltd. (reset driver)
+ *     Author: Sumit Garg <sumit.garg@linaro.org>
  *
  * Based on Little Kernel driver, simplified
  */
@@ -10,9 +15,13 @@
 #include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <reset-uclass.h>
+
 #include "clock-qcom.h"
 
 /* CBCR register fields */
@@ -137,12 +146,15 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 
 static int msm_clk_probe(struct udevice *dev)
 {
-	struct msm_clk_priv *priv = dev_get_priv(dev);
+	struct qcom_cc_data *data = (struct qcom_cc_data *)dev_get_driver_data(dev);
+	struct qcom_cc_priv *priv = dev_get_priv(dev);
 
 	priv->base = dev_read_addr(dev);
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	priv->data = data;
+
 	return 0;
 }
 
@@ -161,21 +173,97 @@ static struct clk_ops msm_clk_ops = {
 	.enable = msm_clk_enable,
 };
 
-static const struct udevice_id msm_clk_ids[] = {
-	{ .compatible = "qcom,gcc-msm8916" },
-	{ .compatible = "qcom,gcc-apq8016" },
-	{ .compatible = "qcom,gcc-msm8996" },
-	{ .compatible = "qcom,gcc-apq8096" },
-	{ .compatible = "qcom,gcc-sdm845" },
-	{ .compatible = "qcom,gcc-qcs404" },
-	{ }
-};
-
-U_BOOT_DRIVER(clk_msm) = {
-	.name		= "clk_msm",
+U_BOOT_DRIVER(qcom_clk) = {
+	.name		= "qcom_clk",
 	.id		= UCLASS_CLK,
-	.of_match	= msm_clk_ids,
 	.ops		= &msm_clk_ops,
-	.priv_auto	= sizeof(struct msm_clk_priv),
+	.priv_auto	= sizeof(struct qcom_cc_priv),
 	.probe		= msm_clk_probe,
 };
+
+int qcom_cc_bind(struct udevice *parent)
+{
+	struct qcom_cc_data *data = (struct qcom_cc_data *)dev_get_driver_data(parent);
+	struct udevice *clkdev, *rstdev;
+	struct driver *drv;
+	int ret;
+
+	/* Get a handle to the common clk handler */
+	drv = lists_driver_lookup_name("qcom_clk");
+	if (!drv)
+		return -ENOENT;
+
+	/* Register the clock controller */
+	ret = device_bind_with_driver_data(parent, drv, "qcom_clk", (ulong)data,
+					   dev_ofnode(parent), &clkdev);
+	if (ret)
+		return ret;
+
+	/* Bail out early if resets are not specified for this platform */
+	if (!data->resets)
+		return ret;
+
+	/* Get a handle to the common reset handler */
+	drv = lists_driver_lookup_name("qcom_reset");
+	if (!drv)
+		return -ENOENT;
+
+	/* Register the reset controller */
+	ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
+					   dev_ofnode(parent), &rstdev);
+	if (ret)
+		device_unbind(clkdev);
+
+	return ret;
+}
+
+static int qcom_reset_set(struct reset_ctl *rst, bool assert)
+{
+	struct qcom_cc_data *data = (struct qcom_cc_data *)dev_get_driver_data(rst->dev);
+	void __iomem *base = dev_get_priv(rst->dev);
+	const struct qcom_reset_map *map;
+	u32 value;
+
+	map = &data->resets[rst->id];
+
+	value = readl(base + map->reg);
+
+	if (assert)
+		value |= BIT(map->bit);
+	else
+		value &= ~BIT(map->bit);
+
+	writel(value, base + map->reg);
+
+	return 0;
+}
+
+static int qcom_reset_assert(struct reset_ctl *rst)
+{
+	return qcom_reset_set(rst, true);
+}
+
+static int qcom_reset_deassert(struct reset_ctl *rst)
+{
+	return qcom_reset_set(rst, false);
+}
+
+static const struct reset_ops qcom_reset_ops = {
+	.rst_assert = qcom_reset_assert,
+	.rst_deassert = qcom_reset_deassert,
+};
+
+static int qcom_reset_probe(struct udevice *dev)
+{
+	/* Set our priv pointer to the base address */
+	dev_set_priv(dev, (void *)dev_read_addr(dev));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(qcom_reset) = {
+	.name = "qcom_reset",
+	.id = UCLASS_RESET,
+	.ops = &qcom_reset_ops,
+	.probe = qcom_reset_probe,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index c90bbefa5881..a77a94b6ea06 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Qualcomm APQ8016, APQ8096, SDM845
- *
  * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
-#ifndef _CLOCK_SNAPDRAGON_H
-#define _CLOCK_SNAPDRAGON_H
+#ifndef _CLOCK_QCOM_H
+#define _CLOCK_QCOM_H
 
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
@@ -32,10 +30,22 @@ struct bcr_regs {
 	uintptr_t D;
 };
 
-struct msm_clk_priv {
-	phys_addr_t base;
+struct qcom_reset_map {
+	unsigned int reg;
+	u8 bit;
 };
 
+struct qcom_cc_data {
+	const struct qcom_reset_map	*resets;
+	unsigned long			num_resets;
+};
+
+struct qcom_cc_priv {
+	phys_addr_t		base;
+	struct qcom_cc_data	*data;
+};
+
+int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 80218af73ef6..e622309b6747 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -11,9 +11,10 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-qcs404.h>
+
 #include "clock-qcom.h"
 
-#include <dt-bindings/clock/qcom,gcc-qcs404.h>
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(31)
@@ -113,7 +114,7 @@ static const struct bcr_regs blsp1_qup4_i2c_apps_regs = {
 
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
-	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case GCC_BLSP1_UART2_APPS_CLK:
@@ -158,7 +159,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
 
 int msm_enable(struct clk *clk)
 {
-	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case GCC_USB30_MASTER_CLK:
@@ -235,3 +236,50 @@ int msm_enable(struct clk *clk)
 
 	return 0;
 }
+
+static const struct qcom_reset_map qcs404_gcc_resets[] = {
+	[GCC_GENI_IR_BCR] = { 0x0F000 },
+	[GCC_CDSP_RESTART] = { 0x18000 },
+	[GCC_USB_HS_BCR] = { 0x41000 },
+	[GCC_USB2_HS_PHY_ONLY_BCR] = { 0x41034 },
+	[GCC_QUSB2_PHY_BCR] = { 0x4103c },
+	[GCC_USB_HS_PHY_CFG_AHB_BCR] = { 0x0000c, 1 },
+	[GCC_USB2A_PHY_BCR] = { 0x0000c, 0 },
+	[GCC_USB3_PHY_BCR] = { 0x39004 },
+	[GCC_USB_30_BCR] = { 0x39000 },
+	[GCC_USB3PHY_PHY_BCR] = { 0x39008 },
+	[GCC_PCIE_0_BCR] = { 0x3e000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
+	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
+	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
+	[GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
+	[GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
+	[GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
+	[GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
+	[GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
+	[GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
+	[GCC_EMAC_BCR] = { 0x4e000 },
+	[GCC_WDSP_RESTART] = {0x19000},
+};
+
+static const struct qcom_cc_data qcs404_gcc_data = {
+	.resets = qcs404_gcc_resets,
+	.num_resets = ARRAY_SIZE(qcs404_gcc_resets),
+};
+
+static const struct udevice_id gcc_qcs404_of_match[] = {
+	{
+		.compatible = "qcom,gcc-qcs404",
+		.data = (ulong)&qcs404_gcc_data
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_qcs404) = {
+	.name		= "gcc_qcs404",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_qcs404_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 95a057b82986..eab88a40c09d 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+
 #include "clock-qcom.h"
 
 #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
@@ -70,7 +71,7 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 	return f - 1;
 }
 
-static int clk_init_uart(struct msm_clk_priv *priv, uint rate)
+static int clk_init_uart(struct qcom_cc_priv *priv, uint rate)
 {
 	const struct freq_tbl *freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 
@@ -82,7 +83,7 @@ static int clk_init_uart(struct msm_clk_priv *priv, uint rate)
 
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
-	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP1_S1_CLK: /*UART2*/
@@ -96,3 +97,53 @@ int msm_enable(struct clk *clk)
 {
 	return 0;
 }
+
+static const struct qcom_reset_map sdm845_gcc_resets[] = {
+	[GCC_MMSS_BCR] = { 0xb000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_PRNG_BCR] = { 0x34000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_CARD_BCR] = { 0x75000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB30_SEC_BCR] = { 0x10000 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+};
+
+static const struct qcom_cc_data qcs404_gcc_data = {
+	.resets = sdm845_gcc_resets,
+	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
+};
+
+static const struct udevice_id gcc_sdm845_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sdm845",
+		.data = (ulong)&qcs404_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sdm845) = {
+	.name		= "gcc_sdm845",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sdm845_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 73bbd3069258..88e04d93f2a0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -156,13 +156,6 @@ config RESET_IMX7
 	help
 	  Support for reset controller on i.MX7/8 SoCs.
 
-config RESET_QCOM
-	bool "Reset driver for Qualcomm SoCs"
-	depends on DM_RESET && (ARCH_SNAPDRAGON || ARCH_IPQ40XX)
-	default y
-	help
-	  Support for reset controller on Qualcomm SoCs.
-
 config RESET_SIFIVE
 	bool "Reset Driver for SiFive SoC's"
 	depends on DM_RESET && CLK_SIFIVE_PRCI && (TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED)
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index e2239a250a3a..7b0066f80188 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_HISILICON) += reset-hisilicon.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
-obj-$(CONFIG_RESET_QCOM) += reset-qcom.o
 obj-$(CONFIG_RESET_SIFIVE) += reset-sifive.o
 obj-$(CONFIG_RESET_SYSCON) += reset-syscon.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
diff --git a/drivers/reset/reset-qcom.c b/drivers/reset/reset-qcom.c
deleted file mode 100644
index 94315e76d545..000000000000
--- a/drivers/reset/reset-qcom.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2020 Sartura Ltd.
- * Copyright (c) 2022 Linaro Ltd.
- *
- * Author: Robert Marko <robert.marko@sartura.hr>
- *         Sumit Garg <sumit.garg@linaro.org>
- *
- * Based on Linux driver
- */
-
-#include <asm/io.h>
-#include <common.h>
-#include <dm.h>
-#include <reset-uclass.h>
-#include <linux/bitops.h>
-#include <malloc.h>
-
-struct qcom_reset_priv {
-	phys_addr_t base;
-};
-
-struct qcom_reset_map {
-	unsigned int reg;
-	u8 bit;
-};
-
-#ifdef CONFIG_ARCH_IPQ40XX
-#include <dt-bindings/reset/qcom,ipq4019-reset.h>
-static const struct qcom_reset_map gcc_qcom_resets[] = {
-	[WIFI0_CPU_INIT_RESET] = { 0x1f008, 5 },
-	[WIFI0_RADIO_SRIF_RESET] = { 0x1f008, 4 },
-	[WIFI0_RADIO_WARM_RESET] = { 0x1f008, 3 },
-	[WIFI0_RADIO_COLD_RESET] = { 0x1f008, 2 },
-	[WIFI0_CORE_WARM_RESET] = { 0x1f008, 1 },
-	[WIFI0_CORE_COLD_RESET] = { 0x1f008, 0 },
-	[WIFI1_CPU_INIT_RESET] = { 0x20008, 5 },
-	[WIFI1_RADIO_SRIF_RESET] = { 0x20008, 4 },
-	[WIFI1_RADIO_WARM_RESET] = { 0x20008, 3 },
-	[WIFI1_RADIO_COLD_RESET] = { 0x20008, 2 },
-	[WIFI1_CORE_WARM_RESET] = { 0x20008, 1 },
-	[WIFI1_CORE_COLD_RESET] = { 0x20008, 0 },
-	[USB3_UNIPHY_PHY_ARES] = { 0x1e038, 5 },
-	[USB3_HSPHY_POR_ARES] = { 0x1e038, 4 },
-	[USB3_HSPHY_S_ARES] = { 0x1e038, 2 },
-	[USB2_HSPHY_POR_ARES] = { 0x1e01c, 4 },
-	[USB2_HSPHY_S_ARES] = { 0x1e01c, 2 },
-	[PCIE_PHY_AHB_ARES] = { 0x1d010, 11 },
-	[PCIE_AHB_ARES] = { 0x1d010, 10 },
-	[PCIE_PWR_ARES] = { 0x1d010, 9 },
-	[PCIE_PIPE_STICKY_ARES] = { 0x1d010, 8 },
-	[PCIE_AXI_M_STICKY_ARES] = { 0x1d010, 7 },
-	[PCIE_PHY_ARES] = { 0x1d010, 6 },
-	[PCIE_PARF_XPU_ARES] = { 0x1d010, 5 },
-	[PCIE_AXI_S_XPU_ARES] = { 0x1d010, 4 },
-	[PCIE_AXI_M_VMIDMT_ARES] = { 0x1d010, 3 },
-	[PCIE_PIPE_ARES] = { 0x1d010, 2 },
-	[PCIE_AXI_S_ARES] = { 0x1d010, 1 },
-	[PCIE_AXI_M_ARES] = { 0x1d010, 0 },
-	[ESS_RESET] = { 0x12008, 0},
-	[GCC_BLSP1_BCR] = {0x01000, 0},
-	[GCC_BLSP1_QUP1_BCR] = {0x02000, 0},
-	[GCC_BLSP1_UART1_BCR] = {0x02038, 0},
-	[GCC_BLSP1_QUP2_BCR] = {0x03008, 0},
-	[GCC_BLSP1_UART2_BCR] = {0x03028, 0},
-	[GCC_BIMC_BCR] = {0x04000, 0},
-	[GCC_TLMM_BCR] = {0x05000, 0},
-	[GCC_IMEM_BCR] = {0x0E000, 0},
-	[GCC_ESS_BCR] = {0x12008, 0},
-	[GCC_PRNG_BCR] = {0x13000, 0},
-	[GCC_BOOT_ROM_BCR] = {0x13008, 0},
-	[GCC_CRYPTO_BCR] = {0x16000, 0},
-	[GCC_SDCC1_BCR] = {0x18000, 0},
-	[GCC_SEC_CTRL_BCR] = {0x1A000, 0},
-	[GCC_AUDIO_BCR] = {0x1B008, 0},
-	[GCC_QPIC_BCR] = {0x1C000, 0},
-	[GCC_PCIE_BCR] = {0x1D000, 0},
-	[GCC_USB2_BCR] = {0x1E008, 0},
-	[GCC_USB2_PHY_BCR] = {0x1E018, 0},
-	[GCC_USB3_BCR] = {0x1E024, 0},
-	[GCC_USB3_PHY_BCR] = {0x1E034, 0},
-	[GCC_SYSTEM_NOC_BCR] = {0x21000, 0},
-	[GCC_PCNOC_BCR] = {0x2102C, 0},
-	[GCC_DCD_BCR] = {0x21038, 0},
-	[GCC_SNOC_BUS_TIMEOUT0_BCR] = {0x21064, 0},
-	[GCC_SNOC_BUS_TIMEOUT1_BCR] = {0x2106C, 0},
-	[GCC_SNOC_BUS_TIMEOUT2_BCR] = {0x21074, 0},
-	[GCC_SNOC_BUS_TIMEOUT3_BCR] = {0x2107C, 0},
-	[GCC_PCNOC_BUS_TIMEOUT0_BCR] = {0x21084, 0},
-	[GCC_PCNOC_BUS_TIMEOUT1_BCR] = {0x2108C, 0},
-	[GCC_PCNOC_BUS_TIMEOUT2_BCR] = {0x21094, 0},
-	[GCC_PCNOC_BUS_TIMEOUT3_BCR] = {0x2109C, 0},
-	[GCC_PCNOC_BUS_TIMEOUT4_BCR] = {0x210A4, 0},
-	[GCC_PCNOC_BUS_TIMEOUT5_BCR] = {0x210AC, 0},
-	[GCC_PCNOC_BUS_TIMEOUT6_BCR] = {0x210B4, 0},
-	[GCC_PCNOC_BUS_TIMEOUT7_BCR] = {0x210BC, 0},
-	[GCC_PCNOC_BUS_TIMEOUT8_BCR] = {0x210C4, 0},
-	[GCC_PCNOC_BUS_TIMEOUT9_BCR] = {0x210CC, 0},
-	[GCC_TCSR_BCR] = {0x22000, 0},
-	[GCC_MPM_BCR] = {0x24000, 0},
-	[GCC_SPDM_BCR] = {0x25000, 0},
-};
-#endif
-
-#ifdef CONFIG_TARGET_QCS404EVB
-#include <dt-bindings/clock/qcom,gcc-qcs404.h>
-static const struct qcom_reset_map gcc_qcom_resets[] = {
-	[GCC_GENI_IR_BCR] = { 0x0F000 },
-	[GCC_CDSP_RESTART] = { 0x18000 },
-	[GCC_USB_HS_BCR] = { 0x41000 },
-	[GCC_USB2_HS_PHY_ONLY_BCR] = { 0x41034 },
-	[GCC_QUSB2_PHY_BCR] = { 0x4103c },
-	[GCC_USB_HS_PHY_CFG_AHB_BCR] = { 0x0000c, 1 },
-	[GCC_USB2A_PHY_BCR] = { 0x0000c, 0 },
-	[GCC_USB3_PHY_BCR] = { 0x39004 },
-	[GCC_USB_30_BCR] = { 0x39000 },
-	[GCC_USB3PHY_PHY_BCR] = { 0x39008 },
-	[GCC_PCIE_0_BCR] = { 0x3e000 },
-	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
-	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
-	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
-	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
-	[GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
-	[GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
-	[GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
-	[GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
-	[GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
-	[GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
-	[GCC_EMAC_BCR] = { 0x4e000 },
-	[GCC_WDSP_RESTART] = {0x19000},
-};
-#endif
-
-static int qcom_reset_assert(struct reset_ctl *rst)
-{
-	struct qcom_reset_priv *priv = dev_get_priv(rst->dev);
-	const struct qcom_reset_map *reset_map = gcc_qcom_resets;
-	const struct qcom_reset_map *map;
-	u32 value;
-
-	map = &reset_map[rst->id];
-
-	value = readl(priv->base + map->reg);
-	value |= BIT(map->bit);
-	writel(value, priv->base + map->reg);
-
-	return 0;
-}
-
-static int qcom_reset_deassert(struct reset_ctl *rst)
-{
-	struct qcom_reset_priv *priv = dev_get_priv(rst->dev);
-	const struct qcom_reset_map *reset_map = gcc_qcom_resets;
-	const struct qcom_reset_map *map;
-	u32 value;
-
-	map = &reset_map[rst->id];
-
-	value = readl(priv->base + map->reg);
-	value &= ~BIT(map->bit);
-	writel(value, priv->base + map->reg);
-
-	return 0;
-}
-
-static const struct reset_ops qcom_reset_ops = {
-	.rst_assert = qcom_reset_assert,
-	.rst_deassert = qcom_reset_deassert,
-};
-
-static const struct udevice_id qcom_reset_ids[] = {
-	{ .compatible = "qcom,gcc-reset-ipq4019" },
-	{ .compatible = "qcom,gcc-reset-qcs404" },
-	{ }
-};
-
-static int qcom_reset_probe(struct udevice *dev)
-{
-	struct qcom_reset_priv *priv = dev_get_priv(dev);
-
-	priv->base = dev_read_addr(dev);
-	if (priv->base == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	return 0;
-}
-
-U_BOOT_DRIVER(qcom_reset) = {
-	.name = "qcom_reset",
-	.id = UCLASS_RESET,
-	.of_match = qcom_reset_ids,
-	.ops = &qcom_reset_ops,
-	.probe = qcom_reset_probe,
-	.priv_auto = sizeof(struct qcom_reset_priv),
-};

-- 
2.42.0

