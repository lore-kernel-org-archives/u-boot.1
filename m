Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30D4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B611888765;
	Thu, 11 Jul 2024 18:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoJA4RH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B317887D9; Thu, 11 Jul 2024 18:47:07 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A61788795
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eea8ea8bb0so20067891fa.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716423; x=1721321223; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GRz+XTlCpnsYYi0KK9pzBnfO6FEF2vig2L6TEuG8pO8=;
 b=KoJA4RH4Ggegk59UiWB+WcLdkYX08RauZ5bk0ZSzIkC2/1msjCaNhBt6NHy3lFWesX
 54Xz/GmcojeiGTn1Clwiuzrbae4DkOo6FoVmvrHHL0w0aFpDwBuIGwnWjS/KMxqo8cOA
 LlGos7Mv9j1i7s9BXOYfnDCoxIoebv2f6dy75GerL+osI/Toi2Ej2Kn8zGJ0bZxi9N+V
 1tY/RVsL2M28jukZO0Cib4Cs4fGpsnyDnqhgdxQkAzJuz8as8Q8co/qSkINsdmeZAL84
 Modt+g4voI1h49BAl3v8iTV5O0Ii2jQ+lt2WIEizTIWmCWH1fP9HKTRWdCFcK8ieo/FJ
 f23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716423; x=1721321223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRz+XTlCpnsYYi0KK9pzBnfO6FEF2vig2L6TEuG8pO8=;
 b=DwMzlU0J7ZNPRi1A/AU9KwBEfkz5p+GTZ4ac9ZgBRzZc5zVkQ7lWpBwjKpb+Q452Mg
 j9XvVnWCtkhIeycBNdVe9nTCxn7BYtaHGzysyy0Ihj15vHLXp9vUB+KjFjLv2qkltuYw
 IHkfJntnt7vgd3lHeNCjDcv+r7eZrOEujaDXSSzYvSLx2VSL8bPtp9CI1Q/90Bx/ELru
 2LUbymTlsh5w4Aknqcpicjr1I4DrPg/Y7VfcV158u9XTFhfB1KCVTlKGPGtev5Eb19tj
 NMJHtDeEtfBVTEK9Lj54aC9/uicR+rijMGUkyDlDdsigMnzqcxvzDOgzfFWN6xBstx+5
 eolA==
X-Gm-Message-State: AOJu0Yy2iJLZhIbtggr5asgcqVNu2TBLsy5Rhd9ts3fHIj/QFn78IgVz
 xmxTUGwo5gIgOsv/vYaE29Tz83yg7fUSuDD4IROZGMXOBdaoPD6RYaiz6mz6AJnAF1yAB6iftU3
 G
X-Google-Smtp-Source: AGHT+IHhdZvsNl4SJsrD0rAFA5lqjgp16NuE1l8PDYMdI1XbXzMjMY24x8i36/oTt0TVRYoF+Iv5Qw==
X-Received: by 2002:a2e:b901:0:b0:2ec:5ff1:2271 with SMTP id
 38308e7fff4ca-2eeb30e459dmr73968601fa.18.1720716422932; 
 Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:50 +0200
