Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D717C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 07:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731B28867C;
	Mon,  8 Jul 2024 09:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="LrXJoHqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DE9886C8; Mon,  8 Jul 2024 09:26:12 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB998861D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id CED90100003;
 Mon,  8 Jul 2024 10:26:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CED90100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1720423568;
 bh=ycBoHCcuBJJabkSlo7Kzo8lcswpSjnzPOrd/eiZ1i5E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LrXJoHqKS12l4bLO97V6o0bSKjAIuFdQPNen9Phiv5KcqU2wHNl4sgQ/e4rcuVqgo
 keD8b0/0dYn56UZRO6/8Hm68bRBumCkEZw+j/ngb2AcLp3srFUgD4a5KvrQRImt36S
 26c0n2MjHcmwSyqDO+Z2l189wiEV1uxtdkBzl21CjmbOKCC8hXA000J/63TXBYgOxa
 zDsFmozuIGo5M8x7g7FvUrunV4UvpVDvHxpU8cdrsXls+L39K/bSsLGvbkghpdFGEM
 hPhVJ+WfkyPZoe0FMKKS2wWYd61CxiZJ9P+NMmBYbJyRlkKxz2M55Co0nP4bPNZccV
 8RStTZKT4VuDw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  8 Jul 2024 10:26:08 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 10:26:07 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v2 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
Date: Mon, 8 Jul 2024 10:13:50 +0300
Message-ID: <20240708071352.3022327-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186360 [Jul 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/08 05:54:00 #25895811
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
---
 Changelog:                                                             
 v1 -> v2:                                                              
  * Place 'NAND_IS_BOOT_MEDIUM' according its numerical value.

 drivers/mtd/nand/raw/nand_base.c | 3 +++
 include/linux/mtd/rawnand.h      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c40a0f23d7..ed605b4af5 100644
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
index fb002ae641..61690e816f 100644
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
 
 /* Options set by nand scan */
 /* bbt has already been read */
-- 
2.30.1

