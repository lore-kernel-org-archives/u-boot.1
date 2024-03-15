Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD96FC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9914688004;
	Fri, 15 Mar 2024 16:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N14MTh64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C21688011; Fri, 15 Mar 2024 16:06:13 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0329A87FF2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso1410453f8f.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515167; x=1711119967; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PL6Z/zkvsAR1KzxwMv1rJzM4fB2Czula3XSPqEJDCS8=;
 b=N14MTh642jeNU8WAEsvNxSgpwwpgXp3/X4zLt9QGP+Kfr2nYga+ckSlNhLQgjnoCgb
 65UzaxKioVzUdTK6CygeIBQBwL1E25ZHJyIOj/+e2hMH1RWgStJgA618QhKLCo06lTRi
 v/Byg/kOya8AERp0zInkJ3E79ATwGqsZ55rBmVOvz9g5Qg4cu3xmoc3zbeFhmAYOgJkd
 iS4E6UFKlb7f6PTtlfW4oErPiG1r0/js6fLnrpFa3CIpNqy3whwPf+5lDNOemBBWIvhV
 Rf8ezo7cx3Ds/3CZQw6xqTRgi2aYDdBRyBU5xiyJgAqwG7fasE++9FX83fLU+QzPPOCE
 2G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515167; x=1711119967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL6Z/zkvsAR1KzxwMv1rJzM4fB2Czula3XSPqEJDCS8=;
 b=KUoocNg8VLOayXg4QmZPidIcpMlZbeqPg9VOyfhTvAq2ANjo2EgBI2Bjsmvi9mY4Zt
 /U79fnJJylPWG+rB4kjHrG44aEURtoj4XhAYbhKttVFVLOlFNWXeZyP6tsyvDGkKM3RV
 MJLuL6BbDJZvrYjCDeUL90Xm7Q1F3xT8FQvk50ik4Ju2+OmecFJOA+x7e3Q/zxboQcXO
 WastsQTksUEDaPPLgUUOZ0LprqLcNlidqW4Xj4HCWl31lZF4bnXyyKEnLC85XUUuEGbp
 wu6sb2QsXUPbqmB8Z2h9H0jaAi9NgsC5B7KGCyPrh/j4WZEES0BRgamJbnMEyEqTPLv4
 nOwQ==
X-Gm-Message-State: AOJu0YwuXWxE831pWq0H6c0KiO4eOu8HCibU1oIvYjk13bePLeb15p7O
 cxbGw2vLP2uD5eckdwEESUEMCglK5OatONEGQPvYgNyn63JDpWgn/8uuItnksjI=
X-Google-Smtp-Source: AGHT+IGT05Tp2EhhWUbnk4GZjf6nlKrP1X/1PS7qxTcZDhi6pf/XmTWkqxeun5PcA222iZ5+ciCfZQ==
X-Received: by 2002:adf:cb92:0:b0:33d:61c7:9b2c with SMTP id
 q18-20020adfcb92000000b0033d61c79b2cmr7745786wrh.34.1710515167313; 
 Fri, 15 Mar 2024 08:06:07 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 jg28-20020a05600ca01c00b0041401fbe446sm1939502wmb.11.2024.03.15.08.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:06:00 +0000
Subject: [PATCH v2 1/5] usb: dwc3-generic: implement Qualcomm wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-usb-v2-1-5467ec27cb26@linaro.org>
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
In-Reply-To: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wyOgocaLbH2BVsPAtMVCO6/ZFsvVRUnte7CZsWHnPsE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvyXca71mev/ZyQc7791Kz32q/XuIvynlM3MFxwQXWc
 2pHi8yrO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEPtgy/C9rM3mzUn2+0oqH
 tRm3VSa+E+AKO3OGZZfpRIFvjOxm3yMYGTYqe2iH6DU/iDvmWbKj997ynYuXJm7dZ3zVRZhf8Om
 vv9wA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The Qualcomm specific dwc3 wrapper isn't hugely complicated, implemented
the missing initialisation for host and gadget mode.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 81 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index a379a0002e77..5a355dd86c60 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -424,8 +424,79 @@ enum dwc3_omap_utmi_mode {
 struct dwc3_glue_ops ti_ops = {
 	.glue_configure = dwc3_ti_glue_configure,
 };
 
+/* USB QSCRATCH Hardware registers */
+#define QSCRATCH_HS_PHY_CTRL 0x10
+#define UTMI_OTG_VBUS_VALID BIT(20)
+#define SW_SESSVLD_SEL BIT(28)
+
+#define QSCRATCH_SS_PHY_CTRL 0x30
+#define LANE0_PWR_PRESENT BIT(24)
+
+#define QSCRATCH_GENERAL_CFG 0x08
+#define PIPE_UTMI_CLK_SEL BIT(0)
+#define PIPE3_PHYSTATUS_SW BIT(3)
+#define PIPE_UTMI_CLK_DIS BIT(8)
+
+#define PWR_EVNT_IRQ_STAT_REG 0x58
+#define PWR_EVNT_LPM_IN_L2_MASK BIT(4)
+#define PWR_EVNT_LPM_OUT_L2_MASK BIT(5)
+
+#define SDM845_QSCRATCH_BASE_OFFSET 0xf8800
+#define SDM845_QSCRATCH_SIZE 0x400
+#define SDM845_DWC3_CORE_SIZE 0xcd00
+
+static void dwc3_qcom_vbus_override_enable(void __iomem *qscratch_base, bool enable)
+{
+	if (enable) {
+		setbits_le32(qscratch_base + QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		setbits_le32(qscratch_base + QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	} else {
+		clrbits_le32(qscratch_base + QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		clrbits_le32(qscratch_base + QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	}
+}
+
+/* For controllers running without superspeed PHYs */
+static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
+{
+	/* Configure dwc3 to use UTMI clock as PIPE clock not present */
+	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+
+	setbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
+
+	clrbits_le32(qscratch_base + QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+}
+
+static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
+				     enum usb_dr_mode mode)
+{
+	struct dwc3_glue_data *glue = dev_get_plat(dev);
+	void __iomem *qscratch_base = (void __iomem *)glue->regs;
+	if (IS_ERR_OR_NULL(qscratch_base)) {
+		log_err("%s: Invalid qscratch base address\n", dev->name);
+		return;
+	}
+
+	if (dev_read_bool(dev, "qcom,select-utmi-as-pipe-clk"))
+		dwc3_qcom_select_utmi_clk(qscratch_base);
+
+	if (mode != USB_DR_MODE_HOST)
+		dwc3_qcom_vbus_override_enable(qscratch_base, true);
+}
+
+struct dwc3_glue_ops qcom_ops = {
+	.glue_configure = dwc3_qcom_glue_configure,
+};
+
 static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
 {
 	*node = dev_ofnode(dev);
 	if (!ofnode_valid(*node))
@@ -511,8 +582,16 @@ static int dwc3_glue_reset_init(struct udevice *dev,
 		return 0;
 	else if (ret)
 		return ret;
 
+	if (device_is_compatible(dev, "qcom,dwc3")) {
+		reset_assert_bulk(&glue->resets);
+		/* We should wait at least 6 sleep clock cycles, that's
+		 * (6 / 32764) * 1000000 ~= 200us. But some platforms
+		 * have slower sleep clocks so we'll play it safe.
+		 */
+		udelay(500);
+	}
 	ret = reset_deassert_bulk(&glue->resets);
 	if (ret) {
 		reset_release_bulk(&glue->resets);
 		return ret;
@@ -628,9 +707,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
-	{ .compatible = "qcom,dwc3" },
+	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
 	{ }

-- 
2.44.0

