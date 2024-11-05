Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC8D3E776
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA028900E;
	Tue,  5 Nov 2024 22:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="R9C6Pn1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFD58900E; Tue,  5 Nov 2024 22:52:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D0088E43
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730843530;
 bh=F9KQRTf6jODDL9LC4f0FaqegrYDL6RqHzb2dzMJvFIo=;
 b=R9C6Pn1PN3P7UsE/D2v/b634MzQOBmVHORB4qMhDCy8SH0g5eVzVDknvH+7ZxQ+x56CESUdyP
 hHPaJeItLXYM6tK4cUJ4cJ20Xi7HXSfCoizhPWXVzQDSxsQMp0lfxiZz5I2kMpYHIWyIyf+UrbC
 BmIvnztnlH1447ujL3OL5pYY6zrplZ55GA4XGHsP7cM43buCWZ+mBlRRfDXTUYmI2t+H/aEw5tt
 7d4IlcSgtRvfgMaWirvuujMLoW92iZuplbn5ji2KJkbPcchS+/MLpK1KcAS+S15l3ukpfdqWYB3
 DsSI4HBJeBbEgZrghTz00n1Hz5UsbW1SyloVIxPGeVPg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/11] rockchip: rk3288-miqi: Migrate to OF_UPSTREAM
Date: Tue,  5 Nov 2024 21:51:36 +0000
Message-ID: <20241105215202.1491441-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a9389059db14dd83d7aaf
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

This series migrate MiQi to use OF_UPSTREAM, ensure devices and pinctrl
is included in xPL control FDT, set ethaddr based on cpuid and finally
change to use FIT with checksum validation.

I do not have a MiQi board and have only done limited runtime test, with
adjusted sdram props, on a Tinker Board.

This series have a loose dependancy on the "rockchip: rk3288-tinker:
Migrate to OF_UPSTREAM" series. Specifically that series change to
SYS_MALLOC_F_LEN and TPL variant in Kconfig.

Jonas Karlman (11):
  rockchip: rk3288-miqi: Sort u-boot.dtsi nodes alphabetically
  rockchip: rk3288-miqi: Remove unused work led node from xPL
  rockchip: rk3288-miqi: Set ethaddr env based on cpuid
  rockchip: rk3288-miqi: Use TPL with common bss and stack addresses
  rockchip: rk3288-miqi: Include required DT nodes in xPL
  rockchip: rk3288-miqi: Include sdmmc regulator in SPL
  rockchip: rk3288-miqi: Drop use of silent console and late boardinfo
  rockchip: rk3288-miqi: Drop USE_PREBOOT Kconfig option
  rockchip: rk3288-miqi: Migrate to OF_UPSTREAM
  rockchip: rk3288-miqi: Fix slow Ethernet initializion
  rockchip: rk3288-miqi: Change to use FIT

 arch/arm/dts/Makefile                 |   1 -
 arch/arm/dts/rk3288-miqi-u-boot.dtsi  |  83 ++++-
 arch/arm/dts/rk3288-miqi.dts          |  16 -
 arch/arm/dts/rk3288-miqi.dtsi         | 417 --------------------------
 arch/arm/mach-rockchip/rk3288/Kconfig |   2 +
 board/mqmaker/miqi_rk3288/MAINTAINERS |   1 -
 configs/miqi-rk3288_defconfig         |  43 +--
 7 files changed, 93 insertions(+), 470 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-miqi.dts
 delete mode 100644 arch/arm/dts/rk3288-miqi.dtsi

-- 
2.46.2

