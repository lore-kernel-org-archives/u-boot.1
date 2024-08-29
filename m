Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1D7C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E793988D12;
	Thu, 29 Aug 2024 20:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tNreQY/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B3988D1A; Thu, 29 Aug 2024 20:56:26 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A9988C60
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a80f0c4a92so12197485a.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724957783; x=1725562583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+wRraymgQondOKBSxEMImsNs3rJiBqdGxUA6toifBxA=;
 b=tNreQY/bzVCDLiwft7LoPO0rNTvPUjoPAes0T4ooOndYFokPLu0jNM6L1xr9iT9tYO
 RkmGpbaH4vbTqC34LmeZ4rvRzpQ6O1uAoRVDUpu1FvYNBk0vKmpE1PQpMoIOum2OWMN2
 KAb69ocTi+JPkLko4m5lpxVoJ2ojWEnszjcXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724957783; x=1725562583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wRraymgQondOKBSxEMImsNs3rJiBqdGxUA6toifBxA=;
 b=b1ONkGsKhpB6DFYCxlu0rqZsCLQRoguVoX1KCGTE5ejrg2X7WDgYo43KW5qhIVPcQ0
 wUVLWnlbFWMjJ+AD0oojrLCq+DJHzL760BkMS8VUrUYd3Th1jQI0Jpmv0vAeu/TNRYLu
 Yy633zI5QyePOpFWyUMdYDUcqhyAjX9773XPF94XfO1qYCr8a8IGTvsZBFF9fQHVD/TZ
 SnzyTOoMlEBODBpChADJsrjRaFpl5FQJEiUSdHkqJNcW+OymacBcQJ0ZAxqhVlZtnWTQ
 Qk4ejKjQMaLGb6nO+TF/WoxaqWBvMpXxjvGr/x4fcWX9dh0IbdQ9ztmZ+BWQbZ1x4pZ7
 7SwQ==
X-Gm-Message-State: AOJu0YyAlekT5QeQLUoK0e0n9F9oLI0V2YAG7exK8MyXYuZJCrl2vXL6
 zu35F1n+P2m0wJVNIM45LNJ9lFWX3jtIWVHtIGUE1uOtrWpvr58hn8/J7MIjbwGEwF36/uCz8iB
 o
X-Google-Smtp-Source: AGHT+IG8HvE02ojWnoiv9pQMooLy57UsyduXxANXkv66KxHl8Wd0aB3i1lKGauCG0u3PNOrDSQvUfg==
X-Received: by 2002:a05:620a:390c:b0:79f:1915:5b3a with SMTP id
 af79cd13be357-7a8041d8d40mr357163485a.38.1724957782645; 
 Thu, 29 Aug 2024 11:56:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d61cb0sm76230085a.119.2024.08.29.11.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 11:56:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Edi Feschiyan <edi.feschiyan@konsulko.com>
Subject: [u-boot-test-hooks][PATCH] labgrid: Add wrapper scripts around using
 labgrid-client for device control
Date: Thu, 29 Aug 2024 12:56:20 -0600
Message-Id: <20240829185620.3179866-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Edi Feschiyan <edi.feschiyan@konsulko.com>

General usage for these hooks is documented in the README.md file. In
terms of implementation, To start with, we add a common file to ensure
that all required environment variables are set. Next, we add a console
script which calls labgrid-console. We also add a reset script that
behaves similarly. For writing files a wrapper around using
labgrid-client sd-mux is provided and then both Raspberry Pi an TI K3
platforms have writers provided. Sample board conf files can be found in
the bin/konsulko-labgrid directory.

