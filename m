Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ABBC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF29882C4C;
	Tue, 15 Apr 2025 23:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="qDYt97Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E99582C4C; Tue, 15 Apr 2025 23:52:10 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A683482BE3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5fLjrzrupV/gLAuRaeDW6yfLLfrYIuxwGtsvgEGQXPU=; b=qDYt97YvkgVoL7icMnxBJQvZjS
 x4Bu5FePPetTIJSlaPKkcYjuPVcAzF1GC7sXELKpu6ESy+NNzeUUHrq0xWhFpy5W++NgchFXmXgCK
 2CveUf3++HLIjqgNOo+VxMncISF1Gw8IZAGL7vbfjTO8OU6EIKFAoEskA4z4y3jBk2x+rSTxT4Al2
 4GJRgb+gi+ieA2pQMF/BEBRAnEUaCxUGf1kLOULZeo0z6LhApP5fEeLTiLXBzUZ0blkBzyuZp3Y5x
 hJK92ZAZ9djNVAAWjndJ8vJIHcqd8jBim780uN6M3md1mtrhdbxxTmFFXiG6uG9lqbb85jinfZAY9
 AAQQ2aWw==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4oCD-0007Uo-FF; Tue, 15 Apr 2025 23:51:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v3 01/15] rockchip: sdram: honor CFG_SYS_SDRAM_BASE when
 defining ram regions
Date: Tue, 15 Apr 2025 23:51:14 +0200
Message-ID: <20250415215128.1475593-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415215128.1475593-1-heiko@sntech.de>
References: <20250415215128.1475593-1-heiko@sntech.de>
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
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/sdram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index aa3f47c3f20..f20d30f3595 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -182,9 +182,9 @@ static int rockchip_dram_init_banksize(void)
 		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
 		 * have it, so force this space as reserved.
 		 */
-		if (start_addr < SZ_2M) {
-			size -= SZ_2M - start_addr;
-			start_addr = SZ_2M;
+		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
+			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
+			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
 		}
 
 		/*
@@ -229,7 +229,7 @@ static int rockchip_dram_init_banksize(void)
 					return -EINVAL;
 				}
 
-				size -= rsrv_end - start_addr;
+				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
 				start_addr = rsrv_end;
 				break;
 			}
@@ -302,8 +302,8 @@ int dram_init_banksize(void)
 	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
 	      ret);
 
-	/* Reserve 0x200000 for ATF bl31 */
-	gd->bd->bi_dram[0].start = 0x200000;
+	/* Reserve 2M for ATF bl31 */
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
 
 	/* Add usable memory beyond the blob of space for peripheral near 4GB */
-- 
2.47.2

