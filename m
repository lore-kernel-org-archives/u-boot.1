Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D65D10BF8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 12:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93FB88D9B;
	Sat, 26 Oct 2024 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC9888D94; Sat, 26 Oct 2024 13:40:35 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF43D88E6B
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 13:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 29B4EB4B0154;
 Sat, 26 Oct 2024 13:40:21 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Minda Chen <minda.chen@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Chanho Park <chanho61.park@samsung.com>, "E. Shattow" <lucent@gmail.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>, H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH] riscv64: dts: starfive: Star64 ethernet0 phy delay values
 sync with upstream Linux
Date: Sat, 26 Oct 2024 04:35:28 -0700
Message-ID: <20241026113537.10347-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 14:54:40 +0200
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

Fix bad delay values copied from vendor board support package of Star64, improves
performance and reliability of bottom network port.

Fixes: 7ebf7e77c0616ef0d2f58cc1684c230f656bd3d6
Signed-off-by: E Shattow <e@freeshell.de>
---
 board/starfive/visionfive2/spl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index f55c6b5d34..eb545e9365 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -103,9 +103,7 @@ static const struct starfive_vf2_pro star64_pine64[] = {
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
 		"motorcomm,rx-data-drv-microamp", "2910"},
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
+		"rx-internal-delay-ps", "1500"},
 
 	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
 		"motorcomm,tx-clk-adj-enabled", NULL},
-- 
2.45.2

