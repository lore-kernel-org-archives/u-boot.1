Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB05CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADE383211;
	Mon, 22 Sep 2025 16:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPyzHiHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1BE83423; Mon, 22 Sep 2025 16:19:23 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3109A82CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7761578340dso5221280b3a.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550760; x=1759155560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CwazTuaRJKIYvWTgpJA/nlkPNrBwL4VO0qeBfkQBwkU=;
 b=PPyzHiHTmgSL0TBFwCTCUm/rqMrhS/CRZghPiXHLKZEPhpQOUrTg3ERc2uw8IaMu+5
 xBAiiQ5ymOG9EOtd8OfsJMHKRsuYNbohg3l4f94qaypF/OxVKA/tx7Zsf610CPABGqum
 bXQIa7fwx71TyhIfBGAgzy2F8Zxna+5JgjEmmFXc/bAs0TxTvBEv4Jr0SBe0zSLXAu/K
 63dM/ts9cAEKGFQTI+7zLJgY6hdCtstraBx1p/uJWFiqeP5FnwFsZJk9cc3TDGGvZDem
 VHtgzQx21k/A62hNM8WIzIJ3UlzjHsXxUmfxbN0maN9rGUwkaT+kvvFymrTCni3eCMQA
 EQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550760; x=1759155560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CwazTuaRJKIYvWTgpJA/nlkPNrBwL4VO0qeBfkQBwkU=;
 b=QTQ+DWpNhkQ/qfdBZStUoE8XMj3wE3AXS+4L6r7gdmWtFtci2/EAXQ4YE6m2IooCbR
 2V9R9sVRivYBMMr+q1yogoISvit+xdfeT9B45oQ/9bsAlj7fhOYuD8Cyu6W/I8a/WAPQ
 9EzJorUqELCqsOQaICKYvDt0XlVw2lPunO68uTYgZQjZZB9A04msHg2wNjBnOamYOF9O
 RC0dLHhL1rLhRM8BwhHx/xmWZ7MAbmrKlpjxmgiJ0UQgva1Rhi0fAZl7p6CC0md0OBBx
 YLT1NZ4qb70u3LzSNGwaJ+2bFSS+AEhsaL0ByKilDWPYtJ/3rz0K6f9SgQOTRexNEs0l
 uq7Q==
X-Gm-Message-State: AOJu0YxJaAmcBBj+/GQD1MgF8iJYr31+KZfk6D4/WgUYF6Pg7B51rxsB
 52aJeWRt6nbZ72grt/Vy7qeHj8ypIYvtxTSoM44Cy0BNcitYHhPty0o0F23rYg==
X-Gm-Gg: ASbGncveiFJwLj07/s/m8cGtvfwRY6GG57g3+TFoiPIxetrd7O5qM4TRQkU5Wm2IW1b
 sgD6FCy0EP9N35tb04PRgarxm9okWnfd8dFlxy0I48Z9G8LsJFPWDFMbbeDi8uZ8ZxCeQosVDbU
 oOjilVEOP0I+9tuHTs78pxgAMuQUd0MyvO0dPY1GLNPHnsOs3N/nFnhDWzpt6monRNY2TpCoYts
 rCVPG2OsiyZ1exkrcwvoF1+wd4AiG0lTv6SgQabjs0OvIrycdalZx34GEXZLKbQYQakEsNz2pQA
 iU6jh2npIXC8stxFpyP7M0RS7S2SNeUh5TdVT4TPy668r8I/Lk9AW2oTdznTcZ3NoyeDNwEDzJs
 2pdbQ/BeHHa/g2u/0LvY3Mv/fGQ7+4dlaz6yQ
X-Google-Smtp-Source: AGHT+IFcOZkuNv7ORgP4h+3xGhjbFdkJXWLBdqR7nFElok6iMRHQ6zcsJ7U7kwt8EAc53GrdqwIATw==
X-Received: by 2002:a05:6a20:939e:b0:24a:b9e:4a6c with SMTP id
 adf61e73a8af0-29274061e53mr17227596637.44.1758550759522; 
 Mon, 22 Sep 2025 07:19:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:17f3:310f:2163:7ea3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f23d92ef0sm5668935b3a.102.2025.09.22.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 07:19:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250922
