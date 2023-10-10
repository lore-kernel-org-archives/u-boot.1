Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E9FCD98C0
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 22:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF47486C43;
	Wed, 11 Oct 2023 00:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O966umMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FC486B8D; Wed, 11 Oct 2023 00:24:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BA286B57
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 00:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f707=FZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1696976631;
 bh=00snIXvPNp6FcQhJ6M/h9wERdWyCYsFSir8Pfgp5aJs=;
 b=O966umMHtb2JRnQP5xlIW0gbjWsZm8kU+1xrdqzRNTo2DGcg4vskikm8pl1Bf9axzigC1/kng
 iuc/LgKK1eEldPeCq/JhDUMkWpD/6LWM/sGv3U/r5h54d6opGJIgmCiVu6RhOUCMT3LKAR7T8h/
 MuKO08fhsXQVuVv6aNXU4FRuVK72LvCu+cVpElxAh758VgyKqlqJGlvxQyXJwKghqluMzhDPG0n
 y17SwbFW3+/1eQTKStIVWWt/d+uPTrKfCkIq/Srjv5mPBe0giXhlrNN1RJOwoSWeOh4P9noez4+
 uL5dwrLmby/eQkLI9yKZgD0QRPeXdyW+9p9f0HRejz4g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: rk3588: Sync pcie and usb3 nodes from linux
Date: Tue, 10 Oct 2023 22:23:34 +0000
Message-ID: <20231010222344.3436526-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6525cef6dfb1822b4d6ef2ec
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

This series sync rk3588 device tree nodes from latest mainline linux
maintainer tree and also update usb3 nodes with latest submitted patches.

Patch 1 sync latest device tree from latest linux maintainer tree to
move pcie and spi flash nodes away from -u-boot.dtsi files.

Patch 2 fully enable pcie and ahci/sata support on rk3588-rock-5b.

Patch 3 sync usb3 nodes with latest pending patches in order to drop
use of rockchip,rk3399-dwc3 compatible.

Patch 4 adds support for rockchip,rk3588-dwc3 compatible to the
dwc3-generic driver.

Jonas Karlman (4):
  rockchip: rk3588: Sync device tree from linux maintainer tree
  rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards
  rockchip: rk3588-rock-5b: Sync USB3 nodes from mainline linux patches
  usb: dwc3-generic: Use combined glue and ctrl node for RK3588

 arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi |  11 +-
 arch/arm/dts/rk3588-evb1-v10.dts         |  98 +++++++++++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi  | 204 +++++------------------
 arch/arm/dts/rk3588-rock-5b.dts          | 140 ++++++++++++++++
 arch/arm/dts/rk3588-u-boot.dtsi          |  40 ++---
 arch/arm/dts/rk3588s-pinctrl.dtsi        |  44 +++++
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi |   4 -
 arch/arm/dts/rk3588s-u-boot.dtsi         |  78 +++++----
 arch/arm/dts/rk3588s.dtsi                |  11 ++
 configs/rock5b-rk3588_defconfig          |   7 +-
 drivers/usb/dwc3/dwc3-generic.c          |   1 +
 11 files changed, 397 insertions(+), 241 deletions(-)

-- 
2.42.0

