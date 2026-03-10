Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EF5EB1054
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505C98400F;
	Tue, 10 Mar 2026 15:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="TsdlxKE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7A184013; Tue, 10 Mar 2026 15:13:13 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF17883FE9
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id A2E7C60136;
 Tue, 10 Mar 2026 15:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773151990;
 bh=zdpCaiwXGIRIh0q6l7PwNRvzyHHQzXYun9ePfJjHj84=;
 h=From:To:Cc:Subject:Date:From;
 b=TsdlxKE7TVQ7Ye0sGh4JnOk0O77lWYX8IAl6qSWpElTKGPCZxvYw4UI0nU1MdxG7M
 YDLJX1halfPiX8JOy9cZeLbRnR8FJ81O3syxML5iaGu3gaJ9QCJ4p8Am8e1PGvltWT
 TXGRJ6EqrJMQwDqrqJLKdfC+/vGgp6fnMZ5H3YqrqlnK94vuBs2rYmOMFXeXE1yo/a
 bw6HPT+PWAUJWwJyRDwE2gODRbkNPv1FO8FAxIcp+MN9BN8ml0em2grXLRp7lNtnMy
 fsoaOQUj5P5QHXbMvAS8GnQqeSG93t+Mf08hAqo5drCIziM/dFdoaJuZeRoG2CFHtQ
 MZlqadkfqf1XA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 vjardin@free.fr
Subject: [PATCH v1 0/5] Add support for Freebox Nodebox 10G (Armada 8040)
Date: Tue, 10 Mar 2026 15:12:47 +0100
Message-ID: <cover.1773151972.git.vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

This series adds board support for the Freebox Nodebox 10G, a network
appliance based on the Marvell Armada 8040 SoC (AP806 + dual CP110).

The series is structured as follows:

Patch 1 adds CPU and clock information display for Armada 8K platforms
by reading the AP806 Sample-At-Reset register. This is ported from
Marvell's vendor U-Boot 2015.01.

Patch 2 adds the board directory, device tree, defconfig, and board
initialization (management PHY reset via GPIO).

Patch 3 adds a U-Boot dtsi overlay for conditional OP-TEE support.

Patch 4 adds the "emmcboot" command to load and boot firmware stored
in the board-specific image format (mvebu_image_tag) at fixed eMMC
offsets. Each image bundles a kernel and device tree under a CRC32-
validated tag header. Two image banks are supported with automatic
fallback based on a bit-field reboot counter.

Patch 5 adds the "fbxserial" command to read factory-programmed device
serial numbers and MAC addresses from a dedicated eMMC region. The
board file hooks EVT_SETTINGS_R to set MAC addresses before network
drivers probe.

Note: the emmcboot and fbxserial commands are hardware-specific and
require the actual board for testing, so no sandbox tests are included.

Based on v2026.04-rc4.

Vincent Jardin (5):
  arm: mach-mvebu: armada8k: add CPU and clock info display
  board: freebox: add Nodebox 10G board support
  arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE
  cmd: mvebu: add emmcboot for Nodebox image format
  cmd: mvebu: add device serial and MAC address initialization

 arch/arm/dts/Makefile                    |   1 +
 arch/arm/dts/armada-8040-nbx-u-boot.dtsi |  15 +
 arch/arm/dts/armada-8040-nbx.dts         | 259 +++++++++++++++++
 arch/arm/mach-mvebu/Kconfig              |   9 +
 arch/arm/mach-mvebu/armada8k/Makefile    |   2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c       |  10 +
 arch/arm/mach-mvebu/armada8k/soc_info.c  | 192 +++++++++++++
 arch/arm/mach-mvebu/armada8k/soc_info.h  |  14 +
 board/freebox/nbx10g/Kconfig             |  12 +
 board/freebox/nbx10g/MAINTAINERS         |  13 +
 board/freebox/nbx10g/Makefile            |   3 +
 board/freebox/nbx10g/board.c             |  79 ++++++
 cmd/mvebu/Kconfig                        |  80 ++++++
 cmd/mvebu/Makefile                       |   2 +
 cmd/mvebu/mvebu_emmcboot.c               | 340 +++++++++++++++++++++++
 cmd/mvebu/nbx_fbxserial.c                | 289 +++++++++++++++++++
 configs/mvebu_nbx_88f8040_defconfig      |  76 +++++
 include/configs/nbx10g.h                 |  29 ++
 include/mvebu_imagetag.h                 |  82 ++++++
 include/mvebu_nrboot.h                   |  51 ++++
 include/nbx_fbxserial.h                  | 134 +++++++++
 21 files changed, 1691 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi
 create mode 100644 arch/arm/dts/armada-8040-nbx.dts
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.c
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.h
 create mode 100644 board/freebox/nbx10g/Kconfig
 create mode 100644 board/freebox/nbx10g/MAINTAINERS
 create mode 100644 board/freebox/nbx10g/Makefile
 create mode 100644 board/freebox/nbx10g/board.c
 create mode 100644 cmd/mvebu/mvebu_emmcboot.c
 create mode 100644 cmd/mvebu/nbx_fbxserial.c
 create mode 100644 configs/mvebu_nbx_88f8040_defconfig
 create mode 100644 include/configs/nbx10g.h
 create mode 100644 include/mvebu_imagetag.h
 create mode 100644 include/mvebu_nrboot.h
 create mode 100644 include/nbx_fbxserial.h

-- 
2.43.0

