Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F6CCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 16:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3CA88176;
	Wed, 10 Apr 2024 17:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nYQ/0lJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7351881B9; Wed, 10 Apr 2024 17:59:51 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BBC8815B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so2665083f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764789; x=1713369589; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBSNxz5F9Gk1/5Z3CGIi5kb5sg8VWXyRTlXhpfzbQLI=;
 b=nYQ/0lJr+a5/oBUsPJVN6AIrh7j2X9Tb3HdHxBhW1Ub5q2DBCDiMzmShd1u/4BjmJq
 U16S4IAQd/Rut8nBgIZNqga0rUfBUkGGhfbBmoB8AFhv5ScaUZHGU4tkYoPxE+52OJZL
 ed85dJQT+zfWHWWYNnZkgodLArXWA/DI/FV5bE60OCdm4uj33ZRS0QFKTsKpEWFYBhIn
 IdxMOpkvT6GtFTqVSW2Q1VakgFDX7B17noNH9k2geDRbvqMIPdzyCAuGNPQsz5aklhnN
 1c5Sk39ZsMGiRNFaUWSznWW2oDA9ozu4/bH2PJbo+g61YVICtZa83HZ2yG30aTNQjumH
 qcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764789; x=1713369589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBSNxz5F9Gk1/5Z3CGIi5kb5sg8VWXyRTlXhpfzbQLI=;
 b=L63Q7FWYJDfNS76cuwQvBWCjLwrlBCfjGpNdRKCJL4OKl96rwzmzIwXXJg1pp7wO77
 KdWcAxiUbNIgkm96fEvlbxJyR8F6JBFfQWZv2pziZlsTZkxDGTEUlUZq7lZNbp8YoLkH
 gQpyVjnIwjkzWVBWbCR82fa5pjfFcMEySijMKWtwG4et+W+2ZhI+HOUa9ro+87nkBcGh
 X4NpKG17i0WJ4lqM5SG7La6Glb1wgXMB7FVLq7ePa/UNhK6ekAH8FoyDq4Lw6bpIOWL/
 j9Hb8mTj+iiGiNM7Kyf+KDtsDQedlYIlPr8KasnTNdaCWslCcVmGzdGMJyzbjARF+dDb
 F7bA==
X-Gm-Message-State: AOJu0Yxa8WNVfS2oJee1jksQLCkDzMBh1ID5m/B3Cx+ZXngaSus+4ejV
 h8O5Q4SePn60+V4Lvbqppca4jbeA8QqTfJPnnVYtH9/0/ohYHP9SKtZBlxYQbws=
X-Google-Smtp-Source: AGHT+IGJvu5B6fbWLYe14ZImWiuOqxSooJmGvbaN8h5i6HzLqoisIbziB8YyZnQgNcAYYBvld9C9pw==
X-Received: by 2002:adf:fd4b:0:b0:343:6b42:b3bb with SMTP id
 h11-20020adffd4b000000b003436b42b3bbmr37580wrs.31.1712764788303; 
 Wed, 10 Apr 2024 08:59:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00343ad4bca7dsm14039431wru.85.2024.04.10.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 08:59:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Apr 2024 17:59:44 +0200
Subject: [PATCH v2 2/3] button: qcom-pmic: move node name checks to
 btn_data struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-topic-sm8x50-spmi-clients-v2-2-783e20d66c25@linaro.org>
References: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
In-Reply-To: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JuJX938A0kKhn4aUDQEOACwit9CMWv30OBUpj8p+Arg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrdxaSQstkC1wcbToRFwG68nyvuoabvOXXPYKw0n
 S+0UKq+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3cQAKCRB33NvayMhJ0ZckEA
 DBJ7+8cu1Yst6HGdS36ZaXu3WdIxo1mADlH3yvVZLKQt8QQDPuifRBCG0grDqRPPJYX3Nt6SqF9Yk6
 30w9+L2lQi+vYsH9SDj8T4FLYeXT/EDnV/sBDM6EDptl397zqvkY5bNhAt873SCbTO3btct6GKsMMA
 qOnEsUcnQ97vQYj5ugOIOn2jC1XA28nciffzXrOuu5HO9XM7VTxruwI+SprgCclbYHjOfDe4NmTQ8L
 81ryjUGVxoIv2ivHT6OSQpgMPDIwrALZw4Y2UNUMftM76sk+H3o5ueztpuiey4sveKYu60+acZeOw1
 O6AsdelaAFqkFvbPqzHg5MilwsIXjLycIlc1hBhqG7jNl3q4e6rijwURitcDjcK6V0t89R5ChXIIrI
 B4/JmG/lDNw/5aOeM+3iLkebaEd2M0fTM69T4BJg8VkULjYyHJgwZumSqJSAMTHoCrGgAizdq9+vnx
 21QmqXAgC3+NNdzMJBOUBRbe9JCHyNJUB9wR9OGCWDUaZCpzgroOzmQlqbAV7HRXAwmfUG8GK1A8UO
 gXuX0HzLzAbeRYIwnc+SOjv5APKbwmVGnG7xh49AMf4OdJ1L68tOSCh3Bn1ogfeeGTYPVfNf9w0kgR
 5WC9Y+si3Jp1qJJE1K4H63LpGQd6ctnoscNA8dtulLp9WIyq2qT/Nh+HTeUg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Move node name checks to a proper data struct with all information
