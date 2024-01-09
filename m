Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB8C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438EC87A82;
	Tue,  9 Jan 2024 18:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="R2MkRuHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9788D8792B; Tue,  9 Jan 2024 18:32:54 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1179D87942
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 4159312000F;
 Tue,  9 Jan 2024 20:32:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4159312000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704821569;
 bh=A3Bxug9hIq5eS6Hg7bmSKGOsqswnyc2j44RMkBtn+SA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=R2MkRuHIa+uzCbL5ezCcA4Kfc+QnO3/5ZPon7F3eFh9XefShojGENefBeDS4ekXON
 YCKAETsZsS+f8UEjcT8pDictJX+CGqmciqGJgoC/KW++soAN3K90O8H3CX+8Pt94B6
 Hm6XlRHvQRYNfoi+HP3DqMdb2snWlAVMMY2fwpDXKoO7dfKN8jPsU2G/S3L4fJMdwE
 7pmrgSb1DE4T8OE7sP+0UW2W0PSIPJW+vryRnVKsbTOJCCGaNj+twMZhQuREy8clVi
 nmDeBoHcEopwEUSL7Bf6kh0SsX+4e5ZoollOOpDdh0OwhzQ3DprKuEh8by2hih1FrO
 K6Vr2pedn4eow==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 20:32:49 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:32:48 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2 06/14] spi: use nand_register() instead of add_mtd_device()
Date: Tue, 9 Jan 2024 20:32:18 +0300
Message-ID: <20240109173231.78920-7-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109173231.78920-1-avromanov@salutedevices.com>
References: <20240109173231.78920-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182518 [Jan 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 100.64.160.123:7.1.2; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/09 15:14:00 #23039571
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 09 Jan 2024 18:40:45 +0100
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

Most functions that work with NAND device (for example fastboot),
use the get_nand_dev_by_index() function to work with NAND MTD.
In order to use this feature, SPI NAND must be registered via
nand_register().

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/nand/spi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 07e521dbf5..2a3dbcfcb4 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -23,6 +23,7 @@
 #else
 #include <common.h>
 #include <errno.h>
+#include <nand.h>
 #include <watchdog.h>
 #include <spi.h>
 #include <spi-mem.h>
@@ -1213,7 +1214,7 @@ static int spinand_probe(struct udevice *dev)
 #ifndef __UBOOT__
 	ret = mtd_device_register(mtd, NULL, 0);
 #else
-	ret = add_mtd_device(mtd);
+	ret = nand_register(0, mtd);
 #endif
 	if (ret)
 		goto err_spinand_cleanup;
-- 
2.30.1

