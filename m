Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279BFC3600B
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 21:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916CD81026;
	Sun, 30 Mar 2025 23:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rpGM9LBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C5581E18; Sun, 30 Mar 2025 23:40:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBD6800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743370829; bh=ODalvzLLej2iS+PfzP5V1+4m6V1I0gWwn01iK4cdx7I=;
 b=rpGM9LBzxmvke7DwCGCj8bY2933ZHzyJHjq0szKoXMWHx9zI1YPTMy9+IU1QZRVaHBgBKpvWJ
 yG39nHe9DqShwFljP0FRFIRrEp7F4PNdORwQL+osambqwDwMYcSCDhVI0cXlwUQS5c+9CiF2g/x
 MoMDMi/iRgRm7nRLyTdNDkwjkBzwS676tnZs2v80ARIivYEKXDZM798GRDuF0XAS7yW1zy0psM4
 p4X5ivhSS1uXwhjiZHKo3Rq3UW//WJULqLTcf4QaUv4mRPztkeSHbB6j4ov+q5TLqq0S+FIo5QD
 kGz9HkEIhyvBjd7ZbqR1S8uUuTY2ou8z3uJ5mTo4jQ6w==
X-Forward-Email-ID: 67e9ba4bf4aa6b41f9be0785
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH 2/2] rng: rockchip_rng: Update compatible for RK3588
Date: Sun, 30 Mar 2025 21:40:11 +0000
Message-ID: <20250330214015.3466802-3-jonas@kwiboo.se>
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

Linux commit 6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to
RK3588") merged for v6.15-rc1 add a proper rng node to the device tree.
The compatible used differs compared to what U-Boot is currently using.

Replace the old trngv1 compatible with the upstream Linux rk3588-rng
compatible.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This was also tested with a full copy of the rng node, meaning the rng
node can fully be dropped from u-boot.dtsi in the future when v6.15-dts
has been merged.
---
 arch/arm/dts/rk3588s-u-boot.dtsi | 4 ++--
 drivers/rng/rockchip_rng.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 8880d162b11c..ee44ad271c7f 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -19,8 +19,8 @@
 		bootph-all;
 	};
 
-	rng: rng@fe378000 {
-		compatible = "rockchip,trngv1";
+	rng@fe378000 {
+		compatible = "rockchip,rk3588-rng";
 		reg = <0x0 0xfe378000 0x0 0x200>;
 	};
 };
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

