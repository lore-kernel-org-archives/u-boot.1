Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2D5C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C292E87E9A;
	Mon, 26 Feb 2024 09:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dXWm201X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629B3879AF; Mon, 26 Feb 2024 09:05:35 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8BB87ECA
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e497a1481cso146247a34.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934729; x=1709539529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v2NmeX3oemJjoWNB7tmfRxuXxCl1IZnTl+BChyd5uo=;
 b=dXWm201Xeg/RJE+tHSicEUYW3vamxLS6Oi6QkEjQ4sWKpoa0150a/lYcrWZjKSEw08
 fY8m23TtGSIW+60j+myT3gx1yWxenuRckOQG/sOE1muVVh5qEVl/k52ELVFAnk7tG48c
 cKaus8NH06oQTmccE+a8wTflntM1CArgyAqQVBOdYEt9SKCQbYnm2hVLUY6TnwEi7QvZ
 /tSdPufTjMuHds6XSBSs5/KVDhN6kd6zdXR1/yRhNMUCO+z0Tr/OCiwINQGD495WGc5S
 FKlSmphjNr97IN4k/Sz3VpEDoi94PURzxc0SDDh1dJu4s2e91ntRNPL26SCpxP+YphXs
 siGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934729; x=1709539529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v2NmeX3oemJjoWNB7tmfRxuXxCl1IZnTl+BChyd5uo=;
 b=ICppU6Fv6OrekNiHYfGVA1fm8c6Vmm1p2GK4RmwYL4nkJKKPG1Dg0btMaCrCWs8Q59
 nZMzgTXN2SUGTGR1d5edhAgZIeN7JT6auqjlYHrzV9An5t8kLmQxyHcsdOAonjaNdQmO
 Wz8R7OJQ9l5nzFDNWHXYtO2ucoLHcN+hD2gCVCsXLS533Va42DidfD7bzsEE9qsnEQ3E
 Wy1OyKiGggT0qDoibdKgh/KJ1p+8UcOcXdaz14GTphL9tSRb/vSC+TTium9FDXxHdO/n
 3peC3A8kxa2X40EZqLURZviteGfgvUT7szSkt6VAWDIIVWZOvu5hfJ8N8jFqEcSr0Ido
 CuyA==
X-Gm-Message-State: AOJu0YztPzhAO5yN1Q8UBa8mkui9qhd3IWgDXNMUEFIWgrvFHL40D4ZE
 OG2zyRMyPNDM304Ye2FX4VrQTGMkTLbaZzC9wuekobBvisoCGEnxF0jAWW0tegDRUHkIBQ2NDoW
 V
X-Google-Smtp-Source: AGHT+IHL7dgrcwLbn0Yn+AtNMSCy7W6HugIHu67EYgjJsR6uauYPElwHKtcfXYaQt/fOAbJnMjkZBg==
X-Received: by 2002:a05:6358:7251:b0:17b:5635:454e with SMTP id
 i17-20020a056358725100b0017b5635454emr8152817rwa.32.1708934728824; 
 Mon, 26 Feb 2024 00:05:28 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:28 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 3/8] imx8mp: power-domain: Add PCIe support
Date: Mon, 26 Feb 2024 13:34:28 +0530
Message-Id: <20240226080433.3307154-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226080433.3307154-1-sumit.garg@linaro.org>
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
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

Add support for GPCv2 power domains and clock handling for PCIe and
PCIe PHY.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 101 ++++++++++++++++++++------
 1 file changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index e2d772c5ec78..58cc3f63bb56 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -16,48 +16,73 @@
 #define GPR_REG0		0x0
 #define  PCIE_CLOCK_MODULE_EN	BIT(0)
 #define  USB_CLOCK_MODULE_EN	BIT(1)
