Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D9110A3D81
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 12:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D3583FD3;
	Thu, 26 Mar 2026 13:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EdjafmLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACE0838BB; Thu, 26 Mar 2026 13:08:31 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A767983FAF
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 13:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso5109965e9.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774526909; x=1775131709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/PAU7Ix1+nnfYVd+6n5LSymV23ji6LbgTx1i6i6WXQ=;
 b=EdjafmLskcXoL+shhN8MBPO6bnZ0f/O/tQA2rMs+AKe6EyvOyYTQHgAr9WMXgihkcT
 PAitVStCOEMwwsIc+drHHKQH4+I1knrJbK2JZcK+a+RFSlpkxy9j3v53z0ZD5etH0nKd
 Fke5rz+eXdDQ2O7vVp17G8dvkzYNipln4y8Cg/IwaAAyvrG/g9dftCI7v4ZNwVdSNoQd
 CTWHmDaephzomkeBhfrh6Im+fiKSdbYXCaBS9NZfesg18u6X5vwcRsmUjGa9VBm8s+4y
 bAcZIzAyLcnb9X9ccAIIMx5h5dIvV+87e817GfNY69M+Z4+vyYPlWn6G0BMFKdvHwoSl
 otnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526909; x=1775131709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/PAU7Ix1+nnfYVd+6n5LSymV23ji6LbgTx1i6i6WXQ=;
 b=DUeMXRBDwMXE//ppWLPOQ2CeIanY5dhhlBG9zROTmVYIW1nDtWrJ+SDN6UsNDQDpzc
 y2hjO/XZOhUSnlHcNGD1J47Q1lw5WLqT5OEpK6ak2rsSIE8YLlVrmp/b9ET45Hc3sLW1
 eqQKyq2T8yEk09aFFhRPK6R7gR+yebI+3pI+TkojmiBj8Eh/Blz/G1Zmjg7B1Rn04drA
 Z/YK6W0XREvtJ/NgorpFKqAVwE3xsczqiFYYawKSkHFhrJWPSxP+Sh8S5cVDi6wib/RS
 NULUIOlpsYTJ6+ZzlSNsGVntaN/zhMlRiX4oMTQ9WTB7PFiHkuIrA8HswUIJ2SccqEJq
 FKgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn5ywuPyYH8OsxvifvPycrqOJjOWh/m++0xokrcQ6tsHXzi25kAIet1x4OeQmxMSLEfCgjV/I=@lists.denx.de
X-Gm-Message-State: AOJu0YwsT2TRhy6847+erGjQdfSS9Ri3f3R8AXweRV79qFPY8pSInEzE
 aD/TZXWFQUkftb1THwvy46dsqkKK4tU/JxBajxckmBe09aSK8Rvr1+fUWHxrXeJ9EK0=
X-Gm-Gg: ATEYQzzkokxCHBDDTwXdtmjFF2OyHKghUBuX7MNlGC7E5CWyI3zi4gDv0hryxTrG6Ki
 sZVsLI3FpXUY20oZKUyinZXxWz6zmubNYOQTyPc4f9FDqzxiavrQcZdhqDnqvIuVI88fdLtzqBB
 srqqnSfddnUIQ7RFSPxcV5xSp/kqkWzyhAoBOx+CcD8p8a0XhYcl/SM9Fn66+J4KEHlvwHt6hQv
 8iVsSSPEIXvG39GXnRT1gU37usVZQsESCssQGGkKQGehCu0U6gl/Io8t/FBcOwOePHMq629Y2pr
 d9QAdhFllAyChudHA68oJ+Ba961m08SAs9FuA/Tp5pRaHJH2IGWp4OpVjBvMAqreYH0UdwsNIWx
 lxfEX3OFH2A2ldeZZzz0OwMKZAqUmuq0wFSeGIHbdzy7fAu1RVRA3ENuR7Lm6pmDZqJbdvn4CdJ
 uptIs9Qhh/wwqmkey2Mi8PPMLMg9Oa
X-Received: by 2002:a05:600c:3b12:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48715fc3677mr108318935e9.5.1774526908928; 
 Thu, 26 Mar 2026 05:08:28 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722ca344dsm22710405e9.12.2026.03.26.05.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:08:28 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:08:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 2/2] pinctrl: scmi: Use standard device tree pin muxing format
Message-ID: <46f9b46210436e73d17a866424a00529439ce1ba.1774526652.git.dan.carpenter@linaro.org>
References: <cover.1774526652.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774526652.git.dan.carpenter@linaro.org>
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

In the original code, I wrote a custom pin muxing parser but the
upstream device trees wouldn't accept something like that so it would
have complicated mergine the device tree files.

Use the standard device tree format with function and groups:

	pinmux1: pinmux1 {
		function = "f_gpio1";
		groups = "grp_1", "grp_3";
	};

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-scmi.c | 151 ++++++++++++---------------------
 1 file changed, 54 insertions(+), 97 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 63d4f8ffeb54..fa31b573f31e 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -33,20 +33,6 @@ static const struct pinconf_param pinctrl_scmi_conf_params[] = {
 	/* The SCMI spec also include "default", "pull-mode" and "input-value */
 };
 
