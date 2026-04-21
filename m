Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB346F94CB6
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 23:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C9C83E76;
	Wed, 22 Apr 2026 01:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IvzfRCvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A7983AC5; Wed, 22 Apr 2026 01:11:39 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABBB83AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-50e5dbd8e0eso24857541cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776813096; x=1777417896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg3kfTIBvC70s4mUbcRwcpiYoqhrTjkB1nj1mEeuIb4=;
 b=IvzfRCvSjGriTbixPfx25KKb+wJrc8uGx6ZapCxZSyoMqrBpRMsOdTnCKpCPlj2m19
 vAStNf0zfJ8gZGbyc6SMAOnUT+c5w7lKEe+JSMFUHBWNg/yVpRKPy202zqbxlCdvi0BX
 c4OddjI+bvAiuZWbehwPUzv/4sgYVj8Tjo0jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813096; x=1777417896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mg3kfTIBvC70s4mUbcRwcpiYoqhrTjkB1nj1mEeuIb4=;
 b=GYsFzsFjq16Vm2N8X56RY28Yr+Zr/5v2XRQi6VDvFG3B8zWhZHG/8eXVXaB0oQPQPK
 41EtHaV4rr+/ry9US9UovUOC2G/iaWdjXYxZRFCM7J6jsSwGYtxMYt8ewALoiSzBVGJw
 CMUCJGtqQM01XMjVbKeQT1aJOvEaxDzJU5zpl6IulYFgk/ng/xqBPpJgLkpLU0BNwewO
 8WmyZu1wIwL4DbuZhOhmtOfJSrUI3T2gg5bBKuHnL9gx/ifKEsJAr8hYIUW/iDEOUlZ3
 /7ohxWxtnmkrSSZQySMHQG0M3x75kxeSMf1xxmRcQpV01tTun0yEYNcIX1yEMLdyNchJ
 LNVw==
X-Gm-Message-State: AOJu0YzTMi7RdyKsnlgPVXT64Ll4+TpyX32u8e0nAOLKSoyPLEA/2y8A
 ou3wSXNinkwVmGi+6jTWPtWrsibIsKKMnf9v30X+8ZAQccNfBSfybB5RcavIliMvCxtwiYqT1aI
 pVqbAsg==
X-Gm-Gg: AeBDiesh8XoTkh/przGWXfFqA69xB89yJ/dVTwriUtCsN895/MVTRAdNHSlZ1KEvSsa
 epcj7JULtLxd8QYdf6wFk4psJqD8TavSosJ1zsvcqa+6917oqWueuN61kmSLioN8m2kpR2TcmZx
 y5mciZ7M9rkRPnorsQvG/ZoXdhv99EgCCNCr/JyvW0wE6yqfC7xDuNBqcqpgjXi4QB7yCNEiv0Z
 J/94+3ENGWwcT8Hn0u1v9ldDdIxqjq6pm5CsmlP6fgYaghu104vJ76CWTRzusd2YxNFXXxyA/y+
 3sA4cuGPfN6+w9tPmOcrx5Yg1siKUP1VV18WePClIeYsk3hi5OYt7MUS2QLLiNnI7zzM7mALIUQ
 aqh28JB1jh5xG2akw0u+xNRHqDEeNz20mjZoZvJb9DbdCgB09v1ZviMFKL+TcWDli+Aa4wrqqZ6
 WiwU3EQ1eg8qrEWhWtVyievo9bYEx1
X-Received: by 2002:ac8:5788:0:b0:509:68c:634d with SMTP id
 d75a77b69052e-50e3682797bmr312660911cf.10.1776813095808; 
 Tue, 21 Apr 2026 16:11:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e6123c3d7sm56551551cf.12.2026.04.21.16.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 16:11:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH 1/3] binman: Flesh out the p11-kit bintool docstring
Date: Tue, 21 Apr 2026 17:11:16 -0600
Message-ID: <20260421231126.597390-2-sjg@chromium.org>
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

Extend the docstring with a short description of what p11-kit does and
how binman uses it, so the generated documentation has useful content.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/p11_kit.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/p11_kit.py b/tools/binman/btool/p11_kit.py
index 9d8d5d848b4..bb9e7304c54 100644
--- a/tools/binman/btool/p11_kit.py
+++ b/tools/binman/btool/p11_kit.py
@@ -7,7 +7,15 @@ from binman import bintool
 
 
 class Bintoolp11_kit(bintool.Bintool):
-    """p11-kit -- support tool for pkcs#11 libraries"""
+    """p11-kit -- support tool for pkcs#11 libraries
+
+    This bintool supports running `p11-kit` to discover and configure the
+    PKCS#11 modules installed on the system. Binman uses it to look up the
+    module path for a given token provider (for example SoftHSMv2) when signing
+    FIT images or capsules with a PKCS#11 key.
+
+    See https://p11-glue.github.io/p11-glue/p11-kit.html for more details.
+    """
     def __init__(self, name):
         super().__init__('p11-kit',
                          'Pkcs11 library modules tool',
-- 
2.43.0

