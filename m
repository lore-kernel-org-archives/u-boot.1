Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ADC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B46487C7F;
	Thu, 21 Mar 2024 16:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="luLjp1Nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7F287D4F; Thu, 21 Mar 2024 16:02:27 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DBB866E8
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-609ed7ca444so10808847b3.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711033344; x=1711638144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW6qYNm21G5ooadcXHxvbFWY7L8jFYvMsUqA95CayFw=;
 b=luLjp1NwzO7IZu4DzkbggJkUoWSvdQGdB+fE95QL2IrtB5lvEvXbz56ZyjpxnqMGGy
 X4CUBdSaO+JhOUoy9+/mJ1tCPFaZKJ7ktUFD40NRXIJUFfNn27hxP/g23r+x20aIgkq9
 8Ay7T+qvRFA5d/Orma/u0geITZxTyYRnrqycRyxc9o1+7JE00fHO/DEdYxUdI1q5gnms
 3qC9ayWN4eJbRLUYMKO6VYdKDLMsSivtUM6AjF22C2XaoTLx+tvZ0zBi0wimeZZq3MmS
 CC23HwPSBC5PiCWUR+bwFICoEz5MEbiSRLwMhkLgKOoTy0jlYS9vBFCml5z/o6oAaJzP
 iX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711033344; x=1711638144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pW6qYNm21G5ooadcXHxvbFWY7L8jFYvMsUqA95CayFw=;
 b=ersg+gS4q6Jon3NRWwet5Ec1LgnQoo+na06YZ+ypHWSUtPWm/g4lzBYbO4QJXhIcgM
 BZefeJBD3eKh6w8V5hHtzyjrRba2vc9O//p1usl5COvuM2BH4iuZY9/tBaQLGIdZ7U/h
 3eJ4scFdSXqN/UwBXJskLvD99r92aDh07OD9sJY922c9doC3psCgz1qL0A7TRUH4w75d
 VjrwsNdx9e69MDTXtIjHxSJGk3df6moKSLC+2Ycrlz/lgkk0CRPgQvaAdVV8mg16P7d7
 lu0xDUlFhyqIikH+6HIKfN6bOsTtQS+TWpW5Js/viKuKDexY7eMY8ywyl6iF3Vi7wd0J
 M/Yw==
X-Gm-Message-State: AOJu0Yyj8Aa8ZttvHlS3k83WLQHMgzU6gq1191Yfk/Tbd++koO0AqPNJ
 yG9u3aZulgeXXzuPDJ/eLHboZR0On659HhztWud2zXU5Oc0gtX06+zBqyLTbSEzbbUZ1trL9k4G
 S
X-Google-Smtp-Source: AGHT+IH/oktlJaPu+eeyPv9SnKsHOd0ncMRad0Nxg+HUXjv7iu1ub5Yxb+nJJ7ohYA+1df7xn5GMbA==
X-Received: by 2002:a05:6a21:788d:b0:1a3:6c9e:1e2b with SMTP id
 bf13-20020a056a21788d00b001a36c9e1e2bmr2451731pzc.14.1711032946734; 
 Thu, 21 Mar 2024 07:55:46 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:55:46 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 04/11] imx8mp: power-domain: Add PCIe support
Date: Thu, 21 Mar 2024 20:25:00 +0530
Message-Id: <20240321145507.619448-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 117 +++++++++++++++++---------
 1 file changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index e2d772c5ec7..d3b0c1146ce 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -16,48 +16,85 @@
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
 
-static int imx8mp_hsiomix_on(struct power_domain *power_domain)
+static int imx8mp_hsiomix_set(struct power_domain *power_domain, bool power_on)
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
 
-	ret = power_domain_on(domain);
-	if (ret)
-		goto err_pd;
+	if (power_on) {
+		ret = power_domain_on(&priv->pd_bus);
+		if (ret)
+			return ret;
 
-	ret = clk_enable(&priv->clk_usb);
-	if (ret)
-		goto err_clk;
+		ret = power_domain_on(domain);
+		if (ret)
+			goto err_pd;
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
-		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
+		if (clk) {
+			ret = clk_enable(clk);
+			if (ret)
+				goto err_clk;
+		}
+
+		if (gpr_reg0_bits)
+			setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
+	} else {
+		if (gpr_reg0_bits)
+			clrbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
+
+		if (clk)
+			clk_disable(clk);
+
+		power_domain_off(domain);
+		power_domain_off(&priv->pd_bus);
+	}
 
 	return 0;
 
@@ -68,26 +105,14 @@ err_pd:
 	return ret;
 }
 
-static int imx8mp_hsiomix_off(struct power_domain *power_domain)
+static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 {
-	struct udevice *dev = power_domain->dev;
-	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
-
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
-		clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
-
-	clk_disable(&priv->clk_usb);
-
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
-		power_domain_off(&priv->pd_usb);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1)
-		power_domain_off(&priv->pd_usb_phy1);
-	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
-		power_domain_off(&priv->pd_usb_phy2);
-
-	power_domain_off(&priv->pd_bus);
+	return imx8mp_hsiomix_set(power_domain, true);
+}
 
-	return 0;
+static int imx8mp_hsiomix_off(struct power_domain *power_domain)
+{
+	return imx8mp_hsiomix_set(power_domain, false);
 }
 
 static int imx8mp_hsiomix_of_xlate(struct power_domain *power_domain,
@@ -109,6 +134,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
+	if (ret < 0)
+		return ret;
+
 	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
 	if (ret < 0)
 		return ret;
@@ -125,8 +154,20 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
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

