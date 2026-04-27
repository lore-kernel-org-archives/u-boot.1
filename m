Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518A4FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE0184277;
	Mon, 27 Apr 2026 09:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="SNeyV3mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA0984277; Mon, 27 Apr 2026 09:09:47 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E598842CE
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0f328e8e420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=yX0nsLzNVHpylOhfWa0NxbWXIBSya3SxZxsin8XWULQ=; 
 b=SNeyV3mbz9F2oUMfgTE4eJOpqwp8ybwkpUquCpfMN4hGQR4bp6NKS5TMXUuDaWZ9KxosddsK7jqXSJx4mXlhqD53aQgumrYtwoNPAWBRl0RUel2ajCuPRZ8HeDoI25Ot0iky99dS1yfqyCZ61elUvFnEpdfys0iSZOhm5RE8bXo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9e4b361b-7855-46c3-8851-458ce499f9f9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:b2cda764-469e-4eb6-aeb8-4b21454b0f32,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0f328e8e420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1941246627; Mon, 27 Apr 2026 15:09:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:38 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 09/10] ubi: add comments for exported ubi API functions
Date: Mon, 27 Apr 2026 15:09:37 +0800
Message-ID: <dd48da7aa5d821b56528824bfd4b57e014947a03.1777272283.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1777272283.git.weijie.gao@mediatek.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
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

This patch adds comments for exported ubi command API functions.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v3: new
---
 include/ubi_uboot.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index ee78f02ae94..0769f089e6b 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -47,14 +47,100 @@
 int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 int ubi_init(void);
 void ubi_exit(void);
+
+/**
+ * ubi_detach() - detach UBI from MTD partition
+ *
+ * This function performs the cleanup of the UBI subsystem to make sure the
+ * MTD partition can be safely used by other purpose, or be attached again
+ * with ubi_part().
+ *
+ * Any mounted UBIFS will be unmounted automatically.
+ *
+ * Return: 0 on success.
+ */
 int ubi_detach(void);
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
+ * Return: 0 on success, 1 if partition not found, or -ve on error.
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
+
+/**
+ * ubi_create_vol() - create UBI volume
+ * @volume: name of the volume to create
+ * @size: size of the volume in bytes
+ * @dynamic: create dynamic volume if set to true
+ * @vol_id: volume ID
+ * @skipcheck: skip CRC check on this volume if set to true
+ *
+ * This function creates a new UBI volume with the specified parameters.
+ * If @size is negative, all available spaces will be used.
+ * if @vol_id is negative, volume ID will be selected and assigned by UBI.
+ *
+ * Return: 0 on success, or -ve on error.
+ */
 int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
 		   bool skipcheck);
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
 struct ubi_volume *ubi_find_volume(const char *volume);
+
+/**
+ * ubi_remove_vol() - remove UBI volume
+ * @volume: name of the volume to remove
+ *
+ * This function removes an existing UBI volume from the current UBI device.
+ *
+ * Return: 0 on success, or a positive error code on failure.
+ */
 int ubi_remove_vol(const char *volume);
 
 extern struct ubi_device *ubi_devices[];
-- 
2.45.2

