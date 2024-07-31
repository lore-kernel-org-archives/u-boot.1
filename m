Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64155C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4773388965;
	Wed, 31 Jul 2024 08:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yw8xmQOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489208895A; Wed, 31 Jul 2024 08:51:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCB388916
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722408663; bh=7w1SkgSB7aFeJ1jdpdWy26d502Ixxww3USvLPNoBoSw=;
 b=yw8xmQOotYmb/L8OnkaEmYRLd0fKVDav9GLLSSsnzwRUEGF9+wiHLJkdmVXQ3dRBHxkS8v+cE
 yr8Vq7/g+dbo+d0XB3jxHd/T3Ay8e8qz3A35Lct7tqIH6tcmLPaEWfPWScaw/9Ud6smyOWwkJfk
 Oi5LaPf08/Oo2SqZ/eURGByCRGgS08RKEAGZNi1TVs3yNPdpWI5vm7bo+jsgU6aDD2JMWrZrA60
 HQgCdFNdzWg1toZ38Pl86D0tV9mumCN58omGCaLbdfVrBxC2udk/hlvuLy0G8bKz6FZOSWLf9G/
 ZIy7B7Uy/x9uwu5AwyaGodjLxsbQkgespnjL7saCLefw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/5] arm64: dts: rockchip: fix mmc aliases for Radxa ZERO 3E/3W
Date: Wed, 31 Jul 2024 06:50:37 +0000
Message-ID: <20240731065048.1199792-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731065048.1199792-1-jonas@kwiboo.se>
References: <20240731065048.1199792-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9ded473d983cd09237948
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

From: FUKAUMI Naoki <naoki@radxa.com>

align with other Radxa products.

- mmc0 is eMMC
- mmc1 is microSD

for ZERO 3E, there is no eMMC, but aliases should start at 0, so mmc0
is microSD as exception.

Fixes: 1a5c8d307c83 ("arm64: dts: rockchip: Add Radxa ZERO 3W/3E")
Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>

Changes in v3:
- fix syntax error in rk3566-radxa-zero-3e.dts
Changes in v2:
- microSD is mmc0 instead of mmc1 for ZERO 3E

Link: https://lore.kernel.org/r/20240620224435.2752-1-naoki@radxa.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 060c1950037e4c54ca4d8186a8f46269e35db901 ]

(cherry picked from commit 8324bc7493e4088013c62bc41f49d6d181575493)
---
 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi | 4 ----
 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts | 1 +
 dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts | 3 ++-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
index 623d5939d194..081be841b286 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
@@ -6,10 +6,6 @@
 #include "rk3566.dtsi"
 
 / {
-	aliases {
-		mmc0 = &sdmmc0;
-	};
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
index e166d66990b9..4a830eb09f0b 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3e.dts
@@ -10,6 +10,7 @@
 
 	aliases {
 		ethernet0 = &gmac1;
+		mmc0 = &sdmmc0;
 	};
 };
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
index 9bf4f464915f..f92475c59deb 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3w.dts
@@ -9,7 +9,8 @@
 	compatible = "radxa,zero-3w", "rockchip,rk3566";
 
 	aliases {
-		mmc1 = &sdhci;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
 		mmc2 = &sdmmc1;
 	};
 
-- 
2.45.2

