Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51049C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 20:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B2C841F2;
	Sat, 27 Jun 2026 22:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="np5km7yY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D37A842FC; Sat, 27 Jun 2026 22:24:22 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8090D83FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 22:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9abc=EY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1782591857;
 bh=F7kmuJ2+coWAZJBSadx5AsZGT4ucCc29d6VVsoBvJMA=;
 b=np5km7yYgsASuBY8pRrfU+w52NSL/NmaTyw0R4GYiRBHOtGroAx42HcCHihmPo1Aqq+zVgDuH
 4ftGxLqNBc76p4n9+wpdtSFjcgEJtgZVmmjcRLNsg90OEVP+J8U5XkmuN6cpR4e5TinByPkuQrp
 oGFqErGB7/IfwVMqeoAyBjh8cntMGjr1AeIN+k/hCobphH8x+vylypnb/jT8O63nDqYfl4HVg9M
 hH7aTfxx/s1fmkWDv7BHUcldz5yOK+rh+4wLyCARwHGqVQDDbH8S3QNHdurw7UeG0Q4zH7Ve4k/
 4UzACtHGXtfHdbSY9Kwv20ZPlVGCUWH/2xJs58GtFj9A==
X-Forward-Email-ID: 6a4031706b1975806ef910c3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.9.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH] rockchip: sdram: Fix initialization of DRAM banks
Date: Sat, 27 Jun 2026 20:24:09 +0000
Message-ID: <20260627202410.1148976-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

The commit 55a342176984 ("common: Add an option to relocate on ram top")
changed so that dram_init_banksize() is called before gd->ram_top has
been initialized. This change broke Rockchip DRAM banks configuration
due to gd->ram_top now being 0 when dram_init_banksize() is called.

This makes first DRAM bank size calculation overflow and end up with

  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0xffffffffffe00000

instead of the expected (for 2 GiB)

  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0x000000007fe00000

or (for 4 GiB)

  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0x00000000f7e00000

on e.g. RK3399 boards.

Change to not depend on gd->ram_top having to be pre-calculated before
dram_init_banksize() is called, also move the related method
board_get_usable_ram_top() closer to more easily get an overview of
their interdependence, to restore working DRAM bank initialization.

Fixes: 55a342176984 ("common: Add an option to relocate on ram top")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/sdram.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index f0923186fa61..2e404df1b200 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -294,10 +294,20 @@ __weak int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/* Make sure U-Boot only uses the space below the 4G address boundary */
+	u64 usable_top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
+
+	return (gd->ram_top > usable_top) ? usable_top : gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
-	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
-	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
+	/* Make sure first bank uses the space below the 4G address boundary */
+	u64 usable_top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
+	size_t ram_top = (unsigned long)(CFG_SYS_SDRAM_BASE + gd->ram_size);
+	size_t top = min((unsigned long)ram_top, (unsigned long)(usable_top));
 
 #ifdef CONFIG_ARM64
 	int ret = rockchip_dram_init_banksize();
@@ -507,11 +517,3 @@ int dram_init(void)
 
 	return 0;
 }
-
-phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
-{
-	/* Make sure U-Boot only uses the space below the 4G address boundary */
-	u64 top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
-
-	return (gd->ram_top > top) ? top : gd->ram_top;
-}
-- 
2.54.0

