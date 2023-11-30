Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E5C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2C3876DC;
	Thu, 30 Nov 2023 21:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hczmwX59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A3387675; Thu, 30 Nov 2023 21:22:50 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B0A87675
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-409299277bbso12361675e9.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375767; x=1701980567; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+wdHp8PWUglJTUe9dEjxojTHpZm5iZyaCXyPd0MZ0Fs=;
 b=hczmwX59Oa4A0ZWtObeTm3ErdR5r5hCFHDrRTXuKtEZVjAiEZyGNPgAy+MX56WDrD7
 IzYIU+jld+fjmDTxWMN6i75UySeFhwcS7261veEixrhAN9Sw7JizSZxPswuMpg7e9zRb
 9UbahwrSLrhz0a3ihwNbiqOOpeB9B2ElxRGrlbIxZauZYLDUVelXtRFaL4kBtov/a0rP
 uyfrEkiOhl656YwVDq2g5rr1yku7RPk32PLP3DuYkcOF2Mt5t8zhFlbBkMErmhNZZ3/y
 /jhW88faU5vcAc6f9f+p845F7IZN6jObfmUxcFMkBbYusmxe10TWfdCdHhiEctzVuGcY
 EKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375767; x=1701980567;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wdHp8PWUglJTUe9dEjxojTHpZm5iZyaCXyPd0MZ0Fs=;
 b=ouZJq+X5P3wKHNP79ZXMzMRfQIqRL+pWXk+RuPB8cj8YJZ9I8J1pOQYJUW1iA+Sfm3
 IgkAhJS2J7VkXSvPv/H+wjbcM+mZTvBqBPU2TxCZvKBy+AcVb2kl7hRGqwfCIk7/dAon
 6eGMn9ABdeigD88niVNoUNhWp98ZhNY4fngirzNlQAbU6rLBOHrvqEOgws/A1FLEaWMg
 mbB3Sahalg3bTYvJDsWKO8+KQMhahAmfaWevCJo0+ajWfz54RscfahyTOy4VlqiZ+5Ax
 Ofec/lbPoEydpoQVoQ5wUxpbNEUOxoKny1W8bugC258/EAKzBvuhcVHPJnWmo1LXhnf0
 Ku+w==
X-Gm-Message-State: AOJu0Yx+uCxJH5nKF+8YwijiGMwClTKwDMUrdqW7TbBYKDjZ5G1McOzt
 3SYFSc/Q7Dh85Vk87uwt3v4daA==
X-Google-Smtp-Source: AGHT+IGo+4AFII3YT8tJCX0ZSUbhY9+g8ygH81DiRZCiw5vVp8jPyWpBxxLrmbE2GaSwr+3V0pwbKA==
X-Received: by 2002:a1c:4b0e:0:b0:40b:5e59:e9e9 with SMTP id
 y14-20020a1c4b0e000000b0040b5e59e9e9mr34847wma.136.1701375767458; 
 Thu, 30 Nov 2023 12:22:47 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 0/9] Qualcomm PMIC fixes
Date: Thu, 30 Nov 2023 20:22:24 +0000
Message-Id: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADvaGUC/33OwQ7CIAwG4FcxnMW0BQU8+R7GAwM2SXQoWxaN2
 buLnma2eGr+Jv/XvlgXcgwd269eLIchdjG1JWzXK+bOtm0Cj75kRkACEXa8kvzu0pX7npdxsz0
 PVigF4GtPgpXeLYc6Pr7m8VTyOXZ9ys/viQE/23/agBw4OFdVSkskiYdLbG1Om5Qb9uEGmhJ6i
 aBCKBQkhFNkpJ4RYkKgXCJEIbS2hmpdA1R2RsgJQYtfyEIYaTwYTR59+CHGcXwDJL4AgHwBAAA
 =
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3922;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wjyhHFY7EwSk1yRQLVOhIoklOmZKzu1b2BemTt9KMlM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM96IZC2NfSplWR618ve/AIh/ThOq3uUFhAoeaTK7fP
 FGSpXawo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyE6TAjw0r2IG6xoITJp0w+
 zepgter5ucJ1Ws21nNVc8mGHHK1czjL8d/9ZFFM1g4vTTlbszVa3d437rkVJn//OrpUhzSewymC
 mDgA=
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
 arch/arm/dts/qcs404-evb.dts                      |   9 +-
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
 drivers/gpio/Kconfig                             |   3 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 146 +++++---------------
 drivers/power/pmic/pmic_qcom.c                   |  13 +-
 drivers/spmi/spmi-msm.c                          |  46 +++----
 25 files changed, 341 insertions(+), 475 deletions(-)
---
base-commit: 4d5dd7090b5ad770974a377f704907893469ebb3

// Caleb (they/them)

