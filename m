Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FEEE876AF;
	Thu, 30 Nov 2023 15:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="UVIAEv0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AFC870AF; Thu, 30 Nov 2023 12:36:35 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097E786940
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 65C32120002;
 Thu, 30 Nov 2023 14:36:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65C32120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701344192;
 bh=LufvmQhGxEhal+81ddbjuLX365srQXUOdBPxk1dfwXU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=UVIAEv0y+uvDBuX8yozp4XPVaxJNEjVXpHzUW1JYTbeFOCEltNM0Rr6DhQl46JFKT
 jGx4w+ARDGZyfs++635dxh+IA2DT2tOIMADDOOmL6uph0JB8KKaE39ydu56REbzrpZ
 brplJ1EDT8IeQN/dJcN1e4n4i0wuULViYO2bmt4qnKE3uX0iAy3dsADr9365Xickas
 yqM2D6hUQbJgFtoOJL7zf1wXL772gO5wGjE8VmBtcRokc7gx1fm9h+PfEz9et60tyi
 qjGYyMamSkyeZA/daOngXD28+MTTZECiEZqjT2eRrJOzBzzPslxMW5VnKKCyrVdYtB
 Ev/0SXQ9eslYg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 30 Nov 2023 14:36:32 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 14:36:31 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>, Alexey Romanov <avromanov@sberdevices.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Sean Edmond <seanedmond@microsoft.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Stephen Carlson
 <stcarlso@linux.microsoft.com>, Michael Walle <michael@walle.cc>, Peter
 Robinson <pbrobinson@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Michael Trimarchi
 <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
 <avkrasnov@salutedevices.com>
Subject: [PATCH v1] cmd: mtd: OTP access support
Date: Thu, 30 Nov 2023 14:28:17 +0300
Message-ID: <20231130112817.98827-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181731 [Nov 30 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2; p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/30 09:19:00 #22581264
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 30 Nov 2023 15:10:20 +0100
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

Add access to OTP region. It supports info, dump, write and lock
operations.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 cmd/Kconfig |   1 +
 cmd/mtd.c   | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 90e4ef93e0..c47523a03b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1354,6 +1354,7 @@ config CMD_MTD
 	bool "mtd"
 	depends on MTD
 	select MTD_PARTITIONS
+	select HEXDUMP
 	help
 	  MTD commands support.
 
diff --git a/cmd/mtd.c b/cmd/mtd.c
index eb6e2d6892..3ad15b0f8f 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <common.h>
 #include <console.h>
+#include <hexdump.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <mtd.h>
@@ -202,6 +203,219 @@ static bool mtd_oob_write_is_empty(struct mtd_oob_ops *op)
 	return true;
 }
 
