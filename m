Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD9C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC6F828A2;
	Sat, 12 Jul 2025 00:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YyzyRQb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC2482AE9; Sat, 12 Jul 2025 00:45:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85608277D
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752273896;
 bh=286mkBN7nX7isLIrLkWgm68yel3RsN22HSQtHU+qfOc=;
 b=YyzyRQb4LFrfgFDct5Od8/hOQe9R+juyhm+1PPg9xE0nTJ/k4BHyAXaXMGheYfUoQYhpVnqGh
 /+N7AN8ZpB8sgOl0MMrUHetfftkq6g2ffPxyAgW//MDdXGmz0ZzxsNHf2J33ly/GGrp/K35nXNd
 5/o822HPPfFT2Jas8U+7irStisbjyahmcaEsuzEjaLK/h2VJeMGXY9WIRwo/eCVRq5/4MuP/35s
 EcuvmHaLERC61+Od1jPSYze4tH7RtnrTUcpqFtz+BlW5KC5XhgQ4/k3mR0+QNyFSJ6QCHisKG94
 5yM/+1obfPlHpHUcVDCZ8faQ65eICVF6towJasT7N6fQ==
X-Forward-Email-ID: 687193e226dc7c4d255610ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/6] board: rockchip: Add ArmSoM Sige5
Date: Fri, 11 Jul 2025 22:44:30 +0000
Message-ID: <20250711224446.211511-1-jonas@kwiboo.se>
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

This series add support for the ArmSoM Sige5 board and is a split from
the "rockchip: rk3576: Add rng, checkboard() and ArmSoM Sige5" v1 [1]
series.

Changes in v2:
- Pick dts/upstream commits to add PCIe nodes
- Add support for RK3576 to the naneng-combphy driver
- Enable PCIe, NVMe and USB Kconfig options

This series depends on the "rockchip: rk3576: Add rng, checkboard() and
generic board" v2 [2] series for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2075772/
[2] https://patchwork.ozlabs.org/cover/2110229/

Heiko Stuebner (1):
  arm64: dts: rockchip: fix rk3576 pcie unit addresses

Jon Lin (1):
  phy: rockchip: naneng-combphy: Add support for RK3576

Jonas Karlman (2):
  rockchip: clk: clk_rk3576: Add dummy CLK_REF_PCIEx_PHY support
  board: rockchip: Add ArmSoM Sige5

Kever Yang (1):
  arm64: dts: rockchip: Add rk3576 pcie nodes

Nicolas Frattaroli (1):
  arm64: dts: rockchip: enable pcie on Sige5

 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi  |  18 +++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |   6 +
 configs/sige5-rk3576_defconfig                |  66 ++++++++
 doc/board/rockchip/rockchip.rst               |   1 +
 drivers/clk/rockchip/clk_rk3576.c             |   2 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 146 ++++++++++++++++++
 .../arm64/rockchip/rk3576-armsom-sige5.dts    |  23 +++
 dts/upstream/src/arm64/rockchip/rk3576.dtsi   | 108 +++++++++++++
 8 files changed, 370 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 configs/sige5-rk3576_defconfig

-- 
2.49.0

