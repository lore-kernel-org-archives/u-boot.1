Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FCC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 08:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C41084B37;
	Wed, 15 Jul 2026 10:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="a0FgDIG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F243084B70; Wed, 15 Jul 2026 10:42:51 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB83C84B32
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 238fbe60802911f1b1788b6acf885367-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=XyjNDeuXBzavyJcoSDeoDwcQv2io7C8ZbBnHURO2XpY=; 
 b=a0FgDIG7nbQTStjAURSBr6dwENdaCh2yjAepaafdakq5Z31pOlEIm/yOWWa1qI7P8BrncJGndFZS7cK2eA4SKkQFYuB+urkm7fItfMFqHPLKUyBQoT0c5dElycG7Pd+DcxO/ejOGC57RgNhpKjhExePH6XxsXNasphPqGbR19jo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:3ec3c9bb-8691-4323-bf03-f474f1a13ac2, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:d497b38, CLOUDID:6163b837-7759-43a9-ae06-f4df9d53bea1,
 B
 ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
 DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 238fbe60802911f1b1788b6acf885367-20260715
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2070932521; Wed, 15 Jul 2026 16:42:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Jul 2026 16:42:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Jul 2026 16:42:38 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] net: lwip: handle chained pbufs in transmit path
Date: Wed, 15 Jul 2026 16:42:36 +0800
Message-ID: <20260715084236.172815-1-weijie.gao@mediatek.com>
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

