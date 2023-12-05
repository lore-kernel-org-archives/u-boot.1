Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A91BC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A8D87655;
	Tue,  5 Dec 2023 14:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pugKpXDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F26D87618; Tue,  5 Dec 2023 14:46:59 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049FC870F4
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9efa1ab7fso39291131fa.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784016; x=1702388816; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YpHa9jPWWb/80nwbouz7sDRkhUDDEwUlvgTNZu9CFvM=;
 b=pugKpXDxM5BoAAJIzM6LZlIxzluOgNLzPFc2mObch1g+3MZVrR0W0MS3eLMprUL6ov
 CgrXE1hUoBWkVpPDMddK4YVyPLP0hI/A3kPyv2ZtZqv6suaDMTTIbcWL1B6Sa3XQt6T/
 vDJ7+sLtJIJ9736rzZmAZp41peJ4+Hg0v3jkwvd8K7V1fj8KriZJToD3guLLxph0zTRC
 XToQE564oyvEJkOSmiPuSCsZ6X7pNDpxfGuR5kXQl+zDoxgvAi1qiG2zZ4dnrepeyybX
 9e2h0ipa0/5sL6VF/vjQbYczX+h/m7lQdT5raoT1AIxZ2j0ijSfMrcmmXSyzc3Jl+0HV
 qKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784016; x=1702388816;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YpHa9jPWWb/80nwbouz7sDRkhUDDEwUlvgTNZu9CFvM=;
 b=UCBcCjteDY5UkhbT+73u3nqxWiLAP6j8Ast1fIVYeIDVP5LbDP3RjjsfZ4yjglQTu0
 aupRf7fkOE1bvjgrsHCGol60lbxxrkxLxQh6YsIVWKCMV0hxIikMQA7cGCuRaPDg15ST
 dtxjT/HxIZgIj8JW9qC8ErFPoeO1vcDJkeOI9l77/pQBKUnRsa7QccwJcMH1RtvM71jN
 e20dVYQydZLdf+bPtkKhYGaRjCV9chP7LjEmpcsBanvSr7JRgEJyt/nY8DArs7Ks7YYm
 sMVy69Mz2WMvuMGKtb6Wsf6mT3WVsA2hLvsEafZJIRq4SZuaZSCUNc6hUTT0aJ0+KRR4
 HkCw==
X-Gm-Message-State: AOJu0YwshxdiOtO3E8JM8VEb+LULA76BKX+IJ+zkIW7e/hVM+kcv4IrW
 1eBncpsNwt0t7WAhAXambM88dQ==
X-Google-Smtp-Source: AGHT+IHm6bM5C6u68OGRVOlQ2F3GXQwMmMEaAywhLkmm2cf4ssJel4FBfhs+hcMz2pRh6pm0LgDi/w==
X-Received: by 2002:a2e:9286:0:b0:2c9:c523:2e13 with SMTP id
 d6-20020a2e9286000000b002c9c5232e13mr1362901ljh.45.1701784016257; 
 Tue, 05 Dec 2023 05:46:56 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:46:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 0/9] Qualcomm PMIC fixes
Date: Tue, 05 Dec 2023 13:46:45 +0000
Message-Id: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUpb2UC/33OTW7CMBAF4KsgrzGaHwfbXfUeFQvHdsBSiakTR
 VQod69hFZSoq9Eb6X0zDzHEkuIgPnYPUeKUhpT7Go77nfAX15+jTKFmQUCMCEfZKvnj81WGUdZ
 xc6OMjrUGCF0gFrV3K7FL95f5dar5koYxl9/XiQmf2/+0CSVI8L5ttVFICj+/U+9KPuRyFk9uo
 iVhtgiqhEYmZq/JKrMieEGg2iK4EsY4S53pAFq3ItSCoM0vVCWssgGsoYAhrohmQTBsEU0lFDY
 AkVi7AG/EPM9/f2ER378BAAA=
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4200;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/+MSPKGjTULuNdf/cLPOwC9hXqNMuOuPVoNQZn49s5s=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zbNLpvkXz1ebsEDisLrErLknflnLpGsHL38u963o7
 7yJTXtedpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJvFrOyLAsdNNlHS/9stdL
 c3/pGrerlFVfefci81JQEMuMlV+dZ5gz/DNVufF/6eEAaZl55ou2SGSs4A66y9b0Zd1JJw7dk9P
 z5XgB
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

