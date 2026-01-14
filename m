Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02760D37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4BF808AF;
	Wed, 14 Jan 2026 15:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y5wF7VM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A689383678; Wed, 14 Jan 2026 15:13:18 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8AB8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso9612515e9.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399996; x=1769004796; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DJnu8YkhfGm8ixOQJxgKsM80t1Lml8pj4gxDfSDeAeI=;
 b=y5wF7VM4sKpvBszSZFJVXyWhYCkmqsn5hQBGWh7v6DVA5tZWZl2jCd4xcet3A9Riww
 lG53Dzyg+iJ02XGmEyptNz420uHQmuCpjJYXZIXpPzMNJ6yHZoh99zMedEUcygvGkuaU
 UfCx02ukLgYbnOMQpSliF5oTLailwE7Q3wfZNvjEcCYmku2VZNUNQJfXN2/vfHPlkZ1t
 HEazUvizYd3DYE52hckIklekq9hZGOOUmp+zjefh/VvjY5fyFxrcT/R0waHD3D/ahs5l
 Wt7nbytZSNWTxf54bfSjg5OYYtJfEh+VOzVUKtzoVfhJu0w3nVuBnjuCeCW4pAerbd1M
 gnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399996; x=1769004796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DJnu8YkhfGm8ixOQJxgKsM80t1Lml8pj4gxDfSDeAeI=;
 b=ZfP+wGhJW27a4/H/TBM0Nzqi50MYKkQhJmGfLSpT+vynqYlTSW944pUB5CWsX2Ttai
 P5J37tWNIWZ5HlzR/gFsjRXM2VkordaDeT28RlXk8aywBM49GD/vBBI3kigEGTE2FJa6
 62dCUA/OIXz4Ltt8JHonwZ1n/wyQuUTzJ3TcZkvB1MGAkRtB9Vbo5FOcLJuSN1dG1ejY
 Vvy11i6OgB/w8cosUP6tpOXlPHDxQHnEecuNMcCM+hc35sEgSVpWEpdlx4dUhsmZ+kio
 j8FAIvEtIVrPjp0gqRYb4J7mJ7rfwu6L2KbDElti0DYUi5M6YzAuYUfazUmDDZ7x9WGW
 AV+Q==
X-Gm-Message-State: AOJu0YwaYQb10iaJH6ESCreRZGReXq6wVrHJHUCVM4CjHQ1BdhhEAGlm
 tlDZNbWPa9u4CUgdLBdbCnwcC85oHpLnLuDKlB96NphSUYK3GBjbDp1PEJqXtwAm3AlO//kQSVu
 afHtK3JI=
X-Gm-Gg: AY/fxX59th9lCndna5JNpkKWb3s4qYVexyubcY6T4F3K5sIzaSlLo8jPoxv0sREQbCM
 mzj3foW8Il+NiWLVNn4EIbXvCxQpyFw3YOfL3TxV8VS49SGAe1YXwkI07NnUjCb3LsbGCmvHyQU
 GpTBPbQnR77hhwD5RlIgtM6b6CnmkLgCBCskoEv1G6LEiVSa2U7gbIptmIrrPgbg5cLXAUcIk9E
 AJe2kvpHVAy5ex8F+SQCHj8+pC/8DpchwCcaAlHd/5RCD8czcHQ6GKotLQCWyS7C/y+ciBd22cW
 J7UY23lgJKqcP2Or2txN6ElybJkTcRPwppPncFwbyP+zOsQvtMA+I0hX/9IIebhTRU0o0IwkSEb
 oIC+5aNMViYfEa9sKkE1TXWtKWq8VVtt718xlzFk2BsQaritMA7bbsNGtOci9HMM+rXkPIjLAwy
 vuYprubxlXpC/Dm05G7vYT/ClM7RcYEFKwbN4YJj44+gRR+/IyWMxvyA==
X-Received: by 2002:a05:600c:470c:b0:477:97c7:9be7 with SMTP id
 5b1f17b1804b1-47ee32e0360mr32002415e9.1.1768399995906; 
 Wed, 14 Jan 2026 06:13:15 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee5910fc2sm29279755e9.13.2026.01.14.06.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:13:15 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 14 Jan 2026 15:13:12 +0100
Subject: [PATCH 2/3] usb: dwc3-generic: support Qualcomm flattened DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
In-Reply-To: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=gssJn3apJ/MJjU3kKRy1Nv+Zy4ALT3cAEJZh/l01K+M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsz0JRVv7s8yuBWXeCfplVDh4cd+V1cwJM0532gsWK8xf
 dX8V5vudpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ7PvCyLD0/sxrKjddXu2o
 Xr073yDouNj9jFaN6PlzUjY87lFw2fuUkaHtq9PeH0rbIuLTUjYeXCgxQSSp9VLSWUb7SlXXC9K
 XUqMB
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

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 02c02b1d80e4..7044696ced0c 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -6,8 +6,10 @@
  *
  * Based on dwc3-omap.c.
  */
 
+#define LOG_DEBUG
+
 #include <dm.h>
 #include <reset.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
@@ -488,23 +490,29 @@ static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
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
@@ -711,8 +719,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
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

