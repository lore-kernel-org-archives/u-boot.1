Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1ACCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D98083DB6;
	Fri,  7 Nov 2025 14:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="iFqtaaO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD35B83D77; Fri,  7 Nov 2025 14:03:12 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8628583D85
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkd1yMKzlxP;
 Fri,  7 Nov 2025 14:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520585;
 bh=bBO44FSRtmfUkxHdGoxVjLhVRRIWV5PfbI0abbJtHiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iFqtaaO5pxYMgRbqB2rQcJZZdDcp4SrMJ+hEgFIKgTyp7kAQ1NHRhfQnEnUKLtAUr
 04Tl6u0AHe+RsahZOealpQ9o5+HIt8uXHvMLxA9X+bA3WoRyZaFGbxKbtM1xDniv8w
 TaRgZhLK94H66XEFIvUlKWmqOQcUfpblWjgst0ek=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkc4VJBzShD; Fri,  7 Nov 2025 14:03:04 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/6] remoteproc: k3-r5: Use verified image address
Date: Fri,  7 Nov 2025 14:01:04 +0100
Message-ID: <20251107130216.3084134-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

After ti_secure_image_post_process() authenticates the image, it may
relocate it to a different memory location and update image_addr to
point to the verified image.

However, rproc_elf_load_image() and rproc_elf_get_boot_addr() were
still using the original "addr" parameter, potentially operating on
the unverified or stale image location instead of the authenticated
image.

Use image_addr (cast to ulong to match function signatures) after
authentication to ensure all operations work with the verified image.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

(no changes since v1)

 drivers/remoteproc/ti_k3_r5f_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index e7bd97a9088b..36ea449f5121 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -343,13 +343,13 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 
 	ti_secure_image_post_process(&image_addr, (size_t *)&size);
 
-	ret = rproc_elf_load_image(dev, addr, size);
+	ret = rproc_elf_load_image(dev, (ulong)image_addr, size);
 	if (ret < 0) {
 		dev_err(dev, "Loading elf failedi %d\n", ret);
 		goto proc_release;
 	}
 
-	boot_vector = rproc_elf_get_boot_addr(dev, addr);
+	boot_vector = rproc_elf_get_boot_addr(dev, (ulong)image_addr);
 
 	dev_dbg(dev, "%s: Boot vector = 0x%llx\n", __func__, boot_vector);
 
-- 
2.51.2

