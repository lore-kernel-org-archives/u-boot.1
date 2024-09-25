Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D57CC369BA
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 09:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDEC88B31;
	Wed, 25 Sep 2024 11:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oB5gC8+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EED18880F; Wed, 25 Sep 2024 11:47:56 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FD288B31
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 11:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c4226a5af8so8368568a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727257671; x=1727862471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy4gzOxSnfq7oDZUa9vl7mL8uMXc+ROqcMttYvUghpw=;
 b=oB5gC8+P9q8y1X6H+zOehf8QULnLrC+PFeaThO4KwFPxwAXWA7EOPJx7IKs+QN62Sb
 S9UhOaLYCyKnA66c3Mauf+qqSDMefi9k5oj9JWVZwmr+QnDTVJKIA3Gv+hctX99JnAi3
 WmXD2Sfty1ztUuFThBKmBQli+UetaeYv2IpYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727257671; x=1727862471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dy4gzOxSnfq7oDZUa9vl7mL8uMXc+ROqcMttYvUghpw=;
 b=FqKGzwWL59vAvBpNUNOZ+H9guE8wcCg6pKF+yhTdC+/9+OTwkxrpIYYX9EXjwDYM2m
 JDMsd10G7MvKVsFqsQ5WBUDzDhlp+1OuR1Gm8RooxyrnJGYOj0zkFAkzoSXwLfK8BK8e
 M4O9aKMbElV9RoZaDrGdgRuQYd+2hXK4w6YfA8dqv/tjSjqSjt76maPCWhTvVr8r8R1l
 zhUVCHAi9H1tsAtL9QYaztEuJ356h6bTj2gxzZRyl/G7gIiVr31QDb5w5ByhEl6CvB8A
 KoNdnvtgNfj8DsBrgGZIEH8F9i7nCjZBLbtFkw/8OarClhQu1Ci8athuJrIcg++BH7YX
 q5FA==
X-Gm-Message-State: AOJu0YzQntsE17JRV3tJobSUtZQJ+/on+ygf894UQpU4bfhtikns2b0m
 X1/XcorJXTzO/5f7kDHWIDgbNf2vxXJqeTHEu6d9vVvyPf9T9oT0Z3x1CNq+VEjmf9oy2oKEHgQ
 =
X-Google-Smtp-Source: AGHT+IGSicdp82bdsbT0TA4aG9egNIVBWvVCxKjZHEKURQuwbcKifcYFTksfkvZsain0EtMyI7fsMw==
X-Received: by 2002:a17:906:cae2:b0:a8a:8de6:a605 with SMTP id
 a640c23a62f3a-a93a035d76amr195163766b.17.1727257671073; 
 Wed, 25 Sep 2024 02:47:51 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f661e1sm191668766b.95.2024.09.25.02.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 02:47:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH] qemu_arm64_tpl: Add a new board
Date: Wed, 25 Sep 2024 11:47:40 +0200
Message-ID: <20240925094745.37922-1-sjg@chromium.org>
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

Add this new board, to support testing the relocating SPL loader.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 bin/travis-ci/conf.qemu_arm64_tpl_na | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu_arm64_tpl_na

diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu_arm64_tpl_na
new file mode 100644
index 0000000..556e15b
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64_tpl_na
@@ -0,0 +1,29 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
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
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
-- 
2.43.0

