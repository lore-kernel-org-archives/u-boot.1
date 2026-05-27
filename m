Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF67CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FCD848AA;
	Wed, 27 May 2026 18:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BrhIFJ0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2C5848A9; Wed, 27 May 2026 18:11:26 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6907A84851
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso6393880a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898283; x=1780503083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOfE5JCeyh/vs4ee0+7cfhHXv8AYjKMviZ7FS9rZaAg=;
 b=BrhIFJ0xXuk7iyV/Y3gCC0pJF/tPxUWW4MZ2+ES7sUrrLaSqZSzhJ6vIkH0gi/o+65
 VtFtYdUfRfsIAq/Ci5b1YhLa/rRmTVbW+nCOFjMf2ATUVHtHWIaF8amOGaI4dJrL2UkD
 wI5EJZ/BC7LRAPBJlZWRqtti4T2hREweKrE7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898283; x=1780503083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOfE5JCeyh/vs4ee0+7cfhHXv8AYjKMviZ7FS9rZaAg=;
 b=ZvGrPBpLfJSDEj/nE2tq7artIQhwx1zaH998YPToatbav9KnwlgLRAduq3W/dCKRmv
 cc3A4gDKr1T8wXs2+m5Ikt19bkoCZAF1A4UrDqhCLlAqDHll1W54vzU8Rxc7K1SBo9f+
 xOC87nZztWn3IOZ7iNKHePk4HlecppqdHUqo+jdIgA7Y9ASIXPRNELB89xiJzvcVZZz8
 pYBzFozsz4CUl9evFuokAdqtDi/zaD1a5sbXtz2g2YaK9dti9nMRszDPOUvXdoYejKyA
 5mAaGcnegp/NbH1Co54TyQKhH7R1dwXHwQwURG7r6xe4Y1nAYPdb9VgBJ+Gv3lkgz6hu
 SlMw==
X-Gm-Message-State: AOJu0YyWlgCgsMAKqeL/AIzbqGGf55/0lE7qLKKgpcNX/5BKjRpWPdFG
 EBmWR3veWBu0rNJFD0+Kmh4wQ4pwOtIBDZKwWGlzVYB5dh0IiQT2eFqhr+gdJ5QBViygzP5PHue
 gpj4Dg4JrKk0KxQ==
X-Gm-Gg: Acq92OEfY8jV3s7yiOFBz0jTUOpxH0c9EVqDAbJyaxh4xF3ziX8xbp7xIU3+CBntxPl
 ZRntg6zPSZzg56GPF43fXGCGrSMqTkSo3FUWkJs2kveiVvT99dSkxnOx8FvnyWDaFDgHGLxt+2i
 4B/y9nQJ+5kAHAfeX4Yv2/CmJx+xXbgbROrydvD0kmgJ0FD4PyNw28flWCymGC60LQckuu1Tzxn
 BFSQGS4YJWo59vWrzb4zvRVJlF9HKfGalykYGfSHxMImRfCVi7td72Fwud47e+58zbnKGEu52Z2
 egQsdrgF9t3/cR431AvDZ4Gf/GMgQZnwK56eMrIJvSZ7XDpgC1TdVEJtuUBcnKRxrprzGST150V
 fUJr9iiSBDp75e8b1qpTj8mjDU2fjqn561Xmx/prIA9JUyUUzyFFgeWxjrduGx9zuMJg0A1BnvV
 RjNaXqepIi9EMqb00S5ietrhoMmFq3
X-Received: by 2002:a05:6830:82a2:b0:7dc:cd0b:58b0 with SMTP id
 46e09a7af769-7e5fec65da6mr14691399a34.3.1779898283190; 
 Wed, 27 May 2026 09:11:23 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] virtio: Rename a few legacy-PCI functions
Date: Wed, 27 May 2026 10:10:19 -0600
Message-ID: <20260527161033.3273795-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

With LSP it is confusing to have two functions named the same in
different files. Rename a few of the legacy ones.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/virtio_pci_legacy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 15f8c6e7d25..fe3e3b475ea 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -277,7 +277,7 @@ static int virtio_pci_notify(struct udevice *udev, struct virtqueue *vq)
 	return 0;
 }
 
-static int virtio_pci_bind(struct udevice *udev)
+static int virtio_pci_bind_legacy(struct udevice *udev)
 {
 	static unsigned int num_devs;
 	char name[20];
@@ -289,7 +289,7 @@ static int virtio_pci_bind(struct udevice *udev)
 	return 0;
 }
 
-static int virtio_pci_probe(struct udevice *udev)
+static int virtio_pci_probe_legacy(struct udevice *udev)
 {
 	struct pci_child_plat *pplat = dev_get_parent_plat(udev);
 	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(udev);
@@ -348,8 +348,8 @@ U_BOOT_DRIVER(virtio_pci_legacy) = {
 	.name	= VIRTIO_PCI_DRV_NAME,
 	.id	= UCLASS_VIRTIO,
 	.ops	= &virtio_pci_ops,
-	.bind	= virtio_pci_bind,
-	.probe	= virtio_pci_probe,
+	.bind	= virtio_pci_bind_legacy,
+	.probe	= virtio_pci_probe_legacy,
 	.priv_auto	= sizeof(struct virtio_pci_priv),
 };
 
-- 
2.43.0

