Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA61C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8545584066;
	Fri, 11 Apr 2025 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NeZ65u4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F738406A; Fri, 11 Apr 2025 16:09:15 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D537884003
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2240b4de12bso27362965ad.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744380551; x=1744985351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2OUU9QR5qAA4ChLCIJeAydEAqvpMoZ3z9+2oj1UYEg=;
 b=NeZ65u4YsGJbdl7qrfxb/Oc5jw722seo4voQobscSQxMU2ICPEWU0yW6pIbMiT5kPR
 Y1vq4O+WKsPC6u8lFy6uNLFQGUH7e2NdkFrJM8aL5Wtw2eqx8tJzzaMQZ9LTTZ7IWNo3
 G1Hjy2qwq6hLUZrVdOzuTpWIKedv7nVm4xOFCClXx81E+EctKNRIxvgkRQqQgwNddGJ6
 iTPHTOMxY3Drdy0ZNx4w52LCj3YM46sr6/uGJ2NfOF1EO78YDTTkP9VMd5fPXbq+9u8V
 wrb107g0nHfI52Ckb1jpmc3nqjHx2QQYy2r70UQwGztPILCATxsGb0yhsS0/KkYWkF0Y
 SibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380551; x=1744985351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2OUU9QR5qAA4ChLCIJeAydEAqvpMoZ3z9+2oj1UYEg=;
 b=Dp8p/xNX6A1UASMrWzshluLw0hqA0sDgY2g0TFd201uUENLDrX+pxgpyO52IZRoe+I
 HPfJScThf2X0nVEqQLAuvTRf6qqrorXC2uObBVs0M+EJX2Vd4kFNO36vSeo8I+31QHvP
 Gi11V40Rm589v2jV/evboQkls2F92WVPBpK15daT4n0AGr/CUus41MIUc2dAMjrTsoAV
 eQrpE0fVQ0GlyK/3mmEZUCiaTM7+E7ITNrjEzEXjDSsIv++3op5KmdqQA8NBUNPaiiKh
 616Be0PzBzLLGg5l+kwkCt/fO4dLrr9Zwg+X3EPyBvB73mkwY7GFSplmsZilEVWhrXT2
 2rqA==
X-Gm-Message-State: AOJu0Yw+iUR0ceR6Xkupf0pgsUf4P+7/iWiU7Y1nQIxPM5aHe+z3rLos
 GEmAVRzqkCLD/k6abYt+BdpPnUdcP5VMwyMbJSvCerVnPJZDRpAD9KGNNA==
X-Gm-Gg: ASbGncsVWX7P2NIBTwQXcrfptdWPwWB+H0nkgPAjFiUcv8jz3f4bukFDmHJPCLUtFdA
 RsMshi0WjFkqx4StrLZnoWVAVMojaPzeeVHCqqk2kdaeL41gsdTvqedWJtjBHJRAo4omho2vbh5
 A9EbnkJmg/4XWq+y3V61zGRG5HiwlK8aIlABfw6NesCl/qXe5GHDq9h0k2yaAEXY4uiWBTlog46
 5V1/jQ9j5P1XbmW7hMYpFt5eOwQeB/t2GMzsWJ4uYe8lKo8gpDg2Ejld1zV7Lu2Ar/Fss4EHol4
 t5R0fubLmm4+kjjurX+gviuAeZ1t/cnSp6cy5dCv+krrBK0zCX5tYD8=
X-Google-Smtp-Source: AGHT+IHNMoSJOF8crFl4kMGv1n7U4rXYIZ3nEHi03BwLCWXnX7+E8wePN7FCCzsRpouoHiPAGhEMVw==
X-Received: by 2002:a17:903:2286:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22bea4ffa76mr36003675ad.36.1744380551262; 
 Fri, 11 Apr 2025 07:09:11 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:cbb1:9927:dc49:12f6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b9042dsm49285165ad.104.2025.04.11.07.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:09:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250411
Date: Fri, 11 Apr 2025 11:09:06 -0300
Message-Id: <20250411140906.32762-1-festevam@gmail.com>
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

