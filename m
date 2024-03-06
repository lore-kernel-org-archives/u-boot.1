Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAF7C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D8F87D9B;
	Wed,  6 Mar 2024 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="DF3zrjDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EAE87666; Wed,  6 Mar 2024 14:49:27 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE9B87D9D
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1732B120019;
 Wed,  6 Mar 2024 16:49:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1732B120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709732964;
 bh=yU2f+chxfAKNoeBVWneOYY0iqFtbCk9na+Zbrwyc4pk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=DF3zrjDFXT6S33JBIP5FkZ7UUuzITcF8oCAwEZB6MlijTV9dM2Ru9tE0Gv1HwR3Kt
 l52Vvz55Xdgn+mQbqHCqCSQYoVLzI8gxlIvE30HvTq/sAAG1vTEemrOfvt2BSX09mE
 JbPiigszwxB9qkTqMmPmz8UdEv1ZiKmszV9GkO3yW/9HMxL0RXpJUiLY6LmyLNd5EZ
 1hhPye6bd3jfCgzYzWyb5JN1fT5moGLpSsguNU3pIqEANLJ+FkcU0kZboq0463/BGp
 Ha0jK2ac/z1A5vkfG8cratKS8Ctb7otTkG/YNTZdLUDPszv/OXN3vsT1Fb5li72r2y
 nDaRSy3wfmfUA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  6 Mar 2024 16:49:23 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 16:49:22 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <kmpark@infradead.org>, <hs@denx.de>,
 <joe.hershberger@ni.com>, <dunaev@tecon.ru>, <sjg@chromium.org>,
 <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <tobias@waldekranz.com>,
 <jpewhacker@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <kever.yang@rock-chips.com>, <jbx6244@gmail.com>,
 <abdellatif.elkhlifi@arm.com>, <mikhail.kshevetskiy@iopsys.eu>,
 <jagan@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 1/6] ubi: allow to read from volume with offset
Date: Wed, 6 Mar 2024 16:49:01 +0300
Message-ID: <20240306134906.1179285-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306134906.1179285-1-avromanov@salutedevices.com>
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 06 Mar 2024 14:51:44 +0100
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

Now user can pass an additional parameter 'offset'
to ubi_volume_read() function.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/ubi.c           | 6 +++---
 env/ubi.c           | 6 +++---
 include/ubi_uboot.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd1..2257f68498 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -420,13 +420,13 @@ int ubi_volume_write(char *volume, void *buf, size_t size)
 	return ubi_volume_begin_write(volume, buf, size, size);
 }
 
-int ubi_volume_read(char *volume, char *buf, size_t size)
+int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
 {
 	int err, lnum, off, len, tbuf_size;
 	void *tbuf;
 	unsigned long long tmp;
 	struct ubi_volume *vol;
-	loff_t offp = 0;
+	loff_t offp = offset;
 	size_t len_read;
 
 	vol = ubi_find_volume(volume);
@@ -787,7 +787,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			return ubi_volume_read(argv[3], (char *)addr, size);
+			return ubi_volume_read(argv[3], (char *)addr, 0, size);
 		}
 	}
 
diff --git a/env/ubi.c b/env/ubi.c
index 445d34fedb..661801d5a9 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -135,13 +135,13 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1,
+	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1, 0,
 				     CONFIG_ENV_SIZE);
 	if (read1_fail)
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
 
-	read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND,
+	read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND, 0,
 				     (void *)tmp_env2, CONFIG_ENV_SIZE);
 	if (read2_fail)
 		printf("\n** Unable to read redundant env from %s:%s **\n",
@@ -172,7 +172,7 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, CONFIG_ENV_SIZE)) {
+	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
 		env_set_default(NULL, 0);
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6da348eb62..bcccb76e6c 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -50,7 +50,7 @@ extern int ubi_init(void);
 extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
 extern int ubi_volume_write(char *volume, void *buf, size_t size);
-extern int ubi_volume_read(char *volume, char *buf, size_t size);
+extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.34.1

