Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3360FF327C5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F025C843D0;
	Tue, 21 Apr 2026 10:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="sZ7eMoEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13970843D0; Tue, 21 Apr 2026 10:36:07 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8BB84258
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 208f924e3d5d11f19781c1a04af40193-20260421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=F1CrNi9d4LICXUjYecQzq9uml4IyXCLWmFgP9kaEoOA=; 
 b=sZ7eMoEG+jHgKA8fKM87hv9kjcM/K1StAx8UT2mNuXzBjCWZVVwa9W11XjFUhDgnBcUiPqAKYXe9eSdJbL9jSXAEdFwnjOLlWpfqPX2drkM8ID91JgL6vTQsDXEbvya7UjqoswBiDOAZiCedah9NStUnR+y5rGLETIvsDDxsKrk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:3191231e-745b-42e3-8e24-f7e1357c5d23, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:43103095-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 208f924e3d5d11f19781c1a04af40193-20260421
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 247255128; Tue, 21 Apr 2026 16:36:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 21 Apr 2026 16:35:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 21 Apr 2026 16:35:59 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 2/8] cmd: ubi: mark read-only function parameters with const
Date: Tue, 21 Apr 2026 16:35:56 +0800
Message-ID: <d58f3c216c5f64a11afa9ea3e32e543abab208f7.1776759754.git.weijie.gao@mediatek.com>
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

Parameters like part/volume name and buffer for writing are not being
modified by the callee functions and should be marked const.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: new
---
 cmd/ubi.c           | 41 ++++++++++++++++++++++-------------------
 include/ubi_uboot.h |  7 ++++---
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 93de6f3aea2..f75ceff11ee 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -39,7 +39,7 @@ static struct ubi_device *ubi;
 #include <ubifs_uboot.h>
 #endif
 
-static void display_volume_info(struct ubi_device *ubi)
+static void display_volume_info(const struct ubi_device *ubi)
 {
 	int i;
 
@@ -50,7 +50,7 @@ static void display_volume_info(struct ubi_device *ubi)
 	}
 }
 
-static void display_ubi_info(struct ubi_device *ubi)
+static void display_ubi_info(const struct ubi_device *ubi)
 {
 	ubi_msg("MTD device name:            \"%s\"", ubi->mtd->name);
 	ubi_msg("MTD device size:            %llu MiB", ubi->flash_size >> 20);
@@ -149,12 +149,12 @@ static int ubi_list(const char *var, int numeric)
 	return 0;
 }
 
-static int ubi_check_volumename(const struct ubi_volume *vol, char *name)
+static int ubi_check_volumename(const struct ubi_volume *vol, const char *name)
 {
 	return strcmp(vol->name, name);
 }
 
-static int ubi_check(char *name)
+static int ubi_check(const char *name)
 {
 	int i;
 
@@ -213,8 +213,8 @@ bad:
 	return err;
 }
 
-static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
-			  bool skipcheck)
+static int ubi_create_vol(const char *volume, int64_t size, int dynamic,
+			  int vol_id, bool skipcheck)
 {
 	struct ubi_mkvol_req req;
 	int err;
@@ -247,7 +247,7 @@ static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
 	return ubi_create_volume(ubi, &req);
 }
 
-static struct ubi_volume *ubi_find_volume(char *volume)
+static struct ubi_volume *ubi_find_volume(const char *volume)
 {
 	struct ubi_volume *vol;
 	int i;
@@ -262,7 +262,7 @@ static struct ubi_volume *ubi_find_volume(char *volume)
 	return NULL;
 }
 
-static int ubi_remove_vol(char *volume)
+static int ubi_remove_vol(const char *volume)
 {
 	int err, reserved_pebs, i;
 	struct ubi_volume *vol;
@@ -316,7 +316,7 @@ out_err:
 	return err;
 }
 
-static int ubi_rename_vol(char *oldname, char *newname)
+static int ubi_rename_vol(const char *oldname, const char *newname)
 {
 	struct ubi_volume *vol;
 	struct ubi_rename_entry rename;
@@ -354,7 +354,8 @@ static int ubi_rename_vol(char *oldname, char *newname)
 	return ubi_rename_volumes(ubi, &list);
 }
 
-static int ubi_volume_continue_write(char *volume, void *buf, size_t size)
+static int ubi_volume_continue_write(const char *volume, const void *buf,
+				     size_t size)
 {
 	int err;
 	struct ubi_volume *vol;
@@ -394,8 +395,8 @@ static int ubi_volume_continue_write(char *volume, void *buf, size_t size)
 	return 0;
 }
 
-int ubi_volume_begin_write(char *volume, void *buf, size_t size,
-	size_t full_size)
+int ubi_volume_begin_write(const char *volume, const void *buf, size_t size,
+			   size_t full_size)
 {
 	int err;
 	int rsvd_bytes;
@@ -424,8 +425,8 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 	return ubi_volume_continue_write(volume, buf, size);
 }
 
-static int ubi_volume_offset_write(char *volume, void *buf, loff_t offset,
-				   size_t size)
+static int ubi_volume_offset_write(const char *volume, const void *buf,
+				   loff_t offset, size_t size)
 {
 	int len, tbuf_size, ret;
 	u64 lnum;
@@ -487,7 +488,8 @@ exit:
 	return ret;
 }
 
-int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
+int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
+		     size_t size)
 {
 	int ret;
 
@@ -503,7 +505,7 @@ int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
 	return ret;
 }
 
-int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
+int ubi_volume_read(const char *volume, char *buf, loff_t offset, size_t size)
 {
 	int err, lnum, off, len, tbuf_size;
 	void *tbuf;
@@ -587,7 +589,8 @@ int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
 	return err;
 }
 
-static int ubi_dev_scan(struct mtd_info *info, const char *vid_header_offset)
+static int ubi_dev_scan(const struct mtd_info *info,
+			const char *vid_header_offset)
 {
 	char ubi_mtd_param_buffer[80];
 	int err;
@@ -611,7 +614,7 @@ static int ubi_dev_scan(struct mtd_info *info, const char *vid_header_offset)
 	return 0;
 }
 
-static int ubi_set_skip_check(char *volume, bool skip_check)
+static int ubi_set_skip_check(const char *volume, bool skip_check)
 {
 	struct ubi_vtbl_record vtbl_rec;
 	struct ubi_volume *vol;
@@ -658,7 +661,7 @@ static int ubi_detach(void)
 	return 0;
 }
 
-int ubi_part(char *part_name, const char *vid_header_offset)
+int ubi_part(const char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
 	int err;
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 05fb9634d81..a949d1b80dd 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -47,9 +47,10 @@
 int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 int ubi_init(void);
 void ubi_exit(void);
-int ubi_part(char *part_name, const char *vid_header_offset);
-int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
-int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
+int ubi_part(const char *part_name, const char *vid_header_offset);
+int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
+		     size_t size);
+int ubi_volume_read(const char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.45.2

