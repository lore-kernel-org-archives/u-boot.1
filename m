Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF459CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1275F838E6;
	Sun, 31 Aug 2025 13:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FOIUx2sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9BA3838AA; Sun, 31 Aug 2025 13:21:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4434E83447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1756639262;
 bh=xid4gAPH9hPSmeNjMJ+7ip3dIlvtZswRCpmx7ev8Oqs=;
 b=FOIUx2sxoyapihbwkWyL5IwkPYh7UzDAM63BAS5esfFkoUutwW42O3zSkfxgVZ7MQOLsg9Yhs
 XJk7Cid7ecaiiepUV6g7H44gRlAo93C78HknpLWb42eUxdgxGAgbvfeRkQLjiBM1N3DM7Y/8OcT
 YRQTA5yu2hvJLGEzjV164MTbOaHd/XsfimCedaC+XkaOZpz4xQies1+PDo9Fpbhx43w/GuAQr8l
 gtmISXOZ337vesqe7CW4P5sRJZRKbSBSdU5ZLXd5KRWvnOec4+LcrqE/nrdLbga4hPbuVlVXm/W
 BRkljoUFAB0xY7Bqy1Q94MSJi4qoaJR9e8UpAM+w7nIQ==
X-Forward-Email-ID: 68b4301c32f03f9a5e9085d9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 00/10] board: rockchip: Add Radxa ROCK 4D
Date: Sun, 31 Aug 2025 11:20:21 +0000
Message-ID: <20250831112046.2642363-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
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

This series add initial support for the Raxda ROCK 4D board, running
from SPI flash, booting OS from SD-card and using Ethernet has been
tested.

It also adds a helper function to read and translate the new bootsource
ids reported by the BootROM of RK3576 to help support booting from SPI
flash.

Kconfig options for PCIe, NVMe and USB has been enabled and is now
working with the picked DT commits from the v6.17-rc1-dts tag.

Changes in v3:
- Implement read_brom_bootsource_id() for RK3528
- Add a short code comment about the re-mapping of bootsource id
- Add fspi1m1 pinctrl bootph- props to SoC u-boot.dtsi
- Drop the incomplete support for FSPI1_M0
- Pick related DT changes that now have landed in v6.17-rc1-dts tag
- Drop the now unneeded reset-gpios prop rename workaround
- Rebase on top of u-boot-rockchip-20250831 tag

Change in v2:
- Add comment about the reset-gpios prop rename in board u-boot.dtsi

Detlev Casanova (1):
  arm64: dts: rockchip: Add UFS support on the ROCK 4D

Jon Lin (1):
  spi: rockchip_sfc: Support sclk_x2 version

Jonas Karlman (4):
  rockchip: spl: Add a read_brom_bootsource_id() helper
  rockchip: rk3528: Implement read_brom_bootsource_id()
  rockchip: rk3576: Add SPI Flash boot support
  board: rockchip: Add Radxa ROCK 4D

Nicolas Frattaroli (3):
  arm64: dts: rockchip: enable PCIe on ROCK 4D
  arm64: dts: rockchip: adjust dcin regulator on ROCK 4D
  arm64: dts: rockchip: complete USB nodes on ROCK 4D

Sebastian Reichel (1):
  arm64: dts: rockchip: fix PHY handling for ROCK 4D

 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi       | 10 +++
 arch/arm/dts/rk3576-u-boot.dtsi               | 46 +++++++++++
 arch/arm/include/asm/arch-rockchip/bootrom.h  |  2 +
 arch/arm/mach-rockchip/rk3528/rk3528.c        | 15 ++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c        | 25 ++++++
 arch/arm/mach-rockchip/spl.c                  |  7 +-
 configs/rock-4d-rk3576_defconfig              | 68 ++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 drivers/spi/rockchip_sfc.c                    | 13 +++-
 .../src/arm64/rockchip/rk3576-rock-4d.dts     | 78 ++++++++++++++++---
 11 files changed, 259 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
 create mode 100644 configs/rock-4d-rk3576_defconfig

-- 
2.51.0

