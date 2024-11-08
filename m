Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F58D5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A2F892DB;
	Fri,  8 Nov 2024 14:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="H6uhcRVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832C088113; Fri,  8 Nov 2024 06:52:13 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330DD88EC6
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 06:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1731045124; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ibRtCKlylOi2m1ttzb5GTZOHFP/NAN+vJtVksMMm0XLZ689Nh4HfmM1JgG7/gHaOS9PTclqaDSFNnLLbeWGuOdvyb/TAPVoZsHSPLaSdZMhP046zHSJjDbJrbwjPfxbivJdOGx8ZcXBlAFZZtEI9uBqs/zab3uverpG5i4OHybo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731045124;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=13M1lNBLesFzSQn0LYalG7iS4rpZhZpBEnhRTyaAtks=; 
 b=YRnPCYGGrhKVN5nCEL2R7qsb1EASq8R1rE43ypRVFXpE6oCizrYsTPYQxHKf5Aq1xt0Js8QXgrkwcKrr5Wk48LntqAjZgJUJV6xBbzYjK/ajGVi7RBxOy2yfQunxdjo3pBJsKPa6RrZ9mKrgLTPEjsK8fh7TaSkC+Pc2G+8QiAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731045124; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=13M1lNBLesFzSQn0LYalG7iS4rpZhZpBEnhRTyaAtks=;
 b=H6uhcRVE1BZ3B/a4CK2VU8AO4+p4N5+/NkdTH8G/kkNwe/mClat6gTh7LnXde61Z
 oujLzX5GgTae/Bvyk1J7P/z2za2GV6Fj8RPjq4bHLPfGLgY7cfn3TYufc4n+JUl4ZSv
 liZSl5Bs09QAHPCmrqJonFcTNSxySvtcGHcyLPLk=
Received: by mx.zohomail.com with SMTPS id 1731045122677767.1927025752368;
 Thu, 7 Nov 2024 21:52:02 -0800 (PST)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH v2 2/2] eth: asix88179: packet drop when receiving large
 fragmented packets
Date: Thu,  7 Nov 2024 21:51:36 -0800
Message-Id: <20241108055136.50701-3-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241108055136.50701-1-admin@khoahoang.com>
References: <20241108055136.50701-1-admin@khoahoang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

The ASIX 88179A drops packets when receiving fragmented packets larger
than the MTU size due to an insufficient URB buffer size. This change
synchronizes the URB buffer size with the configuration used in the
Linux kernel, resolving the packet drop issue.

To reproduce the issue, set the following configuration:
    CONFIG_IP_DEFRAG=y
    CONFIG_TFTP_BLOCKSIZE=16352

Then, run the `tftp` command. It will fail with a timeout error:

    U-Boot> tftp zero.bin
    Using ax88179_eth device
    TFTP from server 10.0.0.196; our IP address is 10.0.0.18
    Filename 'zero.bin'
    Load address: 0x10000000
    Loading: T T T T T T T T T T T
    Retry count exceeded; starting again

Signed-off-by: Khoa Hoang <admin@khoahoang.com>
---
 drivers/usb/eth/asix88179.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 4bd353b9..69d3073b 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -173,7 +173,7 @@
 #define USB_BULK_SEND_TIMEOUT 5000
 #define USB_BULK_RECV_TIMEOUT 5000
 
-#define AX_RX_URB_SIZE 1024 * 0x12
+#define AX_RX_URB_SIZE 1024 * 0x1a
 #define BLK_FRAME_SIZE 0x200
 #define PHY_CONNECT_TIMEOUT 5000
 #define PHY_RESET_TIMEOUT 500
@@ -193,10 +193,10 @@
 static const struct {
 	unsigned char ctrl, timer_l, timer_h, size, ifg;
 } AX88179_BULKIN_SIZE[] =	{
-	{7, 0x4f, 0,	0x02, 0xff},
-	{7, 0x20, 3,	0x03, 0xff},
-	{7, 0xae, 7,	0x04, 0xff},
-	{7, 0xcc, 0x4c, 0x04, 8},
+	{7, 0x4f, 0,	0x12, 0xff},
+	{7, 0x20, 3,	0x16, 0xff},
+	{7, 0xae, 7,	0x18, 0xff},
+	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
 /* driver private */
@@ -332,7 +332,7 @@ static int asix_basic_reset(struct ueth_data *dev,
 	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
 
-	dev_priv->rx_urb_size = 128 * 20;
+	dev_priv->rx_urb_size = 1024 * 20;
 
 	/* Water Level configuration */
 	*tmp = 0x34;
-- 
2.39.2

