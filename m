Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6DC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFF587F9B;
	Tue, 20 Feb 2024 14:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v1jko5st";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3ECF87F9B; Tue, 20 Feb 2024 14:36:20 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCBD87D72
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5a00b5e78adso11988eaf.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436163; x=1709040963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noORKPFv+rQdtdH/NhcKa9ybSVdfJgbtV5xfDHrUIjs=;
 b=v1jko5stxsd7k01ApfxuvciLLeA6ESGHFsCmvzuCFEbp06FA5gLjbGQNbEkiFWIVBf
 AxGREtVS+PKNys1vH8y7dhiCycqY/w8D2k92i1Sv/uMekT4c0XgP5hAVARCmoXHnFZAJ
 lZWCLy036deJEXFegNKATdW/0AXjvuXxHEdmG/9XOdYF0UJtq6lgrjKsJ6EvM7jnJfxK
 1/WzqPkIMdhIDBwSWP5XYly6eCtD6P7vwW2I17BiO4eWJ3kPGHOtiSO0LB9TnuBDIdqt
 Az0HTN4N2dPh7OIUYOtvx41DqgPfdageoJuXmgsadB6d3iyZsqAZ/Tf3O29sa0Sxa0L4
 IHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436163; x=1709040963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noORKPFv+rQdtdH/NhcKa9ybSVdfJgbtV5xfDHrUIjs=;
 b=ZpM9Thfoq35rWRIhgxRuIl+kZJxgtQxPeZaY4YUYOXumkTuasOOkUoshsvF8MMJofn
 N04iwR63NL9VFwxMWLLciwiHYDY2PTF46govOgE1tJQ7mozUni5E8fpwq65fmJherJuo
 71FS7sacne3+c1JE9bQ2EswJFRPVdHkvjYiT++ilOh/Bbe/FRUxR/4jEndaHJSBLl75v
 dWw7NCp83FSw8XBdra/SNPJCPzJ9vbMUrC+NexqKKC+yUUwCgROUYvuxDSI70BxDQRZi
 lMlhWOuAcqPR8btfpx+Uxv1iSeZehUucIH2LhArtlLEglju11WQDWrYNfcEARbesMaXz
 Y+vw==
X-Gm-Message-State: AOJu0YzOvQhfC3nsvcdiKilpnyZ6Xe89G1taFJmD73TYmDzUoi5SoQ3q
 Zzb6XBBMWKqhFSgonUWEhn+OvhutCviiD9NQ61lSVfKq0+dQaxD9e4zF2PtOeT8xOrbpXqqt/2n
 g
X-Google-Smtp-Source: AGHT+IE9Gv4oailSbB78RYzCW1edC6gGrCtxruCDGYaiyFhziBWQsBXM3gCJhOkY2G7uVcOJ8uisvg==
X-Received: by 2002:a05:6a00:4e57:b0:6e4:5a4a:cea4 with SMTP id
 gu23-20020a056a004e5700b006e45a4acea4mr5349821pfb.19.1708434693808; 
 Tue, 20 Feb 2024 05:11:33 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:33 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 4/7] imx8mp: power-domain: Expose high performance PLL clock
Date: Tue, 20 Feb 2024 18:40:53 +0530
Message-Id: <20240220131056.2962331-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220131056.2962331-1-sumit.garg@linaro.org>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

PCIe PHY can use it when there is no external refclock provided.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 79 +++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 62145e0261b..4cefe642724 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -9,6 +9,8 @@
 #include <dm.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <power-domain-uclass.h>
 
 #include <dt-bindings/power/imx8mp-power.h>
@@ -18,6 +20,15 @@
 #define  USB_CLOCK_MODULE_EN	BIT(1)
 #define  PCIE_PHY_APB_RST	BIT(4)
 #define  PCIE_PHY_INIT_RST	BIT(5)
+#define GPR_REG1		0x4
+#define  PLL_LOCK		BIT(13)
+#define GPR_REG2		0x8
+#define  P_PLL_MASK		GENMASK(5, 0)
+#define  M_PLL_MASK		GENMASK(15, 6)
+#define  S_PLL_MASK		GENMASK(18, 16)
+#define GPR_REG3		0xc
+#define  PLL_CKE		BIT(17)
+#define  PLL_RST		BIT(31)
 
 struct imx8mp_hsiomix_priv {
 	void __iomem *base;
@@ -31,6 +42,53 @@ struct imx8mp_hsiomix_priv {
 	struct power_domain pd_pcie_phy;
 };
 
+static int hsio_pll_enable(struct udevice *dev)
+{
+	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
+	unsigned long start;
+	u32 val;
+
+	/* Setup HSIO PLL */
+	val = readl(priv->base + GPR_REG2);
+	val &= ~(P_PLL_MASK | M_PLL_MASK | S_PLL_MASK);
+	val |= (FIELD_PREP(P_PLL_MASK, 12) | FIELD_PREP(M_PLL_MASK, 800) |
+		FIELD_PREP(S_PLL_MASK, 4));
+	writel(val, priv->base + GPR_REG2);
+
+	/* de-assert PLL reset */
+	setbits_le32(priv->base + GPR_REG3, PLL_RST);
+
+	/* enable PLL */
+	setbits_le32(priv->base + GPR_REG3, PLL_CKE);
+
+	/* Check if PLL is locked */
+	start = get_timer(0);
+	for (;;) {
+		if (readl(priv->base + GPR_REG1) & PLL_LOCK)
+			break;
+
+		if (get_timer(start) > 100) {
+			dev_err(dev, "failed to lock HSIO PLL\n");
+			return -ETIMEDOUT;
+		}
+
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static void hsio_pll_disable(struct udevice *dev)
+{
+	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
+
+	/* de-assert PLL reset */
+	clrbits_le32(priv->base + GPR_REG3, PLL_RST);
+
+	/* enable PLL */
+	clrbits_le32(priv->base + GPR_REG3, PLL_CKE);
+}
+
 static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 {
 	struct udevice *dev = power_domain->dev;
@@ -69,16 +127,23 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 	if (ret)
 		goto err_clk_pcie;
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
+	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
 		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
 		setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
 		setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
 						    PCIE_PHY_INIT_RST);
 
+		ret = hsio_pll_enable(dev);
+		if (ret)
+			goto err_hsio_pll;
+	}
+
 	return 0;
 
+err_hsio_pll:
+	clk_disable(&priv->clk_pcie);
 err_clk_pcie:
 	clk_disable(&priv->clk_usb);
 err_clk_usb:
@@ -93,13 +158,15 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
 	struct udevice *dev = power_domain->dev;
 	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
+	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
 		clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
 		clrbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
 		clrbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
 						    PCIE_PHY_INIT_RST);
+		hsio_pll_disable(dev);
+	}
 
 	clk_disable(&priv->clk_usb);
 	clk_disable(&priv->clk_pcie);
-- 
2.34.1

