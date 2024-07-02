Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF053C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C0987D0A;
	Tue,  2 Jul 2024 20:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rVu7NC9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A2987C86; Tue,  2 Jul 2024 20:24:59 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884288874F
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-446340c6608so33840511cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944696; x=1720549496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6WwdYlRiyXEUHkDqj0ZB2LeTSqBJNO+5VBwNtWPsrQ=;
 b=rVu7NC9cKkWxUEAWLzZeKnSJV2klrRG1fyqa89ROjKGNgRQgKPt9cgRhdQq731Vnd1
 rwWYUTYFbtt+WYTGE0RqSN2Iii8tGt+GjfV1P6HwVMNk8rAnbKAeTDuZW3OAlEuBZTSB
 NYo6InB9D0UfckBzBjDhqjuegu2HjlnnD9SjYRnuYE/lTPPBmhGPILGFrOWRNOU7YmZp
 vQA6+s5ckd1kS6A4M0Y8aKfhSyP5anamf1euO/U25nwisQLgzKQchZw4LcRl9E0HZHmi
 roiT4QGvDhl7sQulxRd00N3N4TkKJD1YneTiXMgxosFprvtKh65zAYQlDgsLnoUrqzs9
 /zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944696; x=1720549496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6WwdYlRiyXEUHkDqj0ZB2LeTSqBJNO+5VBwNtWPsrQ=;
 b=rCW01gSfh327g0jDIsfE/UvwHHLxp3NV4ClkiYbb8wpgQgn/kd2Y/QjGfYiJ0UAnhH
 8bxyKvMglgDxhYNmurQo0Z/VIQUBzn/6z+dspyvg6HpapKcuWxvra/cfjz4E1jzKlPep
 1GLs6rZQ2yQH9UyMbRdIImZoxWeDYq4nDqGBbtrEmPpo6htfXnqGX5N2xsmCl9GkHXi5
 bO74oQdLghBms/YoXpmi51/zsqB/0pUs9sJrkPRs9dko5sH3ciDZoJnW/CrgVedzAs3u
 82joI+xbQAHpleMxoBN7v+xuzQTOk8hXOGG9Z218O2702a6vXy+J9aQRYYXvfdlkkHxE
 fy2Q==
X-Gm-Message-State: AOJu0YwVR17zaytD+Gjc19Jiu8D5joshQoJ1/ALJLaRlJOo6L+DGaMRR
 /yl8vvGDp6MaCkg0ckYkJwhDqsKKurryCnfZ1msFFKM+qo5xqGdByPS9vuIQa8Cx/xsTraVyega
 Z
X-Google-Smtp-Source: AGHT+IFvSWd5sEEnhC4m/jVemtSDZ0lijGVkq/Ju6EEHt3ATZ8B1MvPr6t7qED9/aF6+SElJYHTY4g==
X-Received: by 2002:ac8:5f82:0:b0:440:51af:2977 with SMTP id
 d75a77b69052e-44662e53925mr120692571cf.59.1719944696221; 
 Tue, 02 Jul 2024 11:24:56 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:24:55 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 02/29] mbedtls: Add script to update MbedTLS subtree
Date: Tue,  2 Jul 2024 11:22:38 -0700
Message-Id: <20240702182325.2904421-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
commands.
Usage from U-Boot top directory, run:

$ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
$ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- Minor fix and move the script into tools dir.

 tools/update-mbedtls-subtree.sh | 47 +++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 tools/update-mbedtls-subtree.sh

diff --git a/tools/update-mbedtls-subtree.sh b/tools/update-mbedtls-subtree.sh
new file mode 100755
index 00000000000..0a98a4d6e82
--- /dev/null
+++ b/tools/update-mbedtls-subtree.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./tools/update-mbedtls-subtree.sh pull <release-tag>
+# $ ./tools/update-mbedtls-subtree.sh pick <commit-id>
+#
+# The script will pull changes from MbedTLS repo into U-Boot
+# as a subtree located as <U-Boot>/lib/mbedtls/external/mbedtls sub-directory.
+# It will automatically create a squash/merge commit listing the commits
+# imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$2' of MbedTLS repo [1] into lib/mbedtls/external/mbedtls
+
+[1] https://github.com/Mbed-TLS/mbedtls.git
+EOF
+)
+
+remote_add_and_fetch() {
+    if [ -z "$(git remote get-url mbedtls_upstream 2>/dev/null)" ]; then
+        echo "Warning: Script automatically adds new git remote via:"
+        echo "    git remote add mbedtls_upstream \\"
+        echo "        https://github.com/Mbed-TLS/mbedtls.git"
+        git remote add mbedtls_upstream \
+            https://github.com/Mbed-TLS/mbedtls.git
+    fi
+    git fetch mbedtls_upstream master
+}
+
+if [ "$1" = 'pull' ]; then
+    remote_add_and_fetch
+    git subtree pull --prefix lib/mbedtls/external/mbedtls mbedtls_upstream \
+        "$2" --squash -m "${merge_commit_msg}"
+elif [ "$1" = 'pick' ]; then
+    remote_add_and_fetch
+    git cherry-pick -x --strategy=subtree \
+        -Xsubtree=lib/mbedtls/external/mbedtls/ "$2"
+else
+    echo "usage: $0 <op> <ref>"
+    echo "  <op>     pull or pick"
+    echo "  <ref>    release tag [pull] or commit id [pick]"
+fi
-- 
2.25.1

