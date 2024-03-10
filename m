Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6444AC54E49
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 18:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E55879FC;
	Sun, 10 Mar 2024 19:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F/NARuI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF48879FC; Sun, 10 Mar 2024 19:51:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F56875FC
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 19:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=14bd=KR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710096686; bh=oZaYqsaj704RJC7AgOAPON3rLrff49NodK3Lgqjdd6o=;
 b=F/NARuI0CIs4hR2y1vGDKUArj5RCCBGaOB7I0t7rburvVsWtk1wo//q4HOP170vuoHr88vCLl
 Li4gYhP/J+YnRw2Om79/WxwiBpQZAv34yHR+Sjeeh/kDrMKeBIQvdlPJjOU35vJTTlRl2hAM4uL
 7uL6DFTuMDISFDlYRg7PryHmsAr/dcLHDfQ3RO1OXNd0x2Ax/iAdFwnBUk90JpiPycxfRDHs5cl
 FTriTVgwA4CgHCWwTuEVg/br46KGkO9m4S4jAJT6gmO6PE1eJcG6nlyCy113EPEUNo0gq0DKEUO
 W3kNBqCSSk79j9Hm8bQHElDOuNeYsY9fj026OB8m0gHA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/4] rockchip: board: Use a common USB Product ID for UMS
Date: Sun, 10 Mar 2024 18:50:59 +0000
Message-ID: <20240310185106.665553-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310185106.665553-1-jonas@kwiboo.se>
References: <20240310185106.665553-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65ee012c5e98868d918e8ef4
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- No change
- Collect r-b tag
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
2.43.2

