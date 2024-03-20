Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACEEC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4098A880AA;
	Wed, 20 Mar 2024 15:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V1/4Oife";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233D0880AB; Wed, 20 Mar 2024 15:31:34 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3C78809C
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4146fe16a1aso491485e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710945087; x=1711549887; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SjDlW+8IpzNZXJdwydlKPO6ti4rxZpAG+p026aQtpJ4=;
 b=V1/4OifeJ+lDP5clNIQlXPY2qYHC6V95ORnQ7mbzaQFcoceirauQPsV3h1G4ct6T2x
 T5e2X3qWefD5LPN4VMRU02nhoarIigN7D45fg40/Nb2KXImr+DVkaJvnvSNeb9Nnl7WK
 oSmDT93tbZRml5JV5n5uGdIUck+NC9zvaP/TygG2qNlz6PL9JTRZHiTBxzQS5ka+EhAA
 9fEzYz4TEFbNJwh1zZnxeaqSOHP/ZIYaZl9XLp9tPBQqLvPOpOE8CO6H7YbtwfkzmRPu
 i88TL1WO5iyRp6gIIh2ncpdWA4nJWH/p/BqBjS+9zm55rtlk1ruVB/z4AuECXsiaRpzn
 iWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945087; x=1711549887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjDlW+8IpzNZXJdwydlKPO6ti4rxZpAG+p026aQtpJ4=;
 b=wuiDGxPwhuA1eGNJy//wX4CqOlHxlW42+RAH+ZqbZ55Gm7y3+zSnyWjRBilU0XQ/6b
 2/ZIbw8vQZ/w6OrxKU5UkMDhe25LBMw2LEZDSnjKI8+Sv2j6UKssrybq4fvy8P4YdXPk
 E47qcwD8r35EBeQJ8yuMpnHeY4tqI8IJSo++auTCCyc2OpiAMQEaJN4/QTD/3ExlcTsM
 7foR7slpB7/ZPMDEme+blNwA0LVo+zKivdByU+giq45dD6wMangPYfej5jLGqD6o8FUF
 Tv/P6EeeQpzvkadH0MXhdpDjWWftTkuPHgj6ZrpoKmwAFxbIboDRt04IYE8htAzVF+au
 s3mw==
X-Gm-Message-State: AOJu0YyONli+bQcH04dw1ManItnk/R9HFtO9QlC/FqkYRUduSMHRrsCb
 4PnljdwzaVz5YvJ7Js9sxDXyDDLzadZ+XXGn3ThesAIn7khKDHyhgsy4xmoUO68=
X-Google-Smtp-Source: AGHT+IH0q5SBdix5qoLvQamFkFp2Cg2QcdwcsIu0un0XIimHRCAESWb8qVqb3YYVhGptnyeoAMFEfA==
X-Received: by 2002:adf:eac4:0:b0:33d:c5c7:459e with SMTP id
 o4-20020adfeac4000000b0033dc5c7459emr5371450wrn.12.1710945087533; 
 Wed, 20 Mar 2024 07:31:27 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033ed7181fd1sm12036571wrb.62.2024.03.20.07.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:31:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:30:47 +0000
Subject: [PATCH v4 1/5] usb: dwc3-generic: implement Qualcomm wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-usb-v4-1-41be480172e1@linaro.org>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4330;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TBFUFpekV+qFZ6RAviZs0auRQQMd6dN3dIBlHgbqX7E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfn23DWz08bH7m+Hc4ntqx2Pb/MZenDfuOpNx/oL3r2
 u3USnOhjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRiQ8Z/vulCE2W2x6sdlPW
 YhZHbJbNE9MvO+P+zTd5e/Y4j8iHixcZ/vBXtN2tf1I5bd/+6z6rnn6SmnD63OxdbnneB09s7TV
 RkGECAA==
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
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 81 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index a379a0002e77..7a00529a2a8e 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -424,8 +424,79 @@ enum dwc3_omap_utmi_mode {
 struct dwc3_glue_ops ti_ops = {
 	.glue_configure = dwc3_ti_glue_configure,
 };
 
+/* USB QSCRATCH Hardware registers */
+#define QSCRATCH_GENERAL_CFG 0x08
+#define PIPE_UTMI_CLK_SEL BIT(0)
+#define PIPE3_PHYSTATUS_SW BIT(3)
+#define PIPE_UTMI_CLK_DIS BIT(8)
+
+#define QSCRATCH_HS_PHY_CTRL 0x10
+#define UTMI_OTG_VBUS_VALID BIT(20)
+#define SW_SESSVLD_SEL BIT(28)
+
+#define QSCRATCH_SS_PHY_CTRL 0x30
+#define LANE0_PWR_PRESENT BIT(24)
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
+	void __iomem *qscratch_base = map_physmem(glue->regs, 0x400, MAP_NOCACHE);
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

