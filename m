Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6179DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C052287CDD;
	Tue, 31 Oct 2023 15:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcFP67M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA2A87CD9; Tue, 31 Oct 2023 15:22:27 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EE287CCE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so41514165e9.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762144; x=1699366944; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dzMW4p0c6bsfOZxFDF5YYTk7WJ6ktlj8SUzDW8S9Pr8=;
 b=WcFP67M7RG8YvmAsYiBDjQwjLLONFrcs8mAhWkTmQyej+9XkDLKSAPc4OLlR2pLHfw
 ddFaJiJbWZVc1rIUV/gqvQc3LOmY9m+2lKqa6JPswSMLOJK3nq5Fqnf+hIuIC+MDF1pC
 0cnFhoizH1FY88GBiphRKG9pfZl+cb8LHKd2xKsOngJlMOti+wWR4sZzZbe6y8LR4igl
 4j3VoQUdAmszWyZcMdIFn5mOcnzXqy2umLMTRKfasxLlQOc0q3J6E+MMRAIyGE3Y4sNx
 33JtfoPLTORshXK49PxoJAm4lHRyt+9DQlS5sc/Kvgzl2P4yCYSbYrSVBCrw/J/qznLE
 l0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762144; x=1699366944;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dzMW4p0c6bsfOZxFDF5YYTk7WJ6ktlj8SUzDW8S9Pr8=;
 b=Ic5HosoUFcTWTaMXrXY2HTKV2EH9zLfAdSaKyDi4vHz5ZPpUOeGnTowXDkOcbADiQp
 4bO/beYV8C6RSbgSUzsxg7L6HmgtlS5BSSU19mEHDSCv2fo5e2szXEHjvv5AlhaDg82j
 knHoet9+tmtVqaJ7R4pKwFVtcM/OTmbbfh6cSkGLrX1+A+vyHULzlxC3SK20ti0T1QBb
 Dk1/e3P4WModgbrPe0/J6CquNA+Vyt+epvngCSGi5gfVqnlgRPNoQ7u+vw7ec1ATlqgT
 fbOwUjiC/h7PCQ6vsjeOIBN+V3iVBtK9Bum1cHNf6hKZU/0Gi4bdwJDrDLXNBPoWBg0+
 AI7A==
X-Gm-Message-State: AOJu0Yy7xhVUfJtSqrseaNh0VwzoY3ZsBqL3zBaow8rMRkQT4Z9KfCR5
 DLEfahBgDh0acmL45gOnOvbBKw==
X-Google-Smtp-Source: AGHT+IEfs3XfKLERSo1RSCWBkumxU1SM9RzeIsrLeGmPJLZjZ/mHq8oTGOwRIJ21jVcc/yHezSftuA==
X-Received: by 2002:a05:600c:45cb:b0:405:3ae6:2413 with SMTP id
 s11-20020a05600c45cb00b004053ae62413mr11145508wmo.25.1698762143916; 
 Tue, 31 Oct 2023 07:22:23 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 i8-20020a05600011c800b0032179c4a46dsm1606372wrx.100.2023.10.31.07.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:22:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/6] arm: mach-snapdragon: Qualcomm pinctrl driver cleanup
Date: Tue, 31 Oct 2023 14:22:19 +0000
Message-Id: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsNQWUC/x2N0QqDMAwAf0XyvIBWC91+ZeyhjXEGuurSbQzEf
 zf4eAfHbVBZhSvcmg2Uf1JlKQbdpQGaY3kyymgMrnV91zqPacA3LS9cpdBHMw5p9OEaaOqDB6t
 SrIxJY6HZuvLN2eSqPMn/3Nwf+34APUBn+XYAAAA=
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3925;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=29RBlbjZghGXNCSxobpclTY78RVLrSJ65MEqN6G7ieQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRH3nln7R4l5SwWcJ1e0rRy49zpklNUGl4G6H6/bFSZU
 CDzmulzRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI3zKG/z61ZfP1chqUK2rv
 znogoxF5fYXjEpurO7y/nZnXv9jWLJvhrzjbjd/rbk+9/Kz3bNW6TdvsZtYa1b1OWsjpt/vM+vb
 3v6wA
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

