Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4448AF8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9974E84258;
	Fri, 17 Apr 2026 04:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BrfzgUIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BD68427F; Fri, 17 Apr 2026 04:35:37 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7768407E
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 17a89c203a0611f19a16598d5ca7f8ec-20260417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=dk+MhJy2WgVDo6diXKMK5LIpoTXys5uhiw93e4d4h3o=; 
 b=BrfzgUIurVPuA3gFKO8M+advI3TBSNttn7LMAE4e5vcei4tMQ72PkQDZZPzpIy+UThADxJ0BaVLWElzOvAcJBfk1CUihIfRasqXWMLLTbUDPpxhftWbeYrTTasCVQlJBukE5s5Bw2dHw5Qx59Rx3cPED5j2ih/y2gSGxphzt2pI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7e5b208c-f8da-4b84-ac63-8d956bc68ce0, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:b3a90895-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17a89c203a0611f19a16598d5ca7f8ec-20260417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1244276853; Fri, 17 Apr 2026 10:35:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 10:35:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Apr 2026 10:35:24 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 1/3] cmd: ubi: expose more APIs to public
Date: Fri, 17 Apr 2026 10:35:22 +0800
Message-ID: <f0024175a615b0217cb3f2181d7957a9f59b9ec8.1776392312.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1776392312.git.weijie.gao@mediatek.com>
References: <cover.1776392312.git.weijie.gao@mediatek.com>
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
 cmd/ubi.c           | 10 +++++-----
 include/ubi_uboot.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 93de6f3aea2..e7fd7165457 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -213,8 +213,8 @@ bad:
 	return err;
 }
 
-static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
-			  bool skipcheck)
+int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
+		   bool skipcheck)
 {
 	struct ubi_mkvol_req req;
 	int err;
@@ -247,7 +247,7 @@ static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
 	return ubi_create_volume(ubi, &req);
 }
 
-static struct ubi_volume *ubi_find_volume(char *volume)
+struct ubi_volume *ubi_find_volume(char *volume)
 {
 	struct ubi_volume *vol;
 	int i;
@@ -262,7 +262,7 @@ static struct ubi_volume *ubi_find_volume(char *volume)
 	return NULL;
 }
 
-static int ubi_remove_vol(char *volume)
+int ubi_remove_vol(char *volume)
 {
 	int err, reserved_pebs, i;
 	struct ubi_volume *vol;
@@ -635,7 +635,7 @@ static int ubi_set_skip_check(char *volume, bool skip_check)
 	return ubi_change_vtbl_record(ubi, vol->vol_id, &vtbl_rec);
 }
 
-static int ubi_detach(void)
+int ubi_detach(void)
 {
 #ifdef CONFIG_CMD_UBIFS
 	/*
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index ea0db69c72a..36b5b69dbfd 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -47,9 +47,14 @@
 extern int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 extern int ubi_init(void);
 extern void ubi_exit(void);
+extern int ubi_detach(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
 extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
+extern int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
+			  bool skipcheck);
+extern struct ubi_volume *ubi_find_volume(char *volume);
+extern int ubi_remove_vol(char *volume);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.45.2

