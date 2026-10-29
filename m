Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4E606A327
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sUwuPvaF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abp5zYnT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 146CD606D9;
	Thu, 29 Oct 2026 06:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3ubwc857kqA; Thu, 29 Oct 2026 06:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3E2D60697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254033;
	b=SoWe+sPZhjwkbXn6hNJH0OL7O4FvwPjjc0BiXpl5iAJ4ES2duTdlj9lMsdAWUw2+ecFy
	 5fZBQGGqgL585Tzuk9Q4i1aUYCuo+sbXRN/epybGhW30z5/3GLLkgptHpPog9YpMEp826
	 ITRbNFwlRSU/ghpzQNe7SgHqVg+hZLxkchcChdlXDBVjpOI4eusWYD+/zaQSXwHexrbih
	 i0NwLnCs2pGib6hDgwOmoaOk9yRfVMx13svrl5rVDGqH0uqklq5ldVN1eOCzoUlR+ABTi
	 mVBtU8sgz00L64D5foadt9Y0LG6Ar7xUAYf9Ue1SFaoSe9HG8qVXrxCyzPu3krk4tRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IY3D5rAX1dvYhFcqkHcjt8FtaZpqVpzYfXuA9bmD54M=;
	b=HQ3HbwDvUq1xNboEjvNgeLHEzbodR8AK7MHY0LRTuKx4DAsSXO4zyC/kwbd23YgsmUVP
	 Q0LlWCqEA6Mi+ch0Ue1fXeLnc5hKOgS7Su07E7WR7YH0WEkL5hE4skU3W289zDD8R3CJg
	 tYVCdN5bmgTUyqHXgsd1sk8r7GfApULVMowUF5RXIijgcfAEpA8fb0GcHjqfpZ6XdEtsD
	 wR1/xDjbJvANB0j8SvO4zCmVk9ksSSFUlGw7Kqenqp8Y/V6reDMJnYZHqaUg5LScUsgjn
	 HXUkq52V0uqQXFEZoFEnT7cMaKjluLEX4qg9OXRSdXluWzdUriZetd7ArlIx56Z1twQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abp5zYnT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254032;
	bh=IY3D5rAX1dvYhFcqkHcjt8FtaZpqVpzYfXuA9bmD54M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUwuPvaFxB3bKQ14Vis6Y5YLoPRKM8b536rKDIVo2umTNg9VCtjeCYAxaZhJK7w6a
	 SqJEKh5IQPaBLeJaJzBQnnFVGw2py2uB/sXY7UWW0XSTSueEvZVRy7/Mj7E3o4pUOS
	 dZqPgTnCpPDervin1Z6l95MjWMkMym+L9ugFroO8A+xllwCVGYBQHT55V98OlYplCY
	 znxz9DDR5bZVhombKfZRE6ibDP/DSnjK5TVXrgV5rp3QRheagwoQKaP67Pb2vrmdGL
	 iqrQx7rMOiN3K8qXPh/SlV2Nx+IFLGsO+KPE+Oqp1nRs1EjqKnrBSTu+dq46OQ4FNY
	 lHXoRPRyhMyWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3E2D60697;
	Thu, 29 Oct 2026 06:07:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A62C1472
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C42960697
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPxzVP3ZD9mF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E3C86068D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793254030;
 b=KhdcSPqrD7yFBu09BfMAo7fgGb847a3wU05aPos8gmQhI2Xx2G41IG2IpyiCGX5DFiFt
 8hN94EhAd2IrpLL3RWZ7WRfdVJ81be2fsJddM/LArXQtvlKb1QxggMTW7ozpfsqvrg+u+
 1psist88gv0GQFxG9V/3EO69Swbm7cEXx/4zLep1LGIfMUeVUqg95OzD3MfFYNQzTtfHq
 F8J16NwFVSpYwQOAnvYjEzzKCNJ8tUGYRgrxXxB68n2QENLP+Wydpj+4VS1tJrQ9HTPLm
 QuQou8a7u+UBhwgnxou3ao6nslfJa1edby0KzlsxgwXpBfIZW5Exl96SUorseqgh+0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254030;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
 bh=IY3D5rAX1dvYhFcqkHcjt8FtaZpqVpzYfXuA9bmD54M=;
 b=AhfnGEeF3PeGHHLsBtXlFC8Qrmv33OYZKx6fpOWaBnMJcGnb+Ia93AW2n+FP3dGlLsy7
 5CUC9q8BmbO8T3/T9myeuhaQBAYy/1yKd8QkSNBpKqRAyrPUoU9zpC7ypx3BaJwU3Mqhm
 +Qrg75FqEadcyBR9J9vdnaOf9lxz33dAC7sEEAGBvuVWZHjujvpKnNPt6lKcV4X3fqdiW
 0UDawMjBmcLJyPb3lChO7l8HdkeFt/jl830axc75ew7N7Hd0KoE7azD8X9fGskJMc0xzP
 Q9WMv/N6HiOJwrw7Rt0DlN9UxIJ7MNMA0DbY0KHlyYWB2wOwLaNlVoKNKyORGvsKf0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=abp5zYnT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=abp5zYnT
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E3C86068D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:07:09 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so16766225e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793254028; x=1793858828;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IY3D5rAX1dvYhFcqkHcjt8FtaZpqVpzYfXuA9bmD54M=;
 b=abp5zYnTZp9lrBix7wz8zNsPc47cCRXXxYfT2PCFIKZ1vuwE4YaOFm7qkLKsv9GmR2
 NPvAQu3EWxzAM1TPM4yAy6fE+In37ot/9bwzei1pbvV02g4+qlAHZ2ymcvqUKPgUZYhu
 XXg2RngupxwTctmd3mZ3W2S/gj1urVp8QmwWWaT/yZ5sJ8MCK7ARlkIC0WJRbph1BPBr
 r8HVIBDRZ/4sJiXtbHN9uaPT0bzk+Y0UsXUDzQPU0THKFqaLJb1d8L6dB7iXnM4i0Hl8
 XV4VpD544Ujf0dioR0M0XNDicKFBQ0W2tpRhfnyCoq76oqLLp1Rsl4iFk/NLP+W0q1JV
 pqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254028; x=1793858828;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IY3D5rAX1dvYhFcqkHcjt8FtaZpqVpzYfXuA9bmD54M=;
 b=BLTK1Eqh4yDyNgwrP1gNGWUu4qlPgC8a4Ea1LJlL/UXhB6rPZe/J4GQ1gEwEC4DTiB
 P+jMmBKaxY5TXlSbAAZNbpmQmTyYc3FgZ4We6V2DF09Eu+iv1yNePmn1X5dNuh+3BFit
 v5GAc1x69bA3BXnxBYqTLGJrSul0uUm+SLTbpHXrtBBOjwHaxeqp3sv3KeMIHDcd7ODv
 zoNzHHBYafClYUy06NyqyjxQYlMn4WKaND/pRmwG8V2Pr8AK7Ui/2c7L2OY3NmkTa7EH
 ya2/fcuXcC2yZjsSFxvK2CCo8ZqoNbKTzbNZJxyq8hvEKho87Fsvhk8EpFEUAgJW5gJ7
 oGBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkTS8SITMEYK/S4YFEhSyhZi340DCv7PSaKXyUz/lEKFXEY3R53CmMrhUnDuhZqUHaLKCc+Dk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfG5l7wFqz1fmWKEePptYqm3JJXoxVELqIdZy1fhOw32m7rFzt
 iqGGSZ40yZ1tXc5GdM3POYHotmp5uX0q0/BE2v4T2JxhAik78AdV4y/W6NWp8vpo
