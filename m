Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537A6C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604468338D;
	Fri, 23 May 2025 19:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43534833C7; Fri, 23 May 2025 19:45:55 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46DE83278
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4N-0076pt-CU;
 Fri, 23 May 2025 17:20:31 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 11/13] board: venice: update model representation for
 venice-flex
Date: Fri, 23 May 2025 10:20:16 -0700
Message-Id: <20250523172018.4164647-11-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
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

Update the model string representation for the Venice-Flex product
family (GW8xxx).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/eeprom.c | 104 +++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 49b1ad34b148..702ab392a047 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -6,6 +6,7 @@
 #include <gsc.h>
 #include <hexdump.h>
 #include <i2c.h>
+#include <dm/device.h>
 #include <dm/uclass.h>
 
 #include "eeprom.h"
@@ -19,7 +20,7 @@
 
 struct venice_board_info som_info;
 struct venice_board_info base_info;
-char venice_model[32];
+char venice_model[64];
 char venice_som_model[32];
 char venice_baseboard_model[32];
 u32 venice_serial;
@@ -109,7 +110,7 @@ static int eeprom_read(int busno, int slave, int alen, struct venice_board_info
 	/* validate checksum */
 	for (chksum = 0, i = 0; i < (int)sizeof(*info) - 2; i++)
 		chksum += buf[i];
-	if ((info->chksum[0] != chksum >> 8) ||
+	if ((info->chksum[0] != ((chksum >> 8) & 0xff)) ||
 	    (info->chksum[1] != (chksum & 0xff))) {
 		printf("EEPROM: I2C%d@0x%02x: Invalid Checksum\n", busno, slave);
 		print_hex_dump_bytes("", DUMP_PREFIX_NONE, buf, sizeof(*info));
@@ -128,6 +129,54 @@ static int eeprom_read(int busno, int slave, int alen, struct venice_board_info
 	return 0;
 }
 
+static int fsa_eeprom_read(const char *base, int fsa, struct fsa_board_info *info)
+{
+	int i;
+	int chksum;
+	unsigned char *buf = (unsigned char *)info;
+	struct udevice *dev, *bus;
+	int ret;
+	u8 reg;
+
+	/* probe mux */
+	ret = uclass_get_device_by_seq(UCLASS_I2C, 2, &bus);
+	if (!ret)
+		ret = dm_i2c_probe(bus, 0x70, 0, &dev);
+	if (ret)
+		return ret;
+	/* steer mux */
+	if (!strncmp(base, "GW82", 4)) {
+		if (fsa < 3)
+			reg = (fsa == 1) ? BIT(1) : BIT(0);
+		else
+			return -EINVAL;
+	}
+	dm_i2c_write(dev, 0x00, &reg, 1);
+
+	/* get eeprom */
+	ret = dm_i2c_probe(bus, 0x54, 0, &dev);
+	if (ret)
+		return ret;
+
+	/* read eeprom config section */
+	ret = dm_i2c_read(dev, 0x00, buf, sizeof(*info));
+	if (ret)
+		return ret;
+
+	/* validate checksum */
+	for (chksum = 0, i = 0; i < (int)sizeof(*info) - 2; i++)
+		chksum += buf[i];
+	if ((info->chksum[0] != ((chksum >> 8) & 0xff)) ||
+	    (info->chksum[1] != (chksum & 0xff))) {
+		printf("FSA%d EEPROM (board): %s: Invalid Checksum\n", fsa, dev->name);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, sizeof(*info));
+		memset(info, 0, sizeof(*info));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* determine BOM revision from model */
 int get_bom_rev(const char *str)
 {
@@ -352,6 +401,57 @@ int venice_eeprom_init(int quiet)
 	}
 	venice_serial = som_info.serial;
 
+	/* GW8xxx product family naming scheme */
+	if (venice_model[2] == '8') {
+		struct fsa_board_info fsa_info;
+		int i = 0;
+		int fsa;
+
+		/* baseboard */
+		if (base_info.model[0]) {
+			rev_pcb = get_pcb_rev(base_info.model);
+			rev_bom = get_bom_rev(base_info.model);
+			venice_model[i++] = 'G';
+			venice_model[i++] = 'W';
+			venice_model[i++] = base_info.model[2]; /* baseboard */
+			venice_model[i++] = base_info.model[3];
+			venice_model[i++] = base_info.model[4]; /* subload */
+			venice_model[i++] = base_info.model[5];
+			venice_model[i++] = rev_pcb;
+			if (rev_bom)
+				venice_model[i++] = rev_bom;
+			venice_model[i++] = '-';
+			venice_model[i++] = 'S';
+		} else {
+			venice_model[i++] = 'G';
+			venice_model[i++] = 'W';
+		}
+
+		/* som */
+		rev_pcb = get_pcb_rev(som_info.model);
+		rev_bom = get_bom_rev(som_info.model);
+		venice_model[i++] = som_info.model[4];
+		venice_model[i++] = som_info.model[5];
+		venice_model[i++] = rev_pcb;
+		if (rev_bom)
+			venice_model[i++] = rev_bom;
+
+		/* fsa */
+		for (fsa = 1; fsa < FSA_MAX; fsa++) {
+			if (!fsa_eeprom_read(venice_model, fsa, &fsa_info)) {
+				venice_model[i++] = '-';
+				venice_model[i++] = 'F';
+				venice_model[i++] = '0' + fsa;
+				venice_model[i++] = fsa_info.model[5];
+				venice_model[i++] = fsa_info.model[6];
+				venice_model[i++] = fsa_info.model[8];
+				if (fsa_info.model[9])
+					venice_model[i++] = fsa_info.model[9];
+			}
+		}
+		venice_model[i++] = 0;
+	}
+
 	if (!quiet)
 		eeprom_info(false);
 
-- 
2.25.1

