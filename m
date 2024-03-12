Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7BBC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECAC87F30;
	Tue, 12 Mar 2024 08:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qwxkRLBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FDC86D73; Tue, 12 Mar 2024 08:04:27 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E823087F37
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so42306705ad.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227063; x=1710831863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CDHordFaK4Mt/dWhcCKekB74V+A1Wh+ipx1UWz/eYQ=;
 b=qwxkRLBuJxRdtNVZ1EfQACuhFjJ88KcMTgwkEABC5yCs3nHhqoOHlxTWrIWddQPSej
 Kxv21w2ILLBeAuxJumMiQlz4lphz0P85oyUEwH0cbS+7fe+WgP/MHe1NdPO/4CgRcx+V
 EKTIgaoZK50REsSqhFo9o4djTvA8PQmK58dD2eH645M+/nodLHscdKxYddM3O8vJbqk1
 ELBsTdMKNne5Que654gFbL9OZoHRJaMG+VVynu6gbSsMyBrKyAAJk/Zy/K8coxNWtLV7
 YIIYqoyGL6SrGZjod62Vd7U74fnP+sfE73WJdoDI2hPSEpNCCmieG5RIDomDn1oUGBxi
 XmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227063; x=1710831863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CDHordFaK4Mt/dWhcCKekB74V+A1Wh+ipx1UWz/eYQ=;
 b=kds28ww6WYTNY09dyvfuypkXq+Or0mAXiUDXCG5d/c0ui75t69REBwQo1+6t+JEtKx
 noD/rLJukFFmpgqx9QkfElG90jDUZzFrhYeZt8evU7OgObHr1YhRF0M7PM7KMWhvC7ln
 6zt7JnU1QhWHDvKKNTquAG5D/IxQ+n5F9/Nc+lCl+9lOqDi+G/7m+9kvmutRRD3ywlv+
 pyRR5GEYFDfqb/Bw7D7RubOilTwk4z8ag7Sm237dX81BO3kUeCej/EXu+v/D/Gi1SQGZ
 bRWWW6pffZ9odqW+pGl4R7Fk+Dxv6K+C4v2vgoDLcwolGc27OtTUxkxgWW+og3r4/Hda
 NwqA==
X-Gm-Message-State: AOJu0YzNkL1eOmiELcHqO8cDGVMBtfQRzc80k9y+3MOyGW1ttQgCxeDC
 ph1lw/z9QSdDfM/pZCWMWNGPzSnVohlxMnhO+bkh1OPgvLe+xxAnEnedKyRL0UeqM1rpjuDih31
 A
X-Google-Smtp-Source: AGHT+IGlj7gtDGzBd7NuEjQwKnTAHIiC9EX0/8eKbwxTMQtD5pxo+oyJcW7ZiwvxJQLidhDEcikTVw==
X-Received: by 2002:a17:902:bd49:b0:1dc:3e49:677d with SMTP id
 b9-20020a170902bd4900b001dc3e49677dmr7883686plx.26.1710227063037; 
 Tue, 12 Mar 2024 00:04:23 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:22 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 05/11] imx8mp: power-domain: Add PCIe support
Date: Tue, 12 Mar 2024 12:33:32 +0530
Message-Id: <20240312070338.86127-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 114 ++++++++++++++++++--------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 448746432a2..fb8041749ec 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -16,48 +16,84 @@
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
-		return ret;
+	if (power_on) {
+		ret = power_domain_on(&priv->pd_bus);
+		if (ret)
+			return ret;
+
+		ret = power_domain_on(domain);
+		if (ret)
+			return ret;
+
+		if (clk) {
+			ret = clk_enable(clk);
+			if (ret)
+				goto err_clk;
+		}
 
-	ret = clk_enable(&priv->clk_usb);
-	if (ret)
-		goto err_clk;
+		if (gpr_reg0_bits)
+			setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
+	} else {
+		power_domain_off(domain);
+
+		if (clk)
+			clk_disable(clk);
 
-	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
-		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
+		if (gpr_reg0_bits)
+			clrbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
+	}
 
 	return 0;
 
@@ -66,24 +102,14 @@ err_clk:
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
+	return imx8mp_hsiomix_set(power_domain, true);
+}
 
-	return 0;
+static int imx8mp_hsiomix_off(struct power_domain *power_domain)
+{
+	return imx8mp_hsiomix_set(power_domain, false);
 }
 
 static int imx8mp_hsiomix_of_xlate(struct power_domain *power_domain,
@@ -105,6 +131,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
+	if (ret < 0)
+		return ret;
+
 	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
 	if (ret < 0)
 		return ret;
@@ -121,8 +151,20 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
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

