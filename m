Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D554DC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676358898A;
	Wed, 31 Jul 2024 09:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qAQlRY7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9F28898A; Wed, 31 Jul 2024 09:29:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C84188886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722410947;
 bh=0WOLT6+rEyrF6Qzre4qG1l1MEJiPZZ8St2DUPd0i5cw=;
 b=qAQlRY7Uu5l+2PXL8CvzSDIRkTPf4yigNr+INOwNf6Kje19jKmYJKCqNONCAuMGlfP62LpPSh
 xD1vNq7pr4JOXFUUXalkklLtH4rLF5e4XgXcD+peN1Yl+eg75IwFFw9wVL95fDaUEY3PBfKuhDw
 8sboJACr9HXgLgA6OB8OWeQnlLyuD36KJL6AovDC2uzliZhqDaYis/zuPlKJs9Axuw/G/RpGoLR
 CXV2fTibjMIteHGsuzPfFoWmAp6GPfWfHb2MqZecMG0sxWRB/jxP+qx4uWjLjvQD2hZfJqilz7N
 VCNUTmDz2uKc6c70AmWIib6lJg1JGaJR9I7WPCvsWChw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add Radxa ROCK 3B
Date: Wed, 31 Jul 2024 07:28:52 +0000
Message-ID: <20240731072858.1216627-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a9e7c173d983cd09238509
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

This series add support for the RK3568(J) based Radxa ROCK 3B boards.

Features tested on ROCK 3B 8GB v1.51 (both variants):
- SD-card boot
- eMMC boot
- SPI Flash boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Jonas Karlman (2):
  arm64: dts: rockchip: Add Radxa ROCK 3B
  board: rockchip: Add Radxa ROCK 3B

 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi       |  15 +
 board/rockchip/evb_rk3568/MAINTAINERS         |   6 +
 configs/rock-3b-rk3568_defconfig              | 100 +++
 doc/board/rockchip/rockchip.rst               |   3 +-
 .../src/arm64/rockchip/rk3568-rock-3b.dts     | 781 ++++++++++++++++++
 5 files changed, 904 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3568-rock-3b-u-boot.dtsi
 create mode 100644 configs/rock-3b-rk3568_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3568-rock-3b.dts

-- 
2.45.2

