Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0228C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D70887EB7;
	Mon, 26 Feb 2024 09:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wnwsUeNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0583F87EA7; Mon, 26 Feb 2024 09:05:43 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C8A87EB2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e435542d41so1580680b3a.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934735; x=1709539535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=We+fvmTIWTWost47vKSyC3bkS9Lb+gyVjLQt2bCVGyA=;
 b=wnwsUeNdAOFRxylbrpV4ZEQescFfx7u0SdDiuAtCGKOjKijmBo0I77E08ZbIc7/+if
 fEBTJyv3RPsW4e2pHucKPPUvFANVKUX3ct2++Tqa2qNBWWHTL1XZ+JMNAUc1k16XVDlV
 wtgI85wpS4lwl7dm0tQ+b+FB/Nv9sH3FaMz3cIDKzcWcm5q2ZbQNd+7b6cSBVeu/Sl1M
 Pr6ftu3p5WTeip/RXoM23s5LoCiJMTrvV/0jToujg0SIRBSUNKXteHustLq0oazNvCMl
 ILVe1p7ipGY4Gu9PazKzdr1jPq//PovtkeBe0221/Rb1Cdo6JuyspYnE7nxqoCjMdLq8
 w3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934735; x=1709539535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=We+fvmTIWTWost47vKSyC3bkS9Lb+gyVjLQt2bCVGyA=;
 b=Bytp1Jb5RGMn5JX1+jKVeAO3HT+JpYTJAwmUiZkwzpwlydVwtbFnmMWEdw4JEo/yWb
 FbugvM5szq5JrgkOHTXXkP6+xdmNlsKmUcMt/EgF73KaQ/FiptsToTzz21gmDc2NqAdI
 930/NDPo418ivGrbXcJ97ilKH2NrwlA/1xq91//9oXrREseCunnRxGDjwEqU7vmS+5aF
 XJJmtNKF3BTlMzxByh4Jm+DAMJGstHMm28d17a/5I3gWpY83QP135wsVJ4OsoGk8ynDB
 b48PLHkMgDgDLH9qtzEKK/OhSKTtY5XOOr9FAaNTqz8tXnhvEZI1knUO7X0YLF0Sno1m
 +L/A==
X-Gm-Message-State: AOJu0YwvOguIO1cLtc1heeWuEzUF7tyw0mILWTA5jYTw+x6eD9cEcWk+
 3k56YVu0NDrnkPuAX3kp2OyUHxir0EsR4MdrBylC9acRLLKxMxiVqudiSCgI816Du8qdckNEsXI
 L
X-Google-Smtp-Source: AGHT+IFNEKVTwujBo+6GXmHA2muMx2Ec4xewmS+zeDgpHPSV1bdLY6xX7/UmuRGLAg72STfGrrpMVw==
X-Received: by 2002:a05:6a00:1b57:b0:6e4:65a7:c806 with SMTP id
 o23-20020a056a001b5700b006e465a7c806mr4589240pfv.8.1708934734742; 
 Mon, 26 Feb 2024 00:05:34 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:34 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 4/8] imx8mp: power-domain: Expose high performance PLL clock
Date: Mon, 26 Feb 2024 13:34:29 +0530
Message-Id: <20240226080433.3307154-5-sumit.garg@linaro.org>
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

Expose the high performance PLL as a regular Linux clock, so the
PCIe PHY can use it when there is no external refclock provided.

Inspired from counterpart Linux kernel v6.8-rc3 driver:
drivers/pmdomain/imx/imx8mp-blk-ctrl.c

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 78 +++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 58cc3f63bb56..3e514a603578 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -6,9 +6,15 @@
 #include <common.h>
 #include <asm/io.h>
 #include <clk.h>
+#include <clk-uclass.h>
 #include <dm.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <power-domain-uclass.h>
 
 #include <dt-bindings/power/imx8mp-power.h>
@@ -18,6 +24,15 @@
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
@@ -137,6 +152,68 @@ static int imx8mp_hsiomix_of_xlate(struct power_domain *power_domain,
 	return 0;
 }
 
+static int hsio_pll_clk_enable(struct clk *clk)
+{
+	void *base = (void *)dev_get_driver_data(clk->dev);
+	u32 val;
+	int ret;
+
+	/* Setup HSIO PLL */
+	clrsetbits_le32(base + GPR_REG2,
+			P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
+			FIELD_PREP(P_PLL_MASK, 12) |
+			FIELD_PREP(M_PLL_MASK, 800) |
+			FIELD_PREP(S_PLL_MASK, 4));
+
+	/* de-assert PLL reset */
+	setbits_le32(base + GPR_REG3, PLL_RST);
+
+	/* enable PLL */
+	setbits_le32(base + GPR_REG3, PLL_CKE);
+
+	/* Check if PLL is locked */
+	ret = readl_poll_sleep_timeout(base + GPR_REG1, val,
+				       val & PLL_LOCK, 10, 100000);
+	if (ret)
+		dev_err(clk->dev, "failed to lock HSIO PLL\n");
+
+	return ret;
+}
+
+static int hsio_pll_clk_disable(struct clk *clk)
+{
+	void *base = (void *)dev_get_driver_data(clk->dev);
+
+	clrbits_le32(base + GPR_REG3, PLL_CKE);
+	clrbits_le32(base + GPR_REG3, PLL_RST);
+
+	return 0;
+}
+
+static const struct clk_ops hsio_pll_clk_ops = {
+	.enable = hsio_pll_clk_enable,
+	.disable = hsio_pll_clk_disable,
+};
+
+U_BOOT_DRIVER(hsio_pll) = {
+	.name = "hsio-pll",
+	.id = UCLASS_CLK,
+	.ops = &hsio_pll_clk_ops,
+};
+
+int imx8mp_hsiomix_bind(struct udevice *dev)
+{
+	struct driver *drv;
+
+	drv = lists_driver_lookup_name("hsio-pll");
+	if (!drv)
+		return -ENOENT;
+
+	return device_bind_with_driver_data(dev, drv, "hsio-pll",
+					    (ulong)dev_read_addr_ptr(dev),
+					    dev_ofnode(dev), NULL);
+}
+
 static int imx8mp_hsiomix_probe(struct udevice *dev)
 {
 	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
@@ -207,6 +284,7 @@ U_BOOT_DRIVER(imx8mp_hsiomix) = {
 	.id		= UCLASS_POWER_DOMAIN,
 	.of_match	= imx8mp_hsiomix_ids,
 	.probe		= imx8mp_hsiomix_probe,
+	.bind		= imx8mp_hsiomix_bind,
 	.priv_auto	= sizeof(struct imx8mp_hsiomix_priv),
 	.ops		= &imx8mp_hsiomix_ops,
 };
-- 
2.34.1

