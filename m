Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC0C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC8887AFE;
	Thu, 28 Dec 2023 16:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Jvaue4tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D401C87AAA; Thu, 28 Dec 2023 16:39:41 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA0387AD1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id ABC3A12000B;
 Thu, 28 Dec 2023 18:39:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ABC3A12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777977;
 bh=XmknxpxiR1sLZZ5FkB5NsJpx+NQVZj5vWijQbIVs7hs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Jvaue4tr3eDmya1uwARbolLn/WRi1p+66p4g1jAe5Vh0ee3UBjtX6I/HLTIxHNSJy
 ZRbhvmIxUHRO046o1sn21Kui2cdwCAFL+awyc3kelhbGbFcpQKR/KxA6qFAxOC0gKw
 fTE9dD7KotK3nm5yyIS2A7VaR7HY7nszVZaKEuYl6y9ZOrr1PBoZAFI67sjLFU6d2R
 LLizwx6mOVANIiDuvzWOmu+RGemgJRFinNOHd29wHv7Qxemoxy6QCk8XOw6mEEnxg0
 7LFn9N+JGsxKb6XrThv4MQ9+ugukP04z3EfCllMeVTw0X5ONlK7OdB8CpOVaTCNEhP
 lqrIa3Hne2yUQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:37 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:37 +0300
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
Subject: [PATCH v1 08/12] jffs2: use negative error codes
Date: Thu, 28 Dec 2023 18:39:11 +0300
Message-ID: <20231228153922.84323-9-avromanov@salutedevices.com>
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

It is bad practice to use such error codes. Error codes
must be negative.

And use CMD_RET_FAILURE and CMD_RET_SUCCESS defines instead
of 1 and 0.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/jffs2.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/cmd/jffs2.c b/cmd/jffs2.c
index e00fcc2022..068eeedc58 100644
--- a/cmd/jffs2.c
+++ b/cmd/jffs2.c
@@ -151,7 +151,7 @@ extern int cramfs_info (struct part_info *info);
  * Check device number to be within valid range for given device type.
  *
  * @param dev device to validate
- * Return: 0 if device is valid, 1 otherwise
+ * Return: 0 if device is valid, -errno otherwise
  */
 static int mtd_device_validate(u8 type, u8 num, u32 *size)
 {
@@ -191,7 +191,7 @@ static int mtd_device_validate(u8 type, u8 num, u32 *size)
 	} else
 		printf("Unknown defice type %d\n", type);
 
-	return 1;
+	return -EINVAL;
 }
 
 /**
@@ -202,7 +202,7 @@ static int mtd_device_validate(u8 type, u8 num, u32 *size)
  * @param ret_id output pointer to next char after parse completes (output)
  * @param dev_type parsed device type (output)
  * @param dev_num parsed device number (output)
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type, u8 *dev_num)
 {
@@ -220,12 +220,12 @@ static int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type, u8 *d
 		p += 7;
 	} else {
 		printf("incorrect device type in %s\n", id);
-		return 1;
+		return -EINVAL;
 	}
 
 	if (!isdigit(*p)) {
 		printf("incorrect device number in %s\n", id);
-		return 1;
+		return -EINVAL;
 	}
 
 	*dev_num = simple_strtoul(p, (char **)&p, 0);
@@ -328,7 +328,7 @@ static inline u32 get_part_sector_size(struct mtdids *id, struct part_info *part
  * 'Static' version of command line mtdparts_init() routine. Single partition on
  * a single device configuration.
  *
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 int mtdparts_init(void)
 {
@@ -348,7 +348,7 @@ int mtdparts_init(void)
 					sizeof(struct mtdids));
 		if (!current_mtd_dev) {
 			printf("out of memory\n");
-			return 1;
+			return -ENOMEM;
 		}
 		memset(current_mtd_dev, 0, sizeof(struct mtd_device) +
 		       sizeof(struct part_info) + sizeof(struct mtdids));
@@ -365,7 +365,7 @@ int mtdparts_init(void)
 				(mtd_device_validate(id->type, id->num, &size) != 0)) {
 			printf("incorrect device: %s%d\n", MTD_DEV_TYPE(id->type), id->num);
 			free(current_mtd_dev);
-			return 1;
+			return -EINVAL;
 		}
 		id->size = size;
 		INIT_LIST_HEAD(&id->link);
@@ -485,7 +485,7 @@ int do_jffs2_fsload(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -500,17 +500,18 @@ int do_jffs2_fsload(struct cmd_tbl *cmdtp, int flag, int argc,
 			size = jffs2_1pass_load((char *)offset, part, filename);
 		}
 
-		if (size > 0) {
-			printf("### %s load complete: %d bytes loaded to 0x%lx\n",
-				fsname, size, offset);
-			env_set_hex("filesize", size);
-		} else {
+		if (size <= 0) {
 			printf("### %s LOAD ERROR<%x> for %s!\n", fsname, size, filename);
+			return CMD_RET_FAILURE;
 		}
 
-		return !(size > 0);
+		printf("### %s load complete: %d bytes loaded to 0x%lx\n",
+			fsname, size, offset);
+		env_set_hex("filesize", size);
+
+		return 0;
 	}
-	return 1;
+	return CMD_RET_FAILURE;
 }
 
 /**
@@ -534,7 +535,7 @@ int do_jffs2_ls(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -546,9 +547,9 @@ int do_jffs2_ls(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			ret = jffs2_1pass_ls(part, filename);
 		}
 
-		return ret ? 0 : 1;
+		return ret ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 	}
-	return 1;
+	return CMD_RET_FAILURE;
 }
 
 /**
@@ -570,7 +571,7 @@ int do_jffs2_fsinfo(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -585,9 +586,9 @@ int do_jffs2_fsinfo(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = jffs2_1pass_info(part);
 		}
 
-		return ret ? 0 : 1;
+		return ret ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 	}
-	return 1;
+	return CMD_RET_FAILURE;
 }
 
 /***************************************************/
-- 
2.30.1

