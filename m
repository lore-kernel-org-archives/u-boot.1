Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5472ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA07E88D0C;
	Mon,  9 Sep 2024 12:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xTgM13qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF0988D0C; Mon,  9 Sep 2024 12:12:56 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D3188D01
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso4688699a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725876774; x=1726481574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dDnq8am6FoD2oWBGee/4fTlvaATRICZn4HZNvt5S5C8=;
 b=xTgM13qbR6XoNxtBysBmhcyHoqiEQMANAOi+HMMHViSZVVUxkabk/fXN63dEkc3mtu
 AEHs1vtb9TVZBW8/PC0b8w69t0ySm9CKxvM7K2SVNCUQRkyuiPXJnoIEVpPxvINzGueR
 2m3Vb3+ihl6sowqZK4aB3c5xHiXJ4OMxFoHkZ2jyIyDXTjgTj6VZ5dOs88ErXsc3+yJQ
 r8/E6OHiSdD4ERjmoZ5EHa1xSVZmllg2RUAg0l2j5oTAdizlE/hka4Vn9XEeT9YcCPbE
 uyUEKNRhhmOK+Q7GPAkBlS2NgGUI+TjIA6SfpuC/v2dTsxxXCd8zB5OHqj66CIFeYqoz
 uXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725876774; x=1726481574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dDnq8am6FoD2oWBGee/4fTlvaATRICZn4HZNvt5S5C8=;
 b=sMpLF2fMsuh+O3NZKMD5d/18oQXIZQAsVe4H2kn33KeALf8DVpdPZAb69N0E+tiHYc
 3PvV4wDhrn4cznQZZhoe9qyAyxC5CzDQo5T9h39KKowOZ6/pP4bEynYXBI2d5A5FJsR4
 Cn/WGJ9DGlzIa3iFVbCDoCcPNCKvYRtT7mCwCcEDp6Cher9XfPdhPQRMGoL58vfPSQd4
 C5TOrjYT1DrSlmkJLqKzqri42J7Qnj6vSK6ZTlHRChOG36LXBtPrP5LQ1svh6IWTFQz3
 MPrrB42Rg0NHVsO6i2DArfA+Q41ejQoHF/GSLIRjFAEmiXbA0jlLIEbzI6T6fgYEBhLJ
 7XcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5gzLqkywEQ3A/twlMoMPJrKfxnP75Q6VLQ2ih87hDWGSs5P4AWOBGfb24cpfC34tZjuWWd2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxGblGTudNVymTPgFbQIhRUM130yOJh6VrHXOa16K7TFX5qGKRe
 DT/8GxKW+SGQoIpuLIxbqd5AbyTHHD4xVsAHeb/8SYF+8JCbefpUj791iWXKubg=
X-Google-Smtp-Source: AGHT+IEYmR1+P2LPrT0ZZv7gYLhNFaRUkfKtIazkdJ6cH3enNdZAghJyvEWkfLYUP12KNYTEfFJPEQ==
X-Received: by 2002:a17:907:a02:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a8a885f4462mr965733866b.15.1725876773698; 
 Mon, 09 Sep 2024 03:12:53 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72727sm317441466b.107.2024.09.09.03.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 03:12:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-next
Date: Mon,  9 Sep 2024 12:04:46 +0200
Message-ID: <20240909101245.1302713-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
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

Various improvements to Snapdragon support:

* Bumped up the pagetable size to handle newer SoCs with much more RAM
* Made memory map parsing more robust, fixing chainloading on SM8550/SM8650
* Populate fdt_addr_r with U-Boot's FDT by default, and set $loadaddr to prevent
  crashes with some commands which expect it
* Added initial support for SC7280/QCM6490 and the new RB3 Gen 2 board
* Add debug config fragments to enable debug UART on some SoCs.
* Enable RPMh regulators on SM8550/SM8650
* Map the cmd-db memory explicitly since it may not be in the memory map

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/22255

Thanks,

The following changes since commit cbaf53fdf12534be50075fdd84105c682955424f:

  mmc: consider cd-gpios in Synopsys DesignWare driver (2024-09-05 19:08:14 -0600)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD

for you to fetch changes up to 41864bb2b66d0c68e6b2f6ae0c70d3c239ad258d:

  board/qualcomm: add debug config fragments for some SoCs (2024-09-06 11:59:51 +0200)

----------------------------------------------------------------
Caleb Connolly (18):
      mach-snapdragon: refactor board_fdt_blob_setup()
      mach-snapdragon: parse memory ourselves
      mach-snapdragon: set serial number
      mach-snapdragon: allocate fastboot buffer dynamically
      mach-snapdragon: populate fallback FDT
      mach-snapdragon: set loadaddr
      armv8: mmu: add a way to map additional regions
      soc: qcom: cmd-db: use strncmp() instead of memcmp()
      soc: qcom: cmd-db: map cmd-db region
      qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
      clk/qcom: add initial clock driver for sc7280
      dts: qcs6490-rb3gen2-u-boot: add override dtsi
      dts: qcs6490-rb3gen2-u-boot: USB host mode
      iommu: qcom-smmu: add sc7280-smmu-500 compatible
      qcom_defconfig: enable SC7280 clocks
      configs: add qcm6490_defconfig
      doc: board/qualcomm: document rb3gen2 building/flashing
      board/qualcomm: add debug config fragments for some SoCs

Neil Armstrong (3):
      mach-snapdragon: use 1MiB for get_page_table_size()
      soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
      regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators

 MAINTAINERS                                   |   1 +
 arch/arm/cpu/armv8/cache_v8.c                 |  25 ++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi      |  28 ++++
 arch/arm/include/asm/system.h                 |  10 ++
 arch/arm/mach-snapdragon/board.c              | 204 ++++++++++++++++++++++----
 board/qualcomm/debug-sdm845.config            |   5 +
 board/qualcomm/debug-sm6115.config            |   5 +
 board/qualcomm/debug-sm8250.config            |   5 +
 configs/qcm6490_defconfig                     |  21 +++
 configs/qcom_defconfig                        |   2 +
 doc/board/qualcomm/index.rst                  |   1 +
 doc/board/qualcomm/rb3gen2.rst                |  53 +++++++
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-qcom.h                 |   1 +
 drivers/clk/qcom/clock-sc7280.c               | 132 +++++++++++++++++
 drivers/iommu/qcom-hyp-smmu.c                 |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 136 +++++++++++++++++
 drivers/soc/qcom/cmd-db.c                     |  11 +-
 drivers/soc/qcom/rpmh-rsc.c                   |  43 ++++++
 20 files changed, 664 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
 create mode 100644 board/qualcomm/debug-sdm845.config
 create mode 100644 board/qualcomm/debug-sm6115.config
 create mode 100644 board/qualcomm/debug-sm8250.config
 create mode 100644 configs/qcm6490_defconfig
 create mode 100644 doc/board/qualcomm/rb3gen2.rst
 create mode 100644 drivers/clk/qcom/clock-sc7280.c
