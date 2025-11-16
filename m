Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F02CEBF87
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 01:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855FF83A35;
	Sun, 16 Nov 2025 02:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SAWX0Pzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F64983A56; Sun, 16 Nov 2025 02:45:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0761983A2D
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 02:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=62e4=5Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1763257546;
 bh=Pf+s+YWhb0kt9r2I12R6L3ATL/ejZnLaFTxix3sOiRs=;
 b=SAWX0PznJf1lQnPf8HLF2ojWBSPjkpSOBbyjrbN75OXhNQQTQEvsadpz4cKsGYSANekenX8yr
 x5V7UCCFNgvcY7J9ozE8dRSrlv8N5S9Jjp1ZL3rsJqwmXazubmF2mr70it3NoRuK6NUxxNdkyyl
 ICKRwx/1xabyp+ENv7UBNSzvwnqLZcEM8JQz/i1Pcyepp9cSjU4S3THd/zktqZ8nRYCgA3/0K+u
 T3jrq3Bi/Rcj5IM7mQn7DsGwkbA5gTB4rarAdTHMCX8nNZHqe7dlwKQcE3p2BoFfATfAVygCSOf
 z++IHku7m931DmrtLkPGxJy2S5LKlK+Y0/5xrhMAFnxg==
X-Forward-Email-ID: 69192cc2874de5639c1150c0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3588: Map SCMI shared memory area as non-cacheable
Date: Sun, 16 Nov 2025 01:45:29 +0000
Message-ID: <20251116014531.2133243-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.2
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

The SCMI shared memory area is no longer automatically marked as
non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
mmu_set_region_dcache_behaviour() misuse").

This change in behavior cause Rockchip RK3588 boards to fail boot with:

  SoC:   RK3588
  DRAM:  8 GiB
  scmi-over-smccc scmi: Channel unexpectedly busy
  scmi_base_drv scmi-base.0: getting protocol version failed
  scmi-over-smccc scmi: failed to probe base protocol
  initcall_run_r(): initcall initr_dm() failed
  ### ERROR ### Please RESET the board ###

Update the memory mapping on RK3588 to mark the SCMI shared memory area
as non-cacheable to fix the SCMI shared memory based transport issue
that prevented RK3588 boards from booting.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index c01a40020896..55d2caab4fec 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -63,7 +63,20 @@ static struct mm_region rk3588_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
-		.size = 0xf0000000UL,
+		.size = 0x10f000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* SCMI shared memory area must be mapped as non-cacheable. */
+		.virt = 0x10f000UL,
+		.phys = 0x10f000UL,
+		.size = 0x1000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x110000UL,
+		.phys = 0x110000UL,
+		.size = 0xefef0000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
-- 
2.51.2

