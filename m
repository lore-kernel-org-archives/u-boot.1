Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E8CE83071
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 09:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05048405A;
	Tue,  3 Feb 2026 10:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C843684067; Tue,  3 Feb 2026 10:58:23 +0100 (CET)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809E48404D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 10:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4zSr6FZCzk8L;
 Tue,  3 Feb 2026 10:58:20 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4f4zSq2TBfzsGS; Tue,  3 Feb 2026 10:58:19 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 03 Feb 2026 10:58:06 +0100
Subject: [PATCH RFC] rockchip: rk3588: include all addressable DRAM in
 memory map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rk3588-mem-map-v1-1-04005ea48fe5@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKFblG1samGhm5uaq5ubWKBrYGpsZmaYmGieamKmBNRUUJSallkBNjB
 aKcjNWSm2thYAwyfIUmUAAAA=
X-Change-ID: 20260202-rk3588-mem-map-053661aa7e46
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The ATAGS set by Rockchip DDR init blob[1] specify DRAM banks above the
first addressable 4GiB which we haven't done in the mem_map for RK3588
yet.

For 4GiB DRAM, the 256MiB missing from the first addressable 4GiB (due
to MMIO) are accessible at the end of the 8GiB address space. For 8GiB,
4-8GiB address space is used for the additional 4GiB and the missing
256MiB are at the end of 12GiB address space. For 12, 4-12GiB and the
missing 256MiB at the end of 20GiB address space. For 16GiB, 4-~16GiB
with two holes (reasons unknown) around 16GiB and the missing 256MiB is
at the end of 20GiB address space. For 32GiB, 4-16~GiB with two holes
and then 16GiB to 32GiB address space (so likely missing 256MiB from
MMIO address space).

[1] https://gist.github.com/Kwiboo/1c020d37e3adbc9d0d79dc003d921977

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This is the RK3588 counterpart to RK3568's[1] which is required for
Marek's patch[2] to not crash RK35xx series of SoCs when booting.

This (plus patch[2]) has been tested on 4, 8 and 16GiB by TFTP'ing a
kernel and DTB into the various DRAM regions above 4GiB and booting this
kernel+dtb combination.

Note that I have zero clue as to what this is actually doing as I cannot
understand where this mem_map is actually used, hence the RFC.

[1] https://lore.kernel.org/u-boot/20260129193153.2232395-1-jonas@kwiboo.se/
[2] https://lore.kernel.org/u-boot/20260127234856.1503030-1-marek.vasut+renesas@mailbox.org/
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 55d2caab4fe..438642ca529 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -87,6 +87,24 @@ static struct mm_region rk3588_mem_map[] = {
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	},  {
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = 0x2fc000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x3fc500000UL,
+		.phys = 0x3fc500000UL,
+		.size = 0x3a00000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x400000000UL,
+		.phys = 0x400000000UL,
+		.size = 0x400000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
 		.virt = 0x900000000,
 		.phys = 0x900000000,
 		.size = 0x150000000,

---
base-commit: 16fcbcb2ee25ea042c1e9cfbc04f7a5554746b64
change-id: 20260202-rk3588-mem-map-053661aa7e46

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

