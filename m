Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582F5CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19D0831BB;
	Tue, 26 Aug 2025 00:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNgAEKKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B23831B4; Tue, 26 Aug 2025 00:46:23 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E7C828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3c98b309804so1242939f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161981; x=1756766781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=342mSs5rRvHrnlOqA/DiZjoWIF40U8xpFJ9hdmW/dj4=;
 b=bNgAEKKRwt9ohxFdoc+/J1P5cpMDoIcP2230Pn4k6Kpw5qg5kq8YVylRYYOAv39gWL
 wUImlTXw7CTFhbt2FjKz9jC/ZC9yJfpdpYWo881IEJ9iSROSbGdgxxgcfY6caS0kvetF
 mcPm6mJ34CJyaL+XhivQs72fQzp3TLraI7YwtJyBkwxzqYAQ1w2//Bz6N3PebJu2dkPj
 5LptHRjbXDSRdFjc5bsH2oWuwkHe0pfk3dCyu3Epu5qxqadsEmUqkleaSnOykLM+rHsa
 FyNk/CUFaX5VO1Dhxrtsp/TLlLIWP9KtuGqxZl48/PUX5bqZ7PpK+/CyEuNV9+G3SClZ
 nFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161981; x=1756766781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=342mSs5rRvHrnlOqA/DiZjoWIF40U8xpFJ9hdmW/dj4=;
 b=lS2R6NfH6FYKcka20ZBNUcj6CoINLCe86j1VEc+JnAf5uqMp64Oqj95k92flU2hpg6
 r0QUyF/6kQMDPDXOblwLQ3XQt9zHE5Biag1ssAaDI/ZeWc6uY0FK4IC4FtRrfKyeOeNi
 L6FMZDmVb8Q/pKGw/EwJZJu3vmbtlKe66NlWJ8r0AVMppqt2gavfVr8eGA1x3NP1r3PX
 yBGlVQvdGa299mabdnY2kviwb9uQ+4Fh00x/UjiC9DSMMjpUEOYIF2hgHITuW8Zvdypp
 utOs5Wh4jBuzCbA0bKAGV0XaLoMh9ZR8P/wpBE9Wizu408LER/TbHm7T3HEJFFQK9Y7/
 dJZw==
X-Gm-Message-State: AOJu0Yy7KUGZ/+mKp3klcX4PjxEL7v5LOSvfMXluJ0ft6c2FLEd4GVa6
 W3+Jj7d9+q8X1b+ao8lru9LZNKwgGFbm5Bntg7Hp9/UKcfjDJvirt+H1BS7Wh1jecSA=
X-Gm-Gg: ASbGncsMOdIUEMZzY61fwA+xw4/TByhHlESeF5l8qCuW2dScqeYR1KUqb0uA/cMu1Po
 x0w0hab4Er3qS/z0h8P6n50SoN6fu+qG385LHx43EdgcDoJkB87FRH6FsNqfRThRMxCH/9ZyHxB
 DqgSSno2zXl+b+uN4zCvwgx85Vvq8igNOKIyq5gWUeL/npg9y5uA46xM4cSFychJAVa23ZRFUDH
 63hYEGJp1iRtOk6BXLjkCN6c2NhgDQW+GgRhrfzqyya/bkC2ur28JIds3f9WGmsscjDyBus7SKF
 WezOT+rPVOc7XIJKJJFy7MsjRGaHmgpRYmDcAU6K1okbCEnLGbMMl+904VRdKxmKE8aLkLxgNQV
 9zvSf0jGWJqMP9ezinjwFh1bPgxE6
X-Google-Smtp-Source: AGHT+IGcPA+HClwwFsPxUu6AZK0Gk51mwFqUc6oWKpg5+kCa2fSogL5OEojpNj6UTebDQJeUrpg9bw==
X-Received: by 2002:a5d:64ce:0:b0:3bb:2fb3:9dc3 with SMTP id
 ffacd0b85a97d-3c5da54e679mr11048316f8f.5.1756161980586; 
 Mon, 25 Aug 2025 15:46:20 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:20 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 6/7] doc: make pdfdocs: Increase the maximum list depth
Date: Mon, 25 Aug 2025 23:44:49 +0100
Message-ID: <20250825224459.682403-7-adrianocarvalho.pt@gmail.com>
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

According to sphinx-build's documentation, by default the maximum list depth (latex_elements.maxlistdepth in conf.py) is six, which is not enough for U-Boot's documentation, leading to errors. See below.
This commit sets maxlistdepth to ten, solving the problem.

If maxlistdepth is not set to ten, this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

(myenv) uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
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

[340]

! LaTeX Error: Too deeply nested.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.25503 \begin{itemize}

? Output written on board.pdf (344 pages).
Transcript written on board.log.
make[2]: *** [Makefile:29: board.pdf] Error 1
make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
make: *** [Makefile:2686: pdfdocs] Error 2

This solves the problem with the pdfdocs target (in docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025 at least).
The docs have been updated as well, assuming the issues with the pdfdocs target are fixed.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 4 +---
 doc/conf.py                 | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 1e97085fc89..bb13b8589b3 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -84,9 +84,7 @@ The *pdfdocs* target is meant to be used to build PDF documentation:
     # Deactivate the Python environment
     deactivate
 
-However, as of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
-
-We can use texi2pdf instead:
+The *texinfodocs* target, together with *texi2pdf*, can also be used to build PDF documentation:
 
 .. code-block:: bash
 
diff --git a/doc/conf.py b/doc/conf.py
index 43472d5dc3d..7b1a1a2a6a1 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -378,6 +378,8 @@ latex_elements = {
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
      ''',
+
+     'maxlistdepth': 10, # Default is 6.
 }
 
 # At least one book (translations) may have Asian characters
-- 
2.48.1

