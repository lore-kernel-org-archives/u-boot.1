Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D4ACE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E09C88F47;
	Thu, 24 Oct 2024 17:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BF788F45; Thu, 24 Oct 2024 17:25:10 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C8B8B88C3E
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903766"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:05 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3F46B4009A09;
 Fri, 25 Oct 2024 00:25:01 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 00/14] Add support for Ethernet interfaces on RZ/G2L
Date: Thu, 24 Oct 2024 16:24:34 +0100
Message-Id: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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

This patch series enables the usage of both Ethernet interfaces on the
Renesas RZ/G2L SMARC EVK board. This requires changes to the RZ/G2L
clock driver, RZ/G2L pinctrl driver, ksz9131 phy driver and ravb network
driver. Once all drivers have the required support, we enable the
relevant options in the RZ/G2L defconfig and cherry-pick required
devicetree changes from Linux v6.12-rc4.

Paul Barker (14):
  clk: rzg2l: Ignore enable for core clocks
  pinctrl: rzg2l: Support 2.5V PVDD for Ethernet interfaces
  pinctrl: rzg2l: Support Ethernet TXC output enable
  pinctrl: rzg2l: Drop unnecessary scope
  net: phy: Port set/clear bits from Linux
  net: phy: ksz90x1: Handle ksz9131 LED errata
  net: phy: ksz90x1: Load skew values from device tree
  net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay
  net: ravb: Support up to two instances
  net: ravb: Simplify max-speed handling in ravb_of_to_plat
  net: ravb: Add RZ/G2L Support
  renesas_rzg2l_smarc_defconfig: Enable networking support
  arm64: dts: renesas: rzg2l: Enable Ethernet TXC output
  arm64: dts: renesas: rzg2l: Set Ethernet PVDD to 1.8V

 arch/arm/mach-renesas/Kconfig                 |   1 +
 configs/renesas_rzg2l_smarc_defconfig         |   6 +
 drivers/clk/renesas/rzg2l-cpg.c               |   8 +
 drivers/net/Kconfig                           |   2 +
 drivers/net/phy/micrel_ksz90x1.c              | 161 +++++++++++--
 drivers/net/ravb.c                            | 216 ++++++++++++++++--
 drivers/pinctrl/renesas/rzg2l-pfc.c           |  83 +++++--
 .../src/arm64/renesas/rzg2l-smarc-som.dtsi    |  86 ++++---
 include/phy.h                                 |  22 ++
 include/renesas/rzg2l-pfc.h                   |   4 +
 10 files changed, 505 insertions(+), 84 deletions(-)

-- 
2.43.0

