Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E21C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 17:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB79081879;
	Sun, 30 Mar 2025 19:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q7C5Pcbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DF78171B; Sun, 30 Mar 2025 19:20:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739E680FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 19:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1743355249;
 bh=5RMHYPccOTJXT/RomCzTUjScDIuUZk8bDlgkVZ5eYKk=;
 b=q7C5PcbjPvz+317wB5VmsymgxV+Fay3MBkubuO0P20+9sWIysSYLe8ua/hICJ5KWBk5TqHF3Y
 lTQgcU4jhQKWdVxC9qUhX8eegFDQXjGbP1YI07qdpof7hH1uuDHoRIrFRZc2E+8oKnWdwToEja4
 uxPaCQj4f2y9KOHL+RR3klSqRlEbZoV9kOD7m2EXYBBa+r5GNQ5oVpVo2tTizYsUD3PXC3QeIhX
 1qQf5HDVl/ajPNSjV9xGl5yeMIgYffhNOEkHuMQWfTOygk5tXPF3lKSLe5Y4XsewppzvUggJs2c
 yn0yVRoz4b8GAc/b+llaQ8CO1S8flEA6IiuNy9PnVHTA==
X-Forward-Email-ID: 67e97d6e8935e384c291932c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: Add minimal generic RK3328 and RK3399 boards
Date: Sun, 30 Mar 2025 17:20:33 +0000
Message-ID: <20250330172040.3370919-1-jonas@kwiboo.se>
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

This series adds minimal generic board targets for RK3328 and RK3399,
like existing minimal generic boards for RK3566/RK3568, RK3588S/RK3588,
pending RK3528 [1] and upcoming RK3576 targets.

These generic boards can be used to boot into U-Boot and/or Linux on
most boards that follow reference board design with the use of Rockchip
TPL blobs. E.g. to use USB OTG with rockusb or ums to access eMMC,
SD-card or SPI flash storage.

I have tested several of the different RK3328 and RK3399 boards I have,
and boards can boot into U-Boot regardless of DRAM type with latest ddr
init blobs.

Changes in v2:
- Rebase on next after TPL_HAVE_INIT_STACK change
- Add CONFIG_ROCKCHIP_IODOMAIN is not set to generic-rk3399 due to [3]

This series depends on the series "rockchip: ROCKCHIP_COMMON_STACK_ADDR
improvements" v2 [2] for a clean apply.

[1] https://patchwork.ozlabs.org/patch/2038159/
[2] https://patchwork.ozlabs.org/cover/2050003/
[3] https://patchwork.ozlabs.org/patch/2042445/

Jonas Karlman (2):
  board: rockchip: Add minimal generic RK3328 board
  board: rockchip: Add minimal generic RK3399 board

 arch/arm/dts/rk3328-generic-u-boot.dtsi | 39 +++++++++++
 arch/arm/dts/rk3328-generic.dts         | 76 +++++++++++++++++++++
 arch/arm/dts/rk3399-generic-u-boot.dtsi | 10 +++
 arch/arm/dts/rk3399-generic.dts         | 83 +++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          |  2 +-
 board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
 board/rockchip/evb_rk3399/MAINTAINERS   |  6 ++
 configs/generic-rk3328_defconfig        | 90 +++++++++++++++++++++++++
 configs/generic-rk3399_defconfig        | 77 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  2 +
 10 files changed, 390 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3328-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-generic.dts
 create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3399-generic.dts
 create mode 100644 configs/generic-rk3328_defconfig
 create mode 100644 configs/generic-rk3399_defconfig

-- 
2.49.0

