Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516C7C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C35886E7;
	Mon,  8 Jul 2024 13:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U5rkbmL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8784886DB; Mon,  8 Jul 2024 13:33:09 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559F9884CC
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea929ea56so3812904e87.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438386; x=1721043186; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SuiuHq2egloswZBBszTCZJMJKuPRuGimiAQPwi0aliY=;
 b=U5rkbmL0tZJ3Qu3uwbdEeERnp+KJcvy9cgN6X/FhopHBDxqpNCwq3Q0jpH9WglvCnw
 2Y2b4BJLZzDdAx6Vs2OZe6r8huYM3dFjZH7HwtWFVTaGG0bYW7SY8PoYYzlBTwgL2saJ
 nzFOYeDEfg2Y7zD33qq9skqRvmNmpq9w0NaXghqx9PRQFdFzdMrJ51YCFGwH9IexbQ11
 8Feh4kYkXC4Dz9Y4xteijN0h5eLkqMUs3rPbBSOcAxM38NM1M8dIBglpiJ61rrZMNFOM
 8MHR1Se1jkt+Osdd92fHuJg0y9JIaY1RqQfoqfJncFYsVD37Sv7OnD2Cl1NYe6DnXZIk
 tboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438386; x=1721043186;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SuiuHq2egloswZBBszTCZJMJKuPRuGimiAQPwi0aliY=;
 b=NHqFuTDLrF7CbLRbgMrJDZX7l9d2dgikANAOWR4XNhjuCE6ehn0gJdO8t7SxMqA89v
 C5vWbHzloMN16AQfkN2XHPQi40WZyQk3dbPs/DN2aZKO5Axc9hLPUSBSFl5naqpQQj9W
 oJqq5d81RV4hwW1xzO75xegfJNRFTjawAZcHi4tJDL0rxCBZinRqX9hXs/WpHJh9BAOk
 bYy24XunM6EN7uwmAIGGbBJQpTzyyoSsuImoUIRBOJM2DKSV6FsHqlVGcqYo4kEgau9X
 9ZpM45Fn+/gzsUdcQXTUkTmqm/aOWdTyCcP4OGHT2BdkTjLqCQtO1T0Xwb64yR+Qj2aL
 kgfg==
X-Gm-Message-State: AOJu0Ywvpml3e82zl6w+7IELQNrvpBUW4voSGC2pr7lor6rZcS76gBAy
 /ZOAlWwoCsiUuP6vepag3ID3njJi/P6eGObhQLuE4rKB1xjgUfgUZZ6Df3t+h/060Hn9Cep+MsG
 u0Zo=
X-Google-Smtp-Source: AGHT+IFVAN5oJ2yQ/MJJPqpdEaZZVVdG7dis8HbVq7GeveiftuSC6Vtqz1qLIpWJPWezIVvFDvDFMQ==
X-Received: by 2002:ac2:4568:0:b0:52e:710e:e4d2 with SMTP id
 2adb3069b0e04-52ea06327b8mr9229530e87.33.1720438385775; 
 Mon, 08 Jul 2024 04:33:05 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c9925463sm303628466b.69.2024.07.08.04.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:33:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/4] qcom: rpmh core and regulator support
