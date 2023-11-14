Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A13C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD17087468;
	Tue, 14 Nov 2023 14:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WvT1uk2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7981887468; Tue, 14 Nov 2023 14:48:52 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402448716E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso3290043f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699969730; x=1700574530; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QI4Yl5yFYRJhISda5Im7ZHy7chvE4u6cSYQ764AsK8k=;
 b=WvT1uk2EKrYoeUIIrFNANlcYWdrOkTwlWm8st3gwe6sMPEcks/LMwmPuKR8PBbn/qK
 4yyNLCwza4y7O49MAfISC8qL3E+KfP/2FpvdVxRCUGZuBKTON62xWdjLMfx+z3M5B13R
 hVJwGO31EAHK2V+kyC0Ptv1bP1LR/g8ZnijpeY/0dRsTSndPPRGxcFJ1bQiD1QQ7ZSm6
 VuwQtuwqNzb2lFHUElAyl873Qg66RGcJIn7Go1If3NBAA1xvMEb3x2WE367uk7XMnB/o
 PFA/bgmAPqobEGKX+Aa8ZK3rYKRjh07eQRMMVwpG4wuDIjGfaeY+Fn4B9oe+rSt/iVpZ
 J9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969730; x=1700574530;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QI4Yl5yFYRJhISda5Im7ZHy7chvE4u6cSYQ764AsK8k=;
 b=RTCoTu8yl85ReXumIzRIFrsTKm/QAECprrZwIrr4ipWsz3u1MSqfFYBmAX8uPn27He
 UEjHYb3pLITWju5s4DZmYSaDpTj7U+Xy3M9LgS6igvU56/mFo9X/wmAWORO7y9d57gnY
 BGsBvP01B3sv47xfIJEvAHLatd9+um4sDwd19NCsExVGbFfHotGXnHbaP1efzqqOz+zh
 MzKnJ2w1LxIcO2BUd24LHiPopybotj0JeYBvYH6Yn287ER1+Sf4jKl6nFkoZRrgvlc/3
 AaiUablzGGpuHN5efOJUGQtnGzn+CKkiEzXLTpSrBAi7fOLCV+GJsGPIHqDsLPHhKf/N
 5qaA==
X-Gm-Message-State: AOJu0YwfhN5Wi8wcfts6P7j1DrFmkE/83TnI3lH29owODj+d6XHVSb2T
 SqT2ytp2QJGnj6olcocelsAaCQ==
X-Google-Smtp-Source: AGHT+IFmRjY62wrFaEAFsmPGrgM0+XXRL/1OhsLwL1k1sdferJxRgL4xfgx3hRD4RcY8SJoAYDmAeA==
X-Received: by 2002:a05:6000:2ad:b0:331:41bf:c4a with SMTP id
 l13-20020a05600002ad00b0033141bf0c4amr7005989wry.18.1699969729621; 
 Tue, 14 Nov 2023 05:48:49 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003313426f136sm7804220wrs.39.2023.11.14.05.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:48:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/5] Qualcomm PMIC fixes
Date: Tue, 14 Nov 2023 13:48:46 +0000
Message-Id: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL56U2UC/33NwQrCMAyA4VcZPRtp02KnJ99DPHRttwV0ne0oy
 ti72+2kIJ7CH8iXmSUfySd2qmYWfaZEYSghdxWzvRk6D+RKM+QoheAHaBQ8bLiDm6CM0UzgjdS
 ac9c6lKzcjdG39NzMy7V0T2kK8bW9yGLd/tOyAA7c2qbRtRKoxPlGg4lhH2LHVi7jJ1H/IrAQW
 kiU0mo8qvqLWJblDePLZvz2AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dj0Us/ecWZ3+8n7Okc+KRprKBcs67cQq2PQ+dWHErf0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgqgM3D19uF/7/VeD4fKtDgqddUiJe3Z5xOltPb/9Wx
 5bux3pRHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiCZsY/idxMccf/s00yX55
 l7tZpPOBBuur+rdjNcy3GSpYOtX19zD8T5Y4tiPq/cpTlRXBAb///Lzz5Xn0v3SRzC/ZPq07Zir
 umw4A
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
 arch/arm/dts/qcs404-evb.dts                      |   2 +-
 arch/arm/dts/sdm845.dtsi                         |  28 ++--
 arch/arm/dts/starqltechn-uboot.dtsi              |  10 --
 arch/arm/dts/starqltechn.dts                     |  20 +--
 arch/arm/mach-snapdragon/Kconfig                 |   3 +
 arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
 board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
 board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
 drivers/button/Kconfig                           |   9 ++
 drivers/button/Makefile                          |   1 +
 drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
 drivers/gpio/Kconfig                             |   3 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 146 +++++---------------
 drivers/power/pmic/pmic_qcom.c                   |  13 +-
 drivers/spmi/spmi-msm.c                          |  46 +++----
 22 files changed, 337 insertions(+), 304 deletions(-)
---
base-commit: d1efa48e205960b15656eb0c13227110895f1cc9

// Caleb (they/them)

