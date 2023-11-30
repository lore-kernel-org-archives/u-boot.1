Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F517C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9FD87732;
	Thu, 30 Nov 2023 21:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uIq/d9MN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F01E876F6; Thu, 30 Nov 2023 21:22:59 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D14B87714
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so14287665e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375776; x=1701980576; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gXQphteMBD3U0pnY+yrATKZ588HOaJO4A0kylMV0sOA=;
 b=uIq/d9MN42iWm0kGzN8QiwzaOiQ5aQf61OKbRuZQegZ+wh2SAjx/8u02IEihvJ2piG
 KY+LM/yxk/Wrg32D9Et6fL03eiNAGEP1rj0oIVIdcaS3mce46gLyUXVBJCk5IG44H/by
 344eTRE5hLdOzWYUiKMYryAb+r6DwG+7bbEEOabyjMW+mH9gQd/VPtNCghJcGxuEXUhf
 OzLNwV9ktiBQR2F4XBaJJNxnpJZm7AJr6cmkH/ynCrgVkUJQBfOQhtenmhzyGOJ8NXHO
 uF17naBq6WSiBKab+FphHQGE9wfsPPwPJ7UOP8ooDf/3btliiZbzICSP1Y+LMkXd+iaG
 6jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375776; x=1701980576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXQphteMBD3U0pnY+yrATKZ588HOaJO4A0kylMV0sOA=;
 b=ZKOm8MF67IUSDZuUxs8e2mAsYF8N5BYqKEVM6vtH+aMWgR03N9z5ZiuMDJG/9tbT5u
 /uSIf2u5QTaZortdnGsmBlsTPJ8O3rYnlt3whYzSnHiMtUBspgeWwl1ikD0VnTDMQyCe
 pzqk+xgd2Ge5EtQlM0pf15+DL0ftBYDA0aPOg+7TTx5mCpp1xNk/VR1mXy1oVnAwyWwG
 XBR4tOhkWW2h0kPl00ckjpGY4COFBz/ZILlgOEfnZzKcgL0xdy+smsY89nJX6o1yodl8
 2arggPWuxSoayV5fPVhEhJnImBEXoq8U7g4Lyhmqw8kupvvsYfzjp2wnpg5lcD2DJnOW
 5W4w==
X-Gm-Message-State: AOJu0YwUJYtroJ9gLhTkaT0KFlwlbde0mApXCOSg1jBN+296sScLOL14
 k3KOgVgbT/jCq9iGkVkCJWGxwg==
X-Google-Smtp-Source: AGHT+IE7D2P8GKs3/Itp4qpuwqSFajGrD+J23cUqaeNQEOL8HnnpA3Y1osSqoAbO1JNnkfRj1HAisA==
X-Received: by 2002:a05:600c:26d3:b0:40b:5e21:dd44 with SMTP id
 19-20020a05600c26d300b0040b5e21dd44mr41270wmv.114.1701375776750; 
 Thu, 30 Nov 2023 12:22:56 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:56 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:33 +0000
Subject: [PATCH v5 9/9] pmic: qcom: dont use dev_read_addr to get USID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-9-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=5331;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GoC7TMy12LCcUreseBruRwwooFPfjXYG46ZgiFDMnn4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92LHY2+2Kay1XMPo0rz288aKhFcms4oeMh/Ys8RAM
 /7tzjmiHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiZy8y/Pf6eUo1r2zWvus+
 x+Ykb9WQyHojrKJ1pqm44TFL1ulqo0CG/7HTNJ+s3bO+ehmL3c+T7//FKZouK9V+ZsQzs36O8BS
 fX5wA
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

Linux DTs stuff a value indicating if the USID is a USID or a GSID in the
reg property, the Linux SPMI driver then reads the two address cells
separately. U-boot's dev_read_addr() doesn't know how to handle this, so
use ofnode_read_u32_index() to get just the USID.

The Qcom pmic driver doesn't have support for GSID handling, so just
ignore the second value for now.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt | 94 ------------------------
 drivers/power/pmic/pmic_qcom.c                   | 13 +++-
 2 files changed, 10 insertions(+), 97 deletions(-)

