Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E623C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FCA87F1A;
	Sun,  3 Mar 2024 14:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uNfMJB9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AA487F13; Sun,  3 Mar 2024 14:01:31 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F5B87F06
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DEE3A41011; 
 Sun,  3 Mar 2024 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470888;
 bh=ATUKWIx4r2hvaYu92HyoC8QNET8a0xPoOGRWvZFSWMY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=uNfMJB9JDhZwDqO+fYIv1Ni+Avp64NLO720aARTRpsrwM29i6HN5F+0f7O4YX87If
 pn0wmFE2OlCBDFzOo6/sfMnAA61bCytLdpiQoU/gSzqZ+u5pX/xa6Nfl7V+rpaPHXd
 xCTm/Nxu3aEKn+xFQMAsUyGroxM8tUDzZKjEMzdRW+U5x59LYXXTwnVALyZJiu3aN3
 A55VzNNlUKGtUCBlKkrRMFer++ckHu2dOYqVdIaWgNLM4SAHu6N9T7hzMYg0OMC27v
 uwxnAAKzV0PAJQo9wWwLUsFfMZbWyudTa+Sh1KYtOQqpaSNqjaC5desOw8TuRQNu0L
 HTsDb1WfLtOng==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 3/5] board: starfive: support Milk-V Mars board
Date: Sun,  3 Mar 2024 14:01:20 +0100
Message-ID: <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
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

The differences between the Milk-V Mars board and the VisionFive 2 board
are small enough that we can support both using the same U-Boot build.

* The model and compatible property are taken from proposed Linux patches.
* The EEPROM is atmel,24c02 according to the vendor U-Boot.
* The second Ethernet port is not available.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c | 101 +++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 1b49945d11b..c62624a2eb5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -27,6 +27,26 @@ struct starfive_vf2_pro {
 	const char *value;
 };
 
+static const struct starfive_vf2_pro milk_v_mars[] = {
+	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
+	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
+
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-adj-enabled", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-100-inverted", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-1000-inverted", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-clk-drv-microamp", "3970"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-data-drv-microamp", "2910"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"rx-internal-delay-ps", "1900"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"tx-internal-delay-ps", "1500"},
+};
+
 static const struct starfive_vf2_pro starfive_vera[] = {
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "rx-internal-delay-ps",
 		"1900"},
@@ -67,6 +87,51 @@ static const struct starfive_vf2_pro starfive_verb[] = {
 		"tx-internal-delay-ps", "0"},
 };
 
+void spl_fdt_fixup_mars(void *fdt)
+{
+	static const char compat[] = "milkv,mars\0starfive,jh7110";
+	u32 phandle;
+	u8 i;
+	int offset;
+	int ret;
+
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
+			   "Milk-V Mars");
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/i2c@12050000/eeprom@50"),
+			   "compatible", "atmel,24c02");
+
+	/* gmac0 */
+	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
+	phandle = fdt_get_phandle(fdt, offset);
+	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
+
+	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
+	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
+	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
+	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
+			   JH7110_AONCLK_GMAC0_RMII_RTX);
+
+	/* gmac1 */
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
+			   "status", "disabled");
+
+	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
+		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
+
+		if (starfive_verb[i].value)
+			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
+					      dectoul(milk_v_mars[i].value, NULL));
+		else
+			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
+
+		if (ret) {
+			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
+				break;
+		}
+	}
+}
+
 void spl_fdt_fixup_version_a(void *fdt)
 {
 	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
@@ -167,22 +232,34 @@ void spl_fdt_fixup_version_b(void *fdt)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	u8 version;
+	const char *product_id;
 
-	version = get_pcb_revision_from_eeprom();
-	switch (version) {
-	case 'a':
-	case 'A':
-		spl_fdt_fixup_version_a(spl_image->fdt_addr);
-		break;
-
-	case 'b':
-	case 'B':
-	default:
-		spl_fdt_fixup_version_b(spl_image->fdt_addr);
+	product_id = get_product_id_from_eeprom();
+	if (!product_id) {
+		pr_err("Can't read EEPROM\n");
+		return;
+	}
+	if (!strncmp(product_id, "MARS", 4)) {
+		spl_fdt_fixup_mars(spl_image->fdt_addr);
+	} else if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		switch (version) {
+		case 'a':
+		case 'A':
+			spl_fdt_fixup_version_a(spl_image->fdt_addr);
+			break;
+
+		case 'b':
+		case 'B':
+		default:
+			spl_fdt_fixup_version_b(spl_image->fdt_addr);
 		break;
+		};
+	} else {
+		pr_err("Unknown product %s\n", product_id);
 	};
 
-	/* Update the memory size which read form eeprom or DT */
+	/* Update the memory size which read from eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
 
-- 
2.43.0

