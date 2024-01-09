Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833C9C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1AA87AB5;
	Tue,  9 Jan 2024 18:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="oa/uILhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E32D87A3B; Tue,  9 Jan 2024 18:32:56 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF44B878C9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6ED61120011;
 Tue,  9 Jan 2024 20:32:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6ED61120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704821572;
 bh=PssiXoBvGPQsyWb9Tx3EKZdzDtmkAU4148HuwG8YRkQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=oa/uILhTZUGgpn+cw9npO0pSGY+b/VTGiyja7pc+ZgwYBDfoD2GLym//mdDC75Phc
 Y6SRqzUYplDsQ9oIXXJL0BMGG1gjGgLAogGbcit3thBgXgkhb4uCXge1CyoOnRr0z4
 MPfJ/AW+k0lk9RAeH1C+WMa28y1DmQ+OHbQkwUzADAqcJqPkQyORqqHyjVE3HOY7xx
 c8qPm524gheuURibg7xcIytrmxX9sWvo117m1QLJZTojKcqAuWdNgXFixXpP6Kv4IM
 itac0xaHvRyFs/CGlMsz55ZEofivSWAJlykwRf7ZBI3CzWI7BVcbj5a4bE5N1ZYdmd
 ipBPjxhr+RW0g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 20:32:52 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:32:51 +0300
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
Subject: [PATCH v2 10/14] jffs2: use CMD_RET_FAILURE/SUCCESS defines
Date: Tue, 9 Jan 2024 20:32:22 +0300
Message-ID: <20240109173231.78920-11-avromanov@salutedevices.com>
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

Use CMD_RET_FAILURE and CMD_RET_SUCCESS defines instead
of 1 and 0.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/jffs2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmd/jffs2.c b/cmd/jffs2.c
index 15bf8c0edf..d5aa9bcc7e 100644
--- a/cmd/jffs2.c
+++ b/cmd/jffs2.c
@@ -485,7 +485,7 @@ int do_jffs2_fsload(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -502,16 +502,16 @@ int do_jffs2_fsload(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		if (size <= 0) {
 			printf("### %s LOAD ERROR<%x> for %s!\n", fsname, size, filename);
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		printf("### %s load complete: %d bytes loaded to 0x%lx\n",
 			fsname, size, offset);
 		env_set_hex("filesize", size);
 
-		return 0;
+		return CMD_RET_SUCCESS;
 	}
-	return 1;
+	return CMD_RET_FAILURE;
 }
 
 /**
@@ -535,7 +535,7 @@ int do_jffs2_ls(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -547,9 +547,9 @@ int do_jffs2_ls(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			ret = jffs2_1pass_ls(part, filename);
 		}
 
-		return ret ? 0 : 1;
+		return ret ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 	}
-	return 1;
+	return CMD_RET_FAILURE;
 }
 
 /**
@@ -571,7 +571,7 @@ int do_jffs2_fsinfo(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if ((part = jffs2_part_info(current_mtd_dev, current_mtd_partnum))){
 
@@ -586,9 +586,9 @@ int do_jffs2_fsinfo(struct cmd_tbl *cmdtp, int flag, int argc,
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

