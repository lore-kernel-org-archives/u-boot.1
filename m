Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC3C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA99087AF8;
	Thu, 28 Dec 2023 16:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="R0w15Yd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C798287AB3; Thu, 28 Dec 2023 16:39:40 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B66187AB1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id CC79C12003A;
 Thu, 28 Dec 2023 18:39:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CC79C12003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777975;
 bh=o1z4Wh4lFNc/gh/+o+Leaz9V3otlBIabgf1K74YRNXg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=R0w15Yd6Gdx84X9s0cEFNgzDVWfBqpH8/GxPfgLKyuEoPr0Yue3mL01F36ZQLwB9e
 xLqE95LxHfAFsN7IYfsmtZh1tokA3GaOqBPNuNf8Gm7wgPQFuNuSXkDqIntN+ji0Ti
 l1T2D0YD42riMuceO5CuPtFIQh6yPfNc3Wsk3Wzi6X9czHKeJC52s/Bu1cJolRIqq/
 n+4EjmK7/1vWLnLTMQzyrCMg7/V6WTsYwqCDmt3HJcGiS64O3OBtq/0LLLJZOeqLrJ
 0eBjGhfJfmiszEMTFrHTa57M2mKQt7WUIKG/8JKUiatXW76PA9fa6NntsEnLZ4qdpb
 5ajvaRoqtjl+A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:35 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:35 +0300
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
Subject: [PATCH v1 06/12] spi: use nand_register() instead of add_mtd_device()
Date: Thu, 28 Dec 2023 18:39:09 +0300
Message-ID: <20231228153922.84323-7-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228153922.84323-1-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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
index 27ad6fefdb..5210332712 100644
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
@@ -1222,7 +1223,7 @@ static int spinand_probe(struct udevice *dev)
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

