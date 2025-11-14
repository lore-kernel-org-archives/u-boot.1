Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0593CCE8D55
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9417C8427F;
	Fri, 14 Nov 2025 18:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="nx8m1d4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18378427F; Fri, 14 Nov 2025 18:13:46 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A778425C
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20251114171343c1b9ed7773000207a2 for <u-boot@lists.denx.de>;
 Fri, 14 Nov 2025 18:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Aw+pdntw92TYLlQ+lVDZEeJIlFLj4fRW7kTxGsGhX0U=;
 b=nx8m1d4OQ04QUxubEKI3jc91o6M6qxTEaAB6KrpRAOEv7UcXgASX2cYlFimwCEPOm1ClUE
 wJ8J/21KIX51j1fEr+355lXkEv1yFeGFkqaAyq0tH5Mwmm5cWqkhZjs0kmwhjDSRm7SCDpiH
 HiPcdbbgRMUuICRu+Ng5yl1IQoZcI7r+/yT/L8Fkauoa5rewhM1Oz870l3KUgV5NAZfUs/J9
 9+x+C0IrFSJzZ6dFjGXGqmGxJDwrlhOjN5as6Y6tfZci3foQNMWKvYi5MsO1/3Yeq2afaAlq
 AjqPxgTbFUdb4FUKdJZE+EOm+QyZLDrc98EbA2FLU0pzZgWeEnzCC/BQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
Date: Fri, 14 Nov 2025 18:13:40 +0100
Message-ID: <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763140421.git.jan.kiszka@siemens.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
More precisely, SPL is stored 4 times. Take this and its padding into
account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
This allows loading from a partition, without the need to hard-code the
offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-socfpga/board.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 28554b7a109..d756f7381fb 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -14,6 +14,7 @@
 #include <hang.h>
 #include <handoff.h>
 #include <image.h>
+#include <spl.h>
 #include <usb.h>
 #include <usb/dwc2_udc.h>
 #include <asm/global_data.h>
@@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_SPL
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect)
+{
+	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
+}
+#endif
-- 
2.51.0

