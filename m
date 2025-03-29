Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090EFC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02AD81F0B;
	Sat, 29 Mar 2025 16:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oazmWBEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35DD681F00; Sat, 29 Mar 2025 16:07:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DCB805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260815; bh=9NwLhSfLqZaud9ukDQG/kH6wOv2hlNwmthVyZ7LEplw=;
 b=oazmWBEythCFxiwlBPOu1SxLEkH4evXkG5D8+sgjIaq/lH81DOij1IC/Qs0WLfwdnGywgfCqF
 lNKngAJZsg+meABnuJQnAVVGRJERtyEcYH+g1cIFmhVT1sWHZd8p0kgNREL9tlOnXCUG7Uok67c
 rjLK+OCccwa75BqUbis+NtYj7YWj4ZtnC+GNEa0vE5yI1qP6N9ivQGhcjIsKS0KKSAX+nDunSKR
 eNPGBsNAc/0t6F4m9CFXTA+FECq1GeHswMizLzQ2PN4P9LUBKjdCaLgOH/n00HtnsmzvwuCJsZs
 9iFrQ+9MAIij/L5fZ4FxLOSJOEgl3EGG5RfsOgaK157w==
X-Forward-Email-ID: 67e80c8d21787eb134711f77
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 06/10] rockchip: binman: Use the FIT template in the SPI
 image
Date: Sat, 29 Mar 2025 15:06:09 +0000
Message-ID: <20250329150626.2879942-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
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

From: Simon Glass <sjg@chromium.org>

At present simple-bin-spi relies on the u-boot.itb file created by the
simple-bin image. Use the template to avoid this, since Binman may
change to process images in parallel in the future.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Drop filename for the SPI FIT
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"

Changes in v3:
- Keep the filename for the SPI FIT

This is an alternative for the issue reported and fixed in [1] and [2].

[1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
[2] https://lore.kernel.org/u-boot/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de/
---
 arch/arm/dts/rockchip-u-boot.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index f860bfc1ba72..73149b2d8bdd 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -207,8 +207,7 @@
 
 #ifdef HAS_FIT
 		fit {
-			type = "blob";
-			filename = "u-boot.itb";
+			insert-template = <&fit_template>;
 #else
 		u-boot-img {
 #endif
-- 
2.49.0

