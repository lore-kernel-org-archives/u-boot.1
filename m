Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57631CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0219A830B3;
	Mon,  8 Sep 2025 10:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Wxrp+oP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545E8830B3; Mon,  8 Sep 2025 10:34:20 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F056A830A0
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 98fd6aa68c8e11f0b33aeb1e7f16c2b6-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=RHUN6kL5swZK+Vm380+Y2r7gETLhpqEHgtMsO2WqHXU=; 
 b=Wxrp+oP9k58QLQsKpjYYywSNVwgcXOVCBgt8YLa5h07+TiPMw5VD8GXQqGuVejUgf32JPNh6miwLjiVrjdC2ToDsbe8JNLuo9GoyuTCJLNk1TtdjCh4GjPjPMMDTriFpsRLWb+58UZ3bmC0qh29Gia2IQncXn9vznltrfQ8BO8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:b2a3fb5f-88d3-4464-b9bf-8b0a75ead88e, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:f1326cf, CLOUDID:e9f314a9-24df-464e-9c88-e53ab7cf7153,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 98fd6aa68c8e11f0b33aeb1e7f16c2b6-20250908
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 148910709; Mon, 08 Sep 2025 16:34:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 16:34:11 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 16:34:10 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, "Lucien . Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH v4 2/5] misc: fs_loader: allow using long script name in
 request_firmware_into_buf_via_script()
Date: Mon, 8 Sep 2025 16:34:07 +0800
Message-ID: <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1757315849.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1757315849.git.weijie.gao@mediatek.com>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
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

Use cmd_process() to remove the length limit of script name used for
run_command().

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v4: Remove unneeded const from argv[0] used for cmd_process()
---
 drivers/misc/fs_loader.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 87acd385e23..6a6796c1931 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -232,18 +232,15 @@ int request_firmware_into_buf_via_script(void **buf, size_t max_size,
 					 const char *script_name,
 					 size_t *retsize)
 {
+	char *args[2] = { (char *)"run", (char *)script_name };
+	int ret, repeatable;
 	ulong addr, size;
-	int ret;
-	char cmd[32];
 
 	if (!buf || !script_name || !max_size)
 		return -EINVAL;
 
-	/* Create command to run the firmware loading script */
-	snprintf(cmd, sizeof(cmd), "run %s", script_name);
-
 	/* Run the firmware loading script */
-	ret = run_command_list(cmd, -1, 0);
+	ret = cmd_process(0, 2, args, &repeatable, NULL);
 	if (ret) {
 		log_err("Firmware loading script '%s' not defined or failed.\n",
 			script_name);
-- 
2.34.1