Date: Mon, 08 Jul 2024 13:32:52 +0200
Message-Id: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTOi2YC/1XMQQqDMBCF4avIrDslmYjFrnqP4iLGqAPV6KSEF
 vHuTYUuuvwfvG+D6IV9hGuxgfjEkcOcg04FuNHOg0fucgMpKlWlNbYlri5MKMs0Yu/6zpB1VJc
 K8mUR3/Pr4O5N7pHjM8j70JP+rj/o8g8ljQrbjoypajJe2duDZyvhHGSAZt/3D52SctKpAAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3554;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=f/yJ0MvbDxF+4VvnutUnAXeuC+pZ+Uz0dQhK2NPOFrE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi85wUs04WuLNknUcgCBuNYuek0MGNDAv6htgq
 bbcuUbhVKGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovOcAAKCRAFgzErGV9k
 tlLTEACPOSj68GV6f9jpxKUoW+h2AydAivXaviH2Od7k1lV1baU3zU873AcLcuY+9ruSsWcIGcE
 FqXwpq/JXGvZMIp9mfiyW/lX4Yt4yvPzt7l033Yekg9m3FCSEl14lC6ipFEXeuOHzFj7wZnIs2z
 3BnMVTYZJ5ui2qQ2Z26QSrS7POUapx8jgdUXX4jE9xL429w27WPmKtCsJ/7IBQDRXHwih2NZ0QI
 u7EjPiAmyI8FE2HLZf9dm6QjGqB/3NN2E1MsrLJ10fp78FLZDNHIb1zfICTJvK/gElF4CCaZHGD
 ki1CS4WmqVyR2lAMD+IQ7KzRqIsh+q4vLj8mh5Mq7EpnZj2PHoKws0ekpOr2BxjE5D9hiX2ZWyD
 si4SiDx9ZwDkCEpb7Zc3GCax8/X77O+moNhGj6gnSofJxB7ylsXlDkAKfl6razvnAlFCCTw57q6
 U4uRASCGxn1fUVK0OSG2tCoO/eqVVwEmM8Lw/rN64TfEpVZooZz34CDWV/Rt6ecfTuth9JRv+ka
 yVI7VANj1gNFysxc30/PlDVAOolcFvk1qGxe7n2mutfUkRZOEKYIBAHZhLcpy+AX72bRrijR82R
 AswZ2PHQAwOk6Oi/zCrh3J2nHPDJu2vbgPwpHm2B04+Arbbqy9Iv9t2ohnNb6t2ZFg2OB0NvmoE
 nHfd+XVk3AD0AdQ==
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

This series introduces support for the RPMh (Resource Power Manager
(hardened)) co-processor and associated regulator driver found on most
modern Qualcomm platforms (since ~2017).

Even though most regulators are controlled via SPMI, the specific
regions on the PMICs for controlling the regulators are restricted and
can't be accessed by the Applications Processor (AP/HLOS). Instead,
these resources are proxied via the RPMh where they can be voted on by
multiple subsystems (Linux, the modem, and the other DSPs). This is done
for security (to protect clocks, power domains, and regulators that are
specifically relevant for the trustzone) as well as to simplify the
management of shared peripherals and to allow for handover of
peripherals like the USB controller.

For U-Boot, our main concern is the regulators. Since all regulators on
the system are controlled via the RPMh, it is necessary to support it to
enable USB VBUS on some platforms, and may be needed for other
peripherals in the future.

Communicating with the RPMh additional requires accessing the cmd-db
shared memory region, this contains key/value maps to determine the
address of specific resources on the RPMh.

Introduce support for the cmd-db, the RPMh framework, and some of the
regulators that are necessary to enable USB VBUS on the RB5 development
board.

These drivers were originally taken from Linux, however they have been
heavily modified and simplified for U-Boot. Since the original Linux
drivers contained heavy optimisations related to multithreading and
asynchronous probing, as well as support for idle and suspend states
which we don't need to deal with here.

The U-Boot version of the driver supports a single TCS and always
requests a response from the RPMh, since we don't need to worry about
having multiple transactions in flight at once.

---
Changes in v2:
- Implement Neil's suggestions and fixes for SM8[56]50
- Slightly refactor cmd_db_init() for better abstraction.
- Improve logging (printf -> log_err/dev_err)
- Add missing error check in rpmh_regulators_bind()
- Link to v1: https://lore.kernel.org/r/20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org

---
Caleb Connolly (4):
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: rpmh and cmd-db drivers
      power: regulator: add qcom-rpmh-regulator
      qcom_defconfig: enable rpmh regulators

 configs/qcom_defconfig                        |   5 +
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 536 ++++++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/qcom/Kconfig                      |  25 +
 drivers/soc/qcom/Makefile                     |   4 +
 drivers/soc/qcom/cmd-db.c                     | 261 +++++++++++
 drivers/soc/qcom/rpmh-internal.h              | 141 ++++++
 drivers/soc/qcom/rpmh-rsc.c                   | 628 ++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 112 +++++
 include/linux/bitmap.h                        |   8 +
 include/soc/qcom/cmd-db.h                     |  42 ++
 include/soc/qcom/rpmh.h                       |  29 ++
 include/soc/qcom/tcs.h                        |  78 ++++
 16 files changed, 1880 insertions(+)
---
change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
base-commit: 50adc932e7aa34e6d9c738ec13ed09382a9d109a

// Caleb (they/them)

