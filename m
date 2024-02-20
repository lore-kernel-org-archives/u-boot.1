Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E182C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA0C87D9B;
	Tue, 20 Feb 2024 14:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d8B7mANE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087A687D72; Tue, 20 Feb 2024 14:38:48 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0B487F6E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so2201345ad.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436319; x=1709041119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Tkj3mkTZbtyA/2ZVbEvHqkFzZ3+cwk/bRN8ngs1I48=;
 b=d8B7mANE/g6/jnR53nYhGSpHy1QB4Wnje4j91p1lnQJAWwY+4/hZhg1FnplaogRhLQ
 +rr9WCGNNNRfil97FUx0L3+0MBLkvx0CbJcd8rtYU8Cs5ydcrRyIYLQWmCEuYxNu7Jxw
 IQnBjlDrDkiw+0rcI+0wrK/LJsEBlXmrgF9gI7IrfT9OZTNXQ+In2l4gkPZ2X+nMMLiP
 Zm+GgiJfeopRD5mLX/eswSv3VwEBRIRyDlNS6qWFeHm4Qr4w41yNwDFHsJHxnK7aOZCE
 KZc7Cm6s3WiBcGAaMsaYs8X8QG5MsJhfmnwKuhnbAkEf3YY+hSkKT3nTXRdWv9pzYyuB
 i/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436319; x=1709041119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Tkj3mkTZbtyA/2ZVbEvHqkFzZ3+cwk/bRN8ngs1I48=;
 b=uJBvQEsXmAC+5T9s+e1GhRIc+4kC5WwfJfIIi9bU1hXXAqKGCu0pW7KRslWtEpkCeN
 d8bNxfiNk6fnK46CerNg3QxLOMBelvVPU+HYxD+CfZVXXH+VOcxp5M6gWGV6kTDMGj1c
 O8ZNSwjFljhp/jyKmmEhWcRgCGHiHkMiZ1ach3F/FRN/bL08lVyPW8pNSu8ALE0nJCl6
 pSwLczaeW50iFinsC8J0o1mPxeYax7lyss//C1wSo4vcbzRAHTRckB12NQI+Qr/tq5Gr
 2HZbJGEdH/1+T5pSwdYn+djRZ+7SXsULhXsckt3g9mAPg2ZkZV4v5IyEnZ1oq2MxDHXy
 6e9w==
X-Gm-Message-State: AOJu0YxkwZ/B9xB8dqUt4aNmDCtk0Kbj+aVdcoBhVrMVwwIIzRVC5aJC
 hKxJ0CJPboT/IBEYp1bIFdlU7vHHQFqzX73uHAD9Jy5u9oatAqdEKOPiYsQ8U7KPWWu8v18m+kx
 i
X-Google-Smtp-Source: AGHT+IF3JlAYActwovvAm//+CbLIOXuWuTaN6LCFezgrqWunN/XWVPR+9qxuCSwZoxoyyTPZ9ZHKtg==
X-Received: by 2002:a05:6a00:cc8:b0:6e4:7df2:5f67 with SMTP id
 b8-20020a056a000cc800b006e47df25f67mr1266573pfv.17.1708434682910; 
 Tue, 20 Feb 2024 05:11:22 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:22 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 2/7] reset: imx: Add support for i.MX8MP reset controller
Date: Tue, 20 Feb 2024 18:40:51 +0530
Message-Id: <20240220131056.2962331-3-sumit.garg@linaro.org>
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
 drivers/reset/reset-imx7.c | 114 +++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index eaef2cc2cdf..c1de84dea8b 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <dt-bindings/reset/imx7-reset.h>
 #include <dt-bindings/reset/imx8mq-reset.h>
+#include <dt-bindings/reset/imx8mp-reset.h>
 #include <reset-uclass.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -252,6 +253,115 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
 	return 0;
 }
 
