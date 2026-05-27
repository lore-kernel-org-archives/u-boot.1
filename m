Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A321CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C635C848A5;
	Wed, 27 May 2026 18:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EMlZiO6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52651848BD; Wed, 27 May 2026 18:11:32 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DCEA84837
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so12473185a34.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898289; x=1780503089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+N6EzGOVIpDmV6Mv1WGPUvcAfg2zZa+QrAKy7jHaWI=;
 b=EMlZiO6StCfpC8Z0sva6TV8k3Wz64SNlm7KTSII6b0c89GFS0SF0cmKGVbKiB1nPI2
 7nM/kNcpkXtnvJKUmrurVLxA++dC7zbLf78XvDC6vrimF6EZRhS3u83Y5qKP4e8Ctplr
 /KIM8ve/wczPZnrVsn1M/atb/slUKVqJ1SlQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898289; x=1780503089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J+N6EzGOVIpDmV6Mv1WGPUvcAfg2zZa+QrAKy7jHaWI=;
 b=p3zRgZskvJL5v7ALmRwWCKptIiMUtNnP54jybfYcocEkjaIvNYBGyKjsZ/lDivGwTb
 7Yx4HPJZC4D9/fb5othUtNCVibTMk+sH/HhknmT34iPGoWtPdt1wJ9SSCLhUC7NaLHls
 VfBw5nHSENXh3uHUQSrd6Ov6Xii5x8LfoGVD9vZC6P5nSxavqH6Y4yBuhNkpPu4wTHei
 fwfO4GuMLvI8vL7CPSw5Q1z1FMJ9I+ABA0tCSh9HJb6GziVHUDxIQ564sn9sxSAhkwWb
 JFHHH5VaWl/bC2l8Gs+C7pP8sn9H7NE9Rg0JElUWhrlE/3cD3bzcWQkU2mGSMfnVYE7u
 VW4Q==
X-Gm-Message-State: AOJu0YwbdjQfJNXWPYj59O7T2tlQeVfZQufEOVibSotvnZTJGxwPxFG1
 4jsfj+2KWsE+al3w0iiFSHF2ma7Oswetd/Iy6m4U37K/Pa+ua7MYPGTbrmig/rDuj2uy90gCAtD
 20C/cYWovKCg4DQ==
X-Gm-Gg: Acq92OF0c8r2PRUf243BrfMITtd4F5KvjJww3/ho/W8XIcaCc5bWf0dIWNpGXzsgLgn
 uHtGqpXHkxLl9n5LJk/FRuxD8Mk5/SeK2Biq1enBtawudNb8IoVDScex7wSjYoZ4wN+zUkOZskT
 wVShW4CPTmAF23r8nPpW1Th2a6bFKHoKr6SEpQtLDNv6482OJrmsSpucUvd57PiJVj2fJ+ObMRm
 yXkjLUyBNzPz9Q3HDJPLV7/kK1sQ2Bg5WonH+sLfOYhLjgJh+43VEJJuDOj+T9GAzEblEqP8iY7
 q6DQZs7gFdBWTJFHl7E4MRVyoFwdnVl6PyDC9BB5PqdOIfgfOkPPZXtsv8tKw4nygkNI/ryk385
 7o55KJ2fR+ajE7WZ3yPq9WfhCs6i4dUNZN12fKjyFQxljWVWK8XCAIr77nkyHA+Pno/+ONzEhBr
 x1bCf/etfDkq80yXHtEw==
X-Received: by 2002:a05:6830:668c:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7e5ffe89160mr12517949a34.6.1779898288840; 
 Wed, 27 May 2026 09:11:28 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Christian Speich <c.speich@avm.de>, Daniel Palmer <daniel@thingy.jp>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kavin Gunasekara <kavin.gunasekara@arm.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Meet Patel <meet.patel2@arm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] virtio: Delete vqs when removing a device
Date: Wed, 27 May 2026 10:10:22 -0600
Message-ID: <20260527161033.3273795-13-sjg@chromium.org>
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

The rng, net, blk and scsi drivers all use virtio_reset() as their
remove() method.

virtio_reset() only uses the transport's reset() operation, leaving the
virtual queues still allocated (12 KB per virtqueue). Every probe/remove
cycle of a virtio device therefore fails to free its queues.

Add a remove() method to delete the queues before resetting. Update the
four drivers to use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/virtio-uclass.c | 7 +++++++
 drivers/virtio/virtio_blk.c    | 2 +-
 drivers/virtio/virtio_net.c    | 2 +-
 drivers/virtio/virtio_rng.c    | 2 +-
 include/virtio.h               | 8 ++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index 7003f30cb85..532d50ea088 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -90,6 +90,13 @@ int virtio_reset(struct udevice *vdev)
 	return ops->reset(vdev->parent);
 }
 
+int virtio_remove(struct udevice *vdev)
+{
+	virtio_del_vqs(vdev);
+
+	return virtio_reset(vdev);
+}
+
 int virtio_get_features(struct udevice *vdev, u64 *features)
 {
 	struct dm_virtio_ops *ops;
diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 404d9140cb2..fe06135a7ac 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -296,7 +296,7 @@ U_BOOT_DRIVER(virtio_blk) = {
 	.ops	= &virtio_blk_ops,
 	.bind	= virtio_blk_bind,
 	.probe	= virtio_blk_probe,
-	.remove	= virtio_reset,
+	.remove	= virtio_remove,
 	.priv_auto	= sizeof(struct virtio_blk_priv),
 	.flags	= DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
index 7a94c8a528f..d49dab3a6ed 100644
--- a/drivers/virtio/virtio_net.c
+++ b/drivers/virtio/virtio_net.c
@@ -233,7 +233,7 @@ U_BOOT_DRIVER(virtio_net) = {
 	.id	= UCLASS_ETH,
 	.bind	= virtio_net_bind,
 	.probe	= virtio_net_probe,
-	.remove = virtio_reset,
+	.remove = virtio_remove,
 	.ops	= &virtio_net_ops,
 	.priv_auto	= sizeof(struct virtio_net_priv),
 	.plat_auto	= sizeof(struct eth_pdata),
diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
index c6de62142bb..9a5db5f3930 100644
--- a/drivers/virtio/virtio_rng.c
+++ b/drivers/virtio/virtio_rng.c
@@ -89,7 +89,7 @@ U_BOOT_DRIVER(virtio_rng) = {
 	.id	= UCLASS_RNG,
 	.bind	= virtio_rng_bind,
 	.probe	= virtio_rng_probe,
-	.remove = virtio_reset,
+	.remove = virtio_remove,
 	.ops	= &virtio_rng_ops,
 	.priv_auto	= sizeof(struct virtio_rng_priv),
 	.flags	= DM_FLAG_ACTIVE_DMA,
diff --git a/include/virtio.h b/include/virtio.h
index 3edf023463d..5c580e59779 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -285,6 +285,14 @@ int virtio_set_status(struct udevice *vdev, u8 status);
  */
 int virtio_reset(struct udevice *vdev);
 
+/**
+ * virtio_remove() - remove a virtio device by deleting its vqs and resetting it
+ *
+ * @vdev:	the real virtio device
+ * Return: 0 if OK, -ve on error
+ */
+int virtio_remove(struct udevice *vdev);
+
 /**
  * virtio_get_features() - get the array of feature bits for this device
  *
-- 
2.43.0

