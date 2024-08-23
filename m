Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D788C5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725F188BB8;
	Fri, 23 Aug 2024 23:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kItNga6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C01888AA9; Fri, 23 Aug 2024 23:31:32 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C5188B70
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39d4a4e4931so7860645ab.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724448689; x=1725053489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeQrJNMtI6x+iiGJgw63JYLTvZRQS7TEcgYQdkDK9Fg=;
 b=kItNga6mjdMfy4aVW7sZOXxkV840ArjSEwghurSefpkISZZb7LsiaQ5iS2wC3xa+Km
 zPkIkro5b6wgEC+6cGl5PgLRwR6a7iZxHz+843bu67jkGD+xiAgy8QgaCSq+0cbhGsUW
 Md0IDFFrOmMBsec4xC+eSQkHs2viT1calQs6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448689; x=1725053489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeQrJNMtI6x+iiGJgw63JYLTvZRQS7TEcgYQdkDK9Fg=;
 b=kD3lyYoLUXc3KATsv/X2rNz3LArn5ArO6IONVn6DvBpc0hR2UnIpRuu4cVtvOBd0oN
 b55ZWH9zj7rog6XvKwaobOo8N4tnM5NMGshA2lUFkGoLO2CIgcG+0r1EoEszZeYLpYRQ
 crp0bEt9Hv1hnZlMo3Ab2nogoQ9wh217mD7e7C5iqlzdXzETiHnzf3StMb0vVi7jpqan
 cvy8lNPo5MWiKfmEtXjZ81yhwsv7PQicwuudoNYyC3fzSpVwvDaMo2kcOaGcnPH++jZa
 jguIKNqeTTkNNIOhNsiCFEnpqdx30FSEVsd1zEIeqpwr7+L8p00eTSb4usjWcs79dAS4
 yYiw==
X-Gm-Message-State: AOJu0YwfWWzneXTBeQlPFX6DIoYWEscOHjvaa4Og5CsjpvhM6diF89Td
 MHVdNZxPdFSJw4UfzwVxLN2qxZOQbzHvyzSLmh9erQVQlbIyyuuK6nuqKX0/rL+0DmK3kxSEu/Q
 =
X-Google-Smtp-Source: AGHT+IGd9gu2nZwjz/F4KxpOFM9TAEGk/MHYiji+T1RIrZzPxGx0OBiVCwUwdPRPoLCrKxNr/7BtHw==
X-Received: by 2002:a05:6e02:1a65:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-39e3c98c3ecmr43542335ab.14.1724448688932; 
 Fri, 23 Aug 2024 14:31:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce7106a1bbsm1101042173.97.2024.08.23.14.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:31:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v3 1/2] Create a common file for test scripts
Date: Fri, 23 Aug 2024 15:31:22 -0600
Message-Id: <20240823213123.487227-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823213123.487227-1-sjg@chromium.org>
References: <20240823213123.487227-1-sjg@chromium.org>
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

Changes in v3:
- Fall back to conf.${board_type}_${board_ident} if conf.all missing

Changes in v2:
- Make use of the common script (only) to set bin_dir

 bin/u-boot-test-common    | 35 +++++++++++++++++++++++++++++++++++
 bin/u-boot-test-console   |  8 +-------
 bin/u-boot-test-flash     |  8 +-------
 bin/u-boot-test-power-off |  8 +-------
 bin/u-boot-test-power-on  |  8 +-------
 bin/u-boot-test-reset     |  8 +-------
 6 files changed, 40 insertions(+), 35 deletions(-)
 create mode 100755 bin/u-boot-test-common

diff --git a/bin/u-boot-test-common b/bin/u-boot-test-common
new file mode 100755
index 0000000..5975ff9
--- /dev/null
+++ b/bin/u-boot-test-common
@@ -0,0 +1,35 @@
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
+if [ -f "${bin_dir}/${hostname}/conf.all" ]; then
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

