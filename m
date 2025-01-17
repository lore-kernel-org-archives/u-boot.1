Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C3EC02188
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26EA8073D;
	Fri, 17 Jan 2025 10:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="CXGVps54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E8E80758; Fri, 17 Jan 2025 10:18:10 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A27D880778
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f2fbad1cd4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=5F91k4AGAlRpNdEQg4Zl04cn4dpShRt9E5/zcGm8e3g=; 
 b=CXGVps54gOgh8GrExszM1O8t4nWtRTJcSUNhguTyW279vtaIPlOwGVKqVdPckf50sa0xgpqCnl8PBHZ8fZl85oL74q7Is8+7ovizUsPYTty/OxC9sb3VO47iHGuVloG/vnRz5NVNrvYKcaJ7Od1iO4eid+Xa6uNoK6np+s6xGrw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:a61c5483-7542-4021-b50e-c81560fd538d, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:48083285-0f10-4f52-bb41-91703793d3e4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2fbad1cd4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1154154929; Fri, 17 Jan 2025 17:18:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:17:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:17:59 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, Weijie Gao
 <weijie.gao@mediatek.com>, "SkyLake . Huang" <skylake.huang@mediatek.com>
Subject: [PATCH 06/15] spi: mtk_spim: check slave device mode in spi-mem's
 supports_op
Date: Fri, 17 Jan 2025 17:17:55 +0800
Message-ID: <161b349deaacb73b86b3de2441f5c4ce493006b0.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
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

Call spi_mem_default_supports_op() in supports_op to honor the
slave's supported single/dual/quad mode settings.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/spi/mtk_spim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index cd9b9d305ef..2b2c31b4b3f 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -359,6 +359,9 @@ static bool mtk_spim_supports_op(struct spi_slave *slave,
 	struct udevice *bus = dev_get_parent(slave->dev);
 	struct mtk_spim_priv *priv = dev_get_priv(bus);
 
+	if (!spi_mem_default_supports_op(slave, op))
+		return false;
+
 	if (op->cmd.buswidth == 0 || op->cmd.buswidth > 4 ||
 	    op->addr.buswidth > 4 || op->dummy.buswidth > 4 ||
 	    op->data.buswidth > 4)
-- 
2.34.1

