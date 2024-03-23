Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12E2C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CCF87ECC;
	Sat, 23 Mar 2024 19:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QWsX1XGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA3387DAF; Sat, 23 Mar 2024 19:07:30 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C37987E2E
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4E23BCE094C;
 Sat, 23 Mar 2024 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED9EC43394;
 Sat, 23 Mar 2024 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217241;
 bh=7LmwvSNMvGxsWZgQQArdD99K2G0scbY9t+seMwumSS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QWsX1XGO+fqhdwgAY/4BIolMEdGbQ1Mzj0UMUqRxxsligPs9QANHZNafdiQOzayn7
 l8uZs1RdM8q5d+PweWDQTTd692/BbEwYlswjNs8BrJe5RM1/C5LfwqpF4yuFucPoC8
 vlP4bxUk+Vci2zviaAOgp3tHgem36rBL+sMzUIu/Gk8WWHG5hoKsxtwrmdLusbF+2G
 Fq+Der1fU0p+I3FEaPkqWXqQ+/EuH3cyGNpRkh+VPKtb2BY1Bvy/Xx0hi97vvtQakJ
 xnS4hDCaNrI/S8B/i+vHkaqZOavCdBOrG4TPpksR62yBmm52gP3d0Ifk9M75vGfzYR
 YzyPCg4oFdbZw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 04/18] arm: mvebu: turris_omnia: Update MCU
 status and features reading
Date: Sat, 23 Mar 2024 19:06:57 +0100
Message-ID: <20240323180711.5498-5-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Refactor MCU status word and MCU firmware features reading to make it
simpler to use.

Try reading 32 bits of features, if that fails, read 16 bits. Older MCU
firmware supports only 16-bit wide features, and if more bytes are read,
either 0xff is sent or I2C transaction fails. Handle both cases.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 100 +++++++++++++++--------
 1 file changed, 68 insertions(+), 32 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 87e33d88c4..6dfde5ee7a 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -133,6 +133,59 @@ static int omnia_mcu_write(u8 cmd, const void *buf, int len)
 	return dm_i2c_write(chip, cmd, buf, len);
 }
 
+static int omnia_mcu_get_sts_and_features(u16 *psts, u32 *pfeatures)
+{
+	u16 sts, feat16;
+	int ret;
+
+	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &sts, sizeof(sts));
+	if (ret)
+		return ret;
+
+	if (psts)
+		*psts = sts;
+
+	if (!pfeatures)
+		return 0;
+
+	if (sts & STS_FEATURES_SUPPORTED) {
+		/* try read 32-bit features */
+		ret = omnia_mcu_read(CMD_GET_FEATURES, pfeatures,
+				     sizeof(*pfeatures));
+		if (ret) {
+			/* try read 16-bit features */
+			ret = omnia_mcu_read(CMD_GET_FEATURES, &feat16,
+					     sizeof(&feat16));
+			if (ret)
+				return ret;
+
+			*pfeatures = feat16;
+		} else {
+			if (*pfeatures & FEAT_FROM_BIT_16_INVALID)
+				*pfeatures &= GENMASK(15, 0);
+		}
+	} else {
+		*pfeatures = 0;
+	}
+
+	return 0;
+}
+
+static int omnia_mcu_get_sts(u16 *sts)
+{
+	return omnia_mcu_get_sts_and_features(sts, NULL);
+}
+
+static bool omnia_mcu_has_feature(u32 feature)
+{
+	u32 features;
+
+	if (omnia_mcu_get_sts_and_features(NULL, &features))
+		return false;
+
+	return feature & features;
+}
+
 static void enable_a385_watchdog(unsigned int timeout_minutes)
 {
 	struct sar_freq_modes sar_freq;
@@ -194,7 +247,7 @@ static bool disable_mcu_watchdog(void)
 static bool omnia_detect_sata(const char *msata_slot)
 {
 	int ret;
-	u16 stsword;
+	u16 sts;
 
 	puts("MiniPCIe/mSATA card detection... ");
 
@@ -210,24 +263,24 @@ static bool omnia_detect_sata(const char *msata_slot)
 		}
 	}
 
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
+	ret = omnia_mcu_get_sts(&sts);
 	if (ret) {
 		printf("omnia_mcu_read failed: %i, defaulting to MiniPCIe card\n",
 		       ret);
 		return false;
 	}
 
