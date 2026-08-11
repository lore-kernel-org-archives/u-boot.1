Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DABBC5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 12:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED47B81004;
	Tue, 11 Aug 2026 12:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LM7VAp_p5n_3; Tue, 11 Aug 2026 12:26:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C59FC81005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786451183;
	bh=GGJAkPLhnmECdHo2ZAjH+ai1YnL8g+bZVAZ1GIrOOnY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fEb/63naVd6SeJVl47HbaJXtfo4EDQcfj+DZrWoJEgENOixmzbNZE0EPyaQSCpc3x
	 7XjbJbKs/HTiTU50mMCetlXmWw7J0cN9ZvVxHEv7M9yUKZPb03ZsRume/YKbuhsQHR
	 EJY+ucrQ5AINGHvfX42gJ03JFHmJPhfL7qQx4cBN2x75WRbyWWatL6uXF9RHUhfMfi
	 f98mdL11o05nHvvE/Y9xWeVDBIkSu3zvq3BUKD1eCVIER/U+VuA7Hzlpp9O8X1fyaC
	 0vYJDATl7yelZvoJcw0CIaTPAdg1iYedXXwKYjuvOg0pY51o+AZ9wF8yodY7CaopSg
	 rp7LFpNFPreVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C59FC81005;
	Tue, 11 Aug 2026 12:26:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04718218
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF51681004
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFVHLCr2dlTt for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 12:26:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 470E080F88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 470E080F88
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 470E080F88
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:26:21 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49557167508so25096865e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451179; x=1787055979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GGJAkPLhnmECdHo2ZAjH+ai1YnL8g+bZVAZ1GIrOOnY=;
 b=HAWkIhob0mBLNjreQIqONQzvErtbcuFJb9CwFJMLf7pv/76xsD9DMwnEBhSe8S/rDP
 42ny4fP45Szi0BoSWF9e0dJF4BI7nPW0Ayaeh5C7996GMYV2xMBJLDQe/yoOJUqp3un7
 8gGBHnWa5zkgpHpa0ybJiA19I6m4B7lJMg9Yy3E0mWwpUL6WkK4ylbdlIhcglGivRpq4
 vY6ksvgP6QI+PscG7NST58abDqHM9F8mC7N2ux37EJJW2bjTQzpPX2tsvTtlFYFmSZ3D
 RYdtC39ZzvhFbQOYt/qrxLhdA45/xquae1UpRJBDRCudfJANQwoDXAHK8sy5nSCOSFmJ
 GO6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAIS/LX+I+y6wtvARbcqICmRoXSjpMxcfPJJeYLYrLiyw9om0L8H02nlLf5mVgth7s6L4mNtQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx6V7lYnZPh11eKIzj0ZD4+w/CHABH1C54RFHqEmCwYsRLL7C1/
 QwfffM2WPRjFml8b0cnCRYCEVnbtCpbkqLJNZ00+O8ZSs1qkDgdDGzyMZfIQJuRPnHQ=
X-Gm-Gg: AR+sD11vkzzn03RR11nTpUG78KbvA7qbZmWgwqzLbxNsZJ6Fa+uzOdSGAbHg3YZgCiv
 EOUdjzbRGuCU4HibMZ/t4EV5B4TZI37uOwpBRrAVzkYikMtkmhPMgj6Lmk3lChk5Tb9cSm5JHX2
 BjAekM3VN+LfW2IJE/0za6uUtSt9JesLCYQYEGrM77EjszUbit8NBM1UJ1KN07Ld1pjU52f5QBw
 0AsSVl8gQKxFAiQn2Eg23eQZYVJzV1RfgZRfYw9kFavf8sbNIiU3RMVuvGC/lpHsEjS6FZESTWo
 2u5F7Nosa+sBCE11PkSNf6mMuP2SNEv4e8giWqLQP8/h6I3e838bqHOsmfFp682+G4meY40QFoA
 9waNjLe9LYDGjWkbX5FUkLcNmMs4+1ktLBYEkWvpVmePdYWV/sm7JcX6a4X5pF55mfsY3Xz5nQZ
 H5F0T1kwLISDM8G5aiim4cUQ7VMbO6g+tqYqOiZph8UvOi2pLrHgro0xqE63P7h8XOVeTGVOMYz
 mm8JOgl+PAoWoAyJcCFgbukuFOail5vRNAmamU=
