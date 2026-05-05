Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3FACD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 18:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516CC849E5;
	Tue,  5 May 2026 20:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CYt06s3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED81849E5; Tue,  5 May 2026 20:13:19 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59665849DF
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 20:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-479d593a0c3so139651b6e.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778004795; x=1778609595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HONVGuKf5guEfYq2KSRhjxVfWh5NUoLDywU+0rnoz0w=;
 b=CYt06s3BoeG0uQHeSU6UlOplY3NnmfL0dM+IdaJJ4RTlxNsoSnVETJIOnS5D2Ofnk5
 G6smMZ544F+U7cucmYLh/KNIB5e2+2n1w2o9ysh/8vjTrZ2F9ruqXfG03Jgg+D16sCNh
 phKp85A183M2pnq2Qk7fs4y1wSXys5R1yef9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004795; x=1778609595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HONVGuKf5guEfYq2KSRhjxVfWh5NUoLDywU+0rnoz0w=;
 b=fUBujiXAkD1ZPkhOW4mXYJ4389X0OtA1ny2Zwc/VLAjyeHQNJQ80tkDAew1MIXzWTJ
 vWHXC2yvm9UULq/nq62kqAbn5LL07Ri2aiy8qIV8ufTib4tKiyR5PBM/a9NvkESU9ye3
 If9dyaSCObGXtTaXK6zJf+DYcA0/KQsCwN5zkg2DqWDBIK0FzKKv5nWZSYxVv/iPEk/1
 M6MTJv02J5tq/RDYPY3e46Wj24h+yJF4k83lw68mEeYF3JAgYNzX9QMKJtHzVugI2rOP
 RYWd4gzRk7Xsi1epGu2oPPTmhVthfpXR1BPalSDnOlBms5fGpC6tZDqvAwjVrVdkgKG+
 rFMg==
X-Gm-Message-State: AOJu0Ywl4LqWTf8XTktYUoVLGk9iaMK4mPTU1yrnmhQs7ArRWt93jQr+
 9T6NtRZazHy14a5F340aAnuwuIKeenpiSES2D/2wOpD6U/AVkV07iw1Udq0KosjCk4snQrKGT5X
 lBYofHqHS
X-Gm-Gg: AeBDievRaRJhO/8iSYKs8aWeoBupCmSL4FDvOVys8duRDvV9nqV4zWiL8QJg2ERlFrx
 wQUvDafFLs97GU7NI/nlLpzSKgHsiGGLNm6WNvAwE0w7IBglPL8BdVio2KR7jdszcZKDYkC7bz9
 fl7gNyBgsfztrXjh6eZKnmKVVHIijjwEHR8DnVu5I2NQdJi6uD6vYlAiW78FDFW9eHOVHTeqzQ4
 vAqqdYC/RaUuox2KNA9XJP+PVwNNnbSH1RHhi3d5Qm09hiti0XJCs0BICG7J2kpUWaz194zL8jg
 06Qo1DewRzOa0Ad280WTKu2lmD8b6ITrGWdH4K3cNtIH2P6ddKIB5qDpYbUSckMRxcs6G2I/3zY
 zYylOZ7sZlnTpvOJ5IohFRdv2YIoaEs4kW6dVA1RcxwLSLfag9nusPowBnIw5zYxqoE8RtVgVYs
 j3+1udcnwj9PeMjtc+XlFs5QRxyddCBuOxKRuH1G4=
X-Received: by 2002:a05:6808:4fe2:b0:479:fca7:4650 with SMTP id
 5614622812f47-47d3660a591mr2299018b6e.31.1778004795444; 
 Tue, 05 May 2026 11:13:15 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm14585754fac.6.2026.05.05.11.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:13:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] binman: Flesh out the softhsm2-util bintool docstring
Date: Tue,  5 May 2026 12:12:54 -0600
Message-ID: <20260505181300.223439-4-sjg@chromium.org>
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

Extend the docstring with a short description of what softhsm2-util
does and how binman uses it, so the generated documentation has useful
content.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword the docstring per Quentin's review: binman uses this bintool
  only as an availability check, not for runtime PKCS#11 operations

 tools/binman/btool/softhsm2_util.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/softhsm2_util.py b/tools/binman/btool/softhsm2_util.py
index 869221d841d..fd2ff2d6473 100644
--- a/tools/binman/btool/softhsm2_util.py
+++ b/tools/binman/btool/softhsm2_util.py
@@ -7,7 +7,17 @@ from binman import bintool
 
 
 class Bintoolsofthsm2_util(bintool.Bintool):
-    """SoftHSMv2 -- support tool for libsofthsm2"""
+    """SoftHSMv2 -- support tool for libsofthsm2
+
+    This bintool wraps the `softhsm2-util` command shipped with SoftHSMv2 (a
+    software implementation of a PKCS#11 token). Binman uses this wrapper only
+    to check that softhsm2-util is installed (and to fetch it if missing); any
+    actual token initialisation or key import for signing FIT images or
+    capsules is done outside binman, typically via mkimage and the OpenSSL
+    PKCS#11 engine.
+
+    See https://www.opendnssec.org/softhsm/ for more details.
+    """
     def __init__(self, name):
         super().__init__('softhsm2-util',
                          'SoftHSMv2 support tool for libsofthsm2',
-- 
2.43.0

