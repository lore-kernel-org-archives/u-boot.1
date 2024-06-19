Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E6CC2BBCA
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA9988485;
	Wed, 19 Jun 2024 23:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145DB87D83; Wed, 19 Jun 2024 23:13:05 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00E388363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK2c0-00EJGk-Pu;
 Wed, 19 Jun 2024 21:13:00 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: enable GSC supervisor for new board
 models
Date: Wed, 19 Jun 2024 14:12:58 -0700
Message-Id: <20240619211258.2068188-1-tharvey@gateworks.com>
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

The Gateworks System Controller (GSC) has a voltage supervisor which is
disabled by default. On older boards we want to maintian this but on
newer boards we wish to enable the voltage supervisor.

The Gateworks System Controller (GSC) can disable the board primary
power supply by driving a pin to a FET high. On older board models
the leakage of the GSC may exceed the leakage of the FET causing this
signal slowly rise when the GSC battery is low and the board is in a
powered down state resulting in the board being kept in a disabled
state.

Newer boards have a hardware fix to avoid this leakage and thus should
enable the voltage supervisor.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/spl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index b0a315ba9531..9a22eeef36ba 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -119,13 +119,29 @@ static int dm_i2c_clrsetbits(struct udevice *dev, uint reg, uint clr, uint set)
 	return dm_i2c_write(dev, reg, &val, 1);
 }
 
-static int power_init_board(void)
+static int power_init_board(struct udevice *gsc)
 {
 	const char *model = eeprom_get_model();
 	struct udevice *bus;
 	struct udevice *dev;
 	int ret;
 
+	/* Enable GSC voltage supervisor for new board models */
+	if ((!strncmp(model, "GW7100", 6) && model[10] > 'D') ||
+	    (!strncmp(model, "GW7101", 6) && model[10] > 'D') ||
+	    (!strncmp(model, "GW7200", 6) && model[10] > 'E') ||
+	    (!strncmp(model, "GW7201", 6) && model[10] > 'E') ||
+	    (!strncmp(model, "GW7300", 6) && model[10] > 'E') ||
+	    (!strncmp(model, "GW7301", 6) && model[10] > 'E') ||
+	    (!strncmp(model, "GW740", 5) && model[7] > 'B')) {
+		u8 ver;
+
+		if (!dm_i2c_read(gsc, 14, &ver, 1) && ver > 62) {
+			printf("GSC     : enabling voltage supervisor\n");
+			dm_i2c_clrsetbits(gsc, 25, 0, BIT(1));
+		}
+	}
+
 	if ((!strncmp(model, "GW71", 4)) ||
 	    (!strncmp(model, "GW72", 4)) ||
 	    (!strncmp(model, "GW73", 4)) ||
@@ -298,7 +314,7 @@ void board_init_f(ulong dummy)
 	dram_sz = venice_eeprom_init(0);
 
 	/* PMIC */
-	power_init_board();
+	power_init_board(dev);
 
 	/* DDR initialization */
 	spl_dram_init(dram_sz);
-- 
2.25.1

