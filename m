Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310FC636E3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56E388901;
	Wed, 28 Aug 2024 18:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gDh5KqBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A72889D2; Wed, 28 Aug 2024 18:45:36 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A09C88901
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81f8f0197abso340699839f.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724863533; x=1725468333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gK+yBGVi3gOOnIueVrb1aGjUWbMBira1NmXgJikGhkA=;
 b=gDh5KqBhvigVuNCTamXVHFI/DeeTVnuS4YJd2+hRWNIrd+Hcfp9AAgYeSoyuJOWP/D
 dLYHzRH/swzHJSJzRe28RLCE00Ndj+NJ5u+ikK+oDiBmAKp7Rg2QrQuYAEfTg/mxwuSw
 03M5D96KDP2Q3bSa5+j4WPzzn/aTV+UH6BIIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724863533; x=1725468333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gK+yBGVi3gOOnIueVrb1aGjUWbMBira1NmXgJikGhkA=;
 b=F9ezQWGwnBqgAjgGT5qBy1I6s8C8x7GbXM+zdLUb5LVUHTrqbod1BgVb4KyN/KDC1C
 Ysj8UhgbFkZrh+mipmekWhUixcDU+X+XMkCdHbXYalC7d3npPzTCzX82996cXr/bboVl
 en+xn+XDzyPyM4drpcG/fED+Zc2pHW1Suv0+aJek3vi17vA5fSwjf1r2Gk2A7eTUrSn7
 9I6AHacmg73WIAmnrbvO+ON/KcIC+ddBHDmrCuJHP5GMUeJc2A3GGbFf7okN9WN00WYS
 95r7f7a7SYxy68nsEV8+rzKGZFRg+il0Ew4SeULQTnioKUngFg85cy4M1xXIk9xqk7oo
 RAFQ==
X-Gm-Message-State: AOJu0Yxt49bx0G77y3jqFEplj5ELo6VWGb7v+7CKTs7Bjj/N4wd31Q71
 vl/Y4wKm9ITxi+eU4EGzigSEObAv0mNBqiwRTE5cVjiRNOTfQCJHbJGicXLq9YsCwa1k/JjdY2o
 =
X-Google-Smtp-Source: AGHT+IEekWi0z1HWGMgKEM+YZmfZ8DrOB3qhtyhGuuTd8WHa74i9g5Cl4hVybNolpFeKaponYncUfw==
X-Received: by 2002:a05:6602:2c83:b0:812:9c27:357c with SMTP id
 ca18e2360f4ac-82a1101415cmr27974239f.8.1724863532802; 
 Wed, 28 Aug 2024 09:45:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a0ffed35dsm5530939f.31.2024.08.28.09.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:45:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v4 1/3] Create a common file for test scripts
Date: Wed, 28 Aug 2024 10:45:21 -0600
Message-Id: <20240828164523.125770-2-sjg@chromium.org>
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

The top part of each of the u-boot-test-* files is common. Put it in
a common script file to avoid duplication and to allow it to be
replaced for the Labgrid integration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 0000000..5adffd4
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
+if [ -n "${USE_LABGRID}" ]; then
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

