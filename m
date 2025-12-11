Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC2D41D6A
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2CA83A26;
	Thu, 11 Dec 2025 17:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="E8+d2r5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6BE8312A; Thu, 11 Dec 2025 17:35:10 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1093C83106
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20251211163501875938354000020773 for <u-boot@lists.denx.de>;
 Thu, 11 Dec 2025 17:35:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DXuhi2R4usUMi4S5/lrCXouum+ugBkTGmzEWQ30yeHo=;
 b=E8+d2r5I9kWvReiZtxWdF23rHdYKKDxIUWNMAZhFOnbChJc9SZEkQRE7gil5ymea9shZ9p
 cL99KNodPbxpkD3TweYLBrcJKn5zqX1iV+BOzqcMtKXbAGQUof2v8VfwEqWSkRY5LKXtNn5U
 ZP8/uN5Whk6TIaMrU3BuaI+tR262l3DfU84elcCLsV8auIbkHXBqXssbLzUZ7bHSlshl2oud
 dhF2gh4EmmojfFFzy0yvfsZuH1mB5jFCdyz3aEkpSX18src+otSDVHZbjTZAEDlhZCfsl9R3
 baLtr6SQgz93FXQHt2nGI+x40GTc1INK6ooboFgVHcOqi2jkaVUTG2Fg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v3 4/5] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
Date: Thu, 11 Dec 2025 17:34:58 +0100
Message-ID: <c9a6e6f8ec5e854057459e91db20a46c9420b392.1765470899.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765470899.git.jan.kiszka@siemens.com>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
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
index 28554b7a109..7f65aed4540 100644
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
+#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
+     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						 unsigned long raw_sect)
+{
+	/* offset of u-boot proper inside u-boot-with-spl.sfp image */
+	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
+}
+#endif
-- 
2.51.0

