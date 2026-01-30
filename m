Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4AAD73E87
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1BAC84180;
	Fri, 30 Jan 2026 01:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mGktec/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F8484158; Fri, 30 Jan 2026 01:29:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFAB384158
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732994; bh=yqMiYqOm+POYlsMZj+X9ZIVAYXAaeEKJZQN8G+Dw9Wc=;
 b=mGktec/vwUAdut937nfg5fQ/Fbvqe8D+lOCsRXxVujKTuPNYPhsXzX3lpLeR9bETpFYpNmJoH
 esji2kfiXa90WWsuJffq5kKAXpVaOV+kP79a/H6cUbdBTeUYAEL5eXrCd7qSMYIDQa582OHcyBT
 Ek9qhOceGMGcvfQnwOtYQcocI889roRnxwUEXhCxqO60PmKdfmwREdHFtSDlVCiXH0ibUsaHvnt
 42bLYtkGBfeLmsmYstbha7bDQLGK/dGy0kVKFuWGMZmLqRXVM/Y1v88fAdLd0HC14Ie3TqhFSyW
 4itjvKGWjOYPQydNSK7WvxtYsRxpWyU+hCg65pzdVHGQ==
X-Forward-Email-ID: 697bfb805af568bba11df41a
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
Subject: [PATCH 3/6] usb: eth: asix88179: Make functions static and align
 params
Date: Fri, 30 Jan 2026 00:29:28 +0000
Message-ID: <20260130002941.2336252-4-jonas@kwiboo.se>
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

Make internal functions static, align function parameters and drop
unnecessary != 0 checks to cleanup code.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 6da509175480..7d7cdeb60ebf 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -414,7 +414,7 @@ static int asix_wait_link(struct ueth_data *dev)
 }
 
 static int asix_init_common(struct ueth_data *dev,
-			struct asix_private *dev_priv)
+			    struct asix_private *dev_priv)
 {
 	u8 buf[2], tmp[5], link_sts;
 	u16 *tmp16, mode;
@@ -426,14 +426,14 @@ static int asix_init_common(struct ueth_data *dev,
 	/* Configure RX control register => start operation */
 	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
 		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
-	if (asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16) != 0)
+	if (asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16))
 		goto out_err;
 
-	if (asix_wait_link(dev) != 0) {
+	if (asix_wait_link(dev)) {
 		/*reset device and try again*/
 		printf("Reset Ethernet Device\n");
 		asix_basic_reset(dev, dev_priv);
-		if (asix_wait_link(dev) != 0)
+		if (asix_wait_link(dev))
 			goto out_err;
 	}
 
@@ -484,8 +484,8 @@ out_err:
 }
 
 static int asix_send_common(struct ueth_data *dev,
-			struct asix_private *dev_priv,
-			void *packet, int length)
+			    struct asix_private *dev_priv,
+			    void *packet, int length)
 {
 	int err;
 	u32 packet_len, tx_hdr2;
@@ -530,7 +530,7 @@ static int ax88179_eth_start(struct udevice *dev)
 	return asix_init_common(&priv->ueth, priv);
 }
 
-void ax88179_eth_stop(struct udevice *dev)
+static void ax88179_eth_stop(struct udevice *dev)
 {
 	struct asix_private *priv = dev_get_priv(dev);
 	struct ueth_data *ueth = &priv->ueth;
@@ -543,14 +543,14 @@ void ax88179_eth_stop(struct udevice *dev)
 	priv->pkt_hdr = NULL;
 }
 
-int ax88179_eth_send(struct udevice *dev, void *packet, int length)
+static int ax88179_eth_send(struct udevice *dev, void *packet, int length)
 {
 	struct asix_private *priv = dev_get_priv(dev);
 
 	return asix_send_common(&priv->ueth, priv, packet, length);
 }
 
-int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
+static int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct asix_private *priv = dev_get_priv(dev);
 	struct ueth_data *ueth = &priv->ueth;
@@ -630,7 +630,7 @@ static int ax88179_free_pkt(struct udevice *dev, uchar *packet, int packet_len)
 	return 0;
 }
 
-int ax88179_write_hwaddr(struct udevice *dev)
+static int ax88179_write_hwaddr(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct asix_private *priv = dev_get_priv(dev);
-- 
2.52.0

