Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F7ECCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82EBD83653;
	Mon,  6 Oct 2025 00:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqMHY6su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73E280FA1; Mon,  6 Oct 2025 00:13:06 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C75783642
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so38374105e9.0
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702383; x=1760307183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p+CXfLXiCqJD0Co4ZJCYr4jGPt6IFSZyB/qiixqLBPU=;
 b=eqMHY6suoOn57xMH828PbOmnk/ThxRsvdJBFGZcUFbAT7v7McU8GW3Tyyj3Kdb9aJE
 a5rDA42f0y97nkOa+FxIAvWVR45gkoY04MHRLOy8LfuU0xem9fLTNvWysSDcFhoo8G0R
 0WeVPN/0slgETwOEYSlAWcKyACgpaelnGANIXqKJB6wToMi/n6JXEzzu9RP1x/TEdqta
 SS3WsJG5lJ8RYtzsBXmWyUlbQDjb0681KIJA4vaiKpK5B/6VrriBL6VBFgPsoGqg3EXi
 TIYn121dpvZxnYZr6L8n2GaSchVBQD3AIFBibbNJPHWv4Y0yfkGKmtPia685ARuPQoGL
 B1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702383; x=1760307183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+CXfLXiCqJD0Co4ZJCYr4jGPt6IFSZyB/qiixqLBPU=;
 b=OJmaAm/q6MgxWNuA1hHwmX3l7aV3BuJ7C4tmPaAQhR+hC843Li/jyvP5JWSlmyTAVB
 EdUF5ELHcvkOs30AC4vOnTWC/2IhQxVI+RiQiEZMlbzOC/0LEeBEZnO5Qsuq3jiVihr/
 nmka7fOx/Ee+5E+sxE5ZX5KKVa4V4ahree2YIYArRTATO3L8YJ+/CSTxUxkwfxu1Dkmu
 D+dBR8r+P0cHRTZTLV8w7aIq69gnL4hrPJ8YpiTmwyNTaqCTCPwWKGXWCcZxm/1hqEei
 Zs16tDpaiMjF+WM3hUwIZ1m1n5EArxmu0EXwhr5gBZEEQEAyS3V/x/JGbHV7ZpJwh6AJ
 bT0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ToI3AmhvkOsMtmI4LXf+HgWB0gt/Q2p0Tw3NYSa5V29wCM1e7Cs5fpbH6xfzm058pdKMYK0=@lists.denx.de
X-Gm-Message-State: AOJu0YwIw8o2OVeYcUKcEdCaWPY8/Y+KgsEgWTBNkb+y59yJVLyF65r0
 eGuF0qsU7gKkdeqNLzjJENf9h6C3AyRUZ7yGJKLrA69yK+I/4gVePVYV
X-Gm-Gg: ASbGncuwosUra0H4fIqs0ydMjgITyG0FBwu6PY8juqJmgq1sNV3NNuGxyKyje0aHuO/
 x5tSUgvtIJ13CDaoHGH29IYp25Mj7oSphwYCEpOKfPy0jFT6+UQG/mQbuIDTPMXwlMmJTtn4ZUt
 nWuXOyiVNRq000PPcZm+lZVTXrUFODkUneydhGPk+P6RHQCnH35ibHna+Y/2OKkHI1jeSdBIrfS
 vzz7gSwfekX+/Xbgs9cRKDSdfSxH28BEB5qP3ZGugBVNvC2x+KrdAm+Ha0FaGvlBfjLBA63mSgF
 iVsgEna5zDdEAEc27NUK+l4w7KWU6zea0eihl9Hh5kgisB6S5ui+X1kmj44iqvI+eCYIIGkfufA
 j9cvyzxS9RLdN9tN3R2y/9aUiqpi8Xw1mFyg6N9c9DcGzRJL7OBQFuy/ldzh+PldQ
X-Google-Smtp-Source: AGHT+IGsz3YGRyShzWxmwIBroGbSDpXOA39mblyGprnpRl4fLzCXWZiFoOHMcFiHP2dpJ4UzvgcZMQ==
X-Received: by 2002:a05:600c:83c4:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46e71172a04mr74626845e9.37.1759702383440; 
 Sun, 05 Oct 2025 15:13:03 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:13:03 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 6/7] doc: make pdfdocs: Increase the maximum list depth
Date: Sun,  5 Oct 2025 23:10:13 +0100
Message-ID: <20251005221057.255029-7-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

According to sphinx-build's documentation, by default the maximum list
depth (latex_elements.maxlistdepth in conf.py) is six, which is not
enough for U-Boot's documentation, leading to errors. See below.

This commit sets maxlistdepth to ten, solving the problem.

If maxlistdepth is not set to ten, this is what I get with
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

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

[361]

! LaTeX Error: Too deeply nested.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.26806 \begin{itemize}

?
! Emergency stop.
 ...

[...]

Output written on board.pdf (365 pages).
Transcript written on board.log.
make[2]: *** [Makefile:29: board.pdf] Error 1
make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
make: *** [Makefile:2687: pdfdocs] Error 2

This solves the problem with the pdfdocs target (in
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025 at
least).

The docs have been updated as well, assuming the issues with the pdfdocs
target are fixed.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 5 ++---
 doc/conf.py                 | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 1342c71addd..47b849c7d8e 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -88,9 +88,8 @@ The *pdfdocs* target is meant to be used to build PDF documentation:
     # Deactivate the Python environment
     deactivate
 
-However, as of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
-
-We can use texi2pdf instead:
+The *texinfodocs* target, together with *texi2pdf*, can also be used to build
+PDF documentation:
 
 .. code-block:: bash
 
diff --git a/doc/conf.py b/doc/conf.py
index 84d028feda8..3405fe428f7 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -376,6 +376,10 @@ latex_elements = {
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
      ''',
+    #
+    # Deep nesting; tell latex to cope.
+    #
+    "maxlistdepth": "10",
 }
 
 # At least one book (translations) may have Asian characters
-- 
2.34.1

