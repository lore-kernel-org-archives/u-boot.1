Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81F4C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 11:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3123382C79;
	Tue, 17 Jun 2025 13:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kddezFaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D63C682C87; Tue, 17 Jun 2025 13:33:51 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61A182C2F
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 13:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45310223677so45350215e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750160029; x=1750764829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fQblMARX7SMz0WOniqlnPt3VAkT9nrKruHViq/4mD1w=;
 b=kddezFaMUPqvzXorcjsoLAGTQEJ2MjPikpxEAQj82WqiHMGlkT2jRVyJG7V0mJD/at
 DIKXxt49ec9UdlUhAWapicnQNGg+D9f/I0q8eZzvi8XrL9X71zKB5Ln88wk5Wc7xkHCh
 oQu8wS2AbCOzycjYSXAFVvZBl7MTqav8p0z/aabyv7Cb3ewppGH4KEq8V4lZncbYl29y
 6jRyDJiJby9ADs28A6ezcYJcScrxGxgmwowJ0JOdYOBFKn7t7Yaf3i3ZYQwkhuHSylW5
 ujL+ozEPTLP4zYEs+v4BdZZcNm2u4dlPRV5Mxzk2UsPfOsivMlsM/XhdEUjiCZ/kbydb
 hETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750160029; x=1750764829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQblMARX7SMz0WOniqlnPt3VAkT9nrKruHViq/4mD1w=;
 b=KSie2HRmb5hkoxdPNmUBobMM5MwM6qyZ1BpqTrYIhdWRvXJeNoSADNkwnzVCbhET/u
 J57bwyprM7QjJaOnn2WPr4/bk27ivJOb0TTl8unlu1ObE3bEmtjqS2R24ARx79DXLYhc
 PQiKr8lHlUvvUN7q+OCfIcUFaLUL5gySZhPNbmjlcVjQFTdSB4Czps2JIjogoIGKI3OO
 XsK0MvTEXz6h5ZNkk8iswUmpgGtjWTVGwUm4eeANx3VO2eUU2v7tLgJ4J56yG1F9ILKP
 hIldKsksw5aajRM9o4O0JZgjZXECgNWkgn8MdENhIgFEepUjEgefeBaEB+jAG5BSCJGP
 FOag==
X-Gm-Message-State: AOJu0YzsZZuH/g2QVg+1MwEeMfx5+o7D7G02/3FVaCRhOvSujM9cEF6u
 wsA1Is7xXUgFA+mO/QyW1XjdPkMB4x5EyAfnl9OmIFhdoltZJWHdd8+MjPbcdP993r0zwaBy7+Q
 6AaOh
X-Gm-Gg: ASbGnct5eSnAGwMkQ17fNfDWzdtoZs68oFPGs/YlbzY2Y47zX47ORX9pJcdnE0c3CLu
 RuYOqWTu0+UpjMSBrzo9ArM5bx2l7fv7nNKuotAxEIQRZFMS8Q+n0cc8czzjOSW4Kk2PsRvg/Lt
 wfve3mfzub9bFH2dkGpiNUI4nskqqUTTPuhar0tu5Ou2bpbiMdwAOqBt/Sv1RD366Z2ZzHtwObJ
 hA1RBTqZhX+Yp8k9pmkqnBuVRQcDN3IlU03f2j2l4x+K9R78yHjQHD6nY21YJvee/pwUinhWmgA
 h7E6ok3uGQgK5RZgwZiq2YWt/cN1ih724OW9p8DlA8APPtAVLqjn2UiV2naj4ZNcm/YZG8s=
X-Google-Smtp-Source: AGHT+IHRW2ZbTbfYAX7flGa5eRZR6so+ikKr0OfuRw5PaU41eoAgWYa7TRBjxfFyiHVd7N0WsBshkQ==
X-Received: by 2002:a05:600c:8509:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-4533caa3d54mr157855155e9.10.1750160027064; 
 Tue, 17 Jun 2025 04:33:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a579808c24sm9006882f8f.43.2025.06.17.04.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 04:33:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: cmd: wget: remove erroneous note
Date: Tue, 17 Jun 2025 13:33:17 +0200
Message-ID: <20250617113333.2546767-1-jerome.forissier@linaro.org>
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

The note about U-Boot not being able to verify server certificates is
false now that WGET_CACERT and WGET_CACERT_BUILTIN have been added.
Remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 doc/usage/cmd/wget.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 44033aaff39..06df2842549 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -185,13 +185,6 @@ TCP Selective Acknowledgments in the legacy network stack can be enabled via
 CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
 Acknowledgments are enabled by default with lwIP.
 
-.. note::
-
-    U-Boot currently has no way to verify certificates for HTTPS.
-    A place to store the root CA certificates is needed, and then MBed TLS would
-    need to walk the entire chain. Therefore, man-in-the middle attacks are
-    possible and HTTPS should not be relied upon for payload authentication.
-
 Return value
 ------------
 
-- 
2.43.0

base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
branch: wget-doc-update
