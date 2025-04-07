Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472B2C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2CF82E03;
	Mon,  7 Apr 2025 11:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hLZFVOnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDE082D88; Mon,  7 Apr 2025 11:54:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2353982E17
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so6780512a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019683; x=1744624483; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J92mYHRRZGnvseno+Wvln+plCFJyZE3osYgrubq4dAw=;
 b=hLZFVOnjR1bXyqzZMSpn/yXuu8SaD79Fs7YsWrdiqadfSOuJ6JzTdGfNsO1a21Lob7
 isrjA/HGYVCaX6cbwWpJj1JDDUUDZVrjtu13MnVpgw6IYZ20oAI0xl4R9QnFVTzCQTOJ
 hb43hpgVoNK2vDoXVUQhBEIlFSe2z2XaeGXixGFI96Ew2HAMH66U/l/OvxRRrBLi2ReB
 6Dx4MXuxdCOa4nSjKTSkryhQ5UCPC3SGXvdV+0euMy4m0/EC+/qHQHTiSE0mdz8To5ZA
 xjbgp/pGRn2nZJ+46JPjZGZ2G0aRhOcuOYxLLW8o3LAjwfhiF4ej1NFBZsh01wW0r6Kp
 Y1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019683; x=1744624483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J92mYHRRZGnvseno+Wvln+plCFJyZE3osYgrubq4dAw=;
 b=f5wlxTHsZGOalpXmv8VE+7lnWoqgOMsc6H51KoacemKqfUUWwV77Tj2ZEOzmjbHuDl
 Ri+3Q/zex07vkwgJgT8uj2H6wAgp5cs1LadARrJ/10dINnzio3xtVFUbtOnnsNkt1L9T
 Skla+MzxQn05l3C+gKeWbER+GyRJm2kkx4XMo5qWJO3sVRriHrpDn8By8/40Nuv8WW9k
 MU3eMg/I+XkKpNOnS+PcvxftAgnwo0cUy8zCZeGDr6i2pNREJdWbJZBfcoHzrO3pVyzf
 NbLQ8ygx3fQlL8etmLw9iDgsw2QDSq8yLiaMqyvyAMfoFh84SLyI8xxolgS6UDvyVHtU
 G2Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXAtdtFi4/hltEH7KftZkn5//PO+HrDsygH9I97RrU+PJxc4FOS8KLg8RBGEFo/30w2Mt9vDM=@lists.denx.de
X-Gm-Message-State: AOJu0YwHU9KZX+6I+E/3+Fm1TgeOTcbd+vlfUpdJljzL8SoMZXcJYbxt
 g6lQMmGbfxOc9WiAiWx2XvahgqcbwfT5iH6loEWVIz6RzX2yLMYliuCy4+izkfl7LusmSiMeQ2n
 W
X-Gm-Gg: ASbGncsH/FCs135Z9g5c6WRNEZEq24gr2JvyJlgPwprGLavb5zl1KtWAdrc/0bboRo7
 sxjQnl7cDCbpWTNMLgJ0ZeXxBvkaNO7nxqKOPq5JQxJNmu3y4MouBSObkDzBhae5ctenn+fAD88
 NYLCW6E1TfsOdaBEtt0aeRUVEFjY3JCQ8KIdykG5R10xVtBcodPuKc2IM2b78utdBK06cvqpIJW
 EIVutIIG+x1TF7K9JUmW1DuMpvYQZ30AR8u8mmLM0AUegtW/n8CC3fLAHh2Y1bdmSBi766XdYl3
 5DNzL4WOCtw5fYNP6yaGB9w+AIZXMxHlED/FpjZgV6qOYlH3sNtOmw/e1ZuI8q3Kgnf2
X-Google-Smtp-Source: AGHT+IHt94XroP6GtWlNf/YpulqARJr5S3/oGrLtzX16h96cHxkQD/EAZwTJ3h8m3sZjy90sQOi3ZQ==
X-Received: by 2002:a17:906:dc8b:b0:ac7:81bd:60e3 with SMTP id
 a640c23a62f3a-ac7d18bd2d1mr1079687966b.27.1744019683530; 
 Mon, 07 Apr 2025 02:54:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:43 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:26 +0200
Subject: [PATCH 6/6] usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-6-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The UCLASS_USB device is removed and rebound each time you run "usb stop"
followed by "usb start", or when you switch between USB device and USB host
mode. Unfortunately, this causes issues with the current ehci-msm driver:

In ehci_usb_remove() we call generic_shutdown_phy(), but at that point the
ULPI PHY we registered in ehci_usb_of_bind() was already removed again by
the DM core.

Fix this by adding a UCLASS_NOP driver that keeps the PHY driver bound
permanently, and then just re-probe the actual USB part.

