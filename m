Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAFEFC6160
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 14:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E028A83AAD;
	Sat,  3 Jan 2026 15:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PUAblFlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8F883B6C; Sat,  3 Jan 2026 13:29:41 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C4583B49
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 13:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 781C3261B7;
 Sat,  3 Jan 2026 13:29:38 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4_ssyhFg4_c; Sat,  3 Jan 2026 13:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767443377; bh=bjxlbsUNsPEalK87l3dqYb0K419usgCFE/sz7dow0TI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PUAblFlN9+3X4Mm0fkTtg/gLVyxrBgPFhkzFKxVauVUWZ+eN8QWf+jjRvoReLkr8/
 42LZ5MV4U9gEdyEEnN17yQz3mNGw3shnkzy6l4S8q6gu5Y/UAVcToy4fEgCZ3zsV51
 UrZFEmT9cHXpYh6bFe67VjnAteqbXjBuaM3/cEVZJawH0FehTYEYcaM5CfbToodeoj
 gwuGD8x8Jn+mSOQFcYgakaCAZZp8FYV6ZKUwWweoPiNGc3KB5dOg+fFQaFTHNQWQ9w
 oSB7prhRabZ7erSS5W8rvhO0euSJfMOcvH/bvxtpL0KF+imnQz/WDZlRnyZ6LST79D
 5VC3KkR00HZiQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 03 Jan 2026 17:58:54 +0530
Subject: [PATCH v2 1/2] usb: dwc3-generic: allow fallback of dr_mode
 property to "otg"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-usb-dwc3-exynos7870-v2-1-67441680d287@disroot.org>
References: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
In-Reply-To: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sat, 03 Jan 2026 15:42:31 +0100
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

Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index c09014aec60..1967594f48a 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -173,8 +173,8 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 		node = dev_ofnode(dev->parent);
 		plat->dr_mode = usb_get_dr_mode(node);
 		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
-			pr_err("Invalid usb mode setup\n");
-			return -ENODEV;
+			pr_info("No USB mode specified. Using 'otg'\n");
+			plat->dr_mode = USB_DR_MODE_OTG;
 		}
 	}
 
@@ -516,6 +516,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
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

