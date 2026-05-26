Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AA4CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CAD846AC;
	Tue, 26 May 2026 10:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="kVzdL0op";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4362846CA; Tue, 26 May 2026 10:40:46 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718D883FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 10:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 917e9d4658de11f18dc8c9802ae25ab1-20260526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=ndNIP2LV495BN05CUq6E0Vso1CbI7IS9ajhgshWAZw8=; 
 b=kVzdL0opQXcC9dPyVOxbwNMPJvbL1jJQVugtzWd6LcqmEXhXHSfM6wVV9MQ+8pj+r3ji1qMkIWvTXG+U4XdOMPS1vFg08AMf3/NznYhV76nCPVCBtc+4s9VgHIGfiKm9EbanFoiUOTZTwd+dtDILEIRybQQ6wb6Z9+ymz2EWuNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:dff01cca-3829-4649-8583-93403b4737f4, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:07444770-8800-4843-8f0d-4ee1b029261a,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 917e9d4658de11f18dc8c9802ae25ab1-20260526
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 675617923; Tue, 26 May 2026 16:40:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 26 May 2026 16:40:35 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 26 May 2026 16:40:35 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH v2,RESEND] bootmenu: fix incorrect menu quitting logic
Date: Tue, 26 May 2026 16:40:30 +0800
Message-ID: <20260526084030.142468-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

The last entry of bootmenu is always set for exiting the menu, and its
command is set to an empty string.

When user selects to quit the menu, bootmenu will try to run this empty
command. However run_command() with empty cmd string will return failure,
and the return value will be overridden to BOOTMENU_RET_FAIL, not the
expected BOOTMENU_RET_QUIT.

This patch adds a default success value to the cmd_ret variable, and makes
sure run_command() is called only when the menu command is not empty.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v2: updated commit message
---
 cmd/bootmenu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index 528afd221d0..b55f5579409 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -526,7 +526,7 @@ static void handle_uefi_bootnext(void)
  */
 static enum bootmenu_ret bootmenu_show(int uefi, int delay)
 {
-	int cmd_ret;
+	int cmd_ret = CMD_RET_SUCCESS;
 	int init = 0;
 	void *choice = NULL;
 	char *title = NULL;
@@ -628,7 +628,7 @@ cleanup:
 		printf(ANSI_CURSOR_POSITION, 1, 1);
 	}
 
-	if (title && command) {
+	if (title && command && *command) {
 		debug("Starting entry '%s'\n", title);
 		free(title);
 		if (efi_ret == EFI_SUCCESS)
-- 
2.45.2

