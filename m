Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1229C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7084683487;
	Wed,  9 Apr 2025 00:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SUFPuu/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA3783487; Wed,  9 Apr 2025 00:12:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00982834E5
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744150330; bh=Ex7BBWnHh2PK1WOXEaTwfv5V0h+QlEd5ZTVKkjSM2JQ=;
 b=SUFPuu/3Bdjn8gky/C8lKx/xPwJ6SZ2axos2CjDywBuFVfm3PpsIIug2v5WW0tKiv3U32UETV
 tPNweidcm6DdQpzeLmSAOJzTEaby5TeHszY3w9LUPEXsJrx4X7p153dssK2y8SjaviCAa6JIZKl
 /boG2iBF+G25ruv3JKfqN7IkYwEjrwScDgEowezCwmfqudGqBMNbxccDL0sfAmouC0bDawJwKuF
 PEKQc29pueVakstV3WWjrb5asMTnjg0FSz/EL6ei5yKw2lRh3QTumeTTjrGhkTXARcZbFdY+dyY
 mPJTeJQ1GWHmtiEdgmsD8c/nNupUk6mHP44CuZfs3Wmw==
X-Forward-Email-ID: 67f59f399e1b52744186acf9
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
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/4] rng: rockchip_rng: Update compatible for RK3588
Date: Tue,  8 Apr 2025 22:11:45 +0000
Message-ID: <20250408221151.2762853-5-jonas@kwiboo.se>
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

Linux commit 6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to
RK3588") merged for v6.15-rc1 add a proper rng node to the device tree.
The compatible used differs compared to what U-Boot is currently using.

Replace the old trngv1 compatible with the dts/upstream compatible in
the rng driver and remove the old rng node compatible override from SoC
u-boot.dtsi to keep rng working after the driver change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Remove the rng node instead of changing compatible
---
 arch/arm/dts/rk3588s-u-boot.dtsi | 5 -----
 drivers/rng/rockchip_rng.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 8880d162b11c..5eeb138f3513 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -18,11 +18,6 @@
 		compatible = "rockchip,rk3588-dmc";
 		bootph-all;
 	};
-
-	rng: rng@fe378000 {
-		compatible = "rockchip,trngv1";
-		reg = <0x0 0xfe378000 0x0 0x200>;
-	};
 };
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index f673e2657c94..6e4e3abf08c8 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -321,7 +321,7 @@ static const struct udevice_id rockchip_rng_match[] = {
 		.data = (ulong)&rk_cryptov2_soc_data,
 	},
 	{
-		.compatible = "rockchip,trngv1",
+		.compatible = "rockchip,rk3588-rng",
 		.data = (ulong)&rk_trngv1_soc_data,
 	},
 	{},
-- 
2.49.0

