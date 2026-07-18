Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2977DC4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 10:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C7780287;
	Sat, 18 Jul 2026 12:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RG3xwUqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0992980517; Sat, 18 Jul 2026 12:08:37 +0200 (CEST)
Received: from mail-wr2-x00.google.com (mail-wr2-x00.google.com
 [IPv6:2a00:1450:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6B580117
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 12:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr2-x00.google.com with SMTP id
 ffacd0b85a97d-473913157edso1840564f8f.1
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784369314; x=1784974114; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k91UeqwzHH0dziL3QVUI3LGylRZFCVa5E5f45R4vX30=;
 b=RG3xwUqekkS+Pe2hrOuzhujkwA75RnWWCURyUTJnj2vxOj6tSLLIaZiZXTxn1LYCis
 LHShsX04q7N8IHNXmY+SrfRiaKQYuUvNbV3o17/e79rVBTnhX8bNGW3NaznVkuUaA9p2
 2xax+50EJIPsqdQduIrqB2vKqojj3Rgo/EUBTc1b1hqyjaEOTIH++KM8jJXGkn2Kdh5p
 GF9YAH4BOAIDI9GSbuOw2M5Xb1TWhp0hbY8XnsNL5FHFhM1iSK4IX9DR4HIpDAIY3IXx
 Y3DOQC0d9JRtoOQk7TCcCyims/qPwblafc63NL07zqDaiyzP6mbsiQzrwnlQwn2FqG7R
 pbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784369314; x=1784974114;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k91UeqwzHH0dziL3QVUI3LGylRZFCVa5E5f45R4vX30=;
 b=qcIeFqjn268ptUdaKHHm10RiKqeYEyEcwtjgybLzYcuJ5AH42airV4ZqQqyOn7wkZW
 +ep99vn8evavAyJpegeP1WPaQlCQiX5gReinyG4+OmjAS9h0ui3+tCL2bxhxpr5wpN96
 wKVNVE58BRnjnAivjmiPNbbIm+5VWzvOaiKFn5f7P3uk5dJbIcT/bGZpeO6J9GoEXNaC
 kEZ+GDOgbUMgiHqDy4Vn3b9mjLinv44drI5qof3bm8G2NLe/1si6G3F83+9qKBznU1s4
 mEAu7lU3cL/Fdj+b53ZtUJ7/v102zLBzpWumZYsBuXx0wcFRy8D0zEmxaJLi6XcWk5FN
 UTfA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn9wQqu0tRLOW5+QAzuaAsKHMq85wQitJb51ZbyXEEEMzELEqjvXoj1e9Kh5UyhJvFHCrDjXo=@lists.denx.de
X-Gm-Message-State: AOJu0YzrfZB6lnxVczd2FS0gmU5vjqBrAxOZVxwMdab0jTG/w5CtCsfo
 fHwOwhCQf+p5yTreFujMVTe0jqfA9dgG/UkgQ3bvvv5ikz3claWGZu85nhbKZPMSKYA=
X-Gm-Gg: AfdE7clAbpo8ly1iTgXVKfGjjVRfNqxqdrb1I4FEVQ4ms9FWQMA9LiZWlLBRZRVFNQJ
 cCKxcrGUpUucHc5rUP3K2+ySBeecd6Bg7A/aXLxFlKswYizrJOjr+lNwL0fEGinz93DlALprAMX
 2Rvrers99qWY52ZwMLJEMSFM2ltLPTwvWeMrkDwDO38M/XSPyEkjQsx4bep8ZVL5c+PqLO/BDHc
 77Bh8HI4+KTdEL198VMCtqWj9bBUrZuBphoV1aiH9xHooJA4zDGOYTBra2y558rimKuFYMAP1ds
 HiVBMs31V+1ipWho1Qn/YcT7DrMy9jRPJKSC4bBlUF+7zF3SMmeBJf6Fvt6kp/4lsXfnPNbGCwD
 lD1IG7+GyVcK0Li48A6v06gt6159Z74/C6humw0gHVCVew3qnKd42Y78YsdtpULZniyr0JLERPX
 HHU32slHlU/JEqzRcmRKAJCkmwMHjXQH+DVvi/K8Fp48i90wIkeEyptOD6sEHSyDFikTpsE15Ti
 9IiR2IIL6KjqEVh7y0U
X-Received: by 2002:a05:600c:190a:b0:495:39dc:583d with SMTP id
 5b1f17b1804b1-4954a3ec607mr67210135e9.6.1784369313605; 
 Sat, 18 Jul 2026 03:08:33 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a2511sm95524365e9.1.2026.07.18.03.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 03:08:33 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 12:08:11 +0200
Subject: [PATCH v2] usb: mtu3: support the current devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOyw6CMBBFf4XM2jF9RImu/A/DYtqOUMMrbSESw
 r9b8AtcnuTknrtC5OA5wr1YIfDsox/6DOpUgG2orxm9ywxKqKsoZYnWUlYYpzGmwNRhlyaNcWy
 xJldzQiLt9M2SE1eCPDMGfvnPkXhWP46TebNN++5uND6mISzHh1nu3h+5WaLES0malROkjHgYW
 lpvAp/t0EG1bdsX5ChTo+UAAAA=
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
Changes in v2:
- Removed typecast horror
- Added platform storage to pass around legacy flags and device
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com
---
 drivers/usb/mtu3/mtu3_plat.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..f22d047b81e 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -11,6 +11,11 @@
 #include "mtu3.h"
 #include "mtu3_dr.h"
 
+struct mtu3_glue_plat {
+	struct udevice *child;
+	bool legacy_binding;
+};
+
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 			  enum mtu3_dr_force_mode mode)
 {
@@ -135,7 +140,9 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 
 static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 {
-	struct udevice *child;
+	struct mtu3_glue_plat *plat = dev_get_plat(dev);
+	struct udevice *child = plat->child;
+	fdt_addr_t mac_addr;
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vusb33-supply",
@@ -160,13 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return -ENODEV;
 	}
 
-	ret = device_find_first_child(dev, &child);
-	if (ret || !child) {
-		dev_err(dev, "failed to get child %d!\n", ret);
-		return ret;
+	mac_addr = devfdt_get_addr_name(child, "mac");
+	if (mac_addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "error mapping memory for mac\n");
+		return -ENODEV;
 	}
 
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	/* Current bindings describe the device block, not the whole MAC. */
+	if (!plat->legacy_binding)
+		mac_addr -= SSUSB_DEV_BASE;
+
+	ssusb->mac_base = map_physmem(mac_addr, 0, MAP_NOCACHE);
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;
@@ -310,16 +321,24 @@ U_BOOT_DRIVER(mtu3_host) = {
 
 static int mtu3_glue_bind(struct udevice *parent)
 {
-	struct udevice *dev;
+	struct mtu3_glue_plat *plat = dev_get_plat(parent);
 	enum usb_dr_mode dr_mode;
 	const char *driver;
 	const char *name;
 	ofnode node;
 	int ret;
 
-	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
+	node = ofnode_null();
+	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
+		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
+			break;
+	}
+
+	plat->legacy_binding = ofnode_valid(node);
+
+	/* Current bindings keep the gadget resources on the parent node. */
 	if (!ofnode_valid(node))
-		return -ENODEV;
+		node = dev_ofnode(parent);
 
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);
@@ -349,7 +368,8 @@ static int mtu3_glue_bind(struct udevice *parent)
 	dev_dbg(parent, "%s: node name: %s, driver %s, dr_mode %d\n",
 		__func__, name, driver, dr_mode);
 
-	ret = device_bind_driver_to_node(parent, driver, name, node, &dev);
+	ret = device_bind_driver_to_node(parent, driver, name, node,
+					 &plat->child);
 	if (ret)
 		dev_err(parent, "%s: not able to bind usb device mode\n",
 			__func__);
@@ -369,5 +389,6 @@ U_BOOT_DRIVER(mtu3) = {
 	.bind = mtu3_glue_bind,
 	.probe = mtu3_probe,
 	.remove = mtu3_remove,
+	.plat_auto	= sizeof(struct mtu3_glue_plat),
 	.priv_auto	= sizeof(struct ssusb_mtk),
 };

---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