+static int do_mtd_otp_read(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct mtd_info *mtd;
+	size_t retlen;
+	off_t from;
+	size_t len;
+	bool user;
+	int ret;
+	u8 *buf;
+
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	if (!strcmp(argv[2], "u"))
+		user = true;
+	else if (!strcmp(argv[2], "f"))
+		user = false;
+	else
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	from = simple_strtoul(argv[3], NULL, 0);
+	len = simple_strtoul(argv[4], NULL, 0);
+
+	ret = CMD_RET_FAILURE;
+
+	buf = malloc(len);
+	if (!buf)
+		goto put_mtd;
+
+	printf("Reading %s OTP from 0x%lx, %lu bytes\n",
+	       user ? "user" : "factory", from, len);
+
+	if (user)
+		ret = mtd_read_user_prot_reg(mtd, from, len, &retlen, buf);
+	else
+		ret = mtd_read_fact_prot_reg(mtd, from, len, &retlen, buf);
+	if (ret) {
+		free(buf);
+		pr_err("OTP read failed: %d\n", ret);
+		ret = CMD_RET_FAILURE;
+		goto put_mtd;
+	}
+
+	if (retlen != len)
+		pr_err("OTP read returns %zu, but %zu expected\n",
+		       retlen, len);
+
+	print_hex_dump("", 0, 16, 1, buf, retlen, true);
+
+	free(buf);
+
+	ret = CMD_RET_SUCCESS;
+
+put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+
+static int do_mtd_otp_lock(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct mtd_info *mtd;
+	off_t from;
+	size_t len;
+	int ret;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	from = simple_strtoul(argv[2], NULL, 0);
+	len = simple_strtoul(argv[3], NULL, 0);
+
+	ret = mtd_lock_user_prot_reg(mtd, from, len);
+	if (ret) {
+		pr_err("OTP lock failed: %d\n", ret);
+		ret = CMD_RET_FAILURE;
+		goto put_mtd;
+	}
+
+	ret = CMD_RET_SUCCESS;
+
+put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+
+static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	struct mtd_info *mtd;
+	size_t retlen;
+	size_t binlen;
+	u8 *binbuf;
+	off_t from;
+	int ret;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	from = simple_strtoul(argv[2], NULL, 0);
+	binlen = strlen(argv[3]) / 2;
+
+	ret = CMD_RET_FAILURE;
+	binbuf = malloc(binlen);
+	if (!binbuf)
+		goto put_mtd;
+
+	hex2bin(binbuf, argv[3], binlen);
+
+	printf("Will write:\n");
+
+	print_hex_dump("", 0, 16, 1, binbuf, binlen, true);
+
+	printf("to 0x%zx\n", from);
+
+	printf("Caution! OTP data bits can't be erased! Continue (y/n)?\n");
+
+	if (confirm_yesno() != 1) {
+		pr_err("OTP write canceled\n");
+		ret = CMD_RET_SUCCESS;
+		goto put_mtd;
+	}
+
+	ret = mtd_write_user_prot_reg(mtd, from, binlen, &retlen, binbuf);
+	if (ret) {
+		pr_err("OTP write failed: %d\n", ret);
+		ret = CMD_RET_FAILURE;
+		goto put_mtd;
+	}
+
+	if (retlen != binlen)
+		pr_err("OTP write returns %zu, but %zu expected\n",
+		       retlen, binlen);
+
+	ret = CMD_RET_SUCCESS;
+
+put_mtd:
+	free(binbuf);
+	put_mtd_device(mtd);
+
+	return ret;
+}
+
+static int do_mtd_otp_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct otp_info otp_info;
+	struct mtd_info *mtd;
+	size_t retlen;
+	bool user;
+	int ret;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	if (!strcmp(argv[2], "u"))
+		user = true;
+	else if (!strcmp(argv[2], "f"))
+		user = false;
+	else
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (user)
+		ret = mtd_get_user_prot_info(mtd, sizeof(otp_info), &retlen,
+					     &otp_info);
+	else
+		ret = mtd_get_fact_prot_info(mtd, sizeof(otp_info), &retlen,
+					     &otp_info);
+	if (ret) {
+		pr_err("OTP info failed: %d\n", ret);
+		ret = CMD_RET_FAILURE;
+		goto put_mtd;
+	}
+
+	if (retlen != sizeof(otp_info)) {
+		pr_err("OTP info returns %zu, but %zu expected\n",
+		       retlen, sizeof(otp_info));
+		ret = CMD_RET_FAILURE;
+		goto put_mtd;
+	}
+
+	printf("%s OTP region info:\n", user ? "User" : "Factory");
+	printf("\tstart: %u\n", otp_info.start);
+	printf("\tlength: %u\n", otp_info.length);
+	printf("\tlocked: %u\n", otp_info.locked);
+
+	ret = CMD_RET_SUCCESS;
+
+put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+
 static int do_mtd_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
@@ -552,6 +766,10 @@ static char mtd_help_text[] =
 	"\n"
 	"Specific functions:\n"
 	"mtd bad                               <name>\n"
+	"mtd otpread                           <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                          <name> <off> <hex string>\n"
+	"mtd otplock                           <name> <off> <size>\n"
+	"mtd otpinfo                           <name> [u|f]\n"
 	"\n"
 	"With:\n"
 	"\t<name>: NAND partition/chip name (or corresponding DM device name or OF path)\n"
@@ -562,11 +780,17 @@ static char mtd_help_text[] =
 	"\t<size>: length of the operation in bytes (default: the entire device)\n"
 	"\t\t* must be a multiple of a block for erase\n"
 	"\t\t* must be a multiple of a page otherwise (special case: default is a page with dump)\n"
+	"\t<hex string>: hex string without '0x' and spaces. Example: ABCD1234\n"
+	"\t[u|f]: user or factory OTP region\n"
 	"\n"
 	"The .dontskipff option forces writing empty pages, don't use it if unsure.\n";
 #endif
 
 U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
+		U_BOOT_SUBCMD_MKENT(otpread, 5, 1, do_mtd_otp_read),
+		U_BOOT_SUBCMD_MKENT(otpwrite, 4, 1, do_mtd_otp_write),
+		U_BOOT_SUBCMD_MKENT(otplock, 4, 1, do_mtd_otp_lock),
+		U_BOOT_SUBCMD_MKENT(otpinfo, 3, 1, do_mtd_otp_info),
 		U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(read, 5, 0, do_mtd_io,
 					     mtd_name_complete),
-- 
2.35.0

