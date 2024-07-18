Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7759BC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 04:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABDF8870E;
	Thu, 18 Jul 2024 06:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gcf4OAC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753E388AE8; Thu, 18 Jul 2024 06:33:56 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E96B882F0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d94293f12fso240654b6e.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721277232; x=1721882032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fRMjEsvqN9W4Vg1EMV3ABerDW+2fG1BxbTV+vtJOuvA=;
 b=Gcf4OAC4vbBLSz1Ffev+Agd3g4BM3KY0f31znWazxuEecVQeQXD8h8A5i/Iafg/m3W
 G2dewEtN+xTsMK0Q2vHxzpNi1aZpFag5ZM+1slwaI488ngsVkxmMe+1I0C6PAYEA5Sfl
 ABvGBXxD4kHoEablwT6En4M0oxrXpigF9DIyGqSZknN0p41XLOK1yWJiD64sJBo5y8Xu
 Cl89Vohd8fCy2/Vok3LiuskdtpNrym3xYmTbDxCsxz6bQCzD5DB6+dY59EhN+WVIHV4S
 dpMBP0LTVNcMMHqU5y0zXO9T/M2gEapQJBoLp/OwsGuA7Y+pck8EMPYO51IPAvJw2pSL
 THjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721277232; x=1721882032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRMjEsvqN9W4Vg1EMV3ABerDW+2fG1BxbTV+vtJOuvA=;
 b=rXYcpLqyUd4NeF3rb3m0pjBL13daAzPbcfAnVOhDe1KcbF9thdERhfQe6Tx6oPJ+8h
 HhdkrbAVhG/DTveWgx8E5srT7UBatScoaI6GNLPc8Fy3/cAvw+tVPvjW5yLnzrgt1OnI
 Ul3Sc2IVW6Ydp3pqNEC6FdwUsfxb82oF9qbgVC2gdbhZ+fseSeJKdB2/tJQ8qAeJ5px3
 1BIMmA4/l3z1Z2HXfovZuxO7n9LwPDtEpDuLu+mmmiDtIX6yBPHZ5HokbdrHknS1Rocu
 2+AB7nWYcBvv8uVCaOAl+AzZSE5+2iANW+FeqVWPKvNEoW35ceKoU8B1KDpFVNc5vTfh
 iJwQ==
X-Gm-Message-State: AOJu0YyccgL3Wj5xs63DqlZzV6xzPCYkAzGePYPNj03EPgQdNX/UtooB
 Z5TT+eUab2Eja2594pIr+JO0bURjxRrGTcUl0JL1QKaMy1cQLYJDKZQygVjBKVk=
X-Google-Smtp-Source: AGHT+IFggWKokAvpLfTXc/F2PJI/wCkvobn0/JNolEiinKjGmrz7b7bl99PGnrvifwmIK1yZVo88jA==
X-Received: by 2002:a05:6808:2128:b0:3d9:244b:b9d3 with SMTP id
 5614622812f47-3dad7721c93mr1712655b6e.23.1721277232220; 
 Wed, 17 Jul 2024 21:33:52 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd309csm8965354b3a.216.2024.07.17.21.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 21:33:51 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 0/2] riscv: spacemit: bananapi_f3: add support for Banana
 Pi F3 board
Date: Thu, 18 Jul 2024 12:33:21 +0800
Message-ID: <20240718043329.1500-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Banana Pi F3 board is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x USB
3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.

This patch introduces fundamental support for the Banana Pi F3 board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.

Changes in v2:
- Change license to GPL-2.0-or-later
- Add memory node for dts
- Add ft_board_setup function for kernel memory init
- Use default prompt

Kongyang Liu (2):
  riscv: spacemit: bananapi_f3: initial support added
  doc: spacemit: bananapi_f3: document Banana Pi F3 board

 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  54 ++++
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 375 +++++++++++++++++++++++++
 board/spacemit/bananapi_f3/Kconfig     |  25 ++
 board/spacemit/bananapi_f3/MAINTAINERS |   6 +
 board/spacemit/bananapi_f3/Makefile    |   5 +
 board/spacemit/bananapi_f3/board.c     |   9 +
 configs/bananapi_f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi_f3.rst     |  78 +++++
 doc/board/spacemit/index.rst           |   8 +
 include/configs/bananapi_f3.h          |  15 +
 17 files changed, 660 insertions(+)
 create mode 100644 arch/riscv/cpu/k1/Kconfig
 create mode 100644 arch/riscv/cpu/k1/Makefile
 create mode 100644 arch/riscv/cpu/k1/cpu.c
 create mode 100644 arch/riscv/cpu/k1/dram.c
 create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1.dtsi
 create mode 100644 board/spacemit/bananapi_f3/Kconfig
 create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
 create mode 100644 board/spacemit/bananapi_f3/Makefile
 create mode 100644 board/spacemit/bananapi_f3/board.c
 create mode 100644 configs/bananapi_f3_defconfig
 create mode 100644 doc/board/spacemit/bananapi_f3.rst
 create mode 100644 doc/board/spacemit/index.rst
 create mode 100644 include/configs/bananapi_f3.h

-- 
2.41.0

