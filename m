Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C069C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 22:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDA9886B3;
	Tue, 11 Jun 2024 00:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UvKPAXPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDB888675; Tue, 11 Jun 2024 00:27:57 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A702885E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eb73eb209bso95031939f.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718058474; x=1718663274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TL40+6VL4TowLjETCRBylXujRsCVN3Xzzch110GmJQ=;
 b=UvKPAXPlwAsi+Uul9IbyPzLy6lS+hTE4G+RiE9BX89CP4gz1cSjCnHHCSrFAl84ndi
 zDzFDSaHaoN4BMnDpUBpe8k7xmIWi17V3v8cTH7b1zxAzUWhPxYzToDVXCgB5HzXdfjS
 FhjQzY8cXWU2/wY4knlG62gnU4g4ArEAyaVMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718058474; x=1718663274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TL40+6VL4TowLjETCRBylXujRsCVN3Xzzch110GmJQ=;
 b=EMIhvolmQoMVPNa+tRb1+mZtalUjBD2NMMYbE9gZQysumiIJpoVxQ/h6p10uuv7Xts
 SLBoSqj2VIp8TJqbrckeSDO14n3G3J84fuhDnHO6I4wNyav2+HdCdIv7Xc0PmXzFRyia
 gIEWLg67wEffyqTByjhIzbK19W94LOYoq2PeXNL3AzHzELGJCNKRE02TFON27jN9xA1O
 IwIsjsoe9KIExFxDOZ70ZshUTb0VoalOGycn2HHeXjJgZ6uCtkxaLuQ3xaSOT2dSuaYL
 tcVKvIQeCmCT+2p3R7bxL157Cj3I2lf1pM4bPvxj6NRtuU+8vqs2mcVobgf5RvxftCui
 tFig==
X-Gm-Message-State: AOJu0Yzhd6SCSRuZatqKl5nY6jnYqqRhJ7fj6hMMvL72H5/fJOOcVxIQ
 lXPIK2dpvZ8121zIVnf5i7cwcCB0YBX1FyprO9JSFQiu0u4nTUUBloTrPmueZxeC3z9VXMuziHM
 Ssw==
X-Google-Smtp-Source: AGHT+IFd5kpG7Kt3dg3nu42ukaof2FugwLmEoLgpFMW+msVUjJAfPk5CXDEiygrHtwh9908QVG6pnw==
X-Received: by 2002:a05:6602:3407:b0:7eb:7c8d:dee1 with SMTP id
 ca18e2360f4ac-7eb7c8de2e4mr593906639f.11.1718058473827; 
 Mon, 10 Jun 2024 15:27:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b90e06ead0sm1181665173.74.2024.06.10.15.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 15:27:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 1/2] Create a common file for test scripts
Date: Mon, 10 Jun 2024 16:27:42 -0600
Message-Id: <20240610222743.255386-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610222743.255386-1-sjg@chromium.org>
References: <20240610222743.255386-1-sjg@chromium.org>
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

 bin/u-boot-test-common    | 31 +++++++++++++++++++++++++++++++
 bin/u-boot-test-console   |  7 +------
 bin/u-boot-test-flash     |  7 +------
 bin/u-boot-test-power-off |  7 +------
 bin/u-boot-test-power-on  |  7 +------
 bin/u-boot-test-reset     |  7 +------
 6 files changed, 36 insertions(+), 30 deletions(-)
 create mode 100755 bin/u-boot-test-common

diff --git a/bin/u-boot-test-common b/bin/u-boot-test-common
new file mode 100755
index 0000000..fa3ad88
--- /dev/null
+++ b/bin/u-boot-test-common
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+# Copyright Google LLC
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
+. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
diff --git a/bin/u-boot-test-console b/bin/u-boot-test-console
index 0b6b4ac..ad90040 100755
--- a/bin/u-boot-test-console
+++ b/bin/u-boot-test-console
@@ -20,12 +20,7 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
 bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "${bin_dir}/u-boot-test-common"
 
 . "${bin_dir}/console.${console_impl:-picocom}"
diff --git a/bin/u-boot-test-flash b/bin/u-boot-test-flash
index 8dcf198..2e7d5b5 100755
--- a/bin/u-boot-test-flash
+++ b/bin/u-boot-test-flash
@@ -20,12 +20,7 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
 bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "${bin_dir}/u-boot-test-common"
 
 . "${bin_dir}/flash.${flash_impl}"
diff --git a/bin/u-boot-test-power-off b/bin/u-boot-test-power-off
index b59436a..eff0370 100755
--- a/bin/u-boot-test-power-off
+++ b/bin/u-boot-test-power-off
@@ -20,12 +20,7 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
 bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "${bin_dir}/u-boot-test-common"
 
 . "${bin_dir}/poweroff.${power_impl}"
diff --git a/bin/u-boot-test-power-on b/bin/u-boot-test-power-on
index ca87477..5c6b99f 100755
--- a/bin/u-boot-test-power-on
+++ b/bin/u-boot-test-power-on
@@ -20,12 +20,7 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
 bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "${bin_dir}/u-boot-test-common"
 
 . "${bin_dir}/poweron.${power_impl}"
diff --git a/bin/u-boot-test-reset b/bin/u-boot-test-reset
index a160e0c..9d31a12 100755
--- a/bin/u-boot-test-reset
+++ b/bin/u-boot-test-reset
@@ -20,12 +20,7 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
-set -e
-
 bin_dir="`dirname $0`"
-board_type="$1"
-board_ident="$2"
-hostname="`hostname`"
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+. "${bin_dir}/u-boot-test-common"
 
 . "${bin_dir}/reset.${reset_impl}"
-- 
2.34.1

