Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E8CCED63E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B068689185;
	Wed,  9 Oct 2024 11:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mhxuTfNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A9089196; Wed,  9 Oct 2024 11:15:28 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2722B8916C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d2ddb61c8so1512306f8f.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465325; x=1729070125; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ZLum84mjuCXiydoHw4h8lxl3O2fj6xHhIlf9mM3a+c=;
 b=mhxuTfNslq3fUofgqecdVRsFhHx1AFnqo1eGZil+g+lu/CigHWlpwAO5GwWJPLonva
 qjMF9kawHcF+k4QRqQoswSbIJxsNYk2a/9TcppjsvhsNBh3569yC633sU2J6oYBEzn7B
 40d1me1EYb25QeYZseoVWOrbzf1JLjoKlEjJCKkazsRzs/BAxKZZh/dDtRns7C3zlcJu
 XBQw/kh4yue4N078CFv9nWICTSX//KZ9beZwPjq/IQJMXfPvWpXbxFmSlU1jaIQo8Ywh
 QLHEWlE+HHrk2ZEoy6E+kYpheXst+dOHr4mfFjUrXEmO19uGNCem5UhxRAX3N+r6b0za
 uz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465325; x=1729070125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZLum84mjuCXiydoHw4h8lxl3O2fj6xHhIlf9mM3a+c=;
 b=MmFQhufJD8lS/KQkqE35YmiapznOjbpn90Tlw4Jr/nNxNkoupB2jsmjrBG9+7B9jbZ
 BL7sqaiLECgaP59loMIF4vIzHFA1gpt5MhoncsyBcUNr5qPKJOT9dxTB7B/eyYIzmXBL
 f3N94Y2rxEsBlrOcavWEyjYZbe+cuEUVNM9BnAITvrWehUiolpvuOJ7X4+WrV2JyyL1/
 ZV1cPBDpJBw+bN7r1gLIYHp8F4GsQ97T42p2C7mAv4+Ezxf4f4c4SVjlCDgxAUuXLoZT
 EEc5cqyXKr7fyVaHv/mnBPjlb0LQ8lDRVn7bcO3/jgvWCQKDjkHtCBAeFbYORs9U91vf
 FCUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBYUsxpP/5ndpIDZj5vdNFtlycfQwAHbXNg0nmuoNq4q9zIQSF/Ru3/meVVLeHWWPsVivUNQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwzQeGiGFscCBTeb2HlZA5H23ojvCjkg6XDRzsqhqpQ9NSVis31
 jxPOPflQkZwgk+bQM3KfC4lXgL2xjePN6yvglz9npXfsjF5oOcbJH44zIKIbUErmG6jaLPfGUOB
 OCig=
X-Google-Smtp-Source: AGHT+IE4V/4yjBMx5z2FThtsn7aA0j5mGIoFWUo1FjKofaB7IKi1yNybj2lcHnybg4Ct2AiruhiWEA==
X-Received: by 2002:a5d:4ed0:0:b0:37c:c4c0:9b78 with SMTP id
 ffacd0b85a97d-37d3ab01196mr1380824f8f.48.1728465325498; 
 Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f270sm9865471f8f.21.2024.10.09.02.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 11:15:21 +0200
Subject: [PATCH 2/2] power/domain: meson-ee-pwrc: make sure to not enable a
 domain twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-u-boot-topic-fix-hdmi-v1-2-2479cd90c4ea@linaro.org>
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QqKlaNG2u18NoqfXoFDLKgPkKwXjhg4sGwQNKuvTmI4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBkmqWfTejNYWz+pX3trg035RyATW0CdSse5185t8
 lgwI8BGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwZJqgAKCRB33NvayMhJ0SAMD/
 9k6AAs9pzV5z+ZTr4itQbqcsERUNbvCPdpaSUZ+JfBxDbj7liKjs0EGKqxwmTf3RAgeRGX244ONbnA
 hNarb56pOAolU/68NNNnVwDWF3J8u7MaybglY+YsRIbq1CvJ3Y2Pir9uHRN6bcPBvUOb5NPlTCgp6v
 qT8M3tc3+eiWZbR18y7EiurGcPVWkuurIUASRzW/Hwuc7nmcvklHykP2vyXpzFvFWf2VfMl/olLAzJ
 d34CDA/m2nKUVRCiHTP3y2kOOHZN7k7zjBX81/mkv/wkmtcgddcCPWkvylvOPU4wMB37FGINvsOeMc
 isGSl70+qWAFRARRMXcd/rP0+cRGQSHdOI0/nX9yH/PFjXciNVzA7IlbOXmzjC5TEoWUAtysE596FN
 Nibd1PkRX1hY3kmbSHjHzSFV86CfhWJa/bbdrofY7UJ1KRje9tUWsQRLguXxjBO9lgRpSxARzG9Pc9
 HkMdhIBUpwGuIFNBjrL9ou1x9uLwWDTvzVguS8bsfztGlByZEsi6/QavhpgoEuFzGA4Klr9a2VAvSv
 nvOwc+C1ynFZB92eRV0/hzUPt8GAwFfFXjAxaNoU0StIm42i3mjyfFVQrWGzY45tqALSH9gxjLCWry
 xAzYx3gInkjbgP3ovEHGQ8VBNBHKzrUvf58hEr0C+lfJM9LiE/TQWpVKfnIQ==
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

The upstream Device Tree for GXBB/GXL/G12A was updated with VPU domain
shared between the VPU and HDMI node, causing a double enable.

Simply store the enable state and avoid enabling twice, fixing
HDMI output on all platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/domain/meson-ee-pwrc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 20e9f32b381..4d9f3bba644 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -60,6 +60,7 @@ struct meson_ee_pwrc_domain_desc {
 	unsigned int mem_pd_count;
 	struct meson_ee_pwrc_mem_domain *mem_pd;
 	bool (*get_power)(struct power_domain *power_domain);
+	bool enabled;
 };
 
 struct meson_ee_pwrc_domain_data {
@@ -306,6 +307,8 @@ static int meson_ee_pwrc_off(struct power_domain *power_domain)
 		clk_disable_bulk(&priv->clks);
 	}
 
+	pwrc_domain->enabled = false;
+
 	return 0;
 }
 
@@ -317,6 +320,9 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
 
 	pwrc_domain = &priv->data->domains[power_domain->id];
 
+	if (pwrc_domain->enabled)
+		return 0;
+
 	if (pwrc_domain->top_pd)
 		regmap_update_bits(priv->regmap_ao,
 				   pwrc_domain->top_pd->sleep_reg,
@@ -347,8 +353,13 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
 			return ret;
 	}
 
-	if (pwrc_domain->clk_names_count)
-		return clk_enable_bulk(&priv->clks);
+	if (pwrc_domain->clk_names_count) {
+		ret = clk_enable_bulk(&priv->clks);
+		if (ret)
+			return ret;
+	}
+
+	pwrc_domain->enabled = true;
 
 	return 0;
 }

-- 
2.34.1

