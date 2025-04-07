Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E6FC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00AC83164;
	Tue,  8 Apr 2025 00:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W6khNrpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95D683158; Tue,  8 Apr 2025 00:48:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D39F8318F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066118; bh=HID4LB+0KgB/NTzOCfVJPx8hwPpQo65fCH/i4oQ93VM=;
 b=W6khNrppDp82CL4FmOPJIwWwh/knwFx7HzmdDmjQbOakmrHIqQmQSs+10/ikGykslkr249P8x
 0iKZQOeV9FQ1Ju1vsIf5iVg6NNgf0wq3mgmWp+96wxFwrqtVg97YLSZHo9C1uNu+PIcPMfPZxNt
 fI/tL7m9XWWfqJunMoUMCqEzCKsHt6dmhgsxd+kBeilNEMJ4OVdTjpfTLvZF5uqGZc8reGC6o2y
 9yLtoIg5UXymRefjXdq0nH6tFSpuT8Y3CHCXCCb7gIH53TzPvJdPevsDnAOive4vKqt3RHVWA97
 cFIw9zATP3AEFLTJ+qLqBjS36OLXisPMWlUGFLBf/d1w==
X-Forward-Email-ID: 67f456449fd75b9b96512869
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
Subject: [PATCH v2 13/30] arm64: dts: rockchip: Enable onboard eMMC on Radxa
 E20C
Date: Mon,  7 Apr 2025 22:46:46 +0000
Message-ID: <20250407224743.2423921-14-jonas@kwiboo.se>
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

The Radxa E20C may come with an onboard eMMC (8GB / 16GB / 32GB / 64GB).

Enable support for the onboard eMMC on Radxa E20C.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20250305214108.1327208-4-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 3a01b5f14a8ae2d45aea5aeed30001ac1655de86 ]

(cherry picked from commit bd4c8a1c08f92d863d89c0ddff59e5f5bc6a1e34)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
index 5346ef457c2a..57a446b5cbd6 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
@@ -15,6 +15,10 @@
 	model = "Radxa E20C";
 	compatible = "radxa,e20c", "rockchip,rk3528";
 
+	aliases {
+		mmc0 = &sdhci;
+	};
+
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
@@ -133,6 +137,17 @@
 	status = "okay";
 };
 
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;
-- 
2.49.0

