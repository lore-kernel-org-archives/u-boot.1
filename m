Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CE9CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF3B8393F;
	Sun, 31 Aug 2025 13:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tn9oY7k7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2397183929; Sun, 31 Aug 2025 13:21:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADAE83965
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639291; bh=9LTtr1f51cDXJFkMsT6OL2ektm+FHJnFmqu5OJHvEvY=;
 b=tn9oY7k7WvvbX+b6fAQXHm8qG/FFWvxtFPdxItN4qbmUniB1tMPrl4gv5DgmAlnRSWnVKZU/W
 Tv4wqbriAXMEuwS17ujgirpRQFPoC+c7HZLuNjgPkkRKlOV7LGMs+cb8kQu479j5nM0ItUVO3yl
 drF60eQw42LfsOFJXxzl3vrf4vK7lToCSBWLpZ6sV3/70FCdDIA+aEspJdSEnemoE+u23ii+5hZ
 TQQdwqZgBMA/VxY1BSp6O7SIZbSwYm9XUnJqfAYvk6HwEtXCymh4uzs7SCmRpq6s+6+EDy96zZD
 mM1SbX8niuMZvpIa8j1O3VAPaDQHOfkS+xQ8MzRlTrlQ==
X-Forward-Email-ID: 68b4303632f03f9a5e9086c6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 07/10] arm64: dts: rockchip: fix PHY handling for ROCK 4D
Date: Sun, 31 Aug 2025 11:20:28 +0000
Message-ID: <20250831112046.2642363-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Old revisions of the ROCK 4D board have a dedicated crystal to
supply the RTL8211F PHY's 25MHz clock input. At least some newer
revisions instead use REFCLKO25M_GMAC0_OUT. The DT already has
this half-prepared, but there are some issues:

1. The DT relies on auto-selecting the right PHY driver, which
   requires that it works good enough to read the ID registers.
   This does not work without the clock, which is handled by
   the PHY driver. By updating the compatible to contain the
   RTL8211F IDs, so that the operating system can choose the
   right PHY driver without relying on a pre-powered PHY.

2. Despite the name REFCLKO25M_GMAC0_OUT could also provide a
   different frequency, so ensure it is explicitly set to 25
   MHz as expected by the PHY.

3. While at it switch from deprecated "enable-gpio" to standard
   "enable-gpios".

Fixes: a0fb7eca9c09 ("arm64: dts: rockchip: Add Radxa ROCK 4D device tree")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cd803da7c033e376a66793a43ee98e136bc6cc25 ]

(cherry picked from commit d54023e2d503599c8e4b954322eabe411ef398f7)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
index 22ffa15abc9e..62712c90c83d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
@@ -645,14 +645,16 @@
 
 &mdio0 {
 	rgmii_phy0: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+		compatible = "ethernet-phy-id001c.c916";
 		reg = <0x1>;
 		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		assigned-clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		assigned-clock-rates = <25000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&rtl8211f_rst>;
 		reset-assert-us = <20000>;
 		reset-deassert-us = <100000>;
-		reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.51.0

