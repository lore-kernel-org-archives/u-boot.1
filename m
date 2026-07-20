Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86813C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 07:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF2782991;
	Mon, 20 Jul 2026 09:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="BLRfTdNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20AA3838D7; Mon, 20 Jul 2026 09:53:29 +0200 (CEST)
Received: from mail-wr2-x02.google.com (mail-wr2-x02.google.com
 [IPv6:2a00:1450:4864:30::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B710780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr2-x02.google.com with SMTP id
 ffacd0b85a97d-4744516a312so1348246f8f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784534006; x=1785138806; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FzAchyy9u1UyjB+eEXlkD8TGJOqvd8rBdXjno/+M4RA=;
 b=BLRfTdNUWSQHwvjfoBaRAIykDmgKguCVemSKI7O0VhOYgxmgf0QJtob2ei9cVcykdh
 nlagG9O9FImKKN9J4MnzaxHAXYFx5yOXI9V0mKRhSTHN0xSDlfpk4vj1kFKg/vXAPxyd
 aITE+bZoLDMMEhCtFfZn4En/JkkpPPuFbZuDeFKzxfna96I4Cx6JO3m0cAuWpB82ByAu
 /wYrvLig3aXuhqlvBFQ01b8X995uB4MQ+LJN24DhCKOPGRlr7SyMo/w57S1U5ZKSrnnO
 UoHtEj1wWwI8hRXOg4SAmoVwyFe9eQiUGJDekDwSOZdGl6AjS/OgvJ3Kr471Mo6fXWDy
 5fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534006; x=1785138806;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FzAchyy9u1UyjB+eEXlkD8TGJOqvd8rBdXjno/+M4RA=;
 b=FUTQDMSxTskIvSSPnAZFLp+17+YnGJxs1a0MQ9Fimh9ygdK+1hUtvF3pavFkg5rL8+
 v3tG9GjGKAegrBdsrYLriZfgD5qSLGF/oWSTuG9vRgyI4hELGqJoyHXgBJCsSXSdTuGf
 uaYwP3WLiXhyLPIi6dkle0rbXMCzc1IUA++WNUKMVBMKYx6Vj9RCBdVlrvB0Zbrt3Z7A
 +3IXbNSw1BpgysgNlbeqIf4H76ZkPoR6Rpdt6qRVxjdPftbFv3RglpbkA+atT7prOzah
 I4H5Aym6THdkyykUvdEh+kP95fbX7ti/LoziQBmh4y6Wa4mLnibKDc8EWKx/h7yzBEzb
 WRCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ros7m7dOnW1GU6I3AEFb8NbbUeO6WM6ldAARzUAghgNgI5IFp1aZv5fsU6jQpnT+xP2QMdY9Kk=@lists.denx.de
X-Gm-Message-State: AOJu0YzViCTl14mAehb+xsC+ESRsWME4lOU5Wq1JPVCrxHMsSiYAJGFi
 QTg+U/2vUvnKcXc+aKgv8zhTUVlZhVzxuok1G3FQ2IFf9ho8uUIIwVMRyhNs70Bbhtg=
X-Gm-Gg: AfdE7clLXbh89WkawE3iDjrfaiWz4QKJhEw0Gg5VxwN2iibOxf+wwaWBit95vzwkHWs
 9XPHasnzmK2a/EsdRrEEshYNC0zaUfSjanCc67oC8dpcE3z8spMHKErCVsoFfpzjNZmfBNipkDk
 na8fct653O/8pyKnaHBvAz/V7+iWC5Lp5D6wdiyWT21wv8EsCBgDpzpokFAMjNDgPkZngkgjYM1
 m/m7tRL+qRA86JBxwwEhKqmRFz6TdQ++LInccj+bKbiv7LEqD4k6vCMzBMNG0tA8HNX7WHxeeeg
 TwLVW+mD1KbFUdy5iNYNQRuKzAMyUw7ZTLLkgV7TGoRI1xTnehc4Y3b79upq+YTgiWF1ev1V1g0
 M9dxB1b/N+FftkU8p3syw3m8fXgp8qSEAWrSYky9WcNHyvV9FGpsbByTHrIYVE7ICCIsJg4Caz1
 YLv82dYiNSg2LGMzqIa8WnWaqRDaWZ1sLycdP7pUWXjZioXUjkg85EqE1b16w=
X-Received: by 2002:a05:600c:3485:b0:495:6193:c6c0 with SMTP id
 5b1f17b1804b1-49561a30bb3mr12473365e9.18.1784534006056; 
 Mon, 20 Jul 2026 00:53:26 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b87c6sm466113265e9.7.2026.07.20.00.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 00:53:25 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 20 Jul 2026 09:53:21 +0200
Subject: [PATCH v3] usb: mtu3: support the current devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPzQ6CMBAGX4X07JrSCogn38N4WNoFavhLW4iE8
 O4WvBhPevySyczuwhxZQ45dooVZmowzfReGPERM1dhVBEaHzQQXKc/iDJTCgBCMg/OWsIXWjxL
 c0ECFuiIPiFLLXKHmKbKgGSyV5rknbvf3dmPxIOU370bUxvnezvsNU7xxf+SmGGJIMpQkNEdR8
 GuBc2MKS0fVt2wrTuLTef7BKYIzK9PwxSkVSZJ/Odd1fQFcUz0XOQEAAA==
X-Change-ID: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

The MTU3 glue driver requires the legacy U-Boot layout, where a synthetic
mediatek,ssusb child owns the gadget resources and dr_mode:

    usb@112b0000 {
        compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";

        ssusb@112b0000 {
            compatible = "mediatek,ssusb";
            reg = <0 0x112b0000 0 0x3e00>,
                  <0 0x112b3e00 0 0x0100>;
            reg-names = "mac", "ippc";
            dr_mode = "peripheral";
        };
    };

The current binding requires these properties directly on the controller:

    usb@112b1000 {
        compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
        reg = <0 0x112b1000 0 0x2dff>,
              <0 0x112b3e00 0 0x0100>;
        reg-names = "mac", "ippc";
        ranges = <0 0 0 0x112b0000 0 0x3f00>;
        dr_mode = "peripheral";
    };

Modify the driver to look for a legacy node only among direct children
of the controller and bind the gadget device to the controller node when
none is present. This retains support for existing U-Boot devicetrees
without requiring the synthetic node in devicetrees using the current
binding.

There is also a difference in the meaning of the mac resource: normalize
the resource address by SSUSB_DEV_BASE for the current binding and leave
the legacy resource unchanged.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v3:
- Remove the temporary platform data and derive the binding during probe
- Use dev_read_addr_name() for the MAC resource
- Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com

Changes in v2:
- Removed typecast horror
- Added platform storage to pass around legacy flags and device
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com
---
 drivers/usb/mtu3/mtu3_plat.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..f5c00cd5a8d 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -136,6 +136,7 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 {
 	struct udevice *child;
+	fdt_addr_t mac_addr;
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vusb33-supply",
@@ -166,7 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	mac_addr = dev_read_addr_name(child, "mac");
+	if (mac_addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "error mapping memory for mac\n");
+		return -ENODEV;
+	}
+
+	/* Current bindings describe the device block, not the whole MAC. */
+	if (ofnode_equal(dev_ofnode(dev), dev_ofnode(child)))
+		mac_addr -= SSUSB_DEV_BASE;
+
+	ssusb->mac_base = map_physmem(mac_addr, 0, MAP_NOCACHE);
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;
@@ -317,9 +328,15 @@ static int mtu3_glue_bind(struct udevice *parent)
 	ofnode node;
 	int ret;
 
-	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
+	node = ofnode_null();
+	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
+		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
+			break;
+	}
+
+	/* Current bindings keep the gadget resources on the parent node. */
 	if (!ofnode_valid(node))
-		return -ENODEV;
+		node = dev_ofnode(parent);
 
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);

---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

