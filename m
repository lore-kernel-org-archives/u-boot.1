Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD127C44520
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856E684DDC;
	Fri, 17 Jul 2026 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="d/a1tVtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C9A84DEA; Fri, 17 Jul 2026 14:20:50 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5C784DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47362928f65so7003029f8f.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784290847; x=1784895647; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pLzcxopIE3t997/xwvRFwJCq+GCoXN/TSSzjDnfTlQc=;
 b=d/a1tVtUleXOK67ic8ag0viEhbNm0l4Ma8D0hO8AWucTLb6jwaQMqbRYZcR3DvtRil
 lkGPbe9FKi4OwCBm6072DgYiqCqVuMkZ/UyQ/7nKQdI6QRtkkqSZqwL6NudgYMZiHlGU
 N8Q4GecZmFTO6pDyCGg1RA4nYekn9lMWHucS5aZ+pzxsvvohbQo6HWMwnu5wiIq65ln7
 DsJ9NIXu7NZB/26p4FuJbAn2qH3JUlyPbyAxeabNHIMQsEgqcPiWLjP0PVbtazraQfhO
 xCLE/6k+XQKEvHEi6PT1dQnqzSDmln/yYNvMrQPPEuTPvYzeBuzuEMxBCy8GxmdauYUK
 e/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290847; x=1784895647;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pLzcxopIE3t997/xwvRFwJCq+GCoXN/TSSzjDnfTlQc=;
 b=itm6X49xG14qmPJ146bhF1bJJnPt5JYhsUzwJY8UslwQEnb3S5+DpGOe4J3a4sM4md
 lelfIwY/NwiUSRmT3YWC+a0IBfOtOfbiWau+VrtcNFpJB3FSlgtEkJMgp0Sg3s+AsYG0
 zHIPRBztPNCOwQZtipRGnvJ0b2JZ/oJZaAb7IIVMWTX22yqbxVf+ZHlq9jy1BV8ejJvm
 1wXUnuMfgaZHYehObVziVSrOVy6+Sw0xkt9meCkTPmk0GRju52uyq/lePYUxC2P0eGGa
 2w4AXYuihb2AmObLHnOYn59Hc5A/haq5aQOfO/f2PsEtfOXu5nNhpakVKYoGuL9tHir6
 TSww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrG3R4cel5Svcgi3rxxmyME1cRl3g6BVW1lp2yOpzFxH/9VIzNeKl0aHi2GwMmNjlgI5qNiUso=@lists.denx.de
X-Gm-Message-State: AOJu0YxCn87Oqv2zX+Z4KKH+4DV0paxJTUay8ZrZnTkTrSjL+5Q1MDIN
 YGG8H/SOEHtamkftVTper+oJOns5Z1f+jnJSruQ7HX+RBCC46hZFVaWfvo2ZMv/8deb/eodfkIt
 q+Th7zbyBYA==
X-Gm-Gg: AfdE7cktbtQGVEl+0XEZMqLeU21f42dEQo5HA8ZWlxKwQfD3vG/tdMsRA8DOHDGHxZd
 yXJ0T+yt7PCptcxk8JCVc135PeFOC/IFduuqJzGI1GC6pKjf3B042VbaNc3s0U5SCNRCG96CLD0
 YSzf+D7afIJZDq/CwIpQeHqHuVxu/hfurm2vep/dPDv7K8+ZdJxogeVBGshRI7YR8PwMBJSFLAy
 jjyddwSMB6uD9CnNnhVEhubRzxk9l6x9NPzGSpcTBE0b9kuJyXth3aNzqouvoRJXVXQWMQeMnHm
 LWh2vTZTIiXopk7Kj83D31c2x3LGSLw/WNU3XcFmTAfcEXhCMuDMaiWx8gBwJHNAsSW7ElKWUN2
 schbOPZdxa5TMKPUWCzERbRkLAXppLlx64z3JuVAmaxmodP4DQ4zRcJJaS70xSR3d/sqJiDcZtJ
 ZMKZ1FUvLDHyEE4gljGYmK8Ms4wyxWEQkMM1oAH+huH303BkkFVnFmP+2e5ADTyMvZ3rNh5nJol
 NN04kk/baPRuzUdJJob
X-Received: by 2002:a05:6000:2084:b0:47e:81aa:3832 with SMTP id
 ffacd0b85a97d-47f6230e614mr3115045f8f.16.1784290847405; 
 Fri, 17 Jul 2026 05:20:47 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7e49sm3323491f8f.19.2026.07.17.05.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:20:46 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 17 Jul 2026 14:20:25 +0200
Subject: [PATCH] usb: mtu3: support the current devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAyF4VcZuTbQrbChryJeZGmsETdL04ow9
 u5Wvfzg8J8NTLKKwanbIMtLTZ9rQ3/ogG+0RkENzTC4YXRTPyEztYlgTVay0IJLqR4tPTBSiFK
 QyAd/ZApuJGiZlOWq79/F+fK31fkuXL5d2PcP0fBUWoQAAAA=
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
 drivers/usb/mtu3/mtu3_plat.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..8db7ef6d8fc 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -136,6 +136,7 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 {
 	struct udevice *child;
+	bool legacy_binding;
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vusb33-supply",
@@ -166,12 +167,20 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
+	legacy_binding =
+		ofnode_device_is_compatible(dev_ofnode(child), "mediatek,ssusb");
 	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;
 	}
 
+	/* Current bindings describe the device block, not the whole MAC. */
+	if (!legacy_binding) {
+		ssusb->mac_base = (void __iomem *)((uintptr_t)ssusb->mac_base -
+						   SSUSB_DEV_BASE);
+	}
+
 	ssusb->dr_mode = usb_get_dr_mode(dev_ofnode(child));
 
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN ||
@@ -317,9 +326,15 @@ static int mtu3_glue_bind(struct udevice *parent)
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

