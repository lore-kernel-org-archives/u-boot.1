Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B633C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71601801CF;
	Mon, 20 Jan 2025 14:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/DKDaZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839E8805C5; Mon, 20 Jan 2025 14:44:30 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03E180077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21680814d42so73053855ad.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737380666; x=1737985466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KBRkbAjc15CXZv+BHMe2iJ0h62Pf2XbrlcZ3H8adTxg=;
 b=V/DKDaZ/Zvud+yYLTXvidq3yajKs4Yl2ZksOTFt6vMrDX2TmX8YSDBXHlwUDKHlu5w
 WZzUjr0tLxJIXovpm9eMwgQjrc/+LuPCnT71fxetybM8DnYw/8dNg+0H+DWLdzOXXY4v
 MFjljXVXvxc55qs/HmwJ3zCx/nRRb0xVYUKZ9FbhuWefOCULjWGzDHpfHCulRZSNH5Vd
 uAtCijNQm0rJSMp/7MOJtITzPQiSR1pDeL/FF9IXcZbkteKFs4WcuI/fgZINVJ+hPbhA
 YGQbnKSjkrxKaI/Ehs+6Y+admRsiB6TVnF/Q0JR/3Gh9tFjID2ckWkE9s+Yvjd4mGxke
 u/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737380666; x=1737985466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KBRkbAjc15CXZv+BHMe2iJ0h62Pf2XbrlcZ3H8adTxg=;
 b=ZVle7NE4N1ivQDmjdZQFgB8w9/XLKbi4nXb/jtQJg7I3vYGvNYdQ0T0LbOHx2e5XIG
 EZjTO0nNlPEGOiH4+iWaNPAQJRk6uDB4KAiib8WW9N5WKTg+qVTY9AZfW/+4hCU3b2nt
 JcUN64MgfRIsOkTFvGHu58KrqMuUQQ5X98R3p8eW0sR9xUa7KIQ/v2siv3hZfCXlrME0
 9b5PwqoN/ach2rgHHtDjWtmLaCTZwDkK0tpJwAKAmMc27X6THos9Et9hwZL8asJUEM6H
 tDPp+JG0odnduVM9sVouE67Zbco3nBTReLKjOlQz4jCLAZl3o6JjXZA38LXJBZWmYgWB
 agJQ==
X-Gm-Message-State: AOJu0YwzxmwySKFXDhjyrqpPQuHh7qSeNqCIVdVy+zg9cJBxkFwBS72J
 t0nvrmO0DoPjs2SaPbFsBYG672AhVvEJoGI1YtsrUiJM3a6e7yrZ
X-Gm-Gg: ASbGncsljDykimh5Z1pPc2B+DjkbvAyMY9k8BAkAxWWt3XmIvWrC+wOz4VSvB2mU/s5
 Mp/BhmOBrJEu1+MZA2lpa9C8Sr7xAyy/krngPT+RFwokSJsVLkAgHKfA7/R6vUmX+t7zycrF/sW
 bsY44VX6EbWiR6PyomMeKUurvsd6eOLXlk7goDQ6SSq+Xh2nJmJW25Osy+hBfri98/MOk543eKB
 WEMnTQ2CfU6Zkc1WJaPjO4o6ppfhy5WY4GBUaEGTGJ8paKFw/cx3EWHeg70Ds8W3MAz+aJAH+po
 sXjClD/j
X-Google-Smtp-Source: AGHT+IExCiiFlOKgAR6dcru78X5lNHQYsyyi63pqprBzs7mztJXrkh0nQHn3aRhJeJPDSV6pG7MiEw==
X-Received: by 2002:a05:6a00:c92:b0:726:41e:b310 with SMTP id
 d2e1a72fcca58-72daf99edf9mr19327230b3a.12.1737380665780; 
 Mon, 20 Jan 2025 05:44:25 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:927a:619b:e0c9:fec6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bdf0b7579sm6806933a12.73.2025.01.20.05.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 05:44:25 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250120
Date: Mon, 20 Jan 2025 10:44:21 -0300
Message-Id: <20250120134421.3380217-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 639cd409987acf173eaffebe7876968b42fd7c32:

  Merge patch series "add the support of sha256_hmac and sha256_hkdf" (2025-01-18 17:13:01 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250120

for you to fetch changes up to e38a490810af76169f7cf1d298966ea9ba3c005b:

  phycore-imx8mp: Enable CAAM in spl (2025-01-20 08:41:38 -0300)

u-boot-imx-master-20250120
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/24263

- Add i.MX95 EMDIO support
- Guard binman nodes with CONFIG_OPTEE on imx8m
- Enable CAAM in phycore-imx8mp SPL.
- Fix Fix NULL dereference in imx_pinctrl_probe().
----------------------------------------------------------------
Alice Guo (2):
      net: fsl_enetc: add i.MX95 EMDIO support
      net: fsl_enetc: Update enetc driver to support i.MX95

Fabio Estevam (1):
      imx8m: Guard binman nodes with CONFIG_OPTEE

Jesse Taube (1):
      pinctrl: imx: Fix NULL dereference in imx_pinctrl_probe()

Leonard Anderweit (1):
      phycore-imx8mp: Enable CAAM in spl

Marek Vasut (11):
      net: fsl_enetc: Introduce enetc_is_ls1028a()
      net: fsl_enetc: Remove ifdef around enetc_set_ierb_primary_mac()
      net: fsl_enetc: Fold DT MAC address update into enetc_set_ierb_primary_mac()
      net: fsl_enetc: Pass udevice pointer into enetc_enable_si_port()
      net: fsl_enetc: Rename the driver and related structures
      net: fsl_enetc: Introduce enetc_dev_id()
      net: fsl_enetc: Inline register accessors
      net: fsl_enetc: Split register accessors
      net: fsl_enetc: Introduce driver data
      net: fsl_enetc: Pass udevice pointer to accessors
      net: fsl_enetc: Add initial netc-blk-ctrl driver support

 arch/arm/dts/imx8mm-u-boot.dtsi       |   6 +
 arch/arm/dts/imx8mn-u-boot.dtsi       |   6 +
 arch/arm/dts/imx8mp-u-boot.dtsi       |   6 +
 arch/arm/dts/imx8mq-u-boot.dtsi       |   6 +
 board/phytec/phycore_imx8mp/spl.c     |   2 +
 configs/phycore-imx8mp_defconfig      |   2 -
 drivers/net/Kconfig                   |  14 +
 drivers/net/Makefile                  |   1 +
 drivers/net/fsl_enetc.c               | 487 +++++++++++++++++++++++++++++-----
 drivers/net/fsl_enetc.h               |  88 +++---
 drivers/net/fsl_enetc_mdio.c          |  20 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 346 ++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx.c     |   4 +-
 13 files changed, 876 insertions(+), 112 deletions(-)
 create mode 100644 drivers/net/fsl_enetc_netc_blk_ctrl.c
