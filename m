Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBE5CCD1AB
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 05:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD80783741;
	Sun, 19 Oct 2025 07:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bQDgSWsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80BF8381D; Sun, 19 Oct 2025 07:26:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E9083438
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 07:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 13CAF26295;
 Sun, 19 Oct 2025 07:26:22 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLy92tLtIfyE; Sun, 19 Oct 2025 07:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760851581; bh=r3ETFt0TobBkma852UD80o2Q8lmN4ukoI2gm/Ye6v9Q=;
 h=From:To:Cc:Subject:Date;
 b=bQDgSWsPriOU6M53LEzHNFtNVKzOvABHnyaIILiNXC2gVc4n6QmcKhS+BTdtTN0+A
 Vqit7nA0MkcyODkKuodzl4WaVNVUBph1udtkUmn5lPs9pZyINSSfY1NdnZd7VNU0tZ
 bNc6LAZoO4MsVH3R7Iy7tv2NgS2mgQIdPSGiwr3ELXYjcdFHZN0tIFSbzg9Gqax2a7
 sKUu2C1z2MIXpHH6JRhyhd/wJ4F4MF0QoZnXJhzrHZEhH6aKCXQ6j8Ech9foB6GUnm
 PV0eGt2efoAOMP/qP4+ygt4/CR2Ua2ULHVNk5stgk8TMd4V/29GujnOhXWc7yS5UXR
 KsIc+C7whinqg==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 0/2] Add support for FriendlyElec NanoPi Zero2 board
Date: Sun, 19 Oct 2025 05:26:05 +0000
Message-ID: <20251019052607.61702-1-ziyao@disroot.org>
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

This series cherry-picks the upstream board devicetree, add board
configuration and U-Boot devicetree pieces for the board. A wiki page
for the board could be found here[1].

I've tested booting from SD-card and network through EFI and PXE.
On-board LEDs are driven correctly, and button states could be read.

[1]: https://wiki.friendlyelec.com/wiki/index.php/NanoPi_Zero2

Jonas Karlman (1):
  arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2

Yao Zi (1):
  board: rockchip: Add FriendlyElec NanoPi Zero2

 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi  |  11 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS     |   6 +
 configs/nanopi-zero2_defconfig                |  46 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3528-nanopi-zero2.dts    | 340 ++++++++++++++++++
 5 files changed, 404 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
 create mode 100644 configs/nanopi-zero2_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts

-- 
2.50.1

