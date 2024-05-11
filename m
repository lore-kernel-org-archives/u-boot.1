Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCE2C25B5F
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 11:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83467885DD;
	Sat, 11 May 2024 13:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TRL7LNnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7904B885E7; Sat, 11 May 2024 13:28:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB9C87FA7
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 13:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715426922; bh=TnVzdzAJySJ4QTjXLzKCm/54RT7MLCo5SKw2CkPlJ7s=;
 b=TRL7LNnUwIiBsIgvoU5ShOO3S9Fy4KiXQyx3I/8kWSFg/SK6szE3lnd2uHphsiE/S1K13zeJq
 gEYnI+b23+lPcABVPp/AlrztrN3SJMdL8H+gYL+njsQtd5VMQ+ubr1o3Yn/SfQF2IhhNaW5Qy42
 yZ/1ZjwXANPz6/JH5ExGoaHnLtosuBe1e2D5t5avg//E6IfZEOF6xMkBWmJY7CspgSc7KrIaKjN
 ZgcK4sVXLy/YFrcVa+6T+Ehj37dR7mdA510tmig09fQsLTa/NtFES8CjqRzB3/yr+vbhN2zWFR+
 To2kopSDKSgdPmSdIqac0LwwHFZnUYx2D0f46VT7rZ5A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 3/4] rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
Date: Sat, 11 May 2024 11:28:14 +0000
Message-ID: <20240511112821.1156519-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240511112821.1156519-1-jonas@kwiboo.se>
References: <20240511112821.1156519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 663f5666acd5e90e057dfc64
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

The GPIO2_D6 pin is changed to use func-4 using pcie30x2m1_pins during
probe of pcie3x2. This cause the device to lock-up when pci driver use
the reset-gpios unless the pin is first changed to use gpio pinmux.

Drop the board u-boot.dtsi workaround now that the gpio and pinctrl
drivers automatically use gpio pinmux when a gpio is requested.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 9d18f5d0b364..f4e2dc91ddfb 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -6,18 +6,6 @@
 
 #include "rk356x-u-boot.dtsi"
 
-&pcie3x2 {
-	pinctrl-0 = <&pcie3x2_reset_h>;
-};
-
-&pinctrl {
-	pcie {
-		pcie3x2_reset_h: pcie3x2-reset-h {
-			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.43.2

