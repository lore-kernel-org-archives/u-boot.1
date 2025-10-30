Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC908CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 14:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E84583887;
	Thu, 30 Oct 2025 15:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bU1vqElN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE581838BF; Thu, 30 Oct 2025 15:02:57 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16ECD8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 15:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c69476dd8cso124531a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761832974; x=1762437774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:dkim-signature:resent-to:resent-message-id:resent-date
 :resent-from:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cW7QJCXyLq2431Wk8kMguwBjv9st6RHus/vGRsxC/oA=;
 b=KwM7uD/hdQX/qCDegq5OS1OdpA8IUaHWCyyhmbSgG6yCsN9e9+aLwyHvJfnRhNo6uK
 SJpm9Hy+8q7wM+JSYBwJuoXxQRxHEyppgNhTl4eXcRWtEW22gG9ontop0A5Vfq9gZco4
 ZGClDW4GFnBPVgFVQL0AKplUp4TnCZoIvLD91aU4GqUKlpdbk/2zGX2pFiEt77dY69/K
 3JcgT1ZHiX7wGiDTpptxTMSWr9iiGBOF05r8IT+iyN0dByMhSt/V3AJvGEUXRuWuX3Mh
 x8VgGSCFSskqYQh8ha//2sWGw4P7NumQtQGD4lUlFf7oKrsX7gMxYulYNCSoPu1fvahJ
 uOPQ==
X-Forwarded-Encrypted: i=2;
 AJvYcCUR+S29ITDkhD2M3Z6c50o+zrqeVivWGfV6Z7rsXQt4rJe8WHJKLqmiCQVxkdlPLNp2zv1DVsM=@lists.denx.de
X-Gm-Message-State: AOJu0YxFaktKtyLeLS0temlQq+h7OiCY0fRRdHr5BhzCR2M1L/uFxTQY
 1V3LzvysPGm+T9V0cEfz9ITodexp/Gnh/9sdnSQP1P1BB7GourSV3lvXsNDa+im4WEHQ4KIL/Z8
 cDxsIzGJplQ==
X-Gm-Gg: ASbGncu/47JZajZcVbkVzmfcN6UvkAcS+Zj0Zc2zL348T2OVZIjbFb+AHg/vQdLI8eJ
 qrvS//uRTkJLfbI0UTdaZkGcPQmETOwTPQRdvqH2DKHpBIKlyjm17JqYJ+VuGtkt6f4MuANORrS
 r/l6Ck2dvAJi/8epMNQk2IvnCugASsaZDTWQtzTqWmaXy1dwcqIbKHSL1omgslypnovHEybUOxg
 Ms0/AqS+fee7lqP/5i3iS6TwqIZpio5jWZD4+KJ8JjQttcHKcpGe+Mt/EvbtNDbIYi24UsqkKPz
 RBusTjBaSSvL1Ndj92pCpdh2A/crDPEd5csN2SUI51DLlWnj7GFcuz5o33vNCwMeb18X48jlI5T
 bfVXFmc9LhmfkIerEZrsx2pbv37TlvKPvYUW5tuQswdnv88DnIqF/NftPkKFAU79gZxGqlDw/sw
 BYBdsbKyJodT82JvOYo1pbnBZNNF8KH4xqXCTqUJ4=
X-Google-Smtp-Source: AGHT+IGZghHVAa0mjli5GvLapeBYa0ADqo/NDPZetEaVj8EbS5pNhN4KBP5CL2O2UJHemYcEY7BM0w==
X-Received: by 2002:a05:6830:4390:b0:745:2585:9c84 with SMTP id
 46e09a7af769-7c68304db4bmr3953660a34.9.1761832973722; 
 Thu, 30 Oct 2025 07:02:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302203d2sm5126888a34.32.2025.10.30.07.02.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 07:02:53 -0700 (PDT)
