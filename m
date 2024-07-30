Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCDFC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EECD8882C;
	Tue, 30 Jul 2024 16:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sw1tt6KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8378882F; Tue, 30 Jul 2024 16:28:19 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE83B87E62
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722349691; bh=UVYfzPHfBw2JD96jMHN9JuC4A9SO8A8+X39qkLJAwj8=;
 b=sw1tt6KQKfUz+RnHmEfR7TXd1wP1Kw2oMAPBxmzthEv955IErS2RuKNhANtU4jge6156DwmLF
 aPeZmPJBcIMMVDjnGxw2JCLyvIZ3uIde4m++g+82ucPKXKfpzT6n5yAUZPZE0BBO42EcdVhkIBy
 1zoI51BYiG6PxeTycTc3vPIWfKLiJ+H29Ch7Zy8k+Sh9dy298YrogMlwirQR0i0C3YtKBJLDqSl
 P0xQc+N4yaiysHDQLzotqai4Ph+ehGE+e+a0vyQj4JQsN97vxlrdxDa5Q0JvbVZ36TzCXrEcJQe
 9LRcHQGodSO3fEXbjMHKX9OogLctI2LTXyqkS8f21qxg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add OTP device node for RK3308
Date: Tue, 30 Jul 2024 14:27:51 +0000
Message-ID: <20240730142751.842772-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730142751.842772-1-jonas@kwiboo.se>
References: <20240730142751.842772-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a8f87688a51d097cb15102
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

The RK3308 SoC contains a controller for one-time-programmable memory,
add a device node for it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240521211029.1236094-9-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 36d3bbc8cdbef2f83391f7708888265ac4c37a99 ]

(cherry picked from commit db11d284200d0f811a8f8238dbc9c63daf4e6131)
---
v2: New patch
---
 dts/upstream/src/arm64/rockchip/rk3308.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3308.dtsi b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
index c00da150a22f..6531ede13af9 100644
--- a/dts/upstream/src/arm64/rockchip/rk3308.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
@@ -556,6 +556,30 @@
 		status = "disabled";
 	};
 
+	otp: efuse@ff210000 {
+		compatible = "rockchip,rk3308-otp";
+		reg = <0x0 0xff210000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+			 <&cru PCLK_OTP_PHY>;
+		clock-names = "otp", "apb_pclk", "phy";
+		resets = <&cru SRST_OTP_PHY>;
+		reset-names = "phy";
+
+		cpu_id: id@7 {
+			reg = <0x07 0x10>;
+		};
+
+		cpu_leakage: cpu-leakage@17 {
+			reg = <0x17 0x1>;
+		};
+
+		logic_leakage: logic-leakage@18 {
+			reg = <0x18 0x1>;
+		};
+	};
+
 	dmac0: dma-controller@ff2c0000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xff2c0000 0x0 0x4000>;
-- 
2.45.2

