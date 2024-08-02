Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F537C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA80D88C3E;
	Sat,  3 Aug 2024 00:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WeUIwezS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5586F87EED; Sat,  3 Aug 2024 00:13:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8A188C4E
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722636771; bh=dih98ilIyPPf1nb6Ges6QsqzXjyxoyPoNWzMyy0qR6E=;
 b=WeUIwezSkEnlyv8poIZ1nrt/CipA1zP68Ii3tShpcYvrhPOp5My+/Gdj4FSzndgU+YhUMtchL
 pwpw6ZesC6OWRznW4sAE5W0x2RBHG71F9ti3mkNRvomUoweeDAuSz541aeKDcahq2yDRHpxoDOR
 1ejIXz66BcMw6MN019Y4zqIXjR8/xjfOBbWx8YxvtWbg4P3HQbY4gFjC2SLOS0REPeX8xf3QWd8
 6v56dTSr9RwAF9cUqxsG6qxY07+Jim0POF6Ef6rajjyiYz1/jsb7mojptj2WOvp06WzvR1J9TVm
 1psnO/WKFjyc+/RMvWjpBeRRIHVV8LdJWPY+vnT0u4DA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/5] arm64: dts: rockchip: fix mmc aliases for Radxa ZERO
 3E/3W
Date: Fri,  2 Aug 2024 22:12:20 +0000
Message-ID: <20240802221231.2629416-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802221231.2629416-1-jonas@kwiboo.se>
References: <20240802221231.2629416-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad59dfb3fb002aec6e71f0
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
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Add Signed-off-by tag
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

