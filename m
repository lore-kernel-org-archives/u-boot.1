Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BEACD3423
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 15:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27519803C6;
	Fri,  1 May 2026 17:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hGzYgfoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F6981E18; Fri,  1 May 2026 17:16:22 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC2980086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 17:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 407C640076; 
 Fri,  1 May 2026 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777648579;
 bh=XVw6gFQAueT53zRPB+h7ls7RXXfmXmdhJv/Ati8907g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hGzYgfoooZYWOuN5Cb5GW53sgFchvVx46Si8m3L3ZRe7rfPV5Csr5Df6jWaCPuy89
 70Rp+hFQcGu7n/c0sfTET+6P9uVwq7of4jmGdrNSlH92FdZVsjScd7aZ2AjWQWT2Wi
 9VfRk80WbERDvp0m4p3ouCgUc54e3B9vgGQqf9alWcTipHonJ2viI/j1aEyvLaDkwW
 InWxKdQPaW6y8G1W+EzIGjBdeVRUp5D5T3CcZA2Kt32KCumnqZxlTuUFP8VvyzxpO6
 w7+ObVpFZCAPPqq1TkWMeTeHNKEyyb/+dWuoz2Dtu3/lgst6lyfv/l+9oY4riAMFYD
 kK1isr2IxdLA1+upgnbcgjKvUCkLe1PIL7VRIoPlVhb19b3yOTyvgFc13RXtk2iLGJ
 maNAp6X9qvtD4q+oyhOcs2KHe0HUX0ULup8KOT4mlQFSitXdvjZWutQ65QnwbHkpjm
 kCFyt2Kx1YWMwtuGkQxxb0qubsXD29PxcDN6+oqVHeJ7F+MP/PAtU0eXm1HbbbzljR
 7YKgchZZp99IiXyfB5qh7f6HuC0vFCYLPR8ZhReU/xoZf4RrlyYBrzFOYYIepfBj6j
 VvLlXRpsv94dC14c4acTKqDmpHIz9bDCJBsiBZYj14pobAaQz7cTFrVu4UAi3wKeOg
 NuBvgOodk7eJFcWv2aizFcrA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] video: show 'physical' frame buffer on sandbox
Date: Fri,  1 May 2026 17:16:12 +0200
Message-ID: <20260501151612.229417-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

We allow using double buffering for video. This can be accomplished by
cyclic copies or we may copy 'damaged' areas.

To inspect the output we must inspect the target frame buffer that models
the physical frame buffer on the sandbox.

If double buffering is active, priv->copy_fb is a pointer to the target
frame buffer.

Fixes: 5c8dddadf1c9 ("video: Use cyclic to handle video sync")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/video/video-uclass.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 228d6bacc58..c178027fec4 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -516,8 +516,7 @@ int video_sync(struct udevice *vid, bool force)
 		video_flush_dcache(vid, true);
 
 #if defined(CONFIG_VIDEO_SANDBOX_SDL)
-	/* to see the copy framebuffer, use priv->copy_fb */
-	sandbox_sdl_sync(priv->fb);
+	sandbox_sdl_sync(priv->copy_fb ? priv->copy_fb : priv->fb);
 #endif
 	priv->last_sync = get_timer(0);
 
-- 
2.53.0

