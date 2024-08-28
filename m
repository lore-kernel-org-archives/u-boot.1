Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6656CC636E3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B3C889D1;
	Wed, 28 Aug 2024 18:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X/99HcfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8507D88901; Wed, 28 Aug 2024 18:45:37 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C628862E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso30873339f.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724863534; x=1725468334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IBEJWn2oQYHoMtCINh87/TmsP4gko+zI9IbaEbcGfo=;
 b=X/99HcfWCsER1wKrvpZcQK2RnZupjxTeuZycvOqKDJKtvd6/U9isQWJCCtaEEKXo8W
 aY4J3hZn8Z8tnzWsDnjmTqLaLdO9r4w3nGjFxrrDjrDK2fWQF36InYEzJqFB1qKhhqdE
 1NjpPD/bU75Z5SARGHt51iEBVkgQ06l/03EIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724863534; x=1725468334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IBEJWn2oQYHoMtCINh87/TmsP4gko+zI9IbaEbcGfo=;
 b=o3kYKPl2FhRBGCxBLLmCL64z10Rnmaef+aCmRu4yq5RuwyapuqoWRw98pl/2MaztkX
 4RB35LX93Xi9MnRPJRsUSYZhpI02W1MPi48xRferLIwFX4HZBbiYOz2HrlNP+sUY9uRY
 CFwRY8hYuCeyN9aWlNjaaxvJcv59cyxtUsri3bwzJoS3XW1wNg95kbFaS16ksYiUy1bH
 1a3VET87WOx+JuB4t6dJyJkNXbHYQi/oRXmkohG9ygcOWuJ78yFbxhrivuyJZIncAqfs
 Q+VuMFbb5jKbiP5WqYNQqKCzsstHgqCOCY2mVIyRdTKNEJcx8arXHG5z3F76rWKJb98l
 KAfw==
X-Gm-Message-State: AOJu0YyG7hDZ8uHaZoG5i9mXBquafaPLC27yqfit3HHgHMaBK4nhMQ09
 cc6l7WI7mp29vNOjbtCvznkq8LEbbx44cTKpbg6KDNF1yOloJ4rh5jeLqi1zPKoXPUrlTgOPT9w
 =
X-Google-Smtp-Source: AGHT+IHm6tK8dFFUzoSO/W5h6gFk1SrQLJCAccflhG0URloRYmO/cONWUyaW/Fax326zqFmGW0xLCA==
X-Received: by 2002:a05:6602:8086:b0:81f:c045:8902 with SMTP id
 ca18e2360f4ac-82a03aac6afmr200096139f.5.1724863533587; 
 Wed, 28 Aug 2024 09:45:33 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a0ffed35dsm5530939f.31.2024.08.28.09.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:45:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v4 2/3] Add .none scripts for power off/on
Date: Wed, 28 Aug 2024 10:45:22 -0600
Message-Id: <20240828164523.125770-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828164523.125770-1-sjg@chromium.org>
References: <20240828164523.125770-1-sjg@chromium.org>
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

These methods don't have a 'none' method right now, but it will be
needed for Labgrid. Add these scripts.

Note that these are not used by the existing integration, which requires
that boards can be powered off and on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to add .none scripts for power off/on

 bin/poweroff.none | 22 ++++++++++++++++++++++
 bin/poweron.none  | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100755 bin/poweroff.none
 create mode 100755 bin/poweron.none

diff --git a/bin/poweroff.none b/bin/poweroff.none
new file mode 100755
index 0000000..cd9733e
--- /dev/null
+++ b/bin/poweroff.none
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No power-control needed
diff --git a/bin/poweron.none b/bin/poweron.none
new file mode 100755
index 0000000..cd9733e
--- /dev/null
+++ b/bin/poweron.none
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No power-control needed
-- 
2.34.1

