Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F083DD4979F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 07:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000AA89323;
	Mon,  2 Dec 2024 08:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69BD89385; Mon,  2 Dec 2024 08:07:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9730689100
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 08:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843F61063;
 Sun,  1 Dec 2024 23:07:35 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24EFB3F71E;
 Sun,  1 Dec 2024 23:07:04 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] lmb: prohibit allocations above ram_top even from same bank
Date: Mon,  2 Dec 2024 12:36:24 +0530
Message-Id: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

There are platforms which set the value of ram_top based on certain
restrictions that the platform might have in accessing memory above
ram_top, even when the memory region is in the same DRAM bank. So,
even though the LMB allocator works as expected, when trying to
allocate memory above ram_top, prohibit this by marking all memory
above ram_top as reserved, even if the said memory region is from the
same bank.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/lmb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/lmb.c b/lib/lmb.c
index 14b9b8466ff..be168dfb8dc 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -615,6 +615,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 void lmb_add_memory(void)
 {
 	int i;
+	phys_addr_t bank_end;
 	phys_size_t size;
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
@@ -628,6 +629,8 @@ void lmb_add_memory(void)
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		size = bd->bi_dram[i].size;
+		bank_end = bd->bi_dram[i].start + size;
+
 		if (size) {
 			lmb_add(bd->bi_dram[i].start, size);
 
@@ -639,6 +642,9 @@ void lmb_add_memory(void)
 			if (bd->bi_dram[i].start >= ram_top)
 				lmb_reserve_flags(bd->bi_dram[i].start, size,
 						  LMB_NOOVERWRITE);
+			else if (bank_end > ram_top)
+				lmb_reserve_flags(ram_top, bank_end - ram_top,
+						  LMB_NOOVERWRITE);
 		}
 	}
 }
-- 
2.34.1

