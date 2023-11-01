Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEA2C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCAF8768E;
	Wed,  1 Nov 2023 21:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5630586E64; Wed,  1 Nov 2023 21:06:40 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 268438769B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,269,1694703600"; d="scan'208";a="185272685"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 02 Nov 2023 05:06:32 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.52])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5D22C400F50E;
 Thu,  2 Nov 2023 05:06:30 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 1/8] arm: armv8: mmu: Prepare for common.h removal
Date: Wed,  1 Nov 2023 20:05:52 +0000
Message-Id: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

If <common.h> won't be included before <asm/armv8/mmu.h>, we need to
ensure that we have the required type definitions.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/include/asm/armv8/mmu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 19a9e112a434..4f0adb07325f 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -118,6 +118,8 @@
 #define HCR_EL2_E2H_BIT		34
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 static inline void set_ttbr_tcr_mair(int el, u64 table, u64 tcr, u64 attr)
 {
 	asm volatile("dsb sy");

base-commit: a803f87202aa48974bdff4d8100464a8288931e4
-- 
2.39.2

