Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82151C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 04:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A8D80C93;
	Sun,  8 Jun 2025 06:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Jy6XazTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E037280E9A; Sun,  8 Jun 2025 06:15:48 +0200 (CEST)
Received: from mail-m8265.xmail.ntesmail.com (mail-m8265.xmail.ntesmail.com
 [156.224.82.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F3A808AF
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 06:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17e1067ce;
 Sun, 8 Jun 2025 12:15:38 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250606
Date: Sun,  8 Jun 2025 12:15:36 +0800
Message-Id: <20250608041536.329837-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHxhPVhkeTEJCGR1NS0hCTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a974dc04f4903afkunmaaa6846a4f086b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PU06ECo5OTE3LR0VMigiFU4V
 F1YaCg5VSlVKTE9CSE5NSkhCQ0xIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhMS0g3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Jy6XazTbzkeE9RtmlmiOLTAt+lyqCHu9f6mOQe+S3ocq5ua02pEefdfdmeLm8/YklHHccvOEmzPzxiu2pXsCtPdWtG8LYBSKWrAXedqIMaLUobgPFns+9aJGf0ityV9vr7Hyu2OtRABRVpqVk1+JaNzEh6IGlGAftytiy1cV1Lk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6EQTB6h2uOEIFfUSz12GRubljZEAn2CmheTd78BpqQw=;
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
- Allow to silent TPL/SPL debug console;
- enable exFAT support for Theobroma boards;
- Fix SD power initialization in SPL for rk3399-nanopi4

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/26117

Thanks,
- Kever

The following changes since commit b3f69c14187d413610abbc2b82d1a3752cb342c1:

  Merge tag 'xilinx-for-v2025.07-rc4' of https://source.denx.de/u-boot/custodians/u-boot-microblaze (2025-06-05 08:40:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250606

for you to fetch changes up to b8101af3ce56a547f373d273d9ea37aefb74dc5a:

  power: rk8xx: fix swapped mask and value in init registers for RK806 (2025-06-06 17:23:34 +0800)

----------------------------------------------------------------
Justin Klaassen (5):
      rockchip: io-domain: Add debug logging for regulators during probe
      rockchip: io-domain: Add CONFIG_SPL_ROCKCHIP_IODOMAIN
      regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
      rockchip: rk3399-nanopi-4: Allow MMC driver to control SD regulators
      rockchip: rk3399-nanopi-4: Enable IO-domain driver in SPL

Lukasz Czechowski (6):
      arm: uniphier: Change _debug_uart_putc function to inline
      efi: stub: Change _debug_uart_putc function to inline
      ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
      debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART is not set
      rockchip: px30: Weaken dependency TPL/SPL serial
      rockchip: px30: Fix hard dependency to DEBUG_UART_BOARD_INIT

Quentin Schulz (5):
      configs: ringneck-px30: enable exFAT support
      configs: jaguar-rk3588: enable exFAT support
      configs: tiger-rk3588: enable exFAT support
      configs: puma-rk3399: enable exFAT support
      power: rk8xx: fix swapped mask and value in init registers for RK806

 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi        | 12 ++++++++++++
 arch/arm/mach-rockchip/Kconfig                 |  5 ++---
 arch/arm/mach-uniphier/debug-uart/debug-uart.c |  2 +-
 configs/jaguar-rk3588_defconfig                |  1 +
 configs/nanopc-t4-rk3399_defconfig             |  7 +++++++
 configs/nanopi-m4-2gb-rk3399_defconfig         |  7 +++++++
 configs/nanopi-m4-rk3399_defconfig             |  7 +++++++
 configs/nanopi-m4b-rk3399_defconfig            |  7 +++++++
 configs/nanopi-neo4-rk3399_defconfig           |  7 +++++++
 configs/nanopi-r4s-rk3399_defconfig            |  7 +++++++
 configs/puma-rk3399_defconfig                  |  1 +
 configs/ringneck-px30_defconfig                |  1 +
 configs/tiger-rk3588_defconfig                 |  1 +
 drivers/misc/Kconfig                           |  8 ++++++++
 drivers/misc/rockchip-io-domain.c              |  5 ++++-
 drivers/power/pmic/rk8xx.c                     |  2 +-
 drivers/power/regulator/Kconfig                |  9 +++++++++
 drivers/power/regulator/rk8xx.c                |  8 ++------
 drivers/ram/rockchip/Kconfig                   |  1 +
 include/debug_uart.h                           | 20 ++++++++++++++++++++
 lib/efi/efi_stub.c                             |  2 +-
 21 files changed, 107 insertions(+), 13 deletions(-)
