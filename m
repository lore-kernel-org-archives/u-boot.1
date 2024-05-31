Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB80C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182DA887C9;
	Fri, 31 May 2024 17:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F81887BA; Fri, 31 May 2024 17:36:45 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB897887C4
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sD4J5-005Ytl-4A;
 Fri, 31 May 2024 15:36:39 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <avri.altman@wdc.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [RESEND PATCH v4 3/3] venice: show emmc boot hardware partition
Date: Fri, 31 May 2024 08:36:35 -0700
Message-Id: <20240531153635.246154-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531153635.246154-1-tharvey@gateworks.com>
References: <20240531153635.246154-1-tharvey@gateworks.com>
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
v4: new patch for this series
---
 board/gateworks/venice/spl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 6f6dea84feee..ad3af93143d9 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -366,16 +366,24 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
 
 const char *spl_board_loader_name(u32 boot_device)
 {
+	static char name[16];
+	struct mmc *mmc;
+
 	switch (boot_device) {
 	/* SDHC2 */
 	case BOOT_DEVICE_MMC1:
-		return "eMMC";
+		mmc_init_device(0);
+		mmc = find_mmc_device(0);
+		mmc_init(mmc);
+		snprintf(name, sizeof(name), "eMMC %s", emmc_hwpart_names[EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)]);
+		return name;
 	/* SDHC3 */
 	case BOOT_DEVICE_MMC2:
-		return "SD card";
-	default:
-		return NULL;
+		sprintf(name, "SD card");
+		return name;
 	}
+
+	return NULL;
 }
 
 void spl_board_init(void)
-- 
2.25.1

