Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B11ACD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCAC846FC;
	Wed, 20 May 2026 10:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QIRRazwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B31844CF; Wed, 20 May 2026 10:27:46 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA80846D0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c250e4b4542511f1a3561939bc42ff46-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=vxgJYDGw+mMMlsm4RRB3Egp3jlVnEnGUEG8tR65eL5s=; 
 b=QIRRazwDrY6i/OGLzfcFrkUia/S4iCWaUvmoIwzlK1KFAy7ynu6Zd+kMZssfpVT5VIO1UPt6PM09MhfcYAEXKghR+lfPhCN1kv/Gj8VODzzCGmbYWSzfghAsZScuqXnRFBmGHUIS8YSqQEyAkSV0G1lbkdsMVs34pSnQVnL0nE4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:163ac1ff-2a5e-4d45-a5c7-03115cc67d85, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:9091e75, CLOUDID:3203061f-023f-4f87-9e9c-6c116c694fb3,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c250e4b4542511f1a3561939bc42ff46-20260520
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1879549502; Wed, 20 May 2026 16:27:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 16:27:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 16:27:35 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 06/10] cmd: ubi: change all positive error return value to
 negative
Date: Wed, 20 May 2026 16:27:35 +0800
Message-ID: <9ee12a988333e229ce0664b4cac8bec8b5300340.1779263662.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1779263662.git.weijie.gao@mediatek.com>
References: <cover.1779263662.git.weijie.gao@mediatek.com>
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

Change all return value using errno codes to negative. This makes it
consistent with the linux ubi layer.

Also, to follow the standard definition of U-Boot command, in the do_ubi()
command handler, the return value is converted to CMD_RET_FAILURE for error
returning, and CMD_RET_USAGE for incorrect usage.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v5: change two paths returning CMD_RET_FAILURE to CMD_RET_USAGE
    return -ENODEV instead of PTR_ERR(mtd) in ubi_part()
    squash duplicated return statments into one line
v4: new
---
 cmd/ubi.c | 92 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 8d04ff61fb6..dd9cc45a977 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -172,7 +172,7 @@ static int ubi_check(const char *name)
 static int verify_mkvol_req(const struct ubi_device *ubi,
 			    const struct ubi_mkvol_req *req)
 {
-	int n, err = EINVAL;
+	int n, err = -EINVAL;
 
 	if (req->bytes < 0 || req->alignment < 0 || req->vol_type < 0 ||
 	    req->name_len < 0)
@@ -187,7 +187,7 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
 
 	if (req->bytes == 0) {
 		printf("No space left in UBI device!\n");
-		err = ENOMEM;
+		err = -ENOMEM;
 		goto bad;
 	}
 
@@ -204,7 +204,7 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
 
 	if (req->name_len > UBI_VOL_NAME_MAX) {
 		printf("Name too long!\n");
-		err = ENAMETOOLONG;
+		err = -ENAMETOOLONG;
 		goto bad;
 	}
 
@@ -269,13 +269,13 @@ static int ubi_remove_vol(const char *volume)
 
 	vol = ubi_find_volume(volume);
 	if (vol == NULL)
-		return ENODEV;
+		return -ENODEV;
 
 	printf("Remove UBI volume %s (id %d)\n", vol->name, vol->vol_id);
 
 	if (ubi->ro_mode) {
 		printf("It's read-only mode\n");
-		err = EROFS;
+		err = -EROFS;
 		goto out_err;
 	}
 
@@ -311,8 +311,6 @@ static int ubi_remove_vol(const char *volume)
 	return 0;
 out_err:
 	ubi_err(ubi, "cannot remove volume %s, error %d", volume, err);
-	if (err < 0)
-		err = -err;
 	return err;
 }
 
