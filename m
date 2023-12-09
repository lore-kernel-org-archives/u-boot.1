Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057EFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8718C870FF;
	Sat,  9 Dec 2023 21:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LfeAaayt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A578717E; Sat,  9 Dec 2023 21:03:09 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 570CA87078
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7DEDD3F736; 
 Sat,  9 Dec 2023 20:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702152186;
 bh=73qI0So8mPu6Rm3FmP+DqTat62pLfG40QdSzUuY/6uw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=LfeAaaytfIIE6TO/gC2j+zuSZFswsPxsMrfWAVFYuLpoFprh1JeeOWg2yKj6HBd3G
 4122Q7pPwHGpRzeKMYzbOthf9SvFvLjO1a1FX+V0zCmv5WmBiYXRTJwyncbBmn8y+2
 gBrz4cDzVZc5CYI4eCIbnoi7i0OPk8pqbnnWcDGJnkpwqGIR7CQGugyFVLwORD06iJ
 36J3y6piqWLtUBUAofIFsEM6DY1uhvHvRRPydAzbm55b1pg3H5jzv/bY3tuhq1pAJo
 Pr71YdkNsY+z12fadQPmm6OMqZ2zJFod3NWoUnCplB8lZXtZJrHNLcCfWQnIngxTNs
 w8qJKbE+jMUbg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] CI: update pylint to recent version
Date: Sat,  9 Dec 2023 21:03:00 +0100
Message-Id: <20231209200300.12272-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

We are missing some Python problems like

   "Using variable 'varname' before assignment"

Switch to a more recent version. Adjust the documentation accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .azure-pipelines.yml      | 2 +-
 .gitlab-ci.yml            | 2 +-
 doc/develop/python_cq.rst | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b9d6aa98a0..93e9df78d1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -151,7 +151,7 @@ stages:
           export USER=azure
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
-          pip install asteval pylint==2.12.2 pyopenssl
+          pip install asteval pylint==2.17.7 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
           echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fbf99f0322..0acac16d82 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -218,7 +218,7 @@ Run pylint:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
-    - pip install asteval pylint==2.12.2 pyopenssl
+    - pip install asteval pylint==2.17.7 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
     - echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
diff --git a/doc/develop/python_cq.rst b/doc/develop/python_cq.rst
index 1e209ff197..48fe055593 100644
--- a/doc/develop/python_cq.rst
+++ b/doc/develop/python_cq.rst
@@ -23,7 +23,7 @@ regressions in any module.
 To run this locally you should use this version of pylint::
 
     # pylint --version
-    pylint 2.11.1
+    pylint 2.17.7
     astroid 2.8.6
     Python 3.8.10 (default, Sep 28 2021, 16:10:42)
     [GCC 9.3.0]
@@ -31,7 +31,7 @@ To run this locally you should use this version of pylint::
 
 You should be able to select and this install other required tools with::
 
-    pip install pylint==2.11.1
+    pip install pylint==2.17.7
     pip install -r test/py/requirements.txt
     pip install asteval pyopenssl
 
-- 
2.40.1

