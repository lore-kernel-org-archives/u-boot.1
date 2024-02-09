Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB0CC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D8C887E9A;
	Fri,  9 Feb 2024 20:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="B6/5bsI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B76F87E96; Fri,  9 Feb 2024 20:21:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F99087E7B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3c00c98d32so104462566b.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506458; x=1708111258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlcH+RUROVCJiS2By0xuxqzgfC95NkX6vN2nKWBf1N8=;
 b=B6/5bsI9pYinTVXEmfVG1fAjR0m+6Jxr5R6xIJhzY2XhhYDepbBJBlJiNf9DOQ4Hy5
 uom4RsQ3gzs+3AvWpPmpauHmaqDIf5QZxP0x0XRWRQI7vKv5BRvSzNdoETOCykww4Suf
 9H9wGh+XNIQdn0jWVU78xXGJxWoxEcF1Mzk68lfwst0GWZ/xdJ5BaV1A2ReEsTP6Lwhz
 0Le2+NKKGg7Ldl5VtKlyBWdiltRu2Ptg+Nn/cV7cV+1X6B57nPRL6DeQuhNcEYVgcAaI
 Q+IG0Ka/MOsGAYRRD4/oLAD+GmWDchWB2KPhKHVfJbwuLOxwI95283q/oEm0iIkKl7VL
 ajFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506458; x=1708111258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlcH+RUROVCJiS2By0xuxqzgfC95NkX6vN2nKWBf1N8=;
 b=FnNGiUA0yJOgfNumcPqeAXBUST3CHfbtZl4r0ooq4B+Dx9ONXnHlCL4bJO1FJ7QdGI
 axDEMwQvNDNo2R4CR+FDtJg9gtJ9DKUHStA7zwfzULCTJQkuCqSYWlUouh01960Zph0W
 tQp6+D+k7o0PhuVcyFamKSVyAxXhlermHhloAVvNUztwUQFyOWMtRL9DELZyI7qbSUiu
 wDFOucwYT774+B29UZFp3xKtQ2+UfE7ML+Kov9NRhzTunv7qW4OmZ4tzTBkjSO/qLvNS
 FntinZEuFRn1BvkP7fc9eOgFwtZ4f40m4fXfKbNld26XbJCJ/lp2UxN0mVvf7E2SdYmX
 m8PQ==
X-Gm-Message-State: AOJu0Ywn9G78sAyBJhOFNb1Xu8tBSDEcH0s2PCJbRUFe4uL1nFGGlK7r
 BlEcAWIEeRPhQ2YtPgwroyE6pgdv/c8OFUYgPF6gfkQSm6QCEOEtDzPX89t88ykL+IGul12NydF
 vFFs=
X-Google-Smtp-Source: AGHT+IHNswFa0blcSbC5OWxPJtEULX+BQZ4oeWp/YA3c2XFsw3OJpwScZkhHPCnYxVEkkBpKCzFezA==
X-Received: by 2002:a17:906:2b53:b0:a35:cbf1:c254 with SMTP id
 b19-20020a1709062b5300b00a35cbf1c254mr23463ejg.11.1707506458489; 
 Fri, 09 Feb 2024 11:20:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXEifpkIYMODWCyEnD89hr2KnDpJCX65QjBzgEMH8+7Fwl6GV3h5J3hHjwg1REUe6Vc2HTdGOBf/cu6RW7421W8RPQkC6rRducQlOc+j3ogLBivi09o2nhGIDGr3AFSIm830h+h8Gw1oK774N5eo7oS8bumdPCdvxt/QL2vphBbcXWhgjSwDJs24VlHcfrqJ0s0aUOU+B7nfrC0r4cBU/H8hj/VvWzXA9EI/Dj0mijFWjPedmn5ylFdZyNipm4riKZDm1n+y61rUYltclau+yyauutb0PBbbpgxjoJ7KGV/pmO0WVs2GSSEHVQ=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 dc23-20020a170906c7d700b00a30cd599285sm1031109ejb.223.2024.02.09.11.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:20:56 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/7] avb: move SPDX license identifiers to the first line
Date: Fri,  9 Feb 2024 20:20:40 +0100
Message-Id: <20240209192045.3961832-3-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Move SPDX license identifiers to the first line, so it conforms
to license placement rule [1]:

Placement:
The SPDX license identifier in kernel files shall be added at the first
possible line in a file which can contain a comment.  For the majority
of files this is the first line, except for scripts which require the
'#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
identifier goes into the second line.

[1] https://www.kernel.org/doc/Documentation/process/license-rules.rst
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Fix typo in commit message
- Mattijs Korpershoek R-b tag applied

 cmd/avb.c                              | 4 +---
 common/avb_verify.c                    | 3 +--
 include/avb_verify.h                   | 4 +---
 test/py/tests/test_android/test_avb.py | 3 +--
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index 783f51b8169..ce8b63873f2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -1,8 +1,6 @@
-
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #include <avb_verify.h>
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 59f2c25e0de..938a5383b5d 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #include <avb_verify.h>
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 1e787ba6668..2fb850044d9 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -1,8 +1,6 @@
-
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #ifndef	_AVB_VERIFY_H
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 238b48c90fa..865efbca4de 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -1,6 +1,5 @@
-# Copyright (c) 2018, Linaro Limited
-#
 # SPDX-License-Identifier:  GPL-2.0+
+# Copyright (c) 2018, Linaro Limited
 #
 # Android Verified Boot 2.0 Test
 
-- 
2.34.1

