Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC94FC46CA3
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01FD5877FF;
	Mon,  4 Dec 2023 09:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbyYVHH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C89687812; Mon,  4 Dec 2023 09:21:08 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F61687561
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50be3eed85aso2362921e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678065; x=1702282865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yd/gvuADHKkSYhqiTvYTIgyJEQCcW6AJKR1Th0pRVYA=;
 b=fbyYVHH/Ek9AYjTmjrBZWM/Qpqn06RxRAMkK/EUts9RGDgWEmvv9cbassUcHxnfWbX
 hEwhJoN4vrV+zyyw6x2FWfKlBp6xXYmZFNuXSSFt0mS0DeLhnpTwAHjcRwNxMB8u1RRA
 6kITm6/hcrSMpptHPHcGngWx7FCpAnHfU58zofu8YjBEKkkZcmqqfDpUUOm8ZwZOTx6W
 G9hucUGINyddoXYiNbtukHMjByqZ59m4nvSBij9ftjUWDZmhsNwa9z3+lvAgnwTAFvDF
 ExCSl7M6kL8fZ/0ZY0vDBJ1xpmhTuAYHilScLG/A96Votbz/YCap+JopmgBKHr6N0cx5
 M6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678065; x=1702282865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yd/gvuADHKkSYhqiTvYTIgyJEQCcW6AJKR1Th0pRVYA=;
 b=k04rf1Al5YKU09rmD06DcywgC8hKKVOs5aL8gfSRGjmTzggOhNI/Yk0evrT1f3vqEj
 PZx+RFW1tnPFFXVyRbEPfGfztlVLLMbI63QWz3TH6ide3dwRCcUpkXK0R6iV/x+8AXXG
 5tgYdHt6j+VAE0w/VDA0DxTgeL1zzyVSV7Ozrx3LNWz2G1Yv+khXS9sYVNVzjvl6pfIR
 RfTCYgWG3GW87OQ9RWFd2nytHbiTEx2GMgp5Fd22DLbwTmLBJAunzTss/yQlNFHUsN7e
 7ZSFrro9vaeEG8Qe+CBuPRo/hXSiS8YicFWfuQ9nvFX+auwkr31IzIDdgkdWoDkolm3Y
 bZuQ==
X-Gm-Message-State: AOJu0YyL6OiVRlptgzUIt3/IRMTq+fy34Wq2wn64t432xhLvtaNPSEP/
 9mvflsdPsxzgqCm2jGcAVFY=
X-Google-Smtp-Source: AGHT+IHHlNHpaJdDYpMzxzNECerpFUz4xDwuIDcXXO5zrJ176ctmVYPCQC4u9+WzefABwQ1J/ZvNsg==
X-Received: by 2002:a05:6512:2c95:b0:50b:ccc1:2028 with SMTP id
 dw21-20020a0565122c9500b0050bccc12028mr3166461lfb.51.1701678065449; 
 Mon, 04 Dec 2023 00:21:05 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/8] Convert Tegra pinctrl to DM
Date: Mon,  4 Dec 2023 10:20:46 +0200
Message-Id: <20231204082054.4943-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Create a DM supported wrapper arround existing Tegra pinmux logic.
This implementation is backwards compatible with all existing board
setups and early stages of setup. All new boards must be device tree
based. Linux dts pinmux nodes are fully compatible with this driver.

As an example I have converted recently merged T30 boards to this
layout (I have those devices and was able to test them properly) and
Paz00 T20 board which was tested as well by owner.

