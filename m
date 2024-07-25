Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA93C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD52885BF;
	Thu, 25 Jul 2024 22:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="tp9L1VlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED848692C; Thu, 25 Jul 2024 21:47:30 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A69988360
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 21:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id EB06212001A;
 Thu, 25 Jul 2024 22:47:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EB06212001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721936846;
 bh=ivyr9F72MuO1A+TFxaElxl2tjs8hO+yvVQF0dqQiwTA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=tp9L1VlWwcUDECulD9QTc+qiXqoqD3u852faKru6jAj0VTUe8JfCPXtY8KM6YFgqQ
 KLq5G7z7ydunRFcQSr8bSWsrieJP16MFISdg+pvSDaGN53LHjXoDILkHWzA9zHZejd
 X2Mnr3W5xyG95xY3mOLoDSNrQLxFp6txCFrn1E1ZEcDtAQFXnjXbydZVBaL3vHNFlk
 068h1cEzzo4IUv5B+TDqCQx/Zn9eTpOu9V9yD+2qXCPbyV6BBE1Ljg0+1DCKgfI/9F
 Efaz8I5jCxXQKU1CKbi277AU+Gi0HjSBMPMW8TOX9r9ukAKhcRWjN0ibbmt+/T5WWo
 UlAyqzxZIKzzA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 25 Jul 2024 22:47:26 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jul 2024 22:47:26 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>,
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 4/4] common: android_ab: fix slot suffix for abc block
Date: Thu, 25 Jul 2024 22:47:04 +0300
Message-ID: <20240725194716.32232-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725194716.32232-1-ddrokosov@salutedevices.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186723 [Jul 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, source.android.com:5.0.1,7.1.1;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/25 18:54:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/25 18:54:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/25 17:13:00 #26148857
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 25 Jul 2024 22:55:09 +0200
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

To align with the official Android BCB (Boot Control Block)
specifications, it's important to note that the slot_suffix should start
with an underscore symbol.

For a comprehensive understanding of the expected slot_suffix format in
userspace, please refer to the provided reference [1].

Links:
[1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 359cc1a00428..45c154b10f1a 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -53,7 +53,7 @@ static int ab_control_default(struct bootloader_control *abc)
 	if (!abc)
 		return -EFAULT;
 
-	memcpy(abc->slot_suffix, "a\0\0\0", 4);
+	memcpy(abc->slot_suffix, "_a\0\0", 4);
 	abc->magic = BOOT_CTRL_MAGIC;
 	abc->version = BOOT_CTRL_VERSION;
 	abc->nb_slot = NUM_SLOTS;
@@ -319,7 +319,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		 * or the device tree.
 		 */
 		memset(slot_suffix, 0, sizeof(slot_suffix));
-		slot_suffix[0] = BOOT_SLOT_NAME(slot);
+		slot_suffix[0] = '_';
+		slot_suffix[1] = BOOT_SLOT_NAME(slot);
 		if (memcmp(abc->slot_suffix, slot_suffix,
 			   sizeof(slot_suffix))) {
 			memcpy(abc->slot_suffix, slot_suffix,
-- 
2.43.0

