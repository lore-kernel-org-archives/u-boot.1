Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A289D185F3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7643784142;
	Thu,  8 Jan 2026 14:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HOTWtGre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F28E884121; Thu,  8 Jan 2026 13:34:18 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FAD839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 83A27261FF;
 Thu,  8 Jan 2026 13:34:16 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVDqdbVruTlp; Thu,  8 Jan 2026 13:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767875655; bh=qL+5150/X1g42OZya3vckSWtiF/CRQRt9ZxdjySIXhE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HOTWtGrePJybtHHqj5OXTd5mwim4CIRDkoCi6XJHz8a3v8KXxIeg7kB9CUfEsgud1
 NzWwAu+kxW596iJYafnwQbI41cyVh5DxKWExJA9q0gOKUAgVT0FkazW5kfdadCzNCa
 0QTuNAllDNvJsh3yzd+l2cXneqYB1yS+ZUNd5ermpxSszEc5y+mPEwkTRYZLSjcPKE
 d1C0ZgEWWBiF6rI3DH5kIpCPOfaAO7V0fLwKp5wBBrrMAzUl+AqD0UACnXUMYWz7eN
 JoxxAY5Oe2ng/XKXpUogYc2YXXzSrD52w1BrPAKUtrk9i6as38vLIl2UF7SFqzFG1Q
 nWifGKZOxw4rg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 08 Jan 2026 18:03:44 +0530
Subject: [PATCH v3 1/2] usb: dwc3-generic: allow fallback of dr_mode
 property to "otg"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org>
References: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
In-Reply-To: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:07 +0100
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

Documentation [1] states that the default value of the dr_mode property
is "otg". It also isn't marked a mandatory node, so it may or may not be
set. So, accordingly if dr_mode is not mentioned in the devicetree node,
OTG mode must be assumed.

In this driver however, this case is not handled. If dr_mode is not
mentioned, USB_DR_MODE_UNKNOWN is set. The logic implemented raises an
error, instead of falling back to USB_DR_MODE_OTG. Correct this to
conform to the specification.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/tree/Bindings/usb/usb-drd.yaml?h=v6.18-dts [1]
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index c09014aec60..c15eda19e8f 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <reset.h>
 #include <asm/gpio.h>
+#include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <linux/delay.h>
 #include <linux/usb/gadget.h>
@@ -173,8 +174,8 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 		node = dev_ofnode(dev->parent);
 		plat->dr_mode = usb_get_dr_mode(node);
 		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
-			pr_err("Invalid usb mode setup\n");
-			return -ENODEV;
+			dev_info(dev, "No USB mode specified. Using 'otg'\n");
+			plat->dr_mode = USB_DR_MODE_OTG;
 		}
 	}
 
@@ -516,6 +517,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
+	/* usb mode must fallback to peripheral if not known */
+	if (dr_mode == USB_DR_MODE_UNKNOWN)
+		dr_mode = USB_DR_MODE_OTG;
+
 	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
 	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
 		debug("%s: dr_mode: OTG or Peripheral\n", __func__);

-- 
2.52.0

