Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A2109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A0083E76;
	Wed, 25 Mar 2026 20:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="cIg9ejCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D696A83F14; Wed, 25 Mar 2026 20:27:14 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E0D83DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=DXpzYYNSomdGvUp4SvLFUAmKTtm1YJk19iZI6Pkycjc=;
 b=cIg9ejCbt18wrVuTLPt+/NfZNLfX4owARrXX+diIFo/WDMuXWgdAo4USxWRrSOKt2wRe/GneURfrnHWZwUBbRUNZZ6oGiBoRzkR/6hHeBQJakX1YFgxMD24s7ZMooqyKKajgyCjqPmwd3eodfUGp67vtfLlLGSW34hfYQ7QEfJA=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Wed, 25 Mar 2026 20:27:10 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 0/6] sunxi: add NetCube Nagami support and T113 secure boot
 enablement
Date: Wed, 25 Mar 2026 20:26:07 +0100
Message-ID: <20260325192628.750398-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
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

This series adds support for the NetCube Systems Nagami T113-based
system-on-module and its associated carrier boards, along with the
sunxi changes needed to boot signed FIT images from SPL in secure mode
on R528/T113.

The Nagami module is based on the Allwinner T113-S3/T113-S4 family and
the included defconfigs cover the basic carrier, keypad carrier, and a
secure boot example configuration for the basic carrier.

To support the secure boot flow in SPL, the series adds the missing
sunxi pieces for R528/T113: I2C3 pinmux support, early SPC setup for
non-secure peripheral handoff, non-DM SPL FIT signature verification,
and signed SPL image generation in the sunxi binman/FIT description.

The SID MAC fallback handling is also cleaned up. The original fix used
a board-level check for whether nvmem-cells were present in the DT.
This version moves the fallback into the EMAC drivers instead of
env_setup, so both sunxi EMAC variants share a generic implementation.

Lukas Schmid (6):
  sunxi: move SID MAC fallback from board env setup to EMAC
    read_rom_hwaddr
  pinctrl: sunxi: add I2C3 mux for D1/T113-s3 (PG10/PG11)
  sunxi: add SPC setup for R528/T113 secure boot handoff
  boot: allow SPL FIT signature verification without DM
  sunxi: extend binman FIT description for signed SPL images
  sunxi: add support for NetCube Systems Nagami and associated carrier
    boards

 arch/arm/cpu/armv7/sunxi/Makefile             |  1 +
 arch/arm/cpu/armv7/sunxi/spc.c                | 20 ++++++
 arch/arm/dts/sunxi-u-boot.dtsi                | 68 +++++++++++++++++--
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  | 27 ++++++++
 arch/arm/include/asm/arch-sunxi/sys_proto.h   | 14 ++++
 arch/arm/mach-sunxi/board.c                   |  1 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         |  8 +++
 arch/arm/mach-sunxi/cpu_info.c                | 44 ++++++++++++
 board/sunxi/board.c                           | 57 +---------------
 boot/Kconfig                                  |  1 -
 .../netcube_nagami_basic_carrier_defconfig    | 43 ++++++++++++
 ..._nagami_basic_carrier_secureboot_defconfig | 52 ++++++++++++++
 .../netcube_nagami_keypad_carrier_defconfig   | 43 ++++++++++++
 drivers/net/sun8i_emac.c                      | 15 ++++
 drivers/net/sunxi_emac.c                      | 15 ++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |  1 +
 lib/rsa/rsa-verify.c                          | 16 +++--
 17 files changed, 359 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/cpu/armv7/sunxi/spc.c
 create mode 100644 configs/netcube_nagami_basic_carrier_defconfig
 create mode 100644
  configs/netcube_nagami_basic_carrier_secureboot_defconfig
 create mode 100644 configs/netcube_nagami_keypad_carrier_defconfig

-- 
2.47.3

