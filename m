Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2CBD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B61891A4;
	Tue,  5 Nov 2024 17:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BHiC46Fe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32ED1891A4; Tue,  5 Nov 2024 17:01:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2A58900E
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730822464;
 bh=noO18jrsyxCl8m4ykSqjKfvWwIjHixTQkYWYe7h+Q9k=;
 b=BHiC46Fe8rjHGNrB1aHFf2HIgpAfH7W31J10pozE5139a3VYtCN3B6qhppXLofLX09u0y/DdO
 hlQFiQ98Ks1FZIz7W3z1W7ufA8ar2hzCJd6ZtjoxQhrH/ZK2qa+wgfTSkGLMuqbKljykbPMrL37
 J/hFBUZqTOTgp5oNvAlwSTt/HhofmDN1SCmnhAIwpvf5oO+NgQyuOkGKLhVK/Ew2nxZ5oi4gMz8
 YUf2/JbZfMma1hb6Jc1LnwPh/oiupRortoLfyH/awAoLYZj39RCa8dPzPcr00hGUKvkZNV+P/Oz
 xtEQKPXcYj0+vyO/J6Lsu2B9nRVwvPVJEOCSgN12zmwg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/13] rockchip: rk3288-tinker: Migrate to OF_UPSTREAM
Date: Tue,  5 Nov 2024 16:00:23 +0000
Message-ID: <20241105160054.1373319-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a413fff3e144e4725e085
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

This series migrate Tinker Board to use OF_UPSTREAM, cleanup devices and
pinctrl included in xPL control FDT and finally change to use FIT with
checksum validation.

TPL continue to OF_PLATDATA after this series, however boot testing was
done with and without use of OF_PLATDATA.

Features tested on a Tinker Board S:
- SD-card boot
- eMMC boot
- Ethernet
- USB gadget
- USB host

Jonas Karlman (13):
  board: rockchip: rk3288-tinker: Add myself as reviewer to MAINTAINERS
  rockchip: rk3288-tinker: Sort u-boot.dtsi nodes alphabetically
  rockchip: rk3288-tinker: Only include required DT nodes in TPL
  rockchip: rk3288-tinker: Drop unused vcc_sd regulator from SPL
  rockchip: rk3288-tinker: Include mmc nodes in pre-reloc for env load
  rockchip: rk3288-tinker: Set cpuid and serial env var
  rockchip: rk3288-tinker: Sync defconfig options from rk3288-tinker-s
  rockchip: rk3288-tinker: Use common bss and stack addresses
  rockchip: rk3288-tinker: Drop use of silent console and late boardinfo
  rockchip: rk3288-tinker: Drop USE_PREBOOT Kconfig option
  rockchip: rk3288-tinker: Migrate to OF_UPSTREAM
  rockchip: rk3288-tinker: Fix slow Ethernet initializion
  rockchip: rk3288-tinker: Change to use FIT

 arch/arm/dts/Makefile                        |   2 -
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi     |  13 +-
 arch/arm/dts/rk3288-tinker-s.dts             |  29 -
 arch/arm/dts/rk3288-tinker-u-boot.dtsi       |  53 +-
 arch/arm/dts/rk3288-tinker.dts               |  33 --
 arch/arm/dts/rk3288-tinker.dtsi              | 533 -------------------
 arch/arm/mach-rockchip/rk3288/Kconfig        |   6 +-
 board/rockchip/tinker_rk3288/MAINTAINERS     |   7 +-
 board/rockchip/tinker_rk3288/tinker-rk3288.c |   2 +-
 configs/tinker-rk3288_defconfig              |  41 +-
 configs/tinker-s-rk3288_defconfig            |  38 +-
 11 files changed, 81 insertions(+), 676 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-tinker-s.dts
 delete mode 100644 arch/arm/dts/rk3288-tinker.dts
 delete mode 100644 arch/arm/dts/rk3288-tinker.dtsi

-- 
2.46.2

