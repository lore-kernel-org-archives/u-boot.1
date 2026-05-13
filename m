Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7262ECD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0398469F;
	Wed, 13 May 2026 10:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YdWYU3kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEC68341A; Wed, 13 May 2026 10:03:09 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81B58056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 291bb1ee4ea211f1a3561939bc42ff46-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=9leD5TvqRSurkMaXx2dF8m6izEcY/vXBwOny09WVy8U=; 
 b=YdWYU3kcTKC1VNJ5Axdl2New0tc5XjL7B0jAGD/N4Fmp5/RP1Le0bA79mWrmwi2q7KGd1r1zMUsFw6uYqY0GG7Kib1zOjfCc+SAxZvHXF08Zg35oCE+J4muKsnHApX2w3d5OsVwagNwTfHPrBPqF6jPqsMjX53/kbTUCsJ9wgBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:5674359f-3534-4767-9a39-e9156291e320, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:9091e75, CLOUDID:5c18c643-11c5-46fd-96b8-8ddde212c99a,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:5,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 291bb1ee4ea211f1a3561939bc42ff46-20260513
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1504721894; Wed, 13 May 2026 16:03:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 13 May 2026 16:02:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 13 May 2026 16:02:58 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 07/10] cmd: ubi: reorganize command messages
Date: Wed, 13 May 2026 16:02:58 +0800
Message-ID: <1b513aa72b3f4db27d752c8f9f734d4e2cf8d71d.1778657347.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1778657347.git.weijie.gao@mediatek.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch moves normal subcommand messages into the main command function.
This will allow current and potential api functions being called with clean
output on success.

A new function ubi_require_volume() is added for finding and printing error
message if volume not found. The original ubi_find_volume() will be silent
for being an api function.

To avoid ubi_require_volume() being called twice for volume read/remove,
some changes are required:
- The parameter of ubi_remove_vol() is changed to accept
'struct ubi_volume *' directly.
- The original ubi_volume_read() is renamed to __ubi_volume_read, with its
  first parameter changed to accept also 'struct ubi_volume *' directly.
- A new ubi_volume_read() is added to wraps __ubi_volume_read() to accept
  volume name as its first parameter.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v4: Make error message always be printed in both command and api calls.
    Avoid duplicated call to ubi_require_volume().
    Add parameter check for "ubi rename" subcommand.
v3: Fix use-after-free and "ubi read" command message displaying error
v2: new
---
 cmd/ubi.c | 118 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 38 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 23b846f22ce..b0b513cfe53 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -241,8 +241,7 @@ static int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
 		printf("verify_mkvol_req failed %d\n", err);
 		return err;
 	}
-	printf("Creating %s volume %s of size %lld\n",
-		dynamic ? "dynamic" : "static", volume, size);
+
 	/* Call real ubi create volume */
 	return ubi_create_volume(ubi, &req);
 }
@@ -258,20 +257,22 @@ static struct ubi_volume *ubi_find_volume(const char *volume)
 			return vol;
 	}
 
-	printf("Volume %s not found!\n", volume);
 	return NULL;
 }
 
-static int ubi_remove_vol(const char *volume)
+static struct ubi_volume *ubi_require_volume(const char *volume)
 {
-	int err, reserved_pebs, i;
-	struct ubi_volume *vol;
+	struct ubi_volume *vol = ubi_find_volume(volume);
 
-	vol = ubi_find_volume(volume);
-	if (vol == NULL)
-		return -ENODEV;
+	if (!vol)
+		printf("Volume %s not found!\n", volume);
+
+	return vol;
+}
 
