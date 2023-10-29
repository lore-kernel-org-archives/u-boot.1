Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5844C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CE08722E;
	Sun, 29 Oct 2023 08:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="e5l44Gc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404D2871C4; Sun, 29 Oct 2023 08:09:23 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A9E8721C
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 62ED94268B;
 Sun, 29 Oct 2023 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698563357; bh=skDEW9jI8C0AxGJbd1kKImBnUzt3Mz72TkQ8vFUF4/8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=e5l44Gc7Ku17AX4InvidusdVjVUBw3rh3o7vHNCXGX3ra0QUhTZRC9bzHU5FxoS/7
 hwzf7EAKyqXv9dChO2hDP1DSuKUfQZfmx1Nu2O9Lp/MMoX9gyGVQ1s/xmIAzWz2WTj
 Agw47qv+ewssJIJgI3IgyU7shiaObciGviYuZH1vqPw49+K175nmOj+oD4sIPmgsFW
 OjdteFkwHILiFTM3lXFAWp9FxdaqjVvju/GmlC2/vKVt1ytbYDWBlD8merFRNvx7jz
 Q5PRLp7fCavgSqRexlj4xB2FpsrryiA96ZQ33iSPQHxL7EX6qQoLwDBKSZjT0/nIUE
 2ZuuU+eRYjqcQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 16:09:08 +0900
Subject: [PATCH 1/2] usb: kbd: Ignore Yubikeys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-2-v1-1-9f793aa20fe4@marcan.st>
References: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
In-Reply-To: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=marcan@marcan.st;
 h=from:subject:message-id; bh=skDEW9jI8C0AxGJbd1kKImBnUzt3Mz72TkQ8vFUF4/8=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ7VvFpst4q1WccjqrPe9CYvvwg++OfbgUnrjx18Bfdp
 pyrJDyvo5SFQYyDQVZMkaXxRO+pbs/p59RVU6bDzGFlAhnCwMUpABNJjGJkePdnmVjI5mU6WRK/
 d/xsctbyV0hoVdR9uW9b//wu+e0Oygx/eJK/cO2dfuxVbNmKNdo1+f3/z207fm95mK6IdMv23Cx
 dPgA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

We currently only support one USB keyboard device, but some devices
emulate keyboards for other purposes. Most commonly, people run into
this with Yubikeys, so let's ignore those.

Even if we end up supporting multiple keyboards in the future, it's
safer to ignore known non-keyboard devices.

This is particularly important to avoid regressing some users, since
YubiKeys often *don't* work due to other bugs in the USB stack, but will
start to work once they are fixed.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 common/usb_kbd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 352d86fb2ece..e8c102c567e4 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -120,6 +120,15 @@ struct usb_kbd_pdata {
 
 extern int __maybe_unused net_busy_flag;
 
+/*
+ * Since we only support one usbkbd device in the iomux,
+ * ignore common keyboard-emulating devices that aren't
+ * real keyboards.
+ */
+const uint16_t vid_blocklist[] = {
+	0x1050, /* Yubico */
+};
+
 /* The period of time between two calls of usb_kbd_testc(). */
 static unsigned long kbd_testc_tms;
 
@@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 	struct usb_endpoint_descriptor *ep;
 	struct usb_kbd_pdata *data;
 	int epNum;
+	int i;
 
 	if (dev->descriptor.bNumConfigurations != 1)
 		return 0;
@@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
 	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
 		return 0;
 
+	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
+		if (dev->descriptor.idVendor == vid_blocklist[i]) {
+			printf("Ignoring keyboard device 0x%x:0x%x\n",
+			       dev->descriptor.idVendor,
+			       dev->descriptor.idProduct);
+			return 0;
+		}
+	}
+
 	for (epNum = 0; epNum < iface->desc.bNumEndpoints; epNum++) {
 		ep = &iface->ep_desc[epNum];
 

-- 
2.41.0