+#define  PCIE_PHY_APB_RST	BIT(4)
+#define  PCIE_PHY_INIT_RST	BIT(5)
 
 struct imx8mp_hsiomix_priv {
 	void __iomem *base;
 	struct clk clk_usb;
+	struct clk clk_pcie;
 	struct power_domain pd_bus;
 	struct power_domain pd_usb;
+	struct power_domain pd_pcie;
 	struct power_domain pd_usb_phy1;
 	struct power_domain pd_usb_phy2;
+	struct power_domain pd_pcie_phy;
 };
 
 static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 {
 	struct udevice *dev = power_domain->dev;
 	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
-	struct power_domain *domain;
+	struct power_domain *domain = NULL;
+	struct clk *clk = NULL;
+	u32 gpr_reg0_bits = 0;
 	int ret;
 
-	ret = power_domain_on(&priv->pd_bus);
-	if (ret)
-		return ret;
-
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
+	switch (power_domain->id) {
+	case IMX8MP_HSIOBLK_PD_USB:
 		domain = &priv->pd_usb;
-	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1) {
+		clk = &priv->clk_usb;
+		gpr_reg0_bits |= USB_CLOCK_MODULE_EN;
+		break;
+	case IMX8MP_HSIOBLK_PD_USB_PHY1:
 		domain = &priv->pd_usb_phy1;
-	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
+		break;
+	case IMX8MP_HSIOBLK_PD_USB_PHY2:
 		domain = &priv->pd_usb_phy2;
-	} else {
-		ret = -EINVAL;
-		goto err_pd;
+		break;
+	case IMX8MP_HSIOBLK_PD_PCIE:
+		domain = &priv->pd_pcie;
+		clk = &priv->clk_pcie;
+		gpr_reg0_bits |= PCIE_CLOCK_MODULE_EN;
+		break;
+	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
+		domain = &priv->pd_pcie_phy;
+		/* Bits to deassert PCIe PHY reset */
+		gpr_reg0_bits |= PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST;
+		break;
+	default:
+		dev_err(dev, "unknown power domain id: %ld\n",
+			power_domain->id);
+		return -EINVAL;
 	}
 
+	ret = power_domain_on(&priv->pd_bus);
+	if (ret)
+		return ret;
+
 	ret = power_domain_on(domain);
 	if (ret)
 		goto err_pd;
 
-	ret = clk_enable(&priv->clk_usb);
-	if (ret)
-		goto err_clk;
+	if (clk) {
+		ret = clk_enable(clk);
+		if (ret)
+			goto err_clk;
+	}
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
-		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
+	setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
 
 	return 0;
 
@@ -73,17 +98,31 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
 	struct udevice *dev = power_domain->dev;
 	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
+	switch (power_domain->id) {
+	case IMX8MP_HSIOBLK_PD_USB:
 		clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
-
-	clk_disable(&priv->clk_usb);
-
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
+		clk_disable(&priv->clk_usb);
 		power_domain_off(&priv->pd_usb);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1)
+		break;
+	case IMX8MP_HSIOBLK_PD_USB_PHY1:
 		power_domain_off(&priv->pd_usb_phy1);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
+		break;
+	case IMX8MP_HSIOBLK_PD_USB_PHY2:
 		power_domain_off(&priv->pd_usb_phy2);
+		break;
+	case IMX8MP_HSIOBLK_PD_PCIE:
+		clrbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
+		clk_disable(&priv->clk_pcie);
+		power_domain_off(&priv->pd_pcie);
+		break;
+	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
+		clrbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
+						    PCIE_PHY_INIT_RST);
+		power_domain_off(&priv->pd_pcie_phy);
+		break;
+	default:
+		break;
+	}
 
 	power_domain_off(&priv->pd_bus);
 
@@ -109,6 +148,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
+	if (ret < 0)
+		return ret;
+
 	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
 	if (ret < 0)
 		return ret;
@@ -125,8 +168,20 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_pd_usb_phy2;
 
+	ret = power_domain_get_by_name(dev, &priv->pd_pcie, "pcie");
+	if (ret < 0)
+		goto err_pd_pcie;
+
+	ret = power_domain_get_by_name(dev, &priv->pd_pcie_phy, "pcie-phy");
+	if (ret < 0)
+		goto err_pd_pcie_phy;
+
 	return 0;
 
+err_pd_pcie_phy:
+	power_domain_free(&priv->pd_pcie);
+err_pd_pcie:
+	power_domain_free(&priv->pd_usb_phy2);
 err_pd_usb_phy2:
 	power_domain_free(&priv->pd_usb_phy1);
 err_pd_usb_phy1:
-- 
2.34.1

