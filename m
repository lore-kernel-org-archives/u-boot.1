Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222EDD3C935
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 00:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BE388E02;
	Mon, 21 Oct 2024 02:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TgLxTuuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7705F88EC0; Mon, 21 Oct 2024 02:56:58 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FDD88606
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 02:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 5919a6e28f4711efb88477ffae1fc7a5-20241021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=wOIZPHFyTrnvmqsc+7FNqx4PbfdlpHkua07oQU1FAgo=; 
 b=TgLxTuuSYfMaxPG6Toyd9d8axBdbNFnxmUp/i8vEjjidiPosIMgpONhJzAwIWCzXiV5DYYR/dZsgkKMzpYSXsGqqcf9xtyvRfvFDB8wc510PIA9dTy7S0gpWUpmzHEA7kUY5Q8KbbnWTPtePzajtAWCIKzhzRVJyKhpfmSRVPpY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:b6ae751f-cf78-4248-8546-3e30afa5b0df, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:c1295d25-9cd9-4037-af6e-f4241b90f84d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5919a6e28f4711efb88477ffae1fc7a5-20241021
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1072194399; Mon, 21 Oct 2024 08:56:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Oct 2024 08:56:45 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Oct 2024 08:56:45 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Daniel
 Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] menu: fix the logic checking whether ESC key is pressed
Date: Mon, 21 Oct 2024 08:56:42 +0800
Message-ID: <20241021005642.153511-1-weijie.gao@mediatek.com>
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

It's observed that the bootmenu on a serial console sometimes
incorrectly quitted with superfluous characters filled to command
line input:

>  *** U-Boot Boot Menu ***
>
>      1. Startup system (Default)
>      2. Upgrade firmware
>      3. Upgrade ATF BL2
>      4. Upgrade ATF FIP
>      5. Load image
>      0. U-Boot console
>
>
>  Press UP/DOWN to move, ENTER to select, ESC to quit
>MT7988> [B

Analysis shows it was caused by the wrong logic of bootmenu_loop:

At first the bootmenu_loop received the first ESC char correctly.

However, during the second call to bootmenu_loop, there's no data
in the UART Rx FIFO. Due to the low baudrate, the second char of
the down array key sequence hasn't be fully received.

But bootmenu_loop just did a mdelay(10), and then treated it as a
single ESC key press event. It didn't even try tstc() again after
the 10ms timeout.

This patch fixes this issue by letting bootmenu_loop check tstc()
twice.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 common/menu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/menu.c b/common/menu.c
index 8cc9bf06d9c..48ab7f0f398 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -525,14 +525,15 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
 				struct cli_ch_state *cch)
 {
 	enum bootmenu_key key;
-	int c;
+	int c, errchar = 0;
 
 	c = cli_ch_process(cch, 0);
 	if (!c) {
 		while (!c && !tstc()) {
 			schedule();
 			mdelay(10);
-			c = cli_ch_process(cch, -ETIMEDOUT);
+			c = cli_ch_process(cch, errchar);
+			errchar = -ETIMEDOUT;
 		}
 		if (!c) {
 			c = getchar();
-- 
2.17.0

