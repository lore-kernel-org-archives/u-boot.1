Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFDFC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F62D87A79;
	Tue,  9 Jan 2024 18:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Sv/XIUlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD3F8792B; Tue,  9 Jan 2024 18:32:54 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A3CA87977
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D599F120010;
 Tue,  9 Jan 2024 20:32:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D599F120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704821570;
 bh=RsUw0+jyZ3lvvq75q5dwotsQs+NpI8iH1zHq3tiBlhw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Sv/XIUlJ0RqL+21mN79l0iLVJN8QKZpleTXPPdoE2GbEK8NxDGCKMcaD+FTD9m+Q0
 96wD64jVFHm43gVQxGBf67LUxm6r0XhrwT/xDavQI4j4/99yOYpJ16XIqGRY0Wjd1h
 b53oeuYwe/VnMLJqm1ae9HwAxYz9AzndUrC7tCvjwhPxNhiZJ0PHeMH72T0PU7qmxc
 DVBQu3//FLDOWTvVKVbNEkaUQaKq9C1xiIyk00tEb443R9qVolJTm9u/sHpBFhg8Y+
 OZqZbkRHdDxVAaEMvI/2dWiWJI68wkquGAXPucZtyOBDldB8nI/3lU5I7hvEJFCMFt
 +P628UUmP1HAQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 20:32:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:32:50 +0300
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
Subject: [PATCH v2 08/14] mtdparts: use CMD_RET_FAILURE define
Date: Tue, 9 Jan 2024 20:32:20 +0300
Message-ID: <20240109173231.78920-9-avromanov@salutedevices.com>
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

Use 'return CMD_RET_FAILURE' define instead of 'return 1'.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/mtdparts.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index 00c07014b2..392ee511c9 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -1923,15 +1923,15 @@ static int do_chpart(struct cmd_tbl *cmdtp, int flag, int argc,
 	u8 pnum;
 
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if (argc < 2) {
 		printf("no partition id specified\n");
-		return 1;
+		return CMD_RET_FAILURE;
 	}
 
 	if (find_dev_and_part(argv[1], &dev, &pnum, &part) != 0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	current_mtd_dev = dev;
 	current_mtd_partnum = pnum;
@@ -1978,7 +1978,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() != 0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if (argc == 1) {
 		list_partitions();
@@ -2000,11 +2000,11 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct part_info *p;
 
 		if (mtd_id_parse(argv[2], NULL, &type, &num) != 0)
-			return 1;
+			return CMD_RET_FAILURE;
 
 		if ((id = id_find(type, num)) == NULL) {
 			printf("no such device %s defined in mtdids variable\n", argv[2]);
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		len = strlen(id->mtd_id) + 1;	/* 'mtd_id:' */
@@ -2015,7 +2015,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		if (len >= PART_ADD_DESC_MAXLEN) {
 			printf("too long partition description\n");
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 		sprintf(tmpbuf, "%s:%s(%s)%s",
 				id->mtd_id, argv[3], argv[4], argv[5] ? argv[5] : "");
@@ -2031,7 +2031,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 #if defined(CONFIG_CMD_MTDPARTS_SPREAD)
 		if (get_mtd_info(dev->id->type, dev->id->num, &mtd))
-			return 1;
+			return CMD_RET_FAILURE;
 
 		if (!strcmp(&argv[1][3], ".spread")) {
 			spread_partition(mtd, p, &next_offset);
@@ -2045,12 +2045,12 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 		} else if (part_add(dev_tmp, p) != 0) {
 			/* merge new partition with existing ones*/
 			device_del(dev);
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) != 0) {
 			printf("generated mtdparts too long, resetting to null\n");
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		return 0;
-- 
2.30.1

