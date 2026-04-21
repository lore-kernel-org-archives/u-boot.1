Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BCEF327C5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C2D8439E;
	Tue, 21 Apr 2026 10:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="VVGvWmrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9E6843A4; Tue, 21 Apr 2026 10:36:28 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27878431E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 2c5b133c3d5d11f19781c1a04af40193-20260421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=otECr0t2ZjQ6b2A8f02ewWbo2/KEcO2QCw/tXfjX/C4=; 
 b=VVGvWmrf93FfXTiYUyRTaGzJ0528ZFUHwgtAWyvPtVu+rrMcR+Z49LFtlFhnLs0SViKTcVvR+KaQvvjnZw/ysSzkPGdqj2cXjUBdS7k3YlcMPxCEk0u6Um6TAvZrgiJWtZ78e1kevlqaoMw2WI/FbHMXDej9F5N1Qks8gT0Gx4Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:6c2da8f4-ab19-4c96-81a9-1e0086bafe3a, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:b1b6ac8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c5b133c3d5d11f19781c1a04af40193-20260421
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 828862069; Tue, 21 Apr 2026 16:36:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 21 Apr 2026 16:36:19 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 21 Apr 2026 16:36:19 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 4/8] cmd: ubifs: mark string parameters with const
Date: Tue, 21 Apr 2026 16:36:10 +0800
Message-ID: <730a6370bd11b6897ef881e560a8687b893b7bdf.1776759754.git.weijie.gao@mediatek.com>
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

File name and volume name should be const as they will not be modified in
these functions.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: new
---
 cmd/ubifs.c           | 2 +-
 fs/ubifs/super.c      | 2 +-
 fs/ubifs/ubifs.c      | 2 +-
 include/ubi_uboot.h   | 2 +-
 include/ubifs_uboot.h | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/ubifs.c b/cmd/ubifs.c
index 22e95db8ca5..81f2d37fc7b 100644
--- a/cmd/ubifs.c
+++ b/cmd/ubifs.c
@@ -19,7 +19,7 @@
 static int ubifs_initialized;
 static int ubifs_mounted;
 
-int cmd_ubifs_mount(char *vol_name)
+int cmd_ubifs_mount(const char *vol_name)
 {
 	int ret;
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b6004b88f4e..9c8974a97a5 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2694,7 +2694,7 @@ MODULE_VERSION(__stringify(UBIFS_VERSION));
 MODULE_AUTHOR("Artem Bityutskiy, Adrian Hunter");
 MODULE_DESCRIPTION("UBIFS - UBI File System");
 #else
-int uboot_ubifs_mount(char *vol_name)
+int uboot_ubifs_mount(const char *vol_name)
 {
 	struct dentry *ret;
 	int flags;
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index b0cc0d2e1b2..f6f21e6af22 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -974,7 +974,7 @@ void ubifs_close(void)
 }
 
 /* Compat wrappers for common/cmd_ubifs.c */
-int ubifs_load(char *filename, unsigned long addr, u32 size)
+int ubifs_load(const char *filename, unsigned long addr, u32 size)
 {
 	loff_t actread;
 	int err;
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index dd22ec7537a..6ebd8a3b613 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -53,7 +53,7 @@ int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
-int cmd_ubifs_mount(char *vol_name);
+int cmd_ubifs_mount(const char *vol_name);
 int cmd_ubifs_umount(void);
 
 #if IS_ENABLED(CONFIG_UBI_BLOCK)
diff --git a/include/ubifs_uboot.h b/include/ubifs_uboot.h
index db8a29e9bbd..0877dd84f99 100644
--- a/include/ubifs_uboot.h
+++ b/include/ubifs_uboot.h
@@ -18,10 +18,10 @@ struct blk_desc;
 struct disk_partition;
 
 int ubifs_init(void);
-int uboot_ubifs_mount(char *vol_name);
+int uboot_ubifs_mount(const char *vol_name);
 void uboot_ubifs_umount(void);
 int ubifs_is_mounted(void);
-int ubifs_load(char *filename, unsigned long addr, u32 size);
+int ubifs_load(const char *filename, unsigned long addr, u32 size);
 
 int ubifs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int ubifs_ls(const char *dir_name);
-- 
2.45.2

