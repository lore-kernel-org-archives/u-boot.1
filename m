Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C52D59D99
	for <u-boot@archiver.kernel.org>; Sun, 14 Dec 2025 15:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E268800AD;
	Sun, 14 Dec 2025 16:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="I1Fl6ugO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6003F800B1; Sun, 14 Dec 2025 16:10:40 +0100 (CET)
Received: from mail-m19731114.qiye.163.com (mail-m19731114.qiye.163.com
 [220.197.31.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914D58003E
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 16:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [120.36.68.98])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2d25f5ccd;
 Sun, 14 Dec 2025 23:10:30 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20251214
Date: Sun, 14 Dec 2025 23:10:30 +0800
Message-Id: <20251214151030.1461567-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b1d69c79303afkunm3d241c75377691
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH05CVkgfGRpCTRpOT09KSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTUNVQkNZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTEpVSktLVU
 pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=I1Fl6ugOjR0PqBjGfzcqSnKKSV2SuQj752Yk/xSFgEqRWGhLoYJnrgdWznibNJw2VyURRuvYgcE8Bvv2ZiebMInF/Cclv9exJBCy2iWvVoHVSQ3KdSOH3OZs3fLUzod6lUR7Ui1n0+ThYhmOpcQyedIdGyIli4Qj6umT6o2Z3VU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=7ge7yyyNLQtiB4IY+VvJ3DQq6hcxWJC5HdI2Hbgg2y0=;
 h=date:mime-version:subject:message-id:from;
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

Please pull the updates for rockchip platform:
- New Board support: rk3588 Radxa ROCK 5T, ROCK 5B+;
- I2C Fixes;
- RAM boot from maskrom;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/28748

Thanks,
- Kever

The following changes since commit 87d85139a96a39429120cca838e739408ef971a2:

  fs: fat: Perform sanity checks on getsize in get_fatent() (2025-12-12 08:52:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20251214

for you to fetch changes up to 0ed7abc85d1664a3d7432795a7126ff6a1d01147:

  rockchip: mkimage: enhance comments for v1 header (2025-12-14 00:02:10 +0800)

----------------------------------------------------------------
FUKAUMI Naoki (1):
      rockchip: rock5b-rk3588: Add support for Radxa ROCK 5T

Jonas Karlman (4):
      rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
      rockchip: Add support for RAM boot from maskrom mode
      rockchip: sdram: Add rockchip_sdram_type() helper
      rockchip: rock5b-rk3588: Add support for ROCK 5B+

Quentin Schulz (7):
      board: theobroma-systems: update instructions for newer Rockchip rkbin
      board: theobroma-systems: add instructions for how to use upstream TF-A
      board: theobroma-systems: jaguar_rk3588: explicit UART IOMUX
      rockchip: i2c: fix incorrect STOP flag for the interrupt enable register
      rockchip: i2c: move ACK comment where it applies
      rockchip: i2c: fix illegal I2C START/STOP condition
      rockchip: mkimage: enhance comments for v1 header

 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi  |  3 ++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  5 +++
 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi       |  3 ++
 arch/arm/dts/rockchip-u-boot.dtsi             | 33 ++++++++++++++
 arch/arm/include/asm/arch-rockchip/sdram.h    |  3 ++
 arch/arm/mach-rockchip/Kconfig                | 14 ++++--
 arch/arm/mach-rockchip/rk3308/Kconfig         |  3 --
 arch/arm/mach-rockchip/rk3568/Kconfig         |  3 --
 arch/arm/mach-rockchip/rk3588/Kconfig         |  3 --
 arch/arm/mach-rockchip/sdram.c                | 15 +++++++
 arch/arm/mach-rockchip/spl-boot-order.c       | 14 ++++--
 board/radxa/rock5b-rk3588/Kconfig             |  5 +++
 board/radxa/rock5b-rk3588/MAINTAINERS         |  3 +-
 board/radxa/rock5b-rk3588/rock5b-rk3588.c     | 64 +++++++++++++++++++++++++++
 board/rockchip/rockchip-ramboot.config        |  1 +
 boot/Kconfig                                  |  3 ++
 configs/rock5b-rk3588_defconfig               |  1 +
 doc/board/rockchip/rockchip.rst               |  2 +-
 doc/board/theobroma-systems/jaguar_rk3588.rst | 46 +++++++++++++++----
 doc/board/theobroma-systems/puma_rk3399.rst   |  6 ++-
 doc/board/theobroma-systems/ringneck_px30.rst |  3 +-
 doc/board/theobroma-systems/tiger_rk3588.rst  | 45 +++++++++++++++----
 drivers/i2c/rk_i2c.c                          | 27 +++++++----
 tools/rkcommon.c                              | 24 ++++++++--
 24 files changed, 277 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
 create mode 100644 board/rockchip/rockchip-ramboot.config