Date: Mon, 22 Sep 2025 11:19:15 -0300
Message-Id: <20250922141915.208136-1-festevam@gmail.com>
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

The following changes since commit 464800d91b036cfd2df26598d8df2ac72d4569dd:

  Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next (2025-09-20 10:02:00 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250922

for you to fetch changes up to 424103865662603d821028734ecddda8802e43b3:

  doc: phytec: imx8m: Style and firmware update (2025-09-20 17:48:20 -0300)

u-boot-imx-next-20250922
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27684

- Add i.MX8 ahab-commit command.
- Add support for flashing board with UUU on imx93_frdm.
- Fix the acces of PFUZE100 regulator desc.
- Add more i.MX6 PWM clock definitions.
- Enable OP-TEE on phytec-imx8m and update documentation.
- Enable PCI host controller on iMX95 19x19 EVK.
----------------------------------------------------------------
John Ripple (1):
      imx8: Add ahab_commit command

Mathieu Dubois-Briand (1):
      imx93_frdm: Add support for flashing board with UUU

Peng Fan (1):
      power: regulator: pfuze100: Fix accessing the regulator desc

Ricardo Simoes (1):
      clk: imx6q: Add definition for missing PWM clocks

Yannic Moog (3):
      phytec-imx8m boards: enable OP-TEE for KASLR
      doc: phytec: update imx8m docs for optee builds
      doc: phytec: imx8m: Style and firmware update

Ye Li (8):
      pci: dw: Fix wrong register used for PCI_COMMAND
      pci: pcie_dw_imx: Add iMX9 support to the driver
      clk: imx: Add imx95 blkctrl clock driver
      power: regulator: Add vin-supply for GPIO and Fixed regulators
      clk: clk-uclass: Fix clk_set_default_rates issue
      arm: dts: imx95: Assign HSIOPLL_VCO as HSIOPLL parent clock
      arm: dts: imx95-evk: set alias for enetc PCI buses
      imx95_evk: Enable PCI host controller on iMX95 19x19 EVK

 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi    |   7 +
 arch/arm/dts/imx95-u-boot.dtsi              |  16 ++
 arch/arm/mach-imx/imx8/ahab.c               |  29 ++
 board/freescale/imx93_frdm/imx93_frdm.c     |   6 +
 board/freescale/imx93_frdm/imx93_frdm.env   |   8 +
 board/phytec/phycore_imx8mm/MAINTAINERS     |   1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |   5 +-
 configs/imx93_frdm_defconfig                |  14 +
 configs/imx95_19x19_evk_defconfig           |   7 +-
 configs/phycore-imx8mm_defconfig            |   5 +-
 configs/phycore-imx8mp_defconfig            |   4 +
 doc/board/nxp/imx93_frdm.rst                |  22 ++
 doc/board/phytec/imx8mm-optee-build.rsti    |  14 -
 doc/board/phytec/imx8mm-phygate-tauri-l.rst |  41 ++-
 doc/board/phytec/imx8mp-libra-fpsc.rst      |   1 -
 doc/board/phytec/phycore-imx8mm.rst         |  42 ++-
 doc/board/phytec/phycore-imx8mp.rst         |  44 +--
 drivers/clk/clk-uclass.c                    |   2 +-
 drivers/clk/imx/Kconfig                     |   9 +
 drivers/clk/imx/Makefile                    |   1 +
 drivers/clk/imx/clk-imx6q.c                 |   6 +
 drivers/clk/imx/clk-imx95-blkctrl.c         | 170 +++++++++++
 drivers/misc/imx8/scu_api.c                 |  31 ++
 drivers/pci/Kconfig                         |   2 +-
 drivers/pci/pcie_dw_common.c                |   3 +-
 drivers/pci/pcie_dw_imx.c                   | 420 +++++++++++++++++++++++++---
 drivers/power/regulator/pfuze100.c          |  44 ++-
 drivers/power/regulator/regulator_common.c  |  10 +
 drivers/power/regulator/regulator_common.h  |   1 +
 include/firmware/imx/sci/sci.h              |   6 +
 30 files changed, 824 insertions(+), 147 deletions(-)
 delete mode 100644 doc/board/phytec/imx8mm-optee-build.rsti
 create mode 100644 drivers/clk/imx/clk-imx95-blkctrl.c
