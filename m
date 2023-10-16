Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED58CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C209C86EDD;
	Mon, 16 Oct 2023 18:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697473001;
	bh=cZ8NIS2tcPucmK0dq/VP+40NOO82nXr8MX3xV+N2G80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEic79x+4cVO1OUlQo/iXlogBzkLGbSbYz1rccQsr7jusqt+WrXx7sonay0Ufw1FH
	 +860uP7jWqHIA5mUi6KzbiiY9BKAZdII4b9NAxunCmadUCiVyxrEVwTigttT47GyK/
	 LBWNGZgZivfmfKEBnkb0U6C7OwQGAIEz3RvkAmv7kWdlnxzdI0KXvhs3rSwQG14JBX
	 0vw+sHbe1LwQfn2Kg+y88o62g07CsfGSqOUIJHQO2sLMVrozraOQq1z75tYNGS0GnH
	 84u5Oj6xgo31i5tFYpWIvMM5DwR2jcg1hD3UXOGMvqSnk06tMVQ1XQ1yaFXYCPrvLZ
	 PVy9hq1Y5Zwtg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8E4FE86C68;
 Mon, 16 Oct 2023 18:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697472999;
 bh=cZ8NIS2tcPucmK0dq/VP+40NOO82nXr8MX3xV+N2G80=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q9iBCwloQNCtEW3QPEykVlfYcyxOHPGN7wlMjHNFQsIR6oMJiLwp93med50Foa8q4
 rhrTVTRPJ/gHwd8Hs335/QvEQgmN4azTLz7KYpGYc88Nf6uJi3wrqteziSIBIzKhLb
 3GQdhWLklcyIgcbEb5gO7Sp+X+tK1Sm7O/fFAQAitX0nU2d590UZpbEE6Oyi6IDgc2
 5RbUOkjKqaXLegTwrhqft18hhJpMPDd45GYQpX07NLce3F4OsVxwTBrnGfWPA9p2pS
 Egvc+cgeqK7ytX1BQb1sUYCTMj59vc4VNJootH7ZciK/nlsGDREQW23SLhK29gpD/u
 C5rKRECwIHxvA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Chanho Park <chanho61.park@samsung.com>, Elena Popa <elena.popa@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 2/4] ARM: imx: Factor out parsing of ROM log
Date: Mon, 16 Oct 2023 18:16:13 +0200
Message-ID: <20231016161619.50744-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016161619.50744-1-marex@denx.de>
References: <20231016161619.50744-1-marex@denx.de>
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

From: Fedor Ross <fedor.ross@ifm.com>

Factor out parsing of ROM log in function spl_mmc_emmc_boot_partition().
This can be helpful to detect a secondary image boot without fiddling
around with MMC partitions. This way for example, U-Boot is able to
detect a secondary image boot and can enter some fallback scenario like
starting a recovery mode.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Elena Popa <elena.popa@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fedor Ross <fedor.ross@ifm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
V2: No change
---
 arch/arm/mach-imx/imx8m/soc.c | 55 +++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index fc829588ce8..930ee5f59f9 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -648,19 +648,17 @@ struct rom_api *g_rom_api = (struct rom_api *)0x980;
 
 #if defined(CONFIG_IMX8M)
 #include <spl.h>
-int spl_mmc_emmc_boot_partition(struct mmc *mmc)
+int imx8m_detect_secondary_image_boot(void)
 {
 	u32 *rom_log_addr = (u32 *)0x9e0;
 	u32 *rom_log;
 	u8 event_id;
-	int i, part;
-
-	part = default_spl_mmc_emmc_boot_partition(mmc);
+	int i, boot_secondary = 0;
 
 	/* If the ROM event log pointer is not valid. */
 	if (*rom_log_addr < 0x900000 || *rom_log_addr >= 0xb00000 ||
 	    *rom_log_addr & 0x3)
-		return part;
+		return -EINVAL;
 
 	/* Parse the ROM event ID version 2 log */
 	rom_log = (u32 *)(uintptr_t)(*rom_log_addr);
@@ -668,7 +666,7 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 		event_id = rom_log[i] >> 24;
 		switch (event_id) {
 		case 0x00: /* End of list */
-			return part;
+			return boot_secondary;
 		/* Log entries with 1 parameter, skip 1 */
 		case 0x80: /* Start to perform the device initialization */
 		case 0x81: /* The boot device initialization completes */
@@ -686,24 +684,45 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 			continue;
 		/* Boot from the secondary boot image */
 		case 0x51:
-			/*
-			 * Swap the eMMC boot partitions in case there was a
-			 * fallback event (i.e. primary image was corrupted
-			 * and that corruption was recognized by the BootROM),
-			 * so the SPL loads the rest of the U-Boot from the
-			 * correct eMMC boot partition, since the BootROM
-			 * leaves the boot partition set to the corrupted one.
-			 */
-			if (part == 1)
-				part = 2;
-			else if (part == 2)
-				part = 1;
+			boot_secondary = 1;
 			continue;
 		default:
 			continue;
 		}
 	}
 
+	return boot_secondary;
+}
+
+int spl_mmc_emmc_boot_partition(struct mmc *mmc)
+{
+	int part, ret;
+
+	part = default_spl_mmc_emmc_boot_partition(mmc);
+	if (part == 0)
+		return part;
+
+	ret = imx8m_detect_secondary_image_boot();
+	if (ret < 0) {
+		printf("Could not get boot partition! Using %d\n", part);
+		return part;
+	}
+
+	if (ret == 1) {
+		/*
+		 * Swap the eMMC boot partitions in case there was a
+		 * fallback event (i.e. primary image was corrupted
+		 * and that corruption was recognized by the BootROM),
+		 * so the SPL loads the rest of the U-Boot from the
+		 * correct eMMC boot partition, since the BootROM
+		 * leaves the boot partition set to the corrupted one.
+		 */
+		if (part == 1)
+			part = 2;
+		else if (part == 2)
+			part = 1;
+	}
+
 	return part;
 }
 #endif
-- 
2.42.0

