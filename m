Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4434C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B254883A9;
	Tue,  7 May 2024 19:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zBcv/15v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57269883AE; Tue,  7 May 2024 19:52:53 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF42F8836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6969388c36fso16622186d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104369; x=1715709169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hN7/SN/wcO+DLZGmmq/iPYDUB/TVtutVEnQ8MCDP3o=;
 b=zBcv/15vsjkFPh8zpmHb6Ba9f366agRmDDaSwACs1Ph/XjwmjAwa0XhbiCc5g/uVCZ
 e8+YKFUjSedR9wSx6xCgHdJ3j5HRIhGAn4zgfM08iq4zLw+ozeldvzi33cqDE7mB4zaI
 i76T9LuQ66WdE2Fga6Z3FOHNXIdP49nQuD72RYUeLjmp7sCc0oFABnsKN3W+gNtpbtkD
 xSiZG1i3Ff/URRuaC8ceWyPRkk+phXMk0wI1q2usPx2ApECPDJYYG1AvnC3TD+6uXHIi
 XCcalFOo1hsRdnyNpNczZIi9X7k1OQwhvxSlrQvxcpu+vmaJ2xzYiF4SiADFjggM39iR
 9w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104369; x=1715709169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hN7/SN/wcO+DLZGmmq/iPYDUB/TVtutVEnQ8MCDP3o=;
 b=nKT0t2NLn+ioyAiyc60N6x2bRVjd9JFWVE6PVAM/Rbminojm2ERwSQAyJ8ojyFYulx
 qBDw65UQKYHGJFLf7Ar2pZLrgrkrkGxnhdgWnE+0x7gjf48mVX6fm0SZJbjq8aMfcjxb
 sVjJryTg8mzgqaUPEA1G6fga9dniTjoZLglNXLCs9dhzpPA2WWf5Vv7AVlbx262mgyli
 GeiaWL4TAibrum8LqFOr1g+B7cQNwUL+u2HeM6OAXR5GTQSzEGjnmrw+9HeTGCzr50nK
 gjGmf4YYboI7ubjoS7gLTzJMC4uuZXVbxFdDvK9xJY9yd+ZhpwRB34So7OtqzdzvMCfR
 2Yeg==
X-Gm-Message-State: AOJu0YymSEKB/6948mfyHijY7RY+3DgcqMuELuRdH8RPCa7eDv2RvaWK
 f8LWQP9/4twULKXOpWFozDibkA/MHVNyfzuW7ffEymhKTUkC+Ujj6N8W/herVu91r8KJovl7KMO
 V
X-Google-Smtp-Source: AGHT+IFa5UanOCUHQ3rwqbYHh8KRQHBqkdHkewsokLY8r+x0pvjHQ3f9+zPWehl5872WobmIWpqPBg==
X-Received: by 2002:a05:6214:300e:b0:69b:7af:62e2 with SMTP id
 6a1803df08f44-6a151492068mr5453056d6.36.1715104369495; 
 Tue, 07 May 2024 10:52:49 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:52:49 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 02/28] mbedtls: Add script to update MbedTLS subtree
Date: Tue,  7 May 2024 10:50:44 -0700
Message-Id: <20240507175132.1456512-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

