Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D253EC3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 09:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8DE83236;
	Fri, 23 May 2025 11:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Cniizuxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE6283236; Fri, 23 May 2025 11:26:10 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BBD482E26
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f399c74c37b711f0813e4fe1310efc19-20250523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=TacWE92oE7xIC+ZYIEzSaH2C7F3SAv8Uurtf7PGEmZQ=; 
 b=CniizuxeMtxXEpwRoidU4CwNbqvaInZmqQqTfT87vvZjqz5w5KtveRlXCfyb/W1D8uPgv3n1V4vKb264TxznN6acjqJNasWGjz+abOjMLC4vXo8lGoNo/TPDfGH/0quD1ByLJ167m3JSaJammlmEyE8iHBXrpvOsF567oTvxMcQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:3f18504b-8e7f-47d4-8fb9-0902f8ea44f5, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:1e76a647-ee4f-4716-aedb-66601021a588,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f399c74c37b711f0813e4fe1310efc19-20250523
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1697903120; Fri, 23 May 2025 17:26:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 23 May 2025 17:26:02 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 23 May 2025 17:26:02 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 2/2] serial: mediatek: enable baudrate accuracy compensation
Date: Fri, 23 May 2025 17:26:02 +0800
Message-ID: <468db1225bb9e58bb7d4d08046dbddf5365574e2.1747991898.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1747991898.git.weijie.gao@mediatek.com>
References: <cover.1747991898.git.weijie.gao@mediatek.com>
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

The high-speed UART from MediaTek supports baudrate accuracy
compensation when using high-speed mode 3.

This is done by calculating the first digit of the fraction part of
sample count value. The fraction value will be then used as the
reference to insert 0 to 10 sample cycle(s) to one frame (assume
that frame format is 8n1, i.e. 10 bits per frame).

The fracdiv_[l/m] registers are used to determine whether a bit in one frame
should be inserted with one sample cycle.

With typical 40MHz source clock, the actual baudrates with/without
accuracy compensation are:

Ideal    w/o compensation w/ compensation
======== ================ ===============
9600     9603             9600
115200   114942           115207
921600   930232           921659
3000000  3076923          3007519

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/serial/serial_mtk.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 9d379f2e899..01cc415efdd 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -99,10 +99,18 @@ struct mtk_serial_priv {
 	bool upstream_highspeed_logic;
 };
 
+static const unsigned short fraction_l_mapping[] = {
+	0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
+};
+
+static const unsigned short fraction_m_mapping[] = {
+	0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
+};
+
 static void _mtk_serial_setbrg(struct mtk_serial_priv *priv, int baud,
 			       uint clk_rate)
 {
-	u32 quot, realbaud, samplecount = 1;
+	u32 quot, realbaud, samplecount = 1, fraction, frac_l = 0, frac_m = 0;
 
 	/* Special case for low baud clock */
 	if (baud <= 115200 && clk_rate == 12000000) {
@@ -147,7 +155,13 @@ use_hs3:
 		writel(3, &priv->regs->highspeed);
 
 		quot = DIV_ROUND_UP(clk_rate, 256 * baud);
-		samplecount = DIV_ROUND_CLOSEST(clk_rate, quot * baud);
+		samplecount = clk_rate / (quot * baud);
+
+		fraction = ((clk_rate * 100) / quot / baud) % 100;
+		fraction = DIV_ROUND_CLOSEST(fraction, 10);
+
+		frac_l = fraction_l_mapping[fraction];
+		frac_m = fraction_m_mapping[fraction];
 	}
 
 set_baud:
@@ -159,7 +173,11 @@ set_baud:
 
 	/* set highspeed mode sample count & point */
 	writel(samplecount - 1, &priv->regs->sample_count);
-	writel((samplecount - 2) >> 1, &priv->regs->sample_point);
+	writel((samplecount >> 1) - 1, &priv->regs->sample_point);
+
+	/* set baudrate fraction compensation */
+	writel(frac_l, &priv->regs->fracdiv_l);
+	writel(frac_m, &priv->regs->fracdiv_m);
 }
 
 static int _mtk_serial_putc(struct mtk_serial_priv *priv, const char ch)
-- 
2.34.1