X-Received: by 2002:a05:600c:5250:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49978440da8mr46273945e9.7.1786451179077; 
 Tue, 11 Aug 2026 05:26:19 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29ea13.dip0.t-ipconnect.de.
 [91.41.234.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788f17ccsm38825725e9.11.2026.08.11.05.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 05:26:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next
Date: Tue, 11 Aug 2026 14:18:48 +0200
Message-ID: <20260811122549.2586034-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786451179; x=1787055979;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GGJAkPLhnmECdHo2ZAjH+ai1YnL8g+bZVAZ1GIrOOnY=;
 b=bxgb4rZZsRjn8xmUut+BKnPqo3Z7MLIJJVeBOA5DRTO9Pkt5pl0YqQHg02MESysz1o
 yoQMhsBmc5GAQroNfJxRQ8Ssc4sZdW29f5tGp1i/khvgSU+UVLJxgLCkQJTfReNAF1mn
 I9If202ZzpCJzXNQY6mQs0aGYuKQguicde5HpgR1dfbydqGF/Bg198oc/BkxO6m6RVc0
 KAiD/LIfDMVZ3E/BsTI8FOc/1g7buRUZ2mOsEPD4KFb/CKCuAqrSXryGQylSoBQfTz11
 J6PaY+LecFDnV/ByxBbpUHc+6+/NfKYjbnQ3GYdetXoVqntkLd8vyavuSHuTvNVoC2at
 jKwg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bxgb4rZZ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

These changes for 2026.10.

* Support for building mbn files during the build with the new mkmbn
  tool
* Remove UCLASS_SMEM and the old smem driver (Qualcomm was the only
  user of both), replace it with a port of the Linux SMEM driver.
* Refactor memory map parsing and support reading the memory layout from the SMEM database
* Set the serial# from SMEM
* Introduce initial support for SPL in mach-snapdragon
* Add a defconfig for sm8650 with U-Boot as the primary bootloader
* Workaround an MMC issue by limiting the transfer size
* Add support for SM7125/SC7180 (clock/pinctrl drivers and UFS phy)
* Add support for the QCS6490 powered Rubik Pi 3 board and document it

Thanks,

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git qcom-next

for you to fetch changes up to 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee:

  CI: add Qualcomm requirements.txt for world build (2026-08-10 14:49:42 +0200)

----------------------------------------------------------------
Aswin Murugan (1):
      i2c: geni: reset controller on NACK to recover from invalid bus state

Balaji Selvanathan (1):
      configs: qcom_defconfig: Limit MMC transfer size to prevent controller timeout

Casey Connolly (22):
      config.mk: support vendor generic includes
      tools: qcom: introduce mkmbn library
      tools: qcom: add mkmbn.py
      doc: board/qualcomm: update docs for new u-boot.mbn target
      mach-snapdragon: add kconfig infra for building MBN files
      configs: qcom: use mkmbn and stop building ELF files
      Revert "dm: SMEM (Shared memory) uclass"
      smem: drop drivers/smem
      Revert "test: smem: add basic smem test"
      Revert "drivers: smem: sandbox"
      mach-snapdragon: fix reserved memory carveout
      soc: qcom: import smem from Linux 6.11-rc2
      soc: qcom: smem: adjust headers for U-Boot
      soc: qcom: smem: adjust for U-Boot
      soc: qcom: smem: get serial number from socinfo
      soc: qcom: smem: stub functions
      soc: qcom: smem: add build infra
      mach-snapdragon: move memory parsing to its own file
      mach-snapdragon: support parsing memory map from SMEM
      mach-snapdragon: fetch serial# from SMEM
      configs: add qcom_sm8650_defconfig and debug fragment
      CI: add Qualcomm requirements.txt for world build

Hongyang Zhao (2):
      configs: Add qcom_qcs6490_rubikpi3_defconfig
      doc: board: qualcomm: Document RUBIK Pi 3

Michael Srba (12):
      Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
      of_live: support in SPL
      drivers: allow clk_stub and spmi in SPL
      mach-snapdragon: boot0.h: split out msm8916_boot0.h
      qualcomm: add u-boot-spl-elf-sdm845.lds
      mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
      mach-snapdragon: Kconfig: changes / additions to support SPL
      mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
      mach-snapdragon: move board_usb_init to dragonboard410c.c
      mach-snapdragon: add board_spl.c and split out common code
      qualcomm: add defconfig, env and docs for SPL on sdm845
      dts: add u-boot specific sdm845 .dtsi and a .dtsi for shift-axolotl

Vitalii Skorkin (4):
      clk: qcom: Add driver for SC7180 GCC
      pinctrl: qcom: add SC7180 pinctrl driver
      qcom_defconfig: Enable SC7180 GCC
      phy: qcom-qmp-ufs: Add SC7180 support

 .azure-pipelines.yml                               |   1 +
 .gitlab-ci.yml                                     |   1 +
 Kconfig                                            |   1 +
 MAINTAINERS                                        |   1 -
 Makefile                                           |  11 +-
 arch/arm/Kconfig                                   |  37 +-
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi      |   2 +
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +
 arch/arm/mach-snapdragon/Kconfig                   |  46 +-
 arch/arm/mach-snapdragon/Makefile                  |   8 +
 arch/arm/mach-snapdragon/board.c                   | 400 ++---------
 arch/arm/mach-snapdragon/board_spl.c               |  30 +
 arch/arm/mach-snapdragon/dram.c                    | 239 +++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  64 +-
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 ++
 .../include/mach/sdm845_spl_boot0.h                | 121 ++++
 arch/arm/mach-snapdragon/mem_map.c                 | 226 ++++++
 arch/arm/mach-snapdragon/of_fixup.c                |   5 -
 arch/arm/mach-snapdragon/qcom-priv.h               |  19 +-
 arch/arm/mach-snapdragon/rampart.h                 | 194 +++++
 arch/sandbox/dts/test.dts                          |   4 -
 board/qualcomm/config.mk                           |  14 +
 board/qualcomm/debug-sm8650.config                 |   5 +
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  41 ++
 board/qualcomm/requirements.txt                    |   1 +
 board/qualcomm/sdm845_spl/config.mk                |  14 +
 board/qualcomm/sdm845_spl/sdm845_spl.env           |   2 +
 .../qualcomm/sdm845_spl/u-boot-spl-elf-sdm845.lds  |  44 ++
 common/spl/Kconfig                                 |  12 +
 common/spl/spl.c                                   |   9 +
 config.mk                                          |   8 +-
 configs/hmibsc_defconfig                           |   1 +
 configs/qcm6490_defconfig                          |   2 +-
 configs/qcom_defconfig                             |   5 +-
 ...0c_defconfig => qcom_dragonboard410c_defconfig} |   3 +-
 ...0c_defconfig => qcom_dragonboard820c_defconfig} |   0
 configs/qcom_ipq5424_mmc_defconfig                 |   1 -
 configs/qcom_ipq9574_mmc_defconfig                 |   3 +-
 configs/qcom_qcs615_defconfig                      |   2 +-
 configs/qcom_qcs6490_rubikpi3_defconfig            |   7 +
 configs/qcom_qcs8300_defconfig                     |   2 +-
 configs/qcom_qcs9100_defconfig                     |   2 +-
 configs/qcom_sdm845_spl_defconfig                  | 138 ++++
 configs/qcom_sm8650_defconfig                      |  16 +
 configs/sandbox64_defconfig                        |   2 -
 configs/sandbox_defconfig                          |   2 -
 doc/board/qualcomm/board.rst                       |   2 +-
 doc/board/qualcomm/dragonboard410c.rst             |  19 +-
 doc/board/qualcomm/dragonwing.rst                  |  14 +-
 doc/board/qualcomm/index.rst                       |   3 +
 doc/board/qualcomm/rb3gen2.rst                     |  30 +-
 doc/board/qualcomm/rdp.rst                         |   5 +-
 doc/board/qualcomm/rubikpi3.rst                    |  52 ++
 doc/board/qualcomm/signing.rst                     |  32 +
 doc/board/qualcomm/spl.rst                         |  91 +++
 drivers/Kconfig                                    |   2 -
 drivers/Makefile                                   |   3 +-
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clock-sc7180.c                    | 273 ++++++++
 drivers/i2c/geni_i2c.c                             |   2 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                |   1 +
 drivers/pinctrl/qcom/Kconfig                       |   7 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c              |  95 +++
 drivers/smem/Kconfig                               |  25 -
 drivers/smem/Makefile                              |   7 -
 drivers/smem/sandbox_smem.c                        |  44 --
 drivers/smem/smem-uclass.c                         |  46 --
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/{smem/msm_smem.c => soc/qcom/smem.c}       | 777 ++++++++++++---------
 drivers/spmi/Kconfig                               |  13 +
 drivers/spmi/Makefile                              |   4 +-
 dts/Kconfig                                        |   8 +
 include/dm/uclass-id.h                             |   1 -
 include/smem.h                                     |  90 ---
 include/soc/qcom/smem.h                            |  36 +
 include/soc/qcom/socinfo.h                         | 111 +++
 lib/Makefile                                       |   2 +-
 test/dm/Makefile                                   |   1 -
 test/dm/smem.c                                     |  26 -
 tools/mkmbn                                        |   1 +
 tools/qcom/mkmbn/cert.py                           | 127 ++++
 tools/qcom/mkmbn/elf.py                            | 241 +++++++
 tools/qcom/mkmbn/hashseg.py                        | 356 ++++++++++
 tools/qcom/mkmbn/mkmbn.py                          | 165 +++++
 88 files changed, 3506 insertions(+), 1048 deletions(-)
 create mode 100644 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
 create mode 100644 arch/arm/dts/sdm845-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/board_spl.c
 create mode 100644 arch/arm/mach-snapdragon/dram.c
 create mode 100644 arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h
 create mode 100644 arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
 create mode 100644 arch/arm/mach-snapdragon/mem_map.c
 create mode 100644 arch/arm/mach-snapdragon/rampart.h
 create mode 100644 board/qualcomm/config.mk
 create mode 100644 board/qualcomm/debug-sm8650.config
 create mode 100644 board/qualcomm/requirements.txt
 create mode 100644 board/qualcomm/sdm845_spl/config.mk
 create mode 100644 board/qualcomm/sdm845_spl/sdm845_spl.env
 create mode 100644 board/qualcomm/sdm845_spl/u-boot-spl-elf-sdm845.lds
 rename configs/{dragonboard410c_defconfig => qcom_dragonboard410c_defconfig} (96%)
 rename configs/{dragonboard820c_defconfig => qcom_dragonboard820c_defconfig} (100%)
 create mode 100644 configs/qcom_qcs6490_rubikpi3_defconfig
 create mode 100644 configs/qcom_sdm845_spl_defconfig
 create mode 100644 configs/qcom_sm8650_defconfig
 create mode 100644 doc/board/qualcomm/rubikpi3.rst
 create mode 100644 doc/board/qualcomm/signing.rst
 create mode 100644 doc/board/qualcomm/spl.rst
 create mode 100644 drivers/clk/qcom/clock-sc7180.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
 delete mode 100644 drivers/smem/Kconfig
 delete mode 100644 drivers/smem/Makefile
 delete mode 100644 drivers/smem/sandbox_smem.c
 delete mode 100644 drivers/smem/smem-uclass.c
 rename drivers/{smem/msm_smem.c => soc/qcom/smem.c} (56%)
 delete mode 100644 include/smem.h
 create mode 100644 include/soc/qcom/smem.h
 create mode 100644 include/soc/qcom/socinfo.h
 delete mode 100644 test/dm/smem.c
 create mode 120000 tools/mkmbn
 create mode 100644 tools/qcom/mkmbn/cert.py
 create mode 100644 tools/qcom/mkmbn/elf.py
 create mode 100644 tools/qcom/mkmbn/hashseg.py
 create mode 100755 tools/qcom/mkmbn/mkmbn.py
