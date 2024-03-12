Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29438C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9402987F39;
	Tue, 12 Mar 2024 08:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dKNhs50l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D8B87F39; Tue, 12 Mar 2024 08:04:35 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA4287F2F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd8f7d50c6so14391365ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227069; x=1710831869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kiwwd6ptCvekM5cD90IAzeKYrEy/W7GgfSiXErckmNM=;
 b=dKNhs50lDH5ehqAV/kURr+XIIJT29h6WD4y9zhZEJWyzdQC2OBAGCQQ/InhyP1+xG+
 ffU2UoD7W9waf8Qdw2ePSEdoEhwhAHqfcQzPlk1CLkyoDojUkpOfL4U+99YPeYeg99lR
 dtr0yy8d/uo/D30bo/cpj8+vWsCkjFexhLPAUW8cv4z3iAJjT/109TIdZnwGQHCmGyjd
 6+HgQ/3RWFGsmh4CJudvdK0H0J05SWu9b/dTGLvxf6G/u62z5RQyv9iuRpDSGEphXWon
 2eAbRPrhb+ysJJ8wIaDodwLcGWSkBbKwGWTyZRs8eag+KqPqTPFC0n3Zj3QnLLDgtDIv
 bB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227069; x=1710831869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kiwwd6ptCvekM5cD90IAzeKYrEy/W7GgfSiXErckmNM=;
 b=ZvVrIGTNIk8HCKY7N7n2mAyu9oqGNjSkE7AA24+jxBSf7n8WKehK2A59JU9TmchosB
 G0E9GzKrty3cAoRh2/iSxOdQCEht9CZYCsvUwXH3OSyGiUvtrDciRxSC3/mepbBEuH0U
 0NaxtnNNIddOgnsigRNKnVQV8AOzYYroxwmz7fAD3ZWRxtgdo4hme2DWu2E/xHVySgq3
 UFxK7nozVncQy9TkcSwNCTQNpLcr0dXoK/gEHWi4I367NwvodvHgaaAG2/o19Sx1v9t/
 fsS/YD5dVL66cMIsr1RkBrYfdyV4FvuLw6gGfavjWHe0+VDMKhnQE3wdksDO3EIVAUI9
 5GSQ==
X-Gm-Message-State: AOJu0YzGg16bxWsJzJGdHRTNSOyhVKRji8uj/QqhZd1GSwPyl9RL/R6E
 o6BewGm4t57NOII+EabDHbOEmwS0x3thqOxO+qAWBE6CpayCBDJN27QZgZDFiDkXc3Pw/ZoqdcC
 u
X-Google-Smtp-Source: AGHT+IF00TE+5zk1C0+wffZhxbUZl1BB7U8W9QdwONbe1VLOy6H77bYmvCOcSk0cOHQt11Z+Lu2+ew==
X-Received: by 2002:a17:902:ce0b:b0:1dd:8b3b:540d with SMTP id
 k11-20020a170902ce0b00b001dd8b3b540dmr9946809plg.5.1710227068916; 
 Tue, 12 Mar 2024 00:04:28 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:28 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 06/11] imx8mp: power-domain: Expose high performance PLL
 clock
Date: Tue, 12 Mar 2024 12:33:33 +0530
Message-Id: <20240312070338.86127-7-sumit.garg@linaro.org>
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

Expose the high performance PLL as a regular Linux clock, so the
PCIe PHY can use it when there is no external refclock provided.

Inspired from counterpart Linux kernel v6.8-rc3 driver:
drivers/pmdomain/imx/imx8mp-blk-ctrl.c. Use last Linux kernel driver
reference commit 7476ddfd36ac ("pmdomain: imx8mp-blk-ctrl: Convert to
platform remove callback returning void").

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/power/domain/imx8mp-hsiomix.c | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index fb8041749ec..5ec79fc948c 100644
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
@@ -120,6 +135,67 @@ static int imx8mp_hsiomix_of_xlate(struct power_domain *power_domain,
 	return 0;
 }
 
+static int hsio_pll_clk_enable(struct clk *clk)
+{
+	void *base = (void *)dev_get_driver_data(clk->dev);
+	u32 val;
+	int ret;
+
+	/* Setup HSIO PLL as 100 MHz output clock */
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
+	clrbits_le32(base + GPR_REG3, PLL_CKE | PLL_RST);
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
@@ -190,6 +266,7 @@ U_BOOT_DRIVER(imx8mp_hsiomix) = {
 	.id		= UCLASS_POWER_DOMAIN,
 	.of_match	= imx8mp_hsiomix_ids,
 	.probe		= imx8mp_hsiomix_probe,
+	.bind		= imx8mp_hsiomix_bind,
 	.priv_auto	= sizeof(struct imx8mp_hsiomix_priv),
 	.ops		= &imx8mp_hsiomix_ops,
 };
-- 
2.34.1

