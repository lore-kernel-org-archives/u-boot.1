Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D00CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECA2846B0;
	Wed, 20 May 2026 10:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nZXrUWOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3170844CF; Wed, 20 May 2026 10:27:47 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EA7803C6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c474ede4542511f1b5a00d44d12bea5a-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=cyvmz1xAghMIqdgfhSpIvwDsoz2d7dKP4d+Do9mkDX4=; 
 b=nZXrUWOgmkoqRWkkLeJoQT6ALLudORia+Uu7YFJmodtoWK+R6He+Ku2c/KGHrWHFJfJbrdofqMYCdDE2GMj72fMP8Up4SfP2bFrg1bUzwJLLykW4jr043zS4pm6amjsav8WTBd7hwjXD/jwOXEu8e7SDgxQqEBV6eyWeptmNBAc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:bbd7a054-d5e6-4dc2-ac0d-16fff4dc01ee, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:9091e75, CLOUDID:462b2946-e650-4d81-a877-d298d8f44b5d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c474ede4542511f1b5a00d44d12bea5a-20260520
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 874353733; Wed, 20 May 2026 16:27:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 16:27:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 16:27:39 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 08/10] cmd: ubi: export more APIs to public
Date: Wed, 20 May 2026 16:27:38 +0800
Message-ID: <2b20e34e946ae4b243170b7b995402aea7bbc41b.1779263662.git.weijie.gao@mediatek.com>
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

Export the following functions to public:

- ubi_detach(): this is paired with ubi_part(). One may call this function
  to completely clean up the ubi subsystem after using ubi_part().

- ubi_{create,find,remove}_vol: this is a set of functions for volume
  management.

The original ubi_remove_vol is renamed to __ubi_remove_vol to allow the new
ubi_remove_vol() being used as a wrapper for __ubi_remove_vol() with volume
name.

Also, comments are added for all exported functions.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v5: updated commit message
    updated description for ubi_part()
v4: squashed api function comments into this patch.
    make ubi_remove_vol() as a wrapper of __ubi_remove_vol() due to changes
     of previous patch.
v3: updated commit message
v2: not changed
---
 cmd/ubi.c           | 23 +++++++++---
 include/ubi_uboot.h | 91 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 04616d49fac..eea863ac303 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -213,8 +213,8 @@ bad:
 	return err;
 }
 
-static int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
-			  int vol_id, bool skipcheck)
+int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
+		   bool skipcheck)
 {
 	struct ubi_mkvol_req req;
 	int err;
@@ -246,7 +246,7 @@ static int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
 	return ubi_create_volume(ubi, &req);
 }
 
-static struct ubi_volume *ubi_find_volume(const char *volume)
+struct ubi_volume *ubi_find_volume(const char *volume)
 {
 	struct ubi_volume *vol;
 	int i;
@@ -270,7 +270,7 @@ static struct ubi_volume *ubi_require_volume(const char *volume)
 	return vol;
 }
 
-static int ubi_remove_vol(struct ubi_volume *vol)
+static int __ubi_remove_vol(struct ubi_volume *vol)
 {
 	int err, reserved_pebs, i;
 
@@ -315,6 +315,17 @@ out_err:
 	return err;
 }
 
+int ubi_remove_vol(const char *volume)
+{
+	struct ubi_volume *vol;
+
+	vol = ubi_require_volume(volume);
+	if (!vol)
+		return -ENODEV;
+
+	return __ubi_remove_vol(vol);
+}
+
 static int ubi_rename_vol(const char *oldname, const char *newname)
 {
 	struct ubi_volume *vol;
@@ -632,7 +643,7 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	return ubi_change_vtbl_record(ubi, vol->vol_id, &vtbl_rec);
 }
 
-static int ubi_detach(void)
+int ubi_detach(void)
 {
 #ifdef CONFIG_CMD_UBIFS
 	/*
@@ -828,7 +839,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 			vol_id = vol->vol_id;
 
-			ret = ubi_remove_vol(vol);
+			ret = __ubi_remove_vol(vol);
 			if (ret)
 				return CMD_RET_FAILURE;
 
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6ebd8a3b613..bdf5645de3d 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -47,11 +47,102 @@
 int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 int ubi_init(void);
 void ubi_exit(void);
+
+/**
+ * ubi_detach() - detach UBI from MTD partition
+ *
+ * This function performs the cleanup of the UBI subsystem to make sure the
+ * MTD partition can be safely used for another purpose, or be attached again
+ * with ubi_part().
+ *
+ * Any mounted UBIFS will be unmounted automatically.
+ *
+ * Return: 0
+ */
+int ubi_detach(void);
+
+/**
+ * ubi_part() - attach UBI to MTD partition
+ * @part_name: name of the MTD partition to attach
+ * @vid_header_offset: VID header offset (string)
+ *
+ * This function detaches any existing UBI device, then probes for the
+ * specified MTD partition, and then scans it to initialize UBI.
+ *
+ * @vid_header_offset is optional and is usually set to NULL.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
 int ubi_part(const char *part_name, const char *vid_header_offset);
+
+/**
+ * ubi_volume_write() - write data to UBI volume
+ * @volume: name of the volume to write to
+ * @buf: data buffer to be written
+ * @offset: start offset for writing
+ * @size: number of bytes to write
+ *
+ * This function writes data to the specific UBI volume. If the offset is zero,
+ * it initiates a full volume update. Otherwise, it performs an offset-based
+ * write using LEB changes.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
 int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 		     size_t size);
+
+/**
+ * ubi_volume_read() - read data from UBI volume
+ * @volume: name of the volume to read from
+ * @buf: buffer to hold the read data
+ * @offset: start offset for reading
+ * @size: number of bytes to read
+ *
+ * This function reads data from the specified UBI volume. If @size is zero,
+ * the function reads the entire volume content starting from @offset.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
 int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);
 
+/**
+ * ubi_create_vol() - create UBI volume
+ * @volume: name of the volume to create
+ * @size: size of the volume in bytes
+ * @dynamic: create dynamic volume if set to true
+ * @vol_id: volume ID
+ * @skipcheck: skip CRC check on this volume if set to true
+ *
+ * This function creates a new UBI volume with the specified parameters.
+ * If @size is negative, all available space will be used.
+ * For volume ID auto assignment, pass %UBI_VOL_NUM_AUTO to @vol_id.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
+int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
+		   bool skipcheck);
+
+/**
+ * ubi_find_volume() - find UBI volume by name
+ * @volume: name of the volume to find
+ *
+ * This function searches for a UBI volume with the specified name in the
+ * current UBI device.
+ *
+ * Return: pointer to the UBI volume structure, or %NULL if not found.
+ */
+struct ubi_volume *ubi_find_volume(const char *volume);
+
+/**
+ * ubi_remove_vol() - remove UBI volume
+ * @volume: name of the volume to remove
+ *
+ * This function removes an existing UBI volume from the current UBI device.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
+int ubi_remove_vol(const char *volume);
+
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(const char *vol_name);
 int cmd_ubifs_umount(void);
-- 
2.45.2

