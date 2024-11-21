Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B6D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B0989771;
	Thu, 21 Nov 2024 15:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="g/WO8oq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B065589778; Thu, 21 Nov 2024 15:28:14 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBA389772
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0hT8KmxtNZTHF1/aiBU/mxnwyt1XBeZjBArOh3WG9pc=; b=g/WO8oq8shq1rly+6tkc+RzFpy
 ninrYEyFNsy9DZYX8h77dLxhtL0kCFlVrTg4S4EtHZMGTejYBLoDbv+2Xc75VErc29+dQ7UztrJHt
 tI3RSb52hBnpCM9B9RnbSNy73AFtCwK2UuAQFVrzO9hkaS5WSZ6dDA0/bmsqlgDVvxIALqZrmAfgO
 zoVKBug5k8jRdsITq/tm794Vh2v4dSBja2ZPT0meMyiwHIqrtG7UnjWX2WXEtmSNBSpj5UAF2YOhd
 Ez1xs37x0ks1dtGiJ+xwXsCm8mYcvVMe8b5rl29kk3uk4v36uFM39gTvGD1Qod0ldc37IIu8UxTDh
 +m5ECC8A==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A2-0007f9-UH; Thu, 21 Nov 2024 15:27:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 08/20] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining
 ram regions
Date: Thu, 21 Nov 2024 15:27:19 +0100
Message-ID: <20241121142731.1202209-9-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

Currently the sdram code for arm64 expects CFG_SYS_SDRAM_BASE to be 0.
The ram being in front and the device-area behind it.

The upcoming RK3576 uses a different layout, with the device area
in front the ram, which then also extends past the 4G mark.

Adapt both the generic zone definitions as well as the ATAG parser
to be usable on devices where CFG_SYS_SDRAM_BASE is not 0.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/sdram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 1fb01e1c4b1..4e2af55d6e1 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -181,9 +181,9 @@ static int rockchip_dram_init_banksize(void)
 		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
 		 * have it, so force this space as reserved.
 		 */
-		if (start_addr < SZ_2M) {
-			size -= SZ_2M - start_addr;
-			start_addr = SZ_2M;
+		if (start_addr < SZ_2M + CFG_SYS_SDRAM_BASE) {
+			size -= SZ_2M - (start_addr - CFG_SYS_SDRAM_BASE);
+			start_addr = SZ_2M + CFG_SYS_SDRAM_BASE;
 		}
 
 		/*
@@ -228,7 +228,7 @@ static int rockchip_dram_init_banksize(void)
 					return -EINVAL;
 				}
 
-				size -= rsrv_end - start_addr;
+				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
 				start_addr = rsrv_end;
 				break;
 			}
@@ -302,7 +302,7 @@ int dram_init_banksize(void)
 	      ret);
 
 	/* Reserve 0x200000 for ATF bl31 */
-	gd->bd->bi_dram[0].start = 0x200000;
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + 0x200000;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
 
 	/* Add usable memory beyond the blob of space for peripheral near 4GB */
-- 
2.45.2

