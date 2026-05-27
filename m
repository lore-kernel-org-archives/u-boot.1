Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AC9CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B058284851;
	Wed, 27 May 2026 18:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M46oME1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E274884894; Wed, 27 May 2026 18:11:24 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDBC84837
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e61da76fd9so3126904a34.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898281; x=1780503081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAmQisLW13I33biGWC/YvVDaDJycf1Cv6ApIMmPHNdg=;
 b=M46oME1Nkl9UXSKereNHMld7c/0Pl0nWNx2r5G/1o3kFdJrPHLjNo6Hw0h4XlJ1OKI
 /KLnN7RZFsU6Sz1B+10heLP2j7MCrPzLpV5UxTTe0Cw+Ch3cNtzGOHdzSUsooij8srE4
 /3LkeLI4Ot29pZwoVjCucAajpMr/8PWk/NWL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898281; x=1780503081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jAmQisLW13I33biGWC/YvVDaDJycf1Cv6ApIMmPHNdg=;
 b=IgE7ejzNX9SRSUWGBAT2noKKTzKFwV3zUsH7D5EEzdY5BOSzvtuVkGjSsMm1MNirRm
 wNkn1nNweH8GrpixeyunGupZmVeqJ8fbDIiSGprmz8ZKfaqYS5BTXrONI0+z24MFHA+/
 qAYLFvkDm3ick/Ye0ozjtF+9/LZCH3HP4ZSnOGFbTBT4AYmxaRcdKz7BSdjJlbhBd8JG
 qDCObCIvNIL6cv2dQWOvnT5x4uf3DHZkxcfdLWHXurb6bbueHHHpBueUd6HjonlqcAvT
 wdk3x+ufg2xolQVinRweJLHVLC/E7kLvTMbqNrhS0vasvrGYF8OWXk6CZbjUqx7wk6IE
 ZPUw==
X-Gm-Message-State: AOJu0Yw2YcefRxT84ZK/TUbUnDxrWv9Mk3nAQ4Ie+vJLSG8MFLZKD1zY
 8sCfuDbAJ9yMqP0GR3C9dWe6WZKQZnBRtWEvC6Veyyp9LJWLIYEOllVkmZDgPujvZkqSu6fTc3i
 0ikM6GId77kUMVg==
X-Gm-Gg: Acq92OH2583lRJ9hze4VPD6s5hzA8f1EzOnyEllmwrJAOVWB4VGjLAVupeOCribKHQN
 j/qbgwNaEGHzFZ3LDwTief6P9VQyGpI5ubO8ltT7LpZk5NtYi7KZ78agjd6j6X4e96CCuquWlSs
 IMXeAm1hKI8JolU7pznZ3xL5xaDXB+70v8RhjgMmk3AXvc7GRMC5T9XiQicugO1TE5CBxabzkCN
 vIy8y6cn3b8zZa18uuvHT5mf9oPgVmN0JBfj6DJyUAnktJBiCBtNYfeWC5ozEnOdVbH6BRmTRb+
 eaPB8D8ltWy9vPvOTideHuYuNt+daJKBizrQ9nC32e8nrIvzazOjEye+PGGP8k7iw7Wu9b32B6l
 QTQQDtaDkoy43V/hKaWoBQYfXy9u629juHYIX4bk1MOIpWOQfWJ1OH7BSY/iJNJdlvXbXo3mu1S
 Bwk5Ych0nn6m/59T1+KQ==
X-Received: by 2002:a05:6830:3c88:b0:7d9:b189:d938 with SMTP id
 46e09a7af769-7e5fedef14amr14545348a34.10.1779898281532; 
 Wed, 27 May 2026 09:11:21 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/13] virtio: Acknowledge devices only when probed
Date: Wed, 27 May 2026 10:10:18 -0600
Message-ID: <20260527161033.3273795-9-sjg@chromium.org>
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

At present virtio devices are acknowleged when bound. This results in a
call to virtio_set_status() which uses device-private data in several
cases, e.g. in virtio_pci_get_status()

This data is only allocated when the device is probed, so the access is
either ignored (on QEMU) or results in a crash (on sandbox).

Acknowledging the device so early does not seem to be necessary. Move it
to the pre-probe function instead. Update the test to match. We now have
no coverage to check that VIRTIO_CONFIG_S_ACKNOWLEDGE was actually set.

If we later find it necessary to acknowledge the device while binding,
we can update the uclass and drivers to use plat data instead of priv.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/virtio-uclass.c | 12 +++---------
 test/dm/virtio_device.c        |  2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index 927f05e2ccd..7003f30cb85 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -257,14 +257,6 @@ static int virtio_uclass_post_probe(struct udevice *udev)
 	return 0;
 }
 
-static int virtio_uclass_child_post_bind(struct udevice *vdev)
-{
-	/* Acknowledge that we've seen the device */
-	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-
-	return 0;
-}
-
 static int virtio_uclass_child_pre_probe(struct udevice *vdev)
 {
 	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(vdev->parent);
@@ -278,6 +270,9 @@ static int virtio_uclass_child_pre_probe(struct udevice *vdev)
 	if (device_get_uclass_id(vdev) == UCLASS_BOOTDEV)
 		return 0;
 
+	/* Acknowledge that we've seen the device */
+	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
 	/*
 	 * Save the real virtio device (eg: virtio-net, virtio-blk) to
 	 * the transport (parent) device's uclass priv for future use.
@@ -394,7 +389,6 @@ UCLASS_DRIVER(virtio) = {
 	.flags	= DM_UC_FLAG_SEQ_ALIAS,
 	.pre_probe = virtio_uclass_pre_probe,
 	.post_probe = virtio_uclass_post_probe,
-	.child_post_bind = virtio_uclass_child_post_bind,
 	.child_pre_probe = virtio_uclass_child_pre_probe,
 	.child_post_probe = virtio_uclass_child_post_probe,
 	.per_device_auto	= sizeof(struct virtio_dev_priv),
diff --git a/test/dm/virtio_device.c b/test/dm/virtio_device.c
index c2cd0630d97..5ac7ef9d309 100644
--- a/test/dm/virtio_device.c
+++ b/test/dm/virtio_device.c
@@ -31,7 +31,7 @@ static int dm_test_virtio_base(struct unit_test_state *uts)
 
 	/* check driver status */
 	ut_assertok(virtio_get_status(dev, &status));
-	ut_asserteq(VIRTIO_CONFIG_S_ACKNOWLEDGE, status);
+	ut_asserteq(0, status);
 
 	/* probe the virtio-rng driver */
 	ut_assertok(device_probe(dev));
-- 
2.43.0

