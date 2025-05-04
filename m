Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF4C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D051982AC4;
	Sun,  4 May 2025 15:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ia7aZwXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A5E82B16; Sun,  4 May 2025 15:24:50 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B49D82B27
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ace3b03c043so522818466b.2
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365087; x=1746969887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Katpp71JQ9Py/LGaFP4u9ltnCH9fJ7rnxnCq62J9bmQ=;
 b=ia7aZwXOjcX2YChlKVkDI9oWvXz0PCFhQifex7/aejYYD4HwubFRZJny2rUk+ziu4X
 ksp/+FUPZenAk8UIDwjH8SE8nUBGBHosXa+6A1swAK8vEoxtdcgPOE2NQVUM93e43dHg
 teR/8BWiybdmfpI4nYmBqwgPjV6ZSLhUF1LD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365087; x=1746969887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Katpp71JQ9Py/LGaFP4u9ltnCH9fJ7rnxnCq62J9bmQ=;
 b=EVgmTrXtHDD5iGYzWRqM9aVKp/sOPOi3mC5hbkYC5LppUyc0nJntr68tDqjiMEs73R
 hJDMLNuVmZSKTkOd1WjF8u5iCEOoSGlB3jd1QCt44BwLNb6NCt4iPnqzO/Sx8yXnx2BW
 TjSRGx8wlloWMpm56J3cbQcOwrR8eyenVyzmD9CCx3/rem4xKWAGaWGUs5bnfgvZL9bX
 c4NsMoNRZmgoaYA6WziZ4cqGOTJHDCuVEC35WwpYR/BHtQonxqpYT4IopUM230DTdxMi
 CSf+4NkPFRGQdN3c4b1qniKCccA+ISXrAWfjcp32/HdSneLoqQs1e22GyRnumKwyvqzP
 nAiQ==
X-Gm-Message-State: AOJu0YwUnJuZFG4w6PD3WhhS9+CxGdfmO2Jm3kwDlsrYPcPDgTQUTYTP
 e+40WxLqmobmJsnMnzDgZdc3gHQBu4lGVQQPmEhB9dLqWlcMozDBgwezJLzbmBuy5gtUw5N1mcz
 Q0INhrZY=
X-Gm-Gg: ASbGncuWx6iyKI2qJitveapgqlOa24sj1C/ftg09XzqAsJorDwXTMVa7kyF3f+k0T1e
 94G1pQKKDIitqMJnlwmI+IzOgm3yempmoEir/bD077L6ZN0duHVH0a6ZI4V2SKxr6SVrlaHTuRW
 vloImyQeAz8FXex7xuftH3l2IOUXKAD86rxK6hAgEOfeFMkkNJItZdKteWH18UWs9mwTf9zRsn0
 C0dInURkxri35IxExaJbOeSF0FlQDuemoqDOiSAvON+0FYZFeXM3h1UdbdL/g8im5Wpz2gld/0t
 m1/yAmb7/CRsq4oYUHzDkXU2a0tU+pe3BRK9
X-Google-Smtp-Source: AGHT+IEADFTG/+T6+6rAkN7kiJ0xkznyt0nn9Ha55Z8R471THvaw3LMLhy1ET+8GifMEohnydQkZvg==
X-Received: by 2002:a17:907:948e:b0:acb:8a2c:fcdb with SMTP id
 a640c23a62f3a-ad190836633mr500077466b.38.1746365086875; 
 Sun, 04 May 2025 06:24:46 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/30] patman: Add more information to Patch
Date: Sun,  4 May 2025 15:23:41 +0200
Message-ID: <20250504132356.2317305-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

The cover letter has some information on each patch, so allow this to be
stored in the Patch object.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/patchwork.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 3ec266f073e..8b0968c5765 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -52,8 +52,10 @@ class Patch(dict):
         raw_subject (str): Raw patch subject
         subject (str): Patch subject with [..] part removed (same as commit
             subject)
+        data (dict or None): Patch data:
     """
-    def __init__(self, pid):
+    def __init__(self, pid, state=None, data=None, comments=None,
+                 series_data=None):
         super().__init__()
         self.id = pid  # Use 'id' to match what the Rest API provides
         self.seq = None
@@ -62,6 +64,11 @@ class Patch(dict):
         self.version = None
         self.raw_subject = None
         self.subject = None
+        self.state = state
+        self.data = data
+        self.comments = comments
+        self.series_data = series_data
+        self.name = None
 
     # These make us more like a dictionary
     def __setattr__(self, name, value):
-- 
2.43.0

