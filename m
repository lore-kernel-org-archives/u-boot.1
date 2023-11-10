Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A72C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB1C877F2;
	Fri, 10 Nov 2023 10:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EfbBDtyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2AA877F2; Fri, 10 Nov 2023 10:09:24 +0100 (CET)
Received: from mail-m25473.xmail.ntesmail.com (mail-m25473.xmail.ntesmail.com
 [103.129.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0048F877F6
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EfbBDtyjfdnNEI936YAWF6Aig+q4s8N+YRn+xJabBMTATCmg8EJwH/aAwnwfVIpBaIbQz7wOHRXVrG78wQqY+zG2nMsb2ENHmQhOVVk4itMrW7U05KVVlxT+IxvNC1V98PtOcM77JoznSrlyJujG67utDs3QDOABJ57IEA5Fx9g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=QVIgaYrrawMby0phe4ngy+JsGUIGw3AYNzBCZvgtWOk=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 67EC8400404;
 Fri, 10 Nov 2023 17:09:14 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20231110
Date: Fri, 10 Nov 2023 17:09:14 +0800
Message-Id: <20231110090914.116712-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NLGlZKTh4ZQk9JSEIYTExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8bb87e1c612eb3kusn67ec8400404
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6OCo5Nzw9NQwdTSk9CA4a
 Ej4KCSNVSlVKTUJCTUtMSE5PQk1PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITU5NNwY+
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

Please pull the fixex for rockchip platform:
- Add Board: rk3588 Pine64 QuartzPro64;
- fix rk3066 enter download mode;
- fix for ringneck-px30 board;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18047

Thanks,
- Kever

The following changes since commit e17d174773e9ba9447596708e702b7382e47a6cf:

  Merge tag 'xilinx-for-v2024.01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-microblaze (2023-11-07 10:36:23 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20231110

for you to fetch changes up to 4df4aea88fb99f413a0e3a2a96e176c6108939e3:

  rockchip: include: asm: fix entering download mode rk3066 (2023-11-09 18:07:21 +0800)

----------------------------------------------------------------
Johan Jonker (1):
      rockchip: include: asm: fix entering download mode rk3066

Quentin Schulz (3):
      rockchip: ringneck-px30: enable i2c command
      rockchip: ringneck-px30: always reset STM32 companion controller on boot
      rockchip: ringneck-px30: enable SPL_BOARD_INIT

Tim Lunn (3):
      rockchip: dts: fix bootph tags for rv1126
      rockchip: otp: Add support for RV1126
      rockchip: rv1126: Read cpuid from otp and set ethaddr

Tom Fitzhenry (1):
      board: rockchip: add Pine64 QuartzPro64 RK3588 board

 arch/arm/dts/Makefile                              |    1 +
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi        |   12 +
 arch/arm/dts/rk3588-quartzpro64.dts                | 1137 ++++++++++++++++++++
 arch/arm/dts/rv1126-u-boot.dtsi                    |   18 +-
 arch/arm/include/asm/arch-rk3066/boot0.h           |   77 +-
 arch/arm/mach-rockchip/Kconfig                     |    4 +-
 arch/arm/mach-rockchip/rk3066/Kconfig              |    8 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |    8 +
 board/pine64/quartzpro64-rk3588/Kconfig            |   15 +
 board/pine64/quartzpro64-rk3588/MAINTAINERS        |    8 +
 board/pine64/quartzpro64-rk3588/Makefile           |    3 +
 .../pine64/quartzpro64-rk3588/quartzpro64-rk3588.c |   39 +
 .../ringneck_px30/ringneck-px30.c                  |   53 +
 configs/quartzpro64-rk3588_defconfig               |   72 ++
 configs/ringneck-px30_defconfig                    |    2 +
 doc/board/rockchip/rockchip.rst                    |    1 +
 drivers/misc/rockchip-otp.c                        |   76 ++
 include/configs/quartzpro64-rk3588.h               |   14 +
 18 files changed, 1543 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
 create mode 100644 board/pine64/quartzpro64-rk3588/Kconfig
 create mode 100644 board/pine64/quartzpro64-rk3588/MAINTAINERS
 create mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 create mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 create mode 100644 configs/quartzpro64-rk3588_defconfig
 create mode 100644 include/configs/quartzpro64-rk3588.h
