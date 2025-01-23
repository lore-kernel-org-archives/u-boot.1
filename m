Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436C4C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEB580763;
	Thu, 23 Jan 2025 23:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="owfKQTDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761B08078B; Thu, 23 Jan 2025 23:02:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C078076E
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737669755; bh=bIcll/hu8eHDS5vLKKWsVYwwz0fHY/OzJFmQDzOwlPU=;
 b=owfKQTDoC1pk7gkrslcDlQAnSzFglfOb3V78mqgMDo0B6ioB7iurx4PODo/pzrd56Dt+Qn9IO
 Qv2CjGtWN7kXSNiTtg3kcRIOdjZlvy0IajJSf9U+5HCnzMhotxVzJAzZkCdoAkI1a9fpKdfRdAg
 z9G70WzgByTn34SbqRAmEtpc/f+Ib3n4YeQFFHuY3wMUHBoCwDCIGbI+RWgdwgYv2TQ52jEDD5W
 x7OS0+AWH3UXr9xzq6WcfPvHBNlNY9dT12r4sJgFNHu4DK9fWhaM7fV0xUig2YSrg0ypqa6E5Xl
 YdCDf5t9w0shkHM+1/iVlI/cjng49iX+A4IazH5WC6eA==
X-Forward-Email-ID: 6792bc79f07771e5c89df4f3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: sdram: Fix reserve of 2 MiB at start of DRAM
Date: Thu, 23 Jan 2025 22:02:18 +0000
Message-ID: <20250123220222.3089386-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220222.3089386-1-jonas@kwiboo.se>
References: <20250123220222.3089386-1-jonas@kwiboo.se>
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

Normally 2 MiB at the beginning of DRAM is reserved for TF-A use.
However, this only works as intended when DRAM starts at 0x0.

When DRAM starts at e.g. 0x40000000 this reservation never happens, and
U-Boot or Linux may try to read/write into secure memory.

Fix this by taking CFG_SYS_SDRAM_BASE into consideration when reserving
2 MiB at start of DRAM.

Also change to use SZ_2M and SZ_32M for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/sdram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 3d3fc327234f..caca6f917305 100644
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
@@ -302,8 +302,8 @@ int dram_init_banksize(void)
 	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
 	      ret);
 
-	/* Reserve 0x200000 for ATF bl31 */
-	gd->bd->bi_dram[0].start = 0x200000;
+	/* Reserve 2M for ATF bl31 */
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
 
 	/* Add usable memory beyond the blob of space for peripheral near 4GB */
@@ -332,7 +332,7 @@ int dram_init_banksize(void)
 		gd->bd->bi_dram[0].size = 0x8400000;
 		/* Reserve 32M for OPTEE with TA */
 		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE
-					+ gd->bd->bi_dram[0].size + 0x2000000;
+					+ gd->bd->bi_dram[0].size + SZ_32M;
 		gd->bd->bi_dram[1].size = top - gd->bd->bi_dram[1].start;
 	}
 #else
-- 
2.48.1

