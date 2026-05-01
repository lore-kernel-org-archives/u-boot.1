Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B70DCD3423
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 15:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DD8803C6;
	Fri,  1 May 2026 17:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lsKmx1qL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2B680F0E; Fri,  1 May 2026 17:05:58 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3CF80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 17:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 494253F043; 
 Fri,  1 May 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777647955;
 bh=k1/2UwV7je0oy3tY5VHVZFHU9ASS2ild4YFsSfxWQbw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lsKmx1qLcb3dbrdPABwN5NWzQbqhLnBlZeKWoP9RrBPDQvjGLMebIpXglDy3Eq4ii
 lkFKwzCu2U2NooGEBs/QPq23SMIZb1qNn1VaFMe7ZGG40h/ei854vuF/z4FaPlVDVD
 cbimfFbsr40bfcRQF9YUhnvJzRsbPUyv2udKUOq2sroPrRM9lPYOGwcqO2dbmn5q6W
 TPxc4WHQ9Lxl78CXWkPvmPBc4dUB9WXrfHplG3X+jE84gAMXkjQLcid21+T/o9+/yq
 ZbWhMLfVfXXPwFvrR7Mp0Rkri+MUgvDodDM2z0kW6j7frNTW/Nu9kj8PIPIjY7LSwk
 wp7Yp/vrrFJcNmA8c03MWesHDQiGCySmXVrXdbnkpDfFf0zCRtClfX1PK2jH056WMq
 /B/PPUXS/4p6sIDtkpQLM0yB959ouwIDES0sOvEd/coBu/p9JRl9hHRyE0pj7xp+Uz
 w21xNmZwEwHKq41wsWE2vxDL35m93UjkO9/IQKV552DKWKqwLLUcJLOm97IzJOQz9D
 MjsHe+/2NXjhMSjInSjQi2DWOuLfsL75BQ2oLeKAy9MF16yVXD/GjMZIS6lc3CdTMG
 nLa7M4q2r3J9JG2NTqbZ0snUJONJdQF7s4aip049wJrFQk4zJkwUJg8SJXCpD4wXl/
 BEUHKwMYnN7wHWOpj1M9IiMQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: set correct frame buffer address
Date: Fri,  1 May 2026 17:05:50 +0200
Message-ID: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
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

If we use video copy, bit image transfers need to write to the in memory
copy of the physical frame buffer. Damage control will sync the changes
to the physical frame buffer.

Cyclic video copy will catch all changes done by EFI applications directly
accessing the frame buffer copy.

gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
sandbox address.

With this change the block image transfer test works again on the sandbox.

    setenv efi_selftest block image transfer
    bootefi selftest

Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_gop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 9403e09691e..ae44d140289 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
 {
 	struct efi_gop_obj *gopobj;
 	u32 bpix, format, col, row;
-	u64 fb_base, fb_size;
+	u64 fb_size;
 	efi_status_t ret;
 	struct udevice *vdev;
 	struct video_priv *priv;
@@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
 	row = video_get_ysize(vdev);
 
 	plat = dev_get_uclass_plat(vdev);
-	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
 	fb_size = plat->size;
 
 	switch (bpix) {
@@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
 	gopobj->mode.info = &gopobj->info;
 	gopobj->mode.info_size = sizeof(gopobj->info);
 
-	gopobj->mode.fb_base = fb_base;
+	gopobj->mode.fb_base = (uintptr_t)priv->fb;
 	gopobj->mode.fb_size = fb_size;
 
 	gopobj->info.version = 0;
@@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
 	}
 	gopobj->info.pixels_per_scanline = col;
 	gopobj->bpix = bpix;
-	gopobj->fb = map_sysmem(fb_base, fb_size);
+	gopobj->fb = priv->fb;
 	gopobj->vdev = vdev;
 
 	return EFI_SUCCESS;
-- 
2.53.0

