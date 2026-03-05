Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36599F3092B
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 10:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CBE83F98;
	Thu,  5 Mar 2026 11:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="t9xm+xz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AD683FA4; Thu,  5 Mar 2026 11:24:08 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C883783F2D
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 11:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 6b60a98e187d11f1b7fc4fdb8733b2bc-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=JCUGQOcKJtRjc42DFlKJ948xrQzTiEvX1wEMI+QefJI=; 
 b=t9xm+xz+EcUkiki14/y9usLfOKGQi3EiKz2WCy6N2ZV4he7XlCdLDM9i6PguyQLPx5czjp/r+1J/rhEDQVQCrpr3KKH15hejlwchsYcgHNtNLrNWVawKCs0e3QmkSJC2j/alcvpRckaES/TLkxE/mN0a3B6i+JjyU0RadYA18MQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:437f0a40-f579-4640-8558-a09d63ca555b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:c63447ea-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b60a98e187d11f1b7fc4fdb8733b2bc-20260305
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1941674725; Thu, 05 Mar 2026 18:23:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 18:23:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 18:23:56 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: <u-boot@lists.denx.de>, Amjad Ouled-Ameur <aouledameur@baylibre.com>, Tom
 Rini <trini@konsulko.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Ryder
 Lee <Ryder.Lee@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marex@denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Casey Connolly <casey.connolly@linaro.org>, Bin
 Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, "ht
 . lin" <ht.lin@mediatek.com>
Subject: [PATCH v2] scsi: Adjust SCSI inquiry command data length
Date: Thu, 5 Mar 2026 18:23:24 +0800
Message-ID: <20260305102324.2797478-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Per the SCSI SPC-4 specification, the standard inquiry data length
should not be less than 36 bytes. The current implementation uses 512
bytes, which causes detection failures on some UFS devices (e.g.,
Longsys) that do not expect a transfer length exceeding the standard
inquiry size.

Align the default standard inquiry length with the Linux kernel's
implementation (see drivers/scsi/scsi_scan.c), which uses 36 bytes as
the default. Devices requiring vendor-specific inquiry lengths should
be handled through quirk settings in the future.

Signed-off-by: ht.lin <ht.lin@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes for v2:
 - Update commit message according to the review discussions. 

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8fe6b38a8c74..116b696b08dd 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -513,7 +513,7 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 	pccb->target = target;
 	pccb->lun = lun;
 	pccb->pdata = tempbuff;
-	pccb->datalen = 512;
+	pccb->datalen = 36;
 	pccb->dma_dir = DMA_FROM_DEVICE;
 	scsi_setup_inquiry(pccb);
 	if (scsi_exec(dev, pccb)) {
-- 
2.45.2

