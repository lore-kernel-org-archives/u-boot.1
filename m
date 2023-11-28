Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE0AC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896C887766;
	Tue, 28 Nov 2023 17:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eMqecLUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EF587766; Tue, 28 Nov 2023 17:30:52 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C91C87762
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332fd81fc8dso1935258f8f.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701189049; x=1701793849; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ht+JkORDqDWHj182RBOBqn23tjSl5/TkWr4pn0wdvG0=;
 b=eMqecLUEmmXDtq41ODR+5xSZ2fiUa9EdO68+D4vmaNqPSnC5LW8oZVtifbOwuQaukn
 h9V980NveqdrxSZ/eoWqmOEijuu4yK6INfl90GnVAIVgu4/M2Ss9Ydl3KPBgqD24IrTJ
 O7x9yqt3X16GS2luiuLUvPvsmKxYc9xuYNXQBSGXLkaLZyHjhaeSokYzp55xajHh6on5
 TkLS2QMV8tx5xN9hA97d97LsiMcQMgjv9Q2RxaZc+cEYQpa3uxOouM8rgfzqbZIXWHvU
 GMFEGMNYOEJvwq5+txFBhjMr1aD4sRoUgAhZeRSAj/2t4VbE4v/iNoENBRdaN5xMMH9k
 VryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189049; x=1701793849;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ht+JkORDqDWHj182RBOBqn23tjSl5/TkWr4pn0wdvG0=;
 b=jphmtNg10z6EkaiJNwdzjpYGK3lBBHvxkksM6glcaD73Z6CAiPjPjff7y9HqbAJrAk
 mj4ZJUIPnkZjydXo0Y6GaNAJe40h15ddTlhfv3Vx40BkJjPg0TGTFqrP6GtN9aNPzfoo
 G4slr2/xHOIdM8Llihpv2UTKm+K23QCGAe5Fh/HnU8BGEgUgjX3298GFoY66WNt3AP/U
 FEDOasrwqosd8XZSHc8LUQ61qbcY8pETRZ3qVqdkqp1bS8sTwwFH3aRu8IDDGrF7fWbp
 0BI+B4w8MkouEcW2zGl02N8P4BWu1zMEEDl8Axhdh/eDtDWoIpj3vhEIBrVyiK/K2rJK
 yaVQ==
X-Gm-Message-State: AOJu0YzTKYrP3GpPiVseOjJ74Z05dH3uUr/kU7KjuRNoEM++BoXBeKNW
 ifth2/gkN7WSeOdQ0v7LPzP4owZZoJq9QOjPTcOAhw==
X-Google-Smtp-Source: AGHT+IF0sM1zqVlZewRNSluS1DsQLXjn1Fmjm7ZlHWZ3QSrMCCPiiCDSvMwhBKDMGpSmAlCYp3Yokg==
X-Received: by 2002:a05:6000:c45:b0:332:fe7e:2a2a with SMTP id
 do5-20020a0560000c4500b00332fe7e2a2amr5788689wrb.44.1701189049504; 
 Tue, 28 Nov 2023 08:30:49 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d21-20020adf9b95000000b003316debbde4sm15530041wrc.48.2023.11.28.08.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:30:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/5] Qualcomm PMIC fixes
Date: Tue, 28 Nov 2023 16:30:24 +0000
Message-Id: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAVZmUC/33NSwrCMBCA4auUrI0kk2BSV95DXOTVNqBNTUpQS
 u9u2lXF4mr4B+abCSUXvUvoXE0ouuyTD30JfqiQ6VTfOuxtaQQEGKXkhDXHTxMe2I64jEGN2Ck
 mBCG2scBQuRuia/xrNa+30p1PY4jv9UWmy/aflikmmBijtZCcAqeXu+9VDMcQW7RwGbaE3COgE
 IIyYMwIqLn8IdiGoHyPYIWQUtXQyIYQrb6IeZ4/AK4wrTkBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3460;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=FPOLlTxMAyl3n/8TfNpKZoK5JZgwcvwwe7USY3HpOyI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ00e3svX6CCXU6PK/ErvGevnP3g7V1wDK5qv0lv4um+
 T7VapvVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACaiq87wz9S01nBjjlauzMX9
 19ucHwjmldq8fDtV8P+pQ23XRYqyohkZNrOksaY9vsbgHlPTqtiwcm6i/YKrqz02z9r+QMFbaf2
 sEwA=
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
Caleb Connolly (5):
      gpio: qcom_pmic: fix silent dev_read_addr downcast
      gpio: qcom_pmic: rework pwrkey driver into a button driver
      gpio: qcom_pmic: fix support for upstream DT
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
base-commit: d1efa48e205960b15656eb0c13227110895f1cc9

// Caleb (they/them)

