Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73EC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A7883B7F;
	Fri,  1 Aug 2025 22:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YVHcJ+k2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B09283B7F; Fri,  1 Aug 2025 22:43:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E3F83B52
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754081034;
 bh=HCREpVcO7RlftNpH4CT2Pjz0Dz50pnYLjfJrABARlD0=;
 b=YVHcJ+k2j7I7M40rIX1uj67SgQmlQKrDcUH0SE+IlX7/H5IX4n+8EwVOaeVr18db76Ve9Sj40
 D7Ds3z625EIRwtAUsIedXKfk3SOm9zGmJk5R8N102HQ/WrbZm9GNAyIW0gIk5oyCCdVpavcYNLf
 rQEod4x2c7jTR0WfmUW7sT3Gk1+8nwmbi41kmH+sO/NX2OPhv6St1I1BVqHpfIdnBLQlKhvkLJf
 +viUhfegnG0kH1AxyRnFKSOvnVfDtKqKFjf7g/T5gg5Zh7I86o3pXQ/hXKqU1RJ0W8N+wpkivSz
 AuW7QxQATKj8r/6xvLMDi05HQ+igqieu1XOIWf5WGNPg==
X-Forward-Email-ID: 688d2706f149f34f87aecb38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/3] board: rockchip: Add ArmSoM Sige5
Date: Fri,  1 Aug 2025 20:43:36 +0000
Message-ID: <20250801204345.2603723-1-jonas@kwiboo.se>
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

This series add support for the ArmSoM Sige5 board and is a split from
the "rockchip: rk3576: Add rng, checkboard() and ArmSoM Sige5" v1 [1]
series.

Changes in v3:
- Ensure USB3OTG U3 port is enabled when USB3 PHY is used
- Drop device tree patches merged with the v6.16-dts sync

Changes in v2:
- Pick dts/upstream commits to add PCIe nodes
- Add support for RK3576 to the naneng-combphy driver
- Enable PCIe, NVMe and USB Kconfig options

This series depends on the "rockchip: rk3576: Add rng, checkboard() and
generic board" v3 [1] series for a clean apply.

[1] https://patchwork.ozlabs.org/cover/2118071/

Jon Lin (1):
  phy: rockchip: naneng-combphy: Add support for RK3576

Jonas Karlman (2):
  rockchip: clk: clk_rk3576: Add dummy CLK_REF_PCIEx_PHY support
  board: rockchip: Add ArmSoM Sige5

 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi  |  18 +++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |   6 +
 configs/sige5-rk3576_defconfig                |  66 ++++++++
 doc/board/rockchip/rockchip.rst               |   1 +
 drivers/clk/rockchip/clk_rk3576.c             |   2 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 147 ++++++++++++++++++
 6 files changed, 240 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 configs/sige5-rk3576_defconfig

-- 
2.50.1

