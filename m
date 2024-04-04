Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BD9CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9262E883BD;
	Thu,  4 Apr 2024 09:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CK+y6wDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BF0883BD; Thu,  4 Apr 2024 09:51:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80D4883CB
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 93B63612EC;
 Thu,  4 Apr 2024 07:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E8C433F1;
 Thu,  4 Apr 2024 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217079;
 bh=Ut88D2CET+27XgAjt4pVLwNvdmC507QDxImrQdKYb3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CK+y6wDFYAk//JaIbw/X+Du2OVHJowsCWt5M2wSoysADEwcQ/HrIim7TJLpzLPtO6
 ERu/fTQCna7uQc8pIGdSSAQyZiTkQTR4iFMMdWlI/tJlaGo1fV0AcpKYpcAmMbeB1W
 LtJhxb+KEQ9wBOXRQLcvz1ABm51w3Ar2PYNUE1CnWzEpO/JpdcYLKFId1D9J51/zkk
 SeBM4VdN1P8mPR6XCWB63ilitMSh0BlKXYevlOtmxAC/Pd88bWGTQTfGIPFdoETuWX
 TPxfLK8Z3YrzGBYWZwnQ9y/hvmdZvNRN8jPZKtba2dRDJZ2TORNlpPTpOyABeL6ZZM
 fTobYK7KDsT0Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 06/18] arm: mvebu: turris_omnia: Print board
 ECDSA public key if available
Date: Thu,  4 Apr 2024 09:50:55 +0200
Message-ID: <20240404075107.19636-7-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
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
Reviewed-by: Stefan Roese <sr@denx.de>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index f63640ad64..b2f0088e5e 100644
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
+	pub_key[66] = '\0';
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

