Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BC7D1BDC0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 18:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B860688D4A;
	Mon,  4 Nov 2024 19:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PMbcQXtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE35788E4B; Mon,  4 Nov 2024 19:36:53 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F8388D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 19:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83abf71f244so152069939f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730745409; x=1731350209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1irlyi+ZBEZ/jJEr/tsiNz7loA+Etv2zP0qMHr1/fWA=;
 b=PMbcQXtZJvuYKMZaenTFuIrYmEBzzs7CstUFHfJTqHVhxC9ORBFso2tq4NOGtGTIAG
 kBwmGzb+pyhVhSl+dCUdb4qFSYF+8hLgHvgzBhZqwqUmEo8qv1S4nTQItz4YKgrArObS
 TCgGqtFSoWti9Eui0IvZyyIkB6c8APQ/Khht8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730745409; x=1731350209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1irlyi+ZBEZ/jJEr/tsiNz7loA+Etv2zP0qMHr1/fWA=;
 b=k2XOqbgS006lq/JMcF1nsVxc6aY7qW1rVyu5XgOvy8XbbjGmYGoTAzFzq6H8j06E1j
 PblxkenQ3ab6z8hmIb3/nlfhXm2K7NlWm7BsVo3tkYfLcPAM9MvWKinehyLkBC4yiMT1
 IENQOjNZ1bxFgbfcrWNkmZvSD/NFLqS4GTk6eajpjJlF10uu/FTu5dyGWQf/Ub0AX6d+
 5iniAc2NPfsSD5RhPeNyiop4pK7JEkmJUtt99MHhEZ12OUFGq2MR4/pd+aELYalw9ZU6
 iaeN46vSxOk7E2g8QzTTCiUs/y5Yh2HdxXB39QzIgJ2tRlQb7EYe19ExZafP67/iLBRV
 PPaw==
X-Gm-Message-State: AOJu0Yx6bUiyC2xM0wudva0zbYS0I2SWglyuuvyIF1BPbnAM2EnRNnJo
 b2zTi5YePbQRD9ilH9+AVCexejhIGC6iiGVEuei75ZaDn25ridwxgdCKPyvybnlFaQEjOhkg2GY
 =
X-Google-Smtp-Source: AGHT+IF83kD32CEtY1uzKM+evjpk1X3uFqE3I+fjzRklFTyqz8qH61g3QGa9hbx6n3EFWVaPBdKiOg==
X-Received: by 2002:a05:6602:6d1b:b0:83a:9820:f26b with SMTP id
 ca18e2360f4ac-83b64f7309dmr1889303039f.2.1730745409178; 
 Mon, 04 Nov 2024 10:36:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048e372bsm2030285173.74.2024.11.04.10.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 10:36:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v5 1/3] Create a common file for test scripts
Date: Mon,  4 Nov 2024 11:36:41 -0700
Message-Id: <20241104183643.1116385-2-sjg@chromium.org>
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

The top part of each of the u-boot-test-* files is common. Put it in
a common script file to avoid duplication and to allow it to be
replaced for the Labgrid-sjg integration.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v5:
- Use Labgrid-sjg instead of Labgrid
- Use LABGRID_SJG to indicates the 'Labgrid-sjg' integration is running

Changes in v4:
- Use an environment variable to select the Labgrid hooks

Changes in v3:
- Fall back to conf.${board_type}_${board_ident} if conf.all missing

Changes in v2:
- Make use of the common script (only) to set bin_dir

 bin/u-boot-test-common    | 36 ++++++++++++++++++++++++++++++++++++
 bin/u-boot-test-console   |  8 +-------
 bin/u-boot-test-flash     |  8 +-------
 bin/u-boot-test-power-off |  8 +-------
 bin/u-boot-test-power-on  |  8 +-------
 bin/u-boot-test-reset     |  8 +-------
 6 files changed, 41 insertions(+), 35 deletions(-)
 create mode 100755 bin/u-boot-test-common

diff --git a/bin/u-boot-test-common b/bin/u-boot-test-common
new file mode 100755
index 0000000..2c3b476
--- /dev/null
+++ b/bin/u-boot-test-common
@@ -0,0 +1,36 @@
+#!/bin/bash
+
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
+set -e
+
+bin_dir="`dirname $0`"
+board_type="$1"
+board_ident="$2"
+hostname="`hostname`"
+
+# Use either the Labgrid integration or the traditional hooks
+if [ -n "${USE_LABGRID_SJG}" ]; then
+	. "${bin_dir}/${hostname}/conf.all"
+else
+	. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+fi
diff --git a/bin/u-boot-test-console b/bin/u-boot-test-console
index 0b6b4ac..8b7377a 100755
--- a/bin/u-boot-test-console
+++ b/bin/u-boot-test-console
@@ -20,12 +20,6 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
-bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "$(dirname $0)/u-boot-test-common"
 
 . "${bin_dir}/console.${console_impl:-picocom}"
diff --git a/bin/u-boot-test-flash b/bin/u-boot-test-flash
index 8dcf198..bd89a50 100755
--- a/bin/u-boot-test-flash
+++ b/bin/u-boot-test-flash
@@ -20,12 +20,6 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
-bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "$(dirname $0)/u-boot-test-common"
 
 . "${bin_dir}/flash.${flash_impl}"
diff --git a/bin/u-boot-test-power-off b/bin/u-boot-test-power-off
index b59436a..83b69c0 100755
--- a/bin/u-boot-test-power-off
+++ b/bin/u-boot-test-power-off
@@ -20,12 +20,6 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
-bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "$(dirname $0)/u-boot-test-common"
 
 . "${bin_dir}/poweroff.${power_impl}"
diff --git a/bin/u-boot-test-power-on b/bin/u-boot-test-power-on
index ca87477..5a41c3e 100755
--- a/bin/u-boot-test-power-on
+++ b/bin/u-boot-test-power-on
@@ -20,12 +20,6 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
-bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "$(dirname $0)/u-boot-test-common"
 
 . "${bin_dir}/poweron.${power_impl}"
diff --git a/bin/u-boot-test-reset b/bin/u-boot-test-reset
index a160e0c..77e3f40 100755
--- a/bin/u-boot-test-reset
+++ b/bin/u-boot-test-reset
@@ -20,12 +20,6 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
-bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "$(dirname $0)/u-boot-test-common"
 
 . "${bin_dir}/reset.${reset_impl}"
-- 
2.34.1

