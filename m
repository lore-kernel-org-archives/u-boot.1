Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B88FE909A4
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73CE83E0E;
	Tue, 17 Feb 2026 14:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9227883C32; Tue, 17 Feb 2026 14:31:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9F14080325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kavin.gunasekara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B371477;
 Tue, 17 Feb 2026 05:30:59 -0800 (PST)
Received: from e142508.manchester.arm.com (e142508.arm.com [10.33.11.66])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14EB3F632;
 Tue, 17 Feb 2026 05:31:04 -0800 (PST)
From: Kavin Gunasekara <kavin.gunasekara@arm.com>
To: u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 trini@konsulko.com, sjg@chromium.org, kavin.gunasekara@arm.com,
 andre.przywara@arm.com
Subject: [PATCH 2/2] virtio: rng: Handle oversized return buffers
Date: Tue, 17 Feb 2026 13:29:36 +0000
Message-Id: <20260217132936.2736916-3-kavin.gunasekara@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217132936.2736916-1-kavin.gunasekara@arm.com>
References: <20260217132936.2736916-1-kavin.gunasekara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 14:40:39 +0100
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

If extra random bytes are returned, truncate and use the requested number
instead of returning an error.

Signed-off-by: Kavin Gunasekara <kavin.gunasekara@arm.com>
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
2.34.1

