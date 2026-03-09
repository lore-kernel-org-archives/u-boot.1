Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0794FCA173
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 18:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E8883F82;
	Mon,  9 Mar 2026 19:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AD583F14; Mon,  9 Mar 2026 17:55:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BFD7883A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=meet.patel2@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C35811570;
 Mon,  9 Mar 2026 09:55:18 -0700 (PDT)
Received: from e137877.manchester.arm.com (e137877.arm.com [10.33.11.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98B653F7BD;
 Mon,  9 Mar 2026 09:55:23 -0700 (PDT)
From: Meet Patel <meet.patel2@arm.com>
To: kavin.gunasekara@arm.com
Cc: andre.przywara@arm.com, bmeng.cn@gmail.com, sjg@chromium.org,
 sughosh.ganu@linaro.org, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: [PATCH v2 2/2] virtio: rng: Handle oversized return buffers
Date: Mon,  9 Mar 2026 16:55:05 +0000
Message-ID: <20260309165505.4001705-3-meet.patel2@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309165505.4001705-1-meet.patel2@arm.com>
References: <20260309165505.4001705-1-meet.patel2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Mar 2026 19:28:38 +0100
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

From: Kavin Gunasekara <kavin.gunasekara@arm.com>

If extra random bytes are returned, truncate and use the requested number
instead of returning an error.

Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>
Signed-off-by: Meet Patel <meet.patel2@arm.com>
---
 drivers/virtio/virtio_rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
index 90a371a59cc..c6de62142bb 100644
--- a/drivers/virtio/virtio_rng.c
+++ b/drivers/virtio/virtio_rng.c
@@ -46,7 +46,7 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
 			;
 
 		if (rsize > sg.length)
-			return -EIO;
+			rsize = sg.length;
 
 		memcpy(ptr, buf, rsize);
 		len -= rsize;
-- 
2.53.0

