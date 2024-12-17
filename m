Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5DAE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A9480288;
	Tue, 17 Dec 2024 09:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="eFlFXrgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50962801A0; Tue, 17 Dec 2024 09:39:25 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C8780219
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 680f2b76bc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=dPKc3Ft434w8dRDIgVfSsk3Ec5T+MEgFNC72VKoLRWk=; 
 b=eFlFXrgAB/I1s3RsioAgisckAE2GmS73p77gSUEiCv6qPpc6csCzuxS+6hRGcFy/YyHmq068lKM+Pw6DKuOUBiTl8HFVwdeTLc/jJfdueCZUSYt6bOUm7uf1FiF2aUnYbupChygTGxzTIZ0sS2rDCAPMT/UeBb6hQgrlXR1B/x8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:e14b20c5-946c-4f32-851d-9f846aad2ae5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:65e0a628-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 680f2b76bc5211efbd192953cf12861f-20241217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2144115724; Tue, 17 Dec 2024 16:39:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:17 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:17 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 01/10] clk: mediatek: mt7629: fix parent clock of some top
 clock muxes
Date: Tue, 17 Dec 2024 16:39:16 +0800
Message-ID: <c7df5eb71b9f15482621c7c0e3187cc161662851.1734406968.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1734406967.git.weijie.gao@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
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

According to the mt7629 programming guide, the CLK_TOP_F10M_REF_SEL
shares the same parent selection with CLK_TOP_IRRX_SEL, while the
present parent selection for CLK_TOP_F10M_REF_SEL is actually used
for CLK_TOP_SGMII_REF_1_SEL.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 0c796a1788a..380ab9b9b0b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -186,7 +186,7 @@ static const int pwm_parents[] = {
 	CLK_TOP_UNIVPLL2_D4
 };
 
-static const int f10m_ref_parents[] = {
+static const int sgmii_ref_1_parents[] = {
 	CLK_XTAL,
 	CLK_TOP_SGMIIPLL_D2
 };
@@ -369,7 +369,7 @@ static const struct mtk_composite top_muxes[] = {
 
 	/* CLK_CFG_1 */
 	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
+	MUX_GATE(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
 	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
 	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
@@ -412,7 +412,7 @@ static const struct mtk_composite top_muxes[] = {
 
 	/* CLK_CFG_8 */
 	MUX_GATE(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_SGMII_REF_1_SEL, f10m_ref_parents, 0xC0, 8, 1, 15),
+	MUX_GATE(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
 	MUX_GATE(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
 };
 
-- 
2.34.1

