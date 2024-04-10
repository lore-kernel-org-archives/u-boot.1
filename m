Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1173FCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 16:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9360687F52;
	Wed, 10 Apr 2024 18:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJQZCLDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333EA881BF; Wed, 10 Apr 2024 18:01:19 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B1981EEF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 18:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d886dd4f18so42404991fa.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764876; x=1713369676; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wqHyCdGf2x87idYXcYxSq8rt55lyQorMGYN3Z/paOE0=;
 b=rJQZCLDXos8s5JmvMRd1H6Vtuqo9Mp3dP/cziYPzOvB7eeS7jHApG7jTZJNmyRIn+u
 PtR/jwU+efglKnJ2hcJKRdIM0URAUUdSEegsvYNB4PR17dN0j1iE6DTeLenO9aFy3IEV
 sUF12REict/Ioo6ix4uy9wA+qI76dlTMu3zo6cUgaqAYBz3N4Pf0nPePxUnRX0P8K/PY
 H3/bM5S/DO4O0vWvmRjxWpvJNH0jVOj+MdWnZBc75ZCurotWmuR+/Uy0dl4XUVMeHPi9
 c8RCtX8grG2KRGGCieq4Rm8vBSDefjV0iJf5FYhqlZ6izrCUiHppwhNSQt1fOZdtuPzG
 i/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764876; x=1713369676;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqHyCdGf2x87idYXcYxSq8rt55lyQorMGYN3Z/paOE0=;
 b=fiy6/xqXm2Jm20ZbEca7VaL7QB/n8pylgummvTo0XHN3jgHVvR4V1Kd92Mi2jjwVA9
 G1b1/HUrDiCdaD8s/BhGR6scecZWJ52qfvxh+/xUeeAbZJpUNUYvDbq9oSC3m6mnECfX
 M2oSilJ2u7JkT1w7BXJES33HUXg5rp0Rx9VVXZDzaxfBdHzk4wYZJ+qrTznwoc7Dptpo
 1Gpp43d6JHQjseUT1PnXUFV3v4HgKqN+YLuam9CmXQZxz8HNZ6tZ6efZ0yvlPIHiRtD+
 sVCX4/8rnQtTs33e5IPf/CK/aVkPvNS7NH46r1/hReKgILW8Nq6GE4qp1ojoqYvbINQh
 9+xA==
X-Gm-Message-State: AOJu0YxbY6BC46Wdj6FyORdivpcROSH5+J90oDwqbbslWxTlcEww5qqN
 7tb0UYooM20+S/mE2L6GN113umptmHgtGK0hQzDLzcG2R32HDFqREpyA/uOMqlkCkfklu2t+3+g
 bv/k=
X-Google-Smtp-Source: AGHT+IFJGKjMZpdE9xsmSA0gORpg22HNbiQLvfJqXGmwjt2B3JJuExxbfRCncmrAObm+wjh2Q82AHA==
X-Received: by 2002:a2e:2a44:0:b0:2d8:87e2:3a4a with SMTP id
 q65-20020a2e2a44000000b002d887e23a4amr1982992ljq.27.1712764875823; 
 Wed, 10 Apr 2024 09:01:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 l10-20020adfe58a000000b003434f526cb5sm13872624wrm.95.2024.04.10.09.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 09:01:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] phy: qcom: add support for the Qualcomm Synopsys
 eUSB2 PHY
Date: Wed, 10 Apr 2024 18:01:11 +0200
Message-Id: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMe3FmYC/22NQQqDMBREryJ/3V+SoG3sqvcoLhKTmA+tkcSKI
 rl7U6G7Mqs3MG92SDaSTXCrdoh2oURhLCBOFfRejYNFMoVBMFGzEpzDRD2ml1wbhu+kcfIbGta
 qVrqrMFxDmU7ROloP7aMr7CnNIW7Hy8K/7U/Y/BcuHBlKJS+s1k5y6e5PGlUM5xAH6HLOH1pgZ
 sq5AAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=b78VGfYW6GF8hVwddErMbNyZcNCJQjTvkpNGOdiHVuE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrfJ7WJCS7OFam+89d7gbRQUGBrWHAz0eUvfLufH
 8fIpivuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3yQAKCRB33NvayMhJ0Q6kD/
 41BHPM83pEuHD3eLIM4HHT15KpY1XEyqj87msFM6cg/CBcNG1JtG36vWtFnhUwPvCSCfpxFDjMBYl/
 QIZVYyNDmqIJ+IENXS27BF05mNC1Mhy5awoegUygTRE0lmGwd8zUbgpz2kVFtuNL5T/CTKjE//FW34
 c4kQguATUvZ1PZcIxcVabhOYI6XKwp6YsdsFgeqgVKLgLVQkHXM0/pMCw7qc5KIonsZ8zmr0HVPJ2Q
 kLci7fbO3BIdzHszDUoSEwFdjhqwwxBwKmmZatgd6osdWzGrZysf/qvU2lCiRQRIdOFxU3ILzWK7XO
 ju3DyZAh+h/cuiUg/YNzijy6CS7nCh4J/XqRuV69AgvOUCHyjhj6ZqgrhzQc4Ys1kMBG/CJAU/eaq2
 tjOKf7dTMQuRiChhlPSZOEiZQqGpBpODhscnK504/VBIzFMkC5qRfDWJiYy5TsLp46xSBaKYKhH+PG
 JP/vaOG/N+UhEwLzgvoXHakb97Bx5JvS5U254Cyw95nqG82cJcKT8EYq/dS7yJ/iWWQ257XDcbttsx
 aeN47MJ1ziCF9csIzKrvvpNx9dMhkuBNE09n+icsnDFWW3xqzmT/HpWt905RMIAUmUHy6E5jweF4SQ
 LzZdM0UrZOdy6mI9ebhE6Z/tvVwyvwVbYgPl7SHuM/S6uXgMfBfuFZ7l6c1g==
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

Add support for the new Qualcomm Synopsys eUSB2 PHY found in the
SM8550 and SM8650 SoCs.

Finally enable the driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- fixed driver build failure due to missin }
- Link to v1: https://lore.kernel.org/r/20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org

---
Neil Armstrong (2):
      phy: qcom: add Synopsys eUSB2 PHY driver
      qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY driver

 configs/qcom_defconfig                 |   1 +
 drivers/phy/qcom/Kconfig               |   8 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 366 +++++++++++++++++++++++++++++++++
 4 files changed, 376 insertions(+)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-usb-phy-d09a98f72d1b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