diff --git a/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt b/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt
deleted file mode 100644
index eb78e3ae7703..000000000000
--- a/doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-          Qualcomm SPMI PMICs multi-function device bindings
-
-The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
-PMICs.  These PMICs use a QPNP scheme through SPMI interface.
-QPNP is effectively a partitioning scheme for dividing the SPMI extended
-register space up into logical pieces, and set of fixed register
-locations/definitions within these regions, with some of these regions
-specifically used for interrupt handling.
-
-The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
-interfaced to the chip via the SPMI (System Power Management Interface) bus.
-Support for multiple independent functions are implemented by splitting the
-16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
-each. A function can consume one or more of these fixed-size register regions.
-
-Required properties:
-- compatible:      Should contain one of:
-                   "qcom,pm660",
-                   "qcom,pm660l",
-                   "qcom,pm7325",
-                   "qcom,pm8004",
-                   "qcom,pm8005",
-                   "qcom,pm8019",
-                   "qcom,pm8028",
-                   "qcom,pm8110",
-                   "qcom,pm8150",
-                   "qcom,pm8150b",
-                   "qcom,pm8150c",
-                   "qcom,pm8150l",
-                   "qcom,pm8226",
-                   "qcom,pm8350c",
-                   "qcom,pm8841",
-                   "qcom,pm8901",
-                   "qcom,pm8909",
-                   "qcom,pm8916",
-                   "qcom,pm8941",
-                   "qcom,pm8950",
-                   "qcom,pm8953",
-                   "qcom,pm8994",
-                   "qcom,pm8998",
-                   "qcom,pma8084",
-                   "qcom,pmd9635",
-                   "qcom,pmi8950",
-                   "qcom,pmi8962",
-                   "qcom,pmi8994",
-                   "qcom,pmi8998",
-                   "qcom,pmk8002",
-                   "qcom,pmk8350",
-                   "qcom,pmr735a",
-                   "qcom,smb2351",
-                   or generalized "qcom,spmi-pmic".
-- reg:             Specifies the SPMI USID slave address for this device.
-                   For more information see:
-                   Documentation/devicetree/bindings/spmi/spmi.yaml
-
-Required properties for peripheral child nodes:
-- compatible:      Should contain "qcom,xxx", where "xxx" is a peripheral name.
-
-Optional properties for peripheral child nodes:
-- interrupts:      Interrupts are specified as a 4-tuple. For more information
-                   see:
-                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
-- interrupt-names: Corresponding interrupt name to the interrupts property
-
-Each child node of SPMI slave id represents a function of the PMIC. In the
-example below the rtc device node represents a peripheral of pm8941
-SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
-
-Example:
-
-	spmi {
-		compatible = "qcom,spmi-pmic-arb";
-
-		pm8941@0 {
-			compatible = "qcom,pm8941", "qcom,spmi-pmic";
-			reg = <0x0 SPMI_USID>;
-
-			rtc {
-				compatible = "qcom,rtc";
-				interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
-				interrupt-names = "alarm";
-			};
-		};
-
-		pm8941@1 {
-			compatible = "qcom,pm8941", "qcom,spmi-pmic";
-			reg = <0x1 SPMI_USID>;
-
-			regulator {
-				compatible = "qcom,regulator";
-				regulator-name = "8941_boost";
-			};
-		};
-	};
diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
index ad8daf43f06f..f2ac6494811d 100644
--- a/drivers/power/pmic/pmic_qcom.c
+++ b/drivers/power/pmic/pmic_qcom.c
@@ -66,12 +66,19 @@ static const struct udevice_id pmic_qcom_ids[] = {
 static int pmic_qcom_probe(struct udevice *dev)
 {
 	struct pmic_qcom_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	priv->usid = dev_read_addr(dev);
-
-	if (priv->usid == FDT_ADDR_T_NONE)
+	/*
+	 * dev_read_addr() can't be used here because the reg property actually
+	 * contains two discrete values, not a single 64-bit address.
+	 * The address is the first value.
+	 */
+	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
+	if (ret < 0)
 		return -EINVAL;
 
+	debug("usid: %d\n", priv->usid);
+
 	return 0;
 }
 

-- 
2.42.1

