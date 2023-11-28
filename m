Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DFC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 12:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0ED86F67;
	Tue, 28 Nov 2023 13:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="JyfUi7m9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C0186EE1; Tue, 28 Nov 2023 12:26:51 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AD586DAF
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C4E27100013;
 Tue, 28 Nov 2023 14:26:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C4E27100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701170808;
 bh=VBU1BwZyvB5jyGpFhxG10AO3T0fhMf4CmnHXmbeOHYM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=JyfUi7m9cO3czhScuoCT0Trc2GLCLNLlbm0pM/S7sK+4mZ9m+5kE6PWrjZtj3IXc7
 hkZs49EZ24N7tLNg7L13ls1PBlqR6dkOaCblS+n7ZZKdkir6xFhnoirkAoMQ1SN1/C
 Hry1OSEsu2X3nGxkYhV4Mounrsm8Th4sPnazdB1wex+VJusHXgIsjW9e0E7OrfyGuo
 gqzInD1YruvyIvDi7KVMbsRq5tUuh+7mA1oeiK5Ni26TY4kj2dB75JbvZ5QQMx0Usk
 eZ77v3aHLYP+dyE9aP6Qk9mKu0HoVTc7YeSw/fWiB87ywUGB1oKz2ZDlJJh05i+taZ
 SPapUQQI6Py3A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 28 Nov 2023 14:26:47 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 14:26:47 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <jpewhacker@gmail.com>, <sjg@google.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1] android_ab: don't ignore ab_control_store return code
Date: Tue, 28 Nov 2023 14:26:34 +0300
Message-ID: <20231128112636.26655-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181651 [Nov 28 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/28 07:45:00 #22560584
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 28 Nov 2023 13:52:25 +0100
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
---
 boot/android_ab.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 73b55c196c..5a3152dd53 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -337,7 +337,15 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 
 	if (store_needed) {
 		abc->crc32_le = ab_control_compute_crc(abc);
-		ab_control_store(dev_desc, part_info, abc, 0);
+		ret = ab_control_store(dev_desc, part_info, abc, 0);
+		if (ret < 0) {
+#if ANDROID_AB_BACKUP_OFFSET
+			free(backup_abc);
+#endif
+			free(abc);
+			log_err("ANDROID: failed to store boot control block: %d\n", ret);
+			return ret;
+		}
 	}
 
 #if ANDROID_AB_BACKUP_OFFSET
@@ -346,8 +354,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 	 * to the backup offset
 	 */
 	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
-		ab_control_store(dev_desc, part_info, abc,
+		ret = ab_control_store(dev_desc, part_info, abc,
 				 ANDROID_AB_BACKUP_OFFSET);
+		if (ret < 0) {
+			free(backup_abc);
+			free(abc);
+			log_err("ANDROID: failed to store boot control block: %d\n", ret);
+			return ret;
+		}
 	}
 	free(backup_abc);
 #endif
-- 
2.39.2

