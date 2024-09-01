Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228BCCA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 13:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7983889C9;
	Sun,  1 Sep 2024 15:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="xg0hQb82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970C9889F8; Sun,  1 Sep 2024 15:59:19 +0200 (CEST)
Received: from mxc-2-9cd.seznam.cz (mxc-2-9cd.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:9cd])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C4E88702
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 15:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxc-7d44fcc4b-tnzdq
 (smtpc-mxc-7d44fcc4b-tnzdq [2a02:598:64:8a00::1000:9cd])
 id 0ac67902f432cba80a48f71a; Sun, 01 Sep 2024 15:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1725199154;
 bh=/8K7sn8I/VaVHPBbJvgjBu5KSXMw4jLWvgrQYiMtIeU=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=xg0hQb82L26Cl+DNt3Yr9OsVbPUXtrAGvzXhO03FiqwJQtNKxEPcUqKrqE0ZP9zYP
 mGdg22YElRkwAQFgt98w/wbUjS8Jo4eMD4W9qjkR7YEKvDrVOQhUv6C6WtBGYZkNDf
 6kncFROwriFeTiRDfkxdqZoOxeKNCAJ5LTdSnsoIKAuOkJM4VeSvt1vuEPvBBnrmwz
 4VhML+TY+wKIcj5QKmfuKhrctPTyhQBwygQOWgglYNy7l7s+qjmLZrJm+7WTf9MD9j
 Npvv9cr9A37Zq9GPW6tLOM+Dkb58H23TCxYB/tJWpYckflZjV2tHv5J12ITLWIOf0T
 8csM4HU3/Lgog==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Sun, 01 Sep 2024 15:59:12 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>
Subject: [PATCH] cmd: mmc: Allow using partition name in mmc erase command
Date: Sun, 01 Sep 2024 15:59:12 +0200 (CEST)
Message-Id: <2p9.Zbg}.7NiPNKVgoiP.1cr7Cm@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The mmc erase command currently requires blk# and cnt parameters
which can be obtained using the part command if the entire partition
needs to be deleted.

Simplify the use of the mmc erase command by allowing the partition
name to be specified directly.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 cmd/mmc.c             | 21 ++++++++++++++-------
 doc/usage/cmd/mmc.rst |  4 +++-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 7244a90..ba2f506 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -472,18 +472,25 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int f=
lag,
 			int argc, char *const argv[])
 {
 	struct mmc *mmc;
+	struct disk_partition info;
 	u32 blk, cnt, n;
 
-	if (argc !=3D 3)
-		return CMD_RET_USAGE;
-
-	blk =3D hextoul(argv[1], NULL);
-	cnt =3D hextoul(argv[2], NULL);
-
 	mmc =3D init_mmc_device(curr_device, false);
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
+	if (argc =3D=3D 2) {
+		if (part_get_info_by_name(mmc_get_blk_desc(mmc), argv[1], &info) < 0)=

+			return CMD_RET_FAILURE;
+		blk =3D info.start;
+		cnt =3D info.size & ~(mmc->erase_grp_size - 1);
+	} else if (argc =3D=3D 3) {
+		blk =3D hextoul(argv[1], NULL);
+		cnt =3D hextoul(argv[2], NULL);
+	} else {
+		return CMD_RET_USAGE;
+	}
+
 	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
@@ -1270,7 +1277,7 @@ U_BOOT_CMD(
 #if CONFIG_IS_ENABLED(CMD_MMC_SWRITE)
 	"mmc swrite addr blk#\n"
 #endif
-	"mmc erase blk# cnt\n"
+	"mmc erase blk# cnt | partname\n"
 	"mmc rescan [mode]\n"
 	"mmc part - lists available partition on current mmc device\n"
 	"mmc dev [dev] [part] [mode] - show or set current mmc device [partition=
] and set mode\n"
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 5a64400..b919b75 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -14,7 +14,7 @@ Synopsis
     mmc info
     mmc read addr blk# cnt
     mmc write addr blk# cnt
-    mmc erase blk# cnt
+    mmc erase blk# cnt | partname
     mmc rescan [mode]
     mmc part
     mmc dev [dev] [part] [mode]
@@ -50,6 +50,8 @@ The 'mmc erase' command erases *cnt* blocks on the MMC d=
evice starting at block
         start block offset
     cnt
         block count
+    partname
+        partition name
 
 The 'mmc rescan' command scans the available MMC device.
 
-- 
2.7.4
 
