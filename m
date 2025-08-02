Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E54C87FC9
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 22:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A2E83C67;
	Sun,  3 Aug 2025 00:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hI8W4/rD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367E883C6D; Sun,  3 Aug 2025 00:07:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF7483C28
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 00:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7e69=2P=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754172471;
 bh=XnYTLtcUu/zFvxrV8HgT0vWKCLs5YLsF5SlEqmN3fug=;
 b=hI8W4/rD2IFEGgydTfE8B3Qu4oaWf0zrW9xRP2RAYNSm52rrRrp2678NK9l7Pr4mgiLs2eq8a
 aw56HmVr61nefm31yXw5Ng17ONxOsGkKS7bp3I5B1MYIyBGIqj1eoQR+/ifWgRTmDcOb3EG9dnT
 jiMAA/nUEFO/j7XN3gbFAhqVeGZx7PyDlNUgBNLxhVu9kBkikLMUSO7JVBS0dVt9MSnZmCIkuAb
 lRKhbCXehstjf3XLRq6Gq/YDCVqTDqlwwzj3m63Txz+Hqgh56FsUueXVfRHt9fCtAf3IlUIaDZF
 z0NvHIUedyw7119lDh8kejW8xvzZV1MRbxtCvfMMmD9A==
X-Forward-Email-ID: 688e8c34056e3a070faf354b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
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
Subject: [PATCH v3 0/4] rockchip: Add support for RAM boot from maskrom mode
Date: Sat,  2 Aug 2025 22:07:21 +0000
Message-ID: <20250802220738.3018910-1-jonas@kwiboo.se>
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

The config fragment rockchip-ramboot.config can be used to enable
building of these two binman images, e.g.:

  make generic-rk3588_defconfig rockchip-ramboot.config

These binman images can be used with the proprietary rkbin boot_merger
tool to create a special loader image that can be used with tools such
as rkdeveloptool or rockusb tools to RAM boot from maskrom, e.g.:

  Create loader image:
    $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

  Boot from maskrom:
    $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
   or
    $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Another option that does not require use of proprietary tools is using
open source tools such as rkflashtool or rkusbboot that can load the
binman images directly without any need to first create a special loader
image to RAM boot from maskrom, e.g.:

  $ rkflashtool l < u-boot-rockchip-usb471.bin
  $ rkflashtool L < u-boot-rockchip-usb472.bin
 or
  $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

I am setting up a new personal lab for rockchip boards that primarily
will use this RAM boot method for testing new U-Boot and Linux builds.

More detailed instructions on how RAM boot can be used will be added
under doc/board/rockchip/ in a follow-up series, after this series has
been accepted and my new lab is fully up and running.

Changes in v3:
- Use read_brom_bootsource_id() to support RAM boot on RK3576
- Add a rockchip-ramboot.config fragment to explicitly enable instead of
  imply the new Kconfig option on a few select SoCs
- Update commit message to highlight that the binman images can be used
  directly without use of the proprietary rkbin boot_merger tool
- Include a special patch, not intended to be merged, to demonstrate use
  of RAM boot with rk loader images

Changes in v2:
- Rebase on top of "rockchip: binman: Use a template for FIT and other
  improvements" series
- Add patch to fix booting into Linux on RK3588 board with 16+ GiB DRAM

This series depends on the "rockchip: Add support for ROCK 5B+" [1] and
"board: rockchip: Add Radxa ROCK 4D" [2] series for a clean apply.
See [3] for a branch including both depends.

[1] https://patchwork.ozlabs.org/cover/2118033/
[2] https://patchwork.ozlabs.org/cover/2118088/
[3] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboot-v3

Jonas Karlman (4):
  rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
  rockchip: Add support for RAM boot from maskrom mode
  rockchip: sdram: Add fallback that fixup DRAM gaps on RK3588
  HACK: rockchip: Add miniall.ini files to simplify test of RAM boot

 RK3308MINIALL.ini                       | 22 +++++++++++++++++
 RK3328MINIALL.ini                       | 20 +++++++++++++++
 RK3399MINIALL.ini                       | 20 +++++++++++++++
 RK3528MINIALL.ini                       | 25 +++++++++++++++++++
 RK3566MINIALL.ini                       | 25 +++++++++++++++++++
 RK3568MINIALL.ini                       | 25 +++++++++++++++++++
 RK3576MINIALL.ini                       | 27 ++++++++++++++++++++
 RK3588MINIALL.ini                       | 25 +++++++++++++++++++
 arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          | 14 ++++++++---
 arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/rk3588.c  | 27 ++++++++++++++++++++
 arch/arm/mach-rockchip/sdram.c          |  7 +++++-
 arch/arm/mach-rockchip/spl-boot-order.c | 14 ++++++++---
 board/rockchip/rockchip-ramboot.config  |  1 +
 boot/Kconfig                            |  3 +++
 18 files changed, 281 insertions(+), 16 deletions(-)
 create mode 100644 RK3308MINIALL.ini
 create mode 100644 RK3328MINIALL.ini
 create mode 100644 RK3399MINIALL.ini
 create mode 100644 RK3528MINIALL.ini
 create mode 100644 RK3566MINIALL.ini
 create mode 100644 RK3568MINIALL.ini
 create mode 100644 RK3576MINIALL.ini
 create mode 100644 RK3588MINIALL.ini
 create mode 100644 board/rockchip/rockchip-ramboot.config

-- 
2.50.1

