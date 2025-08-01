Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1109C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 17:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018A783ABE;
	Fri,  1 Aug 2025 19:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DOehXLjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF81483ACE; Fri,  1 Aug 2025 19:09:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F1D83AAD
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 19:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754068183;
 bh=brC2ntftpa/iD2molWBcZsB8BOYCmJnj5MU9GDTp/GA=;
 b=DOehXLjM0gdD6TwYmdwmNk9PHq+0Sd8DogSyxcf5gfLHruhP7IH+KcnVH17lSRGZuvwLqXmbi
 A2N71NSD/9HGv1MAGoZmg7pYqCDqzhhpBsybJOGlUbukt6gAnAHfbx8YxiHj91rG5P3oAKOm2ix
 m6rIIRKTY8jNiJc3L8BGzo1x1CweQ8AMco5oKBp8HB/w5YvgxIloD1x001BZl385LK8vAlmZn/A
 xSRq4AfXM33Jp/5RXtj2/8miZQ+iacZsoqH38XV0cuI74NifSopG3mV2tV1FFSazlGZ0dHo7Gkh
 UmyXDnYGcaIrtuk11oWLb+eq4gdvAAxLGzZIXj3bsWbQ==
X-Forward-Email-ID: 688cf4d3ba56726f0787e032
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: Add support for ROCK 5B+
Date: Fri,  1 Aug 2025 17:09:26 +0000
Message-ID: <20250801170933.2530191-1-jonas@kwiboo.se>
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

This series add support for the ROCK 5B+ variant to the existing
rock5b-rk3588 defconfig taget.

The ROCK 5B+ variant is detected based on DRAM type (LPDDR5) and SARADC
channel 5, the read out value is expected to be close to 4095 (1.8v) on
5B+ variants.

Features tested on a ROCK 5B+ v1.2:
- SD-card boot
- eMMC boot
- SPI flash boot
- PCIe/NVMe
- Ethernet
- USB/TCPM

Changes in v2:
- Add a DRAM type check to detected ROCK 5B+ variant
- Drop device tree patches merged with the v6.16-dts sync

Jonas Karlman (2):
  rockchip: sdram: Add rockchip_sdram_type() helper
  rockchip: rock5b-rk3588: Add support for ROCK 5B+

 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
 arch/arm/include/asm/arch-rockchip/sdram.h   |  3 +
 arch/arm/mach-rockchip/sdram.c               | 15 +++++
 board/radxa/rock5b-rk3588/Kconfig            |  5 ++
 board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
 board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 63 ++++++++++++++++++++
 configs/rock5b-rk3588_defconfig              |  1 +
 doc/board/rockchip/rockchip.rst              |  2 +-
 9 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi

-- 
2.50.1

