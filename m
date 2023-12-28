Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BB6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4FD87ABC;
	Thu, 28 Dec 2023 16:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="EMzxwrWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCBF87A7B; Thu, 28 Dec 2023 16:39:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AC387A99
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 02EAA10003C;
 Thu, 28 Dec 2023 18:39:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 02EAA10003C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777975;
 bh=pdxaTnvs+oaWgPorrk7QyE261BruWakULMshi/ZTm0s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=EMzxwrWUGrrKCulgMoNlzgBU1Yz3APekMZzLhOElkCZB7jQq/zaLfy2X2JroaSTu1
 ao3FojH5HVs5PQgDCxz0t7Vj35xftyY8ZqzAyNiD8Ob2NfI/GgpV1HgJEAVy61cs4D
 HCP+dTwB9QRs+5s1TbBxWuGJOeAuUeKXPLg9Sz4hqasH+IjPAMVuzcFwxW9p0JFRQZ
 CyuQ5b2y2dEmIClFXADDvlSpk14fzkLcQgcOKkongm7gAWEe/RIesGNhqCB3U69yZJ
 L8hwZDFxM0bD4hTPDg5FxwjIRQ7sLZoJoPOm30FL6lEGvV+WSuXDBL8orWBkfTg4Pz
 PW8LVT5KnS1nA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:34 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:34 +0300
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
Subject: [PATCH v1 05/12] spi: add board_nand_init() function
Date: Thu, 28 Dec 2023 18:39:08 +0300
Message-ID: <20231228153922.84323-6-avromanov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

By analogy with RAW NAND drivers, select SYS_NAND_SELF_INIT
option and implement board_nand_init() function. It will be
called from nand_init().

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/nand/spi/Kconfig |  1 +
 drivers/mtd/nand/spi/core.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
index 0777dfdf0a..c9ca76a1c9 100644
--- a/drivers/mtd/nand/spi/Kconfig
+++ b/drivers/mtd/nand/spi/Kconfig
@@ -2,6 +2,7 @@ menuconfig MTD_SPI_NAND
 	bool "SPI NAND device Support"
 	depends on DM_MTD && DM_SPI
 	select MTD_NAND_CORE
+	select SYS_NAND_SELF_INIT
 	select SPI_MEM
 	help
 	  This is the framework for the SPI NAND device drivers.
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 202e3f11ec..27ad6fefdb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -28,6 +28,7 @@
 #include <spi-mem.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/uclass.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
@@ -1296,3 +1297,16 @@ U_BOOT_DRIVER(spinand) = {
 	.priv_auto	= sizeof(struct spinand_device),
 	.probe = spinand_probe,
 };
+
+void board_nand_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_SPI,
+					  DM_DRIVER_GET(spinand),
+					  &dev);
+	if (ret && ret != -ENODEV)
+		log_err("Failed to initialize SPI NAND driver. (error %d)\n",
+			ret);
+}
-- 
2.30.1

