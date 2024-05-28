Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBA4C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8878848A;
	Tue, 28 May 2024 10:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zVPPUJOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE1488460; Tue, 28 May 2024 10:32:06 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58B788458
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e95a1eff78so6509301fa.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885124; x=1717489924; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CD/V2oiNsUpOHKjezbUTUwiLCQwPADw8OLXT/uFcZdg=;
 b=zVPPUJOFJ1gpbfxPLGBLW16bWE2c3hAkNL/wi04cXXEKNGHltYFKXzd+mV2IRjcM61
 QrialesXJH4GoMyPmtd01hBBNBtt8FzGDgt0BvaLTgPL9Z8mcbFszC6ETH+ZxAf3oQf5
 60MnX6g6I8CQdpn8vncsTEnkwI6KQvLfyw780B1fSB+PJHvjYv/+GxSZZCeBlDDnq4QG
 1QPYm1ed1ucLGxm/bWH95+Gl78CHGZl5EPgQ9W5WkIvTBFk1L+mjKxOz3fm4i23B8DOJ
 mNQn9w+U9uWUZnm21q5FqgNUjzqxXZG47SRnxwjo/PxFdOxSaiWSZ9SJKiPocIkflZEi
 47Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885124; x=1717489924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD/V2oiNsUpOHKjezbUTUwiLCQwPADw8OLXT/uFcZdg=;
 b=UnozMUV4ahEe1lo4ML2T9FuHPK7qUfQfUNsxCt/0lOdUA7ldqg2DVJRRGDejZcNsuE
 d43SEEzxWYcrM2zNDj2M/6psZ82dFX9CClYrbKh7Gf/cmuI6qSGZiDkyz5UE+mZG4a09
 SaRTPCjXgzxPGxckyPejoqF3saLdcmNAtVZ+5QKFbwf4oXr84X7E56CX/mMTFowXif29
 PXI2NIYs8YzYgk1KD+Puyk+PFDVIAgcF5+FOgCKtobgG+fB1+SgeQGT58zMr465QK0hK
 gGDNGJEFUPYefhp8rDzxmqMWxBiCyyMvNcSfd48IuIh/zLWrV6CqYaKF/pV4wgBuyrjF
 uY+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVXFFWSgGG5qH8zWgO+s+eTo5DvP1U+fU17dsliDXrPnalhTcZ5D8wB0N6bePBJZyXskn/9kUxR/U7jmiUMNnMZ4y8PQ==
X-Gm-Message-State: AOJu0YwRN2GZoUGUoSyBeLhaBySX22JvJfPg8AHYq6i0Akbs7cjrFVf6
 1RBMH0c/fEd4+t8aE26q+vUUJB5BU69aPjg1o/LNDEQw7u4/e6xPqbt+FQChiG+VIOTAHpg2srn
 X
X-Google-Smtp-Source: AGHT+IH3o9EnDBKQ+H/FfRcvgzLOHRCV6cJ+YV0BmvMg1n5Y8GwXQB7NcLm/oZqGrz+vgHPpr0HtBg==
X-Received: by 2002:a05:651c:b0d:b0:2e9:6d4f:e57 with SMTP id
 38308e7fff4ca-2e96d4f143dmr81983071fa.11.1716885123927; 
 Tue, 28 May 2024 01:32:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:32:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:31:57 +0200
Subject: [PATCH 5/5] pinctrl: qcom: sm8650: add special pins pins
 configuration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-5-54d1e9ad7dfa@linaro.org>
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GyUjNQLaqtuAEqtoXOgHoCzKRLac7lezt88J6C48HlY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ/KaGNcurp8h6y6q4kHq2KXkvONLxxwaPCgkU6
 ZspyKx+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfwAKCRB33NvayMhJ0aN0D/
 9j5PbFmfggnEsJTnoDwWdxQGVfsmAGTyxTIYncgDGB9c3HOhllR7APPTJvC3mmoX3Y59R8dRo8V7k4
 ZW2BJJfdM0l3YjJcMpBKEck5qi8m4sXyv3Q0WRG36QiXP1QPx8qrN05qtLqh00TVSWuH6bVVUBV1+d
 QC1ixwy5CuxnZKdTCM0tZsw9NmP4qt/pHEdTgUrSU1OtiFU8Kb3FAD1bsEDUFQoCZ0A3r1K7CQ6wFf
 hFf17OQCmrIt07kZL7qHIcIZ/1CSqeXMq21+DKZIZqmVlR7lbfOs56Iw4u52ZnYCznbdp0zROc3OCt
 DzsDNP3j2YJ7b289N/7ht0lc9+5NmKsfTIF3D0PSccK9wrIkr+THF/DtfeB3/AdxlousEjE71lK9Zi
 1mOVHRwcW68dpLNzlsWVLvPHwVbyEXynZ07GDt40F9MOaCgKDZnuGCqmrZPevfqQwOTVwKuQFMLOTe
 Qf+vCucIdHO9btGEh+uWXGZKeidGC67qFwRZwOoesAOLInh7a/Natgy7BY4KdmXaRAjPPzVj/6oDXn
 3O6jXgpEPl+mJzVqkClATcoc6uZ1wcr3SX9pRp1Fukry4mqv9uyg1FUdDdoJOyK3JXFNN2sqUjoQja
 379jy02tBulXN/WUsArD50Q4esEeAF6MrGyFEo2HYoOZGdWC7PgJ8ssW534A==
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

Add the special pins configuration data to allow setup the bias
of the UFS and SDCard pins on the SM8650 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8650.c | 42 ++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
index d6cc1bbdda8..58fc94e71ac 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8650.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
@@ -18,6 +18,37 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"gpio", 0},
 };
 
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, ctl, io)			\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = io,				\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xde004, 0xdf000),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xd6000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xd6000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xd6000, 9, 0),
+};
+
 static const char *sm8650_get_function_name(struct udevice *dev,
 						 unsigned int selector)
 {
@@ -27,15 +58,9 @@ static const char *sm8650_get_function_name(struct udevice *dev,
 static const char *sm8650_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	static const char *special_pins_names[] = {
-		"ufs_reset",
-		"sdc2_clk",
-		"sdc2_cmd",
-		"sdc2_data",
-	};
-
 	if (selector >= 210 && selector <= 213)
-		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 210]);
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 210].name);
 	else
 		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 
@@ -52,6 +77,7 @@ static struct msm_pinctrl_data sm8650_data = {
 	.pin_data = {
 		.pin_count = 214,
 		.special_pins_start = 210,
+		.special_pins_data = msm_special_pins_data,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sm8650_get_function_name,

-- 
2.34.1

