Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A631C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E684E87E95;
	Sat, 17 Feb 2024 01:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Hv/ZP4Wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CFA87E32; Sat, 17 Feb 2024 01:27:17 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDAE87EAB
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129438; bh=aF9THy9dbUDZsYnZ5mjt032yGGHq2esaylAgj0k8xiw=;
 b=Hv/ZP4WkTvGHQNuGT+9DgngvAykmINNeJsQw8i4quSVnIeFhcK6gpLNgs1vB884aSWIIJPawB
 uaz975Ao3KRb7OFOi3zyL6a5jRxI7/Ccsm3KEYi6k5aHdxRbnItQtvFJai7bRcwWoW56KM55MMc
 LAZYOaNz8cNKkvPb8ngW+4yd63N5EPwuAyobLC49/7T0evb5WsrlvitfyK4PcIYq74OKTe2FDFB
 TF4QKUStZwcmPTvOyCG1AvXoUdxXwPGSF1mrdyFbvDsLPehzXRvHvcLwfW/79iU0o75284zgmjG
 y6LBrsG045vZCopToCfeW3KOTuMZ5AZXLj1eLbEjHmrw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 10/15] rng: rockchip: Use same compatible as linux
Date: Sat, 17 Feb 2024 00:22:36 +0000
Message-ID: <20240217002304.2141064-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffc9cbb96cee8b5411f33
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

Replace the rockchip,cryptov1-rng compatible with compatibles used in
the linux device tree for RK3288, RK3328 and RK3399 to ease sync of SoC
device tree from linux.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
v2:
- No change
- Collect r-b tag
---
 arch/arm/dts/rk3328-u-boot.dtsi |  2 +-
 arch/arm/dts/rk3399-u-boot.dtsi |  2 +-
 drivers/rng/rockchip_rng.c      | 10 +++++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index 687c16da5135..ea34bf6b78bb 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -28,7 +28,7 @@
 	};
 
 	rng: rng@ff060000 {
-		compatible = "rockchip,cryptov1-rng";
+		compatible = "rockchip,rk3328-crypto";
 		reg = <0x0 0xff060000 0x0 0x4000>;
 		status = "okay";
 	};
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 3423b882c437..87b173e59579 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -30,7 +30,7 @@
 	};
 
 	rng: rng@ff8b8000 {
-		compatible = "rockchip,cryptov1-rng";
+		compatible = "rockchip,rk3399-crypto";
 		reg = <0x0 0xff8b8000 0x0 0x1000>;
 		status = "okay";
 	};
diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 705b424cf3dd..e82b5572fec5 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -302,7 +302,15 @@ static const struct dm_rng_ops rockchip_rng_ops = {
 
 static const struct udevice_id rockchip_rng_match[] = {
 	{
-		.compatible = "rockchip,cryptov1-rng",
+		.compatible = "rockchip,rk3288-crypto",
+		.data = (ulong)&rk_cryptov1_soc_data,
+	},
+	{
+		.compatible = "rockchip,rk3328-crypto",
+		.data = (ulong)&rk_cryptov1_soc_data,
+	},
+	{
+		.compatible = "rockchip,rk3399-crypto",
 		.data = (ulong)&rk_cryptov1_soc_data,
 	},
 	{
-- 
2.43.0

