Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E4D3E2BB
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBE489138;
	Mon, 28 Oct 2024 20:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="a3EG4JiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C568911D; Mon, 28 Oct 2024 20:29:44 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A5A89124
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:29:42 +0100 (CET)
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
 bh=cXnow23XuUiToPdaw7Tl7ojwmlPA620TjHjtlwGEDRM=; b=a3EG4JiDut5D0+cMr68QkItdhQ
 dhDDggLekUsyRyY4uQAI+EX7SHmt8kxUUry3ndDT6MCgKEAc1zdDLly3vuNI8NevhvbSWP8tDT0YE
 t9mZ9w7CJ1hSd8fZTDtTLf2/V3xEcSqY1VqggizWOx/670MpXYF66Em1j53bwXrrxcjdkS4btITc3
 jn3ZU3tPajyfsYVzKQWClBoSMhDJJohyy1gwMY/GAtyk9VV9d51cSfNjRnn06/Ep5pOkzhJKAzxno
 32ZD1BdFMZ8vhkivnf3I+aIPxSVffyX2/u2m9RcHD51MZuY95QEXVGJJNdiU/zsL+lUxqYjFJf9H+
 1EDgTfOg==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyr-0000Gm-2I; Mon, 28 Oct 2024 20:00:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 15/18] arm64: dts: rockchip: Simplify network PHY
 connection on qnap-ts433
Date: Mon, 28 Oct 2024 20:00:31 +0100
Message-ID: <20241028190034.143122-16-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028190034.143122-1-heiko@sntech.de>
References: <20241028190034.143122-1-heiko@sntech.de>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