+enum imx8mp_src_registers {
+	SRC_SUPERMIX_RCR	= 0x0018,
+	SRC_AUDIOMIX_RCR	= 0x001c,
+	SRC_MLMIX_RCR		= 0x0028,
+	SRC_GPU2D_RCR		= 0x0038,
+	SRC_GPU3D_RCR		= 0x003c,
+	SRC_VPU_G1_RCR		= 0x0048,
+	SRC_VPU_G2_RCR		= 0x004c,
+	SRC_VPUVC8KE_RCR	= 0x0050,
+	SRC_NOC_RCR		= 0x0054,
+};
+
+static const struct imx7_src_signal imx8mp_src_signals[IMX8MP_RESET_NUM] = {
+	[IMX8MP_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET2]	= { SRC_A53RCR0, BIT(2) },
+	[IMX8MP_RESET_A53_CORE_POR_RESET3]	= { SRC_A53RCR0, BIT(3) },
+	[IMX8MP_RESET_A53_CORE_RESET0]		= { SRC_A53RCR0, BIT(4) },
+	[IMX8MP_RESET_A53_CORE_RESET1]		= { SRC_A53RCR0, BIT(5) },
+	[IMX8MP_RESET_A53_CORE_RESET2]		= { SRC_A53RCR0, BIT(6) },
+	[IMX8MP_RESET_A53_CORE_RESET3]		= { SRC_A53RCR0, BIT(7) },
+	[IMX8MP_RESET_A53_DBG_RESET0]		= { SRC_A53RCR0, BIT(8) },
+	[IMX8MP_RESET_A53_DBG_RESET1]		= { SRC_A53RCR0, BIT(9) },
+	[IMX8MP_RESET_A53_DBG_RESET2]		= { SRC_A53RCR0, BIT(10) },
+	[IMX8MP_RESET_A53_DBG_RESET3]		= { SRC_A53RCR0, BIT(11) },
+	[IMX8MP_RESET_A53_ETM_RESET0]		= { SRC_A53RCR0, BIT(12) },
+	[IMX8MP_RESET_A53_ETM_RESET1]		= { SRC_A53RCR0, BIT(13) },
+	[IMX8MP_RESET_A53_ETM_RESET2]		= { SRC_A53RCR0, BIT(14) },
+	[IMX8MP_RESET_A53_ETM_RESET3]		= { SRC_A53RCR0, BIT(15) },
+	[IMX8MP_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
+	[IMX8MP_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
+	[IMX8MP_RESET_SW_NON_SCLR_M7C_RST]	= { SRC_M4RCR, BIT(0) },
+	[IMX8MP_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
+	[IMX8MP_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
+	[IMX8MP_RESET_SUPERMIX_RESET]		= { SRC_SUPERMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_AUDIOMIX_RESET]		= { SRC_AUDIOMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_MLMIX_RESET]		= { SRC_MLMIX_RCR, BIT(0) },
+	[IMX8MP_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR, BIT(2) },
+	[IMX8MP_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
+	[IMX8MP_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
+	[IMX8MP_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
+	[IMX8MP_RESET_MEDIA_RESET]		= { SRC_DISP_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU2D_RESET]		= { SRC_GPU2D_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU3D_RESET]		= { SRC_GPU3D_RCR, BIT(0) },
+	[IMX8MP_RESET_GPU_RESET]		= { SRC_GPU_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_RESET]		= { SRC_VPU_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_G1_RESET]		= { SRC_VPU_G1_RCR, BIT(0) },
+	[IMX8MP_RESET_VPU_G2_RESET]		= { SRC_VPU_G2_RCR, BIT(0) },
+	[IMX8MP_RESET_VPUVC8KE_RESET]		= { SRC_VPUVC8KE_RCR, BIT(0) },
+	[IMX8MP_RESET_NOC_RESET]		= { SRC_NOC_RCR, BIT(0) },
+};
+
+static int imx7_reset_assert_imx8mp(struct reset_ctl *rst)
+{
+	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct imx7_src_signal *sig = imx8mp_src_signals;
+	u32 val;
+
+	if (rst->id >= IMX8MP_RESET_NUM)
+		return -EINVAL;
+
+	val = readl(priv->base + sig[rst->id].offset);
+	switch (rst->id) {
+	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MP_RESET_PCIEPHY_PERST:
+		val &= ~sig[rst->id].bit;
+		break;
+	default:
+		val |= sig[rst->id].bit;
+		break;
+	}
+	writel(val, priv->base + sig[rst->id].offset);
+
+	return 0;
+}
+
+static int imx7_reset_deassert_imx8mp(struct reset_ctl *rst)
+{
+	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct imx7_src_signal *sig = imx8mp_src_signals;
+	u32 val;
+
+	if (rst->id >= IMX8MP_RESET_NUM)
+		return -EINVAL;
+
+	if (rst->id == IMX8MP_RESET_PCIEPHY) {
+		/*
+		 * wait for more than 10us to release phy g_rst and
+		 * btnrst
+		 */
+		udelay(10);
+	}
+
+	val = readl(priv->base + sig[rst->id].offset);
+	switch (rst->id) {
+	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MP_RESET_PCIEPHY_PERST:
+		val |= sig[rst->id].bit;
+		break;
+	default:
+		val &= ~sig[rst->id].bit;
+		break;
+	}
+	writel(val, priv->base + sig[rst->id].offset);
+
+	return 0;
+}
+
 static int imx7_reset_assert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
@@ -272,6 +382,7 @@ static const struct reset_ops imx7_reset_reset_ops = {
 static const struct udevice_id imx7_reset_ids[] = {
 	{ .compatible = "fsl,imx7d-src" },
 	{ .compatible = "fsl,imx8mq-src" },
+	{ .compatible = "fsl,imx8mp-src" },
 	{ }
 };
 
@@ -289,6 +400,9 @@ static int imx7_reset_probe(struct udevice *dev)
 	} else if (device_is_compatible(dev, "fsl,imx7d-src")) {
 		priv->ops.rst_assert = imx7_reset_assert_imx7;
 		priv->ops.rst_deassert = imx7_reset_deassert_imx7;
+	} else if (device_is_compatible(dev, "fsl,imx8mp-src")) {
+		priv->ops.rst_assert = imx7_reset_assert_imx8mp;
+		priv->ops.rst_deassert = imx7_reset_deassert_imx8mp;
 	}
 
 	return 0;
-- 
2.34.1

