Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CECC7115B
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 01:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DE78006D;
	Tue, 24 Jun 2025 03:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XjDfxGcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF9081E13; Tue, 24 Jun 2025 03:51:20 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C918004F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 03:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-60ef6bf2336so3359468eaf.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 18:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750729877; x=1751334677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:dkim-signature:resent-to:resent-message-id:resent-date
 :resent-from:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYJ35KHKz6FWlduTTkrSis5kvxPvp57eaicLRx2Bszg=;
 b=oM7Dfg5osGcNyjhhPk6RZaReh7WZ4SwlgRz94fXzhmziNR15i5YaDZP+DLW9PzmwB4
 SHkOOFC6OTaMAHBfoI7k/Lrg9l5NjnAB5HtWp8gcOLs/kxDvGRr0PLg7fSstm/mrmO5f
 g0FCGXihS2nBNzmHwNgh7OMRamDwrXXHoAJGt0psJswAlgfcraBgljWy9dODlkqzVRhQ
 iskAQ6PKC0PuPYUryHM40fp2K6IZ9E4dz36KG456k1OFMOAZfVfrWGlMy6hEC3U36W/o
 GZtPRzirHGzbbx/vBHVQ2RZcnsCg+jSgvxmFwtkkTI7FaUMFgPmZ69r85hWjJ0OKZisG
 ZPxA==
X-Forwarded-Encrypted: i=2;
 AJvYcCXMsxOqguVgyjAQU+M2IspUlewomwB343Xysx+uKxxf5x7cRZVC2ovZ+fJp4hQ/YsgTz3xoWM4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1fGZhCCglxhpXbrG7WLUPKMtpNas8ZS+ElM4lEkas4KccFR5o
 Rpm4IN/W0aFwdudAedn0NHLo1gdHEVELSm1EmX6LaGpllIoBwTDtvO90ixJPZ+AgSmXsPvQCZLX
 zsf3hxHo=
X-Gm-Gg: ASbGncuvqVaOUNnA70urcgD7uWj2HStw+w6PxCx1X4VIHpGaC2i/wHyiWWWZpjBWIQS
 SNzyV/FOFaWjGxOgPp6BKbnF+O+6wQ98w5F2Dj5Ij9WuOtd4qZgVq3YEMh4oqzzuHzl+0x6uRC/
 zN9ZJdKpUWGkGhs+FvbvZTPcIhcnqxNjB9JCNxGdipqZDvFZLUv3VewPDdITvZVkJTwCF89xC4U
 gEWLdLeuMEgGG2SM70HVOvfGACy8MQ9K5E0vnFPPyAVaERwyhK17APSd2uvn1/JWRgI4mBrpaL5
 iqpLL0wSu379yCbbyiqw02XWDHBywA/IadXbe1AjkpXkDn4rxU478sGCIx90M0T2KgTk7TCpaLm
 e/6+voH/VU9KCJjVrk8sK/R0=
X-Google-Smtp-Source: AGHT+IFz9h2ZeNaW0hsRzzBAo5PIYlphviXWD1d1NWtBNkJwznX1VoQoby0jKc14O/PVKMEsB1Wqdg==
X-Received: by 2002:a05:6871:441a:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2eeee595007mr11535759fac.30.1750729876874; 
 Mon, 23 Jun 2025 18:51:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ef2e2abcd8sm1744687fac.21.2025.06.23.18.51.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:51:16 -0700 (PDT)
From: Casey Connolly <trini@konsulko.com>
X-Google-Original-From: Casey Connolly <casey.connolly@linaro.org>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Mon, 23 Jun 2025 19:51:14 -0600
Resent-Message-ID: <20250624015114.GH4003484@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:45a4:b0:a6:f736:36be with SMTP id cf36csp2931199dlb; 
 Mon, 23 Jun 2025 16:46:58 -0700 (PDT)
