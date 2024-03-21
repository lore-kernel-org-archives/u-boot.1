Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE0C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27E0880C0;
	Thu, 21 Mar 2024 15:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OiKHHoqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20187880DB; Thu, 21 Mar 2024 15:55:46 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1907487F1E
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e08512cd86so1109125ad.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032940; x=1711637740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXfJ+ze3P2WZwnms0irP1lniROry+6vdxNOaK57iBvo=;
 b=OiKHHoqCOrn9zQpgld0Oi3gfVcfDacbqRZaso/jERjVrE3mb5LYYR+g/f+xU9s1NAE
 9kb2m23mxZg/HDu09YTD2smlB1HYTTFqMmF+tJplxgLcVo1xJpBoXVTJ4sHET/dbVIYL
 4VsXFOh5R6ANoN4yMfBCiOG9eQ0DkpDw8aqnWDJc1qzJSxrrviVKrsTUnqF6xd8WmB6s
 tV2HqL5yUBzDZfcrdpNiwWFRm74yXHVAMYi0l8M9C+C3sIDfUPqBnSdL/euKrnpcDdO/
 u9yh30FePAX9b5vb4+onWi7OcWU8tsbLbXbqOC3F8xjwFTcRWcJWT74miwfywamanPRV
 Zc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032940; x=1711637740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXfJ+ze3P2WZwnms0irP1lniROry+6vdxNOaK57iBvo=;
 b=XhQFfJCx2PoK5Eorn4wenXnArDuvQRglwEREAJhQm2fScSaDZB+BFjKrLhKsw23xwD
 mOWmNDLrnK0LoMx+YZmSjQpuCnBkQ1GVR0IkiHSzS3/zCCUXUamV9Rg8iBTRAf7nLLDn
 DXQAyou3m3bREzL8kVQ/q+lJvbkYxuxGoV7khPqtYa3DlyUF6qGm4rNvPHT7rLgO9TAd
 sLHDY5aeUINldtVjfbyWvqv3PhP++VQ6W6AX9iHqWLH47DY+gH7nmzR/pnobqrxFKGfv
 CkcyRqy2tg+bYKSg8xBRxejJ1CBfywV2ce3hF+uc56l1pf5mytKYJXaDQHG6APzhoW7v
 0SeA==
X-Gm-Message-State: AOJu0Yxhe5n5jeXMo8Z6zwNI6u4SKW7v3cTcZGGwTSy8LGn0+uvGeR67
 EW9byHu5adDIhZ0qLhwHrgfqvV+JpPzTh3oV41siv5sdl9Ebr4QrU9604DefhIUNmnEdsLI9Oht
 2
X-Google-Smtp-Source: AGHT+IGrUerxXRebVZELMTIl3R13y/6mks1CDT/IFC1JI4XiEgi4bzPVq6JlaB5uXd9Pib574ivy0A==
X-Received: by 2002:a17:902:8c93:b0:1dd:e159:3e32 with SMTP id
 t19-20020a1709028c9300b001dde1593e32mr1971492plo.57.1711032940248; 
 Thu, 21 Mar 2024 07:55:40 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:55:39 -0700 (PDT)
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
Subject: [PATCH v4 03/11] reset: imx: Add support for i.MX8MP reset controller
Date: Thu, 21 Mar 2024 20:24:59 +0530
Message-Id: <20240321145507.619448-4-sumit.garg@linaro.org>
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

Add support for i.MX8MP reset controller, it has same reset IP inside
as the other iMX7 and iMX8M variants but with different module layout.

Inspired from counterpart Linux kernel v6.8-rc3 driver:
drivers/reset/reset-imx7.c. Use last Linux kernel driver reference
commit bad8a8afe19f ("reset: Explicitly include correct DT includes").

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/reset/reset-imx7.c | 101 +++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index ca703466605..a3b3132f2fa 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <dt-bindings/reset/imx7-reset.h>
+#include <dt-bindings/reset/imx8mp-reset.h>
 #include <dt-bindings/reset/imx8mq-reset.h>
 #include <reset-uclass.h>
 #include <linux/bitops.h>
@@ -252,6 +253,102 @@ static int imx8mq_reset_assert(struct reset_ctl *rst)
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
+static int imx8mp_reset_set(struct reset_ctl *rst, bool assert)
+{
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
+	unsigned int bit, value;
+
+	if (rst->id >= IMX8MP_RESET_NUM)
+		return -EINVAL;
+
+	bit = imx8mp_src_signals[rst->id].bit;
+	value = assert ? bit : 0;
+
+	switch (rst->id) {
+	case IMX8MP_RESET_PCIEPHY:
+		/*
+		 * wait for more than 10us to release phy g_rst and
+		 * btnrst
+		 */
+		if (!assert)
+			udelay(10);
+		break;
+
+	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MP_RESET_PCIEPHY_PERST:
+		value = assert ? 0 : bit;
+		break;
+	}
+
+	clrsetbits_le32(priv->base + imx8mp_src_signals[rst->id].offset, bit,
+			value);
+
+	return 0;
+}
+
+static int imx8mp_reset_assert(struct reset_ctl *rst)
+{
+	return imx8mp_reset_set(rst, true);
+}
+
+static int imx8mp_reset_deassert(struct reset_ctl *rst)
+{
+	return imx8mp_reset_set(rst, false);
+}
+
 static int imx_reset_assert(struct reset_ctl *rst)
 {
 	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
@@ -272,6 +369,7 @@ static const struct reset_ops imx7_reset_reset_ops = {
 static const struct udevice_id imx7_reset_ids[] = {
 	{ .compatible = "fsl,imx7d-src" },
 	{ .compatible = "fsl,imx8mq-src" },
+	{ .compatible = "fsl,imx8mp-src" },
 	{ }
 };
 
@@ -289,6 +387,9 @@ static int imx7_reset_probe(struct udevice *dev)
 	} else if (device_is_compatible(dev, "fsl,imx7d-src")) {
 		priv->ops.rst_assert = imx7_reset_assert;
 		priv->ops.rst_deassert = imx7_reset_deassert;
+	} else if (device_is_compatible(dev, "fsl,imx8mp-src")) {
+		priv->ops.rst_assert = imx8mp_reset_assert;
+		priv->ops.rst_deassert = imx8mp_reset_deassert;
 	}
 
 	return 0;
-- 
2.34.1

