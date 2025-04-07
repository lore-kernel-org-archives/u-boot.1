Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A61C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6905830E3;
	Tue,  8 Apr 2025 00:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="By1cnANk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B08382FB4; Tue,  8 Apr 2025 00:48:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C136F830E9
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066088; bh=b0oMDUChRcR09GWZswrt124NWicZsRY6/i4N014Ga4s=;
 b=By1cnANkjuoKaSFUuj+RpvliafpOc+jhWAgOjeX6ANKxmgRckoZ8TgqpGQ25y5Jso6wNKjC8k
 BX6PWVLYFysH1yuKm90De8ptKCWoudWEANSVSBmygtMYOBbMetgAx8/GgbqVD/yrRCpb1watjJY
 CPfg6ijPgY5eMSBQvD0gcZZEGjdmGXdb4FUiBdipjUNO58/Kc1Xjhz3WBTH8QmVhGGg7Dqsc4r3
 09C/dj48oAgVgQ/5f/BIz1XvFi6yp3MMUV3CjtlC4gmUNcjdbmxe4KFc8W31YTSm6MC3OsddPal
 rdI204u0Ue4vTK6HcyYAV0+bkRHmiEZvTGa1xaKMtSeQ==
X-Forward-Email-ID: 67f456279fd75b9b965127a5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 05/30] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Mon,  7 Apr 2025 22:46:38 +0000
Message-ID: <20250407224743.2423921-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

From: Chukun Pan <amadeus@jmu.edu.cn>

The Quality-of-Service (QsS) node stores/restores specific
register contents when the power domains is turned off/on.
Add QoS node so that they can connect to the power domain.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Link: https://lore.kernel.org/r/20250306123809.273655-3-amadeus@jmu.edu.cn
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 61a05d8ca3030a544175671f5fab7a8f29c24085 ]

(cherry picked from commit 9ee90dfd6957fcc42ea94c43d195b01d1b286713)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3528.dtsi | 160 ++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
index b1713ed4d7e2..0c0e7f151462 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
@@ -129,6 +129,166 @@
 			#interrupt-cells = <3>;
 		};
 
+		qos_crypto_a: qos@ff200000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200000 0x0 0x20>;
+		};
+
+		qos_crypto_p: qos@ff200080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200080 0x0 0x20>;
+		};
+
+		qos_dcf: qos@ff200100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200100 0x0 0x20>;
+		};
+
+		qos_dft2apb: qos@ff200200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200200 0x0 0x20>;
+		};
+
+		qos_dma2ddr: qos@ff200280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200280 0x0 0x20>;
+		};
+
+		qos_dmac: qos@ff200300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200300 0x0 0x20>;
+		};
+
+		qos_keyreader: qos@ff200380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200380 0x0 0x20>;
+		};
+
+		qos_cpu: qos@ff210000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210000 0x0 0x20>;
+		};
+
+		qos_debug: qos@ff210080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210080 0x0 0x20>;
+		};
+
+		qos_gpu_m0: qos@ff220000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220000 0x0 0x20>;
+		};
+
+		qos_gpu_m1: qos@ff220080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220080 0x0 0x20>;
+		};
+
+		qos_pmu_mcu: qos@ff240000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff240000 0x0 0x20>;
+		};
+
+		qos_rkvdec: qos@ff250000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff250000 0x0 0x20>;
+		};
+
+		qos_rkvenc: qos@ff260000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff260000 0x0 0x20>;
+		};
+
+		qos_gmac0: qos@ff270000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270000 0x0 0x20>;
+		};
+
+		qos_hdcp: qos@ff270080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270080 0x0 0x20>;
+		};
+
+		qos_jpegdec: qos@ff270100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270100 0x0 0x20>;
+		};
+
+		qos_rga2_m0ro: qos@ff270200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270200 0x0 0x20>;
+		};
+
+		qos_rga2_m0wo: qos@ff270280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270280 0x0 0x20>;
+		};
+
+		qos_sdmmc0: qos@ff270300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270300 0x0 0x20>;
+		};
+
+		qos_usb2host: qos@ff270380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270380 0x0 0x20>;
+		};
+
+		qos_vdpp: qos@ff270480 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270480 0x0 0x20>;
+		};
+
+		qos_vop: qos@ff270500 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270500 0x0 0x20>;
+		};
+
+		qos_emmc: qos@ff280000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280000 0x0 0x20>;
+		};
+
+		qos_fspi: qos@ff280080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280080 0x0 0x20>;
+		};
+
+		qos_gmac1: qos@ff280100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280100 0x0 0x20>;
+		};
+
+		qos_pcie: qos@ff280180 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280180 0x0 0x20>;
+		};
+
+		qos_sdio0: qos@ff280200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280200 0x0 0x20>;
+		};
+
+		qos_sdio1: qos@ff280280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280280 0x0 0x20>;
+		};
+
+		qos_tsp: qos@ff280300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280300 0x0 0x20>;
+		};
+
+		qos_usb3otg: qos@ff280380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280380 0x0 0x20>;
+		};
+
+		qos_vpu: qos@ff280400 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280400 0x0 0x20>;
+		};
+
 		cru: clock-controller@ff4a0000 {
 			compatible = "rockchip,rk3528-cru";
 			reg = <0x0 0xff4a0000 0x0 0x30000>;
-- 
2.49.0

