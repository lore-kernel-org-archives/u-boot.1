Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20331CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 16:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D427841EF;
	Thu,  9 Oct 2025 18:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lcr9KIKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F67844AE; Thu,  9 Oct 2025 18:45:01 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9941840F5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 18:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B13983F7CE; 
 Thu,  9 Oct 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760028299;
 bh=qB49E6k6oUwAJMVxscenj4H5yzDwmNZ/aidwrzs5D/c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lcr9KIKFaVfGiaSzemkMjveL+YJiCDloLMAg7MIMc56UHoJSzLA7/ixkTG25jpg+s
 zS5U+HDze2sIvHfpfzZJ4auY7C7KLLnBRAu7IKzBr3Kf0ByjwfU08kVvm6f9l7vFok
 aZZ1Ru3Ddz/+OUm33/o+Ipc8mEa64yf6LowqpkImdKn1R927OF8QMfE4fz/dpCDgs5
 BegwmQAypy5NV2lHcXzNkX6XA8CnPA/wT5NT+dkCdqs/O4TRil0XCXTNok3u7LIzh/
 DM/gHqmRIJwdm5i1g6ZhlhvovZbsGwankEwBMZWy9prhTxfdam8L2PuLW/3UitpBAm
 6Lr3U41h0WsW5ZG+HVB8BPvavkYtDjZjaBg1Sg5HoR/NiBjzO0n43MWcz2PainPndG
 J3KVNQLf632o/gI1lzNoZO8wVKubtE/ze3BWx0oPuZcmkIT4O71ymUZAVaH9iSrPQv
 f3SqL/INqV1/oubg7qquL0totW1RqfGaF6fxZfontK3sfup+5DZoXBVIb57qc+YugB
 uPrWHnq8paQ89YopVz06laxrN5WevwRn7AYd8lBnlXfxi4U2vSZcYu9zXrTb0UYyRb
 64BcN+WR7xbDiwRocog5eCNK11XIl2TA891z44ukZnYoOC8SK9uhskXWzL6yqkVzUb
 DPxIiz9hpvoIPLnQhZa9yfNo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Debbie Horsfall <debbie.horsfall@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] virito: blk: fix logic to determine block sizes
Date: Thu,  9 Oct 2025 18:44:35 +0200
Message-ID: <20251009164435.49535-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

With commit c85b8071e7d3 ("virtio: blk: support block sizes exceeding 512
bytes") logic was added to detect the VIRTIO_BLK_F_BLK_SIZE capability and
to copy the block size reported by QEMU to the block device descriptor.

The logical block size can be set when invoking QEMU:

    -drive if=none,file=4096.img,format=raw,id=vda \
    -device virtio-blk-device,drive=vda,physical_block_size=4096,logical_block_size=4096

In U-Boot the logical block size is shown by command `virtio info`:

    => virtio info
    Device 0: QEMU VirtIO Block Device
                Type: Hard Disk
                Capacity: 1024.0 MB = 1.0 GB (262144 x 4096)

There where two flaws which together hid that the logic was incorrect:

* VIRTIO_BLK_F_BLK_SIZE was missing in the driver capabilities and the bit
  was filtered out.
* The result of the call to virtio_has_feature() was negated.

The problem became apparent when using ARM FVP as emulator which does not set
VIRTIO_BLK_F_BLK_SIZE.

Fixes: c85b8071e7d3 ("virtio: blk: support block sizes exceeding 512 bytes")
Reported-by: Debbie Horsfall <debbie.horsfall@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/virtio/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 4224e3c17f4..ec2e28b54f7 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -26,6 +26,7 @@ struct virtio_blk_priv {
 };
 
 static const u32 feature[] = {
+	VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_WRITE_ZEROES
 };
 
@@ -194,7 +195,7 @@ static int virtio_blk_probe(struct udevice *dev)
 
 	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
 	desc->lba = cap;
-	if (!virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
+	if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
 		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
 		desc->blksz = blk_size;
 		if (!is_power_of_2(blk_size) || desc->blksz < 512)
-- 
2.51.0

