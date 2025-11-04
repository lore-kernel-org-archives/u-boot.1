Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EADDCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C12C83936;
	Tue,  4 Nov 2025 23:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e1pZc5I2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DC98394E; Tue,  4 Nov 2025 23:01:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022F78391C
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 292D93F189; 
 Tue,  4 Nov 2025 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762293660;
 bh=04AXctSsvA00TX+hsz79sjR8XwiJiOjlPZfOi+rJeyI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=e1pZc5I2o5Q1uY8ifIwmbCn35Hso8JQa+eDdDBMuUorAZlzcUtKh1Mkko256tC1pp
 oCmssTg3pH6HGJELVbWyPNv6WEgil0cjjCsiUjol5AMb6mNzsutwl7/Kcq0Px2NTPM
 gwVna2SxipWfQZwGed8Y8WefrysOn+HSF2lPiPxaTVvvTuQPLODaR48Ein4z8H1Kvv
 hYL8OMYPdv0noapMbkXD8mPK79sxduSDtVo0NPySbofE2+U4ZGwOxFDrwph4QXfKif
 mYetixLGeez13LO1MLlMY+H+wjtr7p/00fS5APChLlm+e8UL4+BgcaagWps2UtfeZQ
 /hJIvFDboxEHYszk7DKAKH4wZ+jOzt7OXtvV9Z7RsYgY1u3QcfpIDNM71+Hb/hRjBJ
 O7AhVP+6AWrdmjNJ7FVWrTKOXhOtb9D1EQlli6CGNc+rVU8mQ4INC6DLjyGkE81hnJ
 pO0zXbe0GS806zWEM9jLXNWeVeNoP5aCseCnhCOPRjHFq4AF3wWQtJpwi8qNBPbtKf
 A0vpa/BrdZZsDpWZPwr465/YtYagfieJ9vjuE87w7FWmzYhttNuZz1ZSI4P9QtdDj9
 wurBbjy3HR4M0DEOyDtbVubq6sLKhB/Qn+O2JB/Wd4HVW8/KD7i65CfkHihQLEFYMB
 IujLamMJXWwIEXOEFwwPxSJM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_client: don't include asm/global_data.h twice
Date: Tue,  4 Nov 2025 23:00:55 +0100
Message-ID: <20251104220055.26609-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Remove duplicate #include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_client/efi_app.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_client/efi_app.c b/lib/efi_client/efi_app.c
index 9b94a93ee4f..da8e3432859 100644
--- a/lib/efi_client/efi_app.c
+++ b/lib/efi_client/efi_app.c
@@ -21,7 +21,6 @@
 #include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/root.h>
-- 
2.51.0

