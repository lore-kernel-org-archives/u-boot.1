Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB24C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F204C87B71;
	Sun, 17 Mar 2024 12:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="igwrQMWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D8B87DE2; Sun, 17 Mar 2024 12:07:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08CA87D35
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 37B3B60ACF;
 Sun, 17 Mar 2024 11:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2035C43399;
 Sun, 17 Mar 2024 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710673632;
 bh=Yd7zTXXfnTT1yUWDcP2zXgBHU/8UfM3boWZyYqijYRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=igwrQMWzMK9vRNNeteVph3szaRPP5LR7ORAy/7pzwV7HiXDIWnTNeZoIwj/InbDY6
 kYIpsablyEm6xv+lmdjz1hd1m9I9myRs5zwTzD6+hxtj3A+HQ0tFquRutdDVU1p++G
 t5zXN3BsceDajr5HFJpxYWeb+MZvQgoSnvCOTqToqcZdPO9xiC70GMvgc2Wbv4+yyX
 yXQUe3F42riXbzfOMn7tjRaTMv4t1EpC6LkxW5JGYIpuzltLdZjx0HZ3otWrkmQ0ot
 FjL5ii5SB3KwLKVzG9QbIXWSInruoxt5hB3/tvuarBZeD3DcV51DuOTWIbW7mExrsx
 wjawbCfQXCWDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A6463C54E72;
 Sun, 17 Mar 2024 11:07:12 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 17 Mar 2024 12:07:06 +0100
Subject: [PATCH v2 4/6] usb: Add environment based device blocklist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
In-Reply-To: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4777; i=j@jannau.net;
 h=from:subject:message-id; bh=1B9UO0P8CfWsKNUiNEUhYx6LFm2qj3jdyvJC22Nz0Yw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRv5+7xRMQdv2S1Qunb9p7S/WaxFexcmhXr6l6GMdpuX
 n1zv5hERykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIn0GzEyfFzqemHbzVP7nrGn
 yBtXr5+tPjfw5QqbnJpV+gFNTSxiFxj+RyiyzeMR4N1/qvLh4+49GvF2fN1t59qfRT2o+mt3/bM
 rOwA=
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

Add the environment variable "usb_blocklist" to prevent USB devices
listed in it from being used. This allows to ignore devices which
trigger bugs in u-boot's USB stack or are undesirable for other reasons.
Devices emulating keyboards are one example. U-boot currently supports
only one USB keyboard device. Most commonly, people run into this with
Yubikeys, so let's ignore those in the default environment.

Based on previous USB keyboard specific patches for the same purpose.

Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
Signed-off-by: Janne Grunau <j@jannau.net>
---
 common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/environment.rst | 12 ++++++++++
 include/env_default.h     | 11 ++++++++++
 3 files changed, 79 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index 836506dcd9..73af5be066 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
 	return 0;
 }
 
+static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
+{
+	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
+	       blocklist);
+	return 0;
+}
+
+static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
+{
+	ulong vid, pid;
+	char *end;
+	const char *block_str = env_get("usb_blocklist");
+	const char *cur = block_str;
+
+	/* parse "usb_blocklist" strictly */
+	while (cur && cur[0] != '\0') {
+		vid = simple_strtoul(cur, &end, 0);
+		if (cur == end || end[0] != ':')
+			return usb_blocklist_parse_error(block_str,
+							 cur - block_str);
+
+		cur = end + 1;
+		pid = simple_strtoul(cur, &end, 0);
+		if (cur == end && end[0] != '*')
+			return usb_blocklist_parse_error(block_str,
+							 cur - block_str);
+
+		if (end[0] == '*') {
+			/* use out of range idProduct as wildcard indication */
+			pid = U16_MAX + 1;
+			end++;
+		}
+		if (end[0] != ',' && end[0] != '\0')
+			return usb_blocklist_parse_error(block_str,
+							 cur - block_str);
+
+		if (id_vendor == vid && (pid > U16_MAX || id_product == pid)) {
+			printf("Ignoring USB device 0x%x:0x%x\n",id_vendor,
+			      id_product);
+			debug("Ignoring USB device 0x%x:0x%x\n",id_vendor,
+			      id_product);
+			return 1;
+		}
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
@@ -1099,6 +1150,11 @@ int usb_select_config(struct usb_device *dev)
 	le16_to_cpus(&dev->descriptor.idProduct);
 	le16_to_cpus(&dev->descriptor.bcdDevice);
 
+	/* ignore devices from usb_blocklist */
+	if (usb_device_is_blocked(dev->descriptor.idVendor,
+				  dev->descriptor.idProduct))
+		return -ENODEV;
+
 	/*
 	 * Kingston DT Ultimate 32GB USB 3.0 seems to be extremely sensitive
 	 * about this first Get Descriptor request. If there are any other
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index ebf75fa948..e42702adb2 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -366,6 +366,18 @@ tftpwindowsize
     This means the count of blocks we can receive before
     sending ack to server.
 
+usb_blocklist
+    Block USB devices from being bound to an USB device driver. This can be used
+    to ignore devices which causes crashes in u-boot's USB stack or are
+    undesirable for other reasons.
+    The default environment blocks Yubico devices since they emulate USB
+    keyboards. U-boot currently supports only a single USB keyboard device and
+    it is undesirable that a Yubikey is used as keyboard.
+    Devices are matched by idVendor and idProduct. The variable contains a comma
+    separated list of idVendor:idProduct pairs as hexadecimal numbers joined
+    by a colon. '*' functions as a wildcard for idProduct to block all devices
+    with the specified idVendor.
+
 vlan
     When set to a value < 4095 the traffic over
     Ethernet is encapsulated/received over 802.1q
diff --git a/include/env_default.h b/include/env_default.h
index 2ca4a087d3..ba4c7516b4 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -99,6 +99,17 @@ const char default_environment[] = {
 #ifdef CONFIG_SYS_SOC
 	"soc="		CONFIG_SYS_SOC			"\0"
 #endif
+#ifdef CONFIG_USB_HOST
+	"usb_blocklist="
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

