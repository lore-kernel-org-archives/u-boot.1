Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBB0E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 09:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD1D80608;
	Fri, 10 Jan 2025 10:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="jqg44cAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5733E800C2; Fri, 10 Jan 2025 10:13:13 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76689801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 10:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 184b7600cf3311efbd192953cf12861f-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=yz7YY16b4+714g/r0OC2GHiTraE0irrxsMst3mVQMRE=; 
 b=jqg44cARuXrqcLUqjzFi9myG5puME14xFOkQnXpp+qlanEj7NxpCgrQ8G9XZa1Iq0lUncunsIdQ+ldHmxRb0I1PTdkAYKG3veERRdjHlQLIdcQRfIzszOkJs6WrVPd+XNZ9oOZdNSpbfDqy5x5ovPupl60NT+UGQAyQ0rz2eoAw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:615604cc-62fe-40e8-9c66-fdecda40008e, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:2614ae37-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 184b7600cf3311efbd192953cf12861f-20250110
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1530453656; Fri, 10 Jan 2025 17:13:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 17:13:01 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 17:13:01 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH 1/2] clk: mediatek: mt7629: fix gate offset of peri clock tree
Date: Fri, 10 Jan 2025 17:12:58 +0800
Message-ID: <54778538326da242777bb3e14b5a3c7804298594.1736500023.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1736500023.git.weijie.gao@mediatek.com>
References: <cover.1736500023.git.weijie.gao@mediatek.com>
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

From: Sam Shih <sam.shih@mediatek.com>

The clock definitions in mt7629-clk.h indicate that CLK_PERIBUS_SEL is the
first element in the pericfg clock tree and also serves as a clock mux,
unlike other clocks belonging to the clock gate in pericfg.

This make the clock consumer get a wrong clock gate during request a clock
from <&pericfg>.

Since CLK_PERIBUS_SEL clock is not required in U-Boot, add a clock gate
offset for the pericfg clock tree to resolve this problem.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 380ab9b9b0b..94fc5e51456 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -574,6 +574,18 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 	.muxes = top_muxes,
 };
 
+static const struct mtk_clk_tree mt7629_peri_clk_tree = {
+	.xtal_rate = 40 * MHZ,
+	.xtal2_rate = 20 * MHZ,
+	.gates_offs = CLK_PERI_PWM1_PD,
+	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.plls = apmixed_plls,
+	.fclks = top_fixed_clks,
+	.fdivs = top_fixed_divs,
+	.muxes = top_muxes,
+};
+
 static int mt7629_mcucfg_probe(struct udevice *dev)
 {
 	void __iomem *base;
@@ -619,7 +631,7 @@ static int mt7629_infracfg_probe(struct udevice *dev)
 
 static int mt7629_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, peri_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs);
 }
 
 static int mt7629_ethsys_probe(struct udevice *dev)
-- 
2.34.1

