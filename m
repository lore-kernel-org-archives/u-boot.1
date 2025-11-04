Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EF2CCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7748144A;
	Tue,  4 Nov 2025 11:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="CwTLfAeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53B1836D1; Tue,  4 Nov 2025 11:30:40 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B078003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACCF8C9D1E; Tue,  4 Nov 2025 11:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762252237; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=osxNQpIxgG5lvnscKo7FSQTJ6yfKXAR5n1l4IyFT1WU=;
 b=CwTLfAeDndr+eA3SKAgcpk+8brtbi7Ir/Wju3Pn4JcU1KTZeiYb5AbP5BkgPZwId2Jo3H4
 XypP/lOGpef2w/BaHbT2QQo6fQl6XQcXrKDr4Jj3DQLppTn2VYf2QvHeapBgxIqvTsxCnQ
 QarldlXUC3awoxobRgiKZOdUvvwbysSOO0bqODzuAQFLcRsAm8MS04yRI87QNcquNva7fM
 NjvGX5HYu7qKp1BQyPFqzgmGZttfKfzA/h6poVIEXMkIv5WRAG1DxHi26C0Xk7+B5BSfEM
 MVPR8yUz1v0DQiKXvLsVhpqvNP7O9D4du/giIbMN/3uU5zg0wpWS51/CdhStkA==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 1/2] imx: kontron-sl-mx8mm: Adjust offset for U-Boot proper in
 case of eMMC fastboot
Date: Tue,  4 Nov 2025 11:30:07 +0100
Message-ID: <20251104103010.43702-1-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
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

The image offset on SD/MMC devices is 33 KiB, except for eMMC boot if
fastboot is enabled. In this case it is 1 KiB. In order to make the
the bootloader universal, check the fastboot OTP boot fuse and adjust
the offset.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/spl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index e3b029752b8..50eb0eb13e1 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -186,6 +186,26 @@ static int power_init_board(void)
 	return 0;
 }
 
+unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
+{
+	/*
+	 * The image offset on SD/MMC devices is 33 KiB, except for eMMC boot if
+	 * fastboot is enabled. In this case it is 1 KiB. In order to make the
+	 * bootloader universal, check the fastboot OTP boot fuse and adjust
+	 * the offset.
+	 */
+	if (!IS_SD(mmc) && (readl(OCOTP_BASE_ADDR + 0x470) & 0x80)) {
+		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+		case EMMC_BOOT_PART_BOOT1:
+		case EMMC_BOOT_PART_BOOT2:
+			raw_sect -= 32 * 2;
+			break;
+		}
+	}
+
+	return raw_sect;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
-- 
2.51.0

