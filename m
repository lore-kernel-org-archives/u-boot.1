Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D5C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E59FB83A92;
	Fri,  1 Aug 2025 22:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qEjc1UYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A33383AF6; Fri,  1 Aug 2025 22:33:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFD1839E8
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754080385;
 bh=AlbWwx4ZRZzn9Brd/dsYeFMwWb8fUPqyZcCur7LRHHM=;
 b=qEjc1UYGPnR3MbPM/HpWhdLEtEFB2rBs4bBXGxxhUg2AKrGOC3vpvkJaxjGPFr/vlj4UDcU/x
 YBg8O3FNTjwGT1Iml1E2Qb6VZ6GCkiDp0j0W3vE0UYcvL/JaoEOT4U3Lpp32HxjBmY8sMvtQ9rV
 0iVJQDp/po8TxtB4izSBjESdzn8tqW37rehQBAAslAYCbYR68gveZApvNOeTRxhiM3yWocAOiBE
 cMUD8GbqnfMEfssx9UlUScnnxF9nV0kthNR34XwbDjdMURS40qfm0/UZ8HRp3BmjmL1PfXlSwsD
 Hq9sezglqtjJr1eQM375gJ9k0k+QdIrXFKMj+h6AkO5g==
X-Forward-Email-ID: 688d247c03c11ad4017607f6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/8] rockchip: rk3576: Add rng,
 checkboard() and generic board
Date: Fri,  1 Aug 2025 20:32:36 +0000
Message-ID: <20250801203255.2590535-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
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

This is a follow-up series on top of the original "Support for the
RK3576" series, merged in v2025.07. It adds support for RNG, USB, a
generic board and printing of the running SoC variant.

Changes in v3:
- Add USB glue and USB PHY related patches
- Drop use of USBDP PHY for generic board
- Drop device tree patches merged with the v6.16-dts sync
- Collect r-b tag

Changes in v2:
- Add RNG node by picking a commit from devicetree-rebasing
- Add compatible for RK3576 to RNG driver
- Add default USB_GADGET_PRODUCT_NUM for RK3576
- Add USB OTG nodes to the minimal generic RK3576 board
- Split the checkboard() patch in two
- Split out the ArmSoM Sige5 patch into a separate series

It is recommended to also apply "rockchip: Fix misc USB PHY related
issues" [1] to ensure USB can work reliable.

[1] https://patchwork.ozlabs.org/cover/2114085/

Frank Wang (2):
  phy: rockchip-inno-usb2: Add support for RK3576
  phy: rockchip: usbdp: Add support for RK3576

Jonas Karlman (6):
  rng: rockchip_rng: Add compatible for RK3576
  rockchip: Add default USB_GADGET_PRODUCT_NUM for RK3576
  board: rockchip: Add minimal generic RK3576 board
  rockchip: rk3576: Implement checkboard() to print SoC variant
  arm: dts: rockchip: Include OTP in U-Boot pre-reloc phase for RK3576
  usb: dwc3-generic: Use combined glue and ctrl node for RK3576

 arch/arm/dts/rk3576-generic-u-boot.dtsi       |  3 +
 arch/arm/dts/rk3576-generic.dts               | 63 +++++++++++++++++++
 arch/arm/dts/rk3576-u-boot.dtsi               |  4 ++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  5 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c        | 48 ++++++++++++++
 configs/generic-rk3576_defconfig              | 50 +++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 ++++++++
 drivers/phy/rockchip/phy-rockchip-usbdp.c     | 26 ++++++++
 drivers/rng/rockchip_rng.c                    |  4 ++
 drivers/usb/dwc3/dwc3-generic.c               |  1 +
 drivers/usb/gadget/Kconfig                    |  1 +
 12 files changed, 232 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 configs/generic-rk3576_defconfig

-- 
2.50.1