-	printf("Remove UBI volume %s (id %d)\n", vol->name, vol->vol_id);
+static int ubi_remove_vol(struct ubi_volume *vol)
+{
+	int err, reserved_pebs, i;
 
 	if (ubi->ro_mode) {
 		printf("It's read-only mode\n");
@@ -310,7 +311,7 @@ static int ubi_remove_vol(const char *volume)
 
 	return 0;
 out_err:
-	ubi_err(ubi, "cannot remove volume %s, error %d", volume, err);
+	ubi_err(ubi, "cannot remove volume %s, error %d", vol->name, err);
 	return err;
 }
 
@@ -321,19 +322,15 @@ static int ubi_rename_vol(const char *oldname, const char *newname)
 	struct ubi_volume_desc desc;
 	struct list_head list;
 
-	vol = ubi_find_volume(oldname);
-	if (!vol) {
-		printf("%s: volume %s doesn't exist\n", __func__, oldname);
+	vol = ubi_require_volume(oldname);
+	if (!vol)
 		return -ENODEV;
-	}
 
 	if (!ubi_check(newname)) {
 		printf("%s: volume %s already exist\n", __func__, newname);
 		return -EINVAL;
 	}
 
-	printf("Rename UBI volume %s to %s\n", oldname, newname);
-
 	if (ubi->ro_mode) {
 		printf("%s: ubi device is in read-only mode\n", __func__);
 		return -EROFS;
@@ -358,7 +355,7 @@ static int ubi_volume_continue_write(const char *volume, const void *buf,
 	int err;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (vol == NULL)
 		return -ENODEV;
 
@@ -400,7 +397,7 @@ int ubi_volume_begin_write(const char *volume, const void *buf, size_t size,
 	int rsvd_bytes;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (vol == NULL)
 		return -ENODEV;
 
@@ -432,7 +429,7 @@ static int ubi_volume_offset_write(const char *volume, const void *buf,
 	loff_t off = offset;
 	void *tbuf;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (!vol)
 		return -ENODEV;
 
@@ -503,19 +500,15 @@ int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 	return ret;
 }
 
-int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
+static int __ubi_volume_read(struct ubi_volume *vol, void *buf, loff_t offset,
+			     size_t size)
 {
 	int err, lnum, off, len, tbuf_size;
 	void *tbuf;
 	unsigned long long tmp;
-	struct ubi_volume *vol;
 	loff_t offp = offset;
 	size_t len_read;
 
-	vol = ubi_find_volume(volume);
-	if (vol == NULL)
-		return -ENODEV;
-
 	if (vol->updating) {
 		printf("updating");
 		return -EBUSY;
@@ -527,12 +520,8 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 	if (offp == vol->used_bytes)
 		return 0;
 
-	if (size == 0) {
-		printf("No size specified -> Using max size (%lld)\n", vol->used_bytes);
+	if (size == 0)
 		size = vol->used_bytes;
-	}
-
-	printf("Read %zu bytes from volume %s to %p\n", size, volume, buf);
 
 	if (vol->corrupted)
 		printf("read from corrupted volume %d", vol->vol_id);
@@ -586,6 +575,17 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 	return err;
 }
 
+int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
+{
+	struct ubi_volume *vol;
+
+	vol = ubi_require_volume(volume);
+	if (!vol)
+		return -ENODEV;
+
+	return __ubi_volume_read(vol, buf, offset, size);
+}
+
 static int ubi_dev_scan(const struct mtd_info *info,
 			const char *vid_header_offset)
 {
@@ -616,13 +616,10 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	struct ubi_vtbl_record vtbl_rec;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (!vol)
 		return -ENODEV;
 
-	printf("%sing skip_check on volume %s\n",
-	       skip_check ? "Sett" : "Clear", volume);
-
 	vtbl_rec = ubi->vtbl[vol->vol_id];
 	if (skip_check) {
 		vtbl_rec.flags |= UBI_VTBL_SKIP_CRC_CHECK_FLG;
@@ -695,6 +692,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int64_t size;
 	ulong addr = 0;
 	bool skipcheck = false;
+	struct ubi_volume *vol;
 	int ret;
 
 	if (argc < 2)
@@ -803,7 +801,9 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		/* Use maximum available size */
 		if (!size) {
 			size = (int64_t)ubi->avail_pebs * ubi->leb_size;
-			printf("No size specified -> Using max size (%lld)\n", size);
+			if (size)
+				printf("No size specified -> Using max size (%lld)\n",
+				       size);
 		}
 		/* E.g., create volume */
 		if (argc == 3) {
@@ -811,6 +811,10 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 					     skipcheck);
 			if (ret)
 				return CMD_RET_FAILURE;
+
+			printf("Created %s volume %s of size %lld\n",
+			       dynamic ? "dynamic" : "static", argv[2], size);
+
 			return 0;
 		}
 	}
@@ -818,17 +822,37 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (strncmp(argv[1], "remove", 6) == 0) {
 		/* E.g., remove volume */
 		if (argc == 3) {
-			ret = ubi_remove_vol(argv[2]);
+			int vol_id;
+
+			vol = ubi_require_volume(argv[2]);
+			if (!vol)
+				return CMD_RET_FAILURE;
+
+			vol_id = vol->vol_id;
+
+			ret = ubi_remove_vol(vol);
 			if (ret)
 				return CMD_RET_FAILURE;
+
+			printf("Removed UBI volume %s (id %d)\n", argv[2],
+			       vol_id);
+
 			return 0;
 		}
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], "rename", 6)) {
+		if (argc < 4) {
+			printf("Please see usage\n");
+			return CMD_RET_USAGE;
+		}
+
 		ret = ubi_rename_vol(argv[2], argv[3]);
 		if (ret)
 			return CMD_RET_FAILURE;
+
+		printf("UBI volume %s renamed to %s\n", argv[2], argv[3]);
+
 		return 0;
 	}
 
@@ -839,6 +863,10 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			ret = ubi_set_skip_check(argv[2], skipcheck);
 			if (ret)
 				return CMD_RET_FAILURE;
+
+			printf("%s skip_check on volume %s\n",
+			       skipcheck ? "Set" : "Cleared", argv[2]);
+
 			return 0;
 		}
 	}
@@ -892,9 +920,23 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			ret = ubi_volume_read(argv[3], (void *)addr, 0, size);
+			vol = ubi_require_volume(argv[3]);
+			if (!vol)
+				return CMD_RET_FAILURE;
+
+			if (!size) {
+				printf("No size specified -> Using max size (%lld)\n",
+				       vol->used_bytes);
+				size = vol->used_bytes;
+			}
+
+			ret = __ubi_volume_read(vol, (void *)addr, 0, size);
 			if (ret)
 				return CMD_RET_FAILURE;
+
+			printf("%lld bytes read from volume %s to 0x%lx\n",
+			       size, argv[3], addr);
+
 			return 0;
 		}
 	}
-- 
2.45.2

