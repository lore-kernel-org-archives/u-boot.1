Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23ECF34C1
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC5488EFB;
	Thu,  3 Oct 2024 21:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UgRe5d4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6C688F47; Thu,  3 Oct 2024 21:59:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F7B88E60
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 21:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a5dc=RA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1727985590;
 bh=Kn10omkPhuI4ImEe52BG7daXJvhuSWiS8ciiPztafL0=;
 b=UgRe5d4hoC3pUwsaUKWuyfw6/zENGkQr5l+mcH3UlaFvMBWp6StdlA6cX2y5dOlu5PR4WMi5Y
 oZLGRDmofX/hEk6yncSIjccvVtw2cEUEx31RS/6+vzVQDd/YRzE67Tptiu0Y3BtGJek5wwns1EZ
 IUxEli8Zvtqs1sBbiOLZPwb6SMM8FQDOoyMx35IlvgfMJt07r1zrhfXCgt9y6LBNNhZflsRIBOt
 xY6KJZ86pr6+/ywbaxcEXhX+2TZr/cOQ/q8RXTpY/dSXXjT/xBiavGE6YlY+3JlMIEcVVSZb0Xb
 o+pQYrkhPuFAlGF1k1fM8k655zUsNvEX/MaPsqAURP+w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add Hardkernel ODROID-M2
Date: Thu,  3 Oct 2024 19:59:32 +0000
Message-ID: <20241003195941.340519-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66fef7b35caab3e1f31096ce
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

This series add support for the RK3588S2 based Hardkernel ODROID-M2.

Features tested on a ODROID-M2 16GB rev1.0 20240611:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Jonas Karlman (2):
  arm64: dts: rockchip: Add Hardkernel ODROID-M2
  board: rockchip: Add Hardkernel ODROID-M2

 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi    |   3 +
 arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
 board/hardkernel/odroid_m2/Kconfig            |  12 +
 board/hardkernel/odroid_m2/MAINTAINERS        |   7 +
 configs/odroid-m2-rk3588s_defconfig           |  96 ++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3588s-odroid-m2.dts  | 903 ++++++++++++++++++
 include/configs/odroid_m2.h                   |  11 +
 8 files changed, 1040 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
 create mode 100644 board/hardkernel/odroid_m2/Kconfig
 create mode 100644 board/hardkernel/odroid_m2/MAINTAINERS
 create mode 100644 configs/odroid-m2-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts
 create mode 100644 include/configs/odroid_m2.h

-- 
2.46.2

