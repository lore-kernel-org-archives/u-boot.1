Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B1EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D694F864A1;
	Tue, 22 Aug 2023 19:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43781864D0; Tue, 22 Aug 2023 19:40:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0274B864D7
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2207011FB;
 Tue, 22 Aug 2023 10:41:29 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BF103F762;
 Tue, 22 Aug 2023 10:40:45 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 05/15] btool: mkeficapsule: Add a bintool for EFI capsule
 generation
Date: Tue, 22 Aug 2023 23:09:58 +0530
Message-Id: <20230822174008.626239-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

Add a bintool for generating EFI capsules. This calls the mkeficapsule
tool which generates the capsules.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V10: None

 tools/binman/btool/mkeficapsule.py | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 tools/binman/btool/mkeficapsule.py

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
new file mode 100644
index 0000000000..61179747ff
--- /dev/null
+++ b/tools/binman/btool/mkeficapsule.py
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2023 Linaro Limited
+#
+"""Bintool implementation for mkeficapsule tool
+
+mkeficapsule is a tool used for generating EFI capsules.
+
+The following are the commandline options to be provided
+to the tool
+Usage: mkeficapsule [options] <image blob> <output file>
+Options:
+	-g, --guid <guid string>    guid for image blob type
+	-i, --index <index>         update image index
+	-I, --instance <instance>   update hardware instance
+	-v, --fw-version <version>  firmware version
+	-p, --private-key <privkey file>  private key file
+	-c, --certificate <cert file>     signer's certificate file
+	-m, --monotonic-count <count>     monotonic count
+	-d, --dump_sig              dump signature (*.p7)
+	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
+	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
+	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
+	-h, --help                  print a help message
+"""
+
+from binman import bintool
+
+class Bintoolmkeficapsule(bintool.Bintool):
+    """Handles the 'mkeficapsule' tool
+
+    This bintool is used for generating the EFI capsules. The
+    capsule generation parameters can either be specified through
+    commandline, or through a config file.
+    """
+    def __init__(self, name):
+        super().__init__(name, 'mkeficapsule tool for generating capsules')
+
+    def generate_capsule(self, image_index, image_guid, hardware_instance,
+                         payload, output_fname, priv_key, pub_key,
+                         monotonic_count=0, version=0, oemflags=0):
+        """Generate a capsule through commandline-provided parameters
+
+        Args:
+            image_index (int): Unique number for identifying payload image
+            image_guid (str): GUID used for identifying the image
+            hardware_instance (int): Optional unique hardware instance of
+            a device in the system. 0 if not being used
+            payload (str): Path to the input payload image
+            output_fname (str): Path to the output capsule file
+            priv_key (str): Path to the private key
+            pub_key(str): Path to the public key
+            monotonic_count (int): Count used when signing an image
+            version (int): Image version (Optional)
+            oemflags (int): Optional 16 bit OEM flags
+
+        Returns:
+            str: Tool output
+        """
+        args = [
+            f'--index={image_index}',
+            f'--guid={image_guid}',
+            f'--instance={hardware_instance}'
+        ]
+
+        if version:
+            args += [f'--fw-version={version}']
+        if oemflags:
+            args += [f'--capoemflag={oemflags}']
+        if priv_key and pub_key:
+            args += [
+                f'--monotonic-count={monotonic_count}',
+                f'--private-key={priv_key}',
+                f'--certificate={pub_key}'
+            ]
+
+        args += [
+            payload,
+            output_fname
+        ]
+
+        return self.run_cmd(*args)
+
+    def fetch(self, method):
+        """Fetch handler for mkeficapsule
+
+        This builds the tool from source
+
+        Returns:
+            tuple:
+                str: Filename of fetched file to copy to a suitable directory
+                str: Name of temp directory to remove, or None
+        """
+        if method != bintool.FETCH_BUILD:
+            return None
+
+        cmd = ['tools-only_defconfig', 'tools']
+        result = self.build_from_git(
+            'https://source.denx.de/u-boot/u-boot.git',
+            cmd,
+            'tools/mkeficapsule')
+        return result
-- 
2.34.1

