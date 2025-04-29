Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9288C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AF682145;
	Tue, 29 Apr 2025 15:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dYqxZY0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA8A826B2; Tue, 29 Apr 2025 15:23:44 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D8182145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72bbead793dso4807938a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933020; x=1746537820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4DzcDf4L9UCN8/ZXlMz7fJogr0eCth6MnKLN4MJvYs=;
 b=dYqxZY0L3jUcj8lFApucDuAlsruNov+3qvEZlztVgqlATMS6nR/sw+KwpFckr3H8Jg
 7YbZsqL/0NKYxgS1cY2VNB2Gtpkx7e0zMOXAaCkvkjWtJWU0Y8b0miYhU+uLzHB9lzN9
 dpULPKD8cOeCQBRV4lZagHKlh2VdQVVnfEFzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933020; x=1746537820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4DzcDf4L9UCN8/ZXlMz7fJogr0eCth6MnKLN4MJvYs=;
 b=Ui/XpPwJ+xlh2YvWpq6/0zhAmMAFWENdAd/EDrwvjqEzAg/cWJrM48kTxriUgSSG2t
 7pUQHbeDMbf/2q5/yDlt+3soUZ5gFqq12r0yb+iT1kDX+C+FW/0nBXfW0UO3AnFp90hF
 8IKQbvjdIaT3dXx3ydUwNQLh9DtvjNpntaCHkuHbdCrFA2TP3GSHmDqxfZP8wzn4p8If
 9dLOkxa28CbtjF2DsGfTm3pyjDJsqfe0M8uVpdPsoEdzS8ktHR/EtbNd/KiVeOD40q3h
 dCKNnpWyZeVtcxdqp5zlo2csYA1GTnEgQ+ftfgFcxawA/qx3mnJImukuNkd+sghsdc2f
 62Nw==
X-Gm-Message-State: AOJu0YwLTEWeGK3ePSkXxDPqjRXrUQhVrQQpQJyOqXmw0mpVznynkQEk
 +SdsNGjKq4CHz7G7ZCIhRKtNqRpqYptaBw567y2KZtyINWHhVItCPm6WOwF447dUq+ZbWfOggto
 =
X-Gm-Gg: ASbGncsMERr2nNyEH/iepr7vx1gFBVmB2brz+HHSB1P1HtEH/I4mml3C5WLTD9xcWES
 UK0ruwlmUN02ehW3bC9DOXQ+n1mTKVthayRjOfypYDfflgSZoPqyBz1olK5pELafV1kE1LRuHCq
 CLUQVRzx6JjlNta4iLXNvyEzAQeJETgPiEmNIDtwnPUm+6NjPpVJRGZ8HfpZD5i2ke2Z7RG/GYL
 EUaenymlXRHIPMvZ+Vja6tlD3IAU0SifyIj0dAuf+XZWtnrkoEDu9OEKIXUgv/GR6M5ByFdSivp
 bozPWiuH2KXfANcKzlNcZJOjA6Ly1KgRwAvIrk21U5kAn/nx5ci4ziBHF2m0S80VQg2bv1DsEwj
 rEg==
X-Google-Smtp-Source: AGHT+IGA4yITODLiTY6Y6176apdvrXUCTkUsjPDNQdN15NtGSgFs4eMXcOOBRTgmIBs13RXHdvR6kw==
X-Received: by 2002:a05:6830:34a9:b0:72b:8ec6:e548 with SMTP id
 46e09a7af769-73088b62f4cmr2037011a34.11.1745933020207; 
 Tue, 29 Apr 2025 06:23:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/30] binman: Correct a typo in the toolpath comment
Date: Tue, 29 Apr 2025 07:22:00 -0600
Message-ID: <20250429132239.251756-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Fix the 'ist' typo in the comment for TestFunctional

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 7ee43d87b25..3fb7416a567 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -279,7 +279,7 @@ class TestFunctional(unittest.TestCase):
             preserve_outdir: Preserve the output directories used by tests. Each
                 test has its own, so this is normally only useful when running a
                 single test.
-            toolpath: ist of paths to use for tools
+            toolpath: list of paths to use for tools
         """
         cls.preserve_indir = preserve_indir
         cls.preserve_outdirs = preserve_outdirs
-- 
2.43.0

