Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D434F327C4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C150843D0;
	Tue, 21 Apr 2026 10:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ZXjTDxp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139A18431E; Tue, 21 Apr 2026 10:36:38 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64F0843D0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 31817aa43d5d11f19781c1a04af40193-20260421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=QGh+AnS/nRumtmvWscjF93LhjDb2uwmcHElzgJxDZ90=; 
 b=ZXjTDxp7FQKbp3EsNCIB6hHwPc4aVjQPkjPdI8usruNkgDFqExZCGSFbuV3XxRC+eCLPIwCixP9jvkYDwNzc0srStdWgOtiQxkSA/LLdi/FTHug7xwW7f2VdK8bZqp4U7T2YqtmQQn3GxjibOYc/mxSygUkOP9QkzPjcASfx7jQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:81f14078-d14a-4622-870e-fbe9d867feff, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:65123095-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 31817aa43d5d11f19781c1a04af40193-20260421
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1478945140; Tue, 21 Apr 2026 16:36:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 21 Apr 2026 16:36:28 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 21 Apr 2026 16:36:27 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 5/8] cmd: ubi: reorganize command messages
Date: Tue, 21 Apr 2026 16:36:24 +0800
Message-ID: <fd67a0a7da68717a551f6c6153b56c8719fe2022.1776759754.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1776759754.git.weijie.gao@mediatek.com>
References: <cover.1776759754.git.weijie.gao@mediatek.com>
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
output.

A new function ubi_require_volume() is added for finding and printing error
message if volume not found. The original ubi_find_volume() will be silent
for being an api function.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: new
---
 cmd/ubi.c | 92 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 27 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 8e3cfaaddbb..f2ae63e6a7a 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -241,8 +241,7 @@ static int ubi_create_vol(const char *volume, int64_t size, int dynamic,
 		printf("verify_mkvol_req failed %d\n", err);
 		return err;
 	}
-	printf("Creating %s volume %s of size %lld\n",
-		dynamic ? "dynamic" : "static", volume, size);
+
 	/* Call real ubi create volume */
 	return ubi_create_volume(ubi, &req);
 }
@@ -258,10 +257,19 @@ static struct ubi_volume *ubi_find_volume(const char *volume)
 			return vol;
 	}
 
-	printf("Volume %s not found!\n", volume);
 	return NULL;
 }
 
