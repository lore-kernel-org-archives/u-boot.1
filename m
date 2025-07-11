Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13194C83F21
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B688282B07;
	Sat, 12 Jul 2025 00:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zPpp6ZpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A11682C84; Sat, 12 Jul 2025 00:21:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFFE82B07
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752272503; bh=EQlJqhVDSQO3bVrHcoFJyxK9YyEokCPS21jPRKNAh9E=;
 b=zPpp6ZpAjgIMyAzv4nmfn7HCyG1UDJyUmgbgJbLzZ9rBMW8DsMkoxt0/MCR8Ix3ZxGVoGh2W7
 3Yl0I7EV9kcrzZaQx796bk2tbqRE5gdJCYHCN8kMnsdknZALMGryTHI3kjXNc4PF50T6BaGqU5w
 Hm2E8ywTGsrux7YCzQKap4/lCLXOoAYCCaNVJdwV+/T3pB+tz+wpihc45w8sJyqchNzQApXYfpv
 tV+LhRwNRfbpCc/53+Kv3wIzIBuQVqqZPi9zn5pUFNWvExW2Ic/M+dypeybZYUUURxYZFheJXUQ
 Zgzu0z4DSIyNrcdi+DEdULI10RCrSntowxf8VL5UNGJg==
X-Forward-Email-ID: 68718e7526dc7c4d2555fce9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
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
Subject: [PATCH v2 1/6] arm64: dts: rockchip: add RK3576 RNG node
Date: Fri, 11 Jul 2025 22:21:16 +0000
Message-ID: <20250711222132.204344-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711222132.204344-1-jonas@kwiboo.se>
References: <20250711222132.204344-1-jonas@kwiboo.se>
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

The RK3576 has a hardware random number generator IP built into the SoC.

Add it to the SoC's .dtsi, now that there's a binding and driver for it.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250430-rk3576-hwrng-v1-3-480c15b5843e@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 5268f3b5d29887480011b44567bcbf0d422cda94 ]

(cherry picked from commit 25cfcb091747900639f2b5df297d26b3a6ca3989)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 dts/upstream/src/arm64/rockchip/rk3576.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
index ebb5fc8bb8b1..50332ec6e0de 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
@@ -1419,6 +1419,14 @@
 			status = "disabled";
 		};
 
+		rng: rng@2a410000 {
+			compatible = "rockchip,rk3576-rng";
+			reg = <0x0 0x2a410000 0x0 0x200>;
+			clocks = <&cru HCLK_TRNG_NS>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&cru SRST_H_TRNG_NS>;
+		};
+
 		otp: otp@2a580000 {
 			compatible = "rockchip,rk3576-otp";
 			reg = <0x0 0x2a580000 0x0 0x400>;
-- 
2.49.0

