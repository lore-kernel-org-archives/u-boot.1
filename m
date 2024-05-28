Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BCC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F719884DC;
	Tue, 28 May 2024 16:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ur/ZE1qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDC3884E1; Tue, 28 May 2024 16:10:56 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EDD87D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-79305314956so64352985a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905452; x=1717510252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZEwdNwjpNENzFRgO5U6hLJD2qYPrnUjuSv8rKmZAeQ=;
 b=ur/ZE1qMg18aX4TT+leR+1Race73+QEzI711WK5M1bpuj+DbT1y1AQmUsoDQ5e7kA+
 S2zQivCxcJx8/EhecwZQSQQO+jULFZw8kUOcrZntguBvYvBQQTfTpgqOske61+j/TIiM
 39W7iUAutial6YVEkvUayns6ZJ+YUuFyYixQfHBCtUzZjZRk8wgns8GKtvoYxq/5V6By
 MWXs3w3DXSDd3VrzniQwpXbJLYkNbJAwDBLl6HNbBxlhqTEmENW7Kh741s+90ckVrS0v
 F/9OcIZckUQY3bBfBB+kCOdfnJwBil6/3hNwKWcrlUr9M1WasRsBZ7L+fX0t82jNSSqL
 WRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905452; x=1717510252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZEwdNwjpNENzFRgO5U6hLJD2qYPrnUjuSv8rKmZAeQ=;
 b=FKgmcGMJbjvjeW4kONVRQ7dW7ZstyMBkkMIKpPq8FHaHc5t+kJAa7z9351kSK5dlvc
 BpWxPrBqwekysjl01sdvLnk4vL19dPj5GAHB7AsGiIo56gmIFM13DkKpOUutG96QJhDl
 QyLc9qsTyvqz8CW5azxIr3J6E69RpZKk7CModTaoRwmdEhURFhTMXA7EZoRV0cCHGeOb
 RW7EErLiELgBi+qLP6bT7pyKMBJ8zd20g04QY37WD7qIBytKbLdGqlbbMKox0TK4IqzV
 ngYkffUw9RXJLeW/x4EJ5N6hMWc20gJUuGwqZWcNoIQKxQihyrWmLLPjzlw8m9GuaN/O
 zdvg==
X-Gm-Message-State: AOJu0YwojkzbEUIy7yXwXv2/4kn/y59G/6YGgQlToiwBR4Fiu5IAyAvF
 9DFs2dEKtikWMIzpJjaiMhgCxOUWhmOv3avu6b8LG/eX0qp4aSeWzUwTb9Th7FfgsdY+rXwcNsI
 1jUs=
X-Google-Smtp-Source: AGHT+IEwOxcEmaGklXVHwgQy1QF+uoGy2A0NaN3R1d8Pxzqd5LSqmWQTk7kOCL7Z7MEbbn9LiT00lg==
X-Received: by 2002:a05:620a:2952:b0:792:9a4b:dcd4 with SMTP id
 af79cd13be357-794ab09e87cmr1461149485a.45.1716905452228; 
 Tue, 28 May 2024 07:10:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:10:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 02/25] mbedtls: Add script to update MbedTLS subtree
Date: Tue, 28 May 2024 07:09:13 -0700
Message-Id: <20240528140955.1960172-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

 lib/mbedtls/update-mbedtls-subtree.sh | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 lib/mbedtls/update-mbedtls-subtree.sh

diff --git a/lib/mbedtls/update-mbedtls-subtree.sh b/lib/mbedtls/update-mbedtls-subtree.sh
new file mode 100755
index 00000000000..f208e54a5af
--- /dev/null
+++ b/lib/mbedtls/update-mbedtls-subtree.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
+# $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
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
+    if ! git remote get-url mbedtls_upstream 2>/dev/null
+    then
+        echo "Warning: Script automatically adds new git remote via:"
+        echo "    git remote add mbedtls_upstream \\"
+        echo "        https://github.com/Mbed-TLS/mbedtls.git"
+        git remote add mbedtls_upstream \
+            https://github.com/Mbed-TLS/mbedtls.git
+    fi
+    git fetch mbedtls_upstream master
+}
+
+if [ "$1" = "pull" ]
+then
+    remote_add_and_fetch
+    git subtree pull --prefix lib/mbedtls/external/mbedtls mbedtls_upstream \
+        "$2" --squash -m "${merge_commit_msg}"
+elif [ "$1" = "pick" ]
+then
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

