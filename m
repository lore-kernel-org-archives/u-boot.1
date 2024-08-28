Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CDAC636E0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC1E88A8B;
	Wed, 28 Aug 2024 18:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U3ajByKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08DB889DA; Wed, 28 Aug 2024 18:45:38 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F27889B3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso30873639f.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724863534; x=1725468334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3iNLmN15FSEfdTFTKj3FK94tAMqYNV2x5v5BY8QQyI=;
 b=U3ajByKIV0yAJnBrto+qeyQ0nvT6xWpaNB6ffV6i7KJg2rOBw3IPcpRY5u6IJARYXi
 kkiLNFw/+6Cpbe0D9OTLxyKD3SW6bWTL5yiCpHKfzzFpJ4evy1yEVMZ0h9TL/ahRRgaD
 Ukxs0MqUc55Gf+GZqcopI8S2uH4YKMLKPlEt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724863534; x=1725468334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3iNLmN15FSEfdTFTKj3FK94tAMqYNV2x5v5BY8QQyI=;
 b=qkR/31SzRIhdsV76MTPhITLeYiAC3c5fSXSKTBDDHTVHBF/T1oOO9/EhlESTdiKd8l
 hjUU+BVRIm1aOxeNcsEWU2O4x3YCEi8yDOA7aZTN/25URUqUttHQ2qC2GCX6C5K34B9P
 rFGad3JvnypvCD8nlL5En+SQwZJhcaaVyHs++CGqxyQrvPh7VCtMSsVdJbkNjw/zrrlC
 S8b+3Zoci+h5Is0qbMTQ5R1CfuvNXrzv0lwipNZ2nznnaxOLj0lDI1T91Iz77NwQozH1
 2d03L6eudeo8x+IxnDoddMJFc+4zuK/DAfni4G7InNYZRl6jep5ntlfdfF5snzqRHA6r
 rVbg==
X-Gm-Message-State: AOJu0Ywyv1fldgMEQGL+1tAnjll1yVleSrYNgeH7G4NHLto7YJfMpG6c
 hU0VBkbyt+nQYTS97WC8Cx2HLNRE2vCQTSTchC5EfY4vDERe+9ehjHxPp6ictOQ/LO/ClEh3JMo
 =
X-Google-Smtp-Source: AGHT+IFJ6T8v9bxKI3IwqBcmQFQWsxKMTCdaxY119M98vlA30EVRChOjHLhvBbIj6aAI5v0K4hJd9w==
X-Received: by 2002:a05:6602:1843:b0:825:2a81:e96c with SMTP id
 ca18e2360f4ac-82a03526b51mr173179339f.0.1724863534338; 
 Wed, 28 Aug 2024 09:45:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a0ffed35dsm5530939f.31.2024.08.28.09.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:45:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Date: Wed, 28 Aug 2024 10:45:23 -0600
Message-Id: <20240828164523.125770-4-sjg@chromium.org>
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

With Labgrid we don't need to specify the various methods, except for
the console, which simply calls labgrid-client.

This allows supporting any boards in your lab, without adding per-board
configuration to these hooks.

Provide ellesmere files as an example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

 README.md                    | 50 ++++++++++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++
 bin/getrole.labgrid          | 25 ++++++++++++++++++
 bin/release.labgrid          | 22 ++++++++++++++++
 bin/release.none             | 22 ++++++++++++++++
 bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
 bin/u-boot-test-release      | 26 +++++++++++++++++++
 9 files changed, 295 insertions(+)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

diff --git a/README.md b/README.md
index 290e4d0..18a9a5b 100644
--- a/README.md
+++ b/README.md
@@ -199,6 +199,56 @@ scripts must be replicated once per board instance, or their actions somehow
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
+- In your bin/$hostname directory, create an executable file `common-labgrid`
+  and set your crossbar and environment information, for example:
+
+      # Hostname and port for the gRPC coordinator
+      export LG_COORDINATOR=kea:20408
+
+      # Environment file for the lab
+      export LG_ENV="/path/to/env.cfg"
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
+      # Tell u-boot-test-hooks to use the Labgrid integration
+      export USE_LABGRID=1
+
+      flash_impl=none
+      reset_impl=none
+      console_impl=labgrid
+      release_impl=labgrid
+      getrole_impl=labgrid
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
+    . "${bin_dir}/${hostname}/common-labgrid"
+
+That should be all that is needed.
+
 ## Dependencies
 
 The example scripts depend on various external tools, the installation location
diff --git a/bin/console.labgrid b/bin/console.labgrid
new file mode 100644
index 0000000..85e7da5
--- /dev/null
+++ b/bin/console.labgrid
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
diff --git a/bin/ellesmere/common-labgrid b/bin/ellesmere/common-labgrid
new file mode 100755
index 0000000..8bfb036
--- /dev/null
+++ b/bin/ellesmere/common-labgrid
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
+export LG_ENV=/vid/software/devel/ubtest/lab/cfg/env.cfg
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
+export USE_LABGRID=1
+
+
+flash_impl=none
+reset_impl=none
+console_impl=labgrid
+release_impl=labgrid
+getrole_impl=labgrid
+power_impl=none
diff --git a/bin/ellesmere/conf.all b/bin/ellesmere/conf.all
new file mode 100644
index 0000000..6cbe561
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
+. "${bin_dir}/${hostname}/common-labgrid"
diff --git a/bin/getrole.labgrid b/bin/getrole.labgrid
new file mode 100644
index 0000000..52fc3ce
--- /dev/null
+++ b/bin/getrole.labgrid
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
diff --git a/bin/release.labgrid b/bin/release.labgrid
new file mode 100644
index 0000000..54e7895
--- /dev/null
+++ b/bin/release.labgrid
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

