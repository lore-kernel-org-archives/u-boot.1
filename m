Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6B4D1488B
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38658416C;
	Thu,  8 Jan 2026 15:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YqCQfDI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E91784175; Thu,  8 Jan 2026 15:36:01 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E17F84158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767882957;
 bh=HHDmNv89ydTiWVc9HW4Ya6PRNs7hekf6M3yi54gAxQA=;
 b=YqCQfDI5yxTU6p/RmRFgRN+7Px7w6FHgYmViC211vGAAPAKKoLcksvubG1GT8/NdZyGgQD9KC
 iBTkEY9C1fychwO0Xxq/PpeTP5M1lBh9B04ozosxK2jbV9L5zlHelv6/08N49bnkfIGREOuWABA
 2NBtykixEu0w+6FvYEYdxeDVf4mKF52tr00NRIGIKwcKTP7ipQ6GqA7pd8u6tQ//lU8Uqg0y74/
 dkrrsFMwv7pnJSWIgWHu8Vi0Cnkvp/U4QL/vLJ+KCeWxdzVbrWJY8gwbs9kmT4M1SlzurNEgzYL
 qzCgBK4ypLPQke5hPcVhnz+l5/XCS8xmDD1bxsMSuisA==
X-Forward-Email-ID: 695fc0cc1cb082e77da570b2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tianling Shen <cnsztl@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add FriendlyElec NanoPi R76S
Date: Thu,  8 Jan 2026 14:35:44 +0000
Message-ID: <20260108143551.4017839-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

Jonas Karlman (1):
  board: rockchip: Add FriendlyElec NanoPi R76S

Tianling Shen (1):
  arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R76S

 arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi   |   3 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |   6 +
 configs/nanopi-r76s-rk3576_defconfig          |  60 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3576-nanopi-r76s.dts | 860 ++++++++++++++++++
 5 files changed, 930 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
 create mode 100644 configs/nanopi-r76s-rk3576_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-nanopi-r76s.dts

-- 
2.52.0

