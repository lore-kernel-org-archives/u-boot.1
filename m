Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4ABC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 23:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64AB874E9;
	Sat, 18 Nov 2023 00:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ztmb1BA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4539086E24; Sat, 18 Nov 2023 00:25:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5EB86F2A
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 00:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9f74=G7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1700263487;
 bh=6j5RVr/U3tOdlJ6u+rpgdMRALdd8MiS75iiDRJcdBZY=;
 b=ztmb1BA8pT7WJzy34pjbDc7eizbuj40tU5YFjxoAWFCq2Qeg6nAmohAb3AFYbmK32n0nCmfAg
 N+TaP8Z/+P8FepGCXK1/qUtdf+tQRa/Ylzn98Tdcm4WbKTsghJ5rISt197hPDsc5SNwGBcuv0Dn
 wM5i+hw4nNT4TeX3NgDw2p1cTde4xZ2S7TAduVPC9vujTgi/SZqeua/14Mq7U9hgp6utESbT2rJ
 9sPbu/fmzVDqdl4T09c2jqep4T3YSbJn2YQ1YwOrOYBnOjovIE1flNUbFescQS89X2LNUale7L8
 hci0SNpVHGAEt25Jk8b4cCMj0catWfo/FKED7IH+BPbw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: rk3588: Fix SPI flash bootsource id values
Date: Fri, 17 Nov 2023 23:24:33 +0000
Message-ID: <20231117232442.1430276-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6557f63f943be35dca803c09
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

The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.

At the time the reason for this new bootsource id value 6 was unknown.

Since then the following bootsource id values have been observed on
different RK3588 devices:

- Radxa ROCK 5 Model A - fspim0_pins - rk3588s
- Xunlong Orange Pi 5 - fspim0_pins - rk3588s
    brom_bootdevice_id: 3

- FriendlyElec NanoPC-T6 - fspim1_pins - rk3588
- Xunlong Orange Pi 5 Plus - fspim1_pins - rk3588
    brom_bootdevice_id: 4

- Radxa ROCK 5 Model B - fspim2_pins - rk3588
    brom_bootdevice_id: 6

It has now been confirmed that the BootRom on RK3588 use different
bootsource id values depending on the iomux used by the flash spi
controller, and not by the type of spi nor or spi nand flash used.

This series adjusts the bootsource enum values, updates the boot_devices
array to fix booting from SPI flash on RK3588 devices using fspim1_pins.
It also enable building of a bootable SPI image for affected devices.

Changes in v2:
- Move FSPI M0/M1/M2 enum values from bootrom.h to rk3588.c
- Add t-b tag

John Clark (1):
  rockchip: rk3588-nanopc-t6: Build SPI image

Jonas Karlman (2):
  rockchip: rk3588: Fix boot from SPI flash
  rockchip: rk3588s-orangepi-5: Build SPI image

Slawomir Stepien (1):
  rockchip: rk3588-orangepi-5-plus: Build SPI image

 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 -
 arch/arm/mach-rockchip/rk3588/rk3588.c       | 16 ++++++++++++++--
 configs/nanopc-t6-rk3588_defconfig           |  1 +
 configs/orangepi-5-plus-rk3588_defconfig     |  1 +
 configs/orangepi-5-rk3588s_defconfig         |  1 +
 5 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.42.0

