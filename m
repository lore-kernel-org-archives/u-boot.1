Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1E7CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0323A84C81;
	Fri,  8 May 2026 15:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="gHwye2oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C7F84C95; Fri,  8 May 2026 15:54:26 +0200 (CEST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AFE84C3C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from y14 (unknown [IPv6:2a01:e0a:2af:22b0:d1a5:1153:d371:3c9c])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7C3FC2003AE;
 Fri,  8 May 2026 15:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778248464;
 bh=0EkJ02+o5DWwOXrL+HLfJYBppNSFKteZtF672FP94gA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gHwye2oepDegYPrV9HRKHabnR9TOo/ZKIetCuFCdiQSaZojGSGkbJYyBhy0kPLbp7
 jWD/KwWYdwR3xW9PDBAS0v/kjYooYk5hi+omLtHM9OCUoTuIyoV1f/hSTJ1iTPsI7f
 FXcp0ynJNq3CacAzqK8pWiYn3YJrtX95q2G8xHDIVTn/MuS6pT30LcQhNUSHwDlngy
 pmBz6oMTBO56aCd6pitKln+VcX9btFiSxUgYwxO7VdFTJ3GQHMoZ55k4tWq7+yuRJx
 S8k/t7poSsQCQ1o97HMlR3gMxJ3D3MnFpRlf/Zuej7XoeLzite890qgd3SDJh/A2rV
 Rh9rSY6sMG6IQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board support
Date: Fri,  8 May 2026 15:54:03 +0200
Message-ID: <cover.1778247592.git.vjardin@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776762022.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
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

This v3 addresses Stefan Roese's review feedback on v2:
  https://lists.denx.de/pipermail/u-boot/2026-May/617738.html

Per-patch changelogs are now included below --- in each patch
(per U-Boot's "Sending updated patch versions" guidelines).

Changes in v3:
- Moved per-patch changelogs below --- in each patch (Stefan)
- Patches 3 and 4: collected Reviewed-by Stefan from v2 review
    https://lists.denx.de/pipermail/u-boot/2026-May/617739.html
    https://lists.denx.de/pipermail/u-boot/2026-May/617740.html

For reference, v2 changelog (now also present in each patch):
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

v1 review thread:
  https://lists.denx.de/pipermail/u-boot/2026-March/613625.html

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

