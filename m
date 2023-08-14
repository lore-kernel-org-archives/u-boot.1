Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A9C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1BE86970;
	Mon, 14 Aug 2023 23:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cq9llbvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C9A8697B; Mon, 14 Aug 2023 23:55:12 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EB984788
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc6535027aso41255105ad.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050108; x=1692654908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EAg/jcZBofpli5PaQmLkP2VLLTeUAljDlpFayjcDMNY=;
 b=Cq9llbvX/spLP+omlmtL36cOVFYfzsR1xaUWGVVk+ft/gH6rBQd6IZzRDdJKzoQLSG
 XGdutLvzvRvvBvV+Vn889r3KDZJjhmlRllQ13AD1r3myfp7MbXmrvsCMlO2FBcRIVBnM
 i4veWmlOvX9Z7yubzAgbWcwaorcIN2FdiqmXVfg3QR/GXLp5uJv49ax2UtHO1MD1DgYI
 gdk+jRiuO/o9TeRPRMtj0ylU4FT1XKZaqPwCGL9e99hFQRuyBaPdydfCdJUgTanCktg4
 mXSP1eBsDFAp00w3mJ4Bj36dpetfNJgShBVhGjtWmXkpBDi1ZEPU6omz+RXNx2EJRt2h
 GKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050108; x=1692654908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EAg/jcZBofpli5PaQmLkP2VLLTeUAljDlpFayjcDMNY=;
 b=lPBOblhUCnkLpIdahn5M0ugve8mpvcIlZxzjnLe4JYeOnkwq6+4NJDRecVuAJtW8fz
 C7h8XWoJwrAom3eFA5mcfP3WzNxhjesLc5iGz2RVlID1QMfieMVDg34JlRzG0WVlxyDt
 DPwCvSb7b9+V0bkB6UCW/B4OzcWe+hSZ7jh0OKDorH9/hFPSSN5E//gZiaWK3wxTb40l
 ZnJAc/RwuKqsqyZALoVhSDYB4v8GdSp/WdjQtJ4LE4qzPYTHn0QuEii5MyPtojpqwA1O
 I3qwdEM8aHBUpWvY2TquhuC8NJIbFhVfXPdP8c0a3ad/SourvGdm28tKFpgiA/Khk4/A
 wNQA==
X-Gm-Message-State: AOJu0Yy8oFtM4gKbHSDsSso69vFNvl07WBY29j0qLcbRU5oJCCtEfpED
 EvmCmpYQHTG+s1SC3HDkIq+wAyJZU37DI9z8r3o=
X-Google-Smtp-Source: AGHT+IFaoGDPiV+2CTsRdQj+IdQTgDmTjRKpQOMlfCzNSfjNXH6m1V5+eH12uHUj17jHucjeMBwF9A==
X-Received: by 2002:a17:902:7795:b0:1bb:cf58:531d with SMTP id
 o21-20020a170902779500b001bbcf58531dmr11422813pll.10.1692050108318; 
 Mon, 14 Aug 2023 14:55:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:07 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 00/17] Enable UFS on DragonBoard845c
Date: Tue, 15 Aug 2023 03:24:40 +0530
Message-Id: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

This patchset enables the UFS controller on DragonBoard845c
board which houses Qualcomm SDM845 Snapdragon SoC.

In addition to enabling the UFS HC and UFS QMP PHY found
on this SoC this patchset also contains:
 * Patches to add 'reset' controller support for SDM845 SoC.
 * Minor UFS core framework fixes.
 * Patches to sync u-boot UFS driver flow with Linux UFS driver.
 * Patches which enable RESET, UFS and SCSI config options for
   DragonBoard845c.

Also since the current UFS maintainer's email bounces, promote
myself as the new UFS maintainer to help address this work-area ->
review, test and fix UFS issues in u-boot framework. 

Bhupesh Sharma (17):
  reset: qcom: Add support for SDM845 SoC reset table
  phy: qcom: Import QMP phy related header files from Linux
  dt-bindings: clock: Import SM6115 and SM8250 related clock header
    files from Linux
  phy: qcom: Add QMP UFS PHY driver
  ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
  ufs: Clear UECPA once due to LINERESET has happened during
    LINK_STARTUP
  ufs: Add support for probing UFS controllers newer than
    UFSHCI_VERSION_21
  ufs: Expose 'ufshcd_ops_dbg_register_dump' vops to allow dumping debug
    registers
  ufs: Sync possible UFS Quirks with Linux UFS driver
  ufs: Add missing memory barriers
  ufs: Fix debug message in 'ufs_start'
  ufs: Add Support for Qualcomm UFS HC driver
  arm: dts: qcom: sdm845: Add 'reset' node
  arm: dts: qcom: sdm845: Add UFS HC and PHY nodes
  configs/dragonboard845c_defconfig: Enable DM_RESET by default
  configs/dragonboard845c_defconfig: Enable UFS + SCSI related configs
  MAINTAINERS: Update UFS maintainer

 MAINTAINERS                                   |   2 +-
 arch/arm/dts/sdm845.dtsi                      |  68 ++
 configs/dragonboard845c_defconfig             |  11 +
 drivers/phy/qcom/Kconfig                      |   6 +
 drivers/phy/qcom/Makefile                     |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h    |  25 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h    |  21 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h    |  31 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h    |  32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h    |  31 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h        |  43 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h        | 145 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h        | 135 +++
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v3.h    | 111 ++
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v4.h    | 123 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h   | 140 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h   |  66 ++
 .../qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h   |  30 +
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h   |  68 ++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h   | 233 ++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h  | 205 ++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           | 996 ++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h               | 115 ++
 drivers/reset/reset-qcom.c                    |  33 +
 drivers/ufs/Kconfig                           |   7 +
 drivers/ufs/Makefile                          |   1 +
 drivers/ufs/qcom-ufshcd.c                     | 880 ++++++++++++++++
 drivers/ufs/ufs-qcom.h                        | 275 +++++
 drivers/ufs/ufs.c                             |  93 +-
 drivers/ufs/ufs.h                             | 156 ++-
 include/dt-bindings/clock/qcom,gcc-sm6115.h   | 201 ++++
 include/dt-bindings/clock/qcom,gcc-sm8250.h   | 271 +++++
 32 files changed, 4539 insertions(+), 16 deletions(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-ufs.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp.h
 create mode 100644 drivers/ufs/qcom-ufshcd.c
 create mode 100644 drivers/ufs/ufs-qcom.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm6115.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8250.h

-- 
2.38.1

