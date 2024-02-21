Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C05C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D1B8803D;
	Wed, 21 Feb 2024 08:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7OlJfS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D248803D; Wed, 21 Feb 2024 08:25:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD2A87E23
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E1C3861423;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EA4BC433A6;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708500316;
 bh=zNo8TsV9W6bspsRP0sbff0RXSsZ/VvDRgBhJ/EE3GMo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=P7OlJfS/kTW3J6GYMcjTCErFVYonVbgrNrWRUglr+75bzH1LqFPRYaB2V2Kf06qri
 tu4QB0biX0x511gtPffKKWh9QSBmEVUyfvd5z2leCOGstVFbuSw2i2PFfMv9YEKuSA
 /6G/bARQzR4/WxpTuIutYi5YpY48FRUYWC6Wgh3dEM/MOaUZHQT4UfCDxixQlYUwy8
 R6lQFjT3PbmKanCY/DZL7uJyvA50kII3Oub3Yy+g3Z/r/QOq4ZObCYGikIXi9deL+h
 l4OR1K4LxfXoqjRGr4IqvGCEe5FLkqBOnsiRlDEZYbSwvmSpALrRHRwD5E7ecusjQA
 0OVaysuaLBLzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 780C1C5478A;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 21 Feb 2024 08:25:04 +0100
Subject: [PATCH 4/6] usb: kbd: Ignore Yubikeys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
In-Reply-To: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=j@jannau.net;
 h=from:subject:message-id; bh=Skl/l5JT0ZXzNGK38C7Z1Yy3xS+vbisq7v96Lch2Hkk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtSrS6OaihRjt+uJPnx35LPEscrmrT9WJTRe2e7WEXO+t
 oBzufP1jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABMxvsrwP+a9gfZJk1krpf/N
 jFa5scCk63Ox7LLvXbK7uvIT3Of+Wc7wT5ttF/dHj/p5Gt9Fuuc/Yd2axbd02d5cl7+xUq+yDv/
 O5gIA
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

From: Hector Martin <marcan@marcan.st>

We currently only support one USB keyboard device, but some devices
emulate keyboards for other purposes. Most commonly, people run into
this with Yubikeys, so let's ignore those.

Even if we end up supporting multiple keyboards in the future, it's
safer to ignore known non-keyboard devices.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 common/usb_kbd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 4cbc9acb73..774d3555d9 100644
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
2.43.2

