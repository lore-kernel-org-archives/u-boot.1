Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16CBCA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A9D83443;
	Sun, 31 Aug 2025 18:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gSBWOkgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A65183447; Sun, 31 Aug 2025 18:50:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1855D8341A
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1756659026;
 bh=jC/9PJruI4m1q4MdB9A+yKoVwbdw1UkUFR2wzcu/aT4=;
 b=gSBWOkgs6RUi2Q56FcMoi4TYsVgVQpDuJmiwvV9iFT4AF+2ZuF86L2NWyW0DUePWzY8oNwwnD
 T39C1RYW2UwW5PX4kv980GdKAK5uwfXyb4VSL0q9Et40nDctKO/+korH34Lk6ZNg0ZEC/Y0oisc
 cWFXNOAcSRKpOvg7nZS4dVRgXr+hJLq2LU11YnpaKsZikxZWONK6kGZYAA39fm4h3olNTQnEjpT
 0LwcRyUKDyIrP5enb36tBGUCgFyCtjXs0USGq8JpMKv4Sr9bkGs2JkPlSNfcmSM3KA2QlosRhro
 uyZC0v/G04hqad83G03CueLsuq6GDCQx4UiBfP3a8PXg==
X-Forward-Email-ID: 68b47d4d7f68b507ca9c3996
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/18] rockchip: odroid-go2: Add support for SPI flash boot
 and more 
Date: Sun, 31 Aug 2025 16:49:17 +0000
Message-ID: <20250831165001.2749711-1-jonas@kwiboo.se>
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

This series update ODROID-GO Advance/Super to support SPI flash boot,
adds pinctrl in SPL, enable use of checksum validation for FIT images,
include FDT for each board variant in FIT and more.

Each patch in this series has been tested on a ODROID-GO Super:

  DDR3, 333MHz
  BW=32 Col=10 Bk=8 CS0 Row=15 CS=1 Die BW=16 Size=1024MB
  out
  
  U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
  Trying to boot from MMC1
  ## Checking hash(es) for config config-3 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-3 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  ## Checking hash(es) for Image atf-4 ... sha256+ OK
  ## Checking hash(es) for Image atf-5 ... sha256+ OK
  
  U-Boot 2025.07 (Jul 13 2025 - 10:07:16 +0000)
  
  Model: ODROID-GO Super
  SoC:   RK3326
  DRAM:  1 GiB (total 1022 MiB)
  PMIC:  RK817 (on=0x80, off=0x08)
  Core:  283 devices, 26 uclasses, devicetree: separate
  MMC:   mmc@ff370000: 0
  Loading Environment from MMC... Reading from MMC(0)... OK
  In:    serial@ff160000
  Out:   serial@ff160000
  Err:   serial@ff160000
  Net:   No ethernet found.
  Hit any key to stop autoboot:  0
  =>

Changes in v2:
- Split out fix for incorrect re-defined spi0 alias into separate patch
- Collect r-b tags

Jonas Karlman (18):
  clk: px30: Allow use of GPU and WIFI_PMU in assigned-clocks
  rockchip: odroid-go2: Remove cru assigned-clocks override
  rockchip: odroid-go2: Remove incorrect re-defined spi0 alias
  rockchip: odroid-go2: Remove u-boot.dtsi props already defined
  rockchip: odroid-go2: Use appropriate bootph props
  rockchip: odroid-go2: Move SoC common overrides into a SoC u-boot.dtsi
  rockchip: odroid-go2: Remove unsupported Kconfig options
  rockchip: odroid-go2: Update Kconfig options for SPL
  rockchip: odroid-go2: Include pinctrl for sdmmc, sfc and uart in SPL
  rockchip: odroid-go2: Use power off at power plug-in event
  rockchip: odroid-go2: Add support for SPI flash boot
  rockchip: odroid-go2: Select board FDT from FIT in SPL
  rockchip: odroid-go2: Use env from same storage FIT was loaded from
  rockchip: odroid-go2: Enable RockUSB, button, LED and RNG support
  rockchip: odroid-go2: Turn on the blue LED at boot
  rockchip: odroid-go2: Enable more commands
  rockchip: odroid-go2: Add myself as a reviewer
  arm: dts: rockchip: Include OTP in U-Boot pre-reloc phase for RK3326

 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi    | 111 +++----------
 .../arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi |   3 +
 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi    |   3 +
 arch/arm/dts/rk3326-u-boot.dtsi               | 154 ++++++++++++++++++
 board/hardkernel/odroid_go2/Kconfig           |   7 +
 board/hardkernel/odroid_go2/MAINTAINERS       |   2 +
 board/hardkernel/odroid_go2/go2.c             |  88 ++++++++--
 configs/odroid-go2_defconfig                  |  63 ++++---
 drivers/clk/rockchip/clk_px30.c               |   6 +
 9 files changed, 315 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/dts/rk3326-odroid-go2-v11-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3326-odroid-go3-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3326-u-boot.dtsi

-- 
2.51.0

