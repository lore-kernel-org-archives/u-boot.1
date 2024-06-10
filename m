Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD68C27C4F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 22:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741D1885DB;
	Tue, 11 Jun 2024 00:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j788IhLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B517886BF; Tue, 11 Jun 2024 00:27:59 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA42884E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-7eb5dac7fcbso21668739f.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718058475; x=1718663275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SOZOKp7ioeE1LkGEXVkYD2T9GZIO2W8rLBFhq8qWzA=;
 b=j788IhLyzECIX82YGZGq6rMzZUH71tuMTIdm8nZSCGArcFH1pJwxPMr4DRa7uVhWfX
 wtr9rUxHLX/Z5gKtUGFJBiXGCAFlQH7s+STP9SL8xu0/aTREQ0cZCi3YQW5s0cME8+Cn
 bPqkulD9I2D05zfzFYVdGmGRrFnh7C7YfdQh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718058475; x=1718663275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SOZOKp7ioeE1LkGEXVkYD2T9GZIO2W8rLBFhq8qWzA=;
 b=eB5iN57DuN6ZSe+63zBv135W4EJekHNwRrU94IkTIMyNmsFTBXm5rcA7ApU2eckzDa
 gSYkxe8KnhzBlVzMaE7wtHL1zeLyNZyp7mV6JBFJz9eXNQdHIfkqt6aT9BmtTM//F3NN
 nOhcM/T3l5vPbn9oubOu1qZciQ5Ngb0NSqP+Z8sAwFbLmg4mmVt7/UAiwhQ/eDAygemc
 KSl8sbRmayiPxGWD6lhNOEHC0vtS8Xg4JzJNDlb5D03aUavLlPG4ysIR19q1scmgVKIz
 zSIgHFsktI+u6fQ4aFacfMa4L5ADb/LkS2T/haaZVxQkQPtSEpOQLT/yVX+5FcMoY9WS
 in4w==
X-Gm-Message-State: AOJu0Yy1uno+y9qzCTJAhkwEd/Uvt4Lb0F59jgBxrfhOmxI2w0X6IFBY
 sc2XXowjL3kPoanEOe6w+Fdj2slM+ST1hu7Qghsf6CeUo0jdDUEFyHp4NheG51ftr2qz7t86dom
 xvU52
X-Google-Smtp-Source: AGHT+IEjPbliq7YN1J6cDTESxtf81L5322swXXdLQmusp+tKALsjkyDIDTVDLC9APCat8QC2wfP2zw==
X-Received: by 2002:a05:6602:164b:b0:7eb:8f51:d77c with SMTP id
 ca18e2360f4ac-7eb8f51deb4mr348342439f.3.1718058475065; 
 Mon, 10 Jun 2024 15:27:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b90e06ead0sm1181665173.74.2024.06.10.15.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 15:27:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 2/2] Provide some basic scripts for Labgrid
 integration
Date: Mon, 10 Jun 2024 16:27:43 -0600
Message-Id: <20240610222743.255386-3-sjg@chromium.org>
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

With Labgrid we don't need to specify the various methods, except for
the console, which simply calls labgrid-client.

This allows supporting any boards in your lab, without adding per-board
configuration to these hooks.

Provide ellesmere files as an example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README.md                    | 33 ++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 31 ++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++++++
 bin/getrole.labgrid          | 25 +++++++++++++++++++++
 bin/release.labgrid          | 22 +++++++++++++++++++
 bin/release.none             | 22 +++++++++++++++++++
 bin/u-boot-test-common       |  6 +++++-
 bin/u-boot-test-getrole      | 39 +++++++++++++++++++++++++++++++++
 bin/u-boot-test-release      | 27 +++++++++++++++++++++++
 10 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

diff --git a/README.md b/README.md
index 290e4d0..660ffe2 100644
--- a/README.md
+++ b/README.md
@@ -199,6 +199,39 @@ scripts must be replicated once per board instance, or their actions somehow
 serialized, since they copy files into their own directories when executing, and
 hence parallel execution would cause incorrect operation.
 
+## Labgrid Integration
+
+Labgrid is a python library for embedded-board-control. It includes a client
+program which is used to integrate with the U-Boot pytests.
+
+Since Labgrid has all the information necessary to build and boot on a lab,
+there is no per-board configuration required. The various flash.xxx and
+recovery.xxx scripts are not used. To set it up:
+
+- In your bin/$hostname directory, create `common-labgrid` and set your crossbar
+  and environment information, for example:
+
+      export LG_CROSSBAR="ws://kea:20408/ws"
+      export LG_ENV="/vid/software/devel/ubtest/lab/env_rpi_try.cfg"
+
+      flash_impl=none
+      reset_impl=none
+      console_impl=labgrid
+      release_impl=labgrid
+      getrole_impl=labgrid
+
+The last five lines tell the hooks to use Labgrid for console and board release
+as well as a new 'getrole' hook which is only used by Labgrid. The flash and
+reset of boards is handled by entirely by Labgrid.
+
+Then create another file (in the same directory) called 'conf.all', containing::
+
+    .. code-block:: bash
+
+    . "${bin_dir}/${hostname}/common-labgrid"
+
+That should be all that is needed.
+
 ## Dependencies
 
 The example scripts depend on various external tools, the installation location
