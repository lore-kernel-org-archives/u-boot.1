Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7687AFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6328B84178;
	Mon, 27 Apr 2026 09:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="GjgNdlf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8578423D; Mon, 27 Apr 2026 09:09:39 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA6784144
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 08c0392a420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=1QawkPYweEe1ue7zTOLEOAieBmmTjs8nbybMpMFN/nc=; 
 b=GjgNdlf+1NQLx7aw/B4B6gSputfuOQ5bIVZesPOK/K0enTgSXCTGxdzlyAxX+P9VqveS4anB5NmLCObD7bcF2De+AGpoGoDGmA+IedVBp3ny6u73lbDDjLQZfQkSdUjNV+R7dJxXJtZYFrRHiOhasHLjGcoOFEAPjwRyDQgYlF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5fcf843e-8b52-4d32-acab-54345eafb492, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:7005f58f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 08c0392a420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1169535087; Mon, 27 Apr 2026 15:09:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:28 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:28 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 03/10] cmd: ubi: use void * for buf parameter in
 ubi_volume_read
Date: Mon, 27 Apr 2026 15:09:27 +0800
Message-ID: <42d22e6eaa404394dbf805b966429e023cbe45f9.1777272283.git.weijie.gao@mediatek.com>
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

Use void * to avoid explicit type casting as what ubi_volume_write has done
already.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: new
v3: not changed
---
 cmd/ubi.c           | 4 ++--
 env/ubi.c           | 4 ++--
 include/ubi_uboot.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index f75ceff11ee..8e3cfaaddbb 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -505,7 +505,7 @@ int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 	return ret;
 }
 
-int ubi_volume_read(const char *volume, char *buf, loff_t offset, size_t size)
+int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
 {
 	int err, lnum, off, len, tbuf_size;
 	void *tbuf;
@@ -877,7 +877,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		if (argc == 3) {
-			return ubi_volume_read(argv[3], (char *)addr, 0, size);
+			return ubi_volume_read(argv[3], (void *)addr, 0, size);
 		}
 	}
 
diff --git a/env/ubi.c b/env/ubi.c
index e9865b45ebc..46970ba754f 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -132,14 +132,14 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1, 0,
+	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, tmp_env1, 0,
 				     CONFIG_ENV_SIZE);
 	if (read1_fail)
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
 
 	read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND,
-				     (void *)tmp_env2, 0, CONFIG_ENV_SIZE);
+				     tmp_env2, 0, CONFIG_ENV_SIZE);
 	if (read2_fail)
 		printf("\n** Unable to read redundant env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME_REDUND);
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index a949d1b80dd..dd22ec7537a 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -50,7 +50,7 @@ void ubi_exit(void);
 int ubi_part(const char *part_name, const char *vid_header_offset);
 int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
 		     size_t size);
-int ubi_volume_read(const char *volume, char *buf, loff_t offset, size_t size);
+int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.45.2

