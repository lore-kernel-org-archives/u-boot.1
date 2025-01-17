Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE5C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C86F80763;
	Fri, 17 Jan 2025 10:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QMbEoOc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5DA80756; Fri, 17 Jan 2025 10:16:50 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9746180737
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c4868038d4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=oNvY6p9l6KpPUs/tnJF1uhRM+MPkheA1D46i4B0Xz/M=; 
 b=QMbEoOc4T4YeqpHL78f+D6Pe5dm94NFzuZ3KJQ9TzDYXGv9MF+3Tm/EvEzTUXIZkCLVQQhkn+RKBgI3OHjXvu65dgIpZkryeqG0iMEjK8jhcZsusihpFJE6a9lCFwsJtsiFjhF+6vsJcIpCijl4TRscv1Ntdm7m2Db3TU6JfBss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:b8d8e147-815e-41b7-ad3b-cc0865f41f13, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:99380d0f-078a-483b-8929-714244d25c49,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c4868038d4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 729059657; Fri, 17 Jan 2025 17:16:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:16:41 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:16:41 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 02/15] clk: mediatek: fix uninitialized fields issue in
 INFRA_MUX struct
Date: Fri, 17 Jan 2025 17:16:38 +0800
Message-ID: <b394dcd3f4709566ae1379da6b41c4db26e8a855.1737104723.git.weijie.gao@mediatek.com>
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

This patch adds missing initialization of fields in INFRA_MUX struct
which caused uart broken after any other infra mux being enabled by
'clk_prepare_enable'

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 1 +
 drivers/clk/mediatek/clk-mt7986.c | 1 +
 drivers/clk/mediatek/clk-mt7988.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 97073918006..60814652322 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -359,6 +359,7 @@ static const struct mtk_parent infra_pcie_parents[] = {
 		.id = _id, .mux_reg = (_reg) + 0x8,                            \
 		.mux_set_reg = (_reg) + 0x0, .mux_clr_reg = (_reg) + 0x4,      \
 		.mux_shift = _shift, .mux_mask = BIT(_width) - 1,              \
+		.gate_shift = -1, .upd_shift = -1,			       \
 		.parent_flags = _parents, .num_parents = ARRAY_SIZE(_parents), \
 		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
 	}
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index c5cc77243d0..f9d6f9c1749 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -366,6 +366,7 @@ static const struct mtk_parent infra_pcie_parents[] = {
 		.id = _id, .mux_reg = (_reg) + 0x8,                            \
 		.mux_set_reg = (_reg) + 0x0, .mux_clr_reg = (_reg) + 0x4,      \
 		.mux_shift = _shift, .mux_mask = BIT(_width) - 1,              \
+		.gate_shift = -1, .upd_shift = -1,			       \
 		.parent_flags = _parents, .num_parents = ARRAY_SIZE(_parents), \
 		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
 	}
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 8f4e8f4e8c9..73fd9c6bea6 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -485,6 +485,7 @@ static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
 		.id = _id, .mux_reg = _reg + 0x8, .mux_set_reg = _reg + 0x0,   \
 		.mux_clr_reg = _reg + 0x4, .mux_shift = _shift,                \
 		.mux_mask = BIT(_width) - 1, .parent = _parents,               \
+		.gate_shift = -1, .upd_shift = -1,			       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
 		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_TOPCKGEN,             \
 	}
-- 
2.34.1

