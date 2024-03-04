Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE10C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBEB87FCA;
	Mon,  4 Mar 2024 16:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RPWZ0O4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B0B87FBC; Mon,  4 Mar 2024 16:22:02 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A621987FA0
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1D55ACE0A4B;
 Mon,  4 Mar 2024 15:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB0FC43394;
 Mon,  4 Mar 2024 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709565716;
 bh=pWl3NgzdvtsK4yb/IG1KOSokOh2MM7vZYOcwXIDYOsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RPWZ0O4oWEclh0+p2i0MMG4Nk9LIBm39krAtgBUBGoBiw3mc7iHxP9es/RZron+tW
 gBGSaTTV6+MnAXy7YLeO7eTgll6I9guw7n1hO7dE0dy/WZeV91JsX9zQWefLJ5FZu3
 eHbagQ5O+HGYyMlWK3pfz2K/Bg4ZENdPQS4zN4h2qGj+AGssz4Mh6P8Ana6H/otK9z
 DKfTEoHhrPPRV8f0EbrWGHVb6z1dp5CRE8sr/HznuCZPvf8HrlErHOzYgOvmCeTWxY
 Nx79kKx2R/T8QtgR2oyGqFJR2cUfGbjQyCv2iwqu5rewfVvTNyWpkqDKHbjlNUx2PQ
 hIWwpv2WOm47w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 3/4] arm: mvebu: turris_omnia: Print board ECDSA
 public key if available
Date: Mon,  4 Mar 2024 16:21:47 +0100
Message-ID: <20240304152148.3847-4-kabel@kernel.org>
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

If MCU supports the FEAT_CRYPTO feature, read board ECDSA public key
from MCU and print it.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 7a51ed3ace5..46f576a460e 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -75,6 +75,9 @@ enum mcu_commands {
 	/* available if EXT_CMD bit set in features */
 	CMD_EXT_CONTROL		= 0x12,
 
+	/* available if CRYPTO bit set in features */
+	CMD_CRYPTO_GET_PUBLIC_KEY	= 0x29,
+
 	/* available if BOARD_INFO it set in features */
 	CMD_BOARD_INFO_GET	= 0x2c,
 };
@@ -94,6 +97,7 @@ enum status_word_bits {
 enum features_e {
 	FEAT_PERIPH_MCU		= BIT(0),
 	FEAT_EXT_CMDS		= BIT(1),
+	FEAT_CRYPTO		= BIT(14),
 	FEAT_BOARD_INFO		= BIT(15),
 };
 
@@ -285,6 +289,24 @@ static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
 	return 0;
 }
 
+static int omnia_mcu_get_board_public_key(char pub_key[static 67])
+{
+	u8 reply[34];
+	int ret;
+
+	ret = omnia_mcu_read(CMD_CRYPTO_GET_PUBLIC_KEY, reply, sizeof(reply));
+	if (ret)
+		return ret;
+
+	if (reply[0] != 33)
+		return -EBADMSG;
+
+	bin2hex(pub_key, &reply[1], 33);
+	reply[66] = '\0';
+
+	return 0;
+}
+
 static void enable_a385_watchdog(unsigned int timeout_minutes)
 {
 	struct sar_freq_modes sar_freq;
@@ -1060,7 +1082,7 @@ int board_late_init(void)
 
 int checkboard(void)
 {
-	char serial[17], version[4];
+	char serial[17], version[4], pub_key[67];
 	bool has_version;
 	int err;
 
@@ -1080,6 +1102,11 @@ int checkboard(void)
 	printf("  Board version: %s\n", has_version ? version : "unknown");
 	printf("  Serial Number: %s\n", !err ? serial : "unknown");
 
+	if (omnia_mcu_has_feature(FEAT_CRYPTO)) {
+		err = omnia_mcu_get_board_public_key(pub_key);
+		printf("  ECDSA Public Key: %s\n", !err ? pub_key : "unknown");
+	}
+
 	return 0;
 }
 
-- 
2.43.0

