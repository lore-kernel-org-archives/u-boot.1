Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2DAC624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F3AE81024;
	Wed,  2 Sep 2026 14:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_3UI5jk_xOi; Wed,  2 Sep 2026 14:29:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359384;
	bh=HXBVPfRj/568RVTlealbF3SdwhDO6BlhKmYJIT9LJNo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j0vRgoQDA7BjpcIWVJs6O01uttlD3GhTfaAZvPoso5k77uB11vfi/hXiar8bKNi7y
	 q/fmGLNL+GkAZg6nfpzVDHbyVAdrnJB9+FuSNeUgIEzxSJ2Awtaq5GvyP7c5yb7pG4
	 8yYJTuXeDybJ2JLEBi7leu8fkM0amxxSL4p/3F7aHSq9bmPmSg5/y/F2523gzFVKD9
	 G191x4Q8nOO7bYAib6p2t7KEt730waMCEx7RGQu5wyw9ZF/6bD0PgROu8Xq0Sj9n0/
	 U+PUCX4pZjZwGLu9Qk6DabVeJdd5iX0p048uBPpY0ZyC6qjmsT8EXr462X3B7O4LvT
	 /6ma/0TKLK7FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE7CE81003;
	Wed,  2 Sep 2026 14:29:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88669127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E71C400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWOAnZxlA0fY for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:29:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rwRrybT8
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57C104006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:40 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso11060375e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788359379; x=1788964179;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HXBVPfRj/568RVTlealbF3SdwhDO6BlhKmYJIT9LJNo=;
 b=rwRrybT8Z2F8h2z4zafyCyzQ6AMxhCAAc2/hxGPivZDy3dUJ/VUcVChITTXVc+exK/
 UO16V2pQgij8Yn/fC9tmS1QBGON6d7v3WM4+Yl9qMRQUajepoI9Gg5IC7fYucA0XwR2H
 0e/pBp22Adb8a+NU4ps504Dr6yx3I0cQFS4ycn/M0HtcJORQTnoZ8GNzYghdM0j+T/to
 3DLFeyECGNJwtY8ad6R2rauCw9T6hyHzH1IJU6GbZ4HpB/1OyLwRmskDCTM0ozoVm4sV
 hFhqoeUIy4x9dBdyf+aGkzMeDAYmEK9UWLEGXZs+LxnDQjZsb2s6UBKPbHRX9HykuHUi
 G+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359379; x=1788964179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HXBVPfRj/568RVTlealbF3SdwhDO6BlhKmYJIT9LJNo=;
 b=cX+2s6TYWeuzUQNavjw+jTLJBKNp6YnN3wtWQlpwIXls2qGf5XbqGAK3biDMHpGH9j
 IsG1MAN0wXO6tHVNEUa3UHX9gLYG3hcZHD5/YRK6O5Q/oMkLwigVjy7pmukAn8vt2SCp
 0XZo97TMab55MUFPY9ocfEGnXLZbUH/MWCoSaS2f5OHGV5ccl9eBEI5UCwkT0WOnrq2I
 hhBDGGwpoSaKZwwFX/zKjB6VTn1/npPuX93Yt649AuhhalsLxzR7nkvCvEXtqZ8W1B04
 op+Yd0cl1fa0DhDhRWLeBuhLrsX7WoRI2wvR+cF9wJXOAvNYHoCEAcmfoZV7/o9vBt6v
 VBLg==
X-Gm-Message-State: AFuF++lqu0Aj+CvqqNsC8VyoLinmzQwRWHLXtMDujmHamP/TDOns94aG
 GJhVc+6ySLA/evcS7ZUGdyv4+/NyDuYTEeOvhlOqBa3mkMSnA7cD7E3GLym1VPbeNuE=
X-Gm-Gg: AR+sD110BoEGFubQsEQCaYAC3PNEaKQ7uUB+olzSdCIRnZUv6yddajDSk8Ey/pETnz0
 lN0wy+do19eUP6fQL1Xna/kdr5+4tTVJJNOHv1ye2cUlXCqla+qWcLLdHo7MA9Sd0jiTYVMj6HR
 ezPsNeZni88/x6UoVzaAmMObN8d3O/CK2FuqzA1f2sV4A3TrelacyFSGfmkffszKJGJYbbNbAhM
 6LyaAlNso7HBGFm1ZrH6yNNy/nsLLoW8sth/CTFY8liHlOUdATCIlDevARWQczKcjN8kzrYYkjC
 a4od0S6svrXV8NVC7BXFlnYpgZREKzjPJzjgQD35ttvGBRgPBiqBPPCrdxwvHhMDDwdXegq8Rhy
 QHVTlLIkw2ozgyDsZWr4Qf0Aum5AyS5TjlZHuY1VE18SG5PEvzKBtd8tOlHtiXGj4aFxVc/pbrm
 dQ/+KmgBkS3pvVZkAascu+0ZzQ0/dacs/7EOMTKePMJMkoVKmHeVyiioAYJYBg+zqkSVQPW+G96
 vWlpPoZMoDwuCkiyZ/Q/fdGlxpv9iyzGkTU
X-Received: by 2002:a05:600c:1552:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-49ce57ecc95mr82609895e9.5.1788359336290; 
 Wed, 02 Sep 2026 07:28:56 -0700 (PDT)
Received: from lion.tail248178.ts.net (p549d4d01.dip0.t-ipconnect.de.
 [84.157.77.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce465161esm71752525e9.7.2026.09.02.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:28:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	u-boot-qcom@groups.io
Subject: [PATCH] gpio: qcom_spmi_gpio: fix bias-pull-down
Date: Wed,  2 Sep 2026 16:27:00 +0200
Message-ID: <20260902142736.2419504-3-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

A small logic error resulted in bias-pull-down being interpreted as
bias-pull-up, fix this.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index bd1d7a16e852..b218a3d3d585 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -795,9 +795,9 @@ static const struct pinconf_param qcom_spmi_pmic_pinctrl_conf_params[] = {
 	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
 	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, PMIC_GPIO_PULL_UP_30 },
-	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
 	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
 	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
 	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
 	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
@@ -879,12 +879,9 @@ static int qcom_spmi_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int
 	case PIN_CONFIG_BIAS_PULL_UP:
 		pad->pullup = PMIC_GPIO_PULL_UP_30;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (arg)
-			pad->pullup = PMIC_GPIO_PULL_DOWN;
-		else
-			pad->pullup = PMIC_GPIO_PULL_DISABLE;
+		pad->pullup = PMIC_GPIO_PULL_DOWN;
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
 		pad->is_enabled = false;
 		break;
-- 
2.55.0

