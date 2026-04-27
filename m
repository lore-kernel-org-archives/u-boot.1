Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6F2FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36B3842E7;
	Mon, 27 Apr 2026 09:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="XYe4wejp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D21580433; Mon, 27 Apr 2026 09:09:49 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6C783AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1046706a420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=d19RNAfcB6xvbqPEsT0OpZPgE6rf5NHvqfa22CEZ06s=; 
 b=XYe4wejpPkzLceYXzUpJ9U6oLB0LedZ6ugjm2L5WjPkFGGgoDGsQ8LdzdWlq0Wi5oaaKvQevLvDXCHLnaALGa1hwQK4F/MR9g4Ew75cJ5fi2NC+3wOTACYPVNGczGbdVPOJ/dURa48BUra9j5jKGC9tqXSl22jQ20GowN4vML5s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:2ae9ae0e-577c-4bad-8e49-764bb7faabfd, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:f92a7fbe-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1046706a420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 89929218; Mon, 27 Apr 2026 15:09:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:41 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:40 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 10/10] env: ubi: add support to create environment volume
 if it does not exist
Date: Mon, 27 Apr 2026 15:09:39 +0800
Message-ID: <d7ec0e5d655f8c2f1d159908f74d00927d7a0776.1777272283.git.weijie.gao@mediatek.com>
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

Add an option to allow environment volume being auto created if not
exist.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2: updated kconfig help text
    added error output when failed to create volume
v3: fix error handling and default env setting
---
 env/Kconfig | 11 +++++++++++
 env/ubi.c   | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..8404e0d44eb 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -716,6 +716,17 @@ config ENV_UBI_VOLUME_REDUND
 	help
 	  Name of the redundant volume that you want to store the environment in.
 
+config ENV_UBI_VOLUME_CREATE
+	bool "Create UBI volume if not exist"
+	depends on ENV_IS_IN_UBI
+	help
+	  This option is useful if u-boot will be booted from a fresh device
+	  where environment volume hasn't been created in the UBI partition.
+	  This is a common case where factory UBI image contains only volumes
+	  with valid data.
+	  By enabling this option, environment volume(s) will be created before
+	  loading if not exist.
+
 config ENV_UBI_VID_OFFSET
 	int "ubi environment VID offset"
 	depends on ENV_IS_IN_UBI
diff --git a/env/ubi.c b/env/ubi.c
index 46970ba754f..6b995ce40ac 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -103,12 +103,29 @@ static int env_ubi_save(void)
 }
 #endif /* CONFIG_ENV_REDUNDANT */
 
+static int env_ubi_volume_create(const char *volume)
+{
+	struct ubi_volume *vol;
+	int ret;
+
+	vol = ubi_find_volume(volume);
+	if (vol)
+		return 0;
+
+	ret = ubi_create_vol(volume, CONFIG_ENV_SIZE, true, UBI_VOL_NUM_AUTO,
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
+	int read1_fail, read2_fail, create1_fail, create2_fail;
 	env_t *tmp_env1, *tmp_env2;
 
 	/*
@@ -132,6 +149,15 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
+	if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
+		create1_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
+		create2_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
+		if (create1_fail && create2_fail) {
+			env_set_default(NULL, 0);
+			return -ENODEV;
+		}
+	}
+
 	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, tmp_env1, 0,
 				     CONFIG_ENV_SIZE);
 	if (read1_fail)
@@ -169,6 +195,13 @@ static int env_ubi_load(void)
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

