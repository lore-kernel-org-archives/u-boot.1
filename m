Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D32FCC9A4
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246BF83F2A;
	Tue, 10 Mar 2026 01:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0GRFwfVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEAC083BC8; Tue, 10 Mar 2026 01:06:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6805983981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1773101181;
 bh=k0B37/NhVA7gDohEFDDNZn0DVy4rh1NIPyIYb325qsE=;
 b=0GRFwfVMHz6TopVs/Aof45cRIzNspJeKVjHH0ihJIIDBqwt0pHe1Gm1hTLiYLX8LZiyZER0wo
 u+DYAY0kzYTvYv5iKF7Uq44cb18aRytPeRYvvwoh0x/qkxK1zWzc324p1ryYjr+Ib/CSUIccKiZ
 oajKcFIrtXjGmGrOfN/Q6KmMvVmNssWG/rh27pkHXPAJRd/GoYtn5zOGpqaKiQ3IVANrhWj/GpK
 QomdvlJyRMPtamKDlXTO8ypHzgaS4UpHGTlQ2ILU9fQVw/fYzdLKjiEvo4elqrE5Nm35x14/8LF
 xfpqhLJcisJwzATMZp2MQRx/SEWozDOCoKLj3Nxqu/PQ==
X-Forward-Email-ID: 69af6077746be01f0a4eb8e6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Tianling Shen <cnsztl@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] board: rockchip: Add FriendlyElec NanoPi R76S
Date: Tue, 10 Mar 2026 00:06:03 +0000
Message-ID: <20260310000610.592998-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
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

This series add initial support for the FriendlyElec NanoPi R76S board.

Features tested on a NanoPi R76S 2411:
- SD-card boot
- eMMC boot
- LEDs and button
- PCIe/Ethernet
- USB host

Changes in v2:
- Remove arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
- Collect r-b tag

Jonas Karlman (1):
  board: rockchip: Add FriendlyElec NanoPi R76S

Tianling Shen (1):
  arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R76S

 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |   6 +
 configs/nanopi-r76s-rk3576_defconfig          |  60 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3576-nanopi-r76s.dts | 860 ++++++++++++++++++
 4 files changed, 927 insertions(+)
 create mode 100644 configs/nanopi-r76s-rk3576_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-nanopi-r76s.dts

-- 
2.53.0

