Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4909FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B5C8429E;
	Mon, 27 Apr 2026 09:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="solbnTRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF4880077; Mon, 27 Apr 2026 09:09:42 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154E784144
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0cb5da1c420811f19781c1a04af40193-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=HNVHTGHvGNutL35elZ4aYbKETjywApnar2Ng22P9au4=; 
 b=solbnTRrctNyc1xGMzh0ak1O6um54kX+Tu0ET9BYRgpi6BJKj7RM9EbU1caklXPZFAvzfwQtJ6I0m/SbQWSBiOrV2W+dV6YP3GaJoNnoRCt4NTl8/bJIC999F5F58JYprMqVs289WU9zLaTqWLIRt3/6aVjuP9UI1Fn25+0EzZ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7981cc19-0ab7-4d9d-8687-6f1c6c2e0983, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:dc05f58f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0cb5da1c420811f19781c1a04af40193-20260427
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1215993285; Mon, 27 Apr 2026 15:09:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:35 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:34 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 07/10] cmd: ubi: export more APIs to public
Date: Mon, 27 Apr 2026 15:09:34 +0800
Message-ID: <cb7f6ba95951ed3437b6f0cc85179cf4b78f2a97.1777272283.git.weijie.gao@mediatek.com>
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

Export the following functions to public:

- ubi_detach(): this is paired with ubi_part(). One may call this function
  to completely clean up the ubi subsystem after using ubi_part().

- ubi_{create,find,remove}_vol: this is a set of functions for volume
  management.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: not changed
v3: updated commit message
---
 cmd/ubi.c           | 10 +++++-----
 include/ubi_uboot.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 9f121ea2931..c8b31f92662 100644
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
 
-static int ubi_remove_vol(const char *volume)
+int ubi_remove_vol(const char *volume)
 {
 	int err, reserved_pebs, i;
 	struct ubi_volume *vol;
@@ -635,7 +635,7 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
 	return ubi_change_vtbl_record(ubi, vol->vol_id, &vtbl_rec);
 }
 
-static int ubi_detach(void)
+int ubi_detach(void)
 {
 #ifdef CONFIG_CMD_UBIFS
 	/*
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6ebd8a3b613..ee78f02ae94 100644
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
+int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
+		   bool skipcheck);
+struct ubi_volume *ubi_find_volume(const char *volume);
+int ubi_remove_vol(const char *volume);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(const char *vol_name);
-- 
2.45.2

