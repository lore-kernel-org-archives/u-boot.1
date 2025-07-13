Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E37DC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCEB82DA1;
	Mon, 14 Jul 2025 01:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yF8c1wIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A2381FEE; Mon, 14 Jul 2025 01:34:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD87805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752449681;
 bh=rcAsGCnPQa3C6p1uoy63bk2qZODMk5zIDAkAHotSY1Q=;
 b=yF8c1wIaCJJXuWzmt9lpwcjztfqBbLS5MyhPJZHbxJGizwGcXDv3y6sBwQXqEsyUuvQpl6OSN
 5DRNMJvi8/mjdLQaCZYGHYZTIYFyviyTxlYoeJa+0vFLth5spLPjuq5JwG0CiBQfF76yxa2vJ5v
 vIpjBlZqwtqJS+/SywbQUPNX90A2Uu1qiCq5ozOsqxgFpTg9mkGzbaEvjGywprbeD/1COs2mtQa
 SSkUMZmsHGjvXp+4smH8qekXu9F2xhS/R1jcKhudVXvIpxRrlzmGlFvFXOitT17KZB16AdgVXaU
 0+Tav2Mh0hQh6ZMM6dJGCbcGj563uzciwWPJQEYReWqg==
X-Forward-Email-ID: 6874428e5c59ddd2f404fd70
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
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
Subject: [PATCH 00/17] rockchip: odroid-go2: Add support for SPI flash boot
 and more 
Date: Sun, 13 Jul 2025 23:33:48 +0000
Message-ID: <20250713233429.1376172-1-jonas@kwiboo.se>
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

The final patch in this series enables use of the feature added in
"rockchip: px30/rk3326: Implement checkboard() to print SoC variant" [1]

[1] https://patchwork.ozlabs.org/patch/2095941/

Jonas Karlman (17):
  clk: px30: Allow use of GPU and WIFI_PMU in assigned-clocks
  rockchip: odroid-go2: Remove cru assigned-clocks override
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
2.49.0

