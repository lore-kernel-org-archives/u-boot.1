Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52412C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F36188B1B;
	Thu, 18 Jul 2024 10:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VnMCn4Z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF50388354; Thu, 18 Jul 2024 07:45:46 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A64B88AFC
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D2C4D10001B;
 Thu, 18 Jul 2024 08:45:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D2C4D10001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721281543;
 bh=y0QSfsv/QyGSi/We0D85zboJXbauBSdDtYQFBRCaUOA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=VnMCn4Z1g2mCn6+WGkWAjB1jSBNRpdxwjqCpOOPK2E344yfSu/IE+Bd/W/FDfOQCr
 Bt5+buUp3i+GY4l7bbDmfWvNq6N9UpGfQChZONdHP5FgK+lcm/tSINO2+rxbk7i1+2
 VT4cy4r1xMHyHHgCPX7iAIN/6ydmiXMH//yaaRmXsW774ItfayuhKzKsueddTl1MFX
 7EpexcVYMJG9hgJbVG8OduG8Nl3EaYWTw0ydduNzDhPv0tPKxZamLbnRk2UijOYD1Q
 tUsPQaAGt6W5/sWZN84uQ2IqwdgEaPOFcPzWJhzMVx2OQg2cjHx2a138XoD/7tiEjR
 K3c/IFpNTLSPQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 18 Jul 2024 08:45:43 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 08:45:42 +0300
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
Subject: [PATCH v6 2/6] ubi: allow to write to volume with offset
Date: Thu, 18 Jul 2024 08:45:24 +0300
Message-ID: <20240718054528.799539-3-avromanov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 100.64.160.123:7.1.2; salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
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

Introduce ubi_volume_offset_write() helper, which
allow to write to ubi volume with specified offset.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
Acked-by: Heiko Schocher <hs@denx.de>
---
 cmd/ubi.c           | 72 +++++++++++++++++++++++++++++++++++++++++++--
 env/ubi.c           | 10 +++----
 include/ubi_uboot.h |  2 +-
 3 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 4bf7c099dd..0e62e44932 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -423,9 +423,75 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 	return ubi_volume_continue_write(volume, buf, size);
 }
 
-int ubi_volume_write(char *volume, void *buf, size_t size)
+static int ubi_volume_offset_write(char *volume, void *buf, loff_t offset,
+				   size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int len, tbuf_size, ret;
+	u64 lnum;
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
+		ret = ubi_read(&desc, (int)lnum, tbuf, 0, tbuf_size);
+		if (ret) {
+			pr_err("Failed to read leb %lld (%d)\n", lnum, ret);
+			goto exit;
+		}
+
+		memcpy(tbuf + off, buf, len);
+
+		ret = ubi_leb_change(&desc, (int)lnum, tbuf, tbuf_size);
+		if (ret) {
+			pr_err("Failed to write leb %lld (%d)\n", lnum, ret);
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
@@ -769,7 +835,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 						(void *)addr, size, full_size);
 			}
 		} else {
-			ret = ubi_volume_write(argv[3], (void *)addr, size);
+			ret = ubi_volume_write(argv[3], (void *)addr, 0, size);
 		}
 		if (!ret) {
 			printf("%lld bytes written to volume %s\n", size,
diff --git a/env/ubi.c b/env/ubi.c
index 22f2cafcfb..2f4ca571ed 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -53,7 +53,7 @@ static int env_ubi_save(void)
 	if (gd->env_valid == ENV_VALID) {
 		puts("Writing to redundant UBI... ");
 		if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME_REDUND,
-				     (void *)env_new, CONFIG_ENV_SIZE)) {
+				     (void *)env_new, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to write env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       CONFIG_ENV_UBI_VOLUME_REDUND);
@@ -62,7 +62,7 @@ static int env_ubi_save(void)
 	} else {
 		puts("Writing to UBI... ");
 		if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME,
-				     (void *)env_new, CONFIG_ENV_SIZE)) {
+				     (void *)env_new, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to write env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       CONFIG_ENV_UBI_VOLUME);
@@ -92,7 +92,7 @@ static int env_ubi_save(void)
 		return 1;
 	}
 
-	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME, (void *)env_new,
+	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME, (void *)env_new, 0,
 			     CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to write env to %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
@@ -196,7 +196,7 @@ static int env_ubi_erase(void)
 	memset(env_buf, 0x0, CONFIG_ENV_SIZE);
 
 	if (ubi_volume_write(CONFIG_ENV_UBI_VOLUME,
-			     (void *)env_buf, CONFIG_ENV_SIZE)) {
+			     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to erase env to %s:%s **\n",
 		       CONFIG_ENV_UBI_PART,
 		       CONFIG_ENV_UBI_VOLUME);
@@ -204,7 +204,7 @@ static int env_ubi_erase(void)
 	}
 	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
 		if (ubi_volume_write(ENV_UBI_VOLUME_REDUND,
-				     (void *)env_buf, CONFIG_ENV_SIZE)) {
+				     (void *)env_buf, 0, CONFIG_ENV_SIZE)) {
 			printf("\n** Unable to erase env to %s:%s **\n",
 			       CONFIG_ENV_UBI_PART,
 			       ENV_UBI_VOLUME_REDUND);
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index a4be0feabb..d36bb92348 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -48,7 +48,7 @@ extern int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 extern int ubi_init(void);
 extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
-extern int ubi_volume_write(char *volume, void *buf, size_t size);
+extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
-- 
2.34.1