Subject: [PATCH v5 18/23] power: regulator: qcom-rpmh-regulator: adjust
 structs for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-18-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=U6yGComMBKaDzfG1OpRVhDZGEEuD6iB3cAcmWsZo69M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxwEKw+6GEKeB584FAR2h0o7+1l53GR44Sgw
 4Iy4FIiEJqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMcAAKCRAFgzErGV9k
 trjaEACZyFdi4SypaeuJx9sEVBwEVMMFnI0epnBRqLE/S78uuq7P/rvcI6MHsRfGDnBLTYJGDMx
 FeU4uEwdgxLFmGtYDeoRg/SWIVoOdmyiCA+mf79xx/8AdIy3mS9OdFh3ZgFOkbSJJ6CJSq0vQDm
 hM9sbMClm53HxHW3oI50ome9nDBQ4LBF0Y7fK5yTFx+OgtK1g3v/Fhzkj/OC/2x96UnFrRmrjuo
 GFQ409VV/Dz+DFgjj3dGudBlh6KV7KAcxD3JO8bs0fmLAqwf9vnl00KYMYfg1Kp9uF53tK6SZR+
 esnq8T3RslDTd/Lv0Z9MpbS8DUHyAUB4UWyvJb7/DPYgdY4XH5wxaH3tUCK+66y3v/3Ru+Z46aE
 UYVbjUAtrctimQt40YW+rj6TW8e6COf+zxCnv2VkB30tLgGEIxId2rwL35qGcq/LvYThOJ0oysw
 oCyGKVXYWATf/oic7r6jDtmffx2pJ0OqHcobT0Xy5yXAhImInu6ho6femxZrft4CB4OxQKjUvOi
 iHI0J/ObfDPtilTrVLzppY+wlP6ezpzrxf4ULbWAFczolR3yXW5FMru/als5pDeRgH4dZV24S6l
 KtW/uzEv4B1UZrWk0dS8efGijLSGuo4vi+bPgFtasFUja1JL5loXPIz1Kky6jNr909IL6l2ZO7i
 quFONvugdgrNtuw==
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

Switch to our linear_range helpers and remove unused/unsupported
linux-isms.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index d0acee9f558e..089623f3a2b9 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -102,13 +102,12 @@ struct linear_range {
  * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
  * @regulator_type:		RPMh accelerator type used to manage this
  *				regulator
  * @ops:			Pointer to regulator ops callback structure
- * @voltage_ranges:		The possible ranges of voltages supported by this
- * 				PMIC regulator type
- * @n_linear_ranges:		Number of entries in voltage_ranges
+ * @voltage_range:		The single range of voltages supported by this
+ *				PMIC regulator type
  * @n_voltages:			The number of unique voltage set points defined
- *				by voltage_ranges
+ *				by voltage_range
  * @hpm_min_load_uA:		Minimum load current in microamps that requires
  *				high power mode (HPM) operation.  This is used
  *				for LDO hardware type regulators only.
  * @pmic_mode_map:		Array indexed by regulator framework mode
@@ -119,15 +118,15 @@ struct linear_range {
  *				in device tree to a regulator framework mode
  */
 struct rpmh_vreg_hw_data {
 	enum rpmh_regulator_type		regulator_type;
-	const struct regulator_ops		*ops;
-	const struct linear_range		*voltage_ranges;
-	int					n_linear_ranges;
+	const struct dm_regulator_ops		*ops;
+	struct linear_range			voltage_range;
 	int					n_voltages;
 	int					hpm_min_load_uA;
-	const int				*pmic_mode_map;
-	unsigned int			      (*of_map_mode)(unsigned int mode);
+	struct dm_regulator_mode		*pmic_mode_map;
+	int					n_modes;
+	unsigned int				(*of_map_mode)(unsigned int mode);
 };
 
 /**
  * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
@@ -148,23 +147,22 @@ struct rpmh_vreg_hw_data {
  *				not
  * @bypassed:			Boolean indicating if the regulator is in
  *				bypass (pass-through) mode or not.  This is
  *				only used by BOB rpmh-regulator resources.
- * @voltage_selector:		Selector used for get_voltage_sel() and
- *				set_voltage_sel() callbacks
+ * @uv:				Selector used for get_voltage_sel() and
+ *				set_value() callbacks
  * @mode:			RPMh VRM regulator current framework mode
  */
 struct rpmh_vreg {
-	struct device			*dev;
+	struct udevice			*dev;
 	u32				addr;
-	struct regulator_desc		rdesc;
 	const struct rpmh_vreg_hw_data	*hw_data;
 	bool				always_wait_for_ack;
 
 	int				enabled;
 	bool				bypassed;
-	int				voltage_selector;
-	unsigned int			mode;
+	int				uv;
+	int			mode;
 };
 
 /**
  * struct rpmh_vreg_init_data - initialization data for an RPMh regulator

-- 
2.45.2

