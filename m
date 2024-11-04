Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C4ED1BDDF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 18:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638B188D29;
	Mon,  4 Nov 2024 19:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TolK6R/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66BB88F14; Mon,  4 Nov 2024 19:36:57 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4476C88E77
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 19:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83aac75fcceso156540839f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730745413; x=1731350213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cK9a9laEOm0dfkwENkj6QfWQUDX49vsVHbMcjUt6/Q=;
 b=TolK6R/AjHKg8HEPallUmSg+xJAPEMliNje3Yy+LvD+o8rzS7kvG1t3C+Z59DxOWSc
 LoC87WxLrkUpKJCwVGY/lu/Z4scKF5YNOUkqYsVGIe+THJadOeq/Gjx+g9i0VLyr7sQS
 XY+L06SLsXkjc5xucxR8Kzu3jYHN9uNS/LOGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730745413; x=1731350213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cK9a9laEOm0dfkwENkj6QfWQUDX49vsVHbMcjUt6/Q=;
 b=DFnNQYyOvDccpns0nTMyMtwuJG4Zku66EoC5LLfWjJUuTb0zwPKDTeJYVzLMPsK0lW
 DjlCnGYJWvqoULL6T9kyMdAwFtUYLL+NO4qYXhj4IfVSMljYudLwNcKEs3sy6RRqOW3z
 11yf0i+G/U5d+DddcwAxVO1sjFdMsPEvULhvrD+6dr/LS6nZeOUr79u/UgKcDleTOIv3
 CSFeYNOBIRAznX+HEG80EXoxCk1ak1/Y+dBP+XVnWM8xtGLDT6JDNn6E3LyPheJP3SP7
 YawRA37XrhCAgAmfozjoqqLCYGnNdYE9G2JSd+nux7wzmyty7GaimKhMPHI6z95y5h6I
 IRIg==
X-Gm-Message-State: AOJu0Yxw3G9IuvoKPvIcXCXSGzSTSodg4jDc5Gn8z2xJPstFJ/AKFkvm
 WIsFPgMw+EKxnsKG4T3n/+ZkdTzAe7e2cjravvqzynjyprrE7aAZXd2uWFlHhdwhBCDLdeNyf40
 =
X-Google-Smtp-Source: AGHT+IHunl6xPUAbbExJGYAhWZ8acACP+liPrFtkwkCso8X+NPoBOM1Tos//Y8irLJUfKW9eM7FvZg==
X-Received: by 2002:a05:6602:6015:b0:83a:b33a:5e0a with SMTP id
 ca18e2360f4ac-83b71947e2emr1275594139f.4.1730745413095; 
 Mon, 04 Nov 2024 10:36:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048e372bsm2030285173.74.2024.11.04.10.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 10:36:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v5 3/3] Provide some basic scripts for
 Labgrid integration
Date: Mon,  4 Nov 2024 11:36:43 -0700
Message-Id: <20241104183643.1116385-4-sjg@chromium.org>
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

With Labgrid we don't need to specify the various methods, except for
the console, which simply calls labgrid-client.

This allows supporting any boards in your lab, without adding per-board
configuration to these hooks.

Provide ellesmere files as an example lab-configuration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Update commit message and cover letter for Labgrid-sjg

Changes in v4:
- Support pytest fully with dual-build boards like Beagleplay

Changes in v3:
- Update scripts for latest version of Labgrid integration
- Add poweroff.none and poweron.none
- Provide -n flag when querying board info
- Target the grpc version of Labgrid which is now in -master
- Update README to cover the changes

Changes in v2:
- Make use of the common script (only) to set bin_dir

 README.md                        | 51 ++++++++++++++++++++++++++++++++
 bin/console.labgrid-sjg          | 42 ++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid-sjg | 46 ++++++++++++++++++++++++++++
 bin/ellesmere/conf.all           | 24 +++++++++++++++
 bin/getrole.labgrid-sjg          | 25 ++++++++++++++++
 bin/release.labgrid-sjg          | 22 ++++++++++++++
 bin/release.none                 | 22 ++++++++++++++
 bin/u-boot-test-getrole          | 38 ++++++++++++++++++++++++
 bin/u-boot-test-release          | 26 ++++++++++++++++
 9 files changed, 296 insertions(+)
 create mode 100644 bin/console.labgrid-sjg
 create mode 100755 bin/ellesmere/common-labgrid-sjg
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid-sjg
 create mode 100644 bin/release.labgrid-sjg
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

