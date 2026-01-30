Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C5D73EAD
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0589484148;
	Fri, 30 Jan 2026 01:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EZRkSnvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBB484164; Fri, 30 Jan 2026 01:29:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1070684144
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732989; bh=FBQa4vmRtjYgDta+duPFBMv2/RXxsQF600VGfLzhpEU=;
 b=EZRkSnvJCGiNpeg8YVP1D1lybfE0DHIz/WIBhdICBucJEMXTABJJQdVX5ymW1JBQjMDgCff+r
 o8Bao8YTfN/vM2uWVYMlnK0ZO03Av5ny8o1qQlDh+ypFE3a3nxlI/el+c91gTch3MuolFxDseoN
 tEAY+ykHOs6OGuXlkRh3UeXDA1ya1GS1J+E8Mk3DsuG75Rq5Yjpp45GFG9TMyJfyJb0lOQ0vGQU
 N103tqTqzkqUDcm67q4azq0a/vG6GbVGWMaCxg9R12hxIBKk2ZY/i4WNPKeu3O90B/kxpAM3pTq
 IdocnkLTVXOtCi+D28zTKP4iMaq09/sVkIsF20cRUAmA==
X-Forward-Email-ID: 697bfb7b5af568bba11df3e4
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
Subject: [PATCH 1/6] usb: eth: asix88179: Use negative ECOMM return value
Date: Fri, 30 Jan 2026 00:29:26 +0000
Message-ID: <20260130002941.2336252-2-jonas@kwiboo.se>
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

The ASIX 88179 driver asix_read/write_cmd() return a positive error
value instead of a typical negative error value. This return value is
checked in the asix_read/write_mac() to control a debug() print and can
also propagate to probe() and write_hwaddr() ops.

Change to use a proper negative ECOMM return value when read/write a
command. Also update to use the ETH_ALEN const instead of 6 for
consistent use in asix_read/write_mac().

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 69d3073b669a..8915ef1fdc36 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -235,7 +235,7 @@ static int asix_write_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
 		size,
 		USB_CTRL_SET_TIMEOUT);
 
-	return len == size ? 0 : ECOMM;
+	return len == size ? 0 : -ECOMM;
 }
 
 static int asix_read_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
@@ -260,15 +260,16 @@ static int asix_read_cmd(struct ueth_data *dev, u8 cmd, u16 value, u16 index,
 
 	memcpy(data, buf, size);
 
-	return len == size ? 0 : ECOMM;
+	return len == size ? 0 : -ECOMM;
 }
 
 static int asix_read_mac(struct ueth_data *dev, uint8_t *enetaddr)
 {
 	int ret;
 
-	ret = asix_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, 6, 6, enetaddr);
-	if (ret < 0)
+	ret = asix_read_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID,
+			    ETH_ALEN, ETH_ALEN, enetaddr);
+	if (ret)
 		debug("Failed to read MAC address: %02x\n", ret);
 
 	return ret;
@@ -278,9 +279,9 @@ static int asix_write_mac(struct ueth_data *dev, uint8_t *enetaddr)
 {
 	int ret;
 
-	ret = asix_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
-				 ETH_ALEN, enetaddr);
-	if (ret < 0)
+	ret = asix_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID,
+			     ETH_ALEN, ETH_ALEN, enetaddr);
+	if (ret)
 		debug("Failed to set MAC address: %02x\n", ret);
 
 	return ret;
-- 
2.52.0

