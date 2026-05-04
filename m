Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E09CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 07:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D7F84255;
	Mon,  4 May 2026 09:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="JO4Gr7d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2728B8432A; Mon,  4 May 2026 09:11:24 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043DC83EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 09:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026050407112088b69a3dae0002070e for <u-boot@lists.denx.de>;
 Mon, 04 May 2026 09:11:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LThfucZeKYpC6YnkyVKLCVOU0TXulTxDPwfmAtb+AoE=;
 b=JO4Gr7d58v5b5HqPPaqMt+8gF9HuerOmoS7lc2Ea8ASxjP5t/X6cbPQtt+vabC4PjTysse
 zK/kXeO0/yIkVFnp2D8OabxcvJcaUU2hIW+tVKYtqxpEW/TSDlweKDvyxf/zOSNGbvg4vVeQ
 6rLDjMXE6ULBk+T6MJVV5fqQ1yb93pT4iY/KIBGdAYGfmVz54RLntBkq66Pk3jYWG+0+Tuyq
 Tu0yzf/jPn/PPBD2kcUFGF2ds8DRm0mkO21baL6SAuydW7DE+vN+LHzERswwNf0bJgTxnrW6
 VyDobjfYgr+z/52XCFgYoRLz+39A2v99Dz0F910FuPj7nYKqTn9kkR7Q==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] virtio: fix boot device hunting in qemu with virtio
Date: Mon,  4 May 2026 09:10:23 +0200
Message-ID: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
failures") returns -ENODEV where it would return 0 before. That path is
apparently hit in qemu and breaks boot device discovery
(virtio_bootdev_hunt() expects only ENOENT). So return -ENOENT in
that path instead.
The remaining two error returns in the function are untouched as I
don't know where they play a role.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v2:
 - return ENOENT in probe()

 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 62afe609ec0..d90d8309f99 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -372,7 +372,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		return -ENOENT;
 	}
 	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
 
-- 
2.43.0

base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
branch: us-virtio2