From: Casey Connolly <trini@konsulko.com>
X-Google-Original-From: Casey Connolly <casey.connolly@linaro.org>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Thu, 30 Oct 2025 08:02:51 -0600
Resent-Message-ID: <20251030140251.GU6688@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:32b:b0:ba:8f80:e1f6 with SMTP id 43csp951793dld;
 Thu, 30 Oct 2025 05:15:48 -0700 (PDT)
X-Received: by 2002:a17:907:a42:b0:b3e:fc83:fa83 with SMTP id
 a640c23a62f3a-b70521bce1bmr340062066b.26.1761826548311; 
 Thu, 30 Oct 2025 05:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1761826548; cv=none;
 d=google.com; s=arc-20240605;
 b=I3EuL40agjf7+WBl8weGtPXSSFNE5anaA7u67TZ5NUMsRYPzjM2DwbTrLxFjXax4zO
 2iVQxfEsOKSf8f8yCaDYdqnDP4+4m720Y9TxBvf6OMjsDr6D+tQ+6UBeenOB9Hm4sncf
 BNbHA/faHxQ5pPKgFnbcSrzlq/PAgHH9C46F2DkoBdVUt8fMmJUrfbRlgJ0ckikTAxvg
 AG9NUNMneaV4WYg3CRsZEWJIZLYOxLYXu4Me1G6pdLjEG54iRB/6s9MmpKxD32rRHTUe
 kXzwfOXMab2VXgHsHtBTJerWHoG7xjg1fD7/8G0j3zOScjelJwgQsciXKqiHGFWuFUYD
 /4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature;
 bh=cW7QJCXyLq2431Wk8kMguwBjv9st6RHus/vGRsxC/oA=;
 fh=zna9hY4FOIhPgu3NrqMxvq6Nz930DL0qdeQV4ySEF4w=;
 b=LaZ5Z2lepi6y61JyFL7NOMorr4cd7qo4xATBpyOpXWK4H3uI4Sw6RjP3FRG2I5p/lU
 GjVYAIHSNaJrN+asTngS105CphENcyEkFIRYUYuuvH275wnOIFTYLK8PMcxMKYKya5io
 ZQXVixkihN1cWCSBNIC0Wl3KIgiAD5DRwynU1Nb4bNkWdl7mEdggkzQYgkFJoareqtU+
 kTPVYN7i1F8vpL5tew12Z5vduy3UdJ3ofj1Zy/DzS16fmUYJiexag54va9P09iR/DUgG
 rV8a0Y7N5mwa2oulD7W89IWQ09ZsuwRX72ghshiLMsONBN8ctlM+xUAzh23UHysZYTLu
 Emfw==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@linaro.org header.s=google header.b=bU1vqElN;
 spf=pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) smtp.mailfrom=casey.connolly@linaro.org; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org;
 dara=neutral header.i=@konsulko.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com.
 [209.85.220.41]) by mx.google.com with SMTPS id
 a640c23a62f3a-b7056c2cef0sor79028466b.5.2025.10.30.05.15.47
 for <trini@konsulko.com> (Google Transport Security);
 Thu, 30 Oct 2025 05:15:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) client-ip=209.85.220.41; 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826547; x=1762431347; darn=konsulko.com;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cW7QJCXyLq2431Wk8kMguwBjv9st6RHus/vGRsxC/oA=;
 b=bU1vqElNDulb5zwbtL3j4Lt/NydVcPO6on0ntn+WyS7Ltm72X+bZntY9/4g1aTBxSc
 yMdySaVZFFdsJEhmt3RZqIz+M+haMVzDJ8bd8BkqXCrNIYa1tI9uQfYMbC7sv8qi501O
 FdslGuS9deeBx7xEuXKPX2bWFrHT/EjnZHbT4Ipj33j5gWSmWmrSLacfXMG/ofy66roJ
 CTmtLqjSzO2xsKxcACr3oD9DNUYSFE49UA7KzehS/HlIyZtKRNzZMurQkz//y0Sj27/z
 Ee8UtrbonVLB94WtAoU/gAIZU3+hBJ5WB8jGpfyfs+K3eCOiCyxSAAN47lB/NJmlk51u
 9hlA==
