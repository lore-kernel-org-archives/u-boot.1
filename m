Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34464C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E571787DB3;
	Wed, 31 Jan 2024 16:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KrJmLV5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DB187CE9; Wed, 31 Jan 2024 16:17:15 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FAF87D9E
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33aed096cb3so2613742f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714229; x=1707319029; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1K2UpMRlfHQyCWRzBdmc6/7/huOXjQDmSO+ysf6rEtw=;
 b=KrJmLV5Ooni1Gwh0AKzbk2W4erstloh5adfny4cDmUJ/SuIFelpHSl0RhpvabW0nWw
 NOB54e3Qf7C6hnSQD+uCUcdQ0xKTUPc9K5Wm5jwXCc6nCARfJ6HMCm9vnifu0oAMxkOK
 no9/dYnLyVVFys4BSy6ulRucDAgedhVX8RN09EDrE1/QG/IxSfofBEH9hyS51NoHmM94
 TQfFqxGDy+lPEWHn8tWiMfhzjE9WH5VDmePaAbQautDS2+OB4dvyPgtJW6Pm52D+1ixL
 tvRc1t5ZaDTH20b7Dx1LCYz9/C2FPSAf+v5pJGf0eFMkeDW+7UnKH8uN/bRgxG3MAhZa
 8OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714229; x=1707319029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1K2UpMRlfHQyCWRzBdmc6/7/huOXjQDmSO+ysf6rEtw=;
 b=ZKGBqtUw6aJOy+6WmZ1tjWJlMHvLbyxa8HKqCqJSzt2MPu/bNcusI43dD/iO7TkmS8
 ZbtXknTxwzAZSaLCp7Jtx1/e0iIhpC8H3FF6aZYb+FSY2cpaAXbA/r2o9ooPp9zVQZC2
 dOpQRiqB8xZr17/3ZGoJ6cg1wq4tlG4wvqHGdr5KH/sWuOm2Vupp3p5Er6X0aF5umP6y
 Zteg5NXlDTmGuJ83ee02T0xKqGLTKhAHzhHOanUdd3Cclrqq43w8PbXkAskpZAV6jxW1
 7uuEiDUiNbQdKmSrhOmDfXbgSG3fQ04SgOHD9/8UJbvVEf4ns6S4nFl7Npw47ddjTGJT
 3K+A==
X-Gm-Message-State: AOJu0Yw//U5jkgUOejrJii1SEcyrJLUmEkJEhZZWwk3Ra7MG4q2lG95i
 HxYCyRaKdGEix4OlmeONFMp5UpasTJfuYZ8+UmJ+sP2NFLlCs0g9QAwdt4EEmrdOp4sVSb5Pbln
 9
X-Google-Smtp-Source: AGHT+IE+JNvjGmsk6qsnzZz4Cyc84RnOLxAK8VjBZq89HW1Mj5X431NpftRgALTPmQXFSVc0KHm4iw==
X-Received: by 2002:adf:fdd2:0:b0:33a:e504:9fe0 with SMTP id
 i18-20020adffdd2000000b0033ae5049fe0mr1226186wrs.64.1706714229718; 
 Wed, 31 Jan 2024 07:17:09 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:09 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:01 +0000
Subject: [PATCH 09/13] mach-snapdragon: fixup USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-9-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nFJ1Rg1PfcJyJ/579wdX+LmX63sts5GorAFhcmezZ2Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTn5NTutNO+1rQhI/9BV0Wx/tW3PRguDBCGFWrHch
 3s/qal1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlICjH8L2ZnXu7nlnbWUCzA
 5+/BTXrr9XlsWT3/dt0QsWEuL5x3l5GhIfr9oU85cxXW6nxatKGgMPhM7UedHNPipeVSJRdXGib
 wAwA=
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

We don't support USB super-speed in U-Boot yet, we lack the SS PHY
drivers, however from my testing even with a PHY driver there seem to be
other issues when talking to super-speed peripherals.

In pursuit of maintaining upstream DT compatibility, and simplifying
porting for new devices, let's implement the DT fixups necessary to
configure USB in high-speed only mode at runtime. The pattern is
identical for all Qualcomm boards that use the Synaptics DWC3
controller:

* Add an additional property on the Qualcomm wrapper node
* Remove the super-speed phy phandle and phy-name entries.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 88 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index ca300dc843a9..44925e369d8e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -146,6 +146,93 @@ int board_usb_init(int index, enum usb_init_type init)
 	return 0;
 }
 
+/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
+ * USB controllers. Rather than requiring source level DT changes, we fix up
+ * DT here. This improves compatibility with upstream DT and simplifies the
+ * porting process for new devices.
+ */
+#if CONFIG_IS_ENABLED(OF_LIVE)
+static int fixup_qcom_dwc3(struct device_node *glue_np)
+{
+	struct device_node *dwc3;
+	int ret, len, hsphy_idx = 1;
+	const __be32 *phandles;
+	const char *second_phy_name;
+
+	debug("Fixing up %s\n", glue_np->name);
+
+	/* Tell the glue driver to configure the wrapper for high-speed only operation */
+	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", NULL, 0);
+	if (ret) {
+		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
+		return ret;
+	}
+
+	/* Find the DWC3 node itself */
+	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
+	if (!dwc3) {
+		log_err("Failed to find dwc3 node\n");
+		return -ENOENT;
+	}
+
+	phandles = of_get_property(dwc3, "phys", &len);
+	len /= sizeof(*phandles);
+	if (len == 1) {
+		log_debug("Only one phy, not a superspeed controller\n");
+		return 0;
+	}
+
+	/* Figure out if the superspeed phy is present and if so then which phy is it? */
+	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
+	if (ret == -ENODATA) {
+		log_debug("Only one phy, not a super-speed controller\n");
+		return 0;
+	} else if (ret) {
+		log_err("Failed to read second phy name: %d\n", ret);
+		return ret;
+	}
+
+	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
+		log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
+			  second_phy_name);
+		hsphy_idx = 0;
+	}
+
+	/* Overwrite the "phys" property to only contain the high-speed phy */
+	ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
+	if (ret) {
+		log_err("Failed to overwrite 'phys' property: %d\n", ret);
+		return ret;
+	}
+
+	/* Overwrite "phy-names" to only contain a single entry */
+	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
+	if (ret) {
+		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void fixup_usb_nodes(void)
+{
+	struct device_node *glue_np = NULL;
+	int ret;
+
+	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
+		ret = fixup_qcom_dwc3(glue_np);
+		if (ret)
+			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
+	}
+}
+#else
+static void fixup_usb_nodes(void)
+{
+	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
+}
+#endif
+
 /*
  * Some boards still need board specific init code, they can implement that by
  * overriding this function.
@@ -159,6 +246,7 @@ void __weak qcom_board_init(void)
 int board_init(void)
 {
 	show_psci_version();
+	fixup_usb_nodes();
 	qcom_board_init();
 	return 0;
 }

-- 
2.43.0

