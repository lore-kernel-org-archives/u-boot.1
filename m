Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4440FC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82AA80CF4;
	Wed, 12 Feb 2025 23:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EFnErZfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F8080E94; Wed, 12 Feb 2025 23:23:46 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6261C801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e432beabbdso3153006d6.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399022; x=1740003822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/rLPichaVoUsz/C4pCV2qygz6O7/ikdH5PfoF3Kr8Gk=;
 b=EFnErZfw76wkXVRVoGffsyesNSKyjK6cso03dMg2zeUftDj2IkU0Md084AJ+A79xSt
 JOqsKKShcTp7j0s0ICDtGHA10oV0W8XgJ5SJ7D+rOzl7vp5ddtyKAkr6TBF4G3Ctxemi
 DlbbB/qdg5fn9jr1D8luiFeKdaHJBbqpWPjmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399022; x=1740003822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/rLPichaVoUsz/C4pCV2qygz6O7/ikdH5PfoF3Kr8Gk=;
 b=QkcttnHdk0PkcP6lhbOj/H03G/EPOWgO2Awlp/jH0saBoDbWsAXjbtLOFkIaJDi0b3
 t7cxrzddPjtjuCgqJF8F9VPxfG4AgbnI56tETO8ndwEb3OdcHUOu2PYGGGHdCVNLaFf4
 3EyB4mwd3CIMt8LsHu+yPXxdvtnpHyK6e6+zksYgG6qiq5E5sjalAbO7u09TxXDIfRYB
 bdAZKWtOOkbJDW9RBvpZlyIJ3/ZS7yRA0bVsJwQU+CA43qDrNn8i14uzcq87+mqSzX6H
 xP3SpW0/2sNN0pQKcPlbf42XMfO5gvKKk3VS1k/8PLndB3YrQdJwFj3Q5RMtaPQSqiqb
 EZTw==
X-Gm-Message-State: AOJu0YxeroCHEWFc9wXO0SHF+Fl/qa/4R4Plha0o4EXGLY81Kf36m4N5
 M6nYJTivXsOHPVMnNsQ0CvDYaKsEID10Su3nEiEKWR6KDsUvJ15bJMNCX9m1ugb4XmIcIhQCWLX
 A
X-Gm-Gg: ASbGnctRPZ3V64Id0zI83/WMIvkfFDxvMKF1So9iHGXU9bA1wYmpQSLfmyF1IBxSzZA
 7GgmpC/7zSfljGJ1mVjLkLCsmskGVF2wJFIjfjAPa5sTpjuKkOi+UHUKzkJk04mhNFNGBkkhy/O
 vJz1p1zd28ove/JeAWZcABb6tM2ACwj+TRFkmtzst9QSgMvnD5d6uSG8lHPVwvLFQ8iGL5o9N5p
 dEJYs+QkK8iphewMO6nSgRoptOnMyxMqJGFqor8cOz3MJpw8d1hOMBTS8N7nn/DFwjEp/jSlJAk
 +pjN5cDlv6WJ7w7GsQ==
X-Google-Smtp-Source: AGHT+IHVCxAZgbBbTiVTlILpNwLAmVJNEQ4aR1v+iBwIcD3n7xKOCuN6Muk9Oa9CUnPAlDp8HWRYDQ==
X-Received: by 2002:a05:6214:1303:b0:6d9:3016:d0e7 with SMTP id
 6a1803df08f44-6e46edabb7dmr80196756d6.29.1739399022296; 
 Wed, 12 Feb 2025 14:23:42 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e453a85b86sm61819836d6.34.2025.02.12.14.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] binman: Switch to setuptools
Date: Wed, 12 Feb 2025 16:23:39 -0600
Message-ID: <20250212222339.684459-1-trini@konsulko.com>
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

With the distutils module having been removed with Python 3.12, switch
to using setuptools instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/binman/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/setup.py b/tools/binman/setup.py
index 9a9206eb044a..bec078a3d9b1 100644
--- a/tools/binman/setup.py
+++ b/tools/binman/setup.py
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-from distutils.core import setup
+from setuptools import setup
 setup(name='binman',
       version='1.0',
       license='GPL-2.0+',
-- 
2.43.0

