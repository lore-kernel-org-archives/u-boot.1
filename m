Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91582CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7856683957;
	Sun, 31 Aug 2025 18:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TBrUxQWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DDF83977; Sun, 31 Aug 2025 18:50:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CC783957
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659041; bh=yZd6/IaMJcRgZS+/sau9Al5ss46bn+rRfEcRNMnDLdk=;
 b=TBrUxQWN+0iLO1DNlkM+2Vgur+mP5tlHpEvMxtoc6kL54FjTzoJuABQsTaZeuaDCmspvGom1o
 Mvwrkl/r1ZL2KJnHc783HHqxC6xaRLiQ8iB1CfPwYpe9xcPpH2wj8JSI1mMhsWiIxd+el0A0Eg5
 f8oxAPdWQsWTAlWOaTUmdUadY65tHVKvRblVqOYH1PfAi0e3VnprtcDKHsj5F6V+iqluRLjk0l5
 /badaUD+OVChMrjwS8FRevUrz6srYxcEg0yH/vY+Qg6jOeF87x+s2Nd0yjEbOk4vKxxxZzHmFcC
 XLKtv8Cn1UsBWNHTvk/4iZW+XKrBc7ZqlGqQ5QyuCK2Q==
X-Forward-Email-ID: 68b47d5c7f68b507ca9c3a02
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 04/18] rockchip: odroid-go2: Remove u-boot.dtsi props
 already defined
Date: Sun, 31 Aug 2025 16:49:21 +0000
Message-ID: <20250831165001.2749711-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

DTs from dts/upstream already contain aliases for i2c, mmc and serial.

Remove the aliases and status=okay that are already defined in upstream
board or SoC DT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split out unrelated spi0 alias change into separate patch
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 38778d1aa6cf..df21747fad78 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -10,14 +10,6 @@
 		u-boot,spl-boot-order = &sdmmc;
 	};
 
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		mmc0 = &sdmmc;
-		serial1 = &uart1;
-		serial2 = &uart2;
-	};
-
 	dmc {
 		bootph-all;
 		compatible = "rockchip,px30-dmc", "syscon";
@@ -27,7 +19,6 @@
 	rng: rng@ff0b0000 {
 		compatible = "rockchip,cryptov2-rng";
 		reg = <0x0 0xff0b0000 0x0 0x4000>;
-		status = "okay";
 	};
 };
 
@@ -84,7 +75,6 @@
 
 &saradc {
 	bootph-all;
-	status = "okay";
 };
 
 &sdmmc {
-- 
2.51.0