@@ -326,19 +324,19 @@ static int ubi_rename_vol(const char *oldname, const char *newname)
 	vol = ubi_find_volume(oldname);
 	if (!vol) {
 		printf("%s: volume %s doesn't exist\n", __func__, oldname);
-		return ENODEV;
+		return -ENODEV;
 	}
 
 	if (!ubi_check(newname)) {
 		printf("%s: volume %s already exist\n", __func__, newname);
-		return EINVAL;
+		return -EINVAL;
 	}
 
 	printf("Rename UBI volume %s to %s\n", oldname, newname);
 
 	if (ubi->ro_mode) {
 		printf("%s: ubi device is in read-only mode\n", __func__);
-		return EROFS;
+		return -EROFS;
 	}
 
 	rename.new_name_len = strlen(newname);
@@ -362,17 +360,17 @@ static int ubi_volume_continue_write(const char *volume, const void *buf,
 
 	vol = ubi_find_volume(volume);
 	if (vol == NULL)
-		return ENODEV;
+		return -ENODEV;
 
 	if (!vol->updating) {
 		printf("UBI volume update was not initiated\n");
-		return EINVAL;
+		return -EINVAL;
 	}
 
 	err = ubi_more_update_data(ubi, vol, buf, size);
 	if (err < 0) {
 		printf("Couldnt or partially wrote data\n");
-		return -err;
+		return err;
 	}
 
 	if (err) {
@@ -380,7 +378,7 @@ static int ubi_volume_continue_write(const char *volume, const void *buf,
 
 		err = ubi_check_volume(ubi, vol->vol_id);
 		if (err < 0)
-			return -err;
+			return err;
 
 		if (err) {
 			ubi_warn(ubi, "volume %d on UBI device %d is corrupt",
@@ -404,18 +402,18 @@ int ubi_volume_begin_write(const char *volume, const void *buf, size_t size,
 
 	vol = ubi_find_volume(volume);
 	if (vol == NULL)
-		return ENODEV;
+		return -ENODEV;
 
 	rsvd_bytes = vol->reserved_pebs * (ubi->leb_size - vol->data_pad);
 	if (size > rsvd_bytes) {
 		printf("size > volume size! Aborting!\n");
-		return EINVAL;
+		return -EINVAL;
 	}
 
 	err = ubi_start_update(ubi, vol, full_size);
 	if (err < 0) {
 		printf("Cannot start volume update\n");
-		return -err;
+		return err;
 	}
 
 	/* The volume is just wiped out */
@@ -516,15 +514,15 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 
 	vol = ubi_find_volume(volume);
 	if (vol == NULL)
-		return ENODEV;
+		return -ENODEV;
 
 	if (vol->updating) {
 		printf("updating");
-		return EBUSY;
+		return -EBUSY;
 	}
 	if (vol->upd_marker) {
 		printf("damaged volume, update marker is set");
-		return EBADF;
+		return -EBADF;
 	}
 	if (offp == vol->used_bytes)
 		return 0;
@@ -547,7 +545,7 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 	tbuf = malloc_cache_aligned(tbuf_size);
 	if (!tbuf) {
 		printf("NO MEM\n");
-		return ENOMEM;
+		return -ENOMEM;
 	}
 	len = size > tbuf_size ? tbuf_size : size;
 
@@ -563,7 +561,6 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 		err = ubi_eba_read_leb(ubi, vol, lnum, tbuf, off, len, 0);
 		if (err) {
 			printf("read err %x\n", err);
-			err = -err;
 			break;
 		}
 		off += len;
@@ -603,13 +600,13 @@ static int ubi_dev_scan(const struct mtd_info *info,
 
 	err = ubi_mtd_param_parse(ubi_mtd_param_buffer, NULL);
 	if (err)
-		return -err;
+		return err;
 
 	led_activity_blink();
 	err = ubi_init();
 	led_activity_off();
 	if (err)
-		return -err;
+		return err;
 
 	return 0;
 }
@@ -621,7 +618,7 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 
 	vol = ubi_find_volume(volume);
 	if (!vol)
-		return ENODEV;
+		return -ENODEV;
 
 	printf("%sing skip_check on volume %s\n",
 	       skip_check ? "Sett" : "Clear", volume);
@@ -677,7 +674,7 @@ int ubi_part(const char *part_name, const char *vid_header_offset)
 	mtd = get_mtd_device_nm(part_name);
 	if (IS_ERR(mtd)) {
 		printf("Partition %s not found!\n", part_name);
-		return 1;
+		return -ENODEV;
 	}
 	put_mtd_device(mtd);
 
@@ -698,6 +695,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int64_t size;
 	ulong addr = 0;
 	bool skipcheck = false;
+	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -712,7 +710,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		if (argc == 2) {
 			if (!ubi) {
 				printf("Error, no UBI device selected!\n");
-				return 1;
+				return CMD_RET_FAILURE;
 			}
 
 			printf("Device %d: %s, MTD partition %s\n",
@@ -726,12 +724,13 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		if (argc > 3)
 			vid_header_offset = argv[3];
 
-		return ubi_part(argv[2], vid_header_offset);
+		ret = ubi_part(argv[2], vid_header_offset);
+		return ret ? CMD_RET_FAILURE : 0;
 	}
 
 	if ((strcmp(argv[1], "part") != 0) && !ubi) {
 		printf("Error, no UBI device selected!\n");
-		return 1;
+		return CMD_RET_FAILURE;
 	}
 
 	if (strcmp(argv[1], "info") == 0) {
@@ -761,7 +760,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return ubi_check(argv[2]);
 
 		printf("Error, no volume name passed\n");
-		return 1;
+		return CMD_RET_USAGE;
 	}
 
 	if (strncmp(argv[1], "create", 6) == 0) {
@@ -789,7 +788,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 				dynamic = false;
 			else if (strncmp(argv[4], "d", 1) != 0) {
 				printf("Incorrect type\n");
-				return 1;
+				return CMD_RET_USAGE;
 			}
 			argc--;
 		}
@@ -806,34 +805,38 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 		/* E.g., create volume */
 		if (argc == 3) {
-			return ubi_create_vol(argv[2], size, dynamic, id,
-					      skipcheck);
+			ret = ubi_create_vol(argv[2], size, dynamic, id,
+					     skipcheck);
+			return ret ? CMD_RET_FAILURE : 0;
 		}
 	}
 
 	if (strncmp(argv[1], "remove", 6) == 0) {
 		/* E.g., remove volume */
-		if (argc == 3)
-			return ubi_remove_vol(argv[2]);
+		if (argc == 3) {
+			ret = ubi_remove_vol(argv[2]);
+			return ret ? CMD_RET_FAILURE : 0;
+		}
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], "rename", 6))
-		return ubi_rename_vol(argv[2], argv[3]);
+	if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], "rename", 6)) {
+		ret = ubi_rename_vol(argv[2], argv[3]);
+		return ret ? CMD_RET_FAILURE : 0;
+	}
 
 	if (strncmp(argv[1], "skipcheck", 9) == 0) {
 		/* E.g., change skip_check flag */
 		if (argc == 4) {
 			skipcheck = strncmp(argv[3], "on", 2) == 0;
-			return ubi_set_skip_check(argv[2], skipcheck);
+			ret = ubi_set_skip_check(argv[2], skipcheck);
+			return ret ? CMD_RET_FAILURE : 0;
 		}
 	}
 
 	if (strncmp(argv[1], "write", 5) == 0) {
-		int ret;
-
 		if (argc < 5) {
 			printf("Please see usage\n");
-			return 1;
+			return CMD_RET_USAGE;
 		}
 
 		addr = hextoul(argv[2], NULL);
@@ -858,7 +861,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			       argv[3]);
 		}
 
-		return ret;
+		return ret ? CMD_RET_FAILURE : 0;
 	}
 
 	if (strncmp(argv[1], "read", 4) == 0) {
@@ -877,12 +880,13 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			return ubi_volume_read(argv[3], (void *)addr, 0, size);
+			ret = ubi_volume_read(argv[3], (void *)addr, 0, size);
+			return ret ? CMD_RET_FAILURE : 0;
 		}
 	}
 
 	printf("Please see usage\n");
-	return 1;
+	return CMD_RET_USAGE;
 }
 
 U_BOOT_CMD(
-- 
2.45.2

