Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723C6C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34E4884B4;
	Fri,  5 Apr 2024 10:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kuHrC/nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F84D884B8; Fri,  5 Apr 2024 10:27:31 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431A388433
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d848973b57so23496471fa.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305648; x=1712910448; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xJcp9hmvAoMlvXzYzEK7jxartaDKyXNrkigcbLCsLQk=;
 b=kuHrC/nIVGNLdm0zg95Uc2y2whHVVTQU/XstFVPtNCYPUljj8jegIyKsIr0S78BX58
 fWnkBPx+encxKTZste4nuQFd88SoMomoprVRp01R2eSjh5pO3tjJ3uste1qewV4t7//P
 XD/1YXwSgMQxZ7gb3r2PiJxBwW5J+MXHsOLOSRKZVQTtKCDs1bczi+2yPCtjLsLlhJ8J
 Z99BVjXUp7GXd7zRt6pv8oiS/74A/c8NZtKOBd5/ZAE5/uWmyZfUzjSk+45uxlvLHwDY
 dLsOIkPg8VdUPIcg7jqL4MIYWvOmfqAWla9x2Ee6jRMg0Xb1FnXL7B0I49VtXxPDVo2o
 fFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305648; x=1712910448;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJcp9hmvAoMlvXzYzEK7jxartaDKyXNrkigcbLCsLQk=;
 b=nr6AojhiQUHb/BXAgY8MoQGwnNXMacMbAK7eqjVsXN3q/14AsQHDKHmWX37z8ZPG3N
 HtY5E8djE8JMx1YjUBFj0tgQwZXkbZudBXYjHMYnnI+VCXkRfUUqHjHPgjnXRJI8BdDI
 V+KOxrRC0+LplDzpkDJSJXqnmoGRxYPCU2jmoDhHC+3oRqA/T4Bnyxi3X1DupWupy4FI
 nkeLEzwwiEsRdgcUvZny7UWywFFxWP0zT5avTpEjeOzvoVLnnvJ3RsqqxdmoJBGww98+
 ScwhvHFE3zyb0YshYTwn7ho7ydChNfK4JkOhDWp+1hN/i5W/U7QPT1w0Uoi3mfiSLKjy
 P0Pg==
X-Gm-Message-State: AOJu0YwdcTa1UZCI2M+oOMC65nWv0aNx14zDzOPB4G2QE36NH5mpa02D
 d5WCUKgLQBnQSOWtnOy2e0X5CdJSqfV1QAMbsEP6YY4C8wfyy6yKFwO44Emjuk4=
X-Google-Smtp-Source: AGHT+IGmEDN8yW+RjK96iznlRLxQeOhLFLj4gcL8lXdoL4ThdHhsO0TzCaGhJTvyOnxzqzCt78Doug==
X-Received: by 2002:a2e:8e86:0:b0:2d8:6104:f95a with SMTP id
 z6-20020a2e8e86000000b002d86104f95amr623966ljk.23.1712305648264; 
 Fri, 05 Apr 2024 01:27:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm2721593wmo.21.2024.04.05.01.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:27:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] qcom: support SPMI buttons on SM8550 and SM8650
Date: Fri, 05 Apr 2024 10:27:23 +0200
Message-Id: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOu1D2YC/x2MQQqAIBAAvyJ7bsGiKPtKdBDbaqFU3Agh+nsSc
 5rDzANCiUlgVA8kulk4+CJ1pcDt1m+EvBSHRjetLuAVIjuUc8idRoknozuY/CW4GKuHzloyvYH
 Sx0Qr5/89ze/7AamMm0prAAAA
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4/yqgowGk+H3j3q2Lr5g45Y3uH0ONXBPW08sdsJxohc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7Xt7rpQLUakxCnE2hvoHnET4bvGbIv3EEXu8WDT
 Trkv6/uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+17QAKCRB33NvayMhJ0fWQD/
 wJ0Dab+YHytD303r0EwBpCeXJOwOreZvbenDx9CWnKTLMALd6lPgh6UYXvYDQgJeODhgWMt1EKaw87
 9hnwdkXFd3ImhjQOOrIckeuOfW+V8Z7Sd50PrI7CW75pYliO8n687duwbFM10vkaGlXU8p3P4Rcg9d
 JgDaZTiU9vYEvJ3vIEK5Pn1ySEXWyJ0it2oHWRb3y8ZPweo4TqPbdQUeTs74kvcx9WfTXeRgPF0I2S
 P5Og/jSpafIoOvN+bUU+wpNl10eG1tWEGnkPyZO+zSYY0J+DdV/GTCxVwI62NPBMGBqg6UUJ063D8v
 /3teDAT8sjhh8DG5tJACJ8hqANhN+0mOSCDyCl3DFxzgWyWfJ68EKtJKcb7H4gwa6iqUNwAuqBfTwl
 GrLnXy4GVx8gmwdxZkUm7pVjDjHSofD94/LQ4M/fXCuD1Y1sG1fkHsy0hX88v8asoAkYKgAszZsCai
 zVng9OFApNJR2FySnUrM5vQi0EiRll6BUywquixUecZa68sd21qJ0uox0A12KXap/dzlSHPLD4XlLi
 c8JfsMotnwqU6rwJeLH7HLdQgsFxauO8jCLSS48xn9ozD8V2Xl6VvaOIZlpw+Vcxmg3Qs/XXyKZVU2
 jqeCpPdhcNPaYY9YjUfKMTxy/GZ8x4bGp9cScglfv/0XYx7WmN7UzL9YTLrA==
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

First add PMIC gpio variant on pm8550-gpio, then rework the
qcom-pmic button driver to support data structs for each PMIC
variant and finally add the data for the pmk8350 button configs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      gpio: qcom_pmic_gpio: add support for pm8550-gpio
      button: qcom-pmic: move node name checks to btn_data struct
      button: qcom-pmic: add support for pmk8350 button configs

 drivers/button/button-qcom-pmic.c | 98 ++++++++++++++++++++++++++++-----------
 drivers/gpio/qcom_pmic_gpio.c     | 18 ++++++-
 2 files changed, 86 insertions(+), 30 deletions(-)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-spmi-clients-d9a085aae979

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

