Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140B3D73E84
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 19:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBE584082;
	Thu, 29 Jan 2026 20:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kJfCDDCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B43840A2; Thu, 29 Jan 2026 20:32:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB74A84073
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 20:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769715125;
 bh=NTHr0Dt8StDQnvlp8X4xUehKQn55dWL7iwMpCkFcVI8=;
 b=kJfCDDCHFXOLvAfYKDixrdC/y5JsKRrkn+3joUTx04YF/mpEFGz+GwwoI0EtPMOmuaodM1ce3
 a1yO+SfVdKL3eJu8iuWH5+aRY8BuRsQ3qpumGHp2rcZwjKG4JLv+SlydLm62yOBCTtoX5xQGdFa
 ALiELSRFVGBBpO9cbd+nZ2vi6im9kskRue7qxzS/S6d2AAUHUzAJOQbl/NGx3CxE3IsWl7/gbbF
 EFD3IsJ+Eecat5XK6SkgO+6Kq0ORyTKgyDKmT9cG2sWD5fzscDq3OfrXK6nIJ2fgIHovaPctF2B
 l8CKA1b/3XmspMdu4vm6+MENK3RAJMWDEPLAAaNpiG9Q==
X-Forward-Email-ID: 697bb5af8bac728cb5318728
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory map
Date: Thu, 29 Jan 2026 19:31:50 +0000
Message-ID: <20260129193153.2232395-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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
the initial 4 GiB in its memory map, something that matches gd->ram_top
and current expected memory available for use in U-Boot.

Add the remaining 4-8 GiB range to the memory map to more correctly
describe available and addressable DRAM of RK356x. While at it also add
the missing UL suffix to the PCIe address range for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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
2.52.0

