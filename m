Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74439C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A6588644;
	Wed, 31 Jul 2024 23:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IjXzIPvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A581B88644; Wed, 31 Jul 2024 23:12:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D275388580
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 23:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722460350;
 bh=m2QgoPQufcZCkpdu7D2hjQGoQZo6kXLqA0TR7trFbc0=;
 b=IjXzIPvwE+s3OiibzXFTqofIgLz57kL1/FRqbMcMZ5bW4xvksqBTPHOefC02RWHSRA8iptwN9
 ckvS4lwVTJoF/Vm2CS0IRvknqGmkNroyaRqrGOq1jgseNCBZzJltx4auhzmghQyXfzmBPISNlUo
 a+RqDkQe0gHWAJAPYsHhDYGI+Mbr58fAlrpFFB/w5CvZESRkW+xkEM4Ims3jOrnEEQ/5J3IweF5
 Zf0GOlIxyKarx9B7TXXYZ8dFEzKZefQLreeyhbGPleHLCGR0pIhuqRMDyUo93fDTCnp8Jo/TkhJ
 bF17Fy2A9eDAIUDctBLIalbAsDaUCvqKaZQL5g0APEZw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Kropatsch <seb-dev@mail.de>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add FriendlyElec CM3588 NAS
Date: Wed, 31 Jul 2024 21:12:14 +0000
Message-ID: <20240731211221.1523453-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66aaa8bb06984f15edfbc582
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

This series add support for the RK3588 based FriendlyElec CM3588 NAS
board.

Features tested on a CM3588 NAS Kit with 8GB RAM 64GB eMMC module:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Jonas Karlman (1):
  board: rockchip: Add FriendlyElec CM3588 NAS

Sebastian Kropatsch (1):
  arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board

 ...rk3588-friendlyelec-cm3588-nas-u-boot.dtsi |   8 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |  24 +
 board/friendlyelec/cm3588-nas-rk3588/Kconfig  |  12 +
 .../cm3588-nas-rk3588/MAINTAINERS             |   6 +
 configs/cm3588-nas-rk3588_defconfig           |  90 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../rk3588-friendlyelec-cm3588-nas.dts        | 778 ++++++++++++++++++
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 653 +++++++++++++++
 8 files changed, 1572 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/Kconfig
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS
 create mode 100644 configs/cm3588-nas-rk3588_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-friendlyelec-cm3588-nas.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-friendlyelec-cm3588.dtsi

-- 
2.45.2

