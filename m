Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598BAC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CFD8022B;
	Thu, 16 Jan 2025 15:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6ZRtRPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C8C80283; Thu, 16 Jan 2025 15:37:14 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408E6801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f32fab5de9so252543eaf.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737038231; x=1737643031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dbZpxlL2KeatXF/U2T+3ayB2do3aIUxOF/wMKnid5Yw=;
 b=c6ZRtRPJw84cOBkODmo3dWbsf28PiKWpo5XoonqeQ4vMRTPiF7M4DPTJoGHbohAFE+
 EKMWRb2c/T29rFDalCKxV84n0JFIzmZMljyI+5RVLLr9M0RdyzU1FdhxB1aOFMPe/bna
 ZgPJAIIIU+ABbqPsZvY5XTOXms7Stxir/5alZWwGi6lJRsJoS97hkYx+NLqHSm3Hcyet
 +yoXzTaDar8hnaQI43t2lK/Uh4fO/4xF161XdpvP5/0pS7bbBgKOYWiHP8ElUGIbt2E+
 H5rMFaeVzlpForUcUyFQT4SIcCm3uhhJoRWbgr3coIsGtz4yfc9G0UZghaeWtEbA9gv5
 3qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038231; x=1737643031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbZpxlL2KeatXF/U2T+3ayB2do3aIUxOF/wMKnid5Yw=;
 b=xBhD9RnU28Z1HTeQweazhdvhFjeIqvFNbk5NTcQnehM9lQsyGHnmS74D3wNnYaMdGK
 0JJCTlYjySCohCaWB+0PHUfrDQpZ/MbgBZhxNltRa3n9ZlGIpEzRY/91wHG5WOfaVLrj
 968xGw4aIT0hn6KpVOpwA9Xik98Qka7AIQk0SgqMylmnbPWxveZShDHBkHiDiwlO7Xk9
 JckoMQZrnHyUiVl/aHivIempw1pkzfWfq3fXjjIv/hnneDfQXXu8YoXhShBSNwup8K4l
 JvCoxBsUCsJM9CFqx0Lowqr18FoM5gbWktVQrxZ9ln5lQPectZyLwScroCgrMXEJdczE
 BYVQ==
X-Gm-Message-State: AOJu0Yw6Mh5ei0tgASJQE3nIU5vk2Kf5KVgIpc1C201jj4jXsXbmt5rp
 HHmKhkZimYZPdLlWxRTDsKuVaLmK3dlTwHkmJamK/7+bLWtK2t1E7jUUsA==
X-Gm-Gg: ASbGncty8t09VJk1P5axVNsJRszyQyvyua+x14BFk0fMdJb2BFB36g7c/uG2r1DZvYA
 K0UiAjA3mwLdWuPcoRhSgii18/p0rD0dgt+dX4G7nZPlTsqBy6rfKWhOaPHBekWGt5W3y73EnyA
 R2pUkNqUwwgsHoNXfo5isjvXck98obHiXK6hV4Dlld/ZFk+VN8vSaTfw+8tredYiG9HJdpj1pqs
 vxJbFD+cW8G0Et1x54v2oohEPw8mVYNYMXJDKzcNXoJK1Jor66cIAV/pCqAX+ocC3Z0cpM=
X-Google-Smtp-Source: AGHT+IFslPGrNrRno4VDtKapCiCeiJFA5+cJksMcY5mZMyUTu/5LC4AA7d5EYStq6K+Ymr9X4X1T2A==
X-Received: by 2002:a05:6871:378d:b0:29e:5df2:3e50 with SMTP id
 586e51a60fabf-2aa066d3e3dmr18529937fac.15.1737038230845; 
 Thu, 16 Jan 2025 06:37:10 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b1a4:73e9:7e6a:ebcd])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b1b8d4b3c9sm87613fac.25.2025.01.16.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:37:10 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250116
