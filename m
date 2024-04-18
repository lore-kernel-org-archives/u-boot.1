Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC8B8869E;
	Thu, 18 Apr 2024 19:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e5XK/QZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3630988691; Thu, 18 Apr 2024 19:26:28 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A34488693
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418effbc70cso5568565e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461185; x=1714065985; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PkB93u2GEugy/u3O/UwbjGL8DV0p1duoITuRUfQFiYQ=;
 b=e5XK/QZhxljW84UVwC9zdXDGgYC2+xdt8k5R2Wkh2cipOPYpsZC24bdH38kW7zzQxu
 knw9nnsXgfNKVBwVYlT/RV/yr6ADyWf9UaasC7CkSHdcoLcrOrbHm0L14RnMXwG65Mg8
 CrZiFy3RGIlUZgidkWPrGzvF2gTTK+Jy7DQgBZQG2FL7lmIRaxXH/+KSOES8akt9wcaV
 hILtB1ErUtccK9EapOlDH2S6yns6NS9UH/JRh90r9GnyeNJhusFEd9krNoHR5U5ZEme1
 UhMd9UfnjqLnn1X+yrhb/0dGZFdmwj00r5Xnl3wr1fl/3hsfNNyqiJ/nvAWIN6l0ocfP
 fFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461186; x=1714065986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkB93u2GEugy/u3O/UwbjGL8DV0p1duoITuRUfQFiYQ=;
 b=OFXLTwTARinXTfb/e01N/vD5ck1I8D7ZLz7hO2T0Ua5GGBdjpyjTmk2wQPknPDendn
 qlrx087e8kqHncst2Qo8tswnC/tn89YaB1/mLHLc7/SwIdpRmryQRFRSN9kowWIYeOuI
 4YkjftA92NwXJBAL6hf/QLmaMh83io6eBNFP3EELJuAO9JWEgJm4dopbymxS23rKR0IJ
 Dy2iscZwk4v+2gYjw222LP7gzFc0Al/w7sZYC+mZmc0jeMuWXKvrTObKUHOQlDMJdycD
 SF8Z24oSRALtQnHBlTAPGDlMvyVwDvr8s5IjCPd5yQ7/aaoDjEjsZdBEm8AxDcB/co1g
 FYQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx1iUyysqdrt5M/TE1r8eBp36t/+adsCF3DXPBoLN2xyCKUVp8FXTQwUkxV9NG1sg7kn+RJHrDFzsntcym2SKINg8lhw==
X-Gm-Message-State: AOJu0YwxY+kX9DZPhRdY+x/7h1UUIw/yuyFOuQ4uPMbUDKwhy1u4VvWn
 V+OrPiTmPKUck80CtTGLE1MF+e7C8MaMeHIjYUWXfLe2NO34vvdgmnDu4N6hPps=
X-Google-Smtp-Source: AGHT+IFsw4aanHTZw3zjIjTWDVGmnU5XvbJrfT09jnlq1bpsGYgn0ShzIQOI3ncCYl/6ZOv8t0ITGg==
X-Received: by 2002:a05:600c:19c8:b0:418:95a1:1975 with SMTP id
 u8-20020a05600c19c800b0041895a11975mr2384113wmq.20.1713461185800; 
 Thu, 18 Apr 2024 10:26:25 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:45 +0100
Subject: [PATCH 2/9] gpio: qcom_pmic: add pm8150l
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-2-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=895;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SyJsuXFveE9NP3j11TB258tmAMK9y8RumBgL+mBQw2A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H06h+OPK94zOfxogeKkjty73l9fP1xtufDk41N9e
 /faN53i7ShlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATMS5lZNg1ry3YNXN19wLD
 6z65GRdWfrx/3H8vb9s/1e86umX6ZY8Y/vAIsdb7xq/4NlViZd2ps48z479n/+i6b6Mx8W1xwMN
 3ha4A
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

This is used for the volume keys on some SM8150/SM8250 devices.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 362d98dbf8cb..0dd3434e9e04 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -364,8 +364,9 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
 	{ .compatible = "qcom,pm6125-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
+	{ .compatible = "qcom,pm8150-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ }
 };
 

-- 
2.44.0

