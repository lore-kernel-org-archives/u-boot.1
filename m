Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B5EE8006
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA11986B21;
	Fri,  8 Sep 2023 16:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PlR1A7oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7D386A2A; Fri,  8 Sep 2023 13:07:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7201786A24
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B7GYq094969;
 Fri, 8 Sep 2023 06:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171236;
 bh=/h37kmZRiR75a0ROEUDFzA0tEO5KqiDwqVw4UcDfzVI=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=PlR1A7oN3i/JiwaXVWfwwQpdC+u84+hxLVaIcLMQZNYjVc27q7IX2dcAXhIJMaYe7
 kAJOR+tVeX9B5QQPCaHiSKEheRfLOo6pyt4IAgNjloLxYvMbebDdlAmB9Tu7Abjw7M
 eSr4IJU6UGev3YXQc9C46e/5m8QZKyb8puJVjxAg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B7G3X045612
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:07:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:07:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:07:15 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEO018063;
 Fri, 8 Sep 2023 06:07:09 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 11/16] board: ti: j784s4: Add support for board detection
 by EEPROM read
Date: Fri, 8 Sep 2023 16:35:46 +0530
Message-ID: <20230908110551.861575-12-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

The board name is programmed in the EEPROM. Add support for board
detection and choose the right dtb based on the board name read
from EEPROM.

The J784S4/AM69 has two platforms naming J784S4-EVM and AM69-SK. The
J784S4 has EEPROM populated at 0x50. AM69 SK has EEPROM
populated at next address 0x51. So start looking for TI specific EEPROM
at 0x50, if not found look for EEPROM at 0x51.

Also, add support for setup_serial() to read the serial number from EEPROM
and update the serial environment variable with the same.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/evm.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index d6e695f183..f2a0216888 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -26,6 +26,8 @@
 
 #define board_is_j784s4_evm()	board_ti_k3_is("J784S4-EVM")
 
+#define board_is_am69_sk()      board_ti_k3_is("AM69-SK")
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -72,6 +74,100 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+#ifdef CONFIG_SPL_LOAD_FIT
+int board_fit_config_name_match(const char *name)
+{
+	bool eeprom_read = board_ti_was_eeprom_read();
+
+	if (!eeprom_read || board_is_j784s4_evm()) {
+		if ((!strcmp(name, "k3-j784s4-evm")) || (!strcmp(name, "k3-j784s4-r5-evm")))
+			return 0;
+	} else if (!eeprom_read || board_is_am69_sk()) {
+		if ((!strcmp(name, "k3-am69-sk")) || (!strcmp(name, "k3-am69-r5-sk")))
+			return 0;
+	}
+
+	return -1;
+}
+#endif
+
+#ifdef CONFIG_TI_I2C_BOARD_DETECT
+int do_board_detect(void)
+{
+	int ret;
+
+	if (board_ti_was_eeprom_read())
+		return 0;
+
+	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+					 CONFIG_EEPROM_CHIP_ADDRESS);
+	if (ret) {
+		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
+		       CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
+		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
+						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
+		if (ret)
+			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
+			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
+	}
+
+	return ret;
+}
+
+int checkboard(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+	if (do_board_detect())
+		/* EEPROM not populated */
+		printf("Board: %s rev %s\n", "J784S4-EVM", "E1");
+	else
+		printf("Board: %s rev %s\n", ep->name, ep->version);
+
+	return 0;
+}
+
+static void setup_board_eeprom_env(void)
+{
+	char *name = "j784s4";
+
+	if (do_board_detect())
+		goto invalid_eeprom;
+
+	if (board_is_j784s4_evm())
+		name = "j784s4";
+	else if (board_is_am69_sk())
+		name = "am69-sk";
+	else
+		printf("Unidentified board claims %s in eeprom header\n",
+		       board_ti_get_name());
+
+invalid_eeprom:
+	set_board_info_env_am6(name);
+}
+
+static void setup_serial(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+	unsigned long board_serial;
+	char *endp;
+	char serial_string[17] = { 0 };
+
+	if (env_get("serial#"))
+		return;
+
+	board_serial = simple_strtoul(ep->serial, &endp, 16);
+	if (*endp != '\0') {
+		pr_err("Error: Can't set serial# to %s\n", ep->serial);
+		return;
+	}
+
+	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
+	env_set("serial#", serial_string);
+}
+
+#endif
+
 int board_late_init(void)
 {
 	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
-- 
2.34.1

