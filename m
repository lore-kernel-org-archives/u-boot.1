Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E909CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327CA83189;
	Tue, 26 Aug 2025 00:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i5Z/hhvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE688311B; Tue, 26 Aug 2025 00:46:19 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD40F80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3c8b0f1b699so1425655f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161977; x=1756766777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ie7B7uFxaX6pDZH9e3E22OnEgT4hw6Wd5b0WH5JitO0=;
 b=i5Z/hhvImc91kq47zGPKxrk1iA4yFIrYWsVU8XAQTFB6gfR92o25X176T+3UuAKaaP
 nRMCc2CWEyXtysI67go2REHAJmZspLmxqYamQcLn6fS2KJ7Gqo7X1bCwLK9TUD3Vib55
 wXCAZnNklEiZ7Y44TYOVuyiBfjb9f/vmuHgbusMihXQCAHso7J35r21TpnpGz6tK/Nf2
 g3RjziGDehqeQbqRYv8uHUvtI3By8mTKu7Z8dOHydOhOoOatlWWA1GdUyDmaaTVi3PaH
 IPUjTObw8raPhANutqp8J4g02dzb8HN2I+CPWivfwl1/yTkqmoW1O+cfoK9Cw9BSHZ8N
 vM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161977; x=1756766777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ie7B7uFxaX6pDZH9e3E22OnEgT4hw6Wd5b0WH5JitO0=;
 b=t+Zb/zosVG9wV5VmFvu+6wXfWc3ZWNA3+zoxSJPMI0DKdnUg9xxqMYzZBTQOG6OHCQ
 kww3RGSAyOCM12xznnWZhaThWuzMYBi/NYg/cteLYCeH1pFhTrscHnlcW2mLeuzJgfEj
 elgMSPTzEkB4J8+yjokRhrkqsQLRBKX8dFBdoXYYoG2hCGZqpptsiVtCHKKCwB0RRe+q
 XrNh6X9hvKCqkcpJYdjgC8pny0hCaEGAkvSqu8kXXNbJAnRtP1FwwAJzQHGtdYtyotFM
 WvsZBHp8oFBjW0PcCHZkDxbRlPk0NWwFoup8+JQ73sKttOlG/u+Q2Z5tkMn2H30K1VbS
 c/Xw==
X-Gm-Message-State: AOJu0YwHA8GvIxWuytzyYwzIrY8mqCYz5usNaCBsE4k3cfBAj8laMkXm
 cxPbOT9cu/LhmhLWIgCjFasw3xAQc4EUNIWYzNuqU9BHzRmoFBc7/HbMKHaLZ4drSYw=
X-Gm-Gg: ASbGncuww1JhROjB5lC1zC9sVWnzdAS0a1ju7rwgu8lzhlVz6+I2TyDjQAHQaTx/kdy
 xiOekkJN8JXoYwu3gygd7oBA4cuzhUBw7nEW31Wkvsq3c3B9OPjRalVC4IHVHpLQ1Io9NgP5WIh
 ApH42tPEXo631yNlTYvK2GgFK4CFxUIXZ90lZJ3amrwpZH/+5q/m/J6DOLHsAE6dgr622SjI/lL
 c2Ig+TtnIt24L7hzMu5RIhfvrTyrYPRYHxo3HhFNCXpuxA4QejuyAfUYZC3kyaOH6jbarXxJhbs
 TLtXx3g/C2c+C5EIpEWGhKTitT0GO+K1IDOpap2aWVnen6BcNWgpTCV16QDaAp/xZ41oz3ofeSN
 5ugQYoxllkUTFayfZDOieMMIlSMHk
X-Google-Smtp-Source: AGHT+IF31JOh+9fz/dzZpIjPRbouMg4K7DLBypU+vsol9p+rtkeAui8ufbiZ+0JCFpGE1mhXljjo1w==
X-Received: by 2002:a5d:5f51:0:b0:3ca:4e3:6e7f with SMTP id
 ffacd0b85a97d-3ca04e376dbmr3227843f8f.31.1756161977031; 
 Mon, 25 Aug 2025 15:46:17 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:16 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to PDF
 before the compilation of *.tex files
Date: Mon, 25 Aug 2025 23:44:47 +0100
Message-ID: <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
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

SVG files are not handled directly in the *.tex files.
This commit adds sphinxcontrib.inkscapeconverter (from the sphinxcontrib-svg2pdfconverter package) to sphinx's extensions in conf.py to ensure SVG files are converted to PDF before the compilation of *.tex files.
The needed steps are also updated and inkscape is specified as a dependency.

If I don't add sphinxcontrib.inkscapeconverter to sphinx's extensions, this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
[...]
xelatex  'android.tex'
[...]
Output written on android.pdf (28 pages).
[...]
xelatex  'api.tex'
[...]
Output written on api.pdf (431 pages).
[...]
xelatex  'arch.tex'
[...]
Output written on arch.pdf (62 pages).
[...]
xelatex  'board.tex'
[...]

[152]
Chapter 14.

! LaTeX Error: Cannot determine size of graphic in boot_diagram_am62.svg (no Bo
undingBox).

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.11422 ...ncludegraphics{{boot_diagram_am62}.svg}

? Output written on board.pdf (156 pages).
Transcript written on board.log.
make[2]: *** [Makefile:29: board.pdf] Error 1
make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
make: *** [Makefile:2686: pdfdocs] Error 2

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 3 +++
 doc/conf.py                 | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 69e0dc418b1..1e97085fc89 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -18,6 +18,8 @@ the following dependencies are needed to build the documentation:
 
 * texlive-xetex (if building the `PDF documentation`_ through the *pdfdocs* target)
 
+* inkscape (if building the `PDF documentation`_ through the *pdfdocs* target)
+
 HTML documentation
 ------------------
 
@@ -32,6 +34,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
     . myenv/bin/activate
     # Install build requirements
     python3 -m pip install -r doc/sphinx/requirements.txt
+    python3 -m pip install sphinxcontrib-svg2pdfconverter
     python3 -m pip install pytest
     # Build the documentation
     make htmldocs
diff --git a/doc/conf.py b/doc/conf.py
index 84d028feda8..43472d5dc3d 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -48,7 +48,9 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
               'kernel_abi', 'kernel_feat', 'sphinx-prompt',
-              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
+              'sphinx_reredirects', 'sphinx.ext.autodoc',
+              'sphinx_reredirects', 'sphinx.ext.autodoc',
+              'sphinxcontrib.inkscapeconverter' ]
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
-- 
2.48.1

