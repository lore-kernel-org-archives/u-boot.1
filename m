Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB8DCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8260988875;
	Mon,  2 Sep 2024 19:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nM5STP06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 267FD8876E; Mon,  2 Sep 2024 19:41:27 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C9E88C01
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7141feed424so3467433b3a.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725298882; x=1725903682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CwAx2NQ/1QrMaYKmpQRxNHFY+mU+ilMmEi4L79M4Ykk=;
 b=nM5STP06b+Jc5Klcvm4OWim8Xl5H0mWEmYg5AgCqNdKsRlKbL6j5R+iFUaw5Emp/uv
 9GgrGR6HWhRBAjZ95WeFZbm8ZaOM4a13W2ioN3RP7Tbdg+9P8bN12de+R/Tv78PKQYod
 Ca84GzDCWvh8zLzfWLWI9CPJ77ozaMzjSnQMaH1/LJScjrkg+gTd/qH3uNTqOwpXgOFT
 41kXb7RxtszWp8irVDxeDyfxpby+XnmmgeYRpRkW877wZfW+TlIKVRPN2Krb3ovmvc7F
 Kt3SLqoUbrJrp4kk6gfOl1IePs+WPdxnuZDgZgtwF8H6iSXEsOSwL4uD0AB9le/Jkfcz
 nRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725298882; x=1725903682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CwAx2NQ/1QrMaYKmpQRxNHFY+mU+ilMmEi4L79M4Ykk=;
 b=Lxb1gK/GILyEU995AxlZDY0h4ajUZPTf56gHJh3yu5+a+PnJxRwC5ZncyyGNUcuCYB
 XKeATikl3oqP0nrO34zvXkvmdtokFPNPInN4PeCC+Pog5WvQCmpmshVQWmfmeJ3oQfAZ
 tUGJROIgisg5/l1ksmAZ4RSWT45COtMdAWpppEhzZgI5RrlVZjgBkZeddUbSm1ZMrXS4
 Dm0q16/GQ6x8wwrejEgp4EJBNPScbPhIQsN5DfBrN+Ba2XqxI0r2iVVgOKGlsfjNl837
 +DTdNq4Xb7i50SjtaUuBlP9S8Wb6J6RAnLgcP3mbcgz9ZHsD2NGsQdHSqIM6nOe67URH
 Qdag==
X-Gm-Message-State: AOJu0YwH9sT4br/FlHGPogEsxjB+iSBighho2N5Qp6nhZ/uAcb2C3Gmo
 ry3CtidMLjVSpAON71nmj4BHvS/smsSY2fjatwl7bcidtRh+nYHOtQLEVw==
X-Google-Smtp-Source: AGHT+IGb0Vb6M8zzdWuAOr7LvE42gFTQzrPibRbk8K9IpdXZKR0boM8rw3C1lx8HNCGCO/dVlVQxRw==
X-Received: by 2002:a05:6a00:8c6:b0:706:b10c:548a with SMTP id
 d2e1a72fcca58-7173faecd26mr5906927b3a.22.1725298882127; 
 Mon, 02 Sep 2024 10:41:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9956:477a:b751:c148])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e5576d7bsm7107098b3a.30.2024.09.02.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 10:41:21 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240902
