Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229B0FCA189
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CB383A8C;
	Mon,  9 Mar 2026 22:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xHhn5LZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BB683BC8; Mon,  9 Mar 2026 22:02:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A9983952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1773090163;
 bh=vSEw+7z6KRPjbiiUj1QdHYWitijQGexAotXdfmR5mxs=;
 b=xHhn5LZJhB87GHFUqxqaFt1NnG33brgmx1J/PALy7KRvYj/VvBPrDy3+pnj4pN8I8QA5ijcAm
 o7BTFNoDt80VDxOYPlZi8a60th68TonT9apxJ7+mrLygxRrBrKNilXcsEdKWWzPibd1l99tsw3Q
 yk3fXNjZJLF1VR7uaQLyhomy2+jP336VW0GGJEVGWkf3l0auxOXvSsRwX20gaQxR4gVFcgHkNy0
 DefH1lvupfTEOss0d45dL3kJCh7UcOobIkSZqHixcsSoeC6MIXJphv3k9tjAj9OoQvBN6NlnD8U
 7TsIXsrOPReTmI22ekyxEM3TPzv8uFpi229Ay0rALlZg==
X-Forward-Email-ID: 69af356f76762a90c7fa41a9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory map
Date: Mon,  9 Mar 2026 21:02:32 +0000
Message-ID: <20260309210234.521070-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
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

Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
the initial 32-bit 0-4 GiB addressable range in its memory map,
something that matches gd->ram_top and current expected memory available
for use in U-Boot.

The vendor DRAM init blobs add following ddr_mem rk atags [1]:

  4 GiB: [0x0, 0xf0000000) and [0x1f0000000, 0x200000000)
  8 GiB: [0x0, 0x200000000)

Add the remaining 64-bit 4-8 GiB addressable range, that already is
reported to OS, to the U-Boot memory map to more correctly describe all
available and addressable DRAM of RK356x. While at it also add the
missing UL suffix to the PCIe address range for consistency.

[1] https://gist.github.com/Kwiboo/6d983693c79365b43c330eb3191cbace

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Update commit message
- Collect a-b tag
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index c2b96902d2dd..2b1eafee37c9 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -72,9 +72,15 @@ static struct mm_region rk3568_mem_map[] = {
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
-		.virt = 0x300000000,
-		.phys = 0x300000000,
-		.size = 0x0c0c00000,
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = 0x100000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x300000000UL,
+		.phys = 0x300000000UL,
+		.size = 0x0c0c00000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.53.0

