Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9485EE77371
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB2387037;
	Sat, 30 Sep 2023 14:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Sfg1Itar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398BA86FC4; Sat, 30 Sep 2023 14:02:25 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0F087037
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DA9C0440A9; 
 Sat, 30 Sep 2023 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075339;
 bh=OFQmueqMEEPSBCWtv2OAuyRnbpeut7Xq7GXo6q42mWo=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Sfg1ItarUn4pNDrjAgHdggji30JGNaD9nzuR8BMDfXV1yyH4dwXqYQ/gP06l9YAGM
 l+G2QobEkKJOr1/OQrwrfW3nvNXRGgdQngEx5skg8cmxFsM7rVcp5tiXow6dagqzLa
 pYWsoH56NxpHRZhtSNt4gNU4jP9MJXQ68rdbAPn0UN/FoxaD0otyhhDWDRvpM84Ggq
 LRTazPveYe2GKgvatjw9ETPtPFIrrA79jxzCDe1xV59hLBcIP3Ziwmz2TWqep0wuP+
 clNKYIIsQtcqI1smkX2ZhltppmZzNLZFrOjFFNYKFgJhRCPVO4ES8hLFoAOep+9J0Q
 lryLtY+XwjxMQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/6] eeprom: starfive: re-implement mac command
Date: Sat, 30 Sep 2023 14:01:45 +0200
Message-Id: <20230930120147.59482-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
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

The different implementations of the mac command have board or vendor
specific sub-commands.

Add the command definition specific to the VisionFive 2 board.

Don't call cmd_usage() directly but return CMD_RET_USAGE instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../visionfive2/visionfive2-i2c-eeprom.c      | 62 +++++++++++--------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index befe7888c4..8d99249279 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -404,29 +404,6 @@ static void set_product_id(char *string)
 	update_crc();
 }
 
-static int print_usage(void)
-{
-	printf("display and program the system ID and MAC addresses in EEPROM\n"
-	"[read_eeprom|initialize|write_eeprom|mac_address|pcb_revision|bom_revision|product_id]\n"
-	"mac read_eeprom\n"
-	"    - read EEPROM content into memory data structure\n"
-	"mac write_eeprom\n"
-	"    - save memory data structure to the EEPROM\n"
-	"mac initialize\n"
-	"    - initialize the in-memory EEPROM copy with default data\n"
-	"mac mac0_address <xx:xx:xx:xx:xx:xx>\n"
-	"    - stores a MAC0 address into the local EEPROM copy\n"
-	"mac mac1_address <xx:xx:xx:xx:xx:xx>\n"
-	"    - stores a MAC1 address into the local EEPROM copy\n"
-	"mac pcb_revision <?>\n"
-	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
-	"mac bom_revision <A>\n"
-	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
-	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
-	"    - stores a StarFive product ID into the local EEPROM copy\n");
-	return 0;
-}
-
 int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *cmd;
@@ -437,7 +414,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (argc > 3)
-		return print_usage();
+		return CMD_RET_USAGE;
 
 	cmd = argv[1];
 
@@ -453,7 +430,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (argc != 3)
-		return print_usage();
+		return CMD_RET_USAGE;
 
 	if (is_match_magic()) {
 		printf("Please read the EEPROM ('read_eeprom') and/or initialize the EEPROM ('initialize') first.\n");
@@ -477,7 +454,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 0;
 	}
 
-	return print_usage();
+	return CMD_RET_USAGE;
 }
 
 /**
@@ -559,3 +536,36 @@ u32 get_ddr_size_from_eeprom(void)
 
 	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
 }
+
+#ifndef CONFIG_SPL_BUILD
+
+#ifdef CONFIG_SYS_LONGHELP
+static char booti_help_text[] =
+	"\n"
+	"    - display EEPROM content\n"
+	"mac read_eeprom\n"
+	"    - read EEPROM content into memory data structure\n"
+	"mac write_eeprom\n"
+	"    - save memory data structure to the EEPROM\n"
+	"mac initialize\n"
+	"    - initialize the in-memory EEPROM copy with default data\n"
+	"mac mac0_address <xx:xx:xx:xx:xx:xx>\n"
+	"    - stores a MAC0 address into the local EEPROM copy\n"
+	"mac mac1_address <xx:xx:xx:xx:xx:xx>\n"
+	"    - stores a MAC1 address into the local EEPROM copy\n"
+	"mac pcb_revision <?>\n"
+	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
+	"mac bom_revision <A>\n"
+	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
+	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
+	"    - stores a StarFive product ID into the local EEPROM copy\n";
+#else
+	"";
+#endif
+
+U_BOOT_CMD(
+	mac, 3, 1,  do_mac,
+	"display and program the board revision and MAC address in EEPROM",
+	booti_help_text);
+
+#endif /* CONFIG_SPL_BUILD */
-- 
2.40.1

