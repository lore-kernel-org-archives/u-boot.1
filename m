Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B36BCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E368905E;
	Sun, 13 Oct 2024 21:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="yAUK/11+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB66E8905E; Sun, 13 Oct 2024 21:25:34 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3EF88FF1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a9YDi8Z1dHKCNsPbIvzQ9tcUqJDVAPw9Cn8hE4F2zRo=; b=yAUK/11+frtCh209nyz45YiQ0f
 Nw7CwJnITRpujU+1kkZ3Sh4o+aD0hH/PcgkYFzfSX/3C4WHIC0OM8duiNYLEEbbqqTrT0EQfu0dF7
 wlEIdT/yQ3gn7zOT+Bgyqd5AXGnNNyQhEPaqXYQkEiRU2V6u5CyPT5Cy0Hpik0k0BuIu6a03U5RGv
 9RG5+8MwrqNIEeJvuulf1zKQWpD8zMjavveM8lzgxgtpMf9txTgDOYOmQm3QQBRQ7HHsdFVYdjO0p
 6YhC8e7E5WLckdImQaSQLkekaUOZlKS5lhDX+PD/o0aV8C9TomT6lBpyOQmYFso8yXR/7PpJEHYt2
 1+BZC8SA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Cd-000129-QC; Sun, 13 Oct 2024 21:24:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 15/18] arm64: dts: rockchip: Simplify network PHY
 connection on qnap-ts433
Date: Sun, 13 Oct 2024 21:24:21 +0200
Message-ID: <20241013192424.84280-16-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013192424.84280-1-heiko@sntech.de>
References: <20241013192424.84280-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Uwe Kleine-König <ukleinek@debian.org>

While it requires to have the right phy driver loaded (i.e. motorcomm)
to make the phy asserting the right delays, this is generally the
preferred way to define the MAC <-> PHY connection.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240304084612.711678-2-ukleinek@debian.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e8d45544f806f3b55c30345de84262cbb9504902 ]

(cherry picked from commit e0bbe061fd537bd7b113c53eb046bbcbf0e6597d)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 6c4269b3d95..20e4fa6c185 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -198,15 +198,13 @@
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
 		     &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
-	rx_delay = <0x2f>;
-	tx_delay = <0x3c>;
 	status = "okay";
 };
 
-- 
2.45.2

