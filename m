Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9454BC27C7B
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 04:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E9D88278;
	Mon, 17 Jun 2024 06:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Uh5+hd/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1798D87B30; Sun, 16 Jun 2024 15:34:41 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38F287DCA
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 15:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 58816120006;
 Sun, 16 Jun 2024 16:34:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 58816120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1718544876;
 bh=+Vdg/8pGgWsRfwxXPajqmOc5Iwo1vDWX9znKtpRDu68=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Uh5+hd/ASuJTvP5hyreDKWfi7iRpxnTgerq7AMPTrZyQ7sEBjGciPMxi60rIeBTo/
 Lq8sQeE0usA/U6DoWBJgbGXWFdDofY0QojQISB/MXwpkVJcLvNZqrB0IvIGlmTWRL5
 uCW9MUB7KQdirQ2jDNGA4JaznOoeTovJKH54RG50vQ4WW/+MW8/zQ6O0VeLNHkgsSY
 q0oNujCYULtibwueJjaq4fA5qff0qlgOq8epkxPtMqdKbRqFFJq4F/QXGifA+eUAj4
 Kdq7VsxAInPCQcxzo9f6bKcduYrHgbiF6Y+CdBsEt64s0TfJxCHMSSNynRLkTntCVH
 ihGbSbaH/kdZQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Sun, 16 Jun 2024 16:34:36 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 16 Jun 2024 16:34:35 +0300
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Dmitry Dunaev <dunaev@tecon.ru>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Martin Kurbanov
 <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 1/2] cmd: ubi: remove redundant initializations
Date: Sun, 16 Jun 2024 16:34:17 +0300
Message-ID: <20240616133426.123299-2-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616133426.123299-1-mmkurbanov@salutedevices.com>
References: <20240616133426.123299-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185944 [Jun 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/16 07:48:00 #25636995
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 17 Jun 2024 06:48:41 +0200
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
index 0a6a80bdd1..a9c5560182 100644
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
@@ -574,7 +574,7 @@ static int ubi_detach(void)
 int ubi_part(char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
-	int err = 0;
+	int err;
 
 	if (ubi && ubi->mtd && !strcmp(ubi->mtd->name, part_name)) {
 		printf("UBI partition '%s' already selected\n", part_name);
@@ -605,7 +605,7 @@ int ubi_part(char *part_name, const char *vid_header_offset)
 
 static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int64_t size = 0;
+	int64_t size;
 	ulong addr = 0;
 	bool skipcheck = false;
 
-- 
2.43.2

