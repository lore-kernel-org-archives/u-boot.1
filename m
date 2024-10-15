Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C979CFC27C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0429C889B3;
	Tue, 15 Oct 2024 17:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E65D889C3; Tue, 15 Oct 2024 17:37:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2580988A24
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311F9153B;
 Tue, 15 Oct 2024 08:38:18 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26C43F528;
 Tue, 15 Oct 2024 08:37:45 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 03/15] lmb: add and reserve memory above ram_top
Date: Tue, 15 Oct 2024 21:07:05 +0530
Message-Id: <20241015153717.401371-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015153717.401371-1-sughosh.ganu@linaro.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
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

U-Boot does not use memory above ram_top. However, this memory does
need to get registered as part of the memory map, so that subsystems
like EFI pass it on to the operating system as part of the EFI memory
map. Add memory above ram_top and reserve it with the LMB_NOOVERWRITE
flag so that it does not get allocated or re-used.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Suggested-by: Mark Kettenis <kettenis@openbsd.org>
---
Changes since V3: New patch

 lib/lmb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e1e616679f0..0504a7b3407 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -281,7 +281,6 @@ void lmb_add_memory(void)
 {
 	int i;
 	phys_size_t size;
-	phys_addr_t rgn_top;
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
 
@@ -292,16 +291,16 @@ void lmb_add_memory(void)
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		size = bd->bi_dram[i].size;
 		if (size) {
-			if (bd->bi_dram[i].start > ram_top)
-				continue;
-
-			rgn_top = bd->bi_dram[i].start +
-				bd->bi_dram[i].size;
-
-			if (rgn_top > ram_top)
-				size -= rgn_top - ram_top;
-
 			lmb_add(bd->bi_dram[i].start, size);
+
+			/*
+			 * Reserve memory above ram_top as
+			 * no-overwrite so that it cannot be
+			 * allocated
+			 */
+			if (bd->bi_dram[i].start >= ram_top)
+				lmb_reserve_flags(bd->bi_dram[i].start, size,
+						  LMB_NOOVERWRITE);
 		}
 	}
 }
-- 
2.34.1

