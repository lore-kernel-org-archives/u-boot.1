Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44124CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6B3831D6;
	Sun, 19 Oct 2025 18:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Oi91c9Gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E51831D6; Sun, 19 Oct 2025 18:51:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45FC831D6
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1760892667;
 bh=EWUutq7O+dwUZl5carrL/ffd6PhgVfYsLbnEoUPsVSU=;
 b=Oi91c9GgRCZtsKOJdEDF3ZF10nBLhXx7LKyfj8wu+I+4obQBRLv2SlISD4lw24UvgZAuMWLNJ
 dXEOcuFxdeUVLIdxr0Utvn7ZQ9S9tQwe+2HnJhVhuDotz4EX6Dm0yUhVs8iHVu5eBlLMLFSn3FM
 wTlP834oBzR1GYlJSFB1GD/LAH7fmbrWlpMIjJx+M3xe1QtNSG/AYstg6tXhJ65xeAacZ+apcf7
 wtRzrGikF8NHC+bC3BqxLwA4iJ9+PG3Jp/UbkWKUnzRrYYxvsGnOjq0AMm7QTzqgj1j+LJQjyM9
 PShPtvHD8hFIu/8PHBAiffEJ1RTHrV1Csc1bZsp4hjiQ==
X-Forward-Email-ID: 68f516f65ea0c674272441d8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: John Clark <inindev@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] board: rockchip: Add Luckfox Omni3576 and FriendlyElec
 NanoPi M5
Date: Sun, 19 Oct 2025 16:50:49 +0000
Message-ID: <20251019165056.885394-1-jonas@kwiboo.se>
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

This series add initial support for the Luckfox Omni3576 and
FriendlyElec NanoPi M5 boards.

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

Changes in v2:
- Rebase on top of master with v6.17-dts tag merged

This series depend on the "board: rockchip: Add Radxa ROCK 4D" [1]
series for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2152825/

Jonas Karlman (2):
  board: rockchip: Add Luckfox Omni3576
  board: rockchip: Add FriendlyElec NanoPi M5

 .../dts/rk3576-luckfox-omni3576-u-boot.dtsi   | 11 +++
 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi     | 22 ++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     | 12 +++
 configs/nanopi-m5-rk3576_defconfig            | 78 +++++++++++++++++++
 configs/omni3576-rk3576_defconfig             | 63 +++++++++++++++
 doc/board/rockchip/rockchip.rst               |  2 +
 6 files changed, 188 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-nanopi-m5-u-boot.dtsi
 create mode 100644 configs/nanopi-m5-rk3576_defconfig
 create mode 100644 configs/omni3576-rk3576_defconfig

-- 
2.51.0

