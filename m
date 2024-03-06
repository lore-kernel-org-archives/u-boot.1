Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4894CC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D787E92;
	Wed,  6 Mar 2024 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="fbm2hosE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1025486784; Wed,  6 Mar 2024 14:49:31 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DDA87C92
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 03EB8100021;
 Wed,  6 Mar 2024 16:49:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 03EB8100021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709732967;
 bh=6swo2TNMlMN98gFQ94V9r8Ao3UXj5f+9GInM5NfUgrM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fbm2hosEG+HGHdzyi9vbA+m8warqOeOk3Vr+61evVW4ND6RttgB9Zdzz36uVX3BQd
 OUUYtn2nf+yg0VksyZjj0ZQsbKDr/4dAWKwKND704v0dBYtleO6XXKfQCP6+uCqwN8
 p0O4B3+uTW1Ph4piB7LVwF1Z8frwqqO7wu+dUK6ETGTSVGuw/B/f2pHS1sXccu3z7y
 T2JNHBFw310nIpnphJ0LLhUGOMB8zSAd3XOPI4zhGazJJXsBGh0CUirBSfqu6FaU1b
 0uhaoA1NzkgBNaXg4J0Gg7akbvwmRcmjAD3s4G+JgQAd1u0i1B5A8QWsTRD+D29dGu
 NJRqy4ZcJRwvw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  6 Mar 2024 16:49:26 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 16:49:24 +0300
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
Subject: [PATCH v1 2/6] ubi: allow to write to volume with offset
Date: Wed, 6 Mar 2024 16:49:02 +0300
Message-ID: <20240306134906.1179285-3-avromanov@salutedevices.com>
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

Introduce ubi_volume_offset_write() helper, which
allow to write to ubi volume with specified offset.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/ubi.c           | 71 +++++++++++++++++++++++++++++++++++++++++++--
 env/ubi.c           | 10 +++----
 include/ubi_uboot.h |  2 +-
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 2257f68498..af874b6a46 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -415,9 +415,74 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 	return ubi_volume_continue_write(volume, buf, size);
 }
 
-int ubi_volume_write(char *volume, void *buf, size_t size)
+static int ubi_volume_offset_write(char *volume, void *buf, loff_t offset,
+				   size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int lnum, len, tbuf_size, ret;
+	struct ubi_volume *vol;
+	loff_t off = offset;
+	void *tbuf;
+
+	vol = ubi_find_volume(volume);
+	if (!vol)
+		return -ENODEV;
+
+	if (size > vol->reserved_pebs * (ubi->leb_size - vol->data_pad))
+		return -EINVAL;
+
+	tbuf_size = vol->usable_leb_size;
+	tbuf = malloc_cache_aligned(tbuf_size);
+	if (!tbuf)
+		return -ENOMEM;
+
+	lnum = off;
+	off = do_div(lnum, vol->usable_leb_size);
+
+	do {
+		struct ubi_volume_desc desc = {
+			.vol = vol,
+			.mode = UBI_READWRITE,
+		};
+
+		len = size > tbuf_size ? tbuf_size : size;
+		if (off + len >= vol->usable_leb_size)
+			len = vol->usable_leb_size - off;
+
+		ret = ubi_read(&desc, lnum, tbuf, 0, tbuf_size);
+		if (ret) {
+			pr_err("Failed to read leb %d (%d)\n", lnum, ret);
+			goto exit;
+		}
+
+		memcpy(tbuf + off, buf, len);
+
+		ret = ubi_leb_change(&desc, lnum, tbuf, tbuf_size);
+		if (ret) {
+			pr_err("Failed to write leb %d(%d)\n", lnum, ret);
+			goto exit;
+		}
+
+		off += len;
+		if (off >= vol->usable_leb_size) {
+			lnum++;
+			off -= vol->usable_leb_size;
+		}
+
+		buf += len;
+		size -= len;
+	} while (size);
+
+exit:
+	free(tbuf);
+	return ret;
+}
+
+int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
+{
+	if (!offset)
+		return ubi_volume_begin_write(volume, buf, size, size);
+
+	return ubi_volume_offset_write(volume, buf, offset, size);
 }
 
 int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
@@ -761,7 +826,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 						(void *)addr, size, full_size);
 			}
 		} else {
-			ret = ubi_volume_write(argv[3], (void *)addr, size);
+			ret = ubi_volume_write(argv[3], (void *)addr, 0, size);
 		}
 		if (!ret) {
 			printf("%lld bytes written to volume %s\n", size,
diff --git a/env/ubi.c b/env/ubi.c
index 661801d5a9..6ae74a500b 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -54,7 +54,7 @@ static int env_ubi_save(void)
 	if (gd->env_valid == ENV_VALID) {
 		puts("Writing to redundant UBI... ");
 		if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME_REDUND,
-				     (void *)env_new, CONFIG_ENV_SIZE)) {
+				     (void *)env_new, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to write env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       CONFIG_ENV_UBI_VOLUME_REDUND);
@@ -63,7 +63,7 @@ static int env_ubi_save(void)
 	} else {
 		puts("Writing to UBI... ");
 		if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME,
-				     (void *)env_new, CONFIG_ENV_SIZE)) {
+				     (void *)env_new, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to write env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       CONFIG_ENV_UBI_VOLUME);
@@ -93,7 +93,7 @@ static int env_ubi_save(void)
 		return 1;
 	}
 
-	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME, (void *)env_new,
+	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME, (void *)env_new, 0,
 			     CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to write env to %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
@@ -197,7 +197,7 @@ static int env_ubi_erase(void)
 	memset(env_buf, 0x0, CONFIG_ENV_SIZE);
 
 	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME,
-			     (void *)env_buf, CONFIG_ENV_SIZE)) {
+			     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to erase env to %s:%s **\n",
 		       CONFIG_ENV_UBI_PART,
 		       CONFIG_ENV_UBI_VOLUME);
@@ -205,7 +205,7 @@ static int env_ubi_erase(void)
 	}
 	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
 		if (ubi_volume_write(ENV_UBI_VOLUME_REDUND,
-				     (void *)env_buf, CONFIG_ENV_SIZE)) {
+				     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to erase env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       ENV_UBI_VOLUME_REDUND);
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index bcccb76e6c..5f046b91a2 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -49,7 +49,7 @@ extern int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 extern int ubi_init(void);
 extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
-extern int ubi_volume_write(char *volume, void *buf, size_t size);
+extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
-- 
2.34.1

