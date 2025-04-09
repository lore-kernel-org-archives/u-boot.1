Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF968C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CDD83931;
	Wed,  9 Apr 2025 19:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pT0yKsy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCB8838CC; Wed,  9 Apr 2025 19:17:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9F283927
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so3912609f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219066; x=1744823866; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+diCdExHB9iUetqw9SLZolgCQ2K+N+Of+yOUb1NzDaU=;
 b=pT0yKsy0zXQCUcnthYyFDwsKjzEZmqYN4TCrEB2UXd4oBoBEX1eaYOmuoSKh8d/ClZ
 2Rq26tKQtc9B4FHKw3btRNM4tXCxlH0A97ggzE9lK2NXG6A+eqoGYbihtof6jqa+EPU8
 zUB3NcyJaXgnTA9cSVm6Nri9RX9Wc/bV2cTD/VvpykPOUlBKQU5/yIQ0kBt1GTwq3tnq
 mIMAVIKxXhVtLlx2j7N4feMAeFfD0sX2jVHTyTnAu5WllWMqWe0h5lxR7PHQPuUFAfUj
 ftMRG2NNG7Nkn2jeg2uKUyOjTRW++uvPvadcD3lTfxFitE5EBuCOzHWJvruhglQmjNI2
 scWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219066; x=1744823866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+diCdExHB9iUetqw9SLZolgCQ2K+N+Of+yOUb1NzDaU=;
 b=Y59OpHyW1+G6O2j/L8Bj0AfBAK8SwhYB2Ohoojm8co2QpWQNNivxmO4K5iv9f3pKmw
 bTEiaQuGC4m8q+h5iYAabGtZ40iS0DANhoAftzHmglD8UBBHPJLDddZejq3iDRov37KA
 F8jLMfYtFa5ZGX/YCQS2ogrqGfNWdlDO6CfCO6p7yl9FytcuADQLdN9bXDGnpsGxIo6h
 j7nW0yBglM0izXpKvMlx/WeJt+EUgyhZWb/jwtuE0vLDBfaOApcKAXfoQtLdj4mNRh3M
 Kx6FC8ihjR8xX05repdXk0NSldBcvCNdmycQrNxivpE1Vd/yZgqfJdXJB279OnFTIQ/t
 OrtQ==
X-Gm-Message-State: AOJu0YzpCe1IjNQt7PP7YehdnQB+OYuJCvX10taY36mWAhQ8GGVLGiXG
 fpG0NqZPAMrvPYHqaVMLZfaiHcSCRc4+ThX5iKBFuhyJVcXGE7UHBRT1Wb0uQNKiXns0fNlIVVj
 C/6g=
X-Gm-Gg: ASbGncv+GzKsSGIICp8vCbpfNSJ/hfaXmY/qGeo3vZVZkhMweTGILAzmwJR7aeth6MY
 vzHE2l0QAgNmhQ2n+WMZb2LoYA1rWgvs3k8TaTiKVJSxg9aB1LcRqwgbUK7yC/4yHBD40st6Mhu
 82kKSvKxdYsu58kVCOXf4XLxRVv5wE9lGg8WI2HANsuEDSJcewHwZTfPLK7vSYyWtYdZ6yEXIIP
 UGp4KijlCIXN/KDN0bvpu/rJI1tzWM/fIUjKg6b6WPfBI6xBk335cdLm8EsBQ+33jPoUpLi3DFg
 mmvK6Tc1seWTVdAWwdXeR/Cterh7n42ozN957MdkSzmST95Xz1YQjYpx2DzDOfmR1sEzv4kE/l7
 YCmMPPg==
X-Google-Smtp-Source: AGHT+IEyjczorUJUp/dvtzkMKAC6sFHFot/KJthhY0fTpS/SpfW3k6fEtKu8QzCPAB+4HeGIGh3MRg==
X-Received: by 2002:a5d:588d:0:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-39d87aa8afdmr3255171f8f.1.1744219066512; 
 Wed, 09 Apr 2025 10:17:46 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:29 +0200
Subject: [PATCH 6/6] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-6-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7GvbTITVkOm95AgM9oY8ouOyXXuEUZDuiqePCakNU4c=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9quu3HqvNH16PfHNFjFCz3jT5y6TRTuxkz7g2
 ZvB0goCgmmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrgAKCRAFgzErGV9k
 tlqqD/wMmFNUSSsKHUQxOSlFuHZpPhe6EKMj9+DSv/PyaOZDkgD6ALJWeWUX+SyxCPCH7tc4gTn
 K+2wfwdFQj4WwPDqOtwafneJC1I4E1SA7MvDE5A96Bw4F6RPdI8n51g2iSslSgqupzgmmmK4Yr1
 kvxx5gOD0z0d+ebR5CJph8FfJbSuY67ZLh+StkC5wBYqUUW0f6sFhh9yLc+AP3/PTDmg4tw0QAp
 SA4ESKqHBD0ALkhGDP8FLOWlZsE3BEhe1XNyrfuirlDdA2l3m6NjoLhwKg1/dG41mL9n2BW0PK0
 RfMPDSEGNrArdVhQMQzDxfo+lIxBR7Oks0G+EFWNUQmSHbEmXn4BE0CKIkJ28E/oyO38qqA3CBZ
 S4XD8VGAopVMx8v8j/uKpPxXuD9N7A9gbfItjTfYZjFODIuSSBxP48/Gs7NAA7DLeGXbYk3H2mU
 qgL2J24erTA/dJXlM1mJmW8NrzPDR53Nh+1rLMPXYfng2ZUC0CBWtTZf9jbnI+4N0kZ6heUpwaW
 lwvcENWSzcapowMkC4/bxVTI/4kNzIB9KlwcKnhuBxFut89E+nxruO/pFxqBi2MnKoDTL4D4isZ
 2yNAjosOxt/lIXG8/5PPIfbS/Uanr5VQFiwvYHnefZmg3rTeUjvUAsyB7yTBfzxzBiji4VdQlcW
 4Hwc4wKjvj3lg2w==
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

There are 134 pins not 133, oops! This fixes the sdcard on the RB1 as
the pins now all get configured correctly.

Fixes: 0ecb8cfcb930 ("pinctrl: qcom: add qcm2290 pinctrl driver")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index 0c2222ce663e6d584d229e7521f88fedf8aa19da..84f76b63b93ad78182524661dba561672feb4c85 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -44,9 +44,9 @@ static int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned in
 }
 
 struct msm_pinctrl_data qcm2290_data = {
 	.pin_data = {
-		.pin_count = 133,
+		.pin_count = 134,
 		.special_pins_start = 127,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcm2290_get_function_name,

-- 
2.49.0

