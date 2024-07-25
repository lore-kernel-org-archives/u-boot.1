Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B812DC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438F887876;
	Thu, 25 Jul 2024 15:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ITAO9Zxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FE187C86; Thu, 25 Jul 2024 15:58:11 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396CC86463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5cebd3bd468so586576eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721915888; x=1722520688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4/QPW28ZqL/GVVCRZ+73W37VzyZrSloP5KbYh7vxNyM=;
 b=ITAO9Zxf6fUkoaV9XwAElP4DEjNEEi4JbAwmCchvzEjV7/3+Rgi6wEeMUSJEimpkw/
 zLIe8kAVtBFYbipkgTDKFsUKbnvA6Hjx/qRSUx2ZKPwm3P94T9sBntqrjbwLb2ROLNnn
 0CpnKbEScmieJ42cd/rpHRW3yM8oNskdZOp4RqBS+WdjxxSOX8T5GTFSCwF/kqUCXY/z
 2AZwejdjrqQ7OzfaoqxtjgwHIZOpJWiEGD8J7kp837XsvnJjzGE9toY5nMrTIP3XDq4Z
 bFEKDaIXJvtAK1tyKuFsJG3BwzAL0DM1s0DFh07FwwDjlcHx0/qk6EfyJZZzzLu0kbkT
 qVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915888; x=1722520688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/QPW28ZqL/GVVCRZ+73W37VzyZrSloP5KbYh7vxNyM=;
 b=L3e0z2RryTKdTH99kxpvlBdbTNldiNdFZzHMBNCXfcQwpztehQjkeE2MA6RDtZ7m8g
 YPQrwTLFTGVklEYYaDnOof/ES6PqFsXUnjQmX9SYxSmhezgMBhLFklgZyobVG0bT6uE/
 dQGOHD7Qytg+SNHzQhYoAM+SUp4oNXGAQ99We9zu4oqfYwM709RIscYqH2JALcG4X2xi
 rfR1aH3hbxMVMYtSPeMVW35c/jYxScouRTJ7CcIS5yb9RV89MFpEEGUIriYKovt0rb85
 7mrEjSJFw0nlFVBQJoDWjUnhh+MF3PjdtME6QHMzlh7uAMBguMwG4IxvdPZseU37UXNb
 UvhA==
X-Gm-Message-State: AOJu0Yw+l0noIIsS4MaVEOi8D9GtuxGnvt2vaKQ76AJ9ega76ojDs2RE
 c2OxSgqMnXbkD2bUkzf62ITKbHDwsu/vc89UHD7rHrZi5cfPFDXdAt0o15klmk++fXzo1r8vIUS
 rYRQ=
X-Google-Smtp-Source: AGHT+IHCHSpr+kgEDnV7HFl5NwyCXHMmIm0fkMfMdMrBYu9zgc72OjY4kwbYR5/GW5mTejYFwF4XeA==
X-Received: by 2002:a05:6358:618c:b0:1aa:c71e:2b37 with SMTP id
 e5c5f4694b2df-1acfb9875acmr264231955d.21.1721915887589; 
 Thu, 25 Jul 2024 06:58:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73e7dd5sm84616085a.57.2024.07.25.06.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, jerome.forissier@linaro.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v3] tools: Add script to update git subtree projects
Date: Thu, 25 Jul 2024 06:57:51 -0700
Message-Id: <20240725135754.1215368-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Recently we are introducing multiple git subtree projects and
it is the right time to have a universal script to update
various subtrees and replace the dts/update-dts-subtree.sh.

update-subtree.sh is a wrapper of git subtree commands.

Usage: From U-Boot top directory,
run
$ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
for pulling a tag from the upstream.
Or run
$ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
for cherry-pick a commit from the upstream.

Currently <subtree-name> supports dts, mbedtls and lwip.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactored the script.
- Update the control doc.
Changes in v3
- Remove authorship from the file header.

 doc/develop/devicetree/control.rst |  8 +--
 dts/update-dts-subtree.sh          | 48 -----------------
 tools/update-subtree.sh            | 85 ++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 52 deletions(-)
 delete mode 100755 dts/update-dts-subtree.sh
 create mode 100755 tools/update-subtree.sh

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index ca4fb0b5b10..211f7e4909c 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
 the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
 Linux kernel release. To sync the `dts/upstream/` subtree, run::
 
