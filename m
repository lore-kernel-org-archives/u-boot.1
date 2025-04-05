Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8858C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2774582A81;
	Sat,  5 Apr 2025 17:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DlE71V+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B0B82A81; Sat,  5 Apr 2025 17:38:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB318215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1743867521;
 bh=qnCIVvv/OTHiDkxafEA9ATnl2P4rC3UANtAQy1ib6Fk=;
 b=DlE71V+3LL/zRjE6n3xSxFtBw4VxdQQMCIWNowBwsiH391uCDAiTdQsA+4tThgaW/pWLv2NSD
 QAOOUzg4NcXdjF7+YdrCZoaNX4lEEXJjE6Lucn7obG03os3mVFDXYEne37qADv54NXerkxBlYdX
 8rIEp3vifaL4UW/ZauDrXm3t0EXgndvEhOh7bJssE7hgqQcUIqKXZ8uIr/U4Kz3HHyTAti0U6Tf
 Wimc7VFGfluslxNcjpqGwVO7Gzq55kLCUacjrgqg14zjfLZh9p2u0P+AuSPoBHDXOwKI0Cbupis
 zOxpcpVjDCt4XyK6DXHFuOuaC0es6rfgjD+qYycWGpIw==
X-Forward-Email-ID: 67f14e7d3dc50e09d12388bd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] Add support for RAM boot from maskrom mode
Date: Sat,  5 Apr 2025 15:38:20 +0000
Message-ID: <20250405153832.1427549-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
cannot be found in nand/spi/mmc storage.

In maskrom mode the USB OTG port can accept one of two custom commands.

Initially a 0x471 command to load TPL into SRAM. After TPL has been
executed and it has returned back-to-BROM, a 0x472 command to load SPL
into start of DRAM.

This series adds two binman images that can be used to RAM boot from
maskrom mode:
- u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
- u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
  payload with i.e. U-Boot proper, TF-A and FDT.

These images can be used with rkbin tools/boot_merger to create a loader
image to be used with rkdeveloptool or rockusb tools, e.g.:

  Create loader image:
    $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

  Boot from maskrom:
    $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
   or
    $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Or directly with tools such as rkflashtool or rkusbboot:

  $ rkflashtool l < u-boot-rockchip-usb471.bin
  $ rkflashtool L < u-boot-rockchip-usb472.bin
 or
  $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

Changes in v2:
- Rebase on top of "rockchip: binman: Use a template for FIT and other
  improvements" series
- Add patch to fix booting into Linux on RK3588 board with 16+ GiB DRAM

This series depends on the "rockchip: ROCKCHIP_COMMON_STACK_ADDR
improvements" series [1] and the "rockchip: binman: Use a template for
FIT and other improvements" series [2]. See [3] for a branch including
both depends.

[1] https://patchwork.ozlabs.org/cover/2050003/
[2] https://patchwork.ozlabs.org/cover/2066701/
[3] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboot-v2

Jonas Karlman (4):
  rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
  rockchip: Add support for RAM boot from maskrom mode
  rockchip: Enable RAM boot using ROCKCHIP_MASKROM_IMAGE
  rockchip: sdram: Add fallback that fixup DRAM gaps on RK3588

 arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          | 19 +++++++++++---
 arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/rk3588.c  | 27 ++++++++++++++++++++
 arch/arm/mach-rockchip/sdram.c          |  7 +++++-
 arch/arm/mach-rockchip/spl-boot-order.c | 15 ++++++++---
 boot/Kconfig                            |  3 +++
 9 files changed, 97 insertions(+), 16 deletions(-)

-- 
2.49.0

