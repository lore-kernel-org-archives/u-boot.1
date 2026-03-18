Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFC3103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F268C83F6D;
	Wed, 18 Mar 2026 15:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="suhC4mnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722D684213; Wed, 18 Mar 2026 13:46:58 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2646A84142
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b980b35534eso22615766b.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838015; x=1774442815; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iZtAzRx2igqlQKgI/5iG4feZ8AQMSBPVE+NLwwlSrvA=;
 b=suhC4mnZSuUqC+QqPqSaYc1cE5m0F0QHdYp6Kn5Nsrg5R7sf10Hu3n9Vk8jTr/6SIA
 K9yXfbxcM3X/mLYt1bXmqGGQpAc6wJQm3/fPOzaDCGygyYCB/ZSIbYor3ypjTxJq/cqs
 KSWWQapVCZp9AUAc7z9pUerwWl+ihH29nooqTIr2PCyte1jnynkvpHsp/i7T0qIT4Dhh
 tdSyc3zKLSD4rRnnurDmG8fiZRq1NsU21LrApgwAVvTIo2ur6h6vQcb63nunpIvIxuYR
 sJdK9YRP76CQMKN4cVR82rlgZWhyav8F32mWDzUOdLnOtiLmWHrlLXGuDIkciMHr9OM2
 f2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838015; x=1774442815;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZtAzRx2igqlQKgI/5iG4feZ8AQMSBPVE+NLwwlSrvA=;
 b=gTZpLmiPAHH5FEW/YFDYeRgOukb851k0pDs9LmpqWPc9S3iz5ruHMLc2UmQwJ4YHQT
 9iLR1xeP6mw7ndt2oCsNcHqgojDj/o9S/4PmnCgId9yuYl3h32BEtQYXBXFWlBpe6XvA
 tgO4GPQJNF0+iCBqZcE5weCNi+OmerVXNz8LU4Y8e/RuA03Tn1WlsLeM/IwDb22Al9+q
 HHq4N2oX7o6W+7gC0rhemxkzI1KwJ3Qz58DGpbbz5oll+x5d7t2QZ9T+Cb3XfS9wHY2s
 jysUlh3w3X8TjBroPjYzaY6Adj6fD61IJcdAciXyWG0AecW3A6EhwANr9JrpD/TTFjtx
 x/Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX24ILEmasTIO1y8574Xv8gU830Ju4pP/rZp7pbGj1B67sS3apU6+VTwBrwBhJ0vcHyVhmGQf8=@lists.denx.de
X-Gm-Message-State: AOJu0YzXIdD1aaeVQ7SrHb0nlixH/93KC3xNKt5mduVXDGSds9yJ17G/
 WsaZ9Q85nHNeDP/RhjTmoTTwclBvTzTwZSgX6jgGk3rq64DbsdQz0cH24n+zXr9VGYs=
X-Gm-Gg: ATEYQzx3Uf4rAsllpWBzyb9ncaLY7MXJ5f4ku8wAYaeZQk89GbrFA89EqTJ94qn3fSK
 +oaE/QGI+9Jz+aNuqpXyF2NXxf2RL/Mnhhkgbt2CjQEmJHZBA+TTONK/IInbSa4lOUXlo3FbSBW
 an0l1hcYwrS0MiSM/Tgq/ChUcNMTXS1KQuTiu/a1zE1SPpKFDlGatwMastl1dZQ2rSzng0jZGdD
 kR2O6RWrNChlBSBn8IXKYC7ILF/PPbmVEWkRL08zCRK/Y8wyMm8HJutISrME4UTmKibF92wA3qE
 ghA7SlWDgGlnoiWZlaTr3QJ5lqw+CydEd014iq1XUOMfSNFna1IFIcx1h6gR/4Qz8d3RLYVG9dU
 O+cp3LPs6+azvfRKlWofbQQAF2ZNT4uCErun40bQAi/Uv32sAVWBjFfEBw0iymo6DpOR9fYWypW
 2p1GA5yxXcaPykfHlgJVNbbmtaSyn06TtU3cA0N9UW4/vIMWPsq49LlFozxyLblJ8O6NSifrWXV
 4ks0g==
X-Received: by 2002:a17:907:3d03:b0:b94:231f:26ca with SMTP id
 a640c23a62f3a-b97d6d99d0fmr491603366b.20.1773838015438; 
 Wed, 18 Mar 2026 05:46:55 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:46:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/7] Qualcomm Milos SoC bringup
Date: Wed, 18 Mar 2026 13:46:26 +0100
Message-Id: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6CMBBFr0JmbUmLFZCV9zAsaJnCJNJiC0RDu
 LsF1i7fz/z3Z4WAnjBAlazgcaFAzkbILgnovrEdMmojQ8aznF+FYAO9XGDKk+3mkWFbKm7aoim
 lhtgZPRr6HL5nfbLH9xy10xmCagIy7YaBpipZdm3KJfNawn7fU5ic/x7vLOIo/FleBOMM1Z3ft
 MwLI/jDNOTH3llMox7qbdt+VHmVGt4AAAA=
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=2097;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=8BfBoFY2vkPbZ4+Qz41Eis0lzA/qQYpBfGmn2M4Ft3c=;
 b=vMsDkdQvFurv4zl37cdk9hvxpmIrNqKRDC27DyJzoVhNVrWiAyP6x2uA/RGqDs63LHu/bmp9k
 CzMzwVcaDQcC5BJ/XEaEmuYHtiBr6PvQWs99K/4LkMy0RNEFp+Aa4D8
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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
will contain that fully.

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
Changes in v2:
- Drop irrelevant BCRs and GDSCs from clock driver
- Extend rpmh-regulator and UFS commit messages with Linux tag where
  it's imported from
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com

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
 drivers/clk/qcom/Kconfig                      |   8 ++
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-milos.c                | 196 ++++++++++++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |  88 ++++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   8 ++
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c          | 103 ++++++++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  33 +++++
 11 files changed, 445 insertions(+)
---
base-commit: 79126f765ff9fa390ced0c1f7a94b30c6c36f09a
change-id: 20260311-milos-bringup-ed8b0fd7a84c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

