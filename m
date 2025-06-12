Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D5CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3358082C30;
	Thu, 12 Jun 2025 16:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="gl3yQ+xU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27404828A2; Thu, 12 Jun 2025 16:04:21 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBC982BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=2YWiG2CW9CB05XENeyDqblGa+yOCeABU4bKADhFHuro=; b=gl3yQ+xU7EW43W9BKHtC84uYcm
 RRrZdId8dmoWX/mGfVG7YWCQDOJeHyWIcPzA5K+h3sd1Ebqs2ntfbtvykAIbPFY9GspgFiTydAcMD
 UMuIN1snKaoXS88FeUuDW8015wSSlaQvXCm7plfMBWF3cfjnWyKkL4MXh6YduUqDa51c=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48604
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1uPiXP-0007iT-Og; Thu, 12 Jun 2025 10:04:16 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Thu, 12 Jun 2025 10:04:10 -0400
Message-Id: <20250612140410.768650-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] cmd: tlv_eeprom: fix typo errors in comments and error msg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix typo errors in comments and error message by replacing EERPOM->EEPROM.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 cmd/tlv_eeprom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index d7c229e5441..89546cef16f 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -41,7 +41,7 @@ static int set_date(char *buf, const char *string);
 static int set_bytes(char *buf, const char *string, int *converted_accum);
 static void show_tlv_devices(int current_dev);
 
-/* The EERPOM contents after being read into memory */
+/* The EEPROM contents after being read into memory */
 static u8 eeprom[TLV_INFO_MAX_LEN];
 
 static struct udevice *tlv_devices[MAX_TLV_DEVICES];
@@ -430,7 +430,7 @@ int do_tlv_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	static int has_been_read;
 	int ret;
 
-	// If no arguments, read the EERPOM and display its contents
+	// If no arguments, read the EEPROM and display its contents
 	if (argc == 1) {
 		if (!has_been_read) {
 			ret = read_eeprom(current_dev, eeprom);
@@ -560,7 +560,7 @@ U_BOOT_CMD(tlv_eeprom, 4, 1,  do_tlv_eeprom,
 /**
  *  tlvinfo_find_tlv
  *
- *  This function finds the TLV with the supplied code in the EERPOM.
+ *  This function finds the TLV with the supplied code in the EEPROM.
  *  An offset from the beginning of the EEPROM is returned in the
  *  eeprom_index parameter if the TLV is found.
  */
@@ -631,7 +631,7 @@ static bool tlvinfo_add_tlv(u8 *eeprom, int tcode, char *strval)
 	char data[MAX_TLV_VALUE_LEN];
 	int eeprom_index;
 
-	// Encode each TLV type into the format to be stored in the EERPOM
+	// Encode each TLV type into the format to be stored in the EEPROM
 	switch (tcode) {
 	case TLV_CODE_PRODUCT_NAME:
 	case TLV_CODE_PART_NUMBER:
@@ -691,7 +691,7 @@ static bool tlvinfo_add_tlv(u8 *eeprom, int tcode, char *strval)
 	// Is there room for this TLV?
 	if ((be16_to_cpu(eeprom_hdr->totallen) + ENT_SIZE + new_tlv_len) >
 			TLV_TOTAL_LEN_MAX) {
-		printf("ERROR: There is not enough room in the EERPOM to save data.\n");
+		printf("ERROR: There is not enough room in the EEPROM to save data.\n");
 		return false;
 	}
 

base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
-- 
2.39.5

