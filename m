Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA31FC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA2787F6E;
	Mon,  4 Mar 2024 16:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kYVWOy8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A275387FB8; Mon,  4 Mar 2024 16:22:01 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E201B87FB1
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 524AD6103E;
 Mon,  4 Mar 2024 15:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2936DC43394;
 Mon,  4 Mar 2024 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709565713;
 bh=JZN3nPemvisURGNuQFWMiYsLfSLlwChqD0a3mSTDkVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kYVWOy8YAzsklB+NfGEvlbIgaLfF3nSHnMqCL6ij8mK5ouSSrmerpuOKutCxDGUH+
 Cc64UO7JqtWk2ayO6fc+rXGriZYgZBVMmF72z11Rduk4N+cGpuQQjiIbYJrHjCxCxJ
 bE3XcaBfIgIfcHij3m/x7Z/3PzZ31wrGiiDo33OPbfYeihhF30P3229ZOZC1vJl83x
 n6n7U30Yu8yH//pzhZE/wX382WBs7EWLjRHprFZPzDOGmWTsXBxo2cW3ho7r2sUCS3
 vHJ2C+kPQpRkxgevQTfkyFGQ68suwgumUHZnPlTNHKheJsJXFCwHrG7HaHpSRtui7X
 2i6w6lplaXqvQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 1/4] arm: mvebu: turris_omnia: Refactor MCU
 status and features reading
Date: Mon,  4 Mar 2024 16:21:45 +0100
Message-ID: <20240304152148.3847-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304152148.3847-1-kabel@kernel.org>
References: <20240304152148.3847-1-kabel@kernel.org>
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

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 81 ++++++++++++++++--------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index adeb69a205b..b285e959d06 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -172,6 +172,48 @@ static int omnia_mcu_write(u8 cmd, const void *buf, int len)
 	return dm_i2c_write(chip, cmd, buf, len);
 }
 
+static int omnia_mcu_get_sts_and_features(u16 *psts, u16 *pfeatures)
+{
+	u16 sts;
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
+		ret = omnia_mcu_read(CMD_GET_FEATURES, pfeatures,
+				     sizeof(*pfeatures));
+		if (ret)
+			return ret;
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
+static bool omnia_mcu_has_feature(u16 feature)
+{
+	u16 features;
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
@@ -249,7 +291,7 @@ static bool omnia_detect_sata(const char *msata_slot)
 		}
 	}
 
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
+	ret = omnia_mcu_get_sts(&stsword);
 	if (ret) {
 		printf("omnia_mcu_read failed: %i, defaulting to MiniPCIe card\n",
 		       ret);
@@ -405,20 +447,17 @@ static const char * const omnia_get_mcu_type(void)
 		[STS_MCU_TYPE_MKL]   = "MKL (with peripheral resets)",
 		[STS_MCU_TYPE_UNKN]  = "unknown (with peripheral resets)",
 	};
-	u16 stsword, features;
+	u16 sts;
 	int ret;
 
-	ret = omnia_mcu_read(CMD_GET_STATUS_WORD, &stsword, sizeof(stsword));
+	ret = omnia_mcu_get_sts(&sts);
 	if (ret)
 		return "unknown";
 
-	if (stsword & STS_FEATURES_SUPPORTED) {
-		ret = omnia_mcu_read(CMD_GET_FEATURES, &features, sizeof(features));
-		if (ret == 0 && (features & FEAT_PERIPH_MCU))
-			return mcu_types_with_perip_resets[stsword & STS_MCU_TYPE_MASK];
-	}
+	if (omnia_mcu_has_feature(FEAT_PERIPH_MCU))
+		return mcu_types_with_perip_resets[sts & STS_MCU_TYPE_MASK];
 
-	return mcu_types[stsword & STS_MCU_TYPE_MASK];
+	return mcu_types[sts & STS_MCU_TYPE_MASK];
 }
 
 static const char * const omnia_get_mcu_version(void)
@@ -695,9 +734,6 @@ int board_early_init_f(void)
 
 void spl_board_init(void)
 {
-	u16 val;
-	int ret;
-
 	/*
 	 * If booting from UART, disable MCU watchdog in SPL, since uploading
 	 * U-Boot proper can take too much time and trigger it. Instead enable
@@ -714,12 +750,8 @@ void spl_board_init(void)
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
@@ -919,16 +951,9 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
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
2.43.0