-    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
+    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
 
 If required it is also possible to cherry-pick fixes from the
 devicetree-rebasing repository prior to next sync, usage::
 
-    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
+    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
 
 
 Configuration
@@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received devicetree source file for your
 newly added board support then one option is that you can add the corresponding
 devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
 CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
-prompted by Kconfig. Another option is that you can use use the "pick" option of
-`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
+prompted by Kconfig. Another option is that you can use the "pick" option of
+`tools/update-subtree.sh` mentioned above to bring in the commits that you
 need.
 
 This should include your CPU or SoC's devicetree file. On top of that any U-Boot
diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
deleted file mode 100755
index a57b78a41d3..00000000000
--- a/dts/update-dts-subtree.sh
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright 2024 Linaro Ltd.
-#
-# Usage: from the top level U-Boot source tree, run:
-# $ ./dts/update-dts-subtree.sh pull <release-tag>
-# $ ./dts/update-dts-subtree.sh pick <commit-id>
-#
-# The script will pull changes from devicetree-rebasing repo into U-Boot
-# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
-# automatically create a squash/merge commit listing the commits imported.
-
-set -e
-
-merge_commit_msg=$(cat << EOF
-Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
-
-[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
-EOF
-)
-
-remote_add_and_fetch() {
-    if ! git remote get-url devicetree-rebasing 2>/dev/null
-    then
-        echo "Warning: Script automatically adds new git remote via:"
-        echo "    git remote add devicetree-rebasing \\"
-        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
-        git remote add devicetree-rebasing \
-            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
-    fi
-    git fetch devicetree-rebasing master
-}
-
-if [ "$1" = "pull" ]
-then
-    remote_add_and_fetch
-    git subtree pull --prefix dts/upstream devicetree-rebasing \
-        "$2" --squash -m "${merge_commit_msg}"
-elif [ "$1" = "pick" ]
-then
-    remote_add_and_fetch
-    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
-else
-    echo "usage: $0 <op> <ref>"
-    echo "  <op>     pull or pick"
-    echo "  <ref>    release tag [pull] or commit id [pick]"
-fi
diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
new file mode 100755
index 00000000000..536b3318573
--- /dev/null
+++ b/tools/update-subtree.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024 Linaro Limited
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
+# Or:
+# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
+#
+# The script will pull changes from subtree repo into U-Boot.
+# It will automatically create a squash/merge commit listing the commits
+# imported.
+
+set -e
+
+print_usage() {
+    echo "usage: $0 <op> <subtree-name> <ref>"
+    echo "  <op>           pull or pick"
+    echo "  <subtree-name> mbedtls or dts or lwip"
+    echo "  <ref>          release tag [pull] or commit id [pick]"
+}
+
+if [ $# -ne 3 ]; then
+    print_usage
+    exit 1
+fi
+
+op=$1
+subtree_name=$2
+ref=$3
+
+set_params() {
+    case "$subtree_name" in
+        mbedtls)
+            path=lib/mbedtls/external/mbedtls
+            repo_url=https://github.com/Mbed-TLS/mbedtls.git
+            remote_name="mbedtls_upstream"
+            ;;
+        dts)
+            path=dts/upstream
+            repo_url=https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
+            remote_name="devicetree-rebasing"
+            ;;
+        lwip)
+            path=lib/lwip/lwip
+            repo_url=https://git.savannah.gnu.org/git/lwip.git
+            remote_name="lwip_upstream"
+            ;;
+        *)
+            echo "Invalid subtree name: $subtree_name"
+            print_usage
+            exit 1
+    esac
+}
+
+set_params
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$ref' of $subtree_name repo [1] into $path
+
+[1] $repo_url
+EOF
+)
+
+remote_add_and_fetch() {
+    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
+        echo "Warning: Script automatically adds new git remote via:"
+        echo "    git remote add $remote_name \\"
+        echo "        $repo_url"
+        git remote add $remote_name $repo_url
+    fi
+    git fetch $remote_name master
+}
+
+if [ "$op" = "pull" ]; then
+    remote_add_and_fetch
+    git subtree pull --prefix $path $remote_name "$ref" --squash -m "$merge_commit_msg"
+elif [ "$op" = "pick" ]; then
+    remote_add_and_fetch
+    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
+else
+    print_usage
+    exit 1
+fi
-- 
2.25.1

