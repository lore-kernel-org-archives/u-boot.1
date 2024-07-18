Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3863DC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F114588B15;
	Thu, 18 Jul 2024 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="CZni+ut+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0DA884AC; Thu, 18 Jul 2024 07:45:46 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AC688AF1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 93E85120011;
 Thu, 18 Jul 2024 08:45:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 93E85120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721281542;
 bh=evrXG6q80WBpJz/3y5sLg/b9Xa4Y8qKzYFC0Eb0V0gc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=CZni+ut+0Y3uxos2jV8kHf7pO32SGTnljCIhnvR8taLGrx8MKBzRsbHXwI6b/uZ8Y
 XYQktBYNoAkwY6NJbrvYzcBmZnZEZ1nPPZA/ImCx8tP3Bk9T2rXuzUj3kjj/ebLDvG
 IwnE/Heu8i4yWp8c/BZQgSdlbq7RE+AalcpKluq2wkeQp199Vb8n1ZpOw5drO17yG7
 XypwcJJ55VCj3L8as3I13L+tGt1z/imt42zi1mRxo7dixZ35ERv6kFf28WHycl201E
 WWVoLrlC+7xfpS6oatAkl0+V4XSU/9Zv3EgsEY2B01tAjQfIGGX7U38ohGEbzMEOVl
 FUDYOnpk+/g/g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 18 Jul 2024 08:45:42 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 08:45:40 +0300
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
Subject: [PATCH v6 1/6] ubi: allow to read from volume with offset
Date: Thu, 18 Jul 2024 08:45:23 +0300
Message-ID: <20240718054528.799539-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718054528.799539-1-avromanov@salutedevices.com>
References: <20240718054528.799539-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186573 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; 100.64.160.123:7.1.2; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/18 03:46:00 #26059015
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 18 Jul 2024 10:35:04 +0200
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
Reviewed-by: Heiko Schocher <hs@denx.de>
Acked-by: Heiko Schocher <hs@denx.de>
---
 cmd/ubi.c           | 6 +++---
 env/ubi.c           | 6 +++---
 include/ubi_uboot.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 92998af2b0..4bf7c099dd 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -428,13 +428,13 @@ int ubi_volume_write(char *volume, void *buf, size_t size)
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
@@ -795,7 +795,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			return ubi_volume_read(argv[3], (char *)addr, size);
+			return ubi_volume_read(argv[3], (char *)addr, 0, size);
 		}
 	}
 
diff --git a/env/ubi.c b/env/ubi.c
index 0c3e93c2bf..22f2cafcfb 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -134,14 +134,14 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1,
+	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1, 0,
 				     CONFIG_ENV_SIZE);
 	if (read1_fail)
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
 
 	read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND,
-				     (void *)tmp_env2, CONFIG_ENV_SIZE);
+				     (void *)tmp_env2, 0, CONFIG_ENV_SIZE);
 	if (read2_fail)
 		printf("\n** Unable to read redundant env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME_REDUND);
@@ -171,7 +171,7 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, CONFIG_ENV_SIZE)) {
+	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
 		env_set_default(NULL, 0);
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index d7a8851094..a4be0feabb 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -49,7 +49,7 @@ extern int ubi_init(void);
 extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
 extern int ubi_volume_write(char *volume, void *buf, size_t size);
-extern int ubi_volume_read(char *volume, char *buf, size_t size);
+extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.34.1

