Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86F5F8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AEC84223;
	Fri, 17 Apr 2026 04:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="T9OpkFV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465638428C; Fri, 17 Apr 2026 04:35:43 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A12B8407E
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1cc838463a0611f1ae70033691e9ac7d-20260417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=eEKfbCEkCSCI443ADA6B20gOynm7kWvPjNgjmAErYTU=; 
 b=T9OpkFV5o2nhkSn3+sLAzRqDV7KaopUdeF/scEHNVv75HulFF77HDrG5O35ESbcP4HocD2lOyvSTICX61o9yQaGHPLRAIWh3aNYf63G+WRwJnKUlHqVv1hHKEVZxrt7+UPJ378n3UoyBLF75dGYuAA5r5Igu6WplF700vCwOkCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a588be3e-4610-48f2-842f-cc767968ad01, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:8b52f5d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cc838463a0611f1ae70033691e9ac7d-20260417
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1476180528; Fri, 17 Apr 2026 10:35:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 10:35:33 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Apr 2026 10:35:33 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 3/3] env: ubi: add support to create environment volume if it
 does not exist
Date: Fri, 17 Apr 2026 10:35:32 +0800
Message-ID: <ba4fd0352a7e9a38c0cddaa3056a926cf9715631.1776392312.git.weijie.gao@mediatek.com>
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

Add an option to allow environment volume being auto created if not
exist.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 env/Kconfig |  6 ++++++
 env/ubi.c   | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..cec1bf0bb11 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -716,6 +716,12 @@ config ENV_UBI_VOLUME_REDUND
 	help
 	  Name of the redundant volume that you want to store the environment in.
 
+config ENV_UBI_VOLUME_CREATE
+	bool "Create UBI volume if not exist"
+	depends on ENV_IS_IN_UBI
+	help
+	  Create the UBI volume if it does not exist.
+
 config ENV_UBI_VID_OFFSET
 	int "ubi environment VID offset"
 	depends on ENV_IS_IN_UBI
diff --git a/env/ubi.c b/env/ubi.c
index e9865b45ebc..bbd86adf176 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -103,6 +103,18 @@ static int env_ubi_save(void)
 }
 #endif /* CONFIG_ENV_REDUNDANT */
 
+int __weak env_ubi_volume_create(const char *volume)
+{
+	struct ubi_volume *vol;
+
+	vol = ubi_find_volume((char *)volume);
+	if (vol)
+		return 0;
+
+	return ubi_create_vol((char *)volume, CONFIG_ENV_SIZE, true,
+			      UBI_VOL_NUM_AUTO, false);
+}
+
 #ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_load(void)
 {
@@ -132,6 +144,11 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
+	if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
+		env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
+		env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
+	}
+
 	read1_fail = ubi_volume_read(CONFIG_ENV_UBI_VOLUME, (void *)tmp_env1, 0,
 				     CONFIG_ENV_SIZE);
 	if (read1_fail)
@@ -169,6 +186,9 @@ static int env_ubi_load(void)
 		return -EIO;
 	}
 
+	if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE))
+		env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
+
 	if (ubi_volume_read(CONFIG_ENV_UBI_VOLUME, buf, 0, CONFIG_ENV_SIZE)) {
 		printf("\n** Unable to read env from %s:%s **\n",
 		       CONFIG_ENV_UBI_PART, CONFIG_ENV_UBI_VOLUME);
-- 
2.45.2

