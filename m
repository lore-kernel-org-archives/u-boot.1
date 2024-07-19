Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C33C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 14:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8416987DDF;
	Fri, 19 Jul 2024 16:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gdwMv7wC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2713287F51; Fri, 19 Jul 2024 16:17:03 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F0987DC7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 16:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-447f0d20592so8010151cf.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721398619; x=1722003419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tOrVCi+21Lw9YWguBBpbMERDfsg1e7k5FemY7PQrFO0=;
 b=gdwMv7wC1o/DEnhKevhYFsfRNe2WHRhps5uyHfFbLzqOrIsob3AASTc6edvnVQ6PvZ
 EawIG1lAOu0Hsu7AdaW449mHrUkvXaRk5F7Dwf/0gU6Tru75++ZnizJrGo4ZrbtfpELC
 lradXHztXLxHfc2Ijc4gdnCAeZm8IDYjKduA0VVC1KKK4ZmCF0oT82C4M8VvLylJs4jW
 9hHCaIGQsKscjMkw/kE5OANyiWESNt7XFMMsbiXoV161Z4derg6mt0lN5mmnf8FiDQ7x
 B9zacz+PNtJmSi3QW331FU7SXEYXLUXZFi1wKQr8oL2EINO64AAg4+7tHfiAFdmCWmbG
 MS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398619; x=1722003419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOrVCi+21Lw9YWguBBpbMERDfsg1e7k5FemY7PQrFO0=;
 b=lgl6juZmJjuSfH63FA3ZNG4GTA90N3vI0uxURofDHr3KkCoKVHrcHHnCb3OIU+JlXK
 iIIHCtSmujfZmydOxv+eG2Zko/qV07sn7fY9DacGUFof/QmRgwE0l1JtIomdJ7I9h3x6
 hBlmatvhVpx314HhexDz7dQ0ZlGSTfOXl0Rwt97fCKkXXVtLrMNb7KpHL+f2zV0w2W2/
 d6txDFwvtuuC+rhGud/aYnT60/3rv/odeaJfeInnLBTerDGcn9T65ezmrwOUPJs3HjXP
 sk0DwRclYn6cilORjoh39ipCdS//1lYQCtR5RTqsq1kFVL/qVulrgPYbSDCxjVGWPLtt
 0zsQ==
X-Gm-Message-State: AOJu0YzFFQ7YP3dXUe1+654KnWxEfX5fAgeP7cNjFRPlOugPYbRJ123C
 UNlwxoA1ot4a8n05lnvOKSuZoGM9iUeYPC2l1Dymttsj3/UmUB7W+tXSKIL6oVHVs1mP2i/Gk1V
 O
X-Google-Smtp-Source: AGHT+IFp9/t4AfkOMsY6hxMYvPpUG/AEGkxdcJ/77Gf3oup15SKgb1LBZfDCgJfIghuVO3Y7Fx2wmg==
X-Received: by 2002:ac8:5a10:0:b0:44f:a273:1e77 with SMTP id
 d75a77b69052e-44fa2732183mr10355471cf.45.1721398619012; 
 Fri, 19 Jul 2024 07:16:59 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd06244sm7642001cf.34.2024.07.19.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 07:16:58 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, jerome.forissier@linaro.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] tools: Add script to update git subtree projects
Date: Fri, 19 Jul 2024 07:12:43 -0700
Message-Id: <20240719141245.49186-1-raymond.mao@linaro.org>
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
 dts/update-dts-subtree.sh | 48 ----------------------
 tools/update-subtree.sh   | 86 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 48 deletions(-)
 delete mode 100755 dts/update-dts-subtree.sh
 create mode 100755 tools/update-subtree.sh

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
index 00000000000..bf41a31de2b
--- /dev/null
+++ b/tools/update-subtree.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
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
+repo_url_mbedtls="https://github.com/Mbed-TLS/mbedtls.git"
+repo_url_dts="https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
+repo_url_lwip="https://git.savannah.gnu.org/git/lwip.git"
+
+path_mbedtls="lib/mbedtls/external/mbedtls"
+path_dts="dts/upstream"
+path_lwlip="lib/lwip/lwip"
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
+if [ "$subtree_name" = "mbedtls" ]; then
+    repo_url=$repo_url_mbedtls
+    remote_name="mbedtls_upstream"
+    path=$path_mbedtls
+elif [ "$subtree_name" = "dts" ]; then
+    repo_url=$repo_url_dts
+    remote_name="devicetree-rebasing"
+    path=$path_dts
+elif [ "$subtree_name" = "lwip" ]; then
+    repo_url=$repo_url_lwip
+    remote_name="lwip_upstream"
+    path=$path_lwip
+else
+    echo "Invalid subtree name: $subtree_name"
+    print_usage
+    exit 1
+fi
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