X-Received: by 2002:adf:b605:0:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3a6d13160c0mr10286533f8f.51.1750722417868; 
 Mon, 23 Jun 2025 16:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1750722417; cv=none;
 d=google.com; s=arc-20240605;
 b=YbAvFu20rt6RPafF0+xa2EdECk9Gyy+S7LimJzN2Cy+uSRCHo2ZA07Yg/HqpMQ/wQu
 qPISouHKcgV1H9h8WdYRym6FSgnrV17CHemKzC08JHFp6lS6laz6qG5dQ1W1zdB8hBW7
 VSE9vi52PtZEfrNw+5y3b5dYq7W51Cb/gZGWzcrIl8RhWnbJZnUw652EgCzcVxDDdBYj
 Hcgfj2t3ER1p5M+QQf6EqbyX1WrSJxTP5oAkfJ9AngdUV58lE95VUKULGVOt+oC56Yr2
 pYTGDQHKRzUhqS+4HCuWYKwa6qXA7tyNrUzBVfBIIDT/uT7uwRnUmL3B4LtJgNMcp2pK
 Ktgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature;
 bh=aYJ35KHKz6FWlduTTkrSis5kvxPvp57eaicLRx2Bszg=;
 fh=HiZEvWJXLQIBRR5KTZndlt6Y/KEAt1RsnRDlfhlT/5Y=;
 b=NJDtloQkuL+utsuX5RfIsqPNF+rqQ8HZZ6mw2ZOgc5MYchPVEGuiyDRvp4kvYvqZNe
 Ptschsx1FUfDhrwfvTfQ/fIn3DWM/+xAawXfeasISRhAtMlEPmBNy45THIQCy4SP2axw
 ipomEW7pyT3iBwHspLGWn/CsLFEA6fCNxPM6THudioGTdN7n6dtUgR9wNmO1NlEC2Mce
 iFws4VPx4XRz+jqpUhbm6ytO1d47vO15qMjj3Zwe4uaC6oFSuYGB3aNu0syoIyPjKxXC
 C9U7IoUcbMZZB0BEHoLmQvVB3NhOwhRWlGvxZ1Y7VOqfb8ICFg94bhNktnRlaboLVI3x
 VC9g==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@linaro.org header.s=google header.b=XjDfxGcp;
 spf=pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) smtp.mailfrom=casey.connolly@linaro.org; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org;
 dara=pass header.i=@konsulko.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com.
 [209.85.220.41]) by mx.google.com with SMTPS id
 ffacd0b85a97d-3a6e80b0634sor78636f8f.7.2025.06.23.16.46.57
 for <trini@konsulko.com> (Google Transport Security);
 Mon, 23 Jun 2025 16:46:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) client-ip=209.85.220.41; 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722417; x=1751327217; darn=konsulko.com;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aYJ35KHKz6FWlduTTkrSis5kvxPvp57eaicLRx2Bszg=;
 b=XjDfxGcpfIabzBXFHcdq/5+moNRj0pv9xSGqRHvV8jKZx2hnS2Ykm5gvXxGQFMxzw6
 zlmDqiUxLYNWAP7iak1G5T8JqQiXcCYPNJ+xwWvsbPa8O+ocWhkqjFu22XxJAQHoNY1N
 qPU/akcU58gXY8HN4RRXIqlbyBx7OFAlgs++4VGSekk+MsGXg2cAco0upu1Zx7wZzoLl
 IgDdj2YwEyt6H+G9m6hQVN+yzdb493Uu9khqcAmBqv+HruRQQHaCytfJLy9vSNkNuaFU
 b3QfwPwKxq5ZK5JroBWTAYg5BQ0/Y+zjC+MSpBd3oxBWMrUfB/LTfJ67d+2jRYb+KwDH
 b7aA==
X-Received: by 2002:a05:6000:645:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3a6d130e802mr12177241f8f.40.1750722416827; 
 Mon, 23 Jun 2025 16:46:56 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050e09sm411873f8f.19.2025.06.23.16.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:46:55 -0700 (PDT)
To: Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 George Chan <gchan9527@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-23Jun-1
Date: Tue, 24 Jun 2025 01:45:43 +0200
Message-ID: <20250623234640.126706-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.0
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

sorry this one took a while, still figuring out a good cadence for
this...

This PR introduces 3 new platforms, two from the new Dragonwing IQx
series (QCS615 and QCS8300) as well as the IPQ5424.

Additionally:

* Support for booting downstream Android boot images on some phones is added
* Capsule update support is expanded to be more generic, determining which partition U-Boot was flashed to automatically and supporting many more boards.
* Minor capsule update bugs are fixed
* A watchdog driver is added and gets timeout support
* Autoboot now requires pressing "space" specifically to stop booting as a workaround for some boards getting rogue key presses which would cause autoboot to fail
* Documentation is added for the Dragonwing boards
* The RB1/2 now use USB gadget mode rather than host
* A bug is fixed where GPIO reads could return incorrect values

