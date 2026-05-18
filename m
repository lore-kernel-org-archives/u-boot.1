Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25227CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 15:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC64B83FEE;
	Mon, 18 May 2026 17:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZK63/FAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CAC84664; Mon, 18 May 2026 17:55:08 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C5A83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 17:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so25440785e9.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119703; x=1779724503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eKwwOeREfUOl8PhO4+FC0zekU8n20oKaiFUSgJfqa+Q=;
 b=ZK63/FAfvlM08PerFrHMs5hSy6sZWTK5sWwNiK8WgtaaOILL1oqs5mc3O4ekfujMny
 r/ogIsaIHIVNIcifLPQBZKX6fTdLSvMH+2LmBg3vCE4Ejhij70HzDtqZwpJaRiFf9pCi
 1TDy55FYGgZcxNFvuzUSMI+ASy7yokH+sOKLZ9zR6i2vjRlPOLYOqe6BGhQgLsgupssh
 z/w5q1AuvUoqyR+5ZekvOI87EmbZ68wCmie7/68kkk3an9cq4eZP0o1QxgIQoZ9iTLBX
 IJgR0ck+AWs7shwT8puUGKVPYUdwL0CKmscZLUQ9QbD3nwJ1myjHyio736clZqoBZ5J5
 hPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119703; x=1779724503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKwwOeREfUOl8PhO4+FC0zekU8n20oKaiFUSgJfqa+Q=;
 b=pYK8xM/OcUX7AJ6gvl5aDL6TfLVPjVyLvaMYHMab0L0oerh+GNZAC+tSgDgj5Lu+9U
 LCoOuVbfH9TFGrRIESKeHmhtpMYPsilGDHKKknD9obRPG1L6XdSH8Qk+luHle4Xkb20U
 ixYlsHzk/l14gS4O8FZ+YX4K7/PRFNnc+S80a0kNKWl7NNMVtjNurNqme4r9vNrrgxoN
 Z34Fd3bIHXJ9lgHQQTUqnVaLaN+ZGtbXVOsfjWQKK2YgKILBMWcd2gQp12zStACANXVY
 tdfM2ZM6g1AUM2GreSa54ktv1QS34ksHIuVJh2kINlEX8iMNhps03jzmr7808kfxk6ds
 otIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EgDCvR3CS7hlLBKKSGx/NBbAELpAM2DcF0evMwt2gF/mgK+ywVPhNvA2SzfqUxjDyDX9GcVs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf7hMsmxnMOkt1fO3cL0iy+w9Ppx2yZCfsOdqwnwaG3OTRTHS3
 MX0wj5brY1C7eo+zV9jQYo+70Ius3GvBW5vv8PPAdmvmXkEtfAMZn7m/Xzf18vcBkeI=
X-Gm-Gg: Acq92OEha1LFEAQzMRJW7r2/DgdK5JutaQqvEMsmyCTJtWoJKyLgw7N71F1s3WVrRmS
 ltG8ZweIC8wmYdh7HTV57AEzh8YbFtABEZxVs/e+6MxBvEq6vS/7u09xG/8V4yhBJRGXzycf9HV
 6CZA7moginbxPV0Wdi14BGd/VrirBIhgOKxfILBOxgs88GEK1C9tNaHHScqFgXQ79nzioojJGpG
 FhuhkjYh6kMrTjiUawOcxdVNdXUSb8FLhfxBRxWtbsLWdtltixX9GAIqrmZ2qRwPqOp1qiNhNEm
 Xs2JNV0lK4zO7LIOalg4v08rIlzH9f5KZasVXGM2FmMFyzTUWkHyJ8Y/jWo6gCRL4jW92+PwTlk
 4hJQTQcLLcDpA/T+gvNfrPYcvY3KMeRDSMy9dJqqDTZb3dbdARJOccU3+8nf4l/wMXjV755HsLB
 HTutnMOojaQV55YPQNPZDzWJx0/2hHKCLnQBC5kp8dwfxRukFJlT03j93sSzvoKpxRDc+gIg8u1
 spOjiHaWMbe0qY=
