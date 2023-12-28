Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB1AC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1628787B14;
	Thu, 28 Dec 2023 16:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="fodgI++n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 577E187A71; Thu, 28 Dec 2023 16:39:45 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399E787A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B066E12003E;
 Thu, 28 Dec 2023 18:39:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B066E12003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777982;
 bh=X/oYcH6U5H7VnYuBmXJBo75xNZvRamzbp5TiD8tnujM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fodgI++nepbb0Ka5/MtZcQs3gEEqvVqLe+1RlL4+pGK3NAi75WW1Kn9sTv5vB3449
 FFr2lWMcVBpNkbr0eWAS8qlEy+luKTTfH9rcq4j94Oo3SsJ4JiAFLmM7W9iSMUX9N6
 DoYUyD+KnBKvw+QGCsjzleg4eAUuOx4HIM+ii3XTItEU9nODAsx/eX4ejeGbT28s5+
 2hEn0Npd62x0Aq8XBKm3umDjsIRt2Tf2CLQvIpnAKVljeD/iIxODheqgea3CyHq4wl
 foWfW0Ghy6zFiqONT+Utwc8Wx4HAtA0k1bZxMaJchQ3sOTgy2poxKd/aDt2OpNsvOo
 HgVgPyZJRn9uA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:42 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:42 +0300
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
Subject: [PATCH v1 12/12] fastboot: fb_nand: add missing newlines in pr_err()
 macro
Date: Thu, 28 Dec 2023 18:39:15 +0300
Message-ID: <20231228153922.84323-13-avromanov@salutedevices.com>
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
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:44 +0100
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

pr_err() doesn't add an newline symbol when printing.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/fastboot/fb_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index 39d888301f..9db1903e41 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -48,13 +48,13 @@ static int fb_nand_lookup(const char *partname,
 
 	ret = find_dev_and_part(partname, &dev, &pnum, part);
 	if (ret) {
-		pr_err("cannot find partition: '%s'", partname);
+		pr_err("cannot find partition: '%s'\n", partname);
 		fastboot_fail("cannot find partition", response);
 		return ret;
 	}
 
 	if (dev->id->type != MTD_DEV_TYPE_NAND && dev->id->type != MTD_DEV_TYPE_SPINAND) {
-		pr_err("partition '%s' is not stored on a NAND device",
+		pr_err("partition '%s' is not stored on a NAND device\n",
 		      partname);
 		fastboot_fail("not a NAND device", response);
 		return -EINVAL;
@@ -178,7 +178,7 @@ void fastboot_nand_flash_write(const char *cmd, void *download_buffer,
 
 	ret = fb_nand_lookup(cmd, &mtd, &part, response);
 	if (ret) {
-		pr_err("invalid NAND device");
+		pr_err("invalid NAND device\n");
 		fastboot_fail("invalid NAND device", response);
 		return;
 	}
@@ -242,7 +242,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
 
 	ret = fb_nand_lookup(cmd, &mtd, &part, response);
 	if (ret) {
-		pr_err("invalid NAND device");
+		pr_err("invalid NAND device\n");
 		fastboot_fail("invalid NAND device", response);
 		return;
 	}
@@ -253,7 +253,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
 
 	ret = _fb_nand_erase(mtd, part);
 	if (ret) {
-		pr_err("failed erasing from device %s", mtd->name);
+		pr_err("failed erasing from device %s\n", mtd->name);
 		fastboot_fail("failed erasing from device", response);
 		return;
 	}
-- 
2.30.1

