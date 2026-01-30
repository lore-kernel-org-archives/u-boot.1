Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F325D73EA9
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 576208418C;
	Fri, 30 Jan 2026 01:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gfnip5B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6923A84178; Fri, 30 Jan 2026 01:30:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BC384175
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732996; bh=nnjP4Io+T8pGyr8qTSO69eMekHXw91DNclEJz3fLgEU=;
 b=gfnip5B11Ldt0sM3klCJ/3Pys2j05MK+hudW3ShQFqyCXt1SQrE29M7XrppS6DKEvNm9+CLj8
 rcW8kQVEU1ZdUZBZR65FB0FxzgqN/UXNI42DKQX9b2iRjd247i7i7bc5g7ekNTnR2i1Ft51CD06
 j5uVLrYhXCXSi+qJOwNP+n1Xuj1MPJSHhppuhpQ59sMDCj3mimfNDFnAH5HrwrKEXrz4rAkSq9S
 4c9e3t6OSBjzVwUuSfDZitRQIePoQBSRD0BFYJ2ojObmiSSxTidUsean8wAzV6sjteQ4GbwRoQg
 EO54gK9faQGoayz3yGZ88gOH/Yw39k6FapfCwYsAfRQw==
X-Forward-Email-ID: 697bfb825af568bba11df43b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH 4/6] usb: eth: asix88179: Refactor asix_send_common() to
 closer match Linux
Date: Fri, 30 Jan 2026 00:29:29 +0000
Message-ID: <20260130002941.2336252-5-jonas@kwiboo.se>
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

Refactor asix_send_common() to closer match the Linux variant.

This change has no intended functional change, it only makes the code
closer match the Linux ASIX AX88xxx driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 43 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 7d7cdeb60ebf..a9dff23e83bb 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -487,40 +487,31 @@ static int asix_send_common(struct ueth_data *dev,
 			    struct asix_private *dev_priv,
 			    void *packet, int length)
 {
-	int err;
-	u32 packet_len, tx_hdr2;
-	int actual_len, framesize;
-	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, msg,
-				 PKTSIZE + (2 * sizeof(packet_len)));
+	u32 tx_hdr1, tx_hdr2;
+	int actual_len, ret;
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, msg, PKTSIZE + 8);
 
 	debug("** %s(), len %d\n", __func__, length);
 
-	packet_len = length;
-	cpu_to_le32s(&packet_len);
-
-	memcpy(msg, &packet_len, sizeof(packet_len));
-	framesize = dev_priv->maxpacketsize;
+	tx_hdr1 = length;
 	tx_hdr2 = 0;
-	if (((length + 8) % framesize) == 0)
+	if (((length + 8) % dev_priv->maxpacketsize) == 0)
 		tx_hdr2 |= 0x80008000;	/* Enable padding */
 
-	cpu_to_le32s(&tx_hdr2);
-
-	memcpy(msg + sizeof(packet_len), &tx_hdr2, sizeof(tx_hdr2));
+	put_unaligned_le32(tx_hdr1, msg);
+	put_unaligned_le32(tx_hdr2, msg + 4);
+	memcpy(msg + 8, packet, length);
 
-	memcpy(msg + sizeof(packet_len) + sizeof(tx_hdr2),
-	       (void *)packet, length);
+	ret = usb_bulk_msg(dev->pusb_dev,
+			   usb_sndbulkpipe(dev->pusb_dev, dev->ep_out),
+			   msg,
+			   length + 8,
+			   &actual_len,
+			   USB_BULK_SEND_TIMEOUT);
+	debug("Tx: len = %u, actual = %u, err = %d\n",
+	      length + 8, actual_len, ret);
 
-	err = usb_bulk_msg(dev->pusb_dev,
-				usb_sndbulkpipe(dev->pusb_dev, dev->ep_out),
-				(void *)msg,
-				length + sizeof(packet_len) + sizeof(tx_hdr2),
-				&actual_len,
-				USB_BULK_SEND_TIMEOUT);
-	debug("Tx: len = %zu, actual = %u, err = %d\n",
-	      length + sizeof(packet_len), actual_len, err);
-
-	return err;
+	return ret;
 }
 
 static int ax88179_eth_start(struct udevice *dev)
-- 
2.52.0