X-Received: by 2002:a05:600c:6290:b0:48f:f199:7a33 with SMTP id
 5b1f17b1804b1-48ff1997b3emr206850205e9.28.1779119703574; 
 Mon, 18 May 2026 08:55:03 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab26ed9sm123610165e9.2.2026.05.18.08.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 08:55:02 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Timple Raj M <quic_timple@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-18May2026
Date: Mon, 18 May 2026 17:52:18 +0200
Message-ID: <20260518155457.270420-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Here's the initial next PR for qcom.

* SM6125 gains initial support
* The qcom clock drivers get better support for configuring UFS clocks
* ufetch gets some aesthetic improvements
* A minor bug in the qcm2290 clock driver is fixed
* A few qcom drivers get static/constified
* the GENI serial driver has the RX watermark register properly set

Thanks!

The following changes since commit a6f6947e43fba91de3ec5d0390eee7eb1a6a80f7:

  Merge tag 'mmc-next-2026-05-15' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2026-05-15 08:18:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-18May2026

for you to fetch changes up to 0d131b3b06023c3fe0d1a98588e17a7894e318f0:

  board/qualcomm: qcom-phone: Add poweroff command (2026-05-18 11:06:53 +0200)

----------------------------------------------------------------
Aswin Murugan (1):
      dts: lemans-evk-u-boot: add override dtsi

Balaji Selvanathan (7):
      clk: stub: Sort compatible strings alphabetically
      clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P
      clk: qcom: sa8775p: Add UFS clock support
      clk: qcom: qcs615: Add UFS clock support
      clk: qcom: sc7280: Add UFS clock support
      drivers: ufs: qcom: Initialize and enable clocks before hardware access
      ufs: qcom: Remove redundant POST_CHANGE clock setup call

Biswapriyo Nath (6):
      clk/qcom: Add SM6125 clock driver
      qcom_defconfig: Enable SM6125 clock driver
      drivers: pinctrl: Add Qualcomm SM6125 TLMM driver
      phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
      clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
      board/qualcomm: qcom-phone: Add poweroff command

Marek Vasut (3):
      gpio: qcom_pmic: Staticize and constify driver ops
      gpio: qcom: Staticize and constify driver ops
      pci: pcie_dw_qcom: Staticize and constify driver ops

Quentin Schulz (2):
      cmd: ufetch: show net feature when NET_LWIP is selected
      cmd: ufetch: only show comma separator if there was a previous feature

Timple Raj M (1):
      serial: msm-geni: configure RX watermark register

 arch/arm/dts/lemans-evk-u-boot.dtsi   |  19 +++
 board/qualcomm/qcom-phone.env         |   1 +
 cmd/ufetch.c                          |  29 ++--
 configs/qcom_defconfig                |   2 +
 drivers/clk/clk-stub.c                |   6 +-
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-qcm2290.c      |   2 +-
 drivers/clk/qcom/clock-qcs615.c       |  63 +++++++-
 drivers/clk/qcom/clock-sa8775p.c      |  63 ++++++++
 drivers/clk/qcom/clock-sc7280.c       |  52 +++++++
 drivers/clk/qcom/clock-sm6125.c       | 260 ++++++++++++++++++++++++++++++++++
 drivers/gpio/qcom_pmic_gpio.c         |   2 +-
 drivers/gpio/qcom_spmi_gpio.c         |   2 +-
 drivers/pci/pcie_dw_qcom.c            |   2 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   2 +
 drivers/pinctrl/qcom/Kconfig          |   8 ++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6125.c | 147 +++++++++++++++++++
 drivers/serial/serial_msm_geni.c      |   4 +
 drivers/ufs/ufs-qcom.c                |  54 ++++---
 21 files changed, 694 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/dts/lemans-evk-u-boot.dtsi
 create mode 100644 drivers/clk/qcom/clock-sm6125.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm6125.c
