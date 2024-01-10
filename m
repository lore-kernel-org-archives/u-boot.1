Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3ABC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFA387AEB;
	Wed, 10 Jan 2024 11:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Enu6nRoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE33A87AEB; Wed, 10 Jan 2024 11:37:00 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7890D87AFB
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so18689635ad.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704883016; x=1705487816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzTBFBuuEV3jHwA8W0Ga4EzsnN4VTGx3NOQxj35ln4A=;
 b=Enu6nRoatW1ykBMb0+OoME1YOaI8Eio0Ae0txp67bGJp3JYTjk7PjW35Z1hZrKyK0y
 XWLD+3gsHKnG8Ew4ff7wyE9fj3MiXiFraZ2dlcL/g93bXmsBT4Hy4ADk3h33XlK0yM5x
 ozfEugOwkneREHTl/OTHpcdE4BsPH4WBTPO7J/8IfAJh2MNUMDfIozqLm4PnVNNdy6ES
 bsIB5DDTJPv2r9+wxgJEO7Qsx8BU/oB0oowc2iFnErP1ET4vIYopXSkcsSr0QUYFkB88
 GesqgjwTotyFjTGmuKyWjHxZ0Q5c4ddt3jpaTxzdpvkSMjb00G3ouQd9WKMmJkWWA+ks
 gR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704883016; x=1705487816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzTBFBuuEV3jHwA8W0Ga4EzsnN4VTGx3NOQxj35ln4A=;
 b=BBaLiflFZxTvCO5+1jBlfKEe7C/fTKKzeJbMHcC6gDXiQLL7sfKwcT5AcDVJuYrUi1
 COcAHwpwjXYeRO4hr7dRCKWbu6rQfR4Q4+3FTiH5TRHsOsu1iFRizM/K5izhg5SW9RlY
 Tt2mqLP9QZrvn1s591CYrTshdNPB8N+1Nen4LkjfiNfiyoXqBAzhQHb+zz9I6PKXu0en
 4pBzzmGZJ7Qwpttqpa4R9AqTpA0YiWW19UBXJ/B8urld8TFNtzl6dIOZ1jO3yOcUrV08
 M9MYX5Kegw645znmQlAX/7j7pkwqNxE4Q4Z/2alef55PJJ8tNdZwGUsU3jodtpQJdrlY
 exkg==
X-Gm-Message-State: AOJu0Yy5HPcwwfQFzkUbM06VNXpn7pZkThK+xXoykqhdwAINGOvVmkhz
 z4A0jV57BDukCuoeVxti8G8nZ0dpoWG0VIJ3udiMxX2sLj0=
X-Google-Smtp-Source: AGHT+IF25r576iJdYtL63mGj6GoItMqOOmVtntCBjbG9jPFPF95xZWc9PRQne1NyaaQ7B9a78qAZUw==
X-Received: by 2002:a17:903:22d2:b0:1d5:4b75:f2da with SMTP id
 y18-20020a17090322d200b001d54b75f2damr642425plg.108.1704883016638; 
 Wed, 10 Jan 2024 02:36:56 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:36:56 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 06/11] dts: Add script to uprev dts/upstream subtree
Date: Wed, 10 Jan 2024 16:05:42 +0530
Message-Id: <20240110103547.719757-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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

dts/update-dts-subtree.sh is just a wrapper around git subtree pull
command. Usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh <release-tag>

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- New patch to add script dts/update-dts-subtree.sh as per Rob's comments.

 dts/update-dts-subtree.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 dts/update-dts-subtree.sh

diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
new file mode 100755
index 00000000000..2077094d0d2
--- /dev/null
+++ b/dts/update-dts-subtree.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./dts/update-dts-subtree.sh <release-tag>
+#
+# The script will pull changes from devicetree-rebasing repo into U-Boot
+# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
+# automatically create a squash/merge commit listing the commits imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$1' of devicetree-rebasing repo [1] into dts/upstream
+
+[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
+EOF
+)
+
+git subtree pull --prefix dts/upstream \
+    git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
+    $1 --squash -m "${merge_commit_msg}"
-- 
2.34.1

