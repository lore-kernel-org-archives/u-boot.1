Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3472C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444FE881AC;
	Fri, 22 Mar 2024 08:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kyLCo+x1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DC687F33; Fri, 22 Mar 2024 08:47:25 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5193888188
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EDDC861208;
 Fri, 22 Mar 2024 07:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B23C43399;
 Fri, 22 Mar 2024 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711093638;
 bh=Uu2rr6BMgpFNwZtFoKjhVhb7u7NFbxayRluhmn/EQXM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kyLCo+x1M9XAqRsDOzHJYH5zuLbrxpu9bbmFJ8MFQf5w8vG8kDhFYt+v3TLhMKnlZ
 UtrUqcJsTwAgBAFRQyx6lcSo/5G7Mbp+eg+AIu49VckkMe9sMIAq3sMw1lE28HPtmK
 7BZQ0VBAFSCVlMS0Ukwcb5tZob1Ot7hGvgh9UcinmcpCzBzDCPfKLWXW3+HP85C0Iy
 JIcVE9YOmtMXrc/n9EfnFISpoPGrZiBWk36fMq/W7ffG2fVahS45ASoqJeabqbiKtn
 B+hyIk8yE6+sPCnN76hqg/vovwomydWOSOK8n4iCi3ncj68jbdDE77mPFnzv1m7FlY
 vEeuttnMMiKdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 88276C54E71;
 Fri, 22 Mar 2024 07:47:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Fri, 22 Mar 2024 08:47:07 +0100
Subject: [PATCH v3 4/6] usb: Add environment based device ignorelist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-asahi-keyboards-v3-4-3106dd4c4e19@jannau.net>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
In-Reply-To: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125; i=j@jannau.net;
 h=from:subject:message-id;
 bh=ImxPLqJX6aavJZCvIexBFmtak3NGzyC1PanX6qvV5rI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtS/5i0+5WneJlvM7n7ue8rh8nuZyJNdzW4MC63ZJ21YY
 +15//WijlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOR7WRkmON/h4H1nu8+4b8f
 +Uo8p69YrFRTt+CClunBSbPm6+aqb2VkaD10xPTAeRuLdfbvvx5cuc+o7uR318t3Nr2cWur8t+6
 4PCcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Add the environment variable "usb_ignorelist" to prevent USB devices
listed in it from being bound to drivers. This allows to ignore devices
which are undesirable or trigger bugs in u-boot's USB stack.
Devices emulating keyboards are one example of undesirable devices as
u-boot currently supports only a single USB keyboard device. Most
commonly, people run into this with Yubikeys, so let's ignore those in
the default environment.

Based on previous USB keyboard specific patches for the same purpose.

Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 common/usb.c              | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/environment.rst | 13 +++++++++++
 include/env_default.h     | 11 +++++++++
 3 files changed, 81 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index 836506dcd9..1421b1bb13 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -28,6 +28,7 @@
 #include <common.h>
 #include <command.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
@@ -1084,6 +1085,48 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
 	return 0;
 }
 
+static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
+{
+	ulong vid, pid;
+	char *end;
+	const char *cur = env_get("usb_ignorelist");
+
+	/* parse "usb_ignorelist" strictly */
+	while (cur && cur[0] != '\0') {
+		vid = simple_strtoul(cur, &end, 0);
+		/*
+		 * If strtoul did not parse a single digit or the next char is
+		 * not ':' the ignore list is malformed.
+		 */
+		if (cur == end || end[0] != ':')
+			return -EINVAL;
+
+		cur = end + 1;
+		pid = simple_strtoul(cur, &end, 0);
+		/* Consider '*' as wildcard for the product ID */
+		if (cur == end && end[0] == '*') {
+			pid = U16_MAX + 1;
+			end++;
+		}
+		/*
+		 * The ignore list is malformed if no product ID / wildcard was
+		 * parsed or entries are not separated by ',' or terminated with
+		 * '\0'.
+		 */
+		if (cur == end || (end[0] != ',' && end[0] != '\0'))
+			return -EINVAL;
+
+		if (id_vendor == vid && (pid > U16_MAX || id_product == pid))
+			return -ENODEV;
+
+		if (end[0] == '\0')
+			break;
+		cur = end + 1;
+	}
+
+	return 0;
+}
+
 int usb_select_config(struct usb_device *dev)
 {
 	unsigned char *tmpbuf = NULL;
@@ -1099,6 +1142,20 @@ int usb_select_config(struct usb_device *dev)
 	le16_to_cpus(&dev->descriptor.idProduct);
 	le16_to_cpus(&dev->descriptor.bcdDevice);
 
+	/* ignore devices from usb_ignorelist */
+	err = usb_device_is_ignored(dev->descriptor.idVendor,
+				    dev->descriptor.idProduct);
+	if (err == -ENODEV) {
+		dev_dbg(dev->dev, "Ignoring USB device 0x%x:0x%x\n",
+			dev->descriptor.idVendor, dev->descriptor.idProduct);
+		return err;
+	} else if (err == -EINVAL) {
+		printf("usb_ignorelist parse error in \"%s\"\n",
+		       env_get("usb_ignorelist"));
+	} else if (err < 0) {
+		return err;
+	}
+
 	/*
 	 * Kingston DT Ultimate 32GB USB 3.0 seems to be extremely sensitive
 	 * about this first Get Descriptor request. If there are any other
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index ebf75fa948..7d4b448cb3 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -366,6 +366,19 @@ tftpwindowsize
     This means the count of blocks we can receive before
     sending ack to server.
 
+usb_ignorelist
+    Ignore USB devices to prevent binding them to an USB device driver. This can
+    be used to ignore devices are for some reason undesirable or causes crashes
+    u-boot's USB stack.
+    An example for undesired behavior is the keyboard emulation of security keys
+    like Yubikeys. U-boot currently supports only a single USB keyboard device
+    so try to probe an useful keyboard device. The default environment blocks
+    Yubico devices as common devices emulating keyboards.
+    Devices are matched by idVendor and idProduct. The variable contains a comma
+    separated list of idVendor:idProduct pairs as hexadecimal numbers joined
+    by a colon. '*' functions as a wildcard for idProduct to block all devices
+    with the specified idVendor.
+
 vlan
     When set to a value < 4095 the traffic over
     Ethernet is encapsulated/received over 802.1q
diff --git a/include/env_default.h b/include/env_default.h
index 2ca4a087d3..8ee500d170 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -99,6 +99,17 @@ const char default_environment[] = {
 #ifdef CONFIG_SYS_SOC
 	"soc="		CONFIG_SYS_SOC			"\0"
 #endif
+#ifdef CONFIG_USB_HOST
+	"usb_ignorelist="
+#ifdef CONFIG_USB_KEYBOARD
+	/* Ignore Yubico devices. Currently only a single USB keyboard device is
+	 * supported and the emulated HID keyboard Yubikeys present is useless
+	 * as keyboard.
+	 */
+	"0x1050:*,"
+#endif
+	"\0"
+#endif
 #ifdef CONFIG_ENV_IMPORT_FDT
 	"env_fdt_path="	CONFIG_ENV_FDT_PATH		"\0"
 #endif

-- 
2.44.0


