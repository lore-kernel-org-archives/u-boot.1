Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58473D3E2A2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329E0890F6;
	Mon, 28 Oct 2024 20:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Wrlr+nwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AAF1890F6; Mon, 28 Oct 2024 20:00:48 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE548912A
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
 bh=gFitfqNe7dgC1DtVGqNZrH8+nb78c725YMiiQUIiM74=; b=Wrlr+nwp2i8lHs5UFw06/0z6kD
 i3Zmp9oSNFZKdma45sqChKPynJV3FL4FH9R+3DeWL5JO99jMFhjoFvMBMV1KZPytdHG/1OAn+O8e9
 B8KhV/vXDmQAmoZ2Omv5ugFxOpv8fulPKe3LfXi2lD7Bk/nfhCuCK56uN4AAmcC4dnIGbn4A2PDO6
 VEZVf34tnMKKgIt76A4MY4UbUSoIn9CWLPefYUhRFILwVeFGINVPFLensGuiutsQdY2IMp/huscHO
 Df2O2l6ghjpLYwmuOXY8dc1proX2yHBrIXlkKYWYRAX29zwHKKW/ugNjEKbgTZv7ZYntxREx6I55Z
 UIdBT3dg==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyo-0000Gm-UV; Mon, 28 Oct 2024 20:00:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 06/18] arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
Date: Mon, 28 Oct 2024 20:00:22 +0100
Message-ID: <20241028190034.143122-7-heiko@sntech.de>
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

The TS433 has 4 bays. The last two are accessed via a pci-connected
sata controller, while the first two are accessed via the rk3568's
sata controllers. Enable these two now.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-7-heiko@sntech.de

[ upstream commit: 673c1353b3d476b9c5df6b84a777ed171e5594f5 ]

(cherry picked from commit dfa45bbda057851d0c2167b4c311c0301637cc19)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index be1c2286c2d..40af4dd0e41 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -80,6 +80,16 @@
 	status = "okay";
 };
 
+/* connected to sata1 */
+&combphy1 {
+	status = "okay";
+};
+
+/* connected to sata2 */
+&combphy2 {
+	status = "okay";
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -156,6 +166,14 @@
 	};
 };
 
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.45.2