This series addresses some long-standing issues with the SPMI arb
driver, the PMIC, and the PMIC GPIO. It fixes compatibility with
upstream Linux devicetrees, and simplifies pwrkey/resin support by
rewriting the pon driver to be a button driver rather than a GPIO
driver.

Existing users are adjusted to use the new button driver in their
oard init code.

This series is based on the pinctrl [1] and clock [2] cleanup series.
There may be some DTS conflicts applying it standalone.

[1]: https://lore.kernel.org/u-boot/20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org/
[2]: https://lore.kernel.org/u-boot/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org/

---
Changes in v6:
- Drop spurious change to qcom_pmic_gpio udevice_id table that was left
  in by mistake
- Drop bank-name property from qcs404-evb.dts that was missed previously
- Link to v5: https://lore.kernel.org/r/20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org

Changes in v5:
- Split "rework pwrkey driver into a button driver" into multiple
  commits
- Split "qcom_pmic: fix support for upstream DT" into multiple commits
- Link to v4: https://lore.kernel.org/r/20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org

Changes in v4:
* Remove some now unsupported DT binding docs
* Fix qcs404 SPMI arb dts
* Link to v3: https://lore.kernel.org/r/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org

Changes in v3:
* Remove now-unneeded header includes in dragonboard{410,820}c-uboot.dtsi
* Drop non-standard DTS support from PMIC GPIO driver
* Also remove old gpio-keys nodes from starqltechn-uboot.dtsi
* Link to v2: https://lore.kernel.org/r/20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org

Changes in v2:
* Avoid using non-standard "label" and "linux,code" properties for
  buttons
* Add missing sdm845 DTS parts
* Put button driver in drivers/button
* Link to v1: https://lore.kernel.org/r/20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org

---
Caleb Connolly (9):
      gpio: qcom_pmic: fix silent dev_read_addr downcast
      button: qcom-pmic: introduce Qualcomm PMIC button driver
      mach-snapdragon: switch to PMIC button driver
      gpio: qcom_pmic: drop pon GPIO driver
      gpio: qcom_pmic: support upstream DT
      dts: qcom: adjust pmic gpio to use upstream bindings
      gpio: qcom_pmic: drop gpio-count property
      spmi: msm: fix register range names
      pmic: qcom: dont use dev_read_addr to get USID

 MAINTAINERS                                      |   1 +
 arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 --
 arch/arm/dts/dragonboard410c.dts                 |  25 +++-
 arch/arm/dts/dragonboard820c-uboot.dtsi          |  12 --
 arch/arm/dts/dragonboard820c.dts                 |  26 ++--
 arch/arm/dts/dragonboard845c-uboot.dtsi          |  11 --
 arch/arm/dts/dragonboard845c.dts                 |   4 +
 arch/arm/dts/qcs404-evb.dts                      |  10 +-
 arch/arm/dts/sdm845.dtsi                         |  28 ++--
 arch/arm/dts/starqltechn-uboot.dtsi              |  10 --
 arch/arm/dts/starqltechn.dts                     |  20 +--
 arch/arm/mach-snapdragon/Kconfig                 |   3 +
 arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
 board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
 board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
 doc/device-tree-bindings/gpio/pm8916_gpio.txt    |  48 -------
 doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt |  94 -------------
 doc/device-tree-bindings/spmi/spmi-msm.txt       |  26 ----
 drivers/button/Kconfig                           |   9 ++
 drivers/button/Makefile                          |   1 +
 drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
 drivers/gpio/Kconfig                             |   5 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 138 +++++--------------
 drivers/power/pmic/pmic_qcom.c                   |  13 +-
 drivers/spmi/spmi-msm.c                          |  46 +++----
 25 files changed, 337 insertions(+), 474 deletions(-)
---
base-commit: 11b868d152760a49895e051c285926a0461abcef

// Caleb (they/them)

