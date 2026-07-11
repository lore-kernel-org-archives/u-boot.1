Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F0BC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E3984A4A;
	Sat, 11 Jul 2026 18:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UVtMB5G1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755248498B; Sat, 11 Jul 2026 18:08:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B4C8497A
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786112; bh=g+9ELF/6w9Wl1dXLhiUP3Uzy4VGWlGQt/2s8xsCs4Ok=;
 b=UVtMB5G15mQ/DsuNkgp0LxBQ7T59VhT50iHGssaYav/h9t8AdG+tIxyZENqPxrpVQHkE/6/Ut
 MFcuRhNlNXTlwxLNTolJX6dWcSh0I364MuEzoTw+P/63najBnUfMZQpTGNs0k3lJOz3mabH65OZ
 fUl9vyHrKthteAWKLP4D0P0FJoE4yYA0OV3jmeouxYFpRFvz6UjX/Q/qjpP0ei8lOZsfWad0wWl
 dmlryXgHtsRGFwHcK1dGTX6gmGTTwGrYgXD7ayJo23P3seoQy1bT2soo4IIzWJADrgYwIJ89KTQ
 C9LKRTvm7dj0XMhiwDr0zq6Kk6PKB80LTRmjEWNA29rw==
X-Forward-Email-ID: 6a526a7f1b09fea89cb124fe
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH 4/8] usb: Extract usb_select_configuration_no() helper
Date: Sat, 11 Jul 2026 16:08:02 +0000
Message-ID: <20260711160808.2022242-5-jonas@kwiboo.se>
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

U-Boot only has support for one configuration for devices.

Extract handing of selecting active configuration to a helper function
to make it easier for drivers to select a different configuration.

This include a small change in behavior, errors from parsing config
descriptors are no longer ignored and is instead returned.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 common/usb.c  | 59 ++++++++++++++++++++++++++++++---------------------
 include/usb.h | 10 +++++++++
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 6a4ad346f4ba..625512a1c99a 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1149,11 +1149,38 @@ static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
 	return 0;
 }
 
-int usb_select_config(struct usb_device *dev)
+int usb_select_configuration_no(struct usb_device *dev, int cfgno)
 {
 	unsigned char *tmpbuf = NULL;
 	int err;
 
+	err = usb_get_configuration_len(dev, cfgno);
+	if (err >= 0) {
+		tmpbuf = (unsigned char *)malloc_cache_aligned(err);
+		if (!tmpbuf)
+			err = -ENOMEM;
+		else
+			err = usb_get_configuration_no(dev, cfgno, tmpbuf, err);
+	}
+	if (err < 0) {
+		free(tmpbuf);
+		return err;
+	}
+
+	err = usb_parse_config(dev, tmpbuf, cfgno);
+	free(tmpbuf);
+	if (err < 0)
+		return err;
+
+	usb_set_maxpacket(dev);
+
+	return usb_set_configuration(dev, dev->config.desc.bConfigurationValue);
+}
+
+int usb_select_config(struct usb_device *dev)
+{
+	int err;
+
 	err = get_descriptor_len(dev, USB_DT_DEVICE_SIZE, USB_DT_DEVICE_SIZE);
 	if (err)
 		return err;
@@ -1193,34 +1220,18 @@ int usb_select_config(struct usb_device *dev)
 	 */
 	mdelay(1);
 
-	/* only support for one config for now */
-	err = usb_get_configuration_len(dev, 0);
-	if (err >= 0) {
-		tmpbuf = (unsigned char *)malloc_cache_aligned(err);
-		if (!tmpbuf)
-			err = -ENOMEM;
-		else
-			err = usb_get_configuration_no(dev, 0, tmpbuf, err);
-	}
-	if (err < 0) {
-		printf("usb_new_device: Cannot read configuration, " \
-		       "skipping device %04x:%04x\n",
-		       dev->descriptor.idVendor, dev->descriptor.idProduct);
-		free(tmpbuf);
-		return err;
-	}
-	usb_parse_config(dev, tmpbuf, 0);
-	free(tmpbuf);
-	usb_set_maxpacket(dev);
 	/*
-	 * we set the default configuration here
+	 * we select the default configuration here
 	 * This seems premature. If the driver wants a different configuration
 	 * it will need to select itself.
 	 */
-	err = usb_set_configuration(dev, dev->config.desc.bConfigurationValue);
+	err = usb_select_configuration_no(dev, 0);
 	if (err < 0) {
-		printf("failed to set default configuration " \
-			"len %d, status %lX\n", dev->act_len, dev->status);
+		printf("failed to select default configuration " \
+			"len %d, status %lX, " \
+			"skipping device %04x:%04x\n",
+			dev->act_len, dev->status,
+			dev->descriptor.idVendor, dev->descriptor.idProduct);
 		return err;
 	}
 
diff --git a/include/usb.h b/include/usb.h
index 44c5d1cc5999..e9d16ee6c9fd 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -900,6 +900,16 @@ int usb_scan_device(struct udevice *parent, int port,
  */
 struct udevice *usb_get_bus(struct udevice *dev);
 
+/**
+ * usb_select_configuration_no() - Select configuration to use for a device
+ *
+ * This re-reads the configuration descriptor and sets the configuration.
+ *
+ * @dev:	Device to select configuration
+ * @cfgno:	Configuration number to set
+ */
+int usb_select_configuration_no(struct usb_device *dev, int cfgno);
+
 /**
  * usb_select_config() - Set up a device ready for use
  *
-- 
2.54.0

