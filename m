Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DDFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602DB8702F;
	Mon,  6 Nov 2023 16:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ng57Dfd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FB586F84; Mon,  6 Nov 2023 16:29:06 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5463186BD4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so3413743f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284543; x=1699889343; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YTH6/Sr+mCs/OKYx9wlbi+aCsberASGZt0GrzBhH490=;
 b=Ng57Dfd85cT4v5GR4FhPS3IKbkXx8nzA67qsX/tbriMK5ntl2vBFkdCar3Inez+Jf4
 JZrsm03xe7qrjC2oR6iCjWTZFdUUf922bSJPpVTAsVRUfE3vUykYIBIwbLQDei6diKwp
 VGoese5HAeGvsZx/glS4pcx8Lh1ZZx7DRYe2MkimzYj35IYS3fXmQKdUXuZBmebKnIRY
 xaJSE3U/bAW2JNocK5d+1Bpd5MN8uPIWmqxwYwNG98MHuGRt+hS0AisAeK1+HXO/z402
 o44iQ704AbpWTTKRunVQr8fNvsSC04acbcYZ9poDmITGzOmzi1avL/wjwaFuVFn242g4
 KEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284543; x=1699889343;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YTH6/Sr+mCs/OKYx9wlbi+aCsberASGZt0GrzBhH490=;
 b=WUY0UZ/t8H3igDdjPo6U8VM12J5qU/0KqNi8pKWoZMWnmdJ8Vn8nqh3mexmrdveb9t
 JSIoiO/FO96cTo7yTZs2mWW7IrNugcbOzibSeeYD+TC8S2TbvWOH5CQzFwC0d06+3XSr
 apwRghQSKS7rL74sTHeYmhaUkHCUryprTFuKbDoP27yLQPQirphxMrtELQu4eslMm+zJ
 U1OTe53bi5YSBL+90uhIVLZdSpTiGu9B/TMPZACb8H9Yzk6zZ8Nhatd9zQAZqm0BJOvK
 X653zPc3S6xqbBrG1vQCvvvdSM8iw6lFuewJoafBCBQqezBm+HURHYkhZWWzQO1r6GBC
 9Ztg==
X-Gm-Message-State: AOJu0YyffD958ofh+jEQQOxKLe26XnvG+buxOVvb8KquXLR0PwzKmLID
 n+VnlhU5eRucio41xNBh2g8GUg==
X-Google-Smtp-Source: AGHT+IEcITVjUZ1IAF6d5JDknKy5Aem9Zq+9j+AVIUGedoGdi9dS62AYt8jEzR6WTivvYfJyA6Gb8g==
X-Received: by 2002:adf:d1ca:0:b0:32f:89fb:771b with SMTP id
 b10-20020adfd1ca000000b0032f89fb771bmr10096952wrd.4.1699284543666; 
 Mon, 06 Nov 2023 07:29:03 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 bx30-20020a5d5b1e000000b0032f7d1e2c7csm8116094wrb.95.2023.11.06.07.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:29:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/5] arm: mach-snapdragon: Qualcomm pinctrl driver cleanup
Date: Mon, 06 Nov 2023 15:28:59 +0000
Message-Id: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwGSWUC/3WNQQ6CMBAAv0L27BpaQIGT/zAc2lJgk9riFomG8
 Hcrd48zyWQ2iJbJRmizDdiuFCn4BPKUgZmUHy1SnxhkLguRywp1iU8THjiTNws7LHVf1U1thqK
 uIFVaRYualTdT6vzLuSRntgO9j829SzxRXAJ/jusqfvb/YBWYYyNk0V+UFFerb4684nAOPEK37
 /sXbsoKUsQAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3876;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VRWBuCSsfo/T8E/tVD+W2pXI1LZbn3GI6b0wDtetH4Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRPNrtjF+NttJYZsP9P/1l79UESz7rnFtd9jDbfCEz1f
 qeSpj+3o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzElIXhf5Vb+tG0z49/st3P
 f9pgLT5jujBP/Smdq3uVSrqknv5Y7srIsLzKZ/JZxp4y05XJE4WMdjyb2T7751QmPaubF+4mzA1
 wlQQA
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
Changes in v2:
* Drop msm -> qcom rename (will be handled in a future patch)
* Drop "handle reserved ranges" patch to be introduced alongside a user
* Re-order APQ4019 move to be the second patch
* Change driver name to pinctrl_qcom instead of qcom_pinctrl
* Add MAINTAINERS entry
* Move shared GPIO header to mach-snapdragon
* Link to v1: https://lore.kernel.org/r/20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org

---
Caleb Connolly (5):
      pinctrl: qcom: move out of mach-snapdragon
      pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
      pinctrl: qcom: make compatible with linux DTs
      msm_gpio: use unsigned int
      fixup! pinctrl: qcom: make compatible with linux DTs

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

