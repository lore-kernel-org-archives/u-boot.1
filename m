Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20F8C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA51588AB2;
	Wed, 17 Jul 2024 16:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NisfttEQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="skaM0BxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E583F88A5D; Wed, 17 Jul 2024 16:31:01 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9235188AC2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C2A971140141;
 Wed, 17 Jul 2024 10:30:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226658;
 x=1721313058; bh=dlh2YR72cK6ntPLeIQxKwfL0WYXvb0V16n47R148+2Q=; b=
 NisfttEQWKX4y76m1AdMVv7b9n0sIPmCZpaCQ8XwO05d7Cdlma2R5q+19l4aZ7eE
 aPYe7wcdVE5LSHAH8SIzniL2eDZolPVolnFD3j0nvP9pQZ5+xsv55u9/tcQOl3ib
 lbCdo5aP8C0dMyHAwDaqjCTJEhE8MPi2xiriZeFt8F+3RhTsPW2rEZz9tlwEiwT/
 6y6bGyVMqpZfM959q0yUWQIE0wKRYRowQiR/WnCvLRczvi9IsOgXXLBoup/cEk9x
 FtUygV0t3dTtkN0OFrcS0NOnZUUoFDR5K8D7FUxBdMllrgzsrF1eQonpK3DobSjE
 1fU0HfK84OFp6eWhG9DAOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226658; x=
 1721313058; bh=dlh2YR72cK6ntPLeIQxKwfL0WYXvb0V16n47R148+2Q=; b=s
 kaM0BxUFg5OFBSSItXaPdHDYTuPtxfzpFue/VhnQ2O4oiKN68l0/0zrJjU2r3XPL
 tLQDJw5FRHep4mrAbPdMsdo4avctV/y2aUC1JA2JIn7iw1FpMvY71735YF48ueu0
 fkQ+sPr1xyxB+QIkyuKOYzw1U8HcUEfUioBfj3sjW5Ld9ZTSV0N0mOZM4K0+MZ6X
 t4Ba0NjOAIUw0FI4fbCWLt9id5txcGncrLf3ttFEr5PmiKdcYYvaYz3qPTWJSPq1
 x8E99kXr1gMZmDRteUoJSmJslGYyqKEQyI1iU9P9ecCsiP7+dTrhgWv4Hzagu6xX
 PUScKPWNWLWlMcw1YTVcg==
X-ME-Sender: <xms:odWXZuhCs7V5wDMzNHcRvnu0dHc6bcK7KxhA8oSrKWHUAv7-Y1P7Gg>
 <xme:odWXZvAIRpEOEQR0NsYKc-ooBSV1A_5jMSUzy5A3sEl85JBBFbZ0ZIgzqx5juMMCK
 Q4Fb8fMXV5P3SM638E>
X-ME-Received: <xmr:odWXZmHGeRunUYckVAu3pu1dCbY6yULklkztVKeq_yh_xT-PCEJ9xThzPk80DT_FrMgC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedtteelvedvueekffelheeuteeiheeuhfevleeuveffffeftdet
 veefhfdvvdetveenucffohhmrghinhepghhhtghrrdhiohdpuggvnhigrdguvgdpghhith
 hhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrd
 gtohhm
X-ME-Proxy: <xmx:odWXZnQJZF-rmhQ3ADTYloGGsy8lVLG4SHzSA1QmFbM6tbKR9hUReA>
 <xmx:odWXZrwCSgkMChhAdvaniXXVPqhlCaOJ-vhgKZAh1kYga-hMiDiq4g>
 <xmx:odWXZl6uLoHKzUCP_R6iLOtus7SiBm3SQfHxQ_hy-Zm1A7yKxiO9Ww>
 <xmx:odWXZoxDzqYY8FFskeU0h6-lyOxOS2p3uuS2sAh3hA1opS1jY9i22A>
 <xmx:otWXZiyvA25ENsnGf20G2Yx6Fn2AwkpWTDvGYaeiyzZ_CKGwqgcwtEuC>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:29 +0800
Subject: [PATCH NFC 18/18] Use Jiaxun's CI Image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-18-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=U6MbzP3XN6kzyZYiseTF6poYJy8Z655u/07KsKK/7Jo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10U058Kbku60Gzgu+JvQ6dh8qJZj/1yJzYVne/Ol
 zuee12oo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYSEczI0LGgOOBK07OS7/3b
 dHcLvMm8P6/J01PWxP7xlvIfrgVz1BkZ9nSYnr/tI/Hsm6bvwvz3ayKsKl6w/zogsCXf5SRLvz0
 bBwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Use Jiaxun's CI Image for demonstration.

NOT FOR COMMIT!

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .azure-pipelines.yml    | 4 ++--
 .gitlab-ci.yml          | 4 ++--
 tools/docker/Dockerfile | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e2346ace3097..e5fa57c3a222 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2019
   ubuntu_vm: ubuntu-22.04
   macos_vm: macOS-12
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
+  ci_runner_image: ghcr.io/flygoat/u-boot-ci-docker:main
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
@@ -242,7 +242,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://github.com/FlyGoat/u-boot-test-hooks.git /tmp/uboot-test-hooks
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b38342117434..570ced808830 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
+image: ghcr.io/flygoat/u-boot-ci-docker:main
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
@@ -26,7 +26,7 @@ stages:
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
-    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+    - git clone --depth=1 https://github.com/FlyGoat/u-boot-test-hooks.git /tmp/uboot-test-hooks
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
     - grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3522c3627af9..bcc7f619f2ec 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -277,9 +277,9 @@ USER uboot:uboot
 
 # Populate the cache for pip to use. Get these via wget as the
 # COPY / ADD directives don't work as we need them to.
-RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/test/py/requirements.txt
-RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
-RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
+RUN wget -O /tmp/pytest-requirements.txt https://gitlab.com/FlyGoat/u-boot/-/raw/b4/docker-image/test/py/requirements.txt
+RUN wget -O /tmp/sphinx-requirements.txt https://gitlab.com/FlyGoat/u-boot/-/raw/b4/docker-image/doc/sphinx/requirements.txt
+RUN wget -O /tmp/buildman-requirements.txt https://gitlab.com/FlyGoat/u-boot/-/raw/b4/docker-image/tools/buildman/requirements.txt
 RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 	. /tmp/venv/bin/activate && \
 	pip install -r /tmp/pytest-requirements.txt \

-- 
2.45.2

