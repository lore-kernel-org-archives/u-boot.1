Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D5E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518A689717;
	Wed,  4 Dec 2024 00:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5cUBYqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2FB89712; Wed,  4 Dec 2024 00:47:54 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888B68967A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so210385639f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269671; x=1733874471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoWeoek1tAJaSsy88HsYiS60U4m3iWD9z9iWtihJc0A=;
 b=J5cUBYqv1EEQIJmP7YcuAMgh9Hun/03NvDeuLG3UDSFgV+XFBDeBC5a2WXiWR7Em9a
 KI8sf6qLJCi3WC7rCnWswyL8GhDYVDCmwBJSJQQlzWzodeR2jLDWbwSKj1knm4woHHbe
 xkAWFJOZNhIaGFmN3u0jm3zRGptPBO2F6Wgdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269671; x=1733874471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoWeoek1tAJaSsy88HsYiS60U4m3iWD9z9iWtihJc0A=;
 b=Yxh510hl1l1RfkLeejyzprznZwD018jm+ogNj5HiedCGUNE5qYCXeT2CUQ0uaEpo8+
 KhKJpGGiceX/2u4LZDbPFlQnZHzb8LFK6X+tKbCowUBjgEO+Goee4lV5KRUyvc2uAjik
 oVm51zj6SQ57N6qXXHS+1+i4SXky/dfGClHzdkqpRJefTn1OULxGmV1lnB6Yrtzcr91n
 LLZRDLDef35TJo3yeikFIKlRhV2JB3il2HvZvFVIZ+zrfAJfspgg9KcVW62GsvAbaJ2g
 5tc1BlL88eK+mVBokEXQ3DHAFCb78kHcNeb5XkXXk8FJHy26+BmMxoDZLzJHwzq5pYBG
 6hTg==
X-Gm-Message-State: AOJu0YzV5GJpQX7KQa2jA7kjmdk32UgabeKJKhr/7ysZYsK47xJ5zDZX
 f786JUy0HukqUlk3eshsWtlr7AZUVZqjJ+X1kVpPniDMyxeqIxduhBYmQD8fP0N+JaI50YDqsQE
 =
X-Gm-Gg: ASbGncvEPXvMIY4sr5rJ6yH3qnyTMyYKjEz6k3Wa2KQFpKEChUhOxWYR5ctPp1x72QB
 moOtE9de8jEOLCjunuYOESqpMiDT4+bOeMYRoV2NjWuYuFjv0h/zLYdgYp+wKlFqk6edGaUlFXd
 ActRZd7dRQ4W89BtZkNjjLyWPiazMtsu/hf+wa07bT0gIglBPxzz3HQfXfKVTFHJn7KvUwntirK
 nvnTrou3T0AkXSmef5oPuE/ooGIdWcY5j8Hbt1m6RIoK2meP/2Jb8V5CiE7f1W27h282ZWKP1Fn
 EJp3q8CIa7E=
X-Google-Smtp-Source: AGHT+IEst/rxjkmK/AMQefmA5duoVdSP89ppJY9mPmQRaiICs+wRK56iVRRMHfcv8Xnu/d0rBd5IOQ==
X-Received: by 2002:a05:6602:2cc5:b0:83d:ff89:218c with SMTP id
 ca18e2360f4ac-8445b574071mr546501439f.7.1733269670856; 
 Tue, 03 Dec 2024 15:47:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 35/41] bootmeth_pxe: Drop the driver-private data
Date: Tue,  3 Dec 2024 16:45:53 -0700
Message-Id: <20241203234559.2938192-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Since this driver's plat-data already contains a PXE context, use that.
Drop the priv-data. Use the extlinux_info which is in there, as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 6b3cb3c4b91..a9608edcef9 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -140,7 +140,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context *ctx = dev_get_priv(dev);
+	struct pxe_context *ctx = &plat->ctx;
 	ulong addr;
 	int ret;
 
@@ -188,6 +188,5 @@ U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.of_match	= extlinux_bootmeth_pxe_ids,
 	.ops		= &extlinux_bootmeth_pxe_ops,
 	.bind		= extlinux_bootmeth_pxe_bind,
-	.priv_auto	= sizeof(struct pxe_context),
 	.plat_auto	= sizeof(struct extlinux_plat)
 };
-- 
2.34.1

