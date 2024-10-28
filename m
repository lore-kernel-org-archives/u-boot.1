Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9730D3E2A0
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB58F8912A;
	Mon, 28 Oct 2024 20:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="27V3WTdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1005589124; Mon, 28 Oct 2024 20:00:47 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1406E8911B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:00:43 +0100 (CET)
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
 bh=fmfWDSvvKTGnSj75LCkdJoUso5I0/SOsRe/GJP2Pl/E=; b=27V3WTdIz47GYxBkWji+Lhg9xB
 Dh0p48bwJ+QMCAMSU9iBZgJXnOHPN4RgU+adhMpsKtvlzTl3mVzUpgnhIKzkbf0l9Ub8eomERjpud
 BxMR/zHPAI2h7hnOyd5VHsRxcHUnDQCeBvdyBgC0+8UPNZ4e+CIjyWlNBdO/12+h5CEzTyKWE47rS
 DaV/tggYZzGjmh0gNKZal/6529c6l8ytx0kcOhJqdMivmHzOhjDeQs/MDrHIydRdN8k/7jG9C+b0x
 MMuY16dBThWK5YmEqHQPDdX11qneaEhAj5eGMSF0KrJUaZLdfuUPbbGxdMkDqEHnSPp4jTKHRo48j
 fI3ofrOg==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyo-0000Gm-1G; Mon, 28 Oct 2024 20:00:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 02/18] arm64: dts: rockchip: enable second PCIe controller
 on the Qnap-TS433
Date: Mon, 28 Oct 2024 20:00:18 +0100
Message-ID: <20241028190034.143122-3-heiko@sntech.de>
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

The TS433 uses both pcie controllers for sata and the 2nd network
interface. Set the needed data-lanes in the pcie3 phy and enable
the second pcie controller, as well as remove the bifurcation comment.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-3-heiko@sntech.de

[ upstream commit: 0f5f87a1d602a33028522784eb005647fa1b5c11 ]

(cherry picked from commit 7d8f260e65cc84076ec9456954de0f136948a2c8)
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 07b4f095d76..9bf9c3b65ca 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -78,17 +78,25 @@
 };
 
 &pcie30phy {
+	data-lanes = <1 2>;
 	status = "okay";
 };
 
 /* Connected to a JMicron AHCI SATA controller */
 &pcie3x1 {
-	/* The downstream dts has: rockchip,bifurcation, XXX: find out what this is about */
 	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
 };
 
+/* Connected to the 2.5G NIC for the upper network jack */
+&pcie3x2 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.45.2

