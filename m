Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EAFCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E24683677;
	Wed, 17 Sep 2025 18:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="OS5eLf8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40741835B9; Wed, 17 Sep 2025 14:47:52 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F274F80C93
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso800950766b.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113269; x=1758718069; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xDVmkA5XCgWHEC8wknEhdMnWg4aY+OBm5C5RZINyFnI=;
 b=OS5eLf8SmxT/XrDYFt0vbSYWRkqnRqlsgVuhnRnJ5vnMylZBb/oOLRHcooHHWvqiFm
 N+r6Sv+tH3wzoB7qVXjmVSp9HOPl1GxHTEBWAOnVvyJfNN96Dvul386DwRJ+JHLEMY02
 5kyUdDJhnyq0C1y0uY85zwKA27HQJBR6jwgiXEpsQXTP9NCYEim1dbZ8ZnO0c2oyeFjV
 aQ2PMBrRCyCCV8OnhzGG01bJsIN3/XR6RSb4jy0I8QBN7wnXOEYEgTFNiIqfegM97b2f
 LVplcbixh14WuYV6AFcVW+8UhDrhTThCWZgpxW1HVi62OkRNBrWNS5N7slY4v+3UGJnY
 D9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113269; x=1758718069;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDVmkA5XCgWHEC8wknEhdMnWg4aY+OBm5C5RZINyFnI=;
 b=FWIQVYHW2vT58Y9046yGcKD6sXdM9RI9Yt86THU7Me9ySDMNLLjoDsGtg9BtL3ZPEm
 +pty9K6RpmCTwdZyNg3Etm2d+OBtViZfvMexRMv4blf8GpgrD7ysKoN1qoFrG5HTlSbC
 LyqhshP8JqYMYTq+hIRLBHBf27+H5rod4C1ccGgwfEy8R6Q1Uhnx9/7B2MkfbE+pvMuv
 8+ikPQHVZd7KpwrGFgxpVOl/kw1lTfUrO2QjQhaxoTvDC6c1e8cAch076v51dTgXDWe5
 4C6QHLMFbTE7UznSdvmuWb2oy5viPBhtspmNJ3S7e8t2rANKbcMR100U8zP2wlCSkAWx
 HRbQ==
X-Gm-Message-State: AOJu0YwFZIsLfHOyeunBERu6qNCfHGxfbkX1upPWwfmVzGsOW+V51+tM
 veNXQs8LWi7BYVU6e65cxwUTAZommPO77xioPe4oW9LR6QjFFUaM8OZSVk6czjgRvLE=
X-Gm-Gg: ASbGncs90pFjFDRyPet/5QLVw3hyXOQD1Jxy0HhcA1D6q01PfFp16Wyrki7h995JCQ2
 46xBdFY0fkRXoZewzZsa1NRFaV0eRh6DQ2gzRqIopp7meADh2tqRxH67DQoyTp0AKhaY+jsl4H/
 6wb2YKyjtTfh+M7i3CedVpuraLkjzmxaJkqfd+7sZzjCss+gXcqsswdRmuUKJREPqy/L/f3wmr2
 +5ONsbwsMHPeV7ZPiXrXPKU9GWyWwaGzlJhoHQv6bsRdJgzNLhSmUO/s35qphe6r5Y/QUBstCog
 +NC7Sa/tBp17u9tL4w9CKIkk2Wmjpna5pketnhFcl+I9CLfqYGjg9mOWjZw7LbIsE2fzt+C4SnC
 NZi2THyrdaSD4dT09Z6tqynfdeV3rCA3D7KsEBd2E/s0jhL8bc0z7Wb9zqQsdwTY+FDGfSg==
X-Google-Smtp-Source: AGHT+IGo6npRrPdtT3jgvXNaG34JEFtArkR1dmfA5YYHE0YC4MpbBpratmKMfspY7DzIp2diCiblEw==
X-Received: by 2002:a17:906:730d:b0:b04:725c:bcb with SMTP id
 a640c23a62f3a-b1bb60490a5mr240745766b.23.1758113269290; 
 Wed, 17 Sep 2025 05:47:49 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/9] U-Boot Bringup of SM6350 SoC
Date: Wed, 17 Sep 2025 14:47:33 +0200
Message-Id: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWtymgC/3XMyw6CMBCF4Vchs7amDHKJK9/DsGjrALOgJVNtN
 KTvbmXv8j/J+XaIJEwRrtUOQokjB18CTxW4xfiZFD9KA2psdVcPKq5d02plhf382pQeCC+kp8F
 ahHLahCZ+H+B9LL1wfAb5HH6qf+tfKtVKq8Y5RGNsb3pzmwzLtgRPZxdWGHPOX4pC/7SwAAAA
X-Change-ID: 20250618-sm6350-bringup-08e24e0f8bb2
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=2088;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=u0b0+0CVLx+Sppcg/b9nivsuHI3CXetqUEHUDEBLxPk=;
 b=UvOwnFtXZ7zjR4e0S6h1Iec1eW55nXWH8hDxxNyANsuowIsmiFlAUxMu33bcYXOZcsMC30M3K
 8GxAt/APJ9kAAABZtq14xGBsafM/lMUrIgXFuXl2ckXJSy0TDf/IcLC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Add a clock driver, pinctrl driver for SM6350, and enable support for
this SoC in the SMMU and UFS driver. Add a debug kconfig fragment which
configures the debug UART address.

Finally add support for the PM6150L regulators which is used to get
power on for the SD card.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Drop printf from clk driver
- Add patch for spmi gpio (volume-down button)
- Pick up tags
- Rebase on v2025.10-rc4
- Link to v1: https://lore.kernel.org/r/20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com

---
Luca Weiss (9):
      clk/qcom: Add SM6350 clock driver
      clk/stub: add sm6350-rpmh clock
      drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
      iommu: qcom-smmu: Add qcom,sm6350-smmu-500 compatible
      phy: qcom: Add SM6350 to QMP UFS PHY driver
      regulator: qcom-rpmh-regulator: add support for pm6150l regulators
      gpio: qcom: Support GPIOs on PM6350 PMIC
      qcom_defconfig: Enable SM6350 clock and pinctrl drivers
      board/qualcomm: add debug config fragment for SM6350

 board/qualcomm/debug-sm6350.config            |   5 +
 configs/qcom_defconfig                        |   2 +
 drivers/clk/clk-stub.c                        |   1 +
 drivers/clk/qcom/Kconfig                      |   8 ++
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sm6350.c               | 193 ++++++++++++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c                 |   1 +
 drivers/iommu/qcom-hyp-smmu.c                 |   3 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |   1 +
 drivers/pinctrl/qcom/Kconfig                  |   7 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6350.c         | 104 ++++++++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  31 +++++
 13 files changed, 357 insertions(+), 1 deletion(-)
---
base-commit: 7a4f3c5652157cbb3d26a7728bfe537ea483efc9
change-id: 20250618-sm6350-bringup-08e24e0f8bb2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

