Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CEF327C8
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BA68439E;
	Tue, 21 Apr 2026 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="YB+uYMbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA56843DC; Tue, 21 Apr 2026 11:05:13 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F51284390
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from y14 (unknown [IPv6:2a01:e0a:2af:22b0:6ee8:ae48:54aa:4eff])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9860878050F;
 Tue, 21 Apr 2026 11:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1776762311;
 bh=PWBJiRxLPvC27rvM6AgllA1XucTXnRg11FY2u3d/Ojg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YB+uYMbTSH8izmq1areU95xbQbSJ8Z4sDtNHsaAadPe8vKUo/75ufhqMeIEHdx/OU
 eg1PEJSDqZARb5PpsFnYopg/KcArZYA9DQ0MmpXdhA983IWAxmrL5gO/tCo7+dGs+q
 pRlkx5vBnPJwm94xm8SsmJwhBcSCQ6zy/0HTUX1Yx6mDtHt3syOwYR/7gEEvWErwaC
 0+keuEQcKDFNk0RrDefBpwI6SjM9iPjeGxuEcDpDHNJVNUfnyr3hHLAM2RInDNBpaL
 Ue14I+5XNt3xcfpGACWEA9UQjpSMD3KdGMqDQdr9TjOngLmRXoozHAAojDdE3ao9O5
 nK/lZ6gOHkncw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board support
Date: Tue, 21 Apr 2026 11:04:54 +0200
Message-ID: <cover.1776762022.git.vjardin@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773151972.git.vjardin@free.fr>
References: <cover.1773151972.git.vjardin@free.fr>
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

This v2 addresses Stefan Roese's review feedback on v1:
  https://lists.denx.de/pipermail/u-boot/2026-March/613625.html

Changes since v1:
 - Patch 1 (cpuinfo/SAR): added Reviewed-by Stefan
 - Patch 2 (board support):
     * dropped board_init() bi_boot_params assignment
       (ARM64 uses FDT, ATAGS are !ARM64-only)
     * dropped empty board_early_init_f()
     * removed unused includes / DECLARE_GLOBAL_DATA_PTR
     * added note on U-Boot vs Linux comphy DT bindings
     * MAINTAINERS: armada-8040-nbx* wildcard covers the u-boot dtsi;
       removed duplicate NBX BOARD entry from
       board/Marvell/mvebu_armada-8k/MAINTAINERS
     * added Reviewed-by Stefan
 - Patch 3 (emmcboot): moved from cmd/mvebu/ to board/freebox/nbx10g/,
     renamed Kconfig CMD_MVEBU_EMMCBOOT -> CMD_NBX_EMMCBOOT and
     MVEBU_MMC_PART_* -> NBX_MMC_PART_*, replaced all `return -1`
     with `return -EINVAL`, commit message now explains legacy format
 - Patch 4 (fbxserial): moved from cmd/mvebu/ to board/freebox/nbx10g/,
     replaced all `return -1` with proper errno codes
     (-EINVAL for data validation, -ENODEV for missing MMC,
      -EIO for MMC I/O failures)
 - Patch 5 (U-Boot dtsi): added Reviewed-by Stefan

Build tested on Nodebox 10G (ATF v2.14 + U-Boot 2026.04 + Linux 6.19),
all functionality verified on hardware.

Vincent Jardin (5):
  arm: mach-mvebu: armada8k: cpuinfo and SAR
  board: freebox: add Nodebox 10G board support
  board: freebox: nbx10g: add emmcboot for dual-bank eMMC boot
  board: freebox: nbx10g: add device serial and MAC address
    initialization
  arm: dts: armada-8040-nbx: add U-Boot dtsi for conditional OP-TEE

 arch/arm/dts/Makefile                    |   1 +
 arch/arm/dts/armada-8040-nbx-u-boot.dtsi |  15 +
 arch/arm/dts/armada-8040-nbx.dts         | 259 ++++++++++++++++
 arch/arm/mach-mvebu/Kconfig              |   9 +
 arch/arm/mach-mvebu/armada8k/Makefile    |   2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c       |  12 +
 arch/arm/mach-mvebu/armada8k/soc_info.c  | 194 ++++++++++++
 arch/arm/mach-mvebu/armada8k/soc_info.h  |  14 +
 board/freebox/nbx10g/Kconfig             |  94 ++++++
 board/freebox/nbx10g/MAINTAINERS         |   6 +
 board/freebox/nbx10g/Makefile            |   5 +
 board/freebox/nbx10g/board.c             |  53 ++++
 board/freebox/nbx10g/nbx_emmcboot.c      | 357 +++++++++++++++++++++++
 board/freebox/nbx10g/nbx_fbxserial.c     | 286 ++++++++++++++++++
 board/freebox/nbx10g/nbx_fbxserial.h     | 156 ++++++++++
 board/freebox/nbx10g/nbx_imagetag.h      |  78 +++++
 board/freebox/nbx10g/nbx_nrboot.h        |  34 +++
 configs/mvebu_nbx_88f8040_defconfig      |  75 +++++
 include/configs/nbx10g.h                 |  29 ++
 19 files changed, 1678 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi
 create mode 100644 arch/arm/dts/armada-8040-nbx.dts
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.c
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.h
 create mode 100644 board/freebox/nbx10g/Kconfig
 create mode 100644 board/freebox/nbx10g/MAINTAINERS
 create mode 100644 board/freebox/nbx10g/Makefile
 create mode 100644 board/freebox/nbx10g/board.c
 create mode 100644 board/freebox/nbx10g/nbx_emmcboot.c
 create mode 100644 board/freebox/nbx10g/nbx_fbxserial.c
 create mode 100644 board/freebox/nbx10g/nbx_fbxserial.h
 create mode 100644 board/freebox/nbx10g/nbx_imagetag.h
 create mode 100644 board/freebox/nbx10g/nbx_nrboot.h
 create mode 100644 configs/mvebu_nbx_88f8040_defconfig
 create mode 100644 include/configs/nbx10g.h

-- 
2.53.0

