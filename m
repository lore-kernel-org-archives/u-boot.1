Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B618CC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 23:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC06C87F6E;
	Tue, 27 Feb 2024 00:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JbsZ1YjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF7C87F92; Tue, 27 Feb 2024 00:08:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2022487EFE
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 00:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b6e=KE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708988917; bh=BtaGJ+ycF+I5DpWCk5w8dioaQZKaipOXTxbEei9y7FU=;
 b=JbsZ1YjXs6g+fk5O2cJFv/5Qo0jQTOi30wemE3GvYempvyrxHQMfDtHkBL/gFpZeGw2iGuHyx
 9DFMqdn8diG+NodEgPFQO6bHqPIDH6IC218OhEAyKDF9OwthuGnoQaH8U76+f4GyPvOOo2czZJh
 jvh9oA83lIh6X9pvvblNFwEMPuOGB9xanQVyKHvS9/QvmPvM+WoeccZyFI+C5s/S7ktXvXflGqE
 sZcfgnBzMT7/K7oqQ8k+72Q6XxdCLZgcWqEO9kIDp6j65HS5/Mdz8mtFBIHUug0fyePHKXMu7Lo
 HQNkkXxp1XBqO7SogrJ4qkIfBxG2fkfVW41CakCJocWw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 3/4] rockchip: board: Use a common USB Product ID for UMS
Date: Mon, 26 Feb 2024 23:08:15 +0000
Message-ID: <20240226230822.2430391-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226230822.2430391-1-jonas@kwiboo.se>
References: <20240226230822.2430391-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dd19f481fb330034973f20
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

Change to use the common Product ID 0x0010 when the ums command is used.

This matches downstream vendor U-Boot and is a Product ID that tools
such as rkdeveloptool and RKDevTool will identify as MSC mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/board.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index f84ff542aea9..e9cfba756639 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -221,8 +221,23 @@ void enable_caches(void)
 #endif
 
 #if IS_ENABLED(CONFIG_USB_GADGET)
-#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
 #include <usb.h>
+
+#if IS_ENABLED(CONFIG_USB_GADGET_DOWNLOAD)
+#define ROCKCHIP_G_DNL_UMS_PRODUCT_NUM	0x0010
+
+int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
+{
+	if (!strcmp(name, "usb_dnl_ums"))
+		put_unaligned(ROCKCHIP_G_DNL_UMS_PRODUCT_NUM, &dev->idProduct);
+	else
+		put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM, &dev->idProduct);
+
+	return 0;
+}
+#endif /* CONFIG_USB_GADGET_DOWNLOAD */
+
+#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
 #include <linux/usb/otg.h>
 #include <usb/dwc2_udc.h>
 
-- 
2.43.0