X-Gm-Gg: AYBFou3NfT+geY7QkgzeTNvJUPKmjGdY1EmaZ1pRFCN5babJx667fxNlGMgjRYcdaN2
 r3NhZlleRB23ohtUdjkW1LO2vM2QoSA5oRlMZHOOOirzan1EJeJHlkQYlMGolOmaTZ/zZ5lU4Aa
 PUEfXCsAInQuogi2R1Pfln5JNuhkcEbH04Vk4Gcsua5Mreddy8HTGdUKvJ2YFqeTWyWb66ef+ZG
 aO5QnfFEyCjXRQMqwwm0dzUofwFO1tBtD3/BwDdZvt7Z3PWuDvDuQmAYu68SsHzSCu2kRrCAI4j
 YofQI+SzZBe5x/sl+kAkVqwm3xDT4O+IcMpq/vg7DXVNnXnaNHohsGDBFxiNc49p2cD277Z8X6Z
 zAjoly3X8F7szFQy+d5SmB3vyEHsJxbnIsOW00z/g29n9kO4UPBN911SySmB7SQclfZOPbaMnOV
 2vxtgtJP7YrZdMdi/ioiutpT1X6JJOoWrgv44cngHgnRnC6t4nY4NLXMP1fVDXpvVy4r95pXrH1
 ry00jdWukUoGheiGEG9cRnm8SXuzIPMSw0uyPXtpLgJHyHhTzSsaSkTRLJoANRnuZH0YGFKfM4r
 Mp6AYHaUfjlwDasTS6/Fg81e2HisOmcEKcEvFGhU2xl6oMms94IVBw==