X-Received: by 2002:a17:907:3f26:b0:b3f:331a:a982 with SMTP id
 a640c23a62f3a-b7051f630e8mr353748866b.6.1761826547158; 
 Thu, 30 Oct 2025 05:15:47 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f97f7sm1693460666b.51.2025.10.30.05.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:15:45 -0700 (PDT)
To: Tom Rini <trini@konsulko.com>
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 George Chan <gchan9527@gmail.com>, Jens Reidel <adrian@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io
Subject: [PULL] Please pull qcom-for-2026.01-rc2
Date: Thu, 30 Oct 2025 13:08:32 +0100
Message-ID: <20251030121510.4105280-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

A variety of Qualcomm features/fixes for this cycle, notably with a few
new platforms gaining support:

* Initial support for SDM670 (similar to SDM845), SM6350, and SM7150
  platforms is added
* USB and UART issues on MSM8916 are addressed (improving stability/
  reliability)
* Firmware loading is implemented for the GENI serial engine, this is
  used on some platforms to load firmware for i2c/spi/uart to work

Some additional patches like binman support for building MBN files still
need some additional work.

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8ef6ac07b35e39a57501554680bbf452e818d3e3/pipelines?ref=qcom-main

Cc: u-boot-qcom@groups.io
---

The following changes since commit 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e:

  MAINTAINERS: update my email address (2025-10-28 14:37:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-for-2026.01-rc2

for you to fetch changes up to 8ef6ac07b35e39a57501554680bbf452e818d3e3:

  usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM (2025-10-29 12:27:34 +0100)

----------------------------------------------------------------
Abbarapu Venkatesh Yadav (1):
      qcom_defconfig: Enable meminfo command with mapping

Alexey Minnekhanov (1):
      qcom_defconfig: Enable pinctrl driver for SDM630/660

Casey Connolly (7):
      configs: qualcomm: use fragments for debug UART
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required
      clk/qcom: sc7280: add uart5 and uart7 clocks
      serial: msm-geni: implement firmware loading
      configs: qcom_*: enable QCOM_GENI where needed

Danila Tikhonov (4):
      clk/qcom: add driver for SM7150 GCC
      pinctrl: qcom: add SM7150 pinctrl driver
      phy: qcom-qmp-ufs: Import SM7150 tables from Linux
      configs: qcom_defconfig: Enable SM7150 GCC and Pinctrl

David Wronek (5):
      clk/stub: add sdm670 rpmh clock
      clk/qcom: sdm845: add support for sdm670
      pinctrl: qcom: add sdm670 pinctrl driver
      qcom_defconfig: enable pinctrl for sdm670
      gpio: qcom_spmi: add pm660l

George Chan (2):
      iommu: qcom-smmu: Introduce sc7180 compatible string
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

Jens Reidel (2):
      gpio: qcom: qcom_spmi_gpio: add compatible for pm6150l
      clk/stub: add sc7180-rpmh clock

Luca Weiss (15):
      pinctrl: qcom: sc7280: Fix offset of UFS_RESET
      clk/qcom: sm8250: Remove unused defines
      serial: msm-geni: Update kconfig name for DEBUG_UART_MSM_GENI
      doc: board/qualcomm: Clean up debug options for QUP UART
      board/qualcomm: add debug config fragment for MSM8953
      clk/qcom: Add SM6350 clock driver
      clk/stub: add sm6350-rpmh clock
      drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
      iommu: qcom-smmu: Add qcom,sm6350-smmu-500 compatible
      phy: qcom: Add SM6350 to QMP UFS PHY driver
      regulator: qcom-rpmh-regulator: add support for pm6150l regulators
      gpio: qcom: Support GPIOs on PM6350 PMIC
      qcom_defconfig: Enable SM6350 clock and pinctrl drivers
      board/qualcomm: add debug config fragment for SM6350
      gpio: qcom: Support GPIOs on PM7325 PMIC

Paul Sajna (1):
      qcom_defconfig: enable watchdog command

Stephan Gerhold (12):
      board: dragonboard410c: Drop now unneeded bootph-all for console
      Revert "serial: serial_msm: Delay initialization to let pins stabilize"
      serial: msm: Cleanup register naming
      serial: msm: Reset after writing to DMEN
      serial: msm: Re-enable after resetting
      serial: msm: Use single character mode
      usb: host: ehci-msm: Fix pointer check
      usb: host: echi-msm: Drop ulpi definitions
      usb: host: ehci-msm: Disable clocks after all register accesses
      usb: host: ehci-msm: Use clk bulk helpers
      usb: host: ehci-msm: Drop redundant EHCI register writes
      usb: host: ehci-msm: Register ULPI PHY through NOP wrapper

Stephen Boyd (1):
      serial: msm-geni: Enable SE clk in probe

Tom Rini (1):
      phy: qcom: Rework Kconfig logic around MSM8916_USB_PHY

 arch/arm/dts/apq8016-sbc-u-boot.dtsi          |   9 -
 board/qualcomm/debug-msm8953.config           |   5 +
 board/qualcomm/debug-qcm6490.config           |   5 +
 board/qualcomm/debug-qcs9100.config           |   5 +
 board/qualcomm/debug-sm6350.config            |   5 +
 configs/qcm6490_defconfig                     |   6 -
 configs/qcom_defconfig                        |  10 +
 configs/qcom_ipq5424_mmc_defconfig            |   2 +
 configs/qcom_ipq9574_mmc_defconfig            |   2 +
 configs/qcs9100_defconfig                     |   6 -
 doc/board/qualcomm/debugging.rst              |   2 -
 drivers/clk/clk-stub.c                        |   3 +
 drivers/clk/qcom/Kconfig                      |  15 +
 drivers/clk/qcom/Makefile                     |   2 +
 drivers/clk/qcom/clock-sc7280.c               |  28 ++
 drivers/clk/qcom/clock-sdm845.c               | 127 ++++++
 drivers/clk/qcom/clock-sm6350.c               | 193 +++++++++
 drivers/clk/qcom/clock-sm7150.c               | 250 +++++++++++
 drivers/clk/qcom/clock-sm8250.c               |   5 -
 drivers/gpio/qcom_spmi_gpio.c                 |   4 +
 drivers/i2c/Kconfig                           |   2 +-
 drivers/i2c/geni_i2c.c                        |  14 +-
 drivers/iommu/qcom-hyp-smmu.c                 |   4 +-
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/qcom_geni.c                      | 580 ++++++++++++++++++++++++++
 drivers/phy/qcom/Kconfig                      |   6 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |  62 +++
 drivers/pinctrl/qcom/Kconfig                  |  20 +
 drivers/pinctrl/qcom/Makefile                 |   3 +
 drivers/pinctrl/qcom/pinctrl-sc7280.c         |   6 +-
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 247 +++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6350.c         | 104 +++++
 drivers/pinctrl/qcom/pinctrl-sm7150.c         | 142 +++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  31 ++
 drivers/serial/Kconfig                        |   3 +-
 drivers/serial/serial_msm.c                   | 127 ++----
 drivers/serial/serial_msm_geni.c              | 107 ++---
 drivers/usb/gadget/Kconfig                    |   2 +
 drivers/usb/host/ehci-msm.c                   | 146 +++----
 include/soc/qcom/geni-se.h                    |  36 ++
 include/soc/qcom/qup-fw-load.h                | 178 ++++++++
 42 files changed, 2229 insertions(+), 285 deletions(-)
 create mode 100644 board/qualcomm/debug-msm8953.config
 create mode 100644 board/qualcomm/debug-qcm6490.config
 create mode 100644 board/qualcomm/debug-qcs9100.config
 create mode 100644 board/qualcomm/debug-sm6350.config
 create mode 100644 drivers/clk/qcom/clock-sm6350.c
 create mode 100644 drivers/clk/qcom/clock-sm7150.c
 create mode 100644 drivers/misc/qcom_geni.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm6350.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm7150.c
 create mode 100644 include/soc/qcom/qup-fw-load.h
