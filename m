Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0292CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD5487475;
	Tue, 14 Nov 2023 13:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jBBIPV/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDF9871A0; Tue, 14 Nov 2023 13:55:47 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D81D871C7
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so3413249f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966545; x=1700571345; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7fB+mbQfeFtrpdMKR/7d8cSF1iC4KolRiOmqifdKpL8=;
 b=jBBIPV/V73PK9z83s9/SyNp7qJ1s3S8frqNL0VBd3FBqwu/B/L3yXRX1A88j+fmEP9
 M5WhyQO6xOR8+OYWnTsTysXXhsMICoFKcnBk8u8CN+rUQncnJuRHJrbs6kabwD9cixe4
 M0Y1aGAJgYjGqbwKRubh0dyB20dAe1+sV0/SxsT4EizjzIa82njdFv+SCNR9e0d7KmHO
 7dEtzc2X6Ix4HEVEvOnbXPtoyNoLzKi5JeT9KAMnHC8fT/6yUKW9gaR3kL//hF/2CE8V
 D0ifelV3UIV8qmlWEiHZVONOHPlYiELywAx9g+ktKQpB+5SDUFewaN4Uwms5Jc/tKWLi
 YY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966545; x=1700571345;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fB+mbQfeFtrpdMKR/7d8cSF1iC4KolRiOmqifdKpL8=;
 b=ErRVzaxXsP5zE0yZ2paBpxPgTV5jULPfeng/7XlCd/dGbG5txtPC0Kexnx8oxGLWTT
 nYaVR0XtvoMe1Kh3b4PeRdRrkpcNS+jlwKuJv7M7MMMRX/vJ3OTIeDJB3+7KwVnXvgZJ
 VonvP1kmhpVQTmz10cDfnXaBbnlJ31cz91J/YtBHPVGedH7jc0oREzgcHULPnzJ9PKJJ
 86hcXjy2qvc8UnKCNoRaVj1lLPx45cvuBwistvv802i6Qs2k773158ikHJqYCrO5D++h
 AwNGmXdSf5dJChSK4WWDGC50+1uGj8opbC/o1iVhSHD5HfOKl2c4sRR5zEqLWiXMP06E
 SfEg==
X-Gm-Message-State: AOJu0YzRm0ExRAkajC56k3EE+0tDRcRXmKAgkOb5eD+CnCM9cJAOBnPD
 K6q3RtPlM9rXAxKHPhiGxNd5Ffk4bprIaW99L/Fa9A==
X-Google-Smtp-Source: AGHT+IGr1zPw6ikEFxutQkAN06Y6Dd2K/kTAQNGhjxoYs5tq1YfP6jFz/+utUmC3M2RgzCjmuFDENQ==
X-Received: by 2002:a05:6000:1565:b0:32f:7ebe:3e5a with SMTP id
 5-20020a056000156500b0032f7ebe3e5amr7868865wrz.50.1699966544843; 
 Tue, 14 Nov 2023 04:55:44 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0032d9f32b96csm7748569wrj.62.2023.11.14.04.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:55:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/4] arm: mach-snapdragon: Qualcomm pinctrl driver cleanup
Date: Tue, 14 Nov 2023 12:55:39 +0000
Message-Id: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtuU2UC/3WNTQ7CIBgFr2JY+xmgLVJX3sO44K8tCUKFSjRN7
 y7txhjjcl7yZmaUTLQmodNuRtFkm2zwBar9DqlB+N6A1YURxbQimDYga7ircIPRejVFB7XUDW+
 56ireoPKSIhmQUXg1lJ9/OFfGMZrOPrfM5Vp4sGkK8bVVM1nX/4FMAENLaKWZoORo5NlZL2I4h
 NijVZbpR0Aw+xXQIqgxM1xzxlslvgTLsrwB2UOdvAUBAAA=
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
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=3957;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=IXa/uR+YkdChdxC6LSZE2UIbMN9kBprT2V22bpXVlaQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgPP/p2VfF0pLWHzq7fcurpKubnPTYalacVIvZcuTWh
 iPOls28HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiB3wZGXY9iQ2f6HcioHDL
 n6ZfFi21qVblsYyLSyRPPV65eME6ZWGG/3kPgjwcsv+I/6uTmG50V+LYroNfhfTW7co5xrzw9XL
 JRdEA
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

https://lore.kernel.org/u-boot/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org

---
Changes in v3:
* Fix header in msm_gpio.c
* Link to v2: https://lore.kernel.org/r/20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org

Changes in v2:
* Drop msm -> qcom rename (will be handled in a future patch)
* Drop "handle reserved ranges" patch to be introduced alongside a user
* Re-order APQ4019 move to be the second patch
* Change driver name to pinctrl_qcom instead of qcom_pinctrl
* Add MAINTAINERS entry
* Move shared GPIO header to mach-snapdragon
* Link to v1: https://lore.kernel.org/r/20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org

---
Caleb Connolly (4):
      pinctrl: qcom: move out of mach-snapdragon
      pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
      pinctrl: qcom: make compatible with linux DTs
      msm_gpio: use unsigned int

 MAINTAINERS                                        |   1 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/dragonboard845c-uboot.dtsi            |   2 +-
 arch/arm/dts/sdm845.dtsi                           |  16 +-
 arch/arm/dts/starqltechn-uboot.dtsi                |   5 +-
 arch/arm/dts/starqltechn.dts                       |  16 +-
 arch/arm/mach-ipq40xx/Makefile                     |   8 -
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.c         | 166 ---------------------
 arch/arm/mach-snapdragon/Kconfig                   |   4 +
 arch/arm/mach-snapdragon/Makefile                  |   5 -
 arch/arm/mach-snapdragon/include/mach/gpio.h       |  28 +++-
 arch/arm/mach-snapdragon/pinctrl-sdm845.c          |  44 ------
 arch/arm/mach-snapdragon/pinctrl-snapdragon.h      |  33 ----
 drivers/gpio/msm_gpio.c                            |  42 +++---
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/qcom/Kconfig                       |  46 ++++++
 drivers/pinctrl/qcom/Makefile                      |  10 ++
 .../pinctrl/qcom}/pinctrl-apq8016.c                |  21 ++-
 .../pinctrl/qcom}/pinctrl-apq8096.c                |  21 ++-
 .../pinctrl/qcom}/pinctrl-ipq4019.c                |  25 +++-
 .../pinctrl/qcom/pinctrl-qcom.c                    |  70 +++++----
 .../pinctrl/qcom/pinctrl-qcom.h                    |  15 +-
 .../pinctrl/qcom}/pinctrl-qcs404.c                 |  21 ++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              | 100 +++++++++++++
 25 files changed, 350 insertions(+), 352 deletions(-)
---
base-commit: 8c5e4ddf52ea3c1e85c44cdd5d5b2e2f6c892b4f

// Caleb (they/them)