The following changes since commit dbf7fd557a73ded3141db3c2cf5c572989378825:

  Merge patch series "Consistent Kconfig environment options CONFIG_ENV_ prefix" (2025-06-20 12:57:47 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-23Jun-1

for you to fetch changes up to c4c08cc21448aa97328b4dac17fb54c4f657ce80:

  doc: board/qualcomm: remove signing references from dragonwing.rst (2025-06-23 18:50:41 +0200)

----------------------------------------------------------------
Aswin Murugan (7):
      gpio: msm_gpio: return correct value for gpio read
      dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
      phy: qcom: Enable QMP UFS PHY driver for QCS615
      clk/qcom: qcs615: Add GCC clock driver for QCS615
      qcom_defconfig: Enable QCS615 clock driver
      configs: add qcom_qcs615_defconfig
      board: qualcomm: Add MAINTAINERS entries for Dragonwing platforms

Balaji Selvanathan (7):
      drivers: watchdog: qcom: Add timeout configuration support in watchdog
      doc: board: qualcomm: document Dragonwing board building/flashing
      dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
      clk/qcom: qcs8300: Add GCC clock driver for QCS8300
      phy: qcom: Enable QMP UFS PHY driver for QCS8300
      qcom_defconfig: Enable QCS8300 clock driver
      configs: add qcom_qcs8300_defconfig

Casey Connolly (7):
      watchdog: qcom: introduce qcom-wdt driver
      board: qualcomm: add a MAINTAINERS file
      mach-snapdragon: track boot source
      mach-snapdragon: CapsuleUpdate: support all boot methods
      dfu: scsi: don't call scsi_scan()
      qcom_defconfig: enable capsule update support
      doc: board/qualcomm: remove signing references from dragonwing.rst

George Chan (3):
      boot/image-android: Workaround kernel/ramdisk invalid addr
      mach-snapdragon: Enable workaround of ignoring androidboot addr
      mach-snapdragon: Enhance android image handling memory footprint

Luca Weiss (5):
      doc: board/qualcomm: Fix commands for compilation missing CROSS_COMPILE
      doc: board/qualcomm: Replace buildman build instructions
      doc: board/qualcomm: Add example for boot image version 2
      clk/qcom: sc7280: Fix variable name of msm_clk_data
      clk/qcom: sm8250: Fix variable name of msm_clk_data

Sumit Garg (2):
      mach-snapdragon: of_fixup: Drop USB dr_mode override for RB1/2
      qcom_defconfig: Enable AUTOBOOT_KEYED support

Varadarajan Narayanan (5):
      dts: ipq5424-rdp466-u-boot: add override dtsi
      doc: board/qualcomm: Update RDP signing instructions
      clk/qcom: add initial clock driver for ipq5424
      pinctrl: qcom: Add ipq5424 pinctrl driver
      configs: add qcom_ipq5424_mmc_defconfig

 arch/arm/Kconfig                          |   1 +
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi   |  37 ++++
 arch/arm/dts/qcs615-ride-u-boot.dtsi      |  14 ++
 arch/arm/dts/qcs8300-ride-u-boot.dtsi     |  19 ++
 arch/arm/mach-snapdragon/board.c          |  34 +++-
 arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++-----
 arch/arm/mach-snapdragon/of_fixup.c       |  13 --
 arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
 board/qualcomm/MAINTAINERS                |  24 +++
 boot/Kconfig                              |  11 +
 boot/image-android.c                      |   9 +-
 configs/qcm6490_defconfig                 |   6 -
 configs/qcom_defconfig                    |  10 +
 configs/qcom_ipq5424_mmc_defconfig        |  83 ++++++++
 configs/qcom_qcs615_defconfig             |  22 ++
 configs/qcom_qcs8300_defconfig            |  21 ++
 doc/board/qualcomm/board.rst              |  21 +-
 doc/board/qualcomm/dragonwing.rst         |  49 +++++
 doc/board/qualcomm/index.rst              |   1 +
 doc/board/qualcomm/rdp.rst                |  15 +-
 drivers/clk/qcom/Kconfig                  |  24 +++
 drivers/clk/qcom/Makefile                 |   3 +
 drivers/clk/qcom/clock-ipq5424.c          |  96 +++++++++
 drivers/clk/qcom/clock-qcom.h             |   1 +
 drivers/clk/qcom/clock-qcs615.c           | 163 +++++++++++++++
 drivers/clk/qcom/clock-qcs8300.c          | 146 ++++++++++++++
 drivers/clk/qcom/clock-sc7280.c           |   4 +-
 drivers/clk/qcom/clock-sm8250.c           |   4 +-
 drivers/dfu/dfu_scsi.c                    |   5 -
 drivers/gpio/msm_gpio.c                   |   2 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c       | 128 ++++++++++++
 drivers/pinctrl/qcom/Kconfig              |   7 +
 drivers/pinctrl/qcom/Makefile             |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5424.c    | 322 ++++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig                  |   9 +
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/qcom-wdt.c               | 137 +++++++++++++
 37 files changed, 1632 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
 create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 board/qualcomm/MAINTAINERS
 create mode 100644 configs/qcom_ipq5424_mmc_defconfig
 create mode 100644 configs/qcom_qcs615_defconfig
 create mode 100644 configs/qcom_qcs8300_defconfig
 create mode 100644 doc/board/qualcomm/dragonwing.rst
 create mode 100644 drivers/clk/qcom/clock-ipq5424.c
 create mode 100644 drivers/clk/qcom/clock-qcs615.c
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5424.c
 create mode 100644 drivers/watchdog/qcom-wdt.c
