Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85775C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 12:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD746876A2;
	Mon, 25 Dec 2023 13:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="pxMgqKEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9140F86FF4; Mon, 25 Dec 2023 11:22:57 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6BB86FF4
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 11:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6D7C810000A;
 Mon, 25 Dec 2023 13:22:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D7C810000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703499774;
 bh=sGG1gON410HjJps6pm1gTs4OdbKRhQjnpdxtwgLu0co=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pxMgqKEKDU7Pm2E52N4rfJXXnnjVJ9tONYhWPZ280il8NnNEnBqQzFuP26HmYL1OB
 VChbU2ygd/HsU8CnxoUNXhP/fVLlRFib5tumQoVZUv8j0KhDmC2/vMWjGcaDr7XAR6
 1BNS+nEHzOtuAIAF0TNchaSyTm+Y+CulTGP2PkrCtyZTZJivCCk2pbl1keglaiiqZq
 uCEpspD0e2M90ccA+uotrPj9pbnjW+/jV/3F6UWkVZXIsHRTj2AzUqlOoZP99rqJng
 4P4ZiWohyoJb7jbNqsjj7M9g5FGrHGD/R9Mz62dtHpbM5jpCnELE1ydqiCPZz+P6Oj
 fqdKVUUO0NgdQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 25 Dec 2023 13:22:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 13:22:54 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <jpewhacker@gmail.com>, <sjg@google.com>, <semen.protsenko@linaro.org>,
 <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2] android_ab: don't ignore ab_control_store return code
Date: Mon, 25 Dec 2023 13:22:45 +0300
Message-ID: <20231225102247.76794-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182334 [Dec 25 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/25 08:59:00 #22803377
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 25 Dec 2023 13:30:11 +0100
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

ab_control_store() can return an error if writing to disk fails.
In this case, we have to pass the error code to the caller.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/android_ab.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 73b55c196c..af3c375e07 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -337,7 +337,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 
 	if (store_needed) {
 		abc->crc32_le = ab_control_compute_crc(abc);
-		ab_control_store(dev_desc, part_info, abc, 0);
+		ret = ab_control_store(dev_desc, part_info, abc, 0);
+		if (ret < 0) {
+#if ANDROID_AB_BACKUP_OFFSET
+			free(backup_abc);
+#endif
+			free(abc);
+			return ret;
+		}
 	}
 
 #if ANDROID_AB_BACKUP_OFFSET
@@ -346,8 +353,13 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 	 * to the backup offset
 	 */
 	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
-		ab_control_store(dev_desc, part_info, abc,
+		ret = ab_control_store(dev_desc, part_info, abc,
 				 ANDROID_AB_BACKUP_OFFSET);
+		if (ret < 0) {
+			free(backup_abc);
+			free(abc);
+			return ret;
+		}
 	}
 	free(backup_abc);
 #endif
-- 
2.39.2

