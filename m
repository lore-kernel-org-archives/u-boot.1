Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353AC30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 12:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCC688528;
	Wed, 26 Jun 2024 14:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="BcXSHfcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDE387AEC; Wed, 26 Jun 2024 12:44:59 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9B3880A5
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 12:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 0037D12000B;
 Wed, 26 Jun 2024 13:44:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0037D12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719398697;
 bh=cfIFJtM70OBcz1uqDUBn6Gca/TKBdO9bH63QpLGO2QM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=BcXSHfcxzZlO4wMxQYjZ9iaS3xvRPsH1zTsXqJ9PFKRhEDyFoJRfSTuFepXa/NyQE
 Sr+mCccxq/Y4+2PcLS2Ye2uAS04GTfGEwGKjuKS/JFRL90fUxaPywVQcXjLnIH9M6l
 hC4TqWqsBWLP2RpgjyZQfXyeOz7J8F0sqx4wvqNba/6uE9GtOVWlKF6kkulpBhkPr2
 jlvJ03P3IFV9iWuWk7Hk7L3L3FNaOcUnzdEcmGlfe42d2UprZ24Bt99gTkWyijSKYT
 dfi8fK8vdeyUqe+HtHlbl38nyPzKGcO9yYooNOCkLy9s7CJccKE/XwfxoveGujWGjj
 zxGvqI+yMnRtw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 26 Jun 2024 13:44:56 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 26 Jun 2024 13:44:55 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <bmeng@tinylab.org>,
 <tobias@waldekranz.com>, <jpewhacker@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <kever.yang@rock-chips.com>,
 <jbx6244@gmail.com>, <abdellatif.elkhlifi@arm.com>, <michal.simek@amd.com>,
 <mikhail.kshevetskiy@iopsys.eu>, <patrice.chotard@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v6 3/3] spinand: bind mtdblock
Date: Wed, 26 Jun 2024 13:44:40 +0300
Message-ID: <20240626104440.2811686-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626104440.2811686-1-avromanov@salutedevices.com>
References: <20240626104440.2811686-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186156 [Jun 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/26 06:59:00 #25715418
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 26 Jun 2024 14:29:28 +0200
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

Bind SPI-NAND driver to MTD block driver.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/nand/spi/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62c28aa422..8edb468aed 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -34,6 +34,10 @@
 #include <linux/printk.h>
 #endif
 
+struct spinand_plat {
+	struct mtd_info *mtd;
+};
+
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
@@ -1173,12 +1177,24 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+static int spinand_bind(struct udevice *dev)
+{
+	if (blk_enabled()) {
+		struct spinand_plat *plat = dev_get_plat(dev);
+
+		return mtd_bind(dev, &plat->mtd);
+	}
+
+	return 0;
+}
+
 static int spinand_probe(struct udevice *dev)
 {
 	struct spinand_device *spinand = dev_get_priv(dev);
 	struct spi_slave *slave = dev_get_parent_priv(dev);
 	struct mtd_info *mtd = dev_get_uclass_priv(dev);
 	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spinand_plat *plat = dev_get_plat(dev);
 	int ret;
 
 #ifndef __UBOOT__
@@ -1218,6 +1234,8 @@ static int spinand_probe(struct udevice *dev)
 	if (ret)
 		goto err_spinand_cleanup;
 
+	plat->mtd = mtd;
+
 	return 0;
 
 err_spinand_cleanup:
@@ -1287,4 +1305,6 @@ U_BOOT_DRIVER(spinand) = {
 	.of_match = spinand_ids,
 	.priv_auto	= sizeof(struct spinand_device),
 	.probe = spinand_probe,
+	.bind = spinand_bind,
+	.plat_auto = sizeof(struct spinand_plat),
 };
-- 
2.34.1

