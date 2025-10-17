Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E53CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA32839F1;
	Fri, 17 Oct 2025 17:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hSWe9rFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D938383F; Fri, 17 Oct 2025 17:30:45 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5857383826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 29CE62625B;
 Fri, 17 Oct 2025 17:30:43 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coH3V3O0jfsr; Fri, 17 Oct 2025 17:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760715042; bh=G5Ks94YE1JDolNckNgjOL5kKnsttuu8SxV3Ga7bkZrE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hSWe9rFsYQDHbPFryBkGXq/jq5yFtl95VW81yo8rz6slYZSvarSXXZo3tYx5L77RX
 NuB645Fye1VaA9+PPzWCVHGJwpa+ZtH6m0tesna5pEuL0iJsOEZjltBtnuyvhYumiK
 fyVuTF0Z48Gw6lAsUB43k9vi0XN8+eQ9yxxoL5Ga8tcUN43JRy51Ji3xbRkvbGNu7z
 f7StjftfsZzBGEs/3mUVNkr6oNu9CrNmXAF769dNslqQo/0wjFWHxThr8MMfBpHLmH
 4aK3qkGg+fosQaaxT6+8K8leV8RepvjoaZMXGVwfgAKgzmuxDxTfrGmDRL046KqrDM
 gr7vF0qveYvRw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 21:00:16 +0530
Subject: [PATCH 1/2] usb: dwc3-generic: allow fallback of dr_mode property
 to "otg"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
In-Reply-To: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760715023; l=1599;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=G5Ks94YE1JDolNckNgjOL5kKnsttuu8SxV3Ga7bkZrE=;
 b=spA7su/Y8OUJaK9A5cxJRHXhnWoaEUef/euVuEA/zob2NfXxFuhrxQCNCb+2gt74ooxxQZeY5
 +ZcmGyzgMC9DGjpgqg+mPOJl5jW4RkqKP8fDHK5IO87Vz6Fqq73FY2O
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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
is "otg". In this driver however, this case is not handled. Add simple
logic to fall back to USB_DR_MODE_OTG if its reported to be
USB_DR_MODE_UNKNOWN.

Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index c09014aec60d1ea48afa3bd065d3f1f9672b8633..1967594f48ab40963463e6f17ed58ec45ce5867c 100644
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
2.51.0

