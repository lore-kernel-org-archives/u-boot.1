Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FB4C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9793D87D14;
	Sat, 17 Feb 2024 19:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dreS9Kq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7656B87DBB; Sat, 17 Feb 2024 19:36:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8E287CD4
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708194980;
 bh=1d7uKFcve3LjDSNQ0oQ1uu4wXIYw1EHfVNw0m4ZcVq8=;
 b=dreS9Kq2gFXFWz0secgx540wWxbYTgtSxMWF3QNpp/DQ6dxLwyvIHGHocTtTfrvXyZa3RYD+R
 UqEqGt9dQ8X3s7rh2Nujid/VMnGgVdkBWZoCrZ1GBepb2Nf5GCp1975A1UIsF7yP5bjpK6NSQ6L
 22GbL96HK/J4xWlYhduXcBYBsviIq9GDpv9p4Ryq53ntIuTrWuuy8RlutS24II15CVNt9YNz/I2
 Z+4ET/LMxD/yw1rrIFRJlQMA4yZXr1gi3D2TzXFHgnYzpgkWLojeXyh/+BqwJ2/zyA+g98Qzbay
 JnDuNe11lUhGKpbWy8iUExHh+ew42p+sQiKfWjLUjNaQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/11] rockchip: rk3399: Migrate to use IO-domain driver
Date: Sat, 17 Feb 2024 18:35:45 +0000
Message-ID: <20240217183610.2621132-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d0fca0af53a5c07f266c49
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

This series remove old unused board_early_init_f() functions, adds
support for RK3399 to the IO-domain driver and migrates all boards that
used setup_iodomain() to now use the IO-domain driver instead.

Also add device tree files and myself as reviewer to MAINTAINERS.

This series depends on cleanup done in Quentin Schulz series "rockchip:
add support for Theobroma JAGUAR SBC-RK3588-AMR" [1]. A copy of this
series can also be found at [2]

[1] https://patchwork.ozlabs.org/cover/1896901/
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-io-domain-v1

Jonas Karlman (11):
  board: rockchip: rk3399: Add device tree files to MAINTAINERS
  board: rockchip: rk3399: Add myself as reviewer to MAINTAINERS
  board: rockchip: rk3399: Remove unused board_early_init_f functions
  board: rockchip: Add a common ROCK Pi 4 target
  rockchip: io-domain: Add support for RK3399
  rockchip: pine64: rockpro64: Migrate to use IO-domain driver
  rockchip: pine64: pinebook-pro: Migrate to use IO-domain driver
  rockchip: pine64: pinephone-pro: Migrate to use IO-domain driver
  rockchip: vamrs: rock960: Migrate to use IO-domain driver
  rockchip: theobroma-systems: puma: Migrate to use IO-domain driver
  rockchip: google: gru: Migrate to use IO-domain driver

 arch/arm/mach-rockchip/board.c                | 10 +--
 arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++
 board/firefly/roc-pc-rk3399/MAINTAINERS       |  5 ++
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   | 22 +-----
 board/google/gru/gru.c                        | 35 --------
 board/pine64/pinebook-pro-rk3399/MAINTAINERS  |  3 +-
 board/pine64/pinebook-pro-rk3399/Makefile     |  1 -
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c | 61 --------------
 board/pine64/pinephone-pro-rk3399/MAINTAINERS |  2 +-
 board/pine64/pinephone-pro-rk3399/Makefile    |  1 -
 .../pinephone-pro-rk3399.c                    | 64 ---------------
 board/pine64/rockpro64_rk3399/MAINTAINERS     |  3 +
 board/pine64/rockpro64_rk3399/Makefile        |  7 --
 .../rockpro64_rk3399/rockpro64-rk3399.c       | 39 ---------
 board/radxa/rockpi4-rk3399/Kconfig            | 15 ++++
 board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++
 .../rockpi4-rk3399}/Makefile                  |  2 +-
 .../rockpi4-rk3399/rockpi4-rk3399.c}          | 33 +-------
 board/rockchip/evb_rk3399/MAINTAINERS         | 38 ++++-----
 .../puma_rk3399/puma-rk3399.c                 | 21 -----
 board/vamrs/rock960_rk3399/MAINTAINERS        |  5 ++
 board/vamrs/rock960_rk3399/Makefile           |  6 --
 board/vamrs/rock960_rk3399/rock960-rk3399.c   | 27 -------
 configs/chromebook_bob_defconfig              |  1 +
 configs/chromebook_kevin_defconfig            |  1 +
 configs/ficus-rk3399_defconfig                |  1 +
 configs/pinebook-pro-rk3399_defconfig         |  1 +
 configs/pinephone-pro-rk3399_defconfig        |  1 +
 configs/puma-rk3399_defconfig                 |  1 +
 configs/rock-4c-plus-rk3399_defconfig         |  2 +-
 configs/rock-4se-rk3399_defconfig             |  2 +-
 configs/rock-pi-4-rk3399_defconfig            |  2 +-
 configs/rock-pi-4c-rk3399_defconfig           |  2 +-
 configs/rock960-rk3399_defconfig              |  1 +
 configs/rockpro64-rk3399_defconfig            |  1 +
 drivers/misc/rockchip-io-domain.c             | 79 ++++++++++++++++++-
 include/configs/rk3399_common.h               | 16 ----
 include/configs/rockpi4-rk3399.h              | 32 ++++++++
 38 files changed, 212 insertions(+), 366 deletions(-)
 delete mode 100644 board/pine64/pinebook-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
 delete mode 100644 board/pine64/pinephone-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
 delete mode 100644 board/pine64/rockpro64_rk3399/Makefile
 delete mode 100644 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
 create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
 create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
 rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
 rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (65%)
 delete mode 100644 board/vamrs/rock960_rk3399/Makefile
 delete mode 100644 board/vamrs/rock960_rk3399/rock960-rk3399.c
 create mode 100644 include/configs/rockpi4-rk3399.h

-- 
2.43.0