Reported-by: Jianfeng Zhu <JianfengA.Zhu@sony.com>
Closes: https://lore.kernel.org/u-boot/OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com/
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 107 +++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 659a917ad27372f8f5c7138c40881b60413323e5..8aeb6a915563453ad2a02721d4828fd1b300a4e4 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -25,6 +25,9 @@ struct msm_ehci_priv {
 	struct ehci_ctrl ctrl; /* Needed by EHCI */
 	struct usb_ehci *ehci; /* Start of IP core*/
 	struct phy phy;
+};
+
+struct qcom_ci_hdrc_priv {
 	struct clk_bulk clks;
 };
 
@@ -54,34 +57,20 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
-	ret = clk_get_bulk(dev, &p->clks);
-	if (ret && (ret != -ENOSYS && ret != -ENOENT)) {
-		dev_err(dev, "Failed to get clocks: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_enable_bulk(&p->clks);
-	if (ret)
-		goto cleanup_clocks;
-
 	hccr = (struct ehci_hccr *)((phys_addr_t)&ehci->caplength);
 	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
 			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
 
 	ret = generic_setup_phy(dev, &p->phy, 0, PHY_MODE_USB_HOST, 0);
 	if (ret)
-		goto cleanup_clocks;
+		return ret;
 
 	ret = board_usb_init(0, plat->init_type);
 	if (ret < 0)
-		goto cleanup_clocks;
+		return ret;
 
 	return ehci_register(dev, hccr, hcor, &msm_ehci_ops, 0,
 			     plat->init_type);
-
-cleanup_clocks:
-	clk_release_bulk(&p->clks);
-	return ret;
 }
 
 static int ehci_usb_remove(struct udevice *dev)
@@ -101,7 +90,6 @@ static int ehci_usb_remove(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_release_bulk(&p->clks);
 	return 0;
 }
 
@@ -117,24 +105,6 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static int ehci_usb_of_bind(struct udevice *dev)
-{
-	ofnode ulpi_node = ofnode_first_subnode(dev_ofnode(dev));
-	ofnode phy_node;
-
-	if (!ofnode_valid(ulpi_node))
-		return 0;
-
-	phy_node = ofnode_first_subnode(ulpi_node);
-	if (!ofnode_valid(phy_node)) {
-		printf("%s: ulpi subnode with no phy\n", __func__);
-		return -ENOENT;
-	}
-
-	return device_bind_driver_to_node(dev, "msm8916_usbphy", "msm8916_usbphy",
-					  phy_node, NULL);
-}
-
 #if defined(CONFIG_CI_UDC)
 /* Little quirk that MSM needs with Chipidea controller
  * Must reinit phy after reset
@@ -147,17 +117,10 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
 }
 #endif
 
-static const struct udevice_id ehci_usb_ids[] = {
-	{ .compatible = "qcom,ci-hdrc", },
-	{ }
-};
-
 U_BOOT_DRIVER(usb_ehci) = {
 	.name	= "ehci_msm",
 	.id	= UCLASS_USB,
-	.of_match = ehci_usb_ids,
 	.of_to_plat = ehci_usb_of_to_plat,
-	.bind = ehci_usb_of_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
@@ -165,3 +128,63 @@ U_BOOT_DRIVER(usb_ehci) = {
 	.plat_auto	= sizeof(struct usb_plat),
 	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
 };
+
+static int qcom_ci_hdrc_probe(struct udevice *dev)
+{
+	struct qcom_ci_hdrc_priv *p = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &p->clks);
+	if (ret && (ret != -ENOSYS && ret != -ENOENT)) {
+		dev_err(dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	return clk_enable_bulk(&p->clks);
+}
+
+static int qcom_ci_hdrc_remove(struct udevice *dev)
+{
+	struct qcom_ci_hdrc_priv *p = dev_get_priv(dev);
+
+	return clk_release_bulk(&p->clks);
+}
+
+static int qcom_ci_hdrc_bind(struct udevice *dev)
+{
+	ofnode ulpi_node = ofnode_first_subnode(dev_ofnode(dev));
+	ofnode phy_node;
+	int ret;
+
+	ret = device_bind_driver_to_node(dev, "ehci_msm", "ehci_msm",
+					 dev_ofnode(dev), NULL);
+	if (ret)
+		return ret;
+
+	if (!ofnode_valid(ulpi_node))
+		return 0;
+
+	phy_node = ofnode_first_subnode(ulpi_node);
+	if (!ofnode_valid(phy_node)) {
+		printf("%s: ulpi subnode with no phy\n", __func__);
+		return -ENOENT;
+	}
+
+	return device_bind_driver_to_node(dev, "msm8916_usbphy", "msm8916_usbphy",
+					  phy_node, NULL);
+}
+
+static const struct udevice_id qcom_ci_hdrc_ids[] = {
+	{ .compatible = "qcom,ci-hdrc", },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_ci_hdrc) = {
+	.name		= "qcom_ci_hdrc",
+	.id		= UCLASS_NOP,
+	.of_match	= qcom_ci_hdrc_ids,
+	.bind		= qcom_ci_hdrc_bind,
+	.probe		= qcom_ci_hdrc_probe,
+	.remove		= qcom_ci_hdrc_remove,
+	.priv_auto	= sizeof(struct qcom_ci_hdrc_priv),
+};

-- 
2.47.2

