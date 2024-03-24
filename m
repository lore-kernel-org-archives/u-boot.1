Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12133C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 17:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137D387D40;
	Sun, 24 Mar 2024 18:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2LtErU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04310879E0; Sun, 24 Mar 2024 18:53:18 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C9287519
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 18:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1def81ee762so4328795ad.0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711302794; x=1711907594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=leWQUzYjUrQwqERz9vyKVJKtzcvp8OsyviAMUUQ2qT0=;
 b=F2LtErU7ezmSOlP5ejcYfq66BVwHPq82Qd1GpedKx8fBdFx6/Lg9L3oB5i/PuiZo9C
 0Id5XRWf1e0e/iV0HEQaXzTw124fLkER+qSs52+o6aykKKyLfS7cjIEZlLvGm3FeA/i9
 2esgM4RcGSxagvpCfa8oOu4D22BFVuWT73S8AKUupNBLJViSy5GFSTiqDQd/Mwqvxry9
 z9fZ8aOKNXhbVbSrJMMFVO9hiJAEikR3j2El3CZfFlhrn2FSuUsITnCDQC0lisjkb45n
 JOmKOwrxP7lYaIPt7t/r1S81hX9/q93expKBqBW6HkWrMLTFRONsNzb1r9FJDAdQR9Po
 GLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711302794; x=1711907594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=leWQUzYjUrQwqERz9vyKVJKtzcvp8OsyviAMUUQ2qT0=;
 b=tk0mWSDBm5wp4ADmlebJsHxg3LJH5T1TxCzSYN8eIuX3hlnRR8GNbGlTOhH2ew9na7
 5tgR+T7lTKBKP2tVE/FbuKkEof64x/tJyx+p8k/c9GI1fJufqQtCkn39qf1vw4tiC4yD
 C7Yfai7da0oOkht4aIGtUezun5W59jTqyKXy2UKJtfuYZjq1jMFI6Tb8Ywq/jzul1RD4
 HovTgEiEohp8mao/EO3jNe/oGnI5s7nTp0ZBLHxIGsSJg8mr++xIZyR3FO7lM0huREGe
 4mgrIJVgdVoD7r7GzqDTqa/xUgzzkU08+pz3RyltGppr2pR1mB+/sca9lIHzLIl575Qk
 gN/Q==
X-Gm-Message-State: AOJu0YzYMF6FnoTpfhKcZyAccZPtbxxXq2z+e7yOAzVLEqjLU1S9OvBZ
 MQach6jnj1p5fwdLRmvFdeT/w17OeMxecV9oy+yAYMJh2LatzjjsB9LH0mcA
X-Google-Smtp-Source: AGHT+IE74SV7iQbKBt5uoLAgTFcqXKQI+sLxvzdT6x9gzctLgJFlIO7m1wniKSAXHtyQREnxtBHtVA==
X-Received: by 2002:a17:902:b70e:b0:1db:ce31:96b1 with SMTP id
 d14-20020a170902b70e00b001dbce3196b1mr6279601pls.6.1711302793790; 
 Sun, 24 Mar 2024 10:53:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:cbca:37f7:5684:5700])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a170903124e00b001e004924412sm3270598plh.108.2024.03.24.10.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 10:53:13 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240324
Date: Sun, 24 Mar 2024 14:53:08 -0300
Message-Id: <20240324175308.1612688-1-festevam@gmail.com>
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

Please pull this material for next from u-boot-imx, thanks.

The following changes since commit fb49d6c289d942ff7de309a5c5eaa37a7f4235db:

  remoteproc: uclass: Add methods to load firmware to rproc and boot rproc (2024-03-22 15:50:28 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240324

for you to fetch changes up to 9d27e441bb14dd526c60c13d5ff16353ca322eb3:

  board: phytec: phycore_imx8mp.env fix netboot issues (2024-03-24 13:42:10 -0300)

u-boot-imx-next-20240324
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20056

- Add ahab_commit command support.
- Add USB support for the imx93-phyboard-segin board.
- Add i.MX8MP PCIe support.
- Fix netboot environment on phycore_imx8mp.
----------------------------------------------------------------
Mathieu Othacehe (4):
      imx: ele_ahab: Add ahab_commit command support
      arm: dts: imx93-phyboard-segin: Add USB support
      configs: imx93-phyboard-segin: Add USB support
      configs: imx93-phyboard-segin: Add fastboot support

Sumit Garg (10):
      clk: imx8mp: Add support for PCIe clocks
      reset: imx: Refactor driver to simplify function names
      reset: imx: Add support for i.MX8MP reset controller
      imx8mp: power-domain: Add PCIe support
      imx8mp: power-domain: Expose high performance PLL clock
      phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
      pci: Add DW PCIe controller support for iMX8MP SoC
      pcie_imx: Update header to describe it as a legacy driver
      verdin-imx8mp_defconfig: Enable PCIe/NVMe support
      MAINTAINERS: Add entry for PCIe DWC IMX driver

Tim Harvey (1):
      imx8mp_venice_defconfig: Enable PCIe/NVMe support

Yannic Moog (1):
      board: phytec: phycore_imx8mp.env fix netboot issues

 MAINTAINERS                                    |   6 +
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi  |  15 ++
 arch/arm/include/asm/mach-imx/ele_api.h        |   2 +
 arch/arm/mach-imx/ele_ahab.c                   |  29 +++
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |   4 +-
 configs/imx8mp_venice_defconfig                |   8 +
 configs/imx93-phyboard-segin_defconfig         |  14 +
 configs/verdin-imx8mp_defconfig                |   6 +
 drivers/clk/imx/clk-imx8mp.c                   |   6 +
 drivers/misc/imx_ele/ele_api.c                 |  32 +++
 drivers/pci/Kconfig                            |  11 +
 drivers/pci/Makefile                           |   1 +
 drivers/pci/pcie_dw_imx.c                      | 338 +++++++++++++++++++++++++
 drivers/pci/pcie_imx.c                         |   8 +
 drivers/phy/Kconfig                            |  11 +
 drivers/phy/Makefile                           |   1 +
 drivers/phy/phy-imx8m-pcie.c                   | 283 +++++++++++++++++++++
 drivers/power/domain/imx8mp-hsiomix.c          | 190 +++++++++++---
 drivers/reset/reset-imx7.c                     | 143 +++++++++--
 19 files changed, 1049 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_imx.c
 create mode 100644 drivers/phy/phy-imx8m-pcie.c
