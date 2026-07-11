Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B289C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD5384A63;
	Sat, 11 Jul 2026 18:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="v0XXtmud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A483384A3C; Sat, 11 Jul 2026 18:08:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDF584A5D
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786126; bh=VTdV8+SDIO9lNch1aBa1Jf7YpN4hbpx7oO5WDHNbVvg=;
 b=v0XXtmud70sCa1V8nOi1g97KeC69Tn7bRtDPhaMXzB23bgGgTIEyt1hJltPAMW3yrTHlHisFX
 Q+A2AbPUPmzU1X02Q68xoQGX6skRJHZ/b0kO5nZuD1ik4Z/TYcfvgzboARL2r9YJA9rkB6sMGQZ
 Y2c2qrRKvqQSurByXpzFrgFglsYORFOFhqY1PQYHsd0zkbNJ8uy/iKImgHPcB0IzLOJRz52jfka
 VzIavFtmwWns6SUqTy2/u1g2KKaXQf2PGH7bEYYvWFj6I8xPiNkMKB59lzA/QL2I+bPmZO7K560
 vFHbS2ZMzDS8kRrVzrHqDl1g2CetB+28grKXCUbIhfog==
X-Forward-Email-ID: 6a526a8b1b09fea89cb12556
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 7/8] usb: eth: Bind ASIX AX88179A/AX88772D/AX88279 to CDC
 ECM/NCM driver
Date: Sat, 11 Jul 2026 16:08:05 +0000
Message-ID: <20260711160808.2022242-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711160808.2022242-1-jonas@kwiboo.se>
References: <20260711160808.2022242-1-jonas@kwiboo.se>
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

The ASIX AX88179A, AX88772D and AX88279 USB Ethernet controller
revisions has both CDC ECM and CDC NCM support.

  AX88179:  0b95:1790 1.00
  AX88179A: 0b95:1790 2.00
  AX88772D: 0b95:1790 3.00
  AX88279:  0b95:1790 4.00

Prefer using the CDC NCM or CDC ECM driver for the 2.00-4.00 version
range of the 0b95:1790 ASIX USB Ethernet controllers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 5 +++++
 drivers/usb/eth/cdc_ecm.c   | 3 +++
 drivers/usb/eth/cdc_ncm.c   | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 69d3073b669a..5f496afa5f21 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -691,7 +691,12 @@ U_BOOT_DRIVER(ax88179_eth) = {
 };
 
 static const struct usb_device_id ax88179_eth_id_table[] = {
+#if IS_ENABLED(CONFIG_USB_ETHER_CDC_ECM) || IS_ENABLED(CONFIG_USB_ETHER_CDC_NCM)
+	{ USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0100),
+		.driver_info = FLAG_TYPE_AX88179 },
+#else
 	{ USB_DEVICE(0x0b95, 0x1790), .driver_info = FLAG_TYPE_AX88179 },
+#endif
 	{ USB_DEVICE(0x0b95, 0x178a), .driver_info = FLAG_TYPE_AX88178a },
 	{ USB_DEVICE(0x2001, 0x4a00), .driver_info = FLAG_TYPE_DLINK_DUB1312 },
 	{ USB_DEVICE(0x0df6, 0x0072), .driver_info = FLAG_TYPE_SITECOM },
diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
index 115152e4964a..3d2212be73cc 100644
--- a/drivers/usb/eth/cdc_ecm.c
+++ b/drivers/usb/eth/cdc_ecm.c
@@ -276,6 +276,9 @@ U_BOOT_DRIVER(usb_cdc_2_ecm) = {
 };
 
 static const struct usb_device_id cdc_ecm_id_table[] = {
+	/* ASIX AX88179A, AX88772D, AX88279 */
+	{ USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0400), },
+	/* CDC ECM */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			     USB_CDC_PROTO_NONE), },
 	{ /* sentinel */ }
diff --git a/drivers/usb/eth/cdc_ncm.c b/drivers/usb/eth/cdc_ncm.c
index 2ce3ac37b2f0..eb2ec5e6babd 100644
--- a/drivers/usb/eth/cdc_ncm.c
+++ b/drivers/usb/eth/cdc_ncm.c
@@ -472,6 +472,9 @@ U_BOOT_DRIVER(usb_cdc_1_ncm) = {
 };
 
 static const struct usb_device_id cdc_ncm_id_table[] = {
+	/* ASIX AX88179A, AX88772D, AX88279 */
+	{ USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0400), },
+	/* CDC NCM */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_NCM,
 			     USB_CDC_PROTO_NONE), },
 	{ /* sentinel */ }
-- 
2.54.0

