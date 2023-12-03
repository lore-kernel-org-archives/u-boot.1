Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91604C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE898757C;
	Mon,  4 Dec 2023 01:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12B7875EB; Sun,  3 Dec 2023 18:08:29 +0100 (CET)
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7A1875B9
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=rubini@arcana.gnudd.com
Received: from rubini by mail.gnudd.com with local (Exim 4.94.2)
 (envelope-from <rubini@arcana.gnudd.com>) id 1r9pxC-0002Ev-QZ
 for u-boot@lists.denx.de; Sun, 03 Dec 2023 18:08:26 +0100
Date: Sun, 3 Dec 2023 18:08:26 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: u-boot@lists.denx.de
Subject: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
Message-ID: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
X-Mailman-Approved-At: Mon, 04 Dec 2023 01:24:45 +0100
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

The tool works for me, with imx28 and NAND memory, but the resulting
blocks are reported as bad, both by u-boot and the kernel.

This makes it impossible to erase from Linux (for an upgrade without
console access, for example -- u-boot can "nand scrub" but linux can't).

pre-filling with 0xff creates a proper boot loader image, but no
bad-block marker is there when written to flash.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
---
 tools/mxsboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mxsboot.c b/tools/mxsboot.c
index 04d86f87a8..8f4018aa56 100644
--- a/tools/mxsboot.c
+++ b/tools/mxsboot.c
@@ -478,7 +478,7 @@ static int mx28_create_nand_image(int infd, int outfd)
 		goto err0;
 	}
 
-	memset(buf, 0, size);
+	memset(buf, 0xff, size);
 
 	fcb = mx28_nand_get_fcb(MAX_BOOTSTREAM_SIZE);
 	if (!fcb) {
-- 
2.30.2