Svyatoslav Ryhel (8):
  ARM: mach-tegra: rearrange SPL configs
  drivers: pinctrl: create Tegra DM pinctrl driver
  drivers: pinctrl: tegra: incorporate existing code
  board: asus: grouper: switch to DM pinmux
  board: lg: x3-t30: switch to DM pinmux
  board: asus: transformer: switch to DM pinmux
  board: htc: endeavoru: switch to DM pinmux
  board: compal: paz00: clean up the board

 arch/arm/dts/tegra20-paz00.dts                |    4 +-
 arch/arm/dts/tegra30-asus-grouper-common.dtsi |  712 ++++++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  113 ++
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  113 ++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  149 +++
 arch/arm/dts/tegra30-asus-p1801-t.dts         |  982 ++++++++++++++
 arch/arm/dts/tegra30-asus-tf201.dts           |   45 +
 arch/arm/dts/tegra30-asus-tf300t.dts          |   45 +
 arch/arm/dts/tegra30-asus-tf300tg.dts         |  128 ++
 arch/arm/dts/tegra30-asus-tf300tl.dts         |  163 +++
 arch/arm/dts/tegra30-asus-tf600t.dts          |  889 +++++++++++++
 arch/arm/dts/tegra30-asus-tf700t.dts          |   53 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    |  984 ++++++++++++++
 arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 +++++++++++++++++
 arch/arm/dts/tegra30-lg-p880.dts              |   90 ++
 arch/arm/dts/tegra30-lg-p895.dts              |   93 ++
 arch/arm/dts/tegra30-lg-x3.dtsi               |  845 ++++++++++++
 arch/arm/include/asm/arch-tegra114/pinmux.h   |  303 +++++
 arch/arm/include/asm/arch-tegra124/pinmux.h   |  327 +++++
 arch/arm/include/asm/arch-tegra20/pinmux.h    |  291 +++++
 arch/arm/include/asm/arch-tegra210/pinmux.h   |  394 ++++++
 arch/arm/include/asm/arch-tegra30/pinmux.h    |  381 ++++++
 arch/arm/mach-tegra/Kconfig                   |   16 +-
 arch/arm/mach-tegra/Makefile                  |    1 -
 arch/arm/mach-tegra/board.c                   |    6 +-
 arch/arm/mach-tegra/board2.c                  |    2 +-
 arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
 arch/arm/mach-tegra/tegra124/Makefile         |    2 -
 arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
 arch/arm/mach-tegra/tegra210/Makefile         |    1 -
 arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
 board/asus/grouper/grouper.c                  |   18 -
 board/asus/grouper/pinmux-config-grouper.h    |  362 ------
 .../pinmux-config-transformer.h               |  365 ------
 board/asus/transformer-t30/transformer-t30.c  |   23 -
 board/compal/paz00/Makefile                   |    8 -
 board/compal/paz00/paz00.c                    |   53 -
 board/htc/endeavoru/endeavoru.c               |   14 -
 board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
 board/lg/x3-t30/Kconfig                       |   12 -
 board/lg/x3-t30/configs/p880.config           |    1 -
 board/lg/x3-t30/configs/p895.config           |    1 -
 board/lg/x3-t30/pinmux-config-x3.h            |  449 -------
 board/lg/x3-t30/x3-t30.c                      |   23 -
 configs/paz00_defconfig                       |    3 +
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/tegra/Kconfig                 |   18 +
 drivers/pinctrl/tegra/Makefile                |   16 +
 .../pinctrl/tegra/funcmux-tegra114.c          |    0
 .../pinctrl/tegra/funcmux-tegra124.c          |    0
 .../pinctrl/tegra/funcmux-tegra20.c           |    0
 .../pinctrl/tegra/funcmux-tegra210.c          |    0
 .../pinctrl/tegra/funcmux-tegra30.c           |    0
 drivers/pinctrl/tegra/pinctrl-tegra.c         |  248 ++++
 drivers/pinctrl/tegra/pinctrl-tegra20.c       |  177 +++
 .../pinctrl/tegra}/pinmux-common.c            |    0
 .../pinctrl/tegra/pinmux-tegra114.c           |    0
 .../pinctrl/tegra/pinmux-tegra124.c           |    0
 .../pinctrl/tegra/pinmux-tegra20.c            |    0
 drivers/pinctrl/tegra/pinmux-tegra210.c       |  190 +++
 .../pinctrl/tegra/pinmux-tegra30.c            |    0
 include/configs/x3-t30.h                      |   13 +-
 63 files changed, 8920 insertions(+), 1723 deletions(-)
 delete mode 100644 board/asus/grouper/pinmux-config-grouper.h
 delete mode 100644 board/asus/transformer-t30/pinmux-config-transformer.h
 delete mode 100644 board/compal/paz00/Makefile
 delete mode 100644 board/compal/paz00/paz00.c
 delete mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h
 delete mode 100644 board/lg/x3-t30/pinmux-config-x3.h
 create mode 100644 drivers/pinctrl/tegra/Kconfig
 create mode 100644 drivers/pinctrl/tegra/Makefile
 rename arch/arm/mach-tegra/tegra114/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra20.c (100%)
 rename arch/arm/mach-tegra/tegra210/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra210.c (100%)
 rename arch/arm/mach-tegra/tegra30/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra30.c (100%)
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra.c
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra20.c
 rename {arch/arm/mach-tegra => drivers/pinctrl/tegra}/pinmux-common.c (100%)
 rename arch/arm/mach-tegra/tegra114/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra20.c (100%)
 create mode 100644 drivers/pinctrl/tegra/pinmux-tegra210.c
 rename arch/arm/mach-tegra/tegra30/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra30.c (100%)

-- 
2.40.1