The following changes since commit cb7555e93075114fe4af0adb806877ac4d4ef80d:

  Merge patch series "*** Add Ethernet boot support for AM62Ax + phyCORE-AM62 SoMs ***" (2025-04-10 15:04:09 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250411

for you to fetch changes up to ba71e4ef4d3d3edc05c29e14f0ed84ecce4bb051:

  board: phycore-imx93: env: Add common RAUC boot logic (2025-04-11 10:00:59 -0300)

u-boot-imx-master-20250411
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25652

- Add i.MX8MP LDB support.
- Various phycore-imx93 environment improvements.
- Add support for Toradex SMARC iMX8MP.
----------------------------------------------------------------
Leonard Anderweit (1):
      board: phycore-imx93: env: Move bootcmd from defconfig to env

Martin Schwan (1):
      board: phycore-imx93: env: Add common RAUC boot logic

Miquel Raynal (12):
      core: ofnode_graph: Fix a comment
      dm: doc: Fix example
      dm: core: Add a helper to retrieve devices through graph endpoints
      test: dm: test-fdt: Add checks for uclass_get_device_by_endpoint()
      power-domain: Add refcounting
      clk: Ensure the parent clocks are enabled while reparenting
      clk: imx8mp: Add media related clocks
      imx: power-domain: Describe the i.MX8 MEDIAMIX domain
      imx: power-domain: Add support for the MEDIAMIX control block
      video: imx: Fix Makefile in order to be able to add other imx drivers
      video: imx: Add LDB driver
      video: imx: Add LCDIF driver

Primoz Fiser (4):
      board: phycore-imx93: env: Move fdt and bootenv addresses
      board: phycore-imx93: env: Add optargs to environment
      board: phycore-imx93: env: Add prepare_mcore to environment
      board: phycore-imx93: env: Add option to disable bootenv.txt import

Rafael Beims (1):
      toradex: apalis-imx6: Fix build failure when CONFIG_VIDEO_IPUV3 is enabled

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Vitor Soares (3):
      arm: dts: imx8mp: sync with Linux v6.15-rc1
      toradex: tdx-cfg-block: add 0096 Toradex SMARC iMX95
      board: toradex: add Toradex SMARC iMX8MP

 arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi |   80 +
 arch/arm/dts/imx8mp-toradex-smarc-dev.dts         |  297 ++++
 arch/arm/dts/imx8mp-toradex-smarc.dtsi            | 1284 ++++++++++++++
 arch/arm/dts/imx8mp.dtsi                          |  413 ++++-
 arch/arm/mach-imx/imx8m/Kconfig                   |    7 +
 board/phytec/phycore_imx93/phycore_imx93.env      |   36 +-
 board/toradex/apalis_imx6/apalis_imx6.c           |   14 +-
 board/toradex/common/tdx-cfg-block.c              |    2 +
 board/toradex/common/tdx-cfg-block.h              |    2 +
 board/toradex/smarc-imx8mp/Kconfig                |   39 +
 board/toradex/smarc-imx8mp/MAINTAINERS            |   10 +
 board/toradex/smarc-imx8mp/Makefile               |    9 +
 board/toradex/smarc-imx8mp/imximage.cfg           |    6 +
 board/toradex/smarc-imx8mp/lpddr4_timing.c        | 1903 +++++++++++++++++++++
 board/toradex/smarc-imx8mp/lpddr4_timing.h        |    9 +
 board/toradex/smarc-imx8mp/smarc-imx8mp.c         |   85 +
 board/toradex/smarc-imx8mp/smarc-imx8mp.env       |   20 +
 board/toradex/smarc-imx8mp/spl.c                  |  130 ++
 configs/imx93-phycore_defconfig                   |    1 -
 configs/sandbox64_defconfig                       |    2 +
 configs/sandbox_flattree_defconfig                |    2 +
 configs/toradex-smarc-imx8mp_defconfig            |  184 ++
 doc/board/toradex/index.rst                       |    1 +
 doc/board/toradex/smarc-imx8mp.rst                |  116 ++
 doc/develop/driver-model/design.rst               |    2 +-
 drivers/clk/clk-uclass.c                          |   19 +-
 drivers/clk/imx/clk-imx8mp.c                      |   69 +
 drivers/core/ofnode_graph.c                       |    2 +-
 drivers/core/uclass.c                             |   19 +
 drivers/firmware/scmi/sandbox-scmi_devices.c      |    1 +
 drivers/firmware/scmi/smt.c                       |   13 +
 drivers/power/domain/Kconfig                      |    7 +
 drivers/power/domain/Makefile                     |    1 +
 drivers/power/domain/imx8m-power-domain.c         |   17 +
 drivers/power/domain/imx8mp-mediamix.c            |  208 +++
 drivers/power/domain/power-domain-uclass.c        |   40 +-
 drivers/power/domain/sandbox-power-domain-test.c  |    1 +
 drivers/video/Makefile                            |    2 +-
 drivers/video/imx/Kconfig                         |    9 +
 drivers/video/imx/Makefile                        |    4 +-
 drivers/video/imx/lcdif.c                         |  314 ++++
 drivers/video/imx/ldb.c                           |  251 +++
 include/configs/toradex-smarc-imx8mp.h            |   28 +
 include/dm/uclass.h                               |   24 +
 include/power-domain.h                            |   60 +-
 test/dm/power-domain.c                            |    2 +-
 test/dm/test-fdt.c                                |   20 +-
 47 files changed, 5674 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc-dev.dts
 create mode 100644 arch/arm/dts/imx8mp-toradex-smarc.dtsi
 create mode 100644 board/toradex/smarc-imx8mp/Kconfig
 create mode 100644 board/toradex/smarc-imx8mp/MAINTAINERS
 create mode 100644 board/toradex/smarc-imx8mp/Makefile
 create mode 100644 board/toradex/smarc-imx8mp/imximage.cfg
 create mode 100644 board/toradex/smarc-imx8mp/lpddr4_timing.c
 create mode 100644 board/toradex/smarc-imx8mp/lpddr4_timing.h
 create mode 100644 board/toradex/smarc-imx8mp/smarc-imx8mp.c
 create mode 100644 board/toradex/smarc-imx8mp/smarc-imx8mp.env
 create mode 100644 board/toradex/smarc-imx8mp/spl.c
 create mode 100644 configs/toradex-smarc-imx8mp_defconfig
 create mode 100644 doc/board/toradex/smarc-imx8mp.rst
 create mode 100644 drivers/power/domain/imx8mp-mediamix.c
 create mode 100644 drivers/video/imx/lcdif.c
 create mode 100644 drivers/video/imx/ldb.c
 create mode 100644 include/configs/toradex-smarc-imx8mp.h
