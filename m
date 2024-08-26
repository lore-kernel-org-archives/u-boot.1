Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218DC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979978843A;
	Mon, 26 Aug 2024 08:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="BS8wyQpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228CC8877E; Mon, 26 Aug 2024 08:17:14 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EEA8877E
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B0CB312000A;
 Mon, 26 Aug 2024 09:17:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B0CB312000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1724653031;
 bh=ycBoHCcuBJJabkSlo7Kzo8lcswpSjnzPOrd/eiZ1i5E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=BS8wyQpW3TL6WfwM0Z7qMiGvWXR6TlkdfgS3FOAaw8VQ6ZqB9G8m/GsYQCZ2xIdt7
 VQLgRHzutc0xdATxrfHXO3sHzLEKZizwiwkJqxO0KtIfvWqEaDCdSS9LPqNK+e1NZ+
 Ih1Hux2tIxloyws3P1da2i7esEftZh+68oeRUUiKtwrMhxyJ2QciXxt1k/71LEu5Ng
 94ZM1RUCte1jfRWlvcD0dPL+WQfUv8QXqp5BrmSfgAZqc3x0b/nhT2O5BAATlLlWwv
 jyOhYNEa4KCiQ25CPfQb6+TskdekofeqzGfVyCUK63WhxxhfrUpcJJkxaGqAzHSciW
 jnkNjbpf3QdaA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 26 Aug 2024 09:17:11 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v2 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
Date: Mon, 26 Aug 2024 09:04:09 +0300
Message-ID: <20240826060411.3532105-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.161.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187287 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/08/26 02:45:00 #26434133
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