This series moves the Qualcomm pinctrl drivers from mach-snapdragon and
mach-ipq40xx to drivers/pinctrl/qcom. It then makes the necessary changes
to enable compatibility with Linux DTs.

The pinctrl hardware on most Qualcomm platforms is made up of "tiles",
these are just banks of pins at different register addresses. The
mapping between pin number and tile is totally arbitrary, this
unfortunately means that it is necessary to have a map of pin to tile in
order to support all pins. Up until now this driver has ignored tiles,
meaning that the pin numbers and DT nodes are entirely different to the
Linux DT and only a subset of pins are addressable.

Patch 2 solves this by introducing the pin_offset map, initially
supporting SDM845. This map is used for all pin register lookups for
both the pinctrl and GPIO drivers. Similarly to the clock/reset drivers
these are both associated with a single DT node, where the pinctrl
driver is responsible for binding the GPIO drivers.

Patch 3 introduces support for gpio-reserved-ranges, this property
is used on some boards to mark pin ranges that shouldn't be touched
(else firmware will trigger a fault and reset the board).

This series loosely depends on the associated clock driver cleanup which can be
found here (Makefile and perhaps DTS conflicts):

https://lore.kernel.org/u-boot/20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org/

---
Caleb Connolly (6):
      pinctrl: qcom: move out of mach-snapdragon
      pinctrl: qcom: make compatible with linux DTs
      pinctrl: qcom: handle reserved ranges
      msm_qcom: use unsigned int
      pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
      pinctrl: qcom: rename msm -> qcom

 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/dragonboard845c-uboot.dtsi            |   2 +-
 arch/arm/dts/sdm845.dtsi                           |  16 +-
 arch/arm/dts/starqltechn-uboot.dtsi                |   5 +-
 arch/arm/dts/starqltechn.dts                       |  16 +-
 arch/arm/mach-ipq40xx/Makefile                     |   8 -
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.c         | 166 --------------
 arch/arm/mach-snapdragon/Kconfig                   |   4 +
 arch/arm/mach-snapdragon/Makefile                  |   5 -
 arch/arm/mach-snapdragon/pinctrl-sdm845.c          |  44 ----
 arch/arm/mach-snapdragon/pinctrl-snapdragon.c      | 166 --------------
 arch/arm/mach-snapdragon/pinctrl-snapdragon.h      |  33 ---
 configs/dragonboard410c_defconfig                  |   2 +-
 configs/dragonboard845c_defconfig                  |   2 +-
 configs/qcs404evb_defconfig                        |   2 +-
 configs/starqltechn_defconfig                      |   2 +-
 drivers/gpio/Kconfig                               |   6 +-
 drivers/gpio/Makefile                              |   2 +-
 drivers/gpio/msm_gpio.c                            | 127 -----------
 drivers/gpio/qcom_gpio.c                           | 148 +++++++++++++
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/qcom/Kconfig                       |  46 ++++
 drivers/pinctrl/qcom/Makefile                      |  10 +
 .../pinctrl/qcom}/pinctrl-apq8016.c                |  33 ++-
 .../pinctrl/qcom}/pinctrl-apq8096.c                |  33 ++-
 .../pinctrl/qcom}/pinctrl-ipq4019.c                |  33 ++-
 drivers/pinctrl/qcom/pinctrl-qcom.c                | 244 +++++++++++++++++++++
 .../pinctrl/qcom/pinctrl-qcom.h                    |  17 +-
 .../pinctrl/qcom}/pinctrl-qcs404.c                 |  33 ++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |  99 +++++++++
 include/qcom-gpio.h                                |  43 ++++
 32 files changed, 723 insertions(+), 627 deletions(-)
---
base-commit: 34f2a2a3ec23b4d24b8020054aacfad1143bd430

// Caleb (they/them)