for the supported subnodes.

Replace the key offset defines with the Linux driver ones.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 84 ++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index bad445efa86..f6da958097c 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -19,6 +19,13 @@
 #define REG_TYPE		0x4
 #define REG_SUBTYPE		0x5
 
+struct qcom_pmic_btn_data {
+	char *compatible;
+	unsigned int status_bit;
+	int code;
+	char *label;
+};
+
 struct qcom_pmic_btn_priv {
 	u32 base;
 	u32 status_bit;
@@ -27,11 +34,8 @@ struct qcom_pmic_btn_priv {
 };
 
 #define PON_INT_RT_STS                        0x10
-#define KPDPWR_ON_INT_BIT                     0
-#define RESIN_ON_INT_BIT                      1
-
-#define NODE_IS_PWRKEY(node) (!strncmp(ofnode_get_name(node), "pwrkey", strlen("pwrkey")))
-#define NODE_IS_RESIN(node) (!strncmp(ofnode_get_name(node), "resin", strlen("resin")))
+#define  PON_KPDPWR_N_SET		0
+#define  PON_RESIN_N_SET		1
 
 static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
@@ -52,10 +56,39 @@ static int qcom_pwrkey_get_code(struct udevice *dev)
 	return priv->code;
 }
 
+static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
+	{
+		.compatible = "qcom,pm8941-pwrkey",
+		.status_bit = PON_KPDPWR_N_SET,
+		.code = KEY_ENTER,
+		.label = "pwrkey",
+	},
+	{
+		.compatible = "qcom,pm8941-resin",
+		.status_bit = PON_RESIN_N_SET,
+		.code = KEY_DOWN,
+		.label = "vol_down",
+	},
+};
+
+static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_pmic_btn_data_table); ++i) {
+		if (ofnode_device_is_compatible(node,
+						qcom_pmic_btn_data_table[i].compatible))
+			return &qcom_pmic_btn_data_table[i];
+	}
+
+	return NULL;
+}
+
 static int qcom_pwrkey_probe(struct udevice *dev)
 {
 	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+	const struct qcom_pmic_btn_data *btn_data;
 	ofnode node = dev_ofnode(dev);
 	int ret;
 	u64 base;
@@ -64,6 +97,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 	if (!uc_plat->label)
 		return 0;
 
+	/* Get the data for the node compatible */
+	btn_data = button_qcom_pmic_match(node);
+	if (!btn_data)
+		return -EINVAL;
+
+	priv->status_bit = btn_data->status_bit;
+	priv->code = btn_data->code;
+
 	/* the pwrkey and resin nodes are children of the "pon" node, get the
 	 * PMIC device to use in pmic_reg_* calls.
 	 */
@@ -87,23 +128,10 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 
 	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
 	if (ret < 0 || (ret & 0x7) == 0) {
-		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
+		printf("%s: unexpected PMIC function subtype %d\n", dev->name, ret);
 		return -ENXIO;
 	}
 
-	if (NODE_IS_PWRKEY(node)) {
-		priv->status_bit = 0;
-		priv->code = KEY_ENTER;
-	} else if (NODE_IS_RESIN(node)) {
-		priv->status_bit = 1;
-		priv->code = KEY_DOWN;
-	} else {
-		/* Should not get here! */
-		printf("Invalid pon node '%s' should be 'pwrkey' or 'resin'\n",
-		       ofnode_get_name(node));
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -114,12 +142,20 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 	int ret;
 
 	dev_for_each_subnode(node, parent) {
+		const struct qcom_pmic_btn_data *btn_data;
 		struct button_uc_plat *uc_plat;
 		const char *label;
 
 		if (!ofnode_is_enabled(node))
 			continue;
 
+		/* Get the data for the node compatible */
+		btn_data = button_qcom_pmic_match(node);
+		if (!btn_data) {
+			debug("Unknown button node '%s'\n", ofnode_get_name(node));
+			continue;
+		}
+
 		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
 						 ofnode_get_name(node),
 						 node, &dev);
@@ -128,15 +164,7 @@ static int button_qcom_pmic_bind(struct udevice *parent)
 			return ret;
 		}
 		uc_plat = dev_get_uclass_plat(dev);
-		if (NODE_IS_PWRKEY(node)) {
-			uc_plat->label = "pwrkey";
-		} else if (NODE_IS_RESIN(node)) {
-			uc_plat->label = "vol_down";
-		} else {
-			debug("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
-			       ofnode_get_name(node));
-			device_unbind(dev);
-		}
+		uc_plat->label = btn_data->label;
 	}
 
 	return 0;

-- 
2.34.1

