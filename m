Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9350D73EA9
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E818418A;
	Fri, 30 Jan 2026 01:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jr1QRB2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4C684114; Fri, 30 Jan 2026 01:30:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AC784166
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732999; bh=AgH4lnyVoMfF0u3+kkX578xRnqQypL5ujDKKNdM624U=;
 b=jr1QRB2ppgmEotLiAP1skVVQvawIf6YubKrL2VORKiz36VSDmq/yQH85hPL8quYY0VexUgbil
 bfckzap+mEBXa3IWjpDjeYx9/4wreIU5Vp7cmYn1qdR9gS8wmZiuBk7IwLH7t2+Eo5zOk8cINbB
 dBKK7509VNiTXSqBQONWbIl++9j9aoxj2JMe3gY7hj4nJFwcl21TbU6CUY5Bt8OJrrC+KqPwA19
 qd/f0ppYA+GM7Y2YnjoRxa8VBvugxJ+kNu+HIKGERrahpxa3LE+wI0OGHOE3+IFPcnVmXQkOYUS
 CxBAfpXQ7NcVH+QZC78tg7/PHofZC+BOwDtY28zpx1cQ==
X-Forward-Email-ID: 697bfb845af568bba11df456
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/6] usb: eth: asix88179: Refactor ax88179_eth_recv() to
 closer match Linux
Date: Fri, 30 Jan 2026 00:29:30 +0000
Message-ID: <20260130002941.2336252-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130002941.2336252-1-jonas@kwiboo.se>
References: <20260130002941.2336252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Refactor ax88179_eth_recv() to closer match the Linux ASIX AX88xxx
driver variant.

This change has a minor intended functional change, e.g. it enforces
that packets flagged as DROP or CRC_ERR is fully skipped.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index a9dff23e83bb..1ce90eb794cd 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -547,6 +547,7 @@ static int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct ueth_data *ueth = &priv->ueth;
 	int ret, len;
 	u16 pkt_len;
+	u32 pkt_hdr;
 
 	/* No packet left, get a new one */
 	if (priv->pkt_cnt == 0) {
@@ -570,34 +571,29 @@ static int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 		}
 
 		if (len < 4) {
-			usb_ether_advance_rxbuf(ueth, -1);
-			return -EMSGSIZE;
-		}
-
-		rx_hdr = *(u32 *)(ptr + len - 4);
-		le32_to_cpus(&rx_hdr);
-
-		pkt_cnt = (u16)rx_hdr;
-		if (pkt_cnt == 0) {
 			usb_ether_advance_rxbuf(ueth, -1);
 			return 0;
 		}
 
+		rx_hdr = get_unaligned_le32(ptr + len - 4);
+		pkt_cnt = (u16)rx_hdr;
 		hdr_off = (u16)(rx_hdr >> 16);
-		if (hdr_off > len - 4) {
+
+		if (pkt_cnt == 0 || pkt_cnt * 4 + hdr_off > len) {
 			usb_ether_advance_rxbuf(ueth, -1);
-			return -EIO;
+			return 0;
 		}
 
 		priv->pkt_cnt = pkt_cnt;
 		priv->pkt_data = ptr;
 		priv->pkt_hdr = (u32 *)(ptr + hdr_off);
-		debug("%s: %d packets received, pkt header at %d\n",
-		      __func__, (int)priv->pkt_cnt, (int)hdr_off);
+		debug("%s: %u packets received, pkt header at %u\n",
+		      __func__, priv->pkt_cnt, hdr_off);
 	}
 
-	le32_to_cpus(priv->pkt_hdr);
-	pkt_len = (*priv->pkt_hdr >> 16) & 0x1fff;
+	pkt_hdr = *priv->pkt_hdr;
+	le32_to_cpus(&pkt_hdr);
+	pkt_len = (pkt_hdr >> 16) & 0x1fff;
 
 	*packetp = priv->pkt_data + 2;
 
@@ -605,8 +601,11 @@ static int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	priv->pkt_cnt--;
 	priv->pkt_hdr++;
 
-	debug("%s: return packet of %d bytes (%d packets left)\n",
-	      __func__, (int)pkt_len, priv->pkt_cnt);
+	if (pkt_hdr & (AX_RXHDR_DROP_ERR | AX_RXHDR_CRC_ERR))
+		pkt_len = 0;
+
+	debug("%s: return packet of %u bytes (%u packets left)\n",
+	      __func__, pkt_len, priv->pkt_cnt);
 	return pkt_len;
 }
 
-- 
2.52.0

