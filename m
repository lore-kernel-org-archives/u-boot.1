Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07061C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B0C88B9B;
	Fri, 23 Aug 2024 23:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hJsvrnBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6902E88C08; Fri, 23 Aug 2024 23:31:34 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A91E88B9B
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81f85130660so114518239f.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724448690; x=1725053490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+K2oxgVaK602xfvrS+g6yizwSDCLOTd5xFl6PK6pOo=;
 b=hJsvrnBi5/5pnW124l44QHHarqItEHu6wCsmm9Zh4RX65mmoZvG8Ff4HAlcXnKCXHc
 9SvZSFsfmhP9voWUUFaVkVxylAo5plAcTAsJmvySFFw1FVBy0LQHNdU2pHhm3oEXK7WD
 F/YOdmb/Kq4rkB+hSsIyhoJ9NvHWT3W83fOgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448690; x=1725053490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+K2oxgVaK602xfvrS+g6yizwSDCLOTd5xFl6PK6pOo=;
 b=RD/zjuQxG9n6STyG6mBgAT+xJKQPA/G+/bmBReRRr75r8AXO04ta21Qyn7B40n2LUe
 re04aoqpxRz3f+X19dJlIk9PaIMdIJdtC91rfzKqyOn9gwxljB9RBDHXW+EJ8wTlElHo
 rJEAlKzbIWLAuRFqGgUfS1rPJfVHLE5k8IVJ3aXHEK0Y/VJaGe1XlBET5K3SLdaTtRg4
 pyOBrAR70OoV5cdGXlkK+r9BzOh6QhhCvveD6Uwse7+4s0NEhcG02k4FADQYxVHHTNum
 0UWRejrZEmzZaaPt4OJxyMXXs/MGsdh+mukARmaTKGojBMY/ufP+UX3PckwvTNN1x2oV
 JB+Q==
X-Gm-Message-State: AOJu0YyJg/3oJnURrVME1uYioHfhcmEnoS3sPq+5yMjY/sXPbAhY9BUX
 zZ3/qaTVDUPYfYxTWeV5NakAqLQAuYlvHVs4donMaOX20OSjzDTaF6IVjrhIIWc6OufSmxjHAQo
 =
X-Google-Smtp-Source: AGHT+IF2v3iPftckZq6aL68Fm1VoykccX2AUMIO5sZMa/J3cIrG8t5bRjlKZ+h74KAEGR55WRF/EKg==
X-Received: by 2002:a05:6e02:190e:b0:39d:5292:dc9 with SMTP id
 e9e14a558f8ab-39d7284afbcmr70728615ab.5.1724448689837; 
 Fri, 23 Aug 2024 14:31:29 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce7106a1bbsm1101042173.97.2024.08.23.14.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:31:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v3 2/2] Provide some basic scripts for
 Labgrid integration
Date: Fri, 23 Aug 2024 15:31:23 -0600
Message-Id: <20240823213123.487227-3-sjg@chromium.org>
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

With Labgrid we don't need to specify the various methods, except for
the console, which simply calls labgrid-client.

This allows supporting any boards in your lab, without adding per-board
configuration to these hooks.

Provide ellesmere files as an example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update scripts for latest version of Labgrid integration
- Add poweroff.none and poweron.none
- Provide -n flag when querying board info
- Target the grpc version of Labgrid which is now in -master
- Update README to cover the changes

Changes in v2:
- Make use of the common script (only) to set bin_dir

 README.md                    | 37 +++++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 32 +++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++++++
 bin/getrole.labgrid          | 25 +++++++++++++++++++++
 bin/poweroff.none            | 22 +++++++++++++++++++
 bin/poweron.none             | 22 +++++++++++++++++++
 bin/release.labgrid          | 22 +++++++++++++++++++
 bin/release.none             | 22 +++++++++++++++++++
 bin/u-boot-test-getrole      | 38 ++++++++++++++++++++++++++++++++
 bin/u-boot-test-release      | 26 ++++++++++++++++++++++
 11 files changed, 312 insertions(+)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100755 bin/poweroff.none
 create mode 100755 bin/poweron.none
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

diff --git a/README.md b/README.md
index 290e4d0..03895f5 100644
--- a/README.md
+++ b/README.md
@@ -199,6 +199,43 @@ scripts must be replicated once per board instance, or their actions somehow
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
+      export LG_COORDINATOR=kea:20408
+      export LG_ENV="/vid/software/devel/ubtest/lab/env.cfg"
+      export BUILDMAN_PROCESS_LIMIT=1
+      export LG_CONSOLE="internal"
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
index 0000000..a2af8a5
--- /dev/null
+++ b/bin/ellesmere/common-labgrid
@@ -0,0 +1,32 @@
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
+export LG_COORDINATOR=kea:20408
+export LG_ENV="/vid/software/devel/ubtest/lab/cfg/env.cfg"
+export BUILDMAN_PROCESS_LIMIT=1
+export LG_CONSOLE="internal"
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
index 0000000..76cef53
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
+	UBootProviderDriver:board,source_dir,build_dir${config_arg}
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

