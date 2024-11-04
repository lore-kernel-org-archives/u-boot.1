Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C00D1BDDF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 18:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8D588ED9;
	Mon,  4 Nov 2024 19:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y85n5F+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EE988E96; Mon,  4 Nov 2024 19:36:55 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E69A88DC7
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 19:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a6ababa9f7so14980115ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730745411; x=1731350211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icOjdB2wzNt8g4BIgHkYFkQHJnnDj4skHOAyuwFqqRI=;
 b=Y85n5F+ywh3O0YRJIkHkJYMqqik/UnfonHEOgkawfDr/7UF2BwbQmSCul4AeKeCe8y
 a+z+CVbUGkZ1BuLWR8kEDMEKlWgR0DIh9Hp+RZNXnuU11yZf9ZVw3vXF9Bb5K/FNYzcH
 mszVVolijpBtZWbDJHNlVkny+XpsCktMGnF+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730745411; x=1731350211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icOjdB2wzNt8g4BIgHkYFkQHJnnDj4skHOAyuwFqqRI=;
 b=Gkocdjac6G6scx6WEAWYf/moOiltAnlYZqZ35BAYvLg+YHi+Jif0cVKMX/i4cvF7Jk
 pEE75P2n9FLu5Kdj/blL2lcLuAdIbfRMC2aEj8lqBXc19aiNF88SigdvYNjt5e8xg9Bj
 U2/KGow1LN+HQmRkMgQ9lZIE3tIvD5E1FXbM5NzWAf3neDkTQfUR74OyJP1ftFvOXPLI
 TvzXyE0n0Z9/0OinojfoJpaDaPdbdcpHDiXMnRAbQNMpURHiwB1i4iUcfbSCTDF4m+lp
 k34f3juissHMj9Dvtk4cPVPD2nu5cUv4OaR+vqaDZ+rOTmfmfyzScchqJyoKBc5uIdSY
 wArA==
X-Gm-Message-State: AOJu0YwCYouqeEpNJUz2UMUODFpLsaq/jgos1/VFkE+b1RZ9uOEDbJbY
 vIhwotCIakhbw9c1621lsM/Q+Iq7CqOSJfr7LescWwL1CnsJsLCHpMqEmS1fqaoifzllOZQ/Js8
 =
X-Google-Smtp-Source: AGHT+IGEGsdJ7KpC3+udtbpzXPpVj27IQN7tU8aae7xaxp/7dKVGK0efVArvgiXgkRNvOfvvDQ9IbA==
X-Received: by 2002:a05:6e02:1528:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a4ed295a05mr358591745ab.13.1730745410830; 
 Mon, 04 Nov 2024 10:36:50 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048e372bsm2030285173.74.2024.11.04.10.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 10:36:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v5 2/3] Add .none scripts for power off/on
Date: Mon,  4 Nov 2024 11:36:42 -0700
Message-Id: <20241104183643.1116385-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104183643.1116385-1-sjg@chromium.org>
References: <20241104183643.1116385-1-sjg@chromium.org>
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

(no changes since v4)

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

