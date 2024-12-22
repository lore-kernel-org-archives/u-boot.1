Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC4AE77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 21:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653B680654;
	Sun, 22 Dec 2024 22:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Zowsr5gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DA680655; Sun, 22 Dec 2024 22:23:41 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E6880642
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 22:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id F160C100008;
 Mon, 23 Dec 2024 00:23:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F160C100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734902615;
 bh=e9+uvJm7UT4z4jjk8nLu5x/yPbFjOF/P2OuYIcdSPVE=;
 h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
 b=Zowsr5guHCsoyYqp0KxZBsMgVWWfyMKuU8loTaTzFGB0qHyXgfEqNstgvyPZh2dy2
 qOjSWOvZnQWT6TP8UgNqBhyjREYjginiv5BeCthTh2mC3mznP/BJMjExKdKUlJXBpK
 DGYtZ+qhzy+ANj1pMczjrbNxxzrfCWhyoOtdXv2fsv6HLDb9SWp5hbbCgbyUWVIuK8
 6afjkrb9J6ZcxdKwaAYS7OhaDEh4HB71jUD2jCn4PtBtgGSDS39QytyhHF27PM1uPe
 6Fl4i3iO3Q3wLQLz3j9I/8ahavetc9Y92phP5iAvzlKCIQaHE95rx9JvOEdDaSAqpc
 T30ZT671SfKgg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 23 Dec 2024 00:23:35 +0300 (MSK)
Message-ID: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
Date: Mon, 23 Dec 2024 00:23:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@salutedevices.com>, <oxffffaa@gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.220.140.242]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189992 [Dec 22 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/22 19:44:00 #26898733
X-KSMG-AntiVirus-Status: Clean, skipped
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

If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL),
then driver doesn't copy OOB data from 'oob_poi' to special controller
structures, so zeroes will be written as OOB. But, generic raw NAND logic
in 'nand_base.c' already handles case when OOB is not required to write by
filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
always read 'oob_poi' data for OOB.

Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
so need to keep same behaviour here.

Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 81122315f4..82a12ac061 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *ch
 		memcpy(meson_chip->data_buf, buf, mtd->writesize);
 
 	memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
-
-	if (oob_required)
-		meson_nfc_set_user_byte(chip, chip->oob_poi);
+	meson_nfc_set_user_byte(chip, chip->oob_poi);
 
 	return meson_nfc_write_page_sub(chip, page, false);
 }
-- 
2.30.1
