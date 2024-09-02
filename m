Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C1CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D0A88754;
	Mon,  2 Sep 2024 20:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="l6iCNQqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD2288754; Mon,  2 Sep 2024 20:00:49 +0200 (CEST)
Received: from mxe-1-50f.seznam.cz (mxe-1-50f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:50f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B079886DF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 20:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-6f7b5db655-grmdl
 (smtpc-mxe-6f7b5db655-grmdl [2a02:598:128:8a00::1000:50f])
 id 125a9fc9ecae2d6312d411d1; Mon, 02 Sep 2024 20:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1725300046;
 bh=SXbz4kT3B2EZhAeNVCZaw8wa2iW2Ip57kPzt0JpYbCM=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=l6iCNQqQ28Ey99tRuPk40VBVRMuz5gwjezxPyDz700sv7SAh3/WLyWYdA70qpW4ye
 s6Y5aLJo9CdiHTBtW2F+w9RAZtogqmGae7i14evWGjadYsfRzuFJeIwsV+wZdNpnBW
 9NPEvapLE7kYrVyj/dJfRiPTCyKTomKtQ69OhdiftCINjjG7YNGa0h9HzUeNCa+cHB
 vXyUkgCgZsRYrHpgfxF/agXeLI2izyoxtYxCzpoXKsvMyrujjFPjSXHiPrpQg7oz73
 lwAgQxdoYgbORU5SuU3ytoQsGQcAau2BQXgDRDb8rgMOVXeWKFRSFNbZkhYcPVDJX9
 h+cYFiD/vcGDA==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Mon, 02 Sep 2024 20:00:43 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>
Subject: =?utf-8?q?=5BPATCH_v2=5D_cmd=3A_mmc=3A_Allow_using_partition_name?=
 =?utf-8?q?_in_mmc_erase_command_?=
Date: Mon, 02 Sep 2024 20:00:43 +0200 (CEST)
Message-Id: <3fG.Zblj.WuvIm1nVob.1crVrB@seznam.cz>
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
which can be obtained using the part start and part size commands
if the entire partition needs to be erased.

Simplify the use of the mmc erase command by allowing the partition
name to be specified directly.
---
 cmd/mmc.c             | 17 +++++++++++++----
 doc/usage/cmd/mmc.rst |  6 +++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 7244a90..2fc05f9 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -472,18 +472,26 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int f=
lag,
 			int argc, char *const argv[])
 {
 	struct mmc *mmc;
+	struct disk_partition info;
 	u32 blk, cnt, n;
 
-	if (argc !=3D 3)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-	blk =3D hextoul(argv[1], NULL);
-	cnt =3D hextoul(argv[2], NULL);
-
 	mmc =3D init_mmc_device(curr_device, false);
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
+	if (argc =3D=3D 3) {
+		blk =3D hextoul(argv[1], NULL);
+		cnt =3D hextoul(argv[2], NULL);
+	} else if (part_get_info_by_name(mmc_get_blk_desc(mmc), argv[1], &info) =
>=3D 0) {
+		blk =3D info.start;
+		cnt =3D info.size;
+	} else {
+		return CMD_RET_FAILURE;
+	}
+
 	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
@@ -1271,6 +1279,7 @@ U_BOOT_CMD(
 	"mmc swrite addr blk#\n"
 #endif
 	"mmc erase blk# cnt\n"
+	"mmc erase partname\n"
 	"mmc rescan [mode]\n"
 	"mmc part - lists available partition on current mmc device\n"
 	"mmc dev [dev] [part] [mode] - show or set current mmc device [partition=
] and set mode\n"
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 5a64400..55391fd 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -15,6 +15,7 @@ Synopsis
     mmc read addr blk# cnt
     mmc write addr blk# cnt
     mmc erase blk# cnt
+    mmc erase partname
     mmc rescan [mode]
     mmc part
     mmc dev [dev] [part] [mode]
@@ -44,12 +45,15 @@ The 'mmc write' command writes raw data to MMC device =
from memory address with b
     cnt
         block count
 
-The 'mmc erase' command erases *cnt* blocks on the MMC device starting at=
 block *blk#*.
+The 'mmc erase' command erases *cnt* blocks on the MMC device starting at=
 block *blk#* or
+the entire partition specified by *partname*.
 
     blk#
         start block offset
     cnt
         block count
+    partname
+        partition name
 
 The 'mmc rescan' command scans the available MMC device.
 
-- 
2.7.4
 
