Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67964C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E9487F70;
	Sat, 23 Mar 2024 19:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LqYZg3PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B67F87CDB; Sat, 23 Mar 2024 19:07:32 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9298487E83
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5061060202;
 Sat, 23 Mar 2024 18:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B1DC43394;
 Sat, 23 Mar 2024 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217244;
 bh=nJwvhIxk4QvFYUX8/lCULLVOOWZvvwX8sfKfLU1IMjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LqYZg3PJeJNbjHKRruLeOE0r/dbA/w1JKJkRysMGbaCk7Xpq091LCl7eeYWl2I3El
 JoSB2s5W1pTdiUiTyBOzlY91DxNiju7zdEF22rn/fOCcTsH1eYztm81P5JBiyausOh
 fpnn5eZ8vn06VF5b+32B7UHzbbTX/OyFPwC5WNEsiKSv0/kA5yiYi+2T/ossVDojDV
 JQN/DHFEvUFRWIihd0GD4dZ/WkllsfQByciYqNCXu5nV9ryq04Ksq9vSp/ozuapGzH
 LuSNfdSRhuAy6OQ3cq8XvarjOR+NFd09L7DOtepMR3+EMgsp0FwgfcA5ZXNdZCCLNB
 z5Wp8oOvN7BDQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 06/18] arm: mvebu: turris_omnia: Print board
 ECDSA public key if available
Date: Sat, 23 Mar 2024 19:06:59 +0100
Message-ID: <20240323180711.5498-7-kabel@kernel.org>
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

If MCU supports the FEAT_CRYPTO feature, read board ECDSA public key
from MCU and print it.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index f63640ad64..896c14bb99 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -253,6 +253,24 @@ static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
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
@@ -1032,7 +1050,7 @@ int board_late_init(void)
 
 int checkboard(void)
 {
-	char serial[17], version[4];
+	char serial[17], version[4], pub_key[67];
 	bool has_version;
 	int err;
 
@@ -1051,6 +1069,11 @@ int checkboard(void)
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
2.43.2

