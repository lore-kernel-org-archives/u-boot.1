Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB349C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DB387D47;
	Wed, 31 Jan 2024 15:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B9dqLfDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC55587D1A; Wed, 31 Jan 2024 15:57:36 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE6087C68
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so4218388f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706713052; x=1707317852; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aUbJkWjjrXidoORCmcFz2lZmCRklHKpbctt9GKSboY8=;
 b=B9dqLfDwLauJvRuh+0fMcOPMoOLw/yHfZ+kYVOpoGG+r3l1ARccNiYqpS/aGTjgcAh
 f0jYC2d3ZgbJtrMJdNpSKavz2EX+tT9b8OMRtGEUJYeEiMqavJHqsXwjQGDRO6L8VftG
 I8gzoceQjYmV8tDUpKHzUZgfEMXNm2Oww9bc8KEwvYPUVJkK4Pepvo7M5DCWbv0Whug1
 5sYZ+kH1fONC25sy4PWD+eBZomI6tK2w68B05EdtX6tTO7B1JZu0vtZ/y4t6ku8rVWII
 l7TYLz4CkwtTiREY4spJL9TLi2XeUzw1AruKbXt45grGp4j2uEmGN7huJmYmigy/kHDn
 ourQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713052; x=1707317852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUbJkWjjrXidoORCmcFz2lZmCRklHKpbctt9GKSboY8=;
 b=qjzPUz6vkSioe2YsgdM0rAIhI+2Sn2DKNy7oH4vAQMub4dRTlvsStQm+nzMJ5EiOf+
 taKalnUWbFTLmqu7vo81jjP/huUjeAtgddytzjukJ3Lr0DBAtLdAzp71jeXvSUiekxtF
 KxQKtKkN4K0IqkMcE14pUgY/wQ7Zl4bMN0uc3DPAa4VvTOzyrva0MnZh3xKPHDrDbRv3
 TpjFojJlg47jL6d457jgIMg2+Gzxx7MAGrOyrLbwsYb2p+0inoVGqX+D4mUdFIRjdnMk
 OYIuIs+W5lNA2VVy+sbiVaLkNlas4VQuhZKgusOkqYxFYq+c/KO8NJD1f7jt+15WcmGL
 3YKg==
X-Gm-Message-State: AOJu0YzdOxtvrW5Oqgfiz4PO2aNOiQCTnCmCm4BgUJmiOFXX9i9pR2Tk
 joSL95tL35Bq47G6aGttUw1xN3nT7tOs4R8cO7zE8D5ot8oFpFh3CWRDBRw/hwc=
X-Google-Smtp-Source: AGHT+IE5l3EfMwue8oJcFX0aCfu/5Zt7otIY0nSgx2KDT02ILg3+4q6faiRQTggLVPHrDCcsN1+lCA==
X-Received: by 2002:adf:a188:0:b0:33a:e9d5:3fe4 with SMTP id
 u8-20020adfa188000000b0033ae9d53fe4mr1324928wru.27.1706713052095; 
 Wed, 31 Jan 2024 06:57:32 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm7841912wrx.16.2024.01.31.06.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:57:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 14:57:26 +0000
Subject: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
In-Reply-To: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=l94OSpm9RVtjfYpzydIJkTgKut5ruGNpkKZzx9Ugd3M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRd8be27u0JNJq8vL2vo+hSWXm0816zw9cKtU3t325Zs
 SSuR7ezo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzENZ/hD6/kpZnTDDLT31uv
 NpjMb1Gu/+ML73vNigqnZjaDeTJ/0hn++7zey7V/3qPOaw1qi1r/bWtQ8OT31y343vSMV6aC5XR
 gGwA=
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 99 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 48da621ba966..1119cdecd26d 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -419,6 +419,99 @@ struct dwc3_glue_ops ti_ops = {
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
+static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static void dwc3_qcom_vbus_override_enable(void __iomem *qscratch_base, bool enable)
+{
+	if (enable) {
+		dwc3_qcom_setbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		dwc3_qcom_setbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	} else {
+		dwc3_qcom_clrbits(qscratch_base, QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		dwc3_qcom_clrbits(qscratch_base, QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	}
+}
+
+/* For controllers running without superspeed PHYs */
+static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
+{
+	/* Configure dwc3 to use UTMI clock as PIPE clock not present */
+	dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+
+	udelay(500);
+
+	dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
+
+	udelay(500);
+
+	dwc3_qcom_clrbits(qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+}
+
+static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
+				     enum usb_dr_mode mode)
+{
+	void __iomem *qscratch_base = (void __iomem *)dev_read_addr(dev);
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
@@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
 	else if (ret)
 		return ret;
 
+	if (device_is_compatible(dev, "qcom,dwc3")) {
+		reset_assert_bulk(&glue->resets);
+		udelay(500);
+	}
 	ret = reset_deassert_bulk(&glue->resets);
 	if (ret) {
 		reset_release_bulk(&glue->resets);
@@ -623,7 +720,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
-	{ .compatible = "qcom,dwc3" },
+	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },

-- 
2.43.0