Co-developed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Edi Feschiyan <edi.feschiyan@konsulko.com>
---
 README.md                                     | 13 ++++++
 bin/common.labgrid                            | 35 ++++++++++++++
 bin/console.labgrid                           | 24 ++++++++++
 bin/flash.labgrid.sd-mux                      | 31 +++++++++++++
 .../conf.am62x_beagleplay_a53_na              | 30 ++++++++++++
 bin/konsulko-labgrid/conf.am64x_evm_a53_na    | 30 ++++++++++++
 bin/konsulko-labgrid/conf.rpi_4_32b_na        |  1 +
 bin/konsulko-labgrid/conf.rpi_4_na            |  1 +
 bin/konsulko-labgrid/conf.rpi_arm64_na        | 25 ++++++++++
 bin/reset.labgrid                             | 24 ++++++++++
 bin/writer.labgrid.rpi                        | 46 +++++++++++++++++++
 bin/writer.labgrid.ti-k3                      | 35 ++++++++++++++
 12 files changed, 295 insertions(+)
 create mode 100644 bin/common.labgrid
 create mode 100755 bin/console.labgrid
 create mode 100644 bin/flash.labgrid.sd-mux
 create mode 100644 bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
 create mode 100644 bin/konsulko-labgrid/conf.am64x_evm_a53_na
 create mode 120000 bin/konsulko-labgrid/conf.rpi_4_32b_na
 create mode 120000 bin/konsulko-labgrid/conf.rpi_4_na
 create mode 100644 bin/konsulko-labgrid/conf.rpi_arm64_na
 create mode 100755 bin/reset.labgrid
 create mode 100644 bin/writer.labgrid.rpi
 create mode 100644 bin/writer.labgrid.ti-k3

diff --git a/README.md b/README.md
index 290e4d017b9d..bb836f4a20be 100644
--- a/README.md
+++ b/README.md
@@ -218,6 +218,19 @@ of which must be specified in the board configuration files:
 U-Boot's test framework also requires a `dfu-util` that supports the -p
 command-line option. Most distros provide this nowadays.
 
+# Labgrid support
+
+It is possible to use labgrid to manage the hardware and use hooks provided
+here to run the tests. In order for this to work, the following environment
+variables must be set as per your lab:
+
+- `LG_CROSSBAR` must point at the crossbar service.
+- `LG_PLACE` must point at the device under test.
+- `LG_ENV` must point at the labgrid yaml file that describes your lab.
+
+In order for a given platform to be tested, it must be acquired before starting
+tests and then released once complete.
+
 # Python Modules
 
 See the `py/` directory in this repository.
