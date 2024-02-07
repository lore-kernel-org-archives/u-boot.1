Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA36EC48297
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 01:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C5F87C9A;
	Wed,  7 Feb 2024 02:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hu3Sb2Dp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9E187CB5; Wed,  7 Feb 2024 02:07:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334A287C93
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 02:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707267985; bh=Anu/ZnTJM/OUyzUDShB3OmQU4oAwE+zU3mP+qCFlYXE=;
 b=hu3Sb2DpCt7aYbGiZL/Pm5Flx90MGfnH+e5mRZ9mS/cVwfotz6N8xZeuyaO30ikvPIHJP6HyJ
 GqOncO7zs+ZOxq4+EtdTsfGH2raOmHEOtxt6ELsMRDJeECw9q+twg1SRDBqYrUR3gY0U9MuRjBd
 w+1k79eyKVZkZjPFs+keNUMIzEV9IVqIDWDAQZrIhfkXK5q+JPvI4ia6Oo+4o8MHztK9IF2V85C
 PH8i2ihlkS08lR8Zw15WggVYOU42xXMtyIJK1olzYpQ7AlBab4xfpgvN38t0Nxp1MW+2WHIUrXv
 KWX8v3yyDlTilByhyHnws+e6uL90IepbbFZEp0T9yS+A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/15] rng: rockchip: Use same compatible as linux
Date: Wed,  7 Feb 2024 00:02:39 +0000
Message-ID: <20240207000301.3270722-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c2c8ded5b31093c56fbfb8
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
---
 arch/arm/dts/rk3328-u-boot.dtsi |  2 +-
 arch/arm/dts/rk3399-u-boot.dtsi |  2 +-
 drivers/rng/rockchip_rng.c      | 10 +++++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index e087b02893c1..d805c2f394f8 100644
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