-static bool valid_selector(struct udevice *dev, enum select_type select_type, u32 selector)
-{
-	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
-
-	if (select_type == SCMI_PIN)
-		return selector < priv->num_pins;
-	if (select_type == SCMI_GROUP)
-		return selector < priv->num_groups;
-	if (select_type == SCMI_FUNCTION)
-		return selector < priv->num_functions;
-
-	return false;
-}
-
 static int pinctrl_scmi_get_pins_count(struct udevice *dev)
 {
 	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
@@ -98,6 +84,38 @@ static const char *pinctrl_scmi_get_function_name(struct udevice *dev, unsigned
 	return (const char *)priv->function_info[selector].name;
 }
 
+static int pinctrl_scmi_get_function_id(struct udevice *dev, const char *function)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+	int i;
+
+	if (!function)
+		return -EINVAL;
+
+	for (i = 0; i < priv->num_functions; i++) {
+		if (strcmp(priv->function_info[i].name, function) == 0)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int pinctrl_scmi_get_group_id(struct udevice *dev, const char *group)
+{
+	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
+	int i;
+
+	if (!group)
+		return -EINVAL;
+
+	for (i = 0; i < priv->num_groups; i++) {
+		if (strcmp(priv->group_info[i].name, group) == 0)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int pinctrl_scmi_pinmux_set(struct udevice *dev, u32 pin, u32 function)
 {
 	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
@@ -120,96 +138,35 @@ static int pinctrl_scmi_pinmux_group_set(struct udevice *dev, u32 group, u32 fun
 
 static int pinctrl_scmi_set_state(struct udevice *dev, struct udevice *config)
 {
-	struct pinctrl_scmi_priv *priv = dev_get_priv(dev);
-	/* batch the setup into 20 lines at a go (there are 5 u32s in a config) */
-	const int batch_count = 20 * 5;
-	u32 prev_type = -1u;
-	u32 prev_selector;
-	u32 *configs;
-	const u32 *prop;
-	int offset, cnt, len;
-	int ret = 0;
-
-	prop = dev_read_prop(config, "pinmux", &len);
-	if (!prop)
-		return 0;
-
-	if (len % sizeof(u32) * 5) {
-		dev_err(dev, "invalid pin configuration: len=%d\n", len);
-		return -FDT_ERR_BADSTRUCTURE;
-	}
-
-	configs = kcalloc(batch_count, sizeof(u32), GFP_KERNEL);
-	if (!configs)
-		return -ENOMEM;
-
-	offset = 0;
-	cnt = 0;
-	while (offset + 4 < len / sizeof(u32)) {
-		u32 select_type  = fdt32_to_cpu(prop[offset]);
-		u32 selector     = fdt32_to_cpu(prop[offset + 1]);
-		u32 function     = fdt32_to_cpu(prop[offset + 2]);
-		u32 config_type  = fdt32_to_cpu(prop[offset + 3]);
-		u32 config_value = fdt32_to_cpu(prop[offset + 4]);
-
-		if (select_type > SCMI_GROUP ||
-		    !valid_selector(dev, select_type, selector) ||
-		    (function != SCMI_PINCTRL_FUNCTION_NONE &&
-		     function > priv->num_functions)) {
-			dev_err(dev, "invalid pinctrl data (%u %u %u %u %u)\n",
-				select_type, selector, function, config_type,
-				config_value);
-			ret = -EINVAL;
-			goto free;
-		}
+	int function_id, group_id;
+	const char *function;
+	const char **groups;
+	int group_count;
+	int ret;
+	int i;
 
-		if (function != SCMI_PINCTRL_FUNCTION_NONE) {
-			if (cnt) {
-				ret = scmi_pinctrl_settings_configure(dev,
-								      prev_type,
-								      prev_selector,
-								      cnt / 2, configs);
-				if (ret)
-					goto free;
-				prev_type = -1u;
-				cnt = 0;
-			}
-			scmi_pinctrl_set_function(dev, select_type, selector, function);
-			offset += 5;
-			continue;
-		}
+	ret = dev_read_string_index(config, "function", 0, &function);
+	if (ret)
+		return ret;
 
-		if (cnt == batch_count)
-			goto set;
+	function_id = pinctrl_scmi_get_function_id(dev, function);
+	if (function_id < 0)
+		return function_id;
 
-		if (prev_type == -1u)
-			goto store;
+	group_count = dev_read_string_list(config, "groups", &groups);
+	if (group_count < 0)
+		return group_count;
 
-		if (select_type == prev_type && selector == prev_selector)
-			goto store;
-set:
-		ret = scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
-						      cnt / 2, configs);
+	for (i = 0; i < group_count; i++) {
+		group_id = pinctrl_scmi_get_group_id(dev, groups[i]);
+		if (group_id < 0)
+			return group_id;
+		ret = pinctrl_scmi_pinmux_group_set(dev, group_id, function_id);
 		if (ret)
-			goto free;
-		cnt = 0;
-store:
-		prev_type = select_type;
-		prev_selector = selector;
-		configs[cnt++] = config_type;
-		configs[cnt++] = config_value;
-		offset += 5;
+			return ret;
 	}
 
-	if (cnt)
-		ret = scmi_pinctrl_settings_configure(dev, prev_type, prev_selector,
-						      cnt / 2, configs);
-free:
-	kfree(configs);
-	if (ret)
-		dev_err(dev, "set_state() failed: %d\n", ret);
-
-	return ret;
+	return 0;
 }
 
 static int get_pin_muxing(struct udevice *dev, unsigned int selector,
-- 
2.53.0

