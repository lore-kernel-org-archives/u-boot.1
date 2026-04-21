Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEFDF327C5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4E4843EA;
	Tue, 21 Apr 2026 10:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="RWKu028E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E300C8431E; Tue, 21 Apr 2026 10:36:42 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797A6843FA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 33f7aace3d5d11f19a16598d5ca7f8ec-20260421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=UaKkqExZDqTEhk3fsDeq7cD3g0mgI9HrBTPh+N3njpc=; 
 b=RWKu028EvpaojChFTZ0ndVtJieVD1UJchhgWL3XsluERfXwd2XUd8B3LYaGvGHAwjp7/4kEyIu3eoorOMDehFNfKMDfw4DVOoUM11qtXeoW5dy4tJGlEAW6Dg2j6iGQu2e+28/W5swnr2CRuWWlVuc5rD437qb7nd1khJ5tdtB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:062edda8-a009-4af3-9d79-cf73c6203acc, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:8bb41cd6-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33f7aace3d5d11f19a16598d5ca7f8ec-20260421
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 307508385; Tue, 21 Apr 2026 16:36:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 21 Apr 2026 16:36:32 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 21 Apr 2026 16:36:32 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 6/8] cmd: ubi: expose more APIs to public
Date: Tue, 21 Apr 2026 16:36:29 +0800
Message-ID: <bc5c9f9ec365ad6100709ff6bb260afb1aec9a50.1776759754.git.weijie.gao@mediatek.com>
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

Export ubi_detach/ubi_create_vol/ubi_find_volume/ubi_remove_vol to
public for better ubi manipulation used by other modules.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: not changed
---
 cmd/ubi.c           | 10 +++++-----
 include/ubi_uboot.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index f2ae63e6a7a..aae33d4bca3 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -213,8 +213,8 @@ bad:
 	return err;
 }
 
-static int ubi_create_vol(const char *volume, int64_t size, int dynamic,
-			  int vol_id, bool skipcheck)
+int ubi_create_vol(const char *volume, int64_t size, int dynamic, int vol_id,
+		   bool skipcheck)
 {
 	struct ubi_mkvol_req req;
 	int err;
@@ -246,7 +246,7 @@ static int ubi_create_vol(const char *volume, int64_t size, int dynamic,
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
 
-static int ubi_remove_vol(const char *volume)
+int ubi_remove_vol(const char *volume)
 {
 	int err, reserved_pebs, i;
 	struct ubi_volume *vol;
@@ -637,7 +637,7 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	return ubi_change_vtbl_record(ubi, vol->vol_id, &vtbl_rec);
 }
 
-static int ubi_detach(void)
+int ubi_detach(void)
 {
 #ifdef CONFIG_CMD_UBIFS
 	/*
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6ebd8a3b613..902f214c73d 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -47,10 +47,15 @@
 int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 int ubi_init(void);
 void ubi_exit(void);
+int ubi_detach(void);
 int ubi_part(const char *part_name, const char *vid_header_offset);
 int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 		     size_t size);
 int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);
+int ubi_create_vol(const char *volume, int64_t size, int dynamic, int vol_id,
+		   bool skipcheck);
+struct ubi_volume *ubi_find_volume(const char *volume);
+int ubi_remove_vol(const char *volume);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(const char *vol_name);
-- 
2.45.2