X-Received: by 2002:a05:600c:34cc:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a963ffd2b9mr109673585e9.4.1793254027348; 
 Wed, 28 Oct 2026 23:07:07 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm32315829f8f.53.2026.10.28.23.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:07:06 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND 4/4] test: dm: Add tests for the USB Ethernet rx header
 checks
Date: Thu, 29 Oct 2026 06:07:05 +0000
Message-ID: <81f03167-12d5-4bb3-b2ae-03633a399f9d@gmail.com>
In-Reply-To: <f9afa215-645f-400f-8743-eaeca3f6a2f5@gmail.com>
References: <f9afa215-645f-400f-8743-eaeca3f6a2f5@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add DM tests that bind the r8152, ax88179, lan75xx and lan78xx drivers
without probing them and hand their recv() and free_pkt() prepared
transfers in the receive buffer: well-formed ones, which must come back
as the packets they hold, and ones whose header or lengths run past the
transfer, which must be dropped.

Enable CONFIG_USB_HOST_ETHER and these drivers in sandbox_defconfig so
that they are built and tested under sandbox.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 configs/sandbox_defconfig |   5 +
 test/dm/Makefile          |   1 +
 test/dm/usb_eth.c         | 375 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 test/dm/usb_eth.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..1d409891580 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -359,6 +359,11 @@ CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_ETHER_LAN78XX=y
+CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..e22cbf2c2ba 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_TEE) += tee.o
 obj-$(CONFIG_TIMER) += timer.o
 obj-$(CONFIG_TPM_V2) += tpm.o
 obj-$(CONFIG_DM_USB) += usb.o
+obj-$(CONFIG_USB_HOST_ETHER) += usb_eth.o
 obj-$(CONFIG_VIDEO_SANDBOX_SDL) += video.o
 ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
 obj-y += virtio.o
