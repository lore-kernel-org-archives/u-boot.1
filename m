Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2840FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 18:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82DC849D2;
	Tue,  5 May 2026 20:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+OCNaDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3455849D2; Tue,  5 May 2026 20:13:15 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54118849B2
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 20:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so5363197a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778004791; x=1778609591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym9HUpKzPOqn4X6sWTWvqzozbNU9Zl944RE/uQTNg50=;
 b=Z+OCNaDbtBL8+2JN9QfpOjdWLbNkGrhLCXcgLrIbpNYBL5oiSjzAmWFG2WH8LvgsWp
 8gShPpHYNzu3qMxN/azBI0ogH3Z8Oi4Q34DlP3M7yCCw2nBT8v5WMvhv5O7Iu+7HMZNa
 bwwL10NkFk0DZTHLERY56H3rLfFtbd/pP/oIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004791; x=1778609591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ym9HUpKzPOqn4X6sWTWvqzozbNU9Zl944RE/uQTNg50=;
 b=kLUtolDN3rWT7+fFf0bnvFl6Hs9uXXPAr9HILKVFoqg83sfyoqpNmYfe1JLmD1weOY
 T9zPFebQ6DcPLtttH3TE9ltxr3JsEffSMWz5cGmUNEyUiYn7NKCrIYJ5vP+KfNjyO7zO
 jUMonWFfGehA10OjtYj0lZAHx2JKxixWQuI5CjEZurzaxiqkQDQ01KOSCdE5gaBjmb09
 mBgV/wroMxSjuDgBGhkQ0PbX8upsVbjyxo1kTpDbevJ7JAHuSwVaOlwc3aPzY3cxY52P
 7oDQRIIPNqzo0NHcK10wtucw4yFWPZc9bW5sU+XeieqqbhOK/kkf3DbODXeeYtXBrYdf
 2xRw==
X-Gm-Message-State: AOJu0YyrsHK/uOU4dMpFsEwgQOiOO/26dEIlHKJ5nDuyGsyd1kvpmPS3
 SGOFMm7z75RcsmD7qdBeGsiK/KWshUJBwbAIb6A+9c8u3GR+p4/YeZmoZFVcfeDhuSDVl7MBgpk
 XQ3f5DrSg
X-Gm-Gg: AeBDiev4NvA0dIcXE8hMXur1JodKVv5pAr8OYsM81WrpWqDhG7/gm92IWWLaO9sAk1s
 FiFuqGSNWATHRzNBohQ3NL+EILzRlNIbSTk+GdpOVnM2CYw8m47pC1TiedcCPsNiW0KRJvOCZmE
 zZMb+duCsAzlr7DC6XYc6ojtgjR+HRAr0HsuOT/r40FsfcAe8klzKZ1oMIQtSZ3VRhQB2mfWZA+
 AWSP1HllNuUyalhliNGNTIRwNU5oPluAvew8CdGptMI0IoD1ZAKbMz2OHb9gGBGsdB3fQQtfDCP
 QCm+3zURwl2xUbiSxkvJa+ghtcXwYq9yyh1Vaqd1zX9nw8YVsWv8wpWJ22cd7zqUO4q+JV7sXP1
 mHreOiJqJXKJ+rJ7qidlMHqRqVREMt6VTkJGw7096LMLbEI+PHRVWdUXjHooiGLBOPZ8Eaq3EEy
 smH4bAceksA1ix8gwVHHqFRCyrQG4x
X-Received: by 2002:a05:6820:178a:b0:687:d4de:1f9d with SMTP id
 006d021491bc7-69998105a77mr416314eaf.24.1778004791416; 
 Tue, 05 May 2026 11:13:11 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm14585754fac.6.2026.05.05.11.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:13:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH v2 1/4] binman: Flesh out the p11-kit bintool docstring
Date: Tue,  5 May 2026 12:12:52 -0600
Message-ID: <20260505181300.223439-2-sjg@chromium.org>
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

Extend the docstring with a short description of what p11-kit does and
how binman uses it, so the generated documentation has useful content.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword the docstring per Quentin's review: binman uses this bintool
  only as an availability check, not for runtime PKCS#11 operations

 tools/binman/btool/p11_kit.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/p11_kit.py b/tools/binman/btool/p11_kit.py
index 9d8d5d848b4..1bbece5bb2b 100644
--- a/tools/binman/btool/p11_kit.py
+++ b/tools/binman/btool/p11_kit.py
@@ -7,7 +7,16 @@ from binman import bintool
 
 
 class Bintoolp11_kit(bintool.Bintool):
-    """p11-kit -- support tool for pkcs#11 libraries"""
+    """p11-kit -- support tool for pkcs#11 libraries
+
+    This bintool wraps the `p11-kit` command, a support tool for PKCS#11
+    modules. Binman uses this wrapper only to check that p11-kit is installed
+    (and to fetch it if missing); any actual PKCS#11 module discovery for
+    signing FIT images or capsules is done outside binman, by mkimage and the
+    OpenSSL PKCS#11 engine.
+
+    See https://p11-glue.github.io/p11-glue/p11-kit.html for more details.
+    """
     def __init__(self, name):
         super().__init__('p11-kit',
                          'Pkcs11 library modules tool',
-- 
2.43.0

