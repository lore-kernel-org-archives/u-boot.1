Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D07C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B8D880B6;
	Thu, 22 Feb 2024 12:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zg1hU+WC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527B587663; Thu, 22 Feb 2024 10:37:29 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DF188076
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcd94fb9e4dso1819307276.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594641; x=1709199441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0eINnUSle7kphQXYYJjZQ3WtQtSVqGbbOBtJCnAd90=;
 b=Zg1hU+WCK0aDVabznVxXXaiWMTtaJTfQ5CdJ9+na3AcJYL1LPx2x7OOn2xvtzDM29U
 BA6W823wZLlhAKEZiMZfxUhyaxkMVr//OkkgXLpD85JNVri7UV4BMW9AujD+ti7tnT3l
 5RcJcUBbYRD2HIvA8o50yskP4hm8fVLsIOYK8ejvIDyTIdzUwE5QIX86wEnpvH4Z2IKJ
 kFSQF0xJMxtr2fMq4uhGizWfK0M9m1UdXzsqaPsgXdNDSebn6SH96KkYt0/tCGMRuiPU
 EI+ok8cRUtByNBNuFGzDqiVyZ8ktv6TwlVO14C3RSmhATpbPECqzaDt8Skfk+xhxhmaJ
 ijlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594641; x=1709199441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0eINnUSle7kphQXYYJjZQ3WtQtSVqGbbOBtJCnAd90=;
 b=G36RGUJbDJXmL/CmOUANXJA2HqaQBOU83bDDdS0Mt2mkfdyk6KD9I7zu8JWlQIMWHU
 +9qJfn05YZwCg7IzjKnJ4OkT4c7AIuhwVXGI8AONA4bDpsuMtWH/XNra9ea+ktEOH+5s
 qt45g6i4KAMIdR+QGhhnzUZmhsYwTcIjH9FmjH5RVy2KsQHvzFr25jqkzbhSDi9YR6py
 Upp4Nrb0ofvu14C3L4K//cKEhnMMSvComIXJtiicjwG+3vQIA5QaOfZlDdyKf+oNd0tc
 mk86khSzPWw/rk5A+S+8G4uVzCwBG2SSRhOh14TDGQ6TDIz0uqkCxTFVN7uC/n0hN294
 P1lA==
X-Gm-Message-State: AOJu0YwMI57ugfi2FkzCGwIGHJYbeE0Queb+E9otYL4kRZEJ5mgXwtWd
 9arrCtMUTHV/965c0DlvUCU3iLhJcvqeDPWy+Vw/vjY6vtQghwtZbLldByy+xPt4QRNubTMab8u
 s
X-Google-Smtp-Source: AGHT+IEweK2J/tELagfFflo8hp0PFQw00OrWlIRqkKjUl/PIJ0evxnd7tl9l4oweJIoKkFazd5J02A==
X-Received: by 2002:a25:b946:0:b0:dcb:d0cb:651d with SMTP id
 s6-20020a25b946000000b00dcbd0cb651dmr1976527ybm.17.1708594641055; 
 Thu, 22 Feb 2024 01:37:21 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:37:20 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 06/11] dts: Add script to uprev dts/upstream subtree
Date: Thu, 22 Feb 2024 15:06:02 +0530
Message-Id: <20240222093607.3085545-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
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

dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
Usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh pull <release-tag>
$ ./dts/update-dts-subtree.sh pick <commit-id>

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- Incorporate shell script comments from Marek.

Changes in v5:
- Added support to cherry-pick fixes in subtree update script. Also, used
  https:// instead of git://.

Changes in v4:
- New patch to add script dts/update-dts-subtree.sh as per Rob's comments.

 dts/update-dts-subtree.sh | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 dts/update-dts-subtree.sh

diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
new file mode 100755
index 000000000000..a57b78a41d34
--- /dev/null
+++ b/dts/update-dts-subtree.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./dts/update-dts-subtree.sh pull <release-tag>
+# $ ./dts/update-dts-subtree.sh pick <commit-id>
+#
+# The script will pull changes from devicetree-rebasing repo into U-Boot
+# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
+# automatically create a squash/merge commit listing the commits imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
+
+[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
+EOF
+)
+
+remote_add_and_fetch() {
+    if ! git remote get-url devicetree-rebasing 2>/dev/null
+    then
+        echo "Warning: Script automatically adds new git remote via:"
+        echo "    git remote add devicetree-rebasing \\"
+        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
+        git remote add devicetree-rebasing \
+            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
+    fi
+    git fetch devicetree-rebasing master
+}
+
+if [ "$1" = "pull" ]
+then
+    remote_add_and_fetch
+    git subtree pull --prefix dts/upstream devicetree-rebasing \
+        "$2" --squash -m "${merge_commit_msg}"
+elif [ "$1" = "pick" ]
+then
+    remote_add_and_fetch
+    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
+else
+    echo "usage: $0 <op> <ref>"
+    echo "  <op>     pull or pick"
+    echo "  <ref>    release tag [pull] or commit id [pick]"
+fi
-- 
2.34.1

