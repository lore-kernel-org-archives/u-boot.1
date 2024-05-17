Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266EC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6C1881A9;
	Fri, 17 May 2024 17:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YTTXL++D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9623E881C5; Fri, 17 May 2024 17:15:47 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FACA80EED
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (18.pool62-36-37.static.orange.es [62.36.37.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4DF673F1B7; 
 Fri, 17 May 2024 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715958942;
 bh=AN9d9IZ698qTCKVcRodDHPfhmgeex3Xn4PyGQ8x4m1M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YTTXL++DQ4LD9yESXcogpCydIHiGCGjkmPhmTr+CS9k7D7hR6WFmXPTnLm7oqeuZr
 FYBPU7GpWkql5mFTPrxFW9LCnJeGFWcH6nNFVShXNkHxeeSa+vHgn4wI5USm6FW6E3
 WKmXHPHb3UHwBJ9jnvEn4YEyx02IuAe9yjFuoqJQmZqwTFfIFrBD6yrkMTmzesiDil
 eRwQ2Y2GVcYVOBx5NFy+5uVaDl0WV1GFpE6dvFsKElLvcsmyRz50xleSvYVNAB5frv
 K4HgABAHKRB++cd8ZinGgviH1HsBvTNSEBa/1AG4V4j3SMtMCMPUX5nZVwCAM3sYMq
 rEsgYQpZel8mg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Makefile: add build-sandbox*/ to mrproper target
Date: Fri, 17 May 2024 17:15:34 +0200
Message-ID: <20240517151534.65242-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

make mrproper should remove all build artefacts.

Running make tests without deleting build-sandbox led to an error

    *** No rule to make target '../include/common.h',
    needed by 'include/config/auto.conf'.

on my machine.

Let's add the build-sandbox*/ directories to the mrproper target.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 44deb339af1..179cce9c0a1 100644
--- a/Makefile
+++ b/Makefile
@@ -2204,7 +2204,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       Test* capsule.*.efi-capsule capsule*.map
 
 # Directories & files removed with 'make mrproper'
-MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
+MRPROPER_DIRS  += build-sandbox* include/config include/generated spl tpl vpl \
 		  .tmp_objdiff doc/output include/asm
 
 # Remove include/asm symlink created by U-Boot before v2014.01
-- 
2.43.0

