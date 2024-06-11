Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF95C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FD18882D;
	Tue, 11 Jun 2024 23:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="3yrTQHJX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qq0VB47q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639458839F; Tue, 11 Jun 2024 23:05:06 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041F98881B
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id F12001C00145;
 Tue, 11 Jun 2024 17:05:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 11 Jun 2024 17:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139901;
 x=1718226301; bh=5lPo0BVoIQ/fIdXe6LD0hyY3QgagQOa2O5XxI5EMSE8=; b=
 3yrTQHJXWP8KkEKv2/zYbgOqmg+rci2DSSIFLKPesgtA2UVdWqTd0kaZXKpPgMlD
 HYtIJbKpFPEgpPJNrptWOakFr0pEbseThIx83x/pXChsi9mpwPIHvEm+wjnZ3Mw1
 aOmxqdOsyIYOVTPOSzX+AVAcWPRCqhcUQUFeNscaBhS3iFyvzsPExcPF/jzKGXBK
 h8fPMzkjSGBqLsqFBRgb8NcjuhkLuinxvBogQOfV2Mf82IMw6fI4gGgl0Xgk7aty
 H+rsmea7fVEzcF2DXS4xFu/XfR2ejoT7++cDahRjOef6JtLr8cXjvF/m6wcAbPYK
 v7xieMCNqXSdQByqg36ocQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139901; x=
 1718226301; bh=5lPo0BVoIQ/fIdXe6LD0hyY3QgagQOa2O5XxI5EMSE8=; b=Q
 q0VB47qBRoZJ3rrsrvxe/+VXqjsU+kQmYTaXQb6MjfP+8IsWt76rHrAE+iIvXkqN
 AWUXiV93/pnq/DGB++EwVdk/t9D+cLoNGES+bwQseAVdr/wqWjCBTBpbEgPilfDs
 9C6gBnrP2bK1y0cXZq1PSpngEpdUZ2UCvDSPPTLtSy8Q33NZ41Lk4v7EHYsnomzb
 hdgO9xoO0dlvYrt/cnd2MtJPr7z804YaIqRg3gjwibefVEhWcxrY56oNlb/4rFVu
 EmkgrD6SQjJdCzxcTiel5xNq4jmD6Tjy/Y1GZIbI6skCWE/g+vm5imFM/lwHGFuo
 rCiQdSf2Fme/qs7ImfZUQ==
X-ME-Sender: <xms:_btoZnN55awv4NbN7_2uj9Iqsjk5tUUjuzxnjS6jf20BybbKH8Axmg>
 <xme:_btoZh8kzMCXpq_NYbWo2TIG3lisnIhmGDaUuzcI-UphH1pC4lIdDJ3X1W2ox3rkF
 pPIZ4RZ4-SY24GhRoI>
X-ME-Received: <xmr:_btoZmSTU6UQ4_8utMJBSVdkaVMKOMVim52CUO5lMb6fBN_tL07xfc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedtteelvedvueekffelheeuteeiheeuhfevleeuveffffef
 tdetveefhfdvvdetveenucffohhmrghinhepghhhtghrrdhiohdpuggvnhigrdguvgdpgh
 hithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorg
 htrdgtohhm
X-ME-Proxy: <xmx:_btoZrsFFViZl0x1pj40uZAw1QVrew8aYIQIwQ0jLMV79xQrAkQyGg>
 <xmx:_btoZvc2wRKYdhz9Kr11eSfmZMJW3m0uYvYHN8IKuy-hdnsk32kB1Q>
 <xmx:_btoZn3tQPLaR-gqUZ_TaOgJ6-Wdi9AR0ZO_4Pe_Gy7TdumX4o4_Fg>
 <xmx:_btoZr_93EL6u2Lp6Xe6vuIRYZKbvYs74VoeIpAmgKdIpS88edMYZw>
 <xmx:_btoZuwcXiI_WEquENy0VnowIJyCkOl1_i1_sgWhjpT1C8vU-t2Swllr>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:05:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:18 +0100
Subject: [PATCH NFC 19/20] Use Jiaxun's CI Image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-19-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CscFxw2fOkoha2XT2YLbOktZMv6lZYYU6z+5EQtqr58=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3ecKzdjTw0/cu6V8KO5J1K+5V5mvS0xRvzS7NDWjt
 9rgS0BVRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkeg/DP4PMaIbog4kHu2et
 aVyxgidi67R4AdsNM5Q7rI1u7z0xxZXhf3B/a+WMs9tuZ0+u9nvuOVn8VJH/Pes754OXvD6w8V3
 3Cl4A
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
index 2506814725e1..494c7edaf549 100644
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
@@ -203,7 +203,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://github.com/FlyGoat/u-boot-test-hooks.git /tmp/uboot-test-hooks
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index efb84c3b119f..5b61b5780a32 100644
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
index 26b0e36fec05..3f1bbfce669e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -276,9 +276,9 @@ USER uboot:uboot
 
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
2.43.0

