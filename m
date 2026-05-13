Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC6CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B921E8341A;
	Wed, 13 May 2026 10:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="RIYbNsad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B783846A5; Wed, 13 May 2026 10:03:14 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC86A8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 2bdb21804ea211f1b5a00d44d12bea5a-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=uWTyvTZm8/mLT8qf5pdWvHKsCeVX9xndPDRCJ9XHu9A=; 
 b=RIYbNsado+bSlVDYDH6ufPkYtVQbjJWW4r/pTa9eq3NJhxFIOZceX5rHuz1+3bRpFx3lHHLdsnkYTtbDCGhAGwHV1D5oyLOevxb1FaQWDr8O4d5AsrnVLGOY9JohjtC7ac9OFhtnlnBNMB+SrV35FzOCRT0RRs/kueAQYZPZJMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:0efe78f9-e0fb-4df0-9ca6-2b4e744636c8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:9091e75, CLOUDID:a4aa4dbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2bdb21804ea211f1b5a00d44d12bea5a-20260513
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 610398285; Wed, 13 May 2026 16:03:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 13 May 2026 16:03:03 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 13 May 2026 16:03:03 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 10/10] env: ubi: add support to create environment volume
 if it does not exist
Date: Wed, 13 May 2026 16:03:02 +0800
Message-ID: <4139e7bef0bb12225a18e3b205dd66b77d8ce543.1778657347.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1778657347.git.weijie.gao@mediatek.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
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

When U-Boot is booting from a fresh device, the environment volume may not
exist in the factory UBI image. This is a common case where factory UBI
image contains only volumes with valid data.

With the current design, even if the volume is created manually, the
environment will still be unusable (e.g., saveenv) before a reboot.

This patch adds support to automatically create missing volumes before
loading environment. This will make environment available at first boot.

There are two options:
CONFIG_ENV_UBI_VOLUME_CREATE: whether to enable volume creation
CONFIG_ENV_UBI_VOLUME_STATIC: create static volume (default is dynamic)

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v4: Add option to control whether to create static volume
    Read environment volume only when it exists or has been created.
v3: fix error handling and default env setting
v2: updated kconfig help text
    added error output when failed to create volume
---
 env/Kconfig | 20 +++++++++++++++++
 env/ubi.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..9ec3e090481 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -716,6 +716,26 @@ config ENV_UBI_VOLUME_REDUND
 	help
 	  Name of the redundant volume that you want to store the environment in.
 
+config ENV_UBI_VOLUME_CREATE
+	bool "Create UBI volume if it does not exist"
+	depends on ENV_IS_IN_UBI
+	help
+	  This option is useful if U-Boot will be booted from a fresh device
+	  where the environment volume has not been created.
+	  This is a common case where factory UBI image contains only volumes
+	  with valid data.
+	  By enabling this option, any missing environment volumes will be
+	  created before loading.
+	  If CONFIG_ENV_UBI_VOLUME_REDUND is also enabled, both volumes will be
+	  created,
+
+config ENV_UBI_VOLUME_STATIC
+	bool "Create static UBI volume"
+	depends on ENV_UBI_VOLUME_CREATE
+	help
+	  By default environment volume will be dynamic.
+	  Enable this option to create static volume.
+
 config ENV_UBI_VID_OFFSET
 	int "ubi environment VID offset"
 	depends on ENV_IS_IN_UBI
diff --git a/env/ubi.c b/env/ubi.c
index 46970ba754f..810faaf7744 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -103,12 +103,30 @@ static int env_ubi_save(void)
 }
 #endif /* CONFIG_ENV_REDUNDANT */
 
+static int env_ubi_volume_create(const char *volume)
+{
+	bool dynamic = !IS_ENABLED(CONFIG_ENV_UBI_VOLUME_STATIC);
+	struct ubi_volume *vol;
+	int ret;
+
+	vol = ubi_find_volume(volume);
+	if (vol)
+		return 0;
+
+	ret = ubi_create_vol(volume, CONFIG_ENV_SIZE, dynamic, UBI_VOL_NUM_AUTO,
+			     false);
+	if (ret)
+		printf("Failed to create environment volume '%s'\n", volume);
+
+	return ret;
+}
+
 #ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_load(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, env1_buf, CONFIG_ENV_SIZE);
 	ALLOC_CACHE_ALIGN_BUFFER(char, env2_buf, CONFIG_ENV_SIZE);
-	int read1_fail, read2_fail;
+	int read1_fail, read2_fail, create1_fail = 0, create2_fail = 0;
 	env_t *tmp_env1, *tmp_env2;
 
 	/*
@@ -132,17 +150,35 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
-	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, tmp_env1, 0,
-				     CONFIG_ENV_SIZE);
-	if (read1_fail)
-		printf("\n** Unable to read env from %s:%s **\n",
-		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
+	if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
+		create1_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
+		create2_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
+		if (create1_fail && create2_fail) {
+			env_set_default(NULL, 0);
+			return -ENODEV;
+		}
+	}
 
-	read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND,
-				     tmp_env2, 0, CONFIG_ENV_SIZE);
-	if (read2_fail)
-		printf("\n** Unable to read redundant env from %s:%s **\n",
-		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME_REDUND);
+	if (!create1_fail) {
+		read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, tmp_env1, 0,
+					     CONFIG_ENV_SIZE);
+		if (read1_fail)
+			printf("\n** Unable to read env from %s:%s **\n",
+			       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
+	} else {
+		read1_fail = create1_fail;
+	}
+
+	if (!create2_fail) {
+		read2_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME_REDUND,
+					     tmp_env2, 0, CONFIG_ENV_SIZE);
+		if (read2_fail)
+			printf("\n** Unable to read redundant env from %s:%s **\n",
+			       CONFIG_ENV_UBI_PART,
+			       CONFIG_ENV_UBI_VOLUME_REDUND);
+	} else {
+		read2_fail = create2_fail;
+	}
 
 	return env_import_redund((char *)tmp_env1, read1_fail, (char *)tmp_env2,
 				 read2_fail, H_EXTERNAL);
@@ -169,6 +205,13 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
+	if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
+		if (env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME)) {
+			env_set_default(NULL, 0);
+			return -ENODEV;
+		}
+	}
+
 	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
-- 
2.45.2

