Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7EDC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9915B88852;
	Fri, 10 May 2024 07:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tgXNA888";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4429988719; Fri, 10 May 2024 07:52:52 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B50088860
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0EB4F4081C; 
 Fri, 10 May 2024 05:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715320365;
 bh=dOqodkXXHqnbCwLm91MIqwfc+jXoRMMHu+smwsaCrac=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tgXNA888qzX/t68kSFlXAa2rVogprm4+lv2p/dLgDAOSuZ37/LWoaUBVz0RX2tYRR
 RfVGpErDYq6Y0OCHktrkgwTKQqWPCtsn77RQfPKELKGoBbHFUUFgtRORHRFI50qFrj
 w9QPIi/qYzXuNYOKRijBXpElLd9vs5xQSIB68vGnGkTMzMbNR58HQ1fkwsndDzyng2
 vNDA1wtvwZfnGqo3OCRaEyg0mapk5lcpKYDmHbCJqSmS9ElWyJGINcF8Ha597Wm7ZP
 rnU6VQjyvstwmBkUew6nhQrK/sYm7fSwiPKBuHJMRrg1rm0c/jQ2h2R2u1qWJZVPu0
 CUoItB/CfuAfg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 5/5] starfive: add mac vendor sub-command
Date: Fri, 10 May 2024 07:52:21 +0200
Message-ID: <20240510055223.11617-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
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

As boards from multiple vendors (Milk-V, StarFive, Pine64) use the mac
command provide a sub-command to set the vendor string.

Reported-by: E. Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	new patch
---
 .../visionfive2/visionfive2-i2c-eeprom.c      | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 9648a270494..141d3db8667 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -404,6 +404,24 @@ static void set_product_id(char *string)
 	update_crc();
 }
 
+/**
+ * set_vendor() - set vendor name
+ *
+ * Takes a pointer to a string representing the vendor name, e.g.
+ * "StarFive Technology Co., Ltd.", stores it in the vendor field
+ * of the EEPROM local copy, and updates the CRC of the local copy.
+ */
+static void set_vendor(char *string)
+{
+	memset(pbuf.eeprom.atom1.data.vstr, 0,
+	       sizeof(pbuf.eeprom.atom1.data.vstr));
+
+	snprintf(pbuf.eeprom.atom1.data.vstr,
+		 sizeof(pbuf.eeprom.atom1.data.vstr), string);
+
+	update_crc();
+}
+
 const char *get_product_id_from_eeprom(void)
 {
 	if (read_eeprom())
@@ -463,6 +481,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (!strcmp(cmd, "product_id")) {
 		set_product_id(argv[2]);
 		return 0;
+	} else if (!strcmp(cmd, "vendor")) {
+		set_vendor(argv[2]);
+		return 0;
 	}
 
 	return CMD_RET_USAGE;
@@ -586,7 +607,9 @@ U_BOOT_LONGHELP(mac,
 	"mac bom_revision <A>\n"
 	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
 	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
-	"    - stores a StarFive product ID into the local EEPROM copy\n");
+	"    - stores a StarFive product ID into the local EEPROM copy\n"
+	"mac vendor <Vendor Name>\n"
+	"    - set vendor string\n");
 
 U_BOOT_CMD(
 	mac, 3, 1,  do_mac,
-- 
2.43.0

