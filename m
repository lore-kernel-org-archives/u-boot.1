Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11CED111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C1483A2D;
	Mon,  1 Dec 2025 08:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZWG/Ixju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7AF839D5; Mon,  1 Dec 2025 08:32:54 +0100 (CET)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97307839F1
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 2025120107325109a3e7d786000207e5 for <u-boot@lists.denx.de>;
 Mon, 01 Dec 2025 08:32:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=C0nAyopwKhatbW26uz1LVCSoVd5FGpGlOBAGwpVTqAw=;
 b=ZWG/Ixjuim4BWX6YbhOzfhqmwA8soA9K3RP5uM+50W8bIaDuzqdLDo8Nj6wWR2XWy6UewR
 DiCbAunjnTUehX0xP0K/S2eq87rzo1ByAPB3d5+8fnMWBR7IcWxZZfh+oqqb3YVBzr0AFvSg
 qPSLSM51O9m2LK/TQI0vhq6bPUh4RuY8aCVcDoHvT2aaBJOOeLcJ0n/uLECM2Pr4lXPtLecA
 xEw/vo/K7G7oSENumnPV3JjbRGkJpPZY2varaPCtR2LlbKe2QQETwkg/f5Tv3VJe+sCOjVBs
 V/l/zuPwTeFX2touN0oCti8djKg2WzD10oxUiUYrLzUKOOILD+3sZjog==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
Subject: [PATCH v2 4/5] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
Date: Mon,  1 Dec 2025 08:32:48 +0100
Message-ID: <1046ae695f78304d3e756d2ff3d08aecb0d6ab2e.1764574369.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764574369.git.jan.kiszka@siemens.com>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
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
 arch/arm/mach-socfpga/board.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 28554b7a109..0b04f2bcacf 100644
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
@@ -209,3 +210,13 @@ void lmb_arch_add_memory(void)
 	}
 }
 #endif
+
+#if (defined(TARGET_SOCFPGA_ARRIA10) || defined(TARGET_SOCFPGA_GEN5)) && \
+    defined(CONFIG_XPL_BUILD)
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect)
+{
+	/* offset of u-boot proper inside u-boot-with-spl.sfp image */
+	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
+}
+#endif
-- 
2.51.0

