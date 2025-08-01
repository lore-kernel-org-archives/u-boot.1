Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15468C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 21:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E292583B9E;
	Fri,  1 Aug 2025 23:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZbzaXDQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3116783B9E; Fri,  1 Aug 2025 23:07:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9554583B24
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 23:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754082413;
 bh=ZGQIkCQ+NAPolWO1CjCPJTpT2adfynh7ITsex+5MUXQ=;
 b=ZbzaXDQ08hCHx5QokCXzU3nYAcWKKKO6tREobBIfLdLTS6wznHYLT02D3M1EAhcW0qxAGqUeE
 Y7LufgwNAU7fjARcWwjU/VPvVut6vEp80RGORO9OfaMhg8WAvzq3uWRSpsQJCWncmP72iRGFUJl
 IOgCoieyfLgdrSeJ7KVfF7L/OgBqL0+tFy8fUPLp4dOFwzoBEmorJyhuvS9JKx4bCD9SlbrDA/6
 nfwP80IT4QLXG3oLkgM/55cq8GESVdVJQ0E+rbJc6FK6Lw6s6EleFWI/bwSlDwou2AwC6c9jCoo
 ps28kjuBPotPuh9f2YWJsasxqUlZOFYqbqn98e2Zu5kg==
X-Forward-Email-ID: 688d2c5003c11ad40176432f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] board: rockchip: Add Radxa ROCK 4D
Date: Fri,  1 Aug 2025 21:06:08 +0000
Message-ID: <20250801210619.2618622-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
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

Kconfig options for PCIe, NVMe and USB has been enabled and tested using
latest device tree from pending v6.17-rc1, and should automatically
start working once the updated device tree finally reach dts/upstream.

Change in v3:
- Add comment about the reset-gpios prop rename in board u-boot.dtsi

This series depends on the "board: rockchip: Add ArmSoM Sige5" [1] and
"rockchip: Fix misc USB PHY related issues" [2] series for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2118082/
[2] https://patchwork.ozlabs.org/cover/2114085/

Jon Lin (1):
  spi: rockchip_sfc: Support sclk_x2 version

Jonas Karlman (3):
  rockchip: spl: Add a read_brom_bootsource_id() helper
  rockchip: rk3576: Add SPI Flash boot support
  board: rockchip: Add Radxa ROCK 4D

 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi      | 19 ++++++
 arch/arm/dts/rk3576-u-boot.dtsi              | 36 +++++++++++
 arch/arm/include/asm/arch-rockchip/bootrom.h |  2 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS    |  6 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c       | 23 +++++++
 arch/arm/mach-rockchip/spl.c                 |  7 +-
 configs/rock-4d-rk3576_defconfig             | 68 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 drivers/spi/rockchip_sfc.c                   | 13 +++-
 9 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
 create mode 100644 configs/rock-4d-rk3576_defconfig

-- 
2.50.1

