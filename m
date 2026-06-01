Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC33CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF1784A38;
	Mon,  1 Jun 2026 14:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="htu5ka+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD01184878; Mon,  1 Jun 2026 12:13:26 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B9384869
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 12:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=HR6MNE+Hxbs7UKLGxqgLSNDL9r9waKHTjjmJyLYTWw8=; b=htu5ka+olMKOlSBDzrJm4Y4imp
 WwhA3XY+t+eXOZ+MOotd15Elo6+b5K87kZyV1SXERim9L+jYQnXbf05K9U4dWueck2OSmpMNcnAdB
 WHvwYt8K2rkrNyOoWuSe2u+Nqm7fsJyEXsIadIgyJBXKzSR4sSA90G8+6M1GvJw7hu5yF68g6UsVf
 A0r9qHGcX4x+zKBDiRDFiOAvqNvOlK7OxCOb8dzoLPsjmREdDLUjNHDPuY9PxoV55Ous7cu7c3u74
 EB7hBkpv7g44ztW7lzP/6b7h+093qpYBnHyQ1gMUVg5gpCWgqPDBIhVSbTr7wLwp864F+sB5eUolo
 SUdzKP0Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTze6-000Q0R-2T; Mon, 01 Jun 2026 12:13:22 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTze5-0000YR-2Q; Mon, 01 Jun 2026 12:13:22 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Aswath Govindraju <a-govindraju@ti.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] cmd: mmc: fix help and parameter verification with
 MMC_SPEED_MODE_SET not set
Date: Mon,  1 Jun 2026 12:13:18 +0200
Message-ID: <20260601101319.475824-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Currently help and parameter scanning does not check whether the feature
is enabled or not. This leads to wrong expectations based on help output
and no clear sign why the mmc dev and mmc rescan do not enforce the
supplied mode.

Fixes: 19f7a34a4642 ("mmc: Add support for enumerating MMC card in a given mode using mmc command")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 cmd/mmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 81b1ca4ad84..54c799891e1 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -519,7 +519,7 @@ static int do_mmc_rescan(struct cmd_tbl *cmdtp, int flag,
 
 	if (argc == 1) {
 		mmc = init_mmc_device(curr_device, true);
-	} else if (argc == 2) {
+	} else if ((argc == 2) && (CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET))) {
 		enum bus_mode speed_mode;
 
 		speed_mode = (int)dectoul(argv[1], NULL);
@@ -564,11 +564,13 @@ static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
 
 	switch (argc) {
 	case 4:
-		speed_mode = (int)dectoul(argv[3], &endp);
-		if (*endp) {
-			printf("Invalid speed mode index '%s', did you specify a mode name?\n",
-			       argv[3]);
-			return CMD_RET_USAGE;
+		if (CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET)) {
+			speed_mode = (int)dectoul(argv[3], &endp);
+			if (*endp) {
+				printf("Invalid speed mode index '%s', did you specify a mode name?\n",
+				       argv[3]);
+				return CMD_RET_USAGE;
+			}
 		}
 
 		fallthrough;
@@ -1312,12 +1314,17 @@ U_BOOT_CMD(
 #endif
 	"mmc erase blk# cnt\n"
 	"mmc erase partname\n"
+#if CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET)
 	"mmc rescan [mode]\n"
-	"mmc part - lists available partition on current mmc device\n"
 	"mmc dev [dev] [part] [mode] - show or set current mmc device [partition] and set mode\n"
 	"  - the required speed mode is passed as the index from the following list\n"
 	"    [MMC_LEGACY, MMC_HS, SD_HS, MMC_HS_52, MMC_DDR_52, UHS_SDR12, UHS_SDR25,\n"
 	"    UHS_SDR50, UHS_DDR50, UHS_SDR104, MMC_HS_200, MMC_HS_400, MMC_HS_400_ES]\n"
+#else
+	"mmc rescan\n"
+	"mmc dev [dev] [part] - show or set current mmc device [partition]\n"
+#endif
+	"mmc part - lists available partition on current mmc device\n"
 	"mmc list - lists available devices\n"
 	"mmc wp [PART] - power on write protect boot partitions\n"
 	"  arguments:\n"
-- 
2.43.0

