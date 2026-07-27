Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3327DC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F211140750;
	Mon, 27 Jul 2026 08:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-H7Wg7Cb7oN; Mon, 27 Jul 2026 08:18:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EF744073C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140310;
	bh=XyjNDeuXBzavyJcoSDeoDwcQv2io7C8ZbBnHURO2XpY=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z60Hj0AkY04UCJtVY4XLk8MQHwf/lDH9hbrIpHIN8nDsQbtNls6FuRWwqoHQXRG5O
	 hml85sK+TaO95sB+o63msYEQjDr4s4L8wH/wDc1ZwwcgWUecAXpeDpznzCaI3Bz4yp
	 c1ZEKm9NdVJZP5Q6wO+Y8bdHA9JyrXI2uh+vsauK8okmxKz9Wb77oMQrkdOj1L7jSe
	 uJyzzgkOEv5qVQmzTacgOTLxQSuCOdDWhKePEjl2l4Sfu2bRePLF0rwSqPa76Mq+B6
	 pIidIQ3MbvM7MH0FNlUnPWV3tspOgVxR/XwenYaAS/eU+XYjRorqHOshHCrsmPfwgH
	 bhYFUdqaf9myQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EF744073C;
	Mon, 27 Jul 2026 08:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2E8C2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4C7D80C94
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYZnMoxdwaOJ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:18:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC84180C85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC84180C85
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC84180C85
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:18:27 +0000 (UTC)
X-UUID: 7e6f3ca4899111f1b1788b6acf885367-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:342a8827-2f8d-427d-b11f-11aa095dc8d9, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:8a735a6, CLOUDID:3569431b-aedd-4a4f-a01a-460867678921,
 B
 ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
 DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e6f3ca4899111f1b1788b6acf885367-20260727
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1201061172; Mon, 27 Jul 2026 16:02:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Jul 2026 16:02:19 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Jul 2026 16:02:18 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] net: lwip: handle chained pbufs in transmit path
Date: Mon, 27 Jul 2026 16:02:17 +0800
Message-ID: <20260727080217.18208-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=XyjNDeuXBzavyJcoSDeoDwcQv2io7C8ZbBnHURO2XpY=; 
 b=PjdX3ZcRMIMW+MQH6qXltI3oBJ2nJRmhBCDisPLQGtq/pQd02Vo1h4hgI4jj9/c87BKtAf1fEDIp3HiwQv+NqdA4YcM7mjfe8/GlXtEuoPUvf5AcTwmEikTOCHKbot3VXjgKxXHI+FmHsdwwCDbyAFn72WW5t2Im2PxhrYcTckc=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=PjdX3ZcR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

LwIP may pass a packet to the netif linkoutput callback as a chain
of pbufs. In this case, p->len only describes the length of the
first pbuf, while p->tot_len describes the length of the whole
packet.

The current transmit path only sends the first pbuf. This can
truncate packets whose headers have already been generated for the
full packet length, resulting in malformed frames on the wire.
For example, the IP header may record a larger total length than the
actual Ethernet frame length.

Assemble chained pbufs into one aligned contiguous buffer before
passing the packet to the Ethernet driver.

Fixes: 98ad145db61a (net: lwip: add DHCP support and dhcp commmand)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 net/lwip/net-lwip.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index cfe5a6a640d..8f8f9d69020 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -40,28 +40,47 @@ char *pxelinux_configfile;
 static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 {
 	struct udevice *udev = netif->state;
-	void *pp = NULL;
+	bool pp_allocated = false;
+	u32 plen;
+	void *pp;
 	int err;
 
-	if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
-		printf("net_lwip_tx: %u bytes, udev %s\n", p->len, udev->name);
-		print_hex_dump("net_lwip_tx: ", 0, 16, 1, p->payload, p->len,
-			       true);
-	}
-
-	if ((unsigned long)p->payload % PKTALIGN) {
+	if ((unsigned long)p->payload % PKTALIGN || p->len != p->tot_len) {
 		/*
 		 * Some net drivers have strict alignment requirements and may
 		 * fail or output invalid data if the packet is not aligned.
+		 *
+		 * A packet may also be stored in multiple chained pbufs. In
+		 * this case, assemble the fragments into one contiguous packet
+		 * buffer before passing it to the Ethernet driver.
 		 */
-		pp = memalign(PKTALIGN, p->len);
+
+		pp = memalign(PKTALIGN, p->tot_len);
 		if (!pp)
-			return ERR_ABRT;
-		memcpy(pp, p->payload, p->len);
+			return ERR_MEM;
+
+		pp_allocated = true;
+
+		plen = pbuf_copy_partial(p, pp, p->tot_len, 0);
+		if (plen != p->tot_len) {
+			free(pp);
+			return ERR_BUF;
+		}
+	} else {
+		pp = p->payload;
+		plen = p->len;
+	}
+
+	if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
+		printf("net_lwip_tx: %u bytes, udev %s\n", plen, udev->name);
+		print_hex_dump("net_lwip_tx: ", 0, 16, 1, pp, plen, true);
 	}
 
-	err = eth_get_ops(udev)->send(udev, pp ? pp : p->payload, p->len);
-	free(pp);
+	err = eth_get_ops(udev)->send(udev, pp, plen);
+
+	if (pp_allocated)
+		free(pp);
+
 	if (err) {
 		debug("send error %d\n", err);
 		return ERR_ABRT;
-- 
2.45.2

