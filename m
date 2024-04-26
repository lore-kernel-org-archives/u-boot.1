Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF67C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 16:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58988882A5;
	Fri, 26 Apr 2024 18:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530A1882A6; Fri, 26 Apr 2024 18:56:01 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F13A882A3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 18:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s0Orc-003fWj-UM;
 Fri, 26 Apr 2024 16:55:57 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] venice: show emmc boot hardware partition
Date: Fri, 26 Apr 2024 09:55:54 -0700
Message-Id: <20240426165554.1376497-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

To aid in understanding what emmc hardware partition is being
used to boot on power-up, display the hardware partition name in the
SPL.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/spl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 3b0f11f2fd0f..531bad260b6d 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -366,9 +366,25 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
 
 const char *spl_board_loader_name(u32 boot_device)
 {
+	struct mmc *mmc;
+	int part;
+
 	switch (boot_device) {
 	/* SDHC2 */
 	case BOOT_DEVICE_MMC1:
+		mmc_init_device(0);
+		mmc = find_mmc_device(0);
+		mmc_init(mmc);
+		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+		switch (part) {
+		case 1:
+			return "eMMC boot0";
+		case 2:
+			return "eMMC boot1";
+		case 0:
+		case 7:
+			return "eMMC user";
+		}
 		return "eMMC";
 	/* SDHC3 */
 	case BOOT_DEVICE_MMC2:
-- 
2.25.1

