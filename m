Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148EBCAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 16:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5CF83D71;
	Mon,  6 Oct 2025 18:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HuIE9pZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8431483D85; Mon,  6 Oct 2025 18:45:17 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828B083D52
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 18:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BF59EC085D0;
 Mon,  6 Oct 2025 16:44:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D9739606B7;
 Mon,  6 Oct 2025 16:45:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDFA9102F1A18; 
 Mon,  6 Oct 2025 18:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759769113; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=0LiAOa7TMGq2/L6jdJQAAq2foaPmsgjIOOCkRjrA8Xs=;
 b=HuIE9pZGkSTHYR50da2beY0ul4VSpMf9wPsFZDHCADx4cOBhfHpYxItOmAnG10lXnoawrz
 c2FWuZdZw9kOZfauk4N676Wf4c//cMQahhjvYbT1eebCuvBQAXK28o3Ul9aQdzci15iOF2
 QqyDxkZWH0oPor3QUfvwpCc79U3NNT4ab9TJ8HXA9DDHRSwifdCKWIs/e9pOMAVnfOdqCp
 R01Phy+ywUEHWk+pl9TMILd/9eoT9JsG8516rQvIG+7Yg+FaCTyoZMyN9rz4cOPlbWaW0v
 KDv2N8eGlKhP3LmDyoLtiwsYb57FcLbQJaXeJk+aeMSlMqU36NSBCSnZa/XoJw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: Do not build expo and cedit test if no SDL
Date: Mon,  6 Oct 2025 18:45:04 +0200
Message-ID: <20251006164506.380308-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

expo and cedit tests depend on the host having the SDL library.
Build these tests only if VIDEO_SANDBOX_SDL config is enabled.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 test/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 00223b44fe0..89538d4f0a6 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -6,9 +6,11 @@ ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
 obj-$(CONFIG_FIT) += image.o
 
+ifdef CONFIG_VIDEO_SANDBOX_SDL
 obj-$(CONFIG_EXPO) += expo.o
 obj-$(CONFIG_CEDIT) += cedit.o
 endif
+endif
 
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
-- 
2.43.0