diff --git a/test/dm/usb_eth.c b/test/dm/usb_eth.c
new file mode 100644
index 00000000000..2f8903b71b6
--- /dev/null
+++ b/test/dm/usb_eth.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the receive header checks of the USB Ethernet drivers
+ *
+ * Each driver is bound without being probed, so that no USB device sits
+ * behind it, and its recv() is handed a prepared transfer in the receive
+ * buffer.
+ */
+
+#include <dm.h>
+#include <net.h>
+#include <usb_ether.h>
+#include <asm/unaligned.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <dm/test.h>
+#include <test/ut.h>
+#include "../../drivers/usb/eth/lan7x.h"
+#include "../../drivers/usb/eth/r8152.h"
+
+static u8 rxbuf[256] __maybe_unused;
+
+/*
+ * Bind @drv to a new device and present the first @len bytes of rxbuf to it
+ * as a received transfer. device_of_to_plat() allocates the private data
+ * without probing the device; @ueth_offset is where the driver keeps its
+ * struct ueth_data in there.
+ */
+static int __maybe_unused usb_eth_test_bind(struct unit_test_state *uts,
+					    struct driver *drv,
+					    size_t ueth_offset, int len,
+					    struct udevice **devp,
+					    struct ueth_data **uethp)
+{
+	struct ueth_data *ueth;
+
+	ut_assertok(device_bind(dm_root(), drv, drv->name, NULL, ofnode_null(),
+				devp));
+	ut_assertok(device_of_to_plat(*devp));
+	ueth = dev_get_priv(*devp) + ueth_offset;
+	ueth->rxbuf = rxbuf;
+	ueth->rxsize = sizeof(rxbuf);
+	ueth->rxlen = len;
+	ueth->rxptr = 0;
+	*uethp = ueth;
+
+	return 0;
+}
+
+static int __maybe_unused usb_eth_test_recv(struct udevice *dev,
+					    uchar **packetp)
+{
+	return eth_get_ops(dev)->recv(dev, 0, packetp);
+}
+
+static int __maybe_unused usb_eth_test_free_pkt(struct udevice *dev,
+						uchar *packet, int len)
+{
+	return eth_get_ops(dev)->free_pkt(dev, packet, len);
+}
+
+#if IS_ENABLED(CONFIG_USB_ETHER_RTL8152)
+static int r8152_test_bind(struct unit_test_state *uts, int len,
+			   struct udevice **devp, struct ueth_data **uethp)
+{
+	return usb_eth_test_bind(uts, DM_DRIVER_GET(r8152_eth),
+				 offsetof(struct r8152, ueth), len, devp,
+				 uethp);
+}
+
+/* r8152_eth_recv() returns each packet of an aggregated transfer */
+static int dm_test_r8152_eth_recv(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	/* A packet of 60 bytes, then one of 42 at the next 8-byte boundary */
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(60 + CRC_SIZE, rxbuf);
+	put_unaligned_le32(42 + CRC_SIZE, rxbuf + 88);
+	ut_assertok(r8152_test_bind(uts, 88 + sizeof(struct rx_desc) + 42 +
+				    CRC_SIZE, &dev, &ueth));
+
+	ut_asserteq(60, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + sizeof(struct rx_desc), packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 60));
+	ut_asserteq(42, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 88 + sizeof(struct rx_desc), packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 42));
+	ut_asserteq(-EAGAIN, usb_eth_test_recv(dev, &packet));
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_r8152_eth_recv, 0);
+
+/* r8152_eth_recv() rejects a transfer too short for the rx descriptor */
+static int dm_test_r8152_eth_recv_short(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(CRC_SIZE + 2, rxbuf);
+	ut_assertok(r8152_test_bind(uts, 8, &dev, &ueth));
+
+	ut_asserteq(-ENOSPC, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_r8152_eth_recv_short, 0);
+
+/* r8152_eth_recv() rejects a descriptor length shorter than the CRC */
+static int dm_test_r8152_eth_recv_crc(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(CRC_SIZE - 2, rxbuf);
+	ut_assertok(r8152_test_bind(uts, sizeof(struct rx_desc) + 64, &dev,
+				    &ueth));
+
+	ut_asserteq(-ENOSPC, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_r8152_eth_recv_crc, 0);
+#endif
+
+#if IS_ENABLED(CONFIG_USB_ETHER_ASIX88179)
+/*
+ * struct asix_private is local to the driver; its struct ueth_data comes
+ * first
+ */
+static int ax88179_test_bind(struct unit_test_state *uts, int len,
+			     struct udevice **devp, struct ueth_data **uethp)
+{
+	return usb_eth_test_bind(uts, DM_DRIVER_GET(ax88179_eth), 0, len, devp,
+				 uethp);
+}
+
+/*
+ * Prepare a transfer of 64 bytes of packet data, two packet headers, the
+ * first giving @pkt_len, and the rx header giving @pkt_cnt of them
+ */
+static int ax88179_test_rx(int pkt_cnt, int pkt_len)
+{
+	const int hdr_off = 64;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(pkt_len << 16, rxbuf + hdr_off);
+	put_unaligned_le32(hdr_off << 16 | pkt_cnt, rxbuf + hdr_off + 8);
+
+	return hdr_off + 12;
+}
+
+/* ax88179_eth_recv() returns each packet of the transfer */
+static int dm_test_ax88179_eth_recv(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+	int len;
+
+	/* A packet of 22 bytes padded to 24, then one of 40 up to the headers */
+	len = ax88179_test_rx(2, 22);
+	put_unaligned_le32(40 << 16, rxbuf + 68);
+	ut_assertok(ax88179_test_bind(uts, len, &dev, &ueth));
+
+	ut_asserteq(22, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 2, packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 22));
+	ut_asserteq(40, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 24 + 2, packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 40));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_ax88179_eth_recv, 0);
+
+/* ax88179_eth_recv() rejects packet headers running past the rx header */
+static int dm_test_ax88179_eth_recv_pkt_cnt(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+	int len;
+
+	len = ax88179_test_rx(3, 22);
+	ut_assertok(ax88179_test_bind(uts, len, &dev, &ueth));
+
+	ut_asserteq(-EIO, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_ax88179_eth_recv_pkt_cnt, 0);
+
+/* ax88179_eth_recv() rejects a packet running past the packet headers */
+static int dm_test_ax88179_eth_recv_pkt_len(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+	int len;
+
+	len = ax88179_test_rx(1, 65);
+	ut_assertok(ax88179_test_bind(uts, len, &dev, &ueth));
+
+	ut_asserteq(-EIO, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_ax88179_eth_recv_pkt_len, 0);
+#endif
+
+#if IS_ENABLED(CONFIG_USB_ETHER_LAN75XX) || IS_ENABLED(CONFIG_USB_ETHER_LAN78XX)
+static int lan7x_test_bind(struct unit_test_state *uts, struct driver *drv,
+			   u32 chipid, int len, struct udevice **devp,
+			   struct ueth_data **uethp)
+{
+	struct lan7x_private *priv;
+
+	ut_assertok(usb_eth_test_bind(uts, drv,
+				      offsetof(struct lan7x_private, ueth), len,
+				      devp, uethp));
+	priv = dev_get_priv(*devp);
+	priv->chipid = chipid;
+
+	return 0;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_USB_ETHER_LAN78XX)
+static int lan78xx_test_bind(struct unit_test_state *uts, int len,
+			     struct udevice **devp, struct ueth_data **uethp)
+{
+	return lan7x_test_bind(uts, DM_DRIVER_GET(lan78xx_eth),
+			       ID_REV_CHIP_ID_7800, len, devp, uethp);
+}
+
+/* lan7x_eth_recv() returns the frame behind command A, B and C */
+static int dm_test_lan7x_eth_recv(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(60, rxbuf);
+	ut_assertok(lan78xx_test_bind(uts, 10 + 60, &dev, &ueth));
+
+	ut_asserteq(60, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 10, packet);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_lan7x_eth_recv, 0);
+
+/* lan7x_eth_recv() rejects a transfer too short for command A, B and C */
+static int dm_test_lan7x_eth_recv_short(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(2, rxbuf);
+	ut_assertok(lan78xx_test_bind(uts, 6, &dev, &ueth));
+
+	ut_asserteq(-EINVAL, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_lan7x_eth_recv_short, 0);
+
+/* lan7x_eth_recv() rejects a frame running past the transfer */
+static int dm_test_lan7x_eth_recv_len(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(64, rxbuf);
+	ut_assertok(lan78xx_test_bind(uts, 4 + 64, &dev, &ueth));
+
+	ut_asserteq(-EINVAL, usb_eth_test_recv(dev, &packet));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_lan7x_eth_recv_len, 0);
+
+/* lan7x_free_pkt() steps over the header, the frame and its padding */
+static int dm_test_lan7x_free_pkt(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	/* A frame of 61 bytes, then one of 60 at the next 4-byte boundary */
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(61, rxbuf);
+	put_unaligned_le32(60, rxbuf + 72);
+	ut_assertok(lan78xx_test_bind(uts, 72 + 10 + 60, &dev, &ueth));
+
+	ut_asserteq(61, usb_eth_test_recv(dev, &packet));
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 61));
+	ut_asserteq(60, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 72 + 10, packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 60));
+	ut_asserteq(0, ueth->rxlen);
+	ut_asserteq(-EAGAIN, usb_eth_test_recv(dev, &packet));
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_lan7x_free_pkt, 0);
+#endif
+
+#if IS_ENABLED(CONFIG_USB_ETHER_LAN75XX)
+/*
+ * lan7x_eth_recv() returns the LAN75xx frame behind command A, B and the
+ * padding, which its length counts
+ */
+static int dm_test_lan7x_eth_recv_lan75xx(struct unit_test_state *uts)
+{
+	struct ueth_data *ueth;
+	struct udevice *dev;
+	uchar *packet;
+
+	memset(rxbuf, 0, sizeof(rxbuf));
+	put_unaligned_le32(2 + 60, rxbuf);
+	ut_assertok(lan7x_test_bind(uts, DM_DRIVER_GET(lan75xx_eth),
+				    ID_REV_CHIP_ID_7500, 10 + 60, &dev, &ueth));
+
+	ut_asserteq(60, usb_eth_test_recv(dev, &packet));
+	ut_asserteq_ptr(rxbuf + 10, packet);
+	ut_assertok(usb_eth_test_free_pkt(dev, packet, 60));
+	ut_asserteq(0, ueth->rxlen);
+
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_lan7x_eth_recv_lan75xx, 0);
+#endif
