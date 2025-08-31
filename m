Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12510CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C186838EC;
	Sun, 31 Aug 2025 13:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DAOUhSeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABE783906; Sun, 31 Aug 2025 13:42:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF96C838AA
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be; t=1756640564;
 bh=e0duAhRH7yjpSAWU98g9WLx0VaaFOyvD+jq0nW63Qwo=;
 b=DAOUhSeDnOR9UK1oBh3Bzws1E4QvLcM0ZHnR9j58Cb40U6JKlN0pEhrvgKJ0P2IAF3l1hnYYK
 2BHQhgeb9qKZ7neqrjvA9qj438TPQ03uuw79SLlOkVTkJUZSvoD96OadJi2y0EvLVUnNwvFDER9
 bAz+1ZN4etAiN/8lFbUgUay7Ek+iUio3I4wK1MHezBSTx/bHu6hZIzJ4WCnGAsvoFIEOTFk4MuU
 kaEmIn1l7Yf/qy+309TXM1LF20LvSLzqNBX2mD7eklRODMWdyEH1IkWprjfh97LQfoqyb8W6WiV
 BWQCmYRLJSWz2b8wuz9q7dM2wF5OXWyGFg1omDgkjT9w==
X-Forward-Email-ID: 68b4353332f03f9a5e908b5c
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
Cc: John Clark <inindev@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] board: rockchip: Add Luckfox Omni3576 and FriendlyElec
 NanoPi M5
Date: Sun, 31 Aug 2025 11:42:26 +0000
Message-ID: <20250831114238.2667242-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series add initial support for the Luckfox Omni3576 and
FriendlyElec NanoPi M5 boards. Device tree files for these boards has
been picked from the v6.17-rc1-dts tag.

Features tested with a Core3576 Rev1.1 on a Omni3576 carrier board:
- SD-card boot
- eMMC boot
- LED
- PCIe/NVMe
- USB2.0 HOST

Features tested on a NanoPi M5 2411:
- SD-card boot
- SPI flash boot
- Ethernet
- LEDs
- PCIe/NVMe
- USB HOST/OTG
- USER button

This series depend on the "board: rockchip: Add Radxa ROCK 4D" [1]
series for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2130471/

John Clark (2):
  arm64: dts: rockchip: Add Luckfox Omni3576 Board support
  arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support

Jonas Karlman (2):
  board: rockchip: Add Luckfox Omni3576
  board: rockchip: Add FriendlyElec NanoPi M5

 .../dts/rk3576-luckfox-omni3576-u-boot.dtsi   |  11 +
 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi     |  22 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  12 +
 configs/nanopi-m5-rk3576_defconfig            |  78 ++
 configs/omni3576-rk3576_defconfig             |  63 ++
 doc/board/rockchip/rockchip.rst               |   2 +
 .../rockchip/rk3576-luckfox-core3576.dtsi     | 749 ++++++++++++++
 .../rockchip/rk3576-luckfox-omni3576.dts      |  51 +
 .../src/arm64/rockchip/rk3576-nanopi-m5.dts   | 941 ++++++++++++++++++
 9 files changed, 1929 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
 create mode 100644 configs/nanopi-m5-rk3576_defconfig
 create mode 100644 configs/omni3576-rk3576_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-luckfox-core3576.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-luckfox-omni3576.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts

-- 
2.51.0