-	if (!(stsword & STS_CARD_DET)) {
+	if (!(sts & STS_CARD_DET)) {
 		puts("none\n");
 		return false;
 	}
 
-	if (stsword & STS_MSATA_IND)
+	if (sts & STS_MSATA_IND)
 		puts("mSATA\n");
 	else
 		puts("MiniPCIe\n");
 
-	return stsword & STS_MSATA_IND;
+	return sts & STS_MSATA_IND;
 }
 
 static bool omnia_detect_wwan_usb3(const char *wwan_slot)
@@ -355,14 +408,14 @@ static int omnia_get_ram_size_gb(void)
 static const char * const omnia_get_mcu_type(void)
 {
 	static char result[] = "xxxxxxx (with peripheral resets)";
-	u16 stsword, features;
+	u16 sts;
 	int ret;
 
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
+	ret = omnia_mcu_get_sts(&sts);
 	if (ret)
 		return "unknown";
 
-	switch (stsword & STS_MCU_TYPE_MASK) {
+	switch (sts & STS_MCU_TYPE_MASK) {
 	case STS_MCU_TYPE_STM32:
 		strcpy(result, "STM32");
 		break;
@@ -377,11 +430,8 @@ static const char * const omnia_get_mcu_type(void)
 		break;
 	}
 
-	if (stsword & STS_FEATURES_SUPPORTED) {
-		ret = omnia_mcu_read(CMD_GET_FEATURES, &features, sizeof(features));
-		if (ret == 0 && (features & FEAT_PERIPH_MCU))
-			strcat(result, " (with peripheral resets)");
-	}
+	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU))
+		strcat(result, " (with peripheral resets)");
 
 	return result;
 }
@@ -660,9 +710,6 @@ int board_early_init_f(void)
 
 void spl_board_init(void)
 {
-	u16 val;
-	int ret;
-
 	/*
 	 * If booting from UART, disable MCU watchdog in SPL, since uploading
 	 * U-Boot proper can take too much time and trigger it. Instead enable
@@ -679,12 +726,8 @@ void spl_board_init(void)
 	 * resets then LAN eth switch is initialized automatically by bootstrap
 	 * pins when A385 is released from the reset.
 	 */
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &val, sizeof(val));
-	if (ret == 0 && (val & STS_FEATURES_SUPPORTED)) {
-		ret = omnia_mcu_read(CMD_GET_FEATURES, &val, sizeof(val));
-		if (ret == 0 && (val & FEAT_PERIPH_MCU))
-			initialize_switch();
-	}
+	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU))
+		initialize_switch();
 }
 
 #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP) || IS_ENABLED(CONFIG_OF_BOARD_SETUP)
@@ -884,16 +927,9 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
 #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
 int board_fix_fdt(void *blob)
 {
-	u16 val;
-	int ret;
-
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &val, sizeof(val));
-	if (ret == 0 && (val & STS_FEATURES_SUPPORTED)) {
-		ret = omnia_mcu_read(CMD_GET_FEATURES, &val, sizeof(val));
-		if (ret == 0 && (val & FEAT_PERIPH_MCU)) {
-			fixup_mcu_gpio_in_pcie_nodes(blob);
-			fixup_mcu_gpio_in_eth_wan_node(blob);
-		}
+	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU)) {
+		fixup_mcu_gpio_in_pcie_nodes(blob);
+		fixup_mcu_gpio_in_eth_wan_node(blob);
 	}
 
 	fixup_msata_port_nodes(blob);
-- 
2.43.2

