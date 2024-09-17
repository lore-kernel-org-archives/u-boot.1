Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA81FCAC589
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0BF288F2C;
	Wed, 18 Sep 2024 08:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="CIjyktpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACDF88B29; Tue, 17 Sep 2024 19:54:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E33E88D31
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D705B10000E;
 Tue, 17 Sep 2024 20:53:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D705B10000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726595637;
 bh=K3Ud/e9nlYrxCeJ7AfTxUPG3UpZ2Q/o73oKFa1gYpLw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=CIjyktpesEo8Twkn4jUELi8Nzb33hrFJgxb5S5CCJHVln652J0OmVDByM6++SCdSP
 fOrYHCfwfK8/8Ov4jK6c4PEHbJ5w1dxFsWsVsyI32XfYd4Tmd8sr2nRiG3hLvf8056
 MHOTMPX5+VeAu00wzC8ANX2jzKpkcUFlhrzIlu043Vtv4Q3HIZjMxz5BCz06JgLcOn
 aTyMaUKGRz5j8Em9GiNqTPxI5V4cAHjN03LeFNKjG8Naskms5wsX7z9aqHboKso9AS
 M/eb4eYwbtfAVgIqbkzXLfZ4InpTU1FdsHur/L5bnu8hpny8UBwhGLHxzcxY1CvPEF
 CSsLs02fk/wAA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Sep 2024 20:53:57 +0300 (MSK)
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>,
 "Heiko Schocher" <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Martin Kurbanov
 <mmkurbanov@salutedevices.com>
Subject: [RESEND PATCH v1 1/2] cmd: ubi: remove redundant initializations
Date: Tue, 17 Sep 2024 20:53:22 +0300
Message-ID: <20240917175327.13311-2-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917175327.13311-1-mmkurbanov@salutedevices.com>
References: <20240917175327.13311-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.162.132]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187805 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/17 15:06:00 #26605542
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 18 Sep 2024 08:14:47 +0200
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

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 cmd/ubi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 151afb9803..23b6211f6c 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -249,7 +249,7 @@ static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
 
 static struct ubi_volume *ubi_find_volume(char *volume)
 {
-	struct ubi_volume *vol = NULL;
+	struct ubi_volume *vol;
 	int i;
 
 	for (i = 0; i < ubi->vtbl_slots; i++) {
@@ -356,7 +356,7 @@ static int ubi_rename_vol(char *oldname, char *newname)
 
 static int ubi_volume_continue_write(char *volume, void *buf, size_t size)
 {
-	int err = 1;
+	int err;
 	struct ubi_volume *vol;
 
 	vol = ubi_find_volume(volume);
@@ -392,8 +392,8 @@ static int ubi_volume_continue_write(char *volume, void *buf, size_t size)
 int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 	size_t full_size)
 {
-	int err = 1;
-	int rsvd_bytes = 0;
+	int err;
+	int rsvd_bytes;
 	struct ubi_volume *vol;
 
 	vol = ubi_find_volume(volume);
@@ -640,7 +640,7 @@ static int ubi_detach(void)
 int ubi_part(char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
-	int err = 0;
+	int err;
 
 	if (ubi && ubi->mtd && !strcmp(ubi->mtd->name, part_name)) {
 		printf("UBI partition '%s' already selected\n", part_name);
@@ -671,7 +671,7 @@ int ubi_part(char *part_name, const char *vid_header_offset)
 
 static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int64_t size = 0;
+	int64_t size;
 	ulong addr = 0;
 	bool skipcheck = false;
 
-- 
2.43.0

