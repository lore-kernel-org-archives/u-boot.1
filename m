Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EFC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAA5834D4;
	Wed,  9 Apr 2025 00:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ABXq3E6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29FC83490; Wed,  9 Apr 2025 00:12:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92630834DC
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744150330; bh=IeHrCS3tf6htM3hOnbhePESG7MSjtJGzOdCOP/KgD9Y=;
 b=ABXq3E6NO02COxsj2qXabjcz+fdzIlVt8K1gujHypYIdFCYTW46cSDOZ5rOsSfSzamMdovnZv
 E2GSOQ0IavBbMaiaoprVJVEwlgD/goFNJPvKpC4XttqekE2uwRyCLNIZqoj/C3dpSLRjTiC6lLQ
 +BBhTBPZIymHUI5xANZnzVCzuVTDMnZPdcW3zfhsl12ZM0Ug4koclhIOEv5t+mwHn2ixHwtQP04
 SKA7kAJ1gqN2REQ82AZ/wqIRUYzFfLqitbwnvyx7cGrYk4aTGwYy8u8eqZGE+duCzGnPDeA/Dk6
 Q58Otoh0x4D/QTKexcQ2Oohe3jsvSCacywIZeiTE9A1Q==
X-Forward-Email-ID: 67f59f359e1b52744186accf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add rng node to RK3588
Date: Tue,  8 Apr 2025 22:11:44 +0000
Message-ID: <20250408221151.2762853-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408221151.2762853-1-jonas@kwiboo.se>
References: <20250408221151.2762853-1-jonas@kwiboo.se>
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

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Add the RK3588's standalone hardware random number generator node to its
device tree, and enable it.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250204-rk3588-trng-submission-v2-6-608172b6fd91@collabora.com
[changed reset-id to its numeric value while the constant makes its
 way through the crypto tree]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 6ee0b9ad3995ee5fa229035c69013b7dd0d3634b ]

(cherry picked from commit 4800c4aaad00ffdc053850f130e8504a04dd110d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
index c3abdfb04f8f..2623afa79634 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
@@ -1921,6 +1921,14 @@
 		status = "disabled";
 	};
 
+	rng@fe378000 {
+		compatible = "rockchip,rk3588-rng";
+		reg = <0x0 0xfe378000 0x0 0x200>;
+		interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&scmi_clk SCMI_HCLK_SECURE_NS>;
+		resets = <&scmi_reset 48>;
+	};
+
 	i2s0_8ch: i2s@fe470000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfe470000 0x0 0x1000>;
-- 
2.49.0