diff --git a/README.md b/README.md
index 290e4d0..7abcff7 100644
--- a/README.md
+++ b/README.md
@@ -199,6 +199,57 @@ scripts must be replicated once per board instance, or their actions somehow
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
+- In your bin/$hostname directory, create an executable file
+  `common-labgrid-sjg` and set your crossbar and environment information, for
+  example:
+
+      # Hostname and port for the gRPC coordinator
+      export LG_COORDINATOR=kea:20408
+
+      # Environment file for the lab
+      export LG_ENV="/path/to/kea_env.cfg"
+
+      # Location of the U-Boot test hooks
+      export UB_TEST_HOOKS=/path/to/u-boot-test-hooks
+
+      # Make sure only one buildman can run at a time, since it uses all CPUs
+      export BUILDMAN_PROCESS_LIMIT=1
+
+      # Use the internal console since microcom can miss serial input at boot
+      export LG_CONSOLE="internal"
+
+      # Tell u-boot-test-hooks to use the Labgrid-sjg integration
+      export USE_LABGRID_SJG=1
+
+      flash_impl=none
+      reset_impl=none
+      console_impl=labgrid-sjg
+      release_impl=labgrid-sjg
+      getrole_impl=labgrid-sjg
+      power_impl=none
+
+The last 6 lines tell the hooks to use Labgrid for console and board release
+as well as a new 'getrole' hook which is only used by Labgrid. The flash, reset
+and power features of boards are all handled by entirely by Labgrid.
+
+Then create another executable file (in the same directory) called 'conf.all',
+containing::
+
+    .. code-block:: bash
+
+    . "${bin_dir}/${hostname}/common-labgrid-sjg"
+
+That should be all that is needed.
+
 ## Dependencies
 
 The example scripts depend on various external tools, the installation location
diff --git a/bin/console.labgrid-sjg b/bin/console.labgrid-sjg
new file mode 100644
index 0000000..85e7da5
--- /dev/null
+++ b/bin/console.labgrid-sjg
@@ -0,0 +1,42 @@
+# Copyright 2024 Google LLC
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
diff --git a/bin/ellesmere/common-labgrid-sjg b/bin/ellesmere/common-labgrid-sjg
new file mode 100755
index 0000000..6b3eff5
--- /dev/null
+++ b/bin/ellesmere/common-labgrid-sjg
@@ -0,0 +1,46 @@
+# Copyright 2024 Google LLC
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
+# Hostname and port for the gRPC coordinator
+export LG_COORDINATOR=kea:20408
+
+# Environment file for the lab
+export LG_ENV=/vid/software/devel/ubtest/lab/cfg/kea_env.cfg
+
+# Make sure only one buildman can run at a time, since it uses all CPUs
+export BUILDMAN_PROCESS_LIMIT=1
+
+# Location of the U-Boot test hooks
+export UB_TEST_HOOKS=/vid/software/devel/ubtest/u-boot-test-hooks
+
+# Use the internal console since microcom can miss serial input at boot
+export LG_CONSOLE=internal
+
+# Tell u-boot-test-hooks to use the Labgrid integration
+export USE_LABGRID_SJG=1
+
+
+flash_impl=none
+reset_impl=none
+console_impl=labgrid-sjg
+release_impl=labgrid-sjg
+getrole_impl=labgrid-sjg
+power_impl=none
diff --git a/bin/ellesmere/conf.all b/bin/ellesmere/conf.all
new file mode 100644
index 0000000..4a82ee7
--- /dev/null
+++ b/bin/ellesmere/conf.all
@@ -0,0 +1,24 @@
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
+. "${bin_dir}/${hostname}/common-labgrid-sjg"
diff --git a/bin/getrole.labgrid-sjg b/bin/getrole.labgrid-sjg
new file mode 100644
index 0000000..52fc3ce
--- /dev/null
+++ b/bin/getrole.labgrid-sjg
@@ -0,0 +1,25 @@
+# Copyright 2024 Google LLC
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
+exec labgrid-client -r "${target}" -a query -n \
+	UBootProviderDriver:board,board_extra,source_dir,build_dir,build_dir_extra${config_arg}
diff --git a/bin/release.labgrid-sjg b/bin/release.labgrid-sjg
new file mode 100644
index 0000000..54e7895
--- /dev/null
+++ b/bin/release.labgrid-sjg
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
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
index 0000000..284d1b1
--- /dev/null
+++ b/bin/release.none
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
+# No releasing needed
diff --git a/bin/u-boot-test-getrole b/bin/u-boot-test-getrole
new file mode 100755
index 0000000..ac8e02a
--- /dev/null
+++ b/bin/u-boot-test-getrole
@@ -0,0 +1,38 @@
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
+# Prints the following pieces of information, each on a separate line
+#
+# - U-Boot board name
+# - source path
+# - build dir
+# - filename of .config file
+#
+# For example
+
+. "$(dirname $0)/u-boot-test-common"
+
+target="$1"
+[ -n "$2" ] && do_configure=1
+
+. "${bin_dir}/getrole.${getrole_impl:-none}"
diff --git a/bin/u-boot-test-release b/bin/u-boot-test-release
new file mode 100755
index 0000000..5a3a849
--- /dev/null
+++ b/bin/u-boot-test-release
@@ -0,0 +1,26 @@
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
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/release.${release_impl:-none}"
-- 
2.34.1

