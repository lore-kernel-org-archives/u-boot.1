Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00632FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 18:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECC2849D1;
	Tue,  5 May 2026 20:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRh8rfP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C909F849E4; Tue,  5 May 2026 20:13:17 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4F8849D1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 20:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso3444835fac.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778004793; x=1778609593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8bhKVqfd2hHyxBE7tSTuIPnxphdGTIEWrB8lUiWq9c=;
 b=FRh8rfP9WqIRshykFh1Z1hKJi+Avind5ellVFATDuEXldMbsszOKDfSCwgo/I4C+X6
 f3qsioBV1baHEebBDpB2ggIBi33w5ip0pm2/Q5ZT0ulNsPzzzxHmxd/85N49SjjEhZ1k
 pSu9O7SpR5Hck8YZZNtn6KzpwRPYp3nIo026k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004793; x=1778609593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R8bhKVqfd2hHyxBE7tSTuIPnxphdGTIEWrB8lUiWq9c=;
 b=UqGvWj4MUfya/MMEenBtllVpQP0YNAo8/8ep8HeNS2Z4TNmVqjikXciEnOZXgFiPM8
 MJfMr+8iT9B8JKjdCEQLohoZwJzIC+Ugz+BLgQAYpxPesBKbMO9XubqAiFZH9kp2DOzT
 aaqWbd8BWGBHWbTfKICcUnrOmDWgvcUBZbShLnaxB0/4b6GT5WIrlMzCCW/3Q2ltMYU9
 ipH2qKbbx+ZJ9v3Vb/KhzBe/FqOyBFI9c0OJ+m7alPMWqApBhhjxrzR+9CBeMKgB/BXC
 QU8QhfUBVRzQvXi/9/uM6xLZnDewVRM9dZAVM3eBNqI7JkzOKlAqiz0H8cXwzMg6JwZM
 7+6A==
X-Gm-Message-State: AOJu0YwXIEAgutWAo2cPURG3wLFN3MJ7wKZsC83RaNQHcSbSWkNrpIK7
 PhWRvnGSjolUlorMeH4ajUrnMh7U0TvImWjqG744/lBWu2zIYp27igR198wG9U2Pa1Gl8pV9ZkJ
 HAOpFwj/c
X-Gm-Gg: AeBDietlXlovb7Wno5pqAkHbPaEr5YurVh2+vspc297Vn53rfKTPlgMzDMl5ujDtSKT
 VrIjpilwtxzjGDDUxUhrr54o3uS2dRgxUZtjBsiXzsoqhTFVhWk92QWdcmMD2tQ1k8fwTCKbOeP
 kv0sQYtvWAq/mOSizpaFCJytDZPghHW+f9KKdQOge+/VXeMNzGl4m6iCKBkK0yKO5EogPjRIEUO
 Py/jFrpZ54JMf9QW6OihmTm3nZ6i76S2LoHGvi7NrwmJfYVyATlXll3hbROcRiFLOtKZYRUNlAQ
 plMv8hhSYxP36uBUv5/u7g6o3gOyfaj1TOyOZgrzBTIRqzzHkhX/sTZNf8W5Jx7EE9qJk5X/uWx
 bho/uUJ72kTh7fKs8kDxRbUYRj+f70SpHY/sNj7Djud25k71D2krSWvcJq3Vk3k5SByFdD/YUhw
 jvQaNo25mKK7ogwxq3vV9rxZ55V60s
X-Received: by 2002:a05:6871:e1:b0:428:ba6:c5da with SMTP id
 586e51a60fabf-434f65f3d81mr260571fac.24.1778004793526; 
 Tue, 05 May 2026 11:13:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm14585754fac.6.2026.05.05.11.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:13:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH v2 2/4] binman: Flesh out the pkcs11-tool bintool docstring
Date: Tue,  5 May 2026 12:12:53 -0600
Message-ID: <20260505181300.223439-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505181300.223439-1-sjg@chromium.org>
References: <20260505181300.223439-1-sjg@chromium.org>
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

The Sphinx-generated bintools.rst currently produces an empty section
for this bintool, since its class docstring is only a single line and
so the body under the heading is blank.

Extend the docstring with a short description of what pkcs11-tool does
and how binman uses it, so the generated documentation has useful
content.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword the docstring per Quentin's review: binman uses this bintool
  only as an availability check, not for runtime PKCS#11 operations

 tools/binman/btool/pkcs11_tool.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
index 673c0ea0ac3..ca80943f98c 100644
--- a/tools/binman/btool/pkcs11_tool.py
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -7,7 +7,16 @@ from binman import bintool
 
 
 class Bintoolpkcs11_tool(bintool.Bintool):
-    """pkcs11-tool -- support tool for managing pkcs#11 tokens"""
+    """pkcs11-tool -- support tool for managing pkcs#11 tokens
+
+    This bintool wraps the `pkcs11-tool` command from the OpenSC project for
+    managing objects stored in PKCS#11 tokens. Binman uses this wrapper only
+    to check that pkcs11-tool is installed (and to fetch it if missing); any
+    actual key or token management for signing FIT images or capsules is done
+    outside binman.
+
+    See https://github.com/OpenSC/OpenSC/wiki for more details.
+    """
     def __init__(self, name):
         super().__init__('pkcs11-tool',
                          'PKCS #11 tokens managing tool',
-- 
2.43.0

