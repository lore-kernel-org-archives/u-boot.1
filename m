Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0569C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C66288761;
	Thu, 11 Jul 2024 18:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wvn+VWaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB1A887CE; Thu, 11 Jul 2024 18:47:10 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124AC88777
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so3232899a12.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716427; x=1721321227; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OF76tLlohvDjPr8qGLbtCRZpdV9zcWQISuqlg021S0o=;
 b=Wvn+VWaSbo2j2rJjo7OeeqLt+bFvr8ZPAttNgJyLiGZJXMce3ldahBFT+Wjo1gbbBB
 nru8PTPltNom9Hm5rV+JEtbnXBJi1gQdbmqJKDirLC97VuKwiwsg/gDD2vO7Cy8zOuTl
 1ZuKhq1cCfCT8VN5129AUJ0W/UY9wjBGe6IxI3piPetwRk/dgrLqwXxtz466uMLz7zCH
 eu6Efwvlw7ZAKWtn2P2/WM5oXViq5KZpFrfCP3/Dxy525ry0PWFTQpI9WmGScvzuA/Fv
 niJHRM6BPfYL+ABHCFw8ZgQ1tTi1l/ORnUpodSsEuO8itq3rdVKxk4GlorqUw5YDM1Gh
 vw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716427; x=1721321227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OF76tLlohvDjPr8qGLbtCRZpdV9zcWQISuqlg021S0o=;
 b=URtFhfRtZ9LqRMVWUl1P32m1Pud6UIkv+eHVZRlW2xqjQfCH96nJTsqVhLLOPaSb3z
 BGg0PccJG0sGut/JD3pPE/aZuaEv6UM1R4SOyrJQQloUQDmKQsynLrgvyAwjbu36hE2N
 wCs324RcQsiXhliJHSZ7En8pEig/ZLsTRj8VvKpiezrRpIM949pLMHz60DI9HtFabzl1
 JYwtEtcuHX+ru+DpzXvcooRsaso2PTn0LpLMQ4h2OqZtCkyK/dswEHHS8PvVMGymDdzi
 7TTdNoV/kBqNhdR3bbYvYZzc609HhXzUyXTmwlOl3cBrPZnEcyZsrRJAWTKgIjkFs1oI
 ZQwg==
X-Gm-Message-State: AOJu0Yx3To+ONsJ9yUD2smJ6u6VKdC69DMW46TFGnY6vK+SYQapceWgf
 8SL7jpxqSRv7/LbSgajngDAy8GlXJbpBxiPyE3lemlNFcDyydhi++Q6KVuiG4HA=
X-Google-Smtp-Source: AGHT+IETGGSnDq8CF0MQ3ybKXrQ9mCK9jucXi9Y+7CaEYI6sYaS0TuMsDf5C9NaH6K6xtQb77I6RxQ==
X-Received: by 2002:a17:907:846:b0:a77:f5fc:cb61 with SMTP id
 a640c23a62f3a-a799cd67784mr19872566b.0.1720716427605; 
 Thu, 11 Jul 2024 09:47:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:54 +0200
Subject: [PATCH v5 22/23] power: regulator: qcom-rpmh-regulator: add build
 infra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-22-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Pso8b/uVAl+mlHoL5Qsl7woxZlxMQtfdivEwIMBQyfo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxwUpMJbOcBg40tUC677lctCevBlNqC+Nqvq
 JQnL0QzKjqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMcAAKCRAFgzErGV9k
 tosTD/wNjfoHfn6tyMAD+/t18dXMSnfMZ1VTgju2yP6YDmSLcRJRY9z78/mAoexVyirnMw4UYyS
 sg9u0GvYgBWN5wD/xptK25ISltIdifjOJZYhIJHVGd6XpgWadFcvs/+hxjg3GV83MH3itx4sUFW
 4qPPlVJPqpOLsCmVJN6wIgS+Xtdu6tdETYMz0tunjQWDk0wsrk6m20jHs6obFUelvVwoKsmLtWO
 10O12KOfEMQbDEZOasHzlYxKMod9VkGD0XOeme1/9CJe6nAXDJW7i/xZh2I+TSr+gESozYqgkm8
 JbBKYBv3p87QOrGRZUgThjooL3+/9sU7waQCSqP+VDH+CsTPKRbFGFBOFq8MuThB+X1DKVLaXMk
 5XQ6A3g9+ZbzBKw1Xb6pNRRsgBo3ZtYQj90FRnsQNPzyh9h3Z1Ow7ATpjeqSU0DUn/LhbYKhXbd
 D4ocFRmBPHkALUCytCGZv2r8zdjbpogjP3iMTPbiePx87UfpPZoZlCbKwMTTcMn3jCwO5ZOcHZY
 7VNJuYmiw89bbHkp2ZkQuRnPkbfSmv9fQuuJty9gw6RZ5OgeslTi4yvrdc547vZpHq70a55tch1
 MwQRGajA9k6t4gaBB6U0svzyIohkZyvaukpjJmYdjbbIc7d6fqapmpKsVEfwZD/7vjkpuRCdhGj
 zjml1pjMsJt05eg==
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

Add Kconfig and Makefile entries for this driver now that it can build
for U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/Kconfig  | 8 ++++++++
 drivers/power/regulator/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 102ec7bc5f89..bc061c20d75e 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -215,8 +215,16 @@ config DM_REGULATOR_GPIO
 	This config enables implementation of driver-model regulator uclass
 	features for gpio regulators. The driver implements get/set for
 	voltage value.
 
+config DM_REGULATOR_QCOM_RPMH
+	bool "Enable driver model for Qualcomm RPMh regulator"
+	depends on DM_REGULATOR && QCOM_RPMH
+	---help---
+	  Enable support for the Qualcomm RPMh regulator. The driver
+	  implements get/set api for a limited set of regulators used
+	  by u-boot.
+
 config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_GPIO
 	select SPL_DM_REGULATOR_COMMON
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index f79932d83307..56a527612b74 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -20,8 +20,9 @@ obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
+obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o

-- 
2.45.2

