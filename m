Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F4C369C2
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 02:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D21F8269F;
	Sun,  4 May 2025 04:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iIYqUJLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D01826AA; Sun,  4 May 2025 04:30:17 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529F58210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 04:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2767618b3a.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746325813; x=1746930613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=go7Fj4hyAzLRMNv++bd1iogwqnYc8jfEKpRfxz7R+4Y=;
 b=iIYqUJLxAZ1ZX1tJp62g2FalO25JzxXD0t98GdiVMXVCQ4W7NPfvra6udF9DTX/k1J
 9sSR3I+YcsurcK7EophA70QhC+v1wPiHxcN6Njr7xWQ0ps1wyEwD4fJYZEdNKCyn8qno
 UL1ADQL4xMoHqs/bxNQdNHzza4fGUmN7zps1eM7jsQpC6RZJ4jEuanF1dtAsUmToRSyt
 CGD7XZDlhPk1ui9I2bSQdK1sIKAokWbYL2ijMFzrSHEfROJM4RDf6vOcZMHfK9UdtaUd
 XPzLx3x6O/PTbVZJcTr4MPuU0Y27AxIVArASGlbOGcS7tIe/vGcyeLCOU/RlclgE73lD
 IxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746325813; x=1746930613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=go7Fj4hyAzLRMNv++bd1iogwqnYc8jfEKpRfxz7R+4Y=;
 b=UrumDXsDvOEhXWQ4JG2f+L6w9j11VAjSsLGogYtXzgj9FJqCuSlYt/u5rG16FNgWhs
 6lF51k9JuYC6+ZIgk3MzVGcsgza6ULeB3aotbT9bcna2CHJqFiE4AzRj0PhjI5j7bT8R
 9oi1Qwi0uUx5AiRBdl8r+AlL8jH3zn5knUhYfZ07RIhJ097ESJVE1ZRO2NaEptwA2BwT
 6PAaKgl581+ruVCgtUUMNGwNCW9baJGzOGsbVJH9su2PKyW0L5S3QTXUcumj0jRp1hWA
 +DFd1bXrNL2a2YEK84mWPwLAIFUj6xQkG0pxP4PdbVI4hdrjGQn3H9veMilrXtLUWKrc
 vc7w==
X-Gm-Message-State: AOJu0YxxMSx7e1YRXgjDblk2uHkF+5OvGTR1U63r54qLkiNAuCT6W4p0
 GUZPCtTkRPZ7bMAxhiV9mvgZ5umSadYiVDP+PfsapwzNTC9xOrPZITu61w==
X-Gm-Gg: ASbGncsMzoh3AHV51rZkUCaSN0wgmQhyIzNDOK7OVCGI9LbchtoXQU2l9X9xMFLfCF+
 qtjCi/JJiAxCmjVwVvaQq4S0gfCnNoeoOrTZBNfj6rxl3K1bu70uadPY6TULyNMEnGj5VPQQQOr
 OU1Qu2u0AmYi2nOto0iBEUa2BOzAvH74FVk59ZNEapkzkKjY6EYo0ODqW0YetIC7YTGzHleMMtC
 VHT67BqWUWEDXmOT5MI5j9q323v8831dZEddLNqSpUVHRLkK9VI14ABKeNWBduDz+90IkbzxaEC
 /ich9HFPuR2zVo4xX+Tfa7Hry4GuaHMwLRbaUJoyAoIDqHoDZ17tJA==
X-Google-Smtp-Source: AGHT+IE9t53tEokfudZO6DneyH/mpIjlmpdCC8RxLqATYQC3MYF0C+xEqAxksLKPMYyHN9j5IQMcqg==
X-Received: by 2002:a05:6a21:8dc7:b0:1f5:59e5:8adb with SMTP id
 adf61e73a8af0-20e94437b1emr4417803637.0.1746325812661; 
 Sat, 03 May 2025 19:30:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:51d5:9d5b:e824:396])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3c3da9dsm3138166a12.50.2025.05.03.19.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 19:30:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250503
Date: Sat,  3 May 2025 23:30:07 -0300
Message-Id: <20250504023007.3864911-1-festevam@gmail.com>
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

The following changes since commit 0c8a89d252c3db3401ffa572ee2e4dfcb94e2c3b:

  Merge patch series "k3-j784s4*: Enable ESMs and related PMIC" (2025-05-02 15:32:45 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250503

for you to fetch changes up to fbe176c39c896e3dcec356bd3153074d411d487e:

  arm64: imx: imx8mp-beacon: Enable BOOTAUX (2025-05-03 22:22:58 -0300)

u-boot-imx-master-20250503
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26064

- Add i.MX95 support.
- Enable BOOTAUX on the i.MX8M Beacon boards.
----------------------------------------------------------------
Adam Ford (3):
      arm64: imx: imx8mm-beacon: Enable BOOTAUX
      arm64: imx: imx8mn-beacon: Enable BOOTAUX
      arm64: imx: imx8mp-beacon: Enable BOOTAUX

Alice Guo (12):
      firmware: scmi: support to manage SCMI protocol drivers with a linker-genetated array
      firmware: scmi: use scmi_proto_driver_get() function to get SCMI protocol driver
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi_agent: add SCMI pin control protocol support
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      cpu: imx95: add i.MX95 support
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format
      Makefile: add some files to CLEAN_FILES

Peng Fan (4):
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code

Ye Li (5):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx: container: add V2X container support for i.MX95
      imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 +++
 arch/arm/dts/imx95-u-boot.dtsi                | 188 +++++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           | 119 +++-
 arch/arm/mach-imx/imx9/Kconfig                |  15 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           |  70 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 749 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 ++++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  69 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  38 +-
 configs/imx8mm_beacon_defconfig               |   1 +
 configs/imx8mn_beacon_defconfig               |   1 +
 configs/imx8mp_beacon_defconfig               |   1 +
 configs/imx95_19x19_evk_defconfig             | 152 ++++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 204 ++++++-
 drivers/cpu/imx8_cpu.c                        |   2 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  50 +-
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 165 ++++++
 drivers/power/domain/scmi-power-domain.c      |   8 +
 drivers/power/regulator/scmi_regulator.c      |   8 +
 drivers/reset/reset-scmi.c                    |   8 +
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |  17 +
 include/scmi_protocols.h                      | 104 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 147 ++++-
 tools/imx9_image.sh                           |   8 +
 55 files changed, 2950 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/scmi/Makefile
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock_scmi.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/container.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/imximage.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/soc.c
 create mode 100644 board/freescale/imx95_evk/Kconfig
 create mode 100644 board/freescale/imx95_evk/MAINTAINERS
 create mode 100644 board/freescale/imx95_evk/Makefile
 create mode 100644 board/freescale/imx95_evk/imx95_19x19_evk.env
 create mode 100644 board/freescale/imx95_evk/imx95_evk.c
 create mode 100644 board/freescale/imx95_evk/spl.c
 create mode 100644 configs/imx95_19x19_evk_defconfig
 create mode 100644 doc/board/nxp/imx95_evk.rst
 create mode 100644 doc/imx/imx95_container.txt
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx-scmi.c
 create mode 100644 include/configs/imx95_evk.h
 create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
 create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts
