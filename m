Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E337EC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 22:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965DD82E52;
	Tue, 15 Jul 2025 00:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="djE4a2V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D460D82E52; Tue, 15 Jul 2025 00:34:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A71483013
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 00:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752532461;
 bh=oSyi3ZkWDepqxkLU0X+dIsSq5SGo75GvGbKeJ0thmkc=;
 b=djE4a2V+VYe+GLjnijwIEvanHvr/UT3d/1WsiC4yMqUFWFSGpxv2OMmgCLyX8SehjnMUOnMAA
 k5GNZvq5/n2OhbRFOv+89JgWKpKqnDLRA8eAilvvFojqxCznBzsqglXgVwpypd2lvpd07gXSivE
 J6yYLs3kIyIYIvS+OHV79DlFCq+tP62I2yhD7JtZai0uUfhcZ+3NADyVG3N0Pgv7AmW5zCAOnT/
 cSbVOpBGQe3qjTsnpWiCAt3S/Vp9KlW4sBQC8cWtxnsphd1Rnnt6oreBbqM1KDtGhlRgIAFzagE
 RR+wd9d+Y2cdWzqu3vSnotV1MmegYksiBVMw+jmqwSpw==
X-Forward-Email-ID: 687585e89931367d30116e0d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Add support for ROCK 5B+
Date: Mon, 14 Jul 2025 22:33:57 +0000
Message-ID: <20250714223410.1836893-1-jonas@kwiboo.se>
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

This series add support for the ROCK 5B+ variant to the existing
rock5b-rk3588 defconfig taget.

Three device tree commits are picked from v6.16-rc1-dts to add required
DT changes.

The ROCK 5B+ variant is detected based on SARADC channel 5, the read out
value is expected to be close to 4095 (1.8v) on 5B+ variants.

Features tested on a ROCK 5B+ v1.2:
- SD-card boot
- eMMC boot
- SPI flash boot
- PCIe/NVMe
- Ethernet
- USB/TCPM

Diederik de Haas (1):
  arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3588-rock-5b

Jonas Karlman (1):
  rockchip: rock5b-rk3588: Add support for ROCK 5B+

Sebastian Reichel (2):
  arm64: dts: rockchip: move rock 5b to include file
  arm64: dts: rockchip: add Rock 5B+

 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi  |   3 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |   5 +
 board/radxa/rock5b-rk3588/Kconfig             |   5 +
 board/radxa/rock5b-rk3588/MAINTAINERS         |   3 +-
 board/radxa/rock5b-rk3588/rock5b-rk3588.c     |  55 +
 configs/rock5b-rk3588_defconfig               |   1 +
 doc/board/rockchip/rockchip.rst               |   2 +-
 .../arm64/rockchip/rk3588-rock-5b-plus.dts    | 113 +++
 .../src/arm64/rockchip/rk3588-rock-5b.dts     | 952 +-----------------
 .../src/arm64/rockchip/rk3588-rock-5b.dtsi    | 945 +++++++++++++++++
 10 files changed, 1139 insertions(+), 945 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b-plus.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dtsi

-- 
2.49.0

