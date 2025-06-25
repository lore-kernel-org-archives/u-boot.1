Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DD8C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 21:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB21882CFA;
	Wed, 25 Jun 2025 23:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750885298;
	bh=ZyuxIW9cvzOGEp4HwmlePNmN8IWpzPplIqLPvBZYEWY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NqyV4ZrHPZEmPcjxPNqQnMop+MN4vKVtpcD+6CWzuoIErzA+E3x7lZwWC3vaOzjVU
	 7kVlRmZKnhhOuAXLZ1nl/yHIyoI6d03+MmfJdyPQfwsMztXAGWFsgKwnCnUwrvbBK3
	 cyK3vIiI0hWYzQaeZtGderJGpxmm9/up9aILf1MSWoaAt5sJD9/u5rNiT56WL/VM5v
	 JNz7NPjmU7WIqCmwKcpDMxL6cKQw5nw86gF6yw4BrTz38ft5vv3HUPeecwsWZuk4jL
	 WFiv6fvWj7LSpi1+TWiGKGsbZwnTD52LBCS04KSeC92jMC7eqypppj1lm06sqj+gQO
	 i2R7/x1FSmLDw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669A882D21; Wed, 25 Jun 2025 23:01:37 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0486782C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 23:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agust@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="S9JGOIeF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 273261039BD02
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 23:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750885293; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=ZyuxIW9cvzOGEp4HwmlePNmN8IWpzPplIqLPvBZYEWY=;
 b=S9JGOIeFPUq3pxhNVCgvA6/gsHPLK3FpQH8kZHyaoF883o0syRZEqgBwcCkg1bS+ErFunZ
 I6QjRBLrT+pfqGT75gwGpqKxdUgj7qrN33zLtn6Rvh/u1EmCLULtZJwHQYb+obVN5MQ4pV
 KlY7gce+0A3DPv3AG7in9dhYiH0R5SJZM8ERgk67exkt4Bn5wGqycQ8rjqxeSFdc9H65/p
 vJ/NiNkom6mAFZcKHmG6XS1UWYHYIDZ4fdOJloEfln1HWpWc2x2bITCSK4lB7UwPTd2Y8N
 CMZQqZG88ODL04VgVRmSDiJj93cRv3G0s7j0rWeeMc3vnZYcyXg5x5d+yhE3jA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: add linux initrd ramdisk properties to dtb
Date: Wed, 25 Jun 2025 23:01:32 +0200
Message-Id: <20250625210132.800789-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Currently when SPL is booting FIT images with ramdisk
the kernel fails to find the ramdisk and panics.

This is due to missing "linux,initrd-start/end"
properties in the device tree. Add fixup to insert
these properties if a ramdisk is detected in the
FIT image.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 common/spl/spl_fit.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index b3824af475f..29f06778507 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -567,6 +567,17 @@ static int spl_fit_image_get_os(const void *fit, int noffset, uint8_t *os)
 	return 0;
 }
 
+static int spl_fit_image_is_ramdisk(const void *fit, int node)
+{
+	const char *type;
+
+	type = fdt_getprop(fit, node, FIT_TYPE_PROP, NULL);
+	if (!type)
+		return 0;
+
+	return !strcmp(type, FIT_RAMDISK_PROP);
+}
+
 /*
  * The purpose of the FIT load buffer is to provide a memory location that is
  * independent of the load address of any FIT component.
@@ -890,6 +901,18 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			spl_image->fdt_addr = image_info.fdt_addr;
 		}
 
+		if (spl_fit_image_is_ramdisk(ctx.fit, node)) {
+			/*
+			 * Insert initrd properties into dtb for
+			 * ramdisk detection in kernel
+			 */
+			if (spl_image->fdt_addr) {
+				fdt_initrd(spl_image->fdt_addr,
+					   image_info.load_addr,
+					   image_info.load_addr + image_info.size);
+			}
+		}
+
 		/*
 		 * If the "firmware" image did not provide an entry point,
 		 * use the first valid entry point from the loadables.
-- 
2.25.1

