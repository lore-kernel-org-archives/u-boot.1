Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A295C27C53
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 01:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177DE88886;
	Thu, 13 Jun 2024 03:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M7giasSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED7188702; Thu, 13 Jun 2024 03:15:19 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE438884F
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-36dd6110186so2037645ab.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718241316; x=1718846116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcEKIKvCx49ywHbJhjIZn4wvezS7wXX2gVsYOh1SNmY=;
 b=M7giasSIkSU4bHudolihQs7PoM1TXaxXTu8ofO8sweK7zWOf54CTf/xW2Ax332vuoi
 LZgUz06SpZVQjv6IJqi/MwUEE4js72CeHSyORWof/kmDqEhHufeHUr8imwDJ2fB+VPpG
 quAMYfxVJ/pV6iVJYFGGgWjutlHyAEgrXwImM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718241316; x=1718846116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcEKIKvCx49ywHbJhjIZn4wvezS7wXX2gVsYOh1SNmY=;
 b=pm+C4T6eOOIe1dsxIJbO3dO2Rl3HEpyoWsJzFRFGDxH/yaTTJscXtd648vWL7Qxifh
 ZF8hx+lq45dzI3L/Cp5zxb0NOt8Lpf5cvZiDMpY2Y2+A3y0IZ6tdc4TdwNHar7c6kQn4
 uEKPV04elUCKLqzE4hTqmRjbWwyWfZknTGyjEoYJJDrYsHFCbWRdMYRhhAbePakMybxg
 mI0mzhpgUAAMmBc+Cdh5YFsHWuQToM/ElUrzQKPkNVDaFDtOaJFcrOjkKf05IdpoOeME
 g1C91VJt1tuFClQFTN3gZMUCi+DNrCLm6D3Cog7+W8zcTjIUD0weuom1dOb7V+a4RTYi
 uLEA==
X-Gm-Message-State: AOJu0Yz4uJTAceqfLiCbIlt7sQtpLGtroxsyccNuRCUhOGFFNGOZkGit
 gQQcPoafop3Rq1FN/NQRn4PPYgPnrzHlux1ez23Jocu1SbOpR40f7qEa1veDVXXxYftdpPDzMlN
 lbA==
X-Google-Smtp-Source: AGHT+IEqF5+64EAEptQXvmSlXXCLXahFyJQhb9APAikGz8H7FlXigiWBlhCkGp28p5LQqs5d6Fqt7g==
X-Received: by 2002:a92:c94e:0:b0:375:cdb4:cc1b with SMTP id
 e9e14a558f8ab-375cdb4cd04mr27237225ab.24.1718241315727; 
 Wed, 12 Jun 2024 18:15:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d8b45208sm416445ab.81.2024.06.12.18.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 18:15:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v2 1/2] Create a common file for test scripts
Date: Wed, 12 Jun 2024 19:15:11 -0600
Message-Id: <20240613011512.2476324-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613011512.2476324-1-sjg@chromium.org>
References: <20240613011512.2476324-1-sjg@chromium.org>
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

Changes in v2:
- Make use of the common script (only) to set bin_dir

 bin/u-boot-test-common    | 31 +++++++++++++++++++++++++++++++
 bin/u-boot-test-console   |  8 +-------
 bin/u-boot-test-flash     |  8 +-------
 bin/u-boot-test-power-off |  8 +-------
 bin/u-boot-test-power-on  |  8 +-------
 bin/u-boot-test-reset     |  8 +-------
 6 files changed, 36 insertions(+), 35 deletions(-)
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

