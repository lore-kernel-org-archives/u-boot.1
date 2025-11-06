Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9617CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 23:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D86C83C4B;
	Fri,  7 Nov 2025 00:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uils3G4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD74383C62; Fri,  7 Nov 2025 00:28:41 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4956F83968
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 00:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-443ac891210so85461b6e.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 15:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762471718; x=1763076518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cY82pKeTQ2eerDpSCNFKcMQbRxK1fw3uIOFCP85vnEw=;
 b=Uils3G4ad0zUhFwa2K2IUvr7E8oCIGnQPUI+U4Oj4NDs4wPOyGtdxQ6EII1npS2LOk
 NjHtNEjPyFg2f0OlLPHYz9gr0WUbi+It/KNInPJvAjN+ZEeA/3kBkGE0WvD5QQrL45gq
 JCP9C3gB47XoWBsx52avSpeCp1OF5+H7CBYt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762471718; x=1763076518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY82pKeTQ2eerDpSCNFKcMQbRxK1fw3uIOFCP85vnEw=;
 b=oAjt7Nvh45eOPhOwfkpemiOisGeLFGV6eOPOoHsrtUOSmxZlNF8rvnMzYhsiKtP0sW
 wU6f3flfbzWgLmKaY0lVoBuqUul3L9MteDvV6mVOY/ev7te37cNua8nBJPt+d5rg9lZt
 YnwKxJ2nR5nwqudwwDCUnSrCvtSEKd9ykZhmtYZTE9SJmSlnwEINnslwk9pjWMoYEmBQ
 r/1xvGCOGiRG83tLJCQZb+IKllMk+aRRjFFpr/TPflCfQFS4Ymb3vpySfaYm0ttEUulC
 5FpqdoVvrIjoVOPfDR0wiDekdTmpuA80BLgEAt4Rdhos2Wun0RMA8fUtlykMqfYk9wWt
 Zf4g==
X-Gm-Message-State: AOJu0YwHSvWllQx6+CVIaLQVY5tgsu9aZaGnRec31vPvLMpiPG4f0cr0
 sV7CY7BUAo7fPMRzEEOdKe4CXYRkwrJpwqhG1J4WCkSlsKkNMgQPKkc63r2ceLlmO6rMqphMv9B
 xE3fcXlExmA==
X-Gm-Gg: ASbGncud6sojiHmGFeRfCOI5g2F5+A4XqM6mnRzN8V6gLptnioHQ2lVR6U4olrwcP86
 t07NEDf22QlTomG5+5F4/3fUrEcBsMIB106wE9y55mzj2LhdpK3+nmmG9y9/KofUKwnR1HrTPvN
 uw8aElNLgPlBAqN5wsdaxzEjiR6T9Watx4+jxX3rn7ls4Ihpbt/D7m4COZNnsGtRGjsFjO7e9pO
 0Bx9lawEhGHVqcXMBb8xPbBi/pObxTQfd5QCoIb7NneCoUGwOU4pDbYVIRIqE1c35rkA8zHzND/
 cWDRp1aiJSq3xAy2CGAziBm+XF0CLFWNPWNqC9cjDDsLWJrr/uVvadXoha7ZC/BQoIRa7lyqNia
 68uDABFswmuB+ez4ki2OhPJHnGgFPApAXH6RDWRBV17LBqs+8zwBoxyjYzr+4C4Vc5FWhrFPtx/
 kbTgu3uhtdJMNcgSZp6NQCslOZsA0RKs/yxsIS+urpAw==
X-Google-Smtp-Source: AGHT+IGwBmPjzkmngFTVwU1QSr6xJLaTY2/vxVwupBcmYcx3upMXRFdCij6kHEASyNnX3Ya1mvSGnw==
X-Received: by 2002:a05:6808:c148:b0:43f:5e4b:42ae with SMTP id
 5614622812f47-45015d6e868mr874526b6e.17.1762471718080; 
 Thu, 06 Nov 2025 15:28:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500257fbadsm1352562b6e.8.2025.11.06.15.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 15:28:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Correct override toolchain support for clang
Date: Thu,  6 Nov 2025 17:28:36 -0600
Message-ID: <20251106232836.3243591-1-trini@konsulko.com>
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

When initially adding support for building with clang with buildman,
there was some minimum logic in the Makefile to inform clang what the
expected target was, without CROSS_COMPILE being set. This has long been
deprecated / removed from the Linux kernel, and also not functional in
U-Boot. The normal expectation, especially so that an intentional
mix-and-match of GNU binutils and LLVM C compiler can be used relies on
CROSS_COMPILE also being set and passed. To have buildman do this we
only need to remove the logic that was not setting CROSS_COMPILE when
we had an override. Correct the comment about what override_toolchain
does as it is functional outside of sandbox too.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

 tools/buildman/toolchain.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 5e5bb4b0aedd..80468dfb4175 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -57,7 +57,7 @@ class Toolchain:
         arch: Architecture of toolchain as determined from the first
                 component of the filename. E.g. arm-linux-gcc becomes arm
         priority: Toolchain priority (0=highest, 20=lowest)
-        override_toolchain: Toolchain to use for sandbox, overriding the normal
+        override_toolchain: Toolchain to use for CC/HOSTC, overriding the normal
                 one
     """
     def __init__(self, fname, test, verbose=False, priority=PRIORITY_CALC,
@@ -208,10 +208,7 @@ class Toolchain:
 
         wrapper = self.GetWrapper()
 
-        if self.override_toolchain:
-            # We'll use MakeArgs() to provide this
-            pass
-        elif full_path and self.cross:
+        if full_path and self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
         elif self.cross:
-- 
2.43.0

