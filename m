Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E83C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311F284A73;
	Sat, 11 Jul 2026 18:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uQtULF31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F3C84A7B; Sat, 11 Jul 2026 18:08:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEFD84A3C
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786129; bh=Kv7I4nYYBmkZahReRXqQ6+5+3Fw49BWyyNQjuHzySA0=;
 b=uQtULF31ZRDSN57t4kVFwTJ1r+b7cBIIsKSuNvwuMO15bylk/NztADbWUmpYDn05yrSufQC3M
 Ky36DyuU5poY3xtLf7GgqriJVgCPb0tuV7GUtl+zux2znSHYP2bCm2GAioAXKvzRX5rm/Z0VnRV
 D8YRLISUpUFvZwZ6hkzxvExt1xc9zTqcRU9cFjLNYkZ50laNpeEAFP6IFh4oO45dGFwAQ0Qwywg
 aIjwLKeCo8GCsTW3bWY+fpIWQxelK+r88usBh+W7BnV6fU507pEH7YZbVJVlzixtEEJxZns7lOu
 ABQFOzwEyzWenx65UcoPnqu8XrFrzrorAvqzRL3LZ3UA==
X-Forward-Email-ID: 6a526a8e1b09fea89cb12571
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH 8/8] usb: eth: Bind Realtek RTL815x to CDC ECM driver
Date: Sat, 11 Jul 2026 16:08:06 +0000
Message-ID: <20260711160808.2022242-9-jonas@kwiboo.se>
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

The Realtek RTL815x Ethernet controllers have CDC ECM support. The
RTL8156 and RTL8157 also have CDC NCM support, however RTL8157 fails to
signal Network Connection status on demand.

Bind the Realtek RTL815x Ethernet controllers to the CDC ECM driver. The
driver is sorted last so should work as a fallback after the r8152
driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/cdc_ecm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
index 3d2212be73cc..992eb7ba9cfd 100644
--- a/drivers/usb/eth/cdc_ecm.c
+++ b/drivers/usb/eth/cdc_ecm.c
@@ -278,6 +278,11 @@ U_BOOT_DRIVER(usb_cdc_2_ecm) = {
 static const struct usb_device_id cdc_ecm_id_table[] = {
 	/* ASIX AX88179A, AX88772D, AX88279 */
 	{ USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0400), },
+	/* Realtek RTL8152, RTL8153, RTL8156, RTL8157 */
+	{ USB_DEVICE(0x0bda, 0x8152), },
+	{ USB_DEVICE(0x0bda, 0x8153), },
+	{ USB_DEVICE(0x0bda, 0x8156), },
+	{ USB_DEVICE(0x0bda, 0x8157), },
 	/* CDC ECM */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			     USB_CDC_PROTO_NONE), },
-- 
2.54.0