+static struct ubi_volume *ubi_require_volume(const char *volume)
+{
+	struct ubi_volume *vol = ubi_find_volume(volume);
+
+	if (!vol)
+		printf("Volume %s not found!\n", volume);
+
+	return vol;
+}
+
 static int ubi_remove_vol(const char *volume)
 {
 	int err, reserved_pebs, i;
@@ -271,8 +279,6 @@ static int ubi_remove_vol(const char *volume)
 	if (vol == NULL)
 		return ENODEV;
 
-	printf("Remove UBI volume %s (id %d)\n", vol->name, vol->vol_id);
-
 	if (ubi->ro_mode) {
 		printf("It's read-only mode\n");
 		err = EROFS;
@@ -334,8 +340,6 @@ static int ubi_rename_vol(const char *oldname, const char *newname)
 		return EINVAL;
 	}
 
-	printf("Rename UBI volume %s to %s\n", oldname, newname);
-
 	if (ubi->ro_mode) {
 		printf("%s: ubi device is in read-only mode\n", __func__);
 		return EROFS;
@@ -360,7 +364,7 @@ static int ubi_volume_continue_write(const char *volume, const void *buf,
 	int err;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (vol == NULL)
 		return ENODEV;
 
@@ -402,7 +406,7 @@ int ubi_volume_begin_write(const char *volume, const void *buf, size_t size,
 	int rsvd_bytes;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (vol == NULL)
 		return ENODEV;
 
@@ -434,7 +438,7 @@ static int ubi_volume_offset_write(const char *volume, const void *buf,
 	loff_t off = offset;
 	void *tbuf;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (!vol)
 		return -ENODEV;
 
@@ -514,7 +518,7 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 	loff_t offp = offset;
 	size_t len_read;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (vol == NULL)
 		return ENODEV;
 
@@ -534,8 +538,6 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 		size = vol->used_bytes;
 	}
 
-	printf("Read %zu bytes from volume %s to %p\n", size, volume, buf);
-
 	if (vol->corrupted)
 		printf("read from corrupted volume %d", vol->vol_id);
 	if (offp + size > vol->used_bytes)
@@ -619,13 +621,10 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	struct ubi_vtbl_record vtbl_rec;
 	struct ubi_volume *vol;
 
-	vol = ubi_find_volume(volume);
+	vol = ubi_require_volume(volume);
 	if (!vol)
 		return ENODEV;
 
-	printf("%sing skip_check on volume %s\n",
-	       skip_check ? "Sett" : "Clear", volume);
-
 	vtbl_rec = ubi->vtbl[vol->vol_id];
 	if (skip_check) {
 		vtbl_rec.flags |= UBI_VTBL_SKIP_CRC_CHECK_FLG;
@@ -698,6 +697,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int64_t size;
 	ulong addr = 0;
 	bool skipcheck = false;
+	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -806,31 +806,63 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 		/* E.g., create volume */
 		if (argc == 3) {
-			return ubi_create_vol(argv[2], size, dynamic, id,
-					      skipcheck);
+			ret = ubi_create_vol(argv[2], size, dynamic, id,
+					     skipcheck);
+			if (!ret)
+				printf("Created %s volume %s of size %lld\n",
+				       dynamic ? "dynamic" : "static", argv[2],
+				       size);
+			else if (ret == -EEXIST)
+				printf("Volume %s already exists!\n", argv[2]);
+
+			return ret;
 		}
 	}
 
 	if (strncmp(argv[1], "remove", 6) == 0) {
 		/* E.g., remove volume */
-		if (argc == 3)
-			return ubi_remove_vol(argv[2]);
+		if (argc == 3) {
+			struct ubi_volume *vol;
+
+			vol = ubi_find_volume(argv[2]);
+			if (!vol)
+				return 0;
+
+			ret = ubi_remove_vol(argv[2]);
+			if (!ret) {
+				printf("Removed UBI volume %s (id %d)\n",
+				       vol->name, vol->vol_id);
+			}
+
+			return ret;
+		}
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], "rename", 6))
-		return ubi_rename_vol(argv[2], argv[3]);
+	if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], "rename", 6)) {
+		ret = ubi_rename_vol(argv[2], argv[3]);
+		if (!ret) {
+			printf("UBI volume %s renamed to %s\n", argv[2],
+			       argv[3]);
+		}
+
+		return ret;
+	}
 
 	if (strncmp(argv[1], "skipcheck", 9) == 0) {
 		/* E.g., change skip_check flag */
 		if (argc == 4) {
 			skipcheck = strncmp(argv[3], "on", 2) == 0;
-			return ubi_set_skip_check(argv[2], skipcheck);
+			ret = ubi_set_skip_check(argv[2], skipcheck);
+			if (!ret) {
+				printf("%s skip_check on volume %s\n",
+				       skipcheck ? "Set" : "Cleared", argv[2]);
+			}
+
+			return ret;
 		}
 	}
 
 	if (strncmp(argv[1], "write", 5) == 0) {
-		int ret;
-
 		if (argc < 5) {
 			printf("Please see usage\n");
 			return 1;
@@ -877,7 +909,13 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			return ubi_volume_read(argv[3], (void *)addr, 0, size);
+			ret = ubi_volume_read(argv[3], (void *)addr, 0, size);
+			if (!ret) {
+				printf("%lld bytes read from volume %s to 0x%lx\n",
+				       size, argv[3], addr);
+			}
+
+			return ret;
 		}
 	}
 
-- 
2.45.2

