Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111D1F94CB6
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 23:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF15C842B7;
	Wed, 22 Apr 2026 01:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SFIIGSBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8CA83AC5; Wed, 22 Apr 2026 01:11:46 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ECA8429E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-506362ac5f7so39939961cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776813102; x=1777417902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLYHOEZrP4DsLhYsidxl2FF86XZtPk37WxDN7G9Fo5o=;
 b=SFIIGSBxG+FEpsM2BNrX9uWpRFPhI02cSBOuKvfqn4bnU3BH9quKwBnIGEN2TINjsN
 aI19bahurrqFCTJIaYBPlyoM7GG7YM/PVp2RiZ3Z1nZEF5sL/DIIcbYJVcmVlHY9D2BX
 mt0roN8GbgFtF71UBX6Qk27c6cNNdz1sqFNwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813102; x=1777417902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QLYHOEZrP4DsLhYsidxl2FF86XZtPk37WxDN7G9Fo5o=;
 b=bofgaOAueWSXokXBwXPR9rmNiZUNoz57YqEHh1TLdKvqXdn8PQYlhYMYnKBN5qBSti
 /zMN+XOlPHqhDze80JZnq1H4GNsF/mfVQQth3CFQ6AE22HD4NHHEhwXofkzg/xC7DFMU
 +kipy0P8v5jMyRKdRR/h+KoARcuRYtlVRcLFPjpQC92rWpZ8k37jJp59n9vd5oIk3R9+
 m5xJ1tZ39AKVkkMINdy+mZcK3f+NnYtYp7HNNjzPl8rJi6CHlp6VUZBzjZJNUiJRzt1Z
 F9JgyeO5+26hM5tiAQM6Dfa32GH/UcVi01cy5qmbZxp4pwooc5/85h6cvWoMmhfSRQVO
 ejjg==
X-Gm-Message-State: AOJu0Yyf4f5l2QgJU3XOTeGTwRLsIlHojmfyOdDf7eNafBjb5nc4Cp7g
 gwgASIL+kp6ZKS9qM2sZJKRkEpQnuYYKFoHgU1zqbYVMFuoya0QcFweb6yDGj2L6h3izHBDXT6F
 glaN3Rw==
X-Gm-Gg: AeBDietTTd74akUNCneB8MZIY1id84rXxlWrgCJ/dxa/DcgGBsKy/hNLmDGARY9xj7y
 LZ0DM1a0CP8hlASlNvEp6Fh+JT6QCBQrCjlkA4wK5ic6gHD16DrmpMZ90FK+0uHulMcbFmwe77Z
 v4mmIo71aV7OIz2zZWTBeOiFaynOv3xTHExNPS60h2CyN0KXDYtea0ol4kRRorNsX4dc2RQUDF2
 9fG28JGCoSEdqMwDpBITEOwYzpQ8tVEF2k2hFUJ9AS57haNOJhDtVkAFmDIEUQznGUKR9fTrERc
 238NrrZR72Ws4EPtH1AISAO/pJlzcnqYutgZ88LomHeXoaHY1MbJgrQddDPBL89f/Pa6ShuQFNA
 HA49Js5HCaFmzkjY6YP1tKrq1oI8PgM7fXdzHxIdhtfDuxY3zPTWD2jiy89i5jB1BaT+4CIYqzj
 8ks8TuFVbVO2QdKuCZ2A5IIL5bcxWp
X-Received: by 2002:a05:622a:1884:b0:50d:a644:69b1 with SMTP id
 d75a77b69052e-50e36ba3f1fmr282967401cf.25.1776813102614; 
 Tue, 21 Apr 2026 16:11:42 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e6123c3d7sm56551551cf.12.2026.04.21.16.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 16:11:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] binman: Flesh out the softhsm2-util bintool docstring
Date: Tue, 21 Apr 2026 17:11:18 -0600
Message-ID: <20260421231126.597390-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421231126.597390-1-sjg@chromium.org>
References: <20260421231126.597390-1-sjg@chromium.org>
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

 tools/binman/btool/softhsm2_util.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/softhsm2_util.py b/tools/binman/btool/softhsm2_util.py
index 869221d841d..e79584da11d 100644
--- a/tools/binman/btool/softhsm2_util.py
+++ b/tools/binman/btool/softhsm2_util.py
@@ -7,7 +7,16 @@ from binman import bintool
 
 
 class Bintoolsofthsm2_util(bintool.Bintool):
-    """SoftHSMv2 -- support tool for libsofthsm2"""
+    """SoftHSMv2 -- support tool for libsofthsm2
+
+    This bintool supports running `softhsm2-util`, the command-line utility
+    shipped with SoftHSMv2 (a software implementation of a PKCS#11 token).
+    Binman uses it to initialise a token so that keys can be imported and used
+    to sign FIT images or capsules via the PKCS#11 interface, without requiring
+    real hardware.
+
+    See https://www.opendnssec.org/softhsm/ for more details.
+    """
     def __init__(self, name):
         super().__init__('softhsm2-util',
                          'SoftHSMv2 support tool for libsofthsm2',
-- 
2.43.0

