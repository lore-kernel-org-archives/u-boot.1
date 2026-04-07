Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9642AEDB7E0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 09:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA4C83A41;
	Tue,  7 Apr 2026 11:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6WTBCO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669C483F98; Tue,  7 Apr 2026 11:49:19 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A698352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 11:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso1955898a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775555355; x=1776160155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PGojpPGpkIoQXx+jvmfGstXIhMAA796AdO0xHsGols4=;
 b=W6WTBCO6y3Xi5ZriXOcmWKQJBKUGxONltJiTUFwbgrK69GgoelCTEu7PO2uJh7YjQG
 92p+T8bdgaqkpa0cCuvU8Far7tFb5K3dbTpEiFWnJqLn7wSLkhln/zpXeNoOtWh9o1xT
 xpjGeWPkWi8WjfPmaC0zJ1mXr8IHmz2BSJBtk/n5a0Olg7DdWo1MfrTBVxhSPQ70Impw
 GjDwSV9qfXgp5oEpIKcxiHvWMG5WLYItTKIAd5T31WGapjc1h09QYYimdTpTk+rtCjKh
 tbgJpLbPO8j2aL4axF/AuwgWh1MnKBVmP0gKMoXGUsUzmapL4a21MO8o6QgT1jaMTuUA
 775w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775555355; x=1776160155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGojpPGpkIoQXx+jvmfGstXIhMAA796AdO0xHsGols4=;
 b=WMvjHVEPVRMSYa3oCYSdiDhI9nNljZ9pAkkbXfY8VTxiSCTp/tVL2nSOJMIkwGy4yL
 L7dc6DKce/Ik7w+hyMpqvDBGBd/23GkFZ/VcowXX8OEl6cp7HDSysgR7+ZJ4viPeVBGC
 MZT03sKGuHIFNiVn0wcWv2AxXMekISR3HVGPpZBYGEH2k7zv/u1Pxvwf2JiSWmruC9uK
 lR4aJ046rhXLNFg4jwvhY+7wREIIqZpMmyH3hggOcblUjVozV1GyIh4WyAIQgotClUqP
 UenJNySZIGDUq62SULbopN4BWduwvYid2VXyQOJKr+AESoGILl+iybsovyJVYaYM1nPx
 Kstg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9pVfNu2Q8IiE9jPfbXydlXafRIBKjWdnW5gCS7X/8EqW1utAM+EyfYxHQkjMQUae/KOGRSIE=@lists.denx.de
X-Gm-Message-State: AOJu0YyIg7ga+mpRbcbLjnGwriwLJSVE/ki4XzE+/0bgo4W9EWz91ETM
 oETaoxnqA5CbfjPZWNKRuTQBc8aSGYAKKwJsL2PtyPWhhMYV7A+E4aq6U3zDuw==
X-Gm-Gg: AeBDiesVwmEp1i6Z0psmthgswvVgLUy954sgecO7kuDS0RpdhvRwLS3kVTGZzCK4C3f
 TSxbCLFTFkAwMjd9WBSkGaQKlXjVnF5ECX6d5KVDH8ewtLqV0jyWHqoGsyD/7bKOfcHYTD4Ev1b
 ZnLJ2EGNskLx/pcfm6ZotPn0CL2fEmFZpuE6VZAE1kICo6Qlqj9RUJGwORuF8IMJv3LaKa3hl3m
 y0SmahqM+hNqUyPH+wIhs9rMP5SVJcifwEgm7UlbJO+hOKEV889bosP3XXnRqFgZD8Ou3Qr37eB
 HqQrg2Xl7K72P39I5IJkS+a4BfUKdzb2MRGrAEQnxvmgyKitNMUxbK2+lM+p/NzCqzET6dqR+Ur
 sBSAultGp0KpBebP9Fekc7jVR4X5gajxG2Rm72s9+AVtLgYcFE1raqt1a7bZZ2aRGXuWUZD1HGq
 hjfDUVlMmwaP7AE6QrvtTxHSJokpd76FaUdFF4EzAxYQI26KHTwc/zywSHX9UkLVLdJb6HY4Fp3
 73wItdolKx2bj3ya6yZJiaS9yMGG6NkwV+Y80E=
X-Received: by 2002:a17:903:2c07:b0:2b2:67ca:5ff1 with SMTP id
 d9443c01a7336-2b2818afe20mr176672035ad.31.1775555355533; 
 Tue, 07 Apr 2026 02:49:15 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (100.130.194.35.bc.googleusercontent.com. [35.194.130.100])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27475bc2asm171878375ad.19.2026.04.07.02.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:49:14 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bmeng.cn@gmail.com,
	trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, sjg@chromium.org, daniel@thingy.jp,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] virtio: mmio: Return error codes on probe failures
Date: Tue,  7 Apr 2026 09:49:00 +0000
Message-ID: <20260407094900.420176-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

Currently, virtio_mmio_probe() returns 0 when it encounters an invalid
magic value, an unsupported version, or a dummy device (ID 0). In
U-Boot's driver model, returning 0 indicates a successful probe. This
causes the system to incorrectly register and activate invalid or
placeholder devices, potentially leading to undefined behavior or
crashes later on.

Update the probe function to return appropriate error codes (-ENODEV
for invalid magic values and dummy devices, and -ENXIO for unsupported
versions). This fix correctly instructs the DM to abort the binding
process.

Fixes: fdc4aca89ecb ("virtio: Add virtio over mmio transport driver")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1cd737aca24..62afe609ec0 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -354,7 +354,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 	magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		debug("(%s): wrong magic value 0x%08x!\n", udev->name, magic);
-		return 0;
+		return -ENODEV;
 	}
 
 	/* Check device version */
@@ -362,7 +362,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 	if (priv->version < 1 || priv->version > 2) {
 		debug("(%s): version %d not supported!\n",
 		      udev->name, priv->version);
-		return 0;
+		return -ENXIO;
 	}
 
 	/* Check device ID */
@@ -372,7 +372,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return 0;
+		return -ENODEV;
 	}
 	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
 
-- 
2.53.0.1213.gd9a14994de-goog