Date: Thu, 16 Jan 2025 11:37:06 -0300
Message-Id: <20250116143706.2011606-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 178f6ecb21fe12ada74a9a1a08093c812b15eea5:

  Merge patch series "bootstd: Support recording images" (2025-01-15 19:27:14 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250116

for you to fetch changes up to 985268107d4c0389d154126aa74c1d21706a7ce8:

  imx: fdt: fix cooling-device property corruption (2025-01-16 10:16:47 -0300)

u-boot-imx-master-20250116
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/24221

- Enable watchdog command on Capricorn board.
- Convert imx8m evk boards to BOOTSTD.
- Enable dynamic mmcdev setting on imx8m evk boards.
- Fix i.MX FDT cooling-device property corruption.
- Add OP-TEE support on Phycore i.MX8M boards/
----------------------------------------------------------------
Alexander Sverdlin (1):
      configs: capricorn_cxg3: Enable CMD_WDT

Peng Fan (17):
      imx: imx93_evk: switch to BOOTSTD
      imx: imx93_qsb: switch to BOOTSTD
      imx: imx91_evk: switch to BOOTSTD
      imx: imx8mp_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mp_evk: Switch to BOOTSTD
      imx: imx8mn_evk: Cleanup headers
      imx: imx8mn_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mn_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mn_evk: Switch to BOOTSTD
      imx: imx8mm_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mm_evk: Switch to BOOTSTD
      imx: imx8mq_evk: Cleanup headers
      imx: imx8mq_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mq_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mq_evk: Switch to BOOTSTD
      imx: imx93-11x11-evk: drop duplicated nodes
      gpio: adp5585: Update compatible string

Sébastien Szymanski (1):
      imx: fdt: fix cooling-device property corruption

Yannic Moog (6):
      arm: imx8m: add OP-TEE node
      phycore-imx8mp_defconfig: add optee load address
      imx8mm-phygate-tauri-l_defconfig: add optee load address
      phycore-imx8mm_defconfig: add optee load address
      doc: phytec: imx8mp: add OP-TEE documentation
      doc: phytec: imx8mm: add OP-TEE documentation

 arch/arm/dts/imx8mm-u-boot.dtsi              |  17 +++-
 arch/arm/dts/imx8mn-u-boot.dtsi              |  17 +++-
 arch/arm/dts/imx8mp-u-boot.dtsi              |  17 +++-
 arch/arm/dts/imx8mq-u-boot.dtsi              |  17 +++-
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi     | 118 ---------------------------
 arch/arm/mach-imx/fdt.c                      |   2 +-
 arch/arm/mach-imx/imx8m/Kconfig              |  19 +++++
 arch/arm/mach-imx/imx9/Kconfig               |   6 ++
 board/freescale/common/Makefile              |   2 +-
 board/freescale/imx8mm_evk/imx8mm_evk.c      |   3 +
 board/freescale/imx8mm_evk/imx8mm_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c      |  12 +--
 board/freescale/imx8mn_evk/imx8mn_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c      |   5 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env    |  57 +++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c      |  29 ++-----
 board/freescale/imx8mq_evk/imx8mq_evk.env    |  60 ++++++++++++++
 board/freescale/imx91_evk/imx91_evk.env      |  29 ++++++-
 board/freescale/imx93_evk/imx93_evk.env      |  88 ++++++++++++++++++++
 board/freescale/imx93_qsb/imx93_qsb.env      |  29 ++++++-
 board/phytec/phycore_imx8mm/MAINTAINERS      |   1 +
 configs/capricorn_cxg3_defconfig             |   1 +
 configs/imx8mm-phygate-tauri-l_defconfig     |   1 +
 configs/imx8mm_evk_defconfig                 |   3 +-
 configs/imx8mm_evk_fspi_defconfig            |   4 +-
 configs/imx8mn_evk_defconfig                 |   2 +-
 configs/imx8mp_evk_defconfig                 |   2 +-
 configs/imx8mq_evk_defconfig                 |   3 +-
 configs/imx91_11x11_evk_defconfig            |   3 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |   3 +-
 configs/imx93_11x11_evk_defconfig            |   2 +-
 configs/imx93_9x9_qsb_defconfig              |   3 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig   |   3 +-
 configs/phycore-imx8mm_defconfig             |   1 +
 configs/phycore-imx8mp_defconfig             |   1 +
 doc/board/phytec/imx8mm-optee-build.rsti     |  14 ++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst  |   9 +-
 doc/board/phytec/phycore-imx8mm.rst          |   8 +-
 doc/board/phytec/phycore-imx8mp.rst          |  20 ++++-
 drivers/gpio/adp5585_gpio.c                  |   2 +-
 include/configs/imx8mm_evk.h                 |  22 -----
 include/configs/imx8mn_evk.h                 |  30 -------
 include/configs/imx8mp_evk.h                 |  21 -----
 include/configs/imx8mq_evk.h                 |  22 -----
 include/configs/imx93_evk.h                  | 105 ------------------------
 45 files changed, 573 insertions(+), 374 deletions(-)
 create mode 100644 board/freescale/imx8mm_evk/imx8mm_evk.env
 create mode 100644 board/freescale/imx8mn_evk/imx8mn_evk.env
 create mode 100644 board/freescale/imx8mp_evk/imx8mp_evk.env
 create mode 100644 board/freescale/imx8mq_evk/imx8mq_evk.env
 create mode 100644 board/freescale/imx93_evk/imx93_evk.env
 create mode 100644 doc/board/phytec/imx8mm-optee-build.rsti
