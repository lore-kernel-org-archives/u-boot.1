Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9394FD2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D4789143;
	Fri, 18 Oct 2024 10:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="NPlCjx+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A51489143; Fri, 18 Oct 2024 10:38:31 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A92518912B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 539b82668d2c11efb88477ffae1fc7a5-20241018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=iBUk64iZfTkc+U5bCSQkG6x9ibMXbLNM5yt/eHEUZ30=; 
 b=NPlCjx+ulbE57vxXXcJBzjrdf9Yb7U88GP56KvfUEVh0zKdUh5YaAh4vAyu6GsmymXyN+lY1Jw7Ye0kdeEZ4gt3iIsttj2JRf8of8hZa11aGL1097yJjo/n4vNo/obwwa9RWonOIUeJTbiPy7dXzpLKbooL7lKcyErWwHQrXSKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:2ab7afce-7fac-4d4b-8978-0d086888aaa7, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:ce46010d-1043-475c-b800-3262c01ea3e5,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 539b82668d2c11efb88477ffae1fc7a5-20241018
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2101293925; Fri, 18 Oct 2024 16:38:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 18 Oct 2024 16:38:16 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 18 Oct 2024 16:38:15 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "Daniel
 Golle" <daniel@makrotopia.org>, John Crispin <john@phrozen.org>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] menu: fix the logic checking whether ESC key is pressed
Date: Fri, 18 Oct 2024 16:38:06 +0800
Message-ID: <20241018083806.30679-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.350000-8.000000
X-TMASE-MatchedRID: tWj4i8jq8xryPHQB9pP5RJDrDU5E36oxvFBr9I4pkFNOCtCDJNptxkGd
 9Hthb4Jj8GCkoSXZagmDCaCKLFp+wrpNyfN3ktaZvbFZsqMF9Y87UrmIzxDooMUmcSma304THck
 A2QRcBHnG+m9onx5lUZkX5xUNKMiJfyoI97TEvxDhqJ6oLOc8Qdg/RWw4PQT+1bSmSk9HUNr5WK
 Feqf3EsbatY3hWHUaxgDLqnrRlXrZ8nn9tnqel2MprJP8FBOIars6mSlbaRcvflcRKCrC6BJnas
 bvwmPPO2JuIomUtAkAmD/E647tMs7zy5uqVb6ze/BOQUlobCyXeTP+ne1IvcFOa4m+66RZ8xCbc
 O+QiMtt0BNB20+SxH7f8mJY57oZddJaBDYald1mHO0tVYDV4T0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.350000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0716EDA1EDC9D74B61332B5355CE56E9CB182E358931006FD5A348F148B3901C2000:8
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
index 5fd705039fc..bd2ac3e0ed9 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -566,7 +566,7 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
 				struct cli_ch_state *cch)
 {
 	enum bootmenu_key key;
-	int c;
+	int c, errchar = 0;
 	int choice;
 
 	c = cli_ch_process(cch, 0);
@@ -574,7 +574,8 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
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
2.34.1