diff --git a/bin/console.labgrid b/bin/console.labgrid
new file mode 100644
index 0000000..9ce586f
--- /dev/null
+++ b/bin/console.labgrid
@@ -0,0 +1,42 @@
+# Copyright (c) 2024 Google LLC
+# Written by Simon Glass
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
+# The variables here can come from one of two places:
+#
+# 1. When using the ub-xxx scripts (e.g. ub-int) they come from those scripts,
+#    set by the get_args.sh script
+#
+# 2. When running from gitlab, the variables are all empty and so take the
+#    default values below, except for ${strategy} which is set in the gitlab
+#    script
+
+# On input:
+# strategy: Strategy arguments to use, e.g. "-s start". Normally this is
+# "-s uboot -e off" but it can be "-s start -e off" or even empty
+# verbose: Verbose argument to use, e.g. "-v"
+#
+# These variables are set by .gitlab-ci.yml or by
+
+exec labgrid-client -V do-bootstrap ${bootstrap:-1} -V do-build ${build:-1} \
+    -V do-send ${send:-0} -V do-clean ${clean:-0} \
+    -V process-limit ${BUILDMAN_PROCESS_LIMIT:-0} \
+    -r "${U_BOOT_BOARD_IDENTITY}" ${strategy} ${verbose} -a console \
+    ${console_log}
diff --git a/bin/ellesmere/common-labgrid b/bin/ellesmere/common-labgrid
new file mode 100755
index 0000000..d94cd9e
--- /dev/null
+++ b/bin/ellesmere/common-labgrid
@@ -0,0 +1,31 @@
+# Copyright (c) 2024 Google LLC
+# Written by Simon Glass
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
+export LG_CROSSBAR="ws://kea:20408/ws"
+export LG_ENV="/vid/software/devel/ubtest/lab/env_rpi_try.cfg"
+export BUILDMAN_PROCESS_LIMIT=1
+export LG_CONSOLE="internal"
+
+flash_impl=none
+reset_impl=none
+console_impl=labgrid
+release_impl=labgrid
+getrole_impl=labgrid
diff --git a/bin/ellesmere/conf.all b/bin/ellesmere/conf.all
new file mode 100644
index 0000000..af7a7a6
--- /dev/null
+++ b/bin/ellesmere/conf.all
@@ -0,0 +1,24 @@
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
+. "${bin_dir}/${hostname}/common-labgrid"
diff --git a/bin/getrole.labgrid b/bin/getrole.labgrid
new file mode 100644
index 0000000..cc0a85e
--- /dev/null
+++ b/bin/getrole.labgrid
@@ -0,0 +1,25 @@
+# Copyright (c) 2024 Google LLC
+# Written by Simon Glass
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
+[ -n "${do_configure}" ] && config_arg=",config_file"
+
+exec labgrid-client -r "${target}" -a query \
+	UBootProviderDriver:board,source_dir,build_dir${config_arg}
diff --git a/bin/release.labgrid b/bin/release.labgrid
new file mode 100644
index 0000000..399a515
--- /dev/null
+++ b/bin/release.labgrid
@@ -0,0 +1,22 @@
+# Copyright (c) 2024 Google LLC
+# Written by Simon Glass
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
+exec labgrid-client -r "${U_BOOT_BOARD_IDENTITY}" release -a
diff --git a/bin/release.none b/bin/release.none
new file mode 100644
index 0000000..0f85790
--- /dev/null
+++ b/bin/release.none
@@ -0,0 +1,22 @@
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
+# No releasing needed
diff --git a/bin/u-boot-test-common b/bin/u-boot-test-common
index fa3ad88..858cdc0 100755
--- a/bin/u-boot-test-common
+++ b/bin/u-boot-test-common
@@ -28,4 +28,8 @@ board_type="$1"
 board_ident="$2"
 hostname="`hostname`"
 
-. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+if [ -f "${bin_dir}/${hostname}/conf.all" ]; then
+	. "${bin_dir}/${hostname}/conf.all"
+else
+	. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+fi
diff --git a/bin/u-boot-test-getrole b/bin/u-boot-test-getrole
new file mode 100755
index 0000000..e97123d
--- /dev/null
+++ b/bin/u-boot-test-getrole
@@ -0,0 +1,39 @@
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
+# Prints the following pieces of information, each on a separate line
+#
+# - U-Boot board name
+# - source path
+# - build path
+# - serial txdelay
+# - number of times SPL banner appears
+# - filename of .config file
+
+bin_dir="`dirname $0`"
+. "${bin_dir}/u-boot-test-common"
+
+target="$1"
+[ -n "$2" ] && do_configure=1
+
+. "${bin_dir}/getrole.${getrole_impl:-none}"
diff --git a/bin/u-boot-test-release b/bin/u-boot-test-release
new file mode 100755
index 0000000..d4aa70d
--- /dev/null
+++ b/bin/u-boot-test-release
@@ -0,0 +1,27 @@
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
+bin_dir="`dirname $0`"
+. "${bin_dir}/u-boot-test-common"
+
+. "${bin_dir}/release.${release_impl:-none}"
-- 
2.34.1

