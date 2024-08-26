Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F84C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 13:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FF988A47;
	Mon, 26 Aug 2024 15:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="i+rlU5oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F079588A3A; Mon, 26 Aug 2024 15:30:12 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFA288A2E
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 15:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 46DCE120007;
 Mon, 26 Aug 2024 16:30:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46DCE120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1724679009;
 bh=fzEvLbzaDYGIdkWkAvNQhcdnTWKcApYvgcoMhQsmpM0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=i+rlU5oQDovlWxavw3m54VuQI8d4Q2EIsFfjv/jpP5VAvIGMVKJuGID33WOpVNO3a
 WK9Jwlz2/0/Syq/YwGISUWa1+52HYDMqbkm202sAbB8k6+ALmqdKt44G48ILe6vsl1
 ZT8rWEBzj8CZ0gTLe5OqYCRTPi6opxNT6ve5neI8zo3/T5kikVGU9uS7yA9qUvDZAK
 4y5UHvQ8wIKA01qRF6cVjjd/Faae0gbuOIDvbfY67J8VueYbxJ8f7okh+etKExuPW2
 fjx0vzvsqFbOvrfmjCX85h1PCnmbaBE5CFjywNV8nZDW+IRh1VfjgTJJS51cBg5m3U
 Ia8qenK/ikU0Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 26 Aug 2024 16:30:08 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v3 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
Date: Mon, 26 Aug 2024 16:17:08 +0300
Message-ID: <20240826131710.29746-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240826131710.29746-1-avkrasnov@salutedevices.com>
References: <20240826131710.29746-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.225.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187326 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/08/26 08:14:00 #26435425
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

Based on Linux kernel:
commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")

Allow to define a NAND chip as a boot device. This can be helpful
for the selection of the ECC algorithm and strength in case the boot
ROM supports only a subset of controller provided options.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 Changelog:                                                             
 v1 -> v2:                                                              
  * Place 'NAND_IS_BOOT_MEDIUM' according its numerical value.
 v2 -> v3:                                                              
  * Rebase on last master.

 drivers/mtd/nand/raw/nand_base.c | 3 +++
 include/linux/mtd/rawnand.h      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 688d17ba3c..a7474574f8 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
 	if (ret == 16)
 		chip->options |= NAND_BUSWIDTH_16;
 
+	if (ofnode_read_bool(node, "nand-is-boot-medium"))
+		chip->options |= NAND_IS_BOOT_MEDIUM;
+
 	if (ofnode_read_bool(node, "nand-on-flash-bbt"))
 		chip->bbt_options |= NAND_BBT_USE_FLASH;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4abaf4734c..0e7b5f852c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -248,6 +248,11 @@ enum nand_ecc_algo {
  * kmap'ed, vmalloc'ed highmem buffers being passed from upper layers
  */
 #define NAND_USE_BOUNCE_BUFFER	0x00100000
+/*
+ * Whether the NAND chip is a boot medium. Drivers might use this information
+ * to select ECC algorithms supported by the boot ROM or similar restrictions.
+ */
+#define NAND_IS_BOOT_MEDIUM	0x00400000
 
 /*
  * Do not try to tweak the timings at runtime. This is needed when the
-- 
2.30.1

