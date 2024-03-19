Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE960C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4361288044;
	Tue, 19 Mar 2024 13:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TWgpa72j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F1E487F88; Tue, 19 Mar 2024 13:14:46 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DD187F8C
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513e25afabaso2875007e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850481; x=1711455281; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IfzPwLOX3gt0THn+CH2zX4p2cqGEx8YFAQy2omwRDQY=;
 b=TWgpa72jSDN+Yk+JoK40kKIsnEOVAsMIUNC40I2dwdSTo5m3Ngmd+huyvpyaFDwogi
 Yx5dB3IjQrbDpIZ3aNxjwjEQapakQ2snJcS//Vu1sQsriBgXYEC5Yy+L1L4/igcFasUf
 UBYL7HuGujwhkGjwL0N5+33zrQF0yfhuug/aVAu/du6dJL3MdkSnHrwTvE4MOpJFEtMh
 oktMALJOVZPt0aL9eUgtDXiQdL3BtgXjIiUekAEGnoNPWfbjwi+qYBKqMJSHADkzDzrb
 fwLzo21Nhxsc7INdc8Jr7cAQLPa5T2F7VViUA2/JIBwicDSoCLuiNSeHj65+iu35tbvK
 WlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850481; x=1711455281;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfzPwLOX3gt0THn+CH2zX4p2cqGEx8YFAQy2omwRDQY=;
 b=Xsa8osaAnpOa0Oll4Qz1WUQKWsY8q8CdvUiEfeYpyOfb/lUi+pe+bgfhqzGjA9Ufln
 XLjUDmapEtcJfeIC2yWejgaf/eVOG6kqtYJnFug7++njMr2Or7gz2z5E0cNCI3Xwy9rj
 nCmFdxb4GmiBckoRoGot1PaIZu6aeNAamMJe1D3Eux/SVPnzN4Wjru7+zUKxttl5a6Cr
 4K99bmnNp9kt2nJaWyUM/aQ037zs2KYbUme8JYnztWtfKDU95JopS/OjaFt4QbS3SBd7
 rx/Cqi09KmC6pe5H0rFERBKeluLHnWlLmiLmq4867CcSl0LgrbvUxRyLqDtTtsEKBbXE
 iNMw==
X-Gm-Message-State: AOJu0Yx6Fra10Ule7msuNAo0mDe002ORk7esADi/MnydN4ajtDmIBBDp
 cMjefq9hjAK2lKxU6Wp4Emr7+DsobRmGJlVlzBBlpI8OG3YKnabisLlHugBwoVOOSAgnRyPwUwV
 e
X-Google-Smtp-Source: AGHT+IE734onzjRbb78AzW+2nU7yMeDdNfgyfn2IkPlOxl9GbRP/HcXHHNMsnirKr/djG8H4oN9xig==
X-Received: by 2002:a2e:3c18:0:b0:2d4:5321:9daf with SMTP id
 j24-20020a2e3c18000000b002d453219dafmr8692281lja.44.1710850481335; 
 Tue, 19 Mar 2024 05:14:41 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:14:24 +0000
Subject: [PATCH v3 1/5] usb: dwc3-generic: implement Qualcomm wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-usb-v3-1-09ba1f86d259@linaro.org>
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4313;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Zb3uEMmWe4RzGwHrxJVrzpQg4bHURtPcRw4NigykBUc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjev+vQ9csMxvVurc2Z9q33+8eTL1wqontTU+f9LZF
 yz54Mowr6OUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBMpKma4Z+uvNSuv7yxH5zN
 klx2+h64yc3PyDZ5muG52VW6P+4prlvPyLDt047as/13hfmjxC9lC5v2XjHcHqnesPXOtNkByff
 nbFsMAA==
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
index a379a0002e77..36b6c5306d64 100644
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

