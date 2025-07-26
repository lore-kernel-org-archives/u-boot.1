Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE05C83F17
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 06:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6064383616;
	Sat, 26 Jul 2025 08:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="B6WGK7Ae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A444B83666; Sat, 26 Jul 2025 08:18:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957F5835D8
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 08:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-109-128.46.114.pool.telefonica.de
 [46.114.109.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C340F3FB50; 
 Sat, 26 Jul 2025 06:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753510685;
 bh=OGhb4RPV3cme9eda0UsPGynoJ68RnCMXLupTt315Trc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=B6WGK7AeRwiYHKAVQRHFsZyQVuAsVpW1GqcgWNWIUGWxUpj6R1A+8NeafFkCZlJQi
 EFjC/KmQODbnZm5npiEm3wNg7VzpiPjzeXMDvONb4JOkZk5b/sf6JeFDXtS6VJOuj5
 uYJFuVU6u7ON9rqcw8ns5AUMmpArvn3iOAmK0epgnVnW7j6Z7cMPIpZG1XlipymW8h
 HRjJlse+nCYq0ZP5YIN703q6Xwo8/OqoVmlUs+45W3U28Xry0qHbfFo1VsApRrvWw7
 /qgJCeY0ucK/GCOs782hATmNF3/UXgMbmKpjd+F1XMn/WzTBUvQbFgMEtYTiTAbZUF
 VDY/A+n4DVwxw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Will Deacon <willdeacon@google.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] virtio: fix freeing of virtio ring buffer
Date: Sat, 26 Jul 2025 08:17:58 +0200
Message-ID: <20250726061758.96768-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

If the allocation if the bounce buffer fails, virtio_free_pages is called
with a random value from the stack.

Ensure that vring.size is initialized.

Fixes: 37e53db38bdb ("virtio: Allocate bounce buffers for devices with VIRTIO_F_IOMMU_PLATFORM")
Addresses-Coverity-ID: 453314 Uninitialized scalar variable
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 306fa5b3f68..3a40b12f6e5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -349,9 +349,10 @@ struct virtqueue *vring_create_virtqueue(unsigned int index, unsigned int num,
 
 	/* TODO: allocate each queue chunk individually */
 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		size_t sz = vring_size(num, vring_align);
+		vring.size = vring_size(num, vring_align);
 
-		queue = virtio_alloc_pages(vdev, DIV_ROUND_UP(sz, PAGE_SIZE));
+		queue = virtio_alloc_pages(vdev,
+					   DIV_ROUND_UP(vring.size, PAGE_SIZE));
 		if (queue)
 			break;
 	}
@@ -362,6 +363,7 @@ struct virtqueue *vring_create_virtqueue(unsigned int index, unsigned int num,
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
 		queue = virtio_alloc_pages(vdev, 1);
+		vring.size = PAGE_SIZE;
 	}
 	if (!queue)
 		return NULL;
-- 
2.50.0

