Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAAFD37E37
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 13:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF92808AF;
	Wed, 14 Jan 2026 14:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k5mA7ibj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94D982C7F; Wed, 14 Jan 2026 14:57:45 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631748063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43246af170aso572962f8f.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399063; x=1769003863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nwv0EMDJZOlNZvtZlYRtVDXRGcmf17Q+LSVxsKmV3XM=;
 b=k5mA7ibjCYmo3RCgzX08SyQ8dlQMEB83lTjrLitX2qG6YfyBEv1kEte0LzMEJ/NH0l
 z0514aKj8CNwFuqyK2bfIOzUdRHgExdcllkTqjf7d3wzOfM9CwPENF7beyrfDcoL2mxm
 ybKYIJzhJGQ9XAXvX+bURBRZDopCIbwyl2GRKQU//iUyM/wAdvSjjol4q0BsQwzr0rVI
 DqG9e3bisEW/nQDWSfEkjL8S/aWmKV7RYRLu0tKWNAkn2SbnCWm58TFbV6SoljIhesJ4
 hwxQI2k204bkwz9I9h3kWhOS1grwXxme+SFJ8yRgbgLSWO7IxHMA1d6WRJ6RghcXD1uk
 KY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399063; x=1769003863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nwv0EMDJZOlNZvtZlYRtVDXRGcmf17Q+LSVxsKmV3XM=;
 b=NYrkXfAEQWhShy1yJdoKIZOCRan4qTtb893d2sswFNDsCA5dszwsQfpTLbm4PF5AoP
 HPQsiLWpaeArVlNyBlCQpv0mhahRBI8wd9HHTLMt2II+CJ/s5yK0wdQAejWCaMDVR9IQ
 c/xHu98kTtEZYZsOw5/zuX5AKGzYMkdCWkUV+Gpc8SpMoTnijvF2+rH1bZ8/akjyvOuk
 WzSOrpnD3sQi9QYYrmikhcRetscCF2lvHlPa3gmxPAWF3oJwFlJt0C0JG9lFQWVI/Auz
 KZgy7VF83yXP8fnqJPIDZI1Ghdaob0hoUEC6vwADBd1ZQ+NOY8oVi5uhYemHLXqCH5Ri
 ly/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI7xbTWjD2b497D9kIWGcUPPMH6vRc0Wer6R0EqwuaRzt+I8OYMVsjyIAiQ2xjkbjj0Fe3PzY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7PJXVZu0LLEiUPOcn7nLoXSix/I4SUOKnEnLwcOPH+FbIdsAf
 kjVJU4lh3MTKcv58VF5vseK9HUSoTnLURhXGzWgrBguqP5ItBnTMBq0hWQ63jYF6EVU=
X-Gm-Gg: AY/fxX6M3CZDRgSrKJ3KQqhn09MmBYzuMFxdhMb8nzrzdYVRC+O0B9BhltraU4KJUdp
 Z8u0iVlBl5fFEIdBB6UEp6Bwbm7/QfCc8liC54LkbrNjcoQZ2Eg/oQSdTvMnhbd0AiOG/LERMtK
 2k56/XF4goGdy+QN4byA194XRwxgf7+SkvmJ1rVr7x5/Sl2BVQup49x3Bl4NzFeb+qU0hdfa9Oj
 TyU8SUJICzNitP794IERmm1mAyks+MkSCqNe+6dOgyZXCppd6VqvY0MJV3AAR2IBW+5b+W5uQLj
 uhBShxuodQYX3bZyxDc9Bf8NeXLim92kf3NBiwkrYookJ/WHEyPn3oIlwNsmz3nYs/qHEfupEyw
 KJ8zjhfDHn/ddXXTz+qrzrqbDMGRuqXoHXVdHqglw5KpSEgZjWA2E2fDw3IJExutov2QjJDmEf+
 AOYQJ6NXmfRvVHIE2KhiEWmBh5PuslxQBt3WslfGKiOfc4rpe1WukBrThXEsehiA==
X-Received: by 2002:a05:6000:2886:b0:432:59d4:f54a with SMTP id
 ffacd0b85a97d-43423ed9f25mr9121020f8f.30.1768399062545; 
 Wed, 14 Jan 2026 05:57:42 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm53218520f8f.24.2026.01.14.05.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 05:57:41 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: of_fixup: support new flat dwc3 node
Date: Wed, 14 Jan 2026 14:57:32 +0100
Message-ID: <20260114135739.1546815-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Qualcomm DTs are being updated to use a new format where the dwc3 glue
node and controller are combined into a single DT node. Update the fixup
code to handle this case.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 40 +++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e0..5b6076ea8e57 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -31,31 +31,37 @@
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
  * porting process for new devices.
  */
-static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
+static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np, bool flat)
 {
 	struct device_node *dwc3;
 	int ret, len, hsphy_idx = 1;
 	const __be32 *phandles;
 	const char *second_phy_name;
 
 	debug("Fixing up %s\n", glue_np->name);
 
+	/* New DT flattens the glue and controller into a single node. */
+	if (flat) {
+		dwc3 = glue_np;
+		debug("%s uses flat DT\n", glue_np->name);
+	} else {
+		/* Find the DWC3 node itself */
+		dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
+		if (!dwc3) {
+			log_err("Failed to find dwc3 node\n");
+			return -ENOENT;
+		}
+	}
+
 	/* Tell the glue driver to configure the wrapper for high-speed only operation */
 	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
 	if (ret) {
 		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
 		return ret;
 	}
 
-	/* Find the DWC3 node itself */
-	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
-	if (!dwc3) {
-		log_err("Failed to find dwc3 node\n");
-		return -ENOENT;
-	}
-
 	phandles = of_get_property(dwc3, "phys", &len);
 	len /= sizeof(*phandles);
 	if (len == 1) {
 		log_debug("Only one phy, not a superspeed controller\n");
@@ -103,15 +109,27 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 }
 
 static void fixup_usb_nodes(struct device_node *root)
 {
-	struct device_node *glue_np = root;
+	struct device_node *glue_np = root, *tmp;
 	int ret;
+	bool flat;
+
+	while (true) {
+		flat = false;
+		/* First check for the old DT format with glue node then the new flattened format */
+		tmp = of_find_compatible_node(glue_np, NULL, "qcom,dwc3");
+		if (!tmp) {
+			tmp = of_find_compatible_node(glue_np, NULL, "qcom,snps-dwc3");
+			flat = !!tmp;
+		}
+		if (!tmp)
+			break;
+		glue_np = tmp;
 
-	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
 		if (!of_device_is_available(glue_np))
 			continue;
-		ret = fixup_qcom_dwc3(root, glue_np);
+		ret = fixup_qcom_dwc3(root, glue_np, flat);
 		if (ret)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }
-- 
2.51.0

