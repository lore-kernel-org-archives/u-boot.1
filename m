Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEA1C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B679887D83;
	Tue, 20 Feb 2024 14:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ur64snZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222D187EB8; Tue, 20 Feb 2024 14:37:40 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B32C87D74
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42c78ba62aaso35506021cf.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436249; x=1709041049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHiPWeM5HzUQQbb3RGpIJlC/3ayaPSo9JHbqnDY7yZ8=;
 b=ur64snZSKIzje02AhKXvI/Af/XkQmDFgtGAdt58cmTJFz97dg+AslQsO8ynMJjxuzq
 WunszE19d/RZl1CdBMn5nLu40lNzv6iMuqHczPiv8rxG1GZ/+cK3OJT99Mldpm0gBX9E
 nOvKQGQQUZhdbDWIXJsxbCV95SUUBPcvD5/Gi9C98PTnm7lS4vV85Jg7scl78KAG2J3h
 llDgsDF4JMzWmnWOg+Auk8J8r8MT8yvctT7SKn0S/8ZskT81h3XvE3SsQylC371RG3nO
 RiIL49Slr0VkpQBkbooqMgBSk7m90EKWFv9R/7GPsN7n3s3S6heKDZbdCOrPpXNg+6Qr
 a16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436249; x=1709041049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHiPWeM5HzUQQbb3RGpIJlC/3ayaPSo9JHbqnDY7yZ8=;
 b=Op1pUfsYKwaSrJ+61PsNhN2HxHskvkQLJtMFZQjtmXk77Zc0BW1loGP2nF21F/FVSy
 uFEDxcck3vxIYvKQ9W2CJi24ZHNkIdhAzxpNhSwDywOeAdHr6v6GceDzI6f7asa+0Sdw
 ympS/SDieoBncHzMk6YP78QVhNzH0N4uwHcPnkIGrfro6Zo0ucWaPoDAZdQa5CeIIc17
 FyYfrf+FaTaNoH2ATJXmrVLX7fTwRLqWE3l0xGi6mVo8R/dS5q4ED9YQuNhuoF6OEZHs
 iI39hcTA7Ri4KiBeoOiNjsbtDkn5hxl9UmVlCnA4C0tlyiI0LUxWZ7IMD3dCSikVHi2n
 T6tg==
X-Gm-Message-State: AOJu0YzQVsPbKgLkMlbLHOmJi7Dqa8wXM6GO5ZRj3wtlId0qkiMaShEm
 kQaRhbff7YEZGXG3f30pO3W6cmVfNXKJqbVJ2pOmk1a/CsbvJHdKEgcggjaOBz4xwg3dRqcY2VN
 l
X-Google-Smtp-Source: AGHT+IGWrHkZqVv1Vu3QL8URlDtLdTnStYZSxECcfEOvjhuA06CY6bItDEI7jKPhI+y/XLnTCJ7eWQ==
X-Received: by 2002:aa7:8212:0:b0:6e1:e4c:7978 with SMTP id
 k18-20020aa78212000000b006e10e4c7978mr12621498pfi.31.1708434688316; 
 Tue, 20 Feb 2024 05:11:28 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:28 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 3/7] imx8mp: power-domain: Add PCIe support
Date: Tue, 20 Feb 2024 18:40:52 +0530
Message-Id: <20240220131056.2962331-4-sumit.garg@linaro.org>
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

Pre-requisite to enable PCIe support on iMX8MP SoC.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 50 +++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index e2d772c5ec7..62145e0261b 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -16,14 +16,19 @@
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
@@ -43,6 +48,10 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 		domain = &priv->pd_usb_phy1;
 	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
 		domain = &priv->pd_usb_phy2;
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
+		domain = &priv->pd_pcie;
+	} else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
+		domain = &priv->pd_pcie_phy;
 	} else {
 		ret = -EINVAL;
 		goto err_pd;
@@ -54,14 +63,25 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
 
 	ret = clk_enable(&priv->clk_usb);
 	if (ret)
-		goto err_clk;
+		goto err_clk_usb;
+
+	ret = clk_enable(&priv->clk_pcie);
+	if (ret)
+		goto err_clk_pcie;
 
 	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
 		setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
+		setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
+		setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
+						    PCIE_PHY_INIT_RST);
 
 	return 0;
 
-err_clk:
+err_clk_pcie:
+	clk_disable(&priv->clk_usb);
+err_clk_usb:
 	power_domain_off(domain);
 err_pd:
 	power_domain_off(&priv->pd_bus);
@@ -75,8 +95,14 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
 
 	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
 		clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
+		clrbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
+		clrbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
+						    PCIE_PHY_INIT_RST);
 
 	clk_disable(&priv->clk_usb);
+	clk_disable(&priv->clk_pcie);
 
 	if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
 		power_domain_off(&priv->pd_usb);
@@ -84,6 +110,10 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
 		power_domain_off(&priv->pd_usb_phy1);
 	else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
 		power_domain_off(&priv->pd_usb_phy2);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
+		power_domain_off(&priv->pd_usb_phy2);
+	else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
+		power_domain_off(&priv->pd_usb_phy2);
 
 	power_domain_off(&priv->pd_bus);
 
@@ -109,6 +139,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
+	if (ret < 0)
+		return ret;
+
 	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
 	if (ret < 0)
 		return ret;
@@ -125,8 +159,20 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
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

