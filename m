Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B761C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF9D86DAF;
	Tue,  7 Nov 2023 17:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C9686F44; Tue,  7 Nov 2023 17:09:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B180D86470
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B43D1476;
 Tue,  7 Nov 2023 08:09:54 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D00143F64C;
 Tue,  7 Nov 2023 08:09:08 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
	Peter Hoyes <peter.hoyes@arm.com>
Subject: [PATCH] virtio: rng: gracefully handle 0 byte returns
Date: Tue,  7 Nov 2023 16:09:00 +0000
Message-Id: <20231107160900.2652813-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

According to the virtio v1.x "entropy device" specification, a virtio-rng
device is supposed to always return at least one byte of entropy.
However the virtio v0.9 spec does not mention such a requirement.

The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng always
returns 8 bytes less of entropy than requested. If 8 bytes or less are
requested, it will return 0 bytes.
This behaviour makes U-Boot's virtio_rng_read() implementation go into an
endless loop, hanging the system.

Work around this problem by always requesting 8 bytes more than needed,
but only if a previous call to virtqueue_get_buf() returned 0 bytes.

This should never trigger on a v1.x spec compliant implementation, but
fixes the hang on the Arm FVP.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Peter Hoyes <peter.hoyes@arm.com>
---
 drivers/virtio/virtio_rng.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
index b85545c2ee5..786359a6e36 100644
--- a/drivers/virtio/virtio_rng.c
+++ b/drivers/virtio/virtio_rng.c
@@ -20,7 +20,7 @@ struct virtio_rng_priv {
 static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
 {
 	int ret;
-	unsigned int rsize;
+	unsigned int rsize = 1;
 	unsigned char buf[BUFFER_SIZE] __aligned(4);
 	unsigned char *ptr = data;
 	struct virtio_sg sg;
@@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
 
 	while (len) {
 		sg.addr = buf;
-		sg.length = min(len, sizeof(buf));
+		/*
+		 * Work around implementations which always return 8 bytes
+		 * less than requested, down to 0 bytes, which would
+		 * cause an endless loop otherwise.
+		 */
+		sg.length = min(rsize ? len : len + 8, sizeof(buf));
 		sgs[0] = &sg;
 
 		ret = virtqueue_add(priv->rng_vq, sgs, 0, 1);
-- 
2.25.1

