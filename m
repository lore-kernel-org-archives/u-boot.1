Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E95EC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 21:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0F680FDA;
	Sun, 30 Mar 2025 23:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cjepiQKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7028081DE3; Sun, 30 Mar 2025 23:40:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066BF80FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743370828; bh=HBKKNInqcxTBTUZcOpolgFzOobn7HbckzD0p6U0c5Pc=;
 b=cjepiQKtZt/xgE6n6qoV862Hy0qlyXVgPE97Saj6CUVH/yzk5t5N/vDCKVnh8i92aV47MhxNi
 +ZRONYQBKcUuPxUwgnun7ApCFu5sCFfLx+pZODpZIKKsKiaC9UNBdZ0Co8ip0o8jdpz7oR5zKAf
 NcqoJAV+TLe7XhxCkXTEsnYO5CDdJM123k2XLehcpv/h/oYIZS5HnO+L77hC7Zal8ipysMzZJNQ
 yM4cHETchvxCAKgFA9wyguhlX81rmuLXDIDW4VIyDJPui00MK84xnThReFv5TQO9p7Ksk40Mw/e
 yOI8B1kYpw2j0a+nP1h8I5qugXmBzj50t+hsj59lFOQA==
X-Forward-Email-ID: 67e9ba48f4aa6b41f9be0770
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rng: rockchip_rng: Add compatible for RK3568
Date: Sun, 30 Mar 2025 21:40:10 +0000
Message-ID: <20250330214015.3466802-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330214015.3466802-1-jonas@kwiboo.se>
References: <20250330214015.3466802-1-jonas@kwiboo.se>
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

Linux commit afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG
to RK356x") merged for v6.12-rc1 add a proper rng node to the SoC DT.
The compatible used differs compared to what U-Boot is currently using.

Add support for the rk3568-rng used in upstream Linux. Support for the
cryptov2-rng compatible is still kept because PX30/RK3326 and RK3308 are
still using it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 9 ++++-----
 drivers/rng/rockchip_rng.c      | 4 ++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 24a976cf7e21..871869739536 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -21,11 +21,6 @@
 		bootph-all;
 	};
 
-	rng: rng@fe388000 {
-		compatible = "rockchip,cryptov2-rng";
-		reg = <0x0 0xfe388000 0x0 0x2000>;
-	};
-
 	otp: nvmem@fe38c000 {
 		compatible = "rockchip,rk3568-otp";
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
@@ -121,6 +116,10 @@
 	bootph-all;
 };
 
+&rng {
+	status = "okay";
+};
+
 &sdhci {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 2426648fbd57..f673e2657c94 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -312,6 +312,10 @@ static const struct udevice_id rockchip_rng_match[] = {
 		.compatible = "rockchip,rk3399-crypto",
 		.data = (ulong)&rk_cryptov1_soc_data,
 	},
+	{
+		.compatible = "rockchip,rk3568-rng",
+		.data = (ulong)&rk_cryptov2_soc_data,
+	},
 	{
 		.compatible = "rockchip,cryptov2-rng",
 		.data = (ulong)&rk_cryptov2_soc_data,
-- 
2.49.0