Date: Mon,  2 Sep 2024 14:41:18 -0300
Message-Id: <20240902174118.908571-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit e83ced1a24095de66e526bd6c10f0f24584baaee:

  bootstage: Fix unstash of records from SPL (2024-08-28 10:07:59 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240902

for you to fetch changes up to d1349097222b5a3264f614b3e4fe672e0df26435:

  ARM: imx: Wrap i.MX config options in MACH_IMX (2024-09-02 13:23:36 -0300)

u-boot-imx-next-20240902
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22211

- Enable SPI NOR flash support and MTD partitions for phycore_imx8mp.
- Convert mx6slevk to OF_UPSTREAM and watchdog DM.
- Cleanup some mx5/mx6 USB options.
- Make PLL settings configurable at board level.
- Set CONFIG_SPL_LOAD_FIT_ADDRESS for verdin-imx8m/p.
- Make the mxc-gpio reading state of GPIO pins in output mode to be consistent
with the Linux kernel.
- Add HUK derivation support for ELE AHAB.
----------------------------------------------------------------
Benjamin Hahn (2):
      configs: phycore-imx8mp_defconfig: Enable SPI NOR flash support
      board: phytec: phycore_imx8mp: Add mtd spi partitions

Fabio Estevam (8):
      mx6slevk: Convert to watchdog driver model
      mx6slevk: Fix the boot device number
      mx6slevk: Keep a single defconfig
      mx6slevk: Convert to OF_UPSTREAM
      imx: Remove CFG_MXC_USB_FLAGS
      usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
      mx5: Remove CFG_MXC_USB_PORT
      imx: Remove CFG_MXC_USB_PORTSC

Marek Vasut (2):
      ARM: imx: Make PLL settings configurable at board level
      ARM: imx: Wrap i.MX config options in MACH_IMX

Mathieu Othacehe (1):
      imx: ele_ahab: Add HUK derivation support

Rogerio Guerra Borin (1):
      configs: verdin-imx8m[mp]: set CONFIG_SPL_LOAD_FIT_ADDRESS

Tomas Paukrt (1):
      gpio: mxc_gpio: fix reading state of GPIO pins in output mode

 arch/arm/dts/imx6sl-evk.dts                    |  658 ---------------
 arch/arm/dts/imx6sl-pinfunc.h                  | 1073 ------------------------
 arch/arm/dts/imx6sl.dtsi                       | 1005 ----------------------
 arch/arm/include/asm/mach-imx/ele_api.h        |    2 +
 arch/arm/mach-imx/Kconfig                      |    4 +
 arch/arm/mach-imx/ele_ahab.c                   |   31 +
 arch/arm/mach-imx/imx8m/clock_imx8mm.c         |   11 +-
 arch/arm/mach-imx/mx6/Kconfig                  |    1 +
 board/phytec/phycore_imx8mp/phycore-imx8mp.c   |   34 +
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |    4 +
 configs/mx6slevk_defconfig                     |    7 +-
 configs/mx6slevk_spinor_defconfig              |   71 --
 configs/mx6slevk_spl_defconfig                 |   88 --
 configs/phycore-imx8mp_defconfig               |   24 +
 configs/verdin-imx8mm_defconfig                |    1 +
 configs/verdin-imx8mp_defconfig                |    1 +
 drivers/gpio/mxc_gpio.c                        |   10 +-
 drivers/misc/imx_ele/ele_api.c                 |   77 ++
 drivers/usb/host/ehci-mx5.c                    |    4 +
 include/configs/apalis_imx6.h                  |    5 -
 include/configs/aristainetos2.h                |    4 -
 include/configs/brppt2.h                       |    3 -
 include/configs/cl-som-imx7.h                  |    4 -
 include/configs/cm_fx6.h                       |    4 -
 include/configs/colibri-imx6ull.h              |    5 -
 include/configs/colibri_imx6.h                 |    5 -
 include/configs/colibri_imx7.h                 |    5 -
 include/configs/dart_6ul.h                     |    4 -
 include/configs/dh_imx6.h                      |    4 -
 include/configs/display5.h                     |    1 -
 include/configs/embestmx6boards.h              |    4 -
 include/configs/ge_b1x5v2.h                    |    4 -
 include/configs/gw_ventana.h                   |    4 -
 include/configs/imx6_logic.h                   |    6 -
 include/configs/imx6dl-mamoj.h                 |    4 -
 include/configs/imx6q-bosch-acc.h              |    2 -
 include/configs/imx7-cm.h                      |    3 -
 include/configs/imx8mm-cl-iot-gate.h           |    3 -
 include/configs/kontron-sl-mx6ul.h             |    5 -
 include/configs/kontron-sl-mx8mm.h             |    5 -
 include/configs/kp_imx53.h                     |    1 -
 include/configs/kp_imx6q_tpc.h                 |    6 -
 include/configs/liteboard.h                    |    6 -
 include/configs/m53menlo.h                     |    2 -
 include/configs/meerkat96.h                    |    3 -
 include/configs/mx51evk.h                      |    1 -
 include/configs/mx53cx9020.h                   |    2 -
 include/configs/mx53loco.h                     |    2 -
 include/configs/mx53ppd.h                      |    2 -
 include/configs/mx6cuboxi.h                    |    3 -
 include/configs/mx6memcal.h                    |    1 -
 include/configs/mx6sabreauto.h                 |    4 -
 include/configs/mx6sabresd.h                   |    6 -
 include/configs/mx6slevk.h                     |   10 +-
 include/configs/mx6sllevk.h                    |    5 -
 include/configs/mx6sxsabreauto.h               |    5 -
 include/configs/mx6sxsabresd.h                 |    5 -
 include/configs/mx6ul_14x14_evk.h              |    6 -
 include/configs/mx7dsabresd.h                  |    3 -
 include/configs/mx7ulp_com.h                   |    1 -
 include/configs/mys_6ulx.h                     |    4 -
 include/configs/nitrogen6x.h                   |    4 -
 include/configs/novena.h                       |    6 -
 include/configs/npi_imx6ull.h                  |    4 -
 include/configs/o4-imx6ull-nano.h              |    4 -
 include/configs/opos6uldev.h                   |    6 -
 include/configs/pcl063.h                       |    4 -
 include/configs/pcl063_ull.h                   |    4 -
 include/configs/pico-imx6.h                    |    4 -
 include/configs/pico-imx6ul.h                  |    4 -
 include/configs/pico-imx7d.h                   |    4 -
 include/configs/somlabs_visionsom_6ull.h       |    6 -
 include/configs/tbs2910.h                      |    5 -
 include/configs/tqma6.h                        |    3 -
 include/configs/usbarmory.h                    |    2 -
 include/configs/verdin-imx8mm.h                |    3 -
 include/configs/vining_2000.h                  |    2 -
 include/configs/wandboard.h                    |    4 -
 include/configs/warp7.h                        |    1 -
 include/configs/xpress.h                       |    4 -
 80 files changed, 208 insertions(+), 3134 deletions(-)
 delete mode 100644 arch/arm/dts/imx6sl-evk.dts
 delete mode 100644 arch/arm/dts/imx6sl-pinfunc.h
 delete mode 100644 arch/arm/dts/imx6sl.dtsi
 delete mode 100644 configs/mx6slevk_spinor_defconfig
 delete mode 100644 configs/mx6slevk_spl_defconfig
