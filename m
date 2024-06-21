Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BBC2BA18
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 02:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F012087FC8;
	Fri, 21 Jun 2024 04:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ecZUbY0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6B387C69; Fri, 21 Jun 2024 04:14:08 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E7788001
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 04:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6fd3f5a19bso372466b.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718936044; x=1719540844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NsQCZO25FWJCiBev/SEulu11JBkZCgJ55+ZAQCk6w50=;
 b=ecZUbY0HF3JJKORSoJ0mwQSs/XZSunTpFWv07/eOku4+4Kv7wSio3xj5p/LisLokSr
 sSmuid2RrXE6oHD8Vx20z40K+4izoRvmukZT36W8yR/0In+tkUSTupnn7fkbrlLy+5lO
 axWKQDT8OIG64DVHQx5f8jxGDWE5DLZ4h8RAFcWGDmMqKC9X8fyYuVJSlagfGm8Kcwqs
 z8VXhuWTLd303WMCtgonxfk272t1clV87BXmH866ia04aXtYi8KKWbF0ghmNsVnr+5uC
 EfpIT7TP8LBb69dsvpiI7lRTI8JrvBZ/qHQV/Ng+zkIdlmb9eUyVC/L3Qd/Jur21VZJD
 rL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718936044; x=1719540844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsQCZO25FWJCiBev/SEulu11JBkZCgJ55+ZAQCk6w50=;
 b=Q/Ve/Ul6A4pPZVXUggZYwcKbK8IZIp1Rti0LUTstxzuyL3jfd5WmOxZ6McZ1d72Hbg
 iB05c8KesY5HVAbW0O+PJ6sUNyhHVA2KYkpwqGvdWZcqV7GITmDKWOg4JJivYa4OdDSH
 3A5T6qjvmmRgSBBZ9pLqF+lt0pO/M/Nn6MlylZSclp7hIQWOTA8lok8eYbSDD8td6RWC
 bTlp546vMzFyDkp8xfUyWsdxo8uZqDCJ/4e30NfohHyB0nYFDBZI+upojCzkrV8924QZ
 7b/iZLN8LODFAvgHj/DeZJ1/QeXZPIq8C/lgvVElV4bi+rCxL4OTy86NnyxKTL9ryF4l
 KaIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKtnDE4/RnBbwGlF22ndLRv41Ftz/iWKesXPje/RPj66qQGE307MFVTXu4o8/is1oM+mk3EYb+RHyiruHA+i7wtLArAQ==
X-Gm-Message-State: AOJu0YwaRlS8sSL2H8TIgrWGaiQzwj24qodIJDnEbEyeiqFEmZTTfuJ+
 6TpwbwNR6j/gN95vD0RuKDTvoLiOw8VSL7VKnplg1NVhso9h96+QLjmOHIsIafk=
X-Google-Smtp-Source: AGHT+IF9Snf/ozVg4Ohtw8IbLAOI0P8mPPIdT27BFzYDj/pv/gddYq12uYEfIWBd9gqwu9LbUYtkTw==
X-Received: by 2002:a17:906:590c:b0:a6f:513a:a65 with SMTP id
 a640c23a62f3a-a6fab6423a4mr414754866b.33.1718936044270; 
 Thu, 20 Jun 2024 19:14:04 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf48b51csm29730766b.89.2024.06.20.19.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 19:14:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3: respect role-switch-default-mode
Date: Fri, 21 Jun 2024 04:11:31 +0200
Message-ID: <20240621021135.1600847-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

* Factor out the common pattern of checking the dr_mode property on
  the usb node and it's parent
* Respect the usb-role-switch property, rather than requiring dr_mode be
  set
* Override OTG mode with the value in role-switch-default-mode

The devicetree bindings don't dictate that dr_mode is a required
property, but the dwc3 driver would refuse to probe if it was unset
(this breaks the Qualcomm RB2 board which doesn't set it).

Here, we update the driver to respect the other properties that can be
used to describe the controller, and more gracefully handle some of the
edge cases.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 56 +++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index cbb5d61dfb0b..1cf8b90e8bbf 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -49,8 +49,46 @@ struct dwc3_generic_host_priv {
 	struct dwc3_generic_priv gen_priv;
 	struct udevice *vbus_supply;
 };
 
+/**
+ * dwc3_get_preferred_dr_mode() - Get the preferred DR mode for the USB node
+ *
+ * Since we don't support dynamic role switching yet in dwc3, this is a slightly
+ * opinionated wrapper around usb_get_dr_mode() which will respect the
+ * role-switch-default-mode property if it is present and the dr_mode is OTG.
+ *
+ * @child: Node to get the DR mode for
+ */
+static enum usb_dr_mode dwc3_get_preferred_dr_mode(ofnode node)
+{
+	enum usb_dr_mode mode;
+	bool is_role_switch = ofnode_has_property(node, "usb-role-switch");
+
+	mode = usb_get_dr_mode(node);
+	/* Attempt to search the parent node too */
+	if (mode == USB_DR_MODE_UNKNOWN) {
+		node = ofnode_get_parent(node);
+		mode = usb_get_dr_mode(node);
+		is_role_switch |= ofnode_has_property(node, "usb-role-switch");
+	}
+
+	/* If the usb-role-switch property is present, but dr_mode isn't, then the
+	 * default is OTG.
+	 */
+	if (is_role_switch && mode == USB_DR_MODE_UNKNOWN)
+		mode = USB_DR_MODE_OTG;
+
+	/* Respect the role-switch-default-mode property */
+	if (mode == USB_DR_MODE_OTG && is_role_switch) {
+		mode = usb_get_role_switch_default_mode(node);
+		if (mode == USB_DR_MODE_UNKNOWN)
+			mode = USB_DR_MODE_OTG;
+	}
+
+	return mode;
+}
+
 static int dwc3_generic_probe(struct udevice *dev,
 			      struct dwc3_generic_priv *priv)
 {
 	int rc;
@@ -178,17 +216,12 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 		pr_info("No USB maximum speed specified. Using super speed\n");
 		plat->maximum_speed = USB_SPEED_SUPER;
 	}
 
-	plat->dr_mode = usb_get_dr_mode(node);
+	plat->dr_mode = dwc3_get_preferred_dr_mode(node);
 	if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
-		/* might be a leaf so check the parent for mode */
-		node = dev_ofnode(dev->parent);
-		plat->dr_mode = usb_get_dr_mode(node);
-		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
-			pr_err("Invalid usb mode setup\n");
-			return -ENODEV;
-		}
+		pr_err("Invalid usb mode setup\n");
+		return -ENODEV;
 	}
 
 	return 0;
 }
@@ -541,12 +574,9 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	int ret;
 
 	debug("%s: subnode name: %s\n", __func__, name);
 
-	/* if the parent node doesn't have a mode check the leaf */
-	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
-	if (!dr_mode)
-		dr_mode = usb_get_dr_mode(node);
+	dr_mode = dwc3_get_preferred_dr_mode(node);
 
 	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
 	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
 		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
@@ -698,9 +728,9 @@ int dwc3_glue_probe(struct udevice *dev)
 
 	while (child) {
 		enum usb_dr_mode dr_mode;
 
-		dr_mode = usb_get_dr_mode(dev_ofnode(child));
+		dr_mode = dwc3_get_preferred_dr_mode(dev_ofnode(child));
 		device_find_next_child(&child);
 		if (ops && ops->glue_configure)
 			ops->glue_configure(dev, index, dr_mode);
 		index++;
-- 
2.45.0