diff --git a/bin/common.labgrid b/bin/common.labgrid
new file mode 100644
index 000000000000..e07107462a5e
--- /dev/null
+++ b/bin/common.labgrid
@@ -0,0 +1,35 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+if [ -z "${LG_CROSSBAR}" ]; then
+	echo "LG_CROSSBAR is unset";
+	exit 1;
+fi
+
+if [ -z "${LG_PLACE}" ]; then
+	echo "LG_PLACE is unset";
+	exit 1;
+fi
+
+if [ -z "${LG_ENV}" ]; then
+	echo "LG_ENV is unset";
+	exit 1;
+fi
diff --git a/bin/console.labgrid b/bin/console.labgrid
new file mode 100755
index 000000000000..ac5d6a7c2620
--- /dev/null
+++ b/bin/console.labgrid
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+. common.labgrid
+
+exec labgrid-client console
diff --git a/bin/flash.labgrid.sd-mux b/bin/flash.labgrid.sd-mux
new file mode 100644
index 000000000000..0dacf7d6dfd9
--- /dev/null
+++ b/bin/flash.labgrid.sd-mux
@@ -0,0 +1,31 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+. common.labgrid
+
+echo "switching sd-mux to host"
+labgrid-client sd-mux host
+#let mmc have some time to initialize to be available for udisks
+sleep 1
+. writer.${flash_writer}
+
+echo "switching sd-mux to dut"
+labgrid-client sd-mux dut
diff --git a/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na b/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
new file mode 100644
index 000000000000..271cb19325df
--- /dev/null
+++ b/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# List the files to copy
+tispl=tispl.bin_unsigned
+uboot=u-boot.img_unsigned
+tiboot3=tiboot3-am62x-gp-evm.bin
+
+# Use labgrid
+console_impl=labgrid
+reset_impl=labgrid
+flash_impl=labgrid.sd-mux
+flash_writer=labgrid.ti-k3
diff --git a/bin/konsulko-labgrid/conf.am64x_evm_a53_na b/bin/konsulko-labgrid/conf.am64x_evm_a53_na
new file mode 100644
index 000000000000..fbc6b9b61fb4
--- /dev/null
+++ b/bin/konsulko-labgrid/conf.am64x_evm_a53_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# List the files to copy
+tispl=tispl.bin_unsigned
+uboot=u-boot.img_unsigned
+tiboot3=tiboot3-am64x-gp-evm.bin
+
+# Use labgrid
+console_impl=labgrid
+reset_impl=labgrid
+flash_impl=labgrid.sd-mux
+flash_writer=labgrid.ti-k3
diff --git a/bin/konsulko-labgrid/conf.rpi_4_32b_na b/bin/konsulko-labgrid/conf.rpi_4_32b_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/konsulko-labgrid/conf.rpi_4_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/konsulko-labgrid/conf.rpi_4_na b/bin/konsulko-labgrid/conf.rpi_4_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/konsulko-labgrid/conf.rpi_4_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/konsulko-labgrid/conf.rpi_arm64_na b/bin/konsulko-labgrid/conf.rpi_arm64_na
new file mode 100644
index 000000000000..a65f078ac6e2
--- /dev/null
+++ b/bin/konsulko-labgrid/conf.rpi_arm64_na
@@ -0,0 +1,25 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Use labgrid
+console_impl=labgrid
+reset_impl=labgrid
+flash_impl=labgrid.sd-mux
+flash_writer=labgrid.rpi
diff --git a/bin/reset.labgrid b/bin/reset.labgrid
new file mode 100755
index 000000000000..1f6912ebb2b3
--- /dev/null
+++ b/bin/reset.labgrid
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+. common.labgrid
+
+exec labgrid-client power cycle
diff --git a/bin/writer.labgrid.rpi b/bin/writer.labgrid.rpi
new file mode 100644
index 000000000000..73f1d589ed9f
--- /dev/null
+++ b/bin/writer.labgrid.rpi
@@ -0,0 +1,46 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+. common.labgrid
+set -e
+
+build=${U_BOOT_BUILD_DIR}
+configtxt=`mktemp`
+
+echo "enable_uart=1" | tee ${configtxt}
+echo "kernel=u-boot.bin" | tee -a ${configtxt}
+
+case "${board_type}" in
+rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
+    echo "arm_64bit=1" | tee -a ${configtxt}
+    ;;
+esac
+
+case "${board_ident}" in
+3-32-pl011)
+    echo "dtoverlay=pi3-miniuart-bt" | sudo tee -a ${configtxt}
+    ;;
+esac
+
+labgrid-client write-files -T ${configtxt} config.txt
+labgrid-client write-files -T ${build}/u-boot.bin u-boot.bin
+rm ${configtxt}
+echo "Done writing build"
diff --git a/bin/writer.labgrid.ti-k3 b/bin/writer.labgrid.ti-k3
new file mode 100644
index 000000000000..0210eeeda46e
--- /dev/null
+++ b/bin/writer.labgrid.ti-k3
@@ -0,0 +1,35 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
+# Ensure we have all environment variables set
+. common.labgrid
+
+build=${U_BOOT_BUILD_DIR}
+
+if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
+    echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
+    echo "per the board documentation."
+    exit 1
+fi
+echo "Writing build at ${build}"
+labgrid-client write-files -T ${build}/${tispl} tispl.bin
+labgrid-client write-files -T ${build}/${uboot} u-boot.img
+labgrid-client write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
+echo "Done writing build"
-- 
2.34.1

