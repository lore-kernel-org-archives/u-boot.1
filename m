Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480CB1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55C38414E;
	Wed, 11 Mar 2026 15:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Mm5nAidV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCB284065; Wed, 11 Mar 2026 15:20:48 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AA184010
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-661cfb9f3aaso8117991a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238846; x=1773843646; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OPmrouOuvjEZYscxnkUp68Ju3BQaUZ1OnQ+kMSQdBGI=;
 b=Mm5nAidViefw4GhdOR6tLLCfxvQmHJIhYV33VMvGKUYr51TxxHVlQFMbiaX/B2jPjL
 I1VsLLQ8KgIqr+nc1K1CFDDql5v17UX/0GKDY72mhbdbpASzCq4UrcopHFwPEnA6S/S1
 gxghkiNp8fLcT5jXMGShPk57GZ9GYQ8cnesK/SHud3SMb9ZlsYszgW9ELT9PwB/bbu1S
 9IdDlAd+iYhC8GWIfMsQsD4WJIgDJibtkx/2GdzYDG4Hp1pytI7jL3iRf6RAQ34Pt4Hq
 Lb0eBEis4UvBgRvOEsLCDWiGZDgoCp+4BkHzMnRm/jIIIp3PsUl5PYj1J1n/rQ0XxFfB
 PpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238846; x=1773843646;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPmrouOuvjEZYscxnkUp68Ju3BQaUZ1OnQ+kMSQdBGI=;
 b=Tsabb4xoXtCPiLLUE4wV9DVb24FJI8tZe/Q8qCXQxc+o6TEtj9HlfHXAV10fq++Sjq
 caYpjg0Y5uidMtA1mM/fuHpxD6MQ/JKmdmGqR+Mjz2BrE6N1AbnaS8YKZoQ0h1rmVMrH
 NB2l0afe9Wti1QMZdepDZf3Mh34BEjQBE7ClOocda0RJqIQ1abe3lr+CCIk9tnU6kngL
 nsI6aGkwBnbMxLk3jzuOngstSnezsTRj1jduX4/X/KbR544lGSaoDBL4GLPT/s8A10B2
 LAOm0KxzZ49asrqn1UDuAKPTwXxpYDbSt8nV8dtRaUtfYOTnOKiMB3lB0QoX3iC+N/Sc
 9RoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi4WIBhFTpCUr8cIDn7QCte5UUIw4G5LeByakmk7RHnAVcxUCBry4HIzRkv3AbTI0CzXIuH8k=@lists.denx.de
X-Gm-Message-State: AOJu0YyTF0RQFuZnxpm0k6BPQQmcZy4xDYBwb9RV+I1AOW0d67ZI83Sv
 1pTRuXao61thU5xTH/WXZCy1kCKaposPdHUqC8WP4+V7U+YYKjnWloWlQynkuXqG5mU=
X-Gm-Gg: ATEYQzwa21F2KdJtdq51WuJetHezOaZ9zJRTWMvqSvidCOoglz6U3HBvk0VR1uE2at0
 d7vOT+IsVGTr6Qg/LQI1SyJHkL3JKyb3F8gVadLdmYyt9BJ4AW6S3cneHc7x0WG5UCpJFV64754
 94StB1oUTri0FX4qTC9PFL2SNIUzRmXQDL3q5TEOxvbVW/4No+W+da7KLg2XkDe1mmwKXJE5Qts
 oBNNWCvbwGGpLgADKXpPw8ZL8ZLfqGVWk21dJNWd0tCa1NbT0G5q218Mlp/MOURjOkiRx8vSO8Y
 jZdpK3ql2l1cUVixHFq2cBpmPyRM/VXi0HuzR1Eq5N+8SL3JTUjLphKSoE+p0oqnI4vORXd5IT3
 iGsTYoq1Z9GjgoeYkbseOHWyW6GaJmM5OJzdQFKzgkBCLlUEoemIjDx9EDk05Z2T+gnvNhU7p5Q
 RUC7j/SNsy8e8dRcWPoUYNOPfJ/cpi8yzm0Hrb30kqN+qiN0O+QmTNBOsWLS/ZRVWGniMNfvKIa
 tI+mg==
X-Received: by 2002:a05:6402:358e:b0:662:811d:60fa with SMTP id
 4fb4d7f45d1cf-663187d8caemr1325931a12.0.1773238845583; 
 Wed, 11 Mar 2026 07:20:45 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:45 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/7] Qualcomm Milos SoC bringup
Date: Wed, 11 Mar 2026 15:20:40 +0100
Message-Id: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VcJs25KYkMrvkpxkctoB5rETlQE8
 d2b1uV/4Hw7FGTCAp3YgXGlQjnV0BcB/mXTiJJCbWhUc1c3rWWkdy7SMaVxmSSG1qkhPGxrPNT
 PxDjQ9vee/dmMn6Wy8zmCswWlzzHS3In1x16VkewN9MfxBeKOdsOPAAAA
X-Change-ID: 20260311-milos-bringup-ed8b0fd7a84c
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=1815;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=nLeK2tey56qt7XccTPmSFpboWYD6Tr7NljbK7PBt1iQ=;
 b=mlYdXkqrHq8TrcYUkLMYTSxEsfocoBH+ngTIbozSbQNU7+bTPJ8w0ny5BxHE0oXUYR95QFfJ5
 DzhFC32aTh+AwrAVWQDWwM8U2Q6+nMvRIzE7d+tBG3XEDUdwt16/WtO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Add pinctrl, clock drivers, UFS PHY configuration, PM7550 regulators and
GPIOs to support the Milos SoC in U-Boot.

The milos.dtsi is part of Linux since v7.0-rc1. UFS is still on the
mailing lists but parts are slowly getting picked up, so hopefully v7.1
will see some parts already.

Working features, as tested on Fairphone (Gen. 6):
* Earlycon
* UART
* Framebuffer (with additional patches, both dts and u-boot simplefb.c)
* Power + Volume buttons
* USB
* UFS
* SD card

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (7):
      drivers: pinctrl: Add Qualcomm Milos TLMM driver
      clk/qcom: Add Milos clock driver
      phy: qcom: Add Milos to QMP UFS PHY driver
      regulator: qcom-rpmh-regulator: add support for PM7550 regulators
      gpio: qcom: Support GPIOs on PM7550 PMIC
      qcom_defconfig: Enable Milos clock driver
      board/qualcomm: add debug config fragment for Milos

 board/qualcomm/debug-milos.config             |   5 +
 configs/qcom_defconfig                        |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-milos.c                | 224 ++++++++++++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |  88 ++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c          | 104 ++++++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  33 ++++
 11 files changed, 474 insertions(+)
---
base-commit: 79126f765ff9fa390ced0c1f7a94b30c6c36f09a
change-id: 20260311-milos-bringup-ed8b0fd7a84c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

