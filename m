Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11897C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F53982162;
	Thu,  8 May 2025 00:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PVKwZOIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DDA8283E; Thu,  8 May 2025 00:11:22 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 025048209C
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-601ad30bc0cso917940eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746655879; x=1747260679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqqPC9CbkTz59aYGcR0jCZzg8c5UP/f/37Gqzukp3pI=;
 b=PVKwZOIeWMsO+ug7jCCWYO4KiG271AIr5iYfXT21DiagUQCjU3OCkwk0S1/0vyNKTi
 2WomE0bkG7jUHnGAwghHLDjtzhHr+9xnwlRQk3ucWu4VqPuUl0xoNK5az5vqjkNV7Qql
 hkCmpS1EoJ1zJw4sV+hc99+X0xcCyv6Wty1K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655879; x=1747260679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqqPC9CbkTz59aYGcR0jCZzg8c5UP/f/37Gqzukp3pI=;
 b=m1c1H3JTUEG+NwP6ffZr4PU938APrkUw1ugm8herDTHoLf71myIy7EIUciNsdnKLOR
 8K5+Tg3AoRIvTTuO8RbTg6TIAyuDvS9pXERHmxok76dkbIgmGZKLvfgV2yyGZqR4Yv5P
 leWv3HfPZSFBSAfoSeKjRnv1TlaI0ZKBAxhTl7qmjtK9tkWXxZXJcrQIPYA0O1rVm9X7
 wbR1R45V/ZJJuSNg23dBsBWEaY9myEoXu89Ethr4CdjR2WABqA9BOoi2QsK+m7Vvvu8Q
 AFxmMDsFLtauHZv+4/lCITE+YW2xA2FQ7GwniJyrqwGj8OLFgFrgtI8BAMX24o69MQwr
 awOw==
X-Gm-Message-State: AOJu0YytYbmu2d44G/PHXb+N8sGqvmNsvK9vyYAbRCGKe2H4mOuh3kkX
 c8F8xq44e4p0WLNc/CzvkCXoGbU2ViB+C/rCrWRH5xkADqGIU6t2qbpAuGlJZnbopV6CbDt+Lw6
 q
X-Gm-Gg: ASbGnctUqWw5mufSRk3saSq+MDSKBZedjrXEHa5ShWjeMy2u6lHwwg1d22/SMHuUmV1
 7tZSP6H/Dg5Iqx63y3puHI5RXmvCh1MQoHRgUEWS9IU10wDToDfYhOo9KG62cKSToe3RncAaqpN
 8uShm9hQ+i09Uu+jtBR73y8njX2tqHiLYck0whvn5WMAUQgOuu2MZeNN7j3dEYAbieSQ9ypwcz/
 7pUMfg58NePMWLYmEYA2hhqzVA6C/DFdEl33K3EPsiL0ruvO783wmIT1cFaQ5hQJ29Qmrf26hS3
 CmANy69isZzyzFJJ2NZhTVhL1dBPMyvMu4t5pEsgmb2rB1jwT3GeFpg0NriDoW+pfsof4g/wP0x
 GMp1d
X-Google-Smtp-Source: AGHT+IHETQ0k+sJ87WAvirzvXSNO849kMaxAODl/ukhIlsZX5UMxhx42+6xzHAVzU4CXRYVd7ATnDA==
X-Received: by 2002:a05:6870:7046:10b0:2d4:d9d6:c8dc with SMTP id
 586e51a60fabf-2db807d5a17mr598679fac.9.1746655878625; 
 Wed, 07 May 2025 15:11:18 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbf16f1sm967181fac.20.2025.05.07.15.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:11:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/4] doc: pytest: Framework for documenting tests and
 document test_000_version
Date: Wed,  7 May 2025 16:08:18 -0600
Message-ID: <20250507221112.518041-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507221112.518041-1-trini@konsulko.com>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
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

In order to easily document pytests, we need to include the autodoc
extension. We also need to make sure that for building the docs, CI
includes pytest and that we have PYTHONPATH configured such that it will
find all of the tests and related files. Finally, we need to have our
comments in the test file by in proper pydoc format in order to be
included in the output.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 .azure-pipelines.yml                    |  2 +-
 .gitlab-ci.yml                          |  2 +-
 Makefile                                |  3 ++-
 doc/conf.py                             |  2 +-
 doc/develop/pytest/index.rst            |  8 ++++++++
 doc/develop/pytest/test_000_version.rst |  8 ++++++++
 test/py/tests/test_000_version.py       | 10 ++++++----
 7 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 doc/develop/pytest/test_000_version.rst

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 5e1938b05262..9c136513bb9e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -92,7 +92,7 @@ stages:
           set -e
           python3 -m venv /tmp/venvhtml
           . /tmp/venvhtml/bin/activate
-          pip install -r doc/sphinx/requirements.txt
+          pip install -r doc/sphinx/requirements.txt pytest
           make htmldocs KDOC_WERROR=1
           make infodocs
 
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f11331514b8..7aadd5d8b735 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ docs:
   script:
     - python3 -m venv /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
-    - pip install -r doc/sphinx/requirements.txt
+    - pip install -r doc/sphinx/requirements.txt pytest
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
diff --git a/Makefile b/Makefile
index 15c7e633b874..bd136a48982a 100644
--- a/Makefile
+++ b/Makefile
@@ -2448,7 +2448,8 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
 	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
 PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS): scripts_basic FORCE
-	$(Q)$(MAKE) $(build)=doc $@
+	$(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
+	$(MAKE) $(build)=doc $@
 
 PHONY += checkstack ubootrelease ubootversion
 
diff --git a/doc/conf.py b/doc/conf.py
index 3cb9b2bb65e5..84d028feda83 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -48,7 +48,7 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
               'kernel_abi', 'kernel_feat', 'sphinx-prompt',
-              'sphinx_reredirects' ]
+              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 435d84fc619f..ca45e157d3be 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -10,3 +10,11 @@ General
    :maxdepth: 1
 
    usage
+
+Individual tests
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   test_000_version
diff --git a/doc/develop/pytest/test_000_version.rst b/doc/develop/pytest/test_000_version.rst
new file mode 100644
index 000000000000..09e9a361729b
--- /dev/null
+++ b/doc/develop/pytest/test_000_version.rst
@@ -0,0 +1,8 @@
+test_000_version
+================
+
+.. automodule:: test_000_version
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_000_version.py b/test/py/tests/test_000_version.py
index b95ceae23465..63d392e956e0 100644
--- a/test/py/tests/test_000_version.py
+++ b/test/py/tests/test_000_version.py
@@ -2,10 +2,12 @@
 # Copyright (c) 2015 Stephen Warren
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
 
-# pytest runs tests the order of their module path, which is related to the
-# filename containing the test. This file is named such that it is sorted
-# first, simply as a very basic sanity check of the functionality of the U-Boot
-# command prompt.
+"""
+pytest runs tests the order of their module path, which is related to the
+filename containing the test. This file is named such that it is sorted
+first, simply as a very basic sanity check of the functionality of the U-Boot
+command prompt.
+"""
 
 def test_version(ubman):
     """Test that the "version" command prints the U-Boot version."""
-- 
2.43.0

