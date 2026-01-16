Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B39C982DB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FA2838A5;
	Fri, 16 Jan 2026 18:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v0BQiQ3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1799D82BF2; Fri, 16 Jan 2026 18:09:58 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F9683623
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso295707566b.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768583395; x=1769188195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rlL9ofLbLeGmSMS2xn0YEs1yozXsjNRSDVFwseaOyAQ=;
 b=v0BQiQ3FlKz7JB3GCoffvALmvfwlqI4RZx3tosZllHKf+bDIW2Bi+xOEIoAXb5eOoa
 ijaq/kY+hctLbY1u3jPyO/wwaDlyoVGtHqNnTqusV41P3T2rBI+KLGGi3fI0BpHFrPNt
 IN2fFZQ82AREz/KtzUi4SNl660HnJC6MMJ5Q8F4UAoI23zr7n2q5BuTD6FcufPzZIMyz
 9UI1abzu5MtPbwERdRs1M2+qJqy7ol/JGEDl/+ip9takXPmcMhYJQOEEEmLdPY6JAFpA
 jg3C0DQukDGFOzdzQtXd0GIyd3IbTY894HoDUjBfcnSqBfyVKeJ9iFK1X4b9Z3SZQaJA
 6otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583395; x=1769188195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rlL9ofLbLeGmSMS2xn0YEs1yozXsjNRSDVFwseaOyAQ=;
 b=M+5aHRbkf2VRWFRjav9mej8tbHanMkKEmtQ4XGZkRPN6Rn8BryVATBeSs/YoJfqyUd
 oMY02tmxwocepGo2aE3WM1nRtZkYlUeqxKzjBLIal19AnYHjNkKQdA5PwKbmuylLwL2x
 gKC5DtReU1doM/J2dyZvN41tmXO5XC704eB7AF5wK7vaYX3NTE7MKgBrAxO4IkbGIik8
 rVnNUu8lESX0T/9mWayZ/DDR7c9tN/Gs74hQxds9JwdzxjSiZ3cFjYMORp3PzQszAjKe
 gSO/GuAk5p6Gjdp/1b7dSfKxSc8r3f/J1nxdtW7y+o8fYVWwcngtVRbQ1nG3dDvrZ4Vu
 j6ag==
X-Gm-Message-State: AOJu0YzNCNTsUXnc0SXh+omkqaAB9IfwSRNv0mvseE5xXS/1T9s2Rok2
 8jiR9tjObfa7qbl5I3zFltDUdqpRr4DS17p5vXlHtyH6SA6W+iDGks76kGYn4V1JQCs=
X-Gm-Gg: AY/fxX5raRKaEsDraTT18wrU96ZhJD2fWG0IGE8jCNmHYvwn8LtPeuQ+osQSrX3sALf
 WAT2Zj37AsyLYEe62/N0mT7PZNggVX/sOwua4RoBNfYwIZU1w+HUPcn/PFrqHsUorfN9o2Hpd8A
 YPsktWAFOpirzVZtD8yQQeIxLTu/JPM07jltGxtVUJZh3NPEqqFXeXpFRsgnggGmw27XuxqeLti
 NxoCmAuTxjtkhvUZoBw3a1xGB7WKVYga1IFlHuyOcdTUZLvL6jTCHqa7w/haSTPqS0ReFJs+Q7h
 mv4/2iwUh0tw3YJhh4yY+ujgwPkksKz9hvIn5/ILVYCDfcOem6IO5rOJNVViQO+NMaQpEGOUORc
 bzeRwH7pNplixbqmcbkuqMT8aGllb9pxslV1SeT1dzp0uyF5XNSKpTKswPK/jBrHevYcWoN1N8R
 8J1u0/4tLPpBbXKketIVdiyIom8PS0wcS/v3BAP28UR9yBS7h0U/CZTg==
X-Received: by 2002:a17:907:97c2:b0:b76:b632:1123 with SMTP id
 a640c23a62f3a-b8796afd5b4mr284806966b.42.1768583395307; 
 Fri, 16 Jan 2026 09:09:55 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795c38208sm294912666b.71.2026.01.16.09.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:09:54 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 16 Jan 2026 18:09:44 +0100
Subject: [PATCH v2 1/2] usb: dwc3-generic: support Qualcomm flattened DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-casey-usb-role-switch-v2-1-83a1a6501a11@linaro.org>
References: <20260116-casey-usb-role-switch-v2-0-83a1a6501a11@linaro.org>
In-Reply-To: <20260116-casey-usb-role-switch-v2-0-83a1a6501a11@linaro.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=RWBNulV+1gFhRGnyU2/l15uFHLpV9odyImSTGXoXkqE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsysggcbjFzSVz+I6L/cwBQj8C//R1DDOe9XXIyeEjecZ
 V+feHiko5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExEQprhf1KgmlvJ0cTjZ65p
 f60LetWQsfzr7r9r3zbxFL59kbytuIGRoevAkSeLXreFWWhev6gkMt/Gof4Cw67a7W+11h75UX/
 zeDQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Qualcomm devicetrees are moving away from having a glue node with dwc3
as a subnode and now may just have a single flattened node.

Rockchip already have a glue_get_ctrl_dev op which returns the node for
the glue device itself, commonise this and reuse it for the new Qualcomm
node.

Lastly adjust the qscratch base address since it now requires an offset
from the dwc3 base.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 02c02b1d80e4..22b9ef0b24e3 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -475,9 +475,16 @@ static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
 static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
 				     enum usb_dr_mode mode)
 {
 	struct dwc3_glue_data *glue = dev_get_plat(dev);
-	void __iomem *qscratch_base = map_physmem(glue->regs, 0x400, MAP_NOCACHE);
+	fdt_addr_t regs = glue->regs;
+	void __iomem *qscratch_base;
+
+	/* Offset for qscratch base when using flat DT */
+	if (device_is_compatible(dev, "qcom,snps-dwc3"))
+		regs += SDM845_QSCRATCH_BASE_OFFSET;
+
+	qscratch_base = map_physmem(regs, 0x400, MAP_NOCACHE);
 	if (IS_ERR_OR_NULL(qscratch_base)) {
 		log_err("%s: Invalid qscratch base address\n", dev->name);
 		return;
 	}
@@ -488,23 +495,29 @@ static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
 	if (mode != USB_DR_MODE_HOST)
 		dwc3_qcom_vbus_override_enable(qscratch_base, true);
 }
 
-struct dwc3_glue_ops qcom_ops = {
-	.glue_configure = dwc3_qcom_glue_configure,
-};
-
-static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
+/* In cases where there is no dwc3 node and it's flattened into the glue node */
+static int dwc3_flat_dt_get_ctrl_dev(struct udevice *dev, ofnode *node)
 {
 	*node = dev_ofnode(dev);
 	if (!ofnode_valid(*node))
 		return -EINVAL;
 
 	return 0;
 }
 
+struct dwc3_glue_ops qcom_ops = {
+	.glue_configure = dwc3_qcom_glue_configure,
+};
+
+struct dwc3_glue_ops qcom_flat_dt_ops = {
+	.glue_configure = dwc3_qcom_glue_configure,
+	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
+};
+
 struct dwc3_glue_ops rk_ops = {
-	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
+	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
 };
 
 static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 {
@@ -711,8 +724,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
+	{ .compatible = "qcom,snps-dwc3", .data = (ulong)&qcom_flat_dt_ops },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
 	{ .compatible = "samsung,exynos7870-dwusb3" },

-- 
2.51.0

