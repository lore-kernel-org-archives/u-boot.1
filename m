Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE853CCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B78838E7;
	Tue,  4 Nov 2025 11:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="oGnK16oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8812F8003E; Tue,  4 Nov 2025 11:30:41 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A576E8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 139E3C9DCE; Tue,  4 Nov 2025 11:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762252239; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=FQ3q8vANPdlEX7lXSTbA2PoNcztzKf1sKXhtnbUWscg=;
 b=oGnK16oHZJ56VrJSv4wurQGZhCc/grj3hiK/6TckbvqE0s+SEEp24a1X/c132EhtAnlCTU
 +QGl1iq0ydGPML4d/K70xItR2DnFFFgrtN/x8cIRGrsxCD1xOfuiKp7oYbVcyTY+plSTBe
 wDtBm5vQSNT/LrOJyCAHXz1IzVjHh5ciCVw02IjnbCO37qsK6EPz0vtcf5y4TQ7H1z6d5J
 VkCcaooqNyrWxHy8CERnON9904FkBzwR5FL2oxMDzxBZMYy5d1aeGQBB1p09slFGeRs1+D
 C9VOHuzJHR4cGpoDoG5Ork4H6OQQVRnZqVbhMseiS8cJAEL4gj6uJn/2P9XiRQ==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 2/2] imx: kontron-sl-mx8mm: Implement spl_board_loader_name()
Date: Tue,  4 Nov 2025 11:30:08 +0100
Message-ID: <20251104103010.43702-2-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104103010.43702-1-frieder@fris.de>
References: <20251104103010.43702-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This allows to print user-friendly names for the boot device
probed by SPL to the console.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/spl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index 50eb0eb13e1..a5cdd2ab6d1 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -206,6 +206,33 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
 	return raw_sect;
 }
 
+const char *spl_board_loader_name(u32 boot_device)
+{
+	static char name[16];
+	struct mmc *mmc;
+
+	switch (boot_device) {
+	case BOOT_DEVICE_SPI:
+		sprintf(name, "SPI NOR");
+		return name;
+	case BOOT_DEVICE_MMC1:
+		mmc_init_device(0);
+		mmc = find_mmc_device(0);
+		mmc_init(mmc);
+		snprintf(name, sizeof(name), "eMMC %s",
+			 emmc_hwpart_names[EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)]);
+		return name;
+	case BOOT_DEVICE_MMC2:
+		sprintf(name, "SD card");
+		return name;
+	case BOOT_DEVICE_BOARD:
+		sprintf(name, "USB OTG");
+		return name;
+	}
+
+	return NULL;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
-- 
2.51.0

