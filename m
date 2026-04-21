Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B54F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 23:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A9C83BC8;
	Wed, 22 Apr 2026 01:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqc/ToTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B088426E; Wed, 22 Apr 2026 01:11:42 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE40284198
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8d560ede296so517473685a.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776813098; x=1777417898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc9x3j6PKLXGIA+lziXuBC3krXhagyUOOX+nEDxQRwc=;
 b=bqc/ToTApbjZsUr789tOdDS4KMiefEh67xeJ2ybIuMrOS1xkOuOtP5NN0dPacrG7Vi
 7Pr7qC/r/Iihezq/P2jtZknZOU9d3pBPMT7tZ/8Hy3dHbOZq3TgS5kFfpHvHqNZSEFOv
 rNi+fHpBGKqfDq3NOydrL6mcAkG58do/qyCLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813098; x=1777417898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cc9x3j6PKLXGIA+lziXuBC3krXhagyUOOX+nEDxQRwc=;
 b=Swz3Db052bA4lB6eov9HEEXU+Zdq7HCFPL9WtVQrNSQUAxTYmmCOwJwpKoP7y3u1Ub
 iX6P/MtyV2lfg5LUB1DAHYfwKCGTjvS/xn85InJNPnS5qWdM2BAMJ8C7DkxAX2cjJWY1
 maJPen6JYXUJyAcUzYmh7R3R3saEbBAdtjIehYFbWRXUyRqsTKup+ZEULitEHpGqcvVc
 738CBTr2WIG9C3MYmvH8L6Y1bibzWdJdXXZ7cmSR13FUv2rgPYD1V6PSI4qRMM59svSu
 6Af3CKIkd/5EN1SWf67B+N4ru2b4UUU6p7v4N6yKE3WWJPuhV4J7WOCunAqYXKMHWk16
 hG/w==
X-Gm-Message-State: AOJu0YyOs38RIMKxqELdKVl1I6zgp05/OKD5oYPRXQ677qC+/2k5I+e1
 qEgqI1DDOyEanh6DFiSrvABHOkLq9f1rjG+fDBeK8Eg+QFAlJDJ2J/azmuYKPyDXr9ZaOj/ZcjC
 ZINE=
X-Gm-Gg: AeBDietwZ9sy6pb6zAWVlonBre8OESNT75DdZ5kqEamb8XMuzgyBsho/dBpfYBHsbMX
 /UcpEj3sFk7XYaau6dfRjqWnh8rWJPQ0YI1Fvpwb4hU+l7ivIZlGIzhcf9Mluox/NIQ/E33hTDv
 gn0H+MxpVruc9dKvcL3hF3e9l2cjkrtucKEZeqJ7SDuF6jOwyOD7U0MjzV2XOat6bgO31twIXrf
 HQLfoseJ39c+P/M57SWbGrbMwEgXVwfcosQ7EJUyGJJvlTRgrMuBLMZI4yjAC7R4R9KwRoXkpm9
 1TDPKFeMZnOsKOlNsDlXIEfwe6oiAImYMkozF18xy/wACCWXQTfAgnxzEbNPlOozwj1qw2/79QZ
 SmLi4jrNm6mslPBbvshysmKqpf7L8r+/PFyQ99TmWHX87k+Qx/4SYiLAmD3kQM1MxOg4pVfkf0v
 T2vFgYpwGRApHN3IGsiS5p8QTbX7tA
X-Received: by 2002:ac8:5fd1:0:b0:50d:8172:714d with SMTP id
 d75a77b69052e-50e3693c0c4mr325389941cf.13.1776813098064; 
 Tue, 21 Apr 2026 16:11:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e6123c3d7sm56551551cf.12.2026.04.21.16.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 16:11:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH 2/3] binman: Flesh out the pkcs11-tool bintool docstring
Date: Tue, 21 Apr 2026 17:11:17 -0600
Message-ID: <20260421231126.597390-3-sjg@chromium.org>
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

Extend the docstring with a short description of what pkcs11-tool does
and how binman uses it, so the generated documentation has useful
content.

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/pkcs11_tool.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
index 673c0ea0ac3..c4c49bf7de1 100644
--- a/tools/binman/btool/pkcs11_tool.py
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -7,7 +7,15 @@ from binman import bintool
 
 
 class Bintoolpkcs11_tool(bintool.Bintool):
-    """pkcs11-tool -- support tool for managing pkcs#11 tokens"""
+    """pkcs11-tool -- support tool for managing pkcs#11 tokens
+
+    This bintool supports running `pkcs11-tool`, a utility from the OpenSC
+    project for managing objects stored in PKCS#11 tokens. Binman uses it to
+    import signing keys and certificates into a token so that FIT images or
+    capsules can be signed via the PKCS#11 interface.
+
+    See https://github.com/OpenSC/OpenSC/wiki for more details.
+    """
     def __init__(self, name):
         super().__init__('pkcs11-tool',
                          'PKCS #11 tokens managing tool',
-- 
2.43.0

