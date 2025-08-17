Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982BCA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 23:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD5E983252;
	Mon, 18 Aug 2025 01:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=she-devel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=she-devel.com header.i=@she-devel.com header.b="E4Ev6mP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DD783281; Mon, 18 Aug 2025 01:49:48 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6202831E4
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 01:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=she-devel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alison@she-devel.com
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id 73D022058CD3;
 Mon, 18 Aug 2025 01:49:45 +0200 (CEST)
Authentication-Results: ext-mx-out011.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=she-devel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=she-devel.com;
 h=content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from:received:received:received; s=dkim2;
 t=1755474584; x=1757288985; bh=8IF6ZZnrbKdnsqIKPsFnNY6moxo9HdHl
 eHD6DnHRWPM=; b=E4Ev6mP/naKe5IEsrvhek23IBk2wyrZ+4reAwqCW8XttO2tJ
 c8hZtgNmJD33NH0u+UbTUVvKmI1olnyyP7/xWL/rrBRi0ku7XsSlinfLB541suQQ
 58CpVOjZ/PrvhZ1cAooT8TeK08qoTqjLH9IV3GtboGnIVsPj7cdl7NwUfCcVLsSa
 M29Ls+B7CZUE45fSe7INQNYG1MmUl0i5ozlBSKSJFZUcuZwx1Au4os+dM1fjhS8Z
 bb6kM0zKob9E8d/4ukE6h4K+NYlkgfIJOcXcNvp/EolCc8yBF2k3orTX6+f5V4EH
 5tRuq9NAlKo4+x1uWBEClPINcHcqJbsdN9jCRQ==
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DBJ0ZxpJXMil; Mon, 18 Aug 2025 01:49:44 +0200 (CEST)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
 by mx.kolabnow.com (Postfix) with ESMTPS id B85B420660F6;
 Mon, 18 Aug 2025 01:49:44 +0200 (CEST)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
 by int-mx009.mykolab.com (Postfix) with ESMTPS id 4F74C20C19AD;
 Mon, 18 Aug 2025 01:49:44 +0200 (CEST)
From: alison@she-devel.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	alison@she-devel.com
Subject: [PATCH] sandbox: fix linker error for SDL build
Date: Sun, 17 Aug 2025 16:49:40 -0700
Message-ID: <20250817234940.3023378-1-alison@she-devel.com>
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

From: Alison Chaiken <alison@she-devel.com>

The patches fixes the following build failure:

$ make sandbox_defconfig

$ make nconfig

Turn on SANDBOX_SDL.

$ make u-boot

[ . . . ]

  LTO     u-boot
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
    `dm_test_video_bmp8':
/home/alison/gitsrc/u-boot/test/dm/video.c:415:(.text+0x16bb): undefined
    reference to `sandbox_sdl_set_bpp'
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
    `dm_test_video_bmp32':
/home/alison/gitsrc/u-boot/test/dm/video.c:507:(.text+0x189c): undefined
    reference to `sandbox_sdl_set_bpp'
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
    `dm_test_video_comp_bmp32':
/home/alison/gitsrc/u-boot/test/dm/video.c:543:(.text+0x1a7d): undefined
    reference to `sandbox_sdl_set_bpp'
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
    `dm_test_video_comp_bmp8':
/home/alison/gitsrc/u-boot/test/dm/video.c:563:(.text+0x1c5e): undefined
    reference to `sandbox_sdl_set_bpp'
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o: in function
    `dm_test_video_bmp16':
/home/alison/gitsrc/u-boot/test/dm/video.c:437:(.text+0x1e49): undefined
    reference to `sandbox_sdl_set_bpp'
/usr/bin/ld: /tmp/ccEZac9f.ltrans48.ltrans.o:
    /home/alison/gitsrc/u-boot/test/dm/video.c:461: more undefined
        references to `sandbox_sdl_set_bpp' follow
collect2: error: ld returned 1 exit status
make: *** [Makefile:2029: u-boot] Error 1

Signed-off-by: Alison Chaiken <alison@she-devel.com>
---
 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index d61a327f151..d8fedee55b1 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -55,6 +55,7 @@ config HOST_HAS_SDL
 config SANDBOX_SDL
 	bool "Enable SDL2 support in sandbox"
 	default HOST_HAS_SDL
+	select VIDEO_SANDBOX_SDL if VIDEO
 
 config SANDBOX_CRASH_RESET
 	bool "Reset on crash"
-- 
2.47.2

