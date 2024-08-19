Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC0DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 16:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189AD88CC5;
	Mon, 19 Aug 2024 18:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WsBdEpcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A8D88CBF; Mon, 19 Aug 2024 18:26:35 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E080E88AA8
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 18:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7afd1aeac83so3634876a12.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724084791; x=1724689591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dw0UKe0sJZx8xyZ2TMhiyhhu1s6wyqBt0eNwQTd8Hh4=;
 b=WsBdEpcd+sqWFxQuxcdEC86wAf2o1ZIbMkj4AQ17T3yhg/O7uJowyRJEvbmNdkaCsb
 JO4wfUVGvTmIzvCL40r9Y5flUs/WYAGm7Fx2X13wKI29eq+e4Dk3LkPGgdXyVvlY3j7t
 P327+y5fZTok3zgZ6FAABdmZll0FXKVoAQ7u8GkuQWLc4Ki99GHI9ZfyIJLawexlaxSA
 y51whupRCU6i28F+KJD5BiCR9Hqj6Ho+H+9h/v67QGemeZckAI2TQ2ooyeQK8aS4VSgy
 vLLGUIHs2BmfF44Zgf9QzBO6GSXWctGCfsiCVyP4Qa2rknLKbUnex8ZNom+HoZ0cvXDE
 0neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724084791; x=1724689591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dw0UKe0sJZx8xyZ2TMhiyhhu1s6wyqBt0eNwQTd8Hh4=;
 b=b09DT8vuL+ifB/om3t8UA+mIbOjAo/tOHNOten9XKh/Hk0+371n8FOiLeyc88hE2Ob
 15+tspt3xFTTX5FMNOGRQgSl4og/y/rR+BvoPb+N7kHG52md/tK8pvQtdS8rCOhFOmZF
 D7neWlQtzzI4fLnxAJqorm2o4bW3/rYbZBjcKH/kGi9zByl0HbLzdSCSp6CBFBNTAvNy
 NPV8ecbXKzx22CvHdEXik/4RQIM1kUCP8KQyYGKQK/Rj+n/zm2EX66bFNpF5A+OvhGSY
 Gxl0N1jn7G+mT+UU0uibU9RrBZl575CiqO3/344uScSIzM1Ht7m9w3npwnXxYiOvRqxO
 cnXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO57qsBUknUjqh1nzN2Epb2yQARy2CU/QVk1TKdeQTO6st7+olp1TKz3iywm4B912QGEQZoD8u9HeJU/jX+Ffh4t3anw==
X-Gm-Message-State: AOJu0YzQTBhUFfthnG8gXuiqaohhDLSNaB1ueBf55CiTyahjZ/aEkmxz
 qVjlMl1tPMdHyJXZrzo8OEGn7tq/oDcE+NpQUuJIiIbw7Dc5HP/q
X-Google-Smtp-Source: AGHT+IEQqG2gADoZxHQxtUAVRVKCKsBJS0uDMkOiLMCAwD0uk0dmnHGz3mB+M8gnwnxFq97h/3dYrw==
X-Received: by 2002:a17:90a:5d89:b0:2d3:acbd:307b with SMTP id
 98e67ed59e1d1-2d47321cf79mr248823a91.10.1724084790648; 
 Mon, 19 Aug 2024 09:26:30 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2b65b85sm7456675a91.2.2024.08.19.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 09:26:30 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Bo Gan <ganboing@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 John Keeping <jkeeping@inmusicbrands.com>, Jonas Karlman <jonas@kwiboo.se>,
 Shengyu Qu <wiagn233@outlook.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] tools/scripts/Kconfig: Update references from
 kconfig-language.txt to rst
Date: Mon, 19 Aug 2024 13:24:49 -0300
Message-Id: <20240819162449.101449-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Hiago De Franco <hiago.franco@toradex.com>

The Linux kernel documentation has transitioned from using
kconfig-language.txt to kconfig-language.rst. Therefore update all
occurrences of kconfig-language.txt.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 Kconfig                                            |  2 +-
 scripts/kconfig/symbol.c                           |  2 +-
 .../tests/err_recursive_dep/expected_stderr        | 14 +++++++-------
 tools/buildman/kconfiglib.py                       | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Kconfig b/Kconfig
index 82df59f176ec..29c42249a221 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,6 +1,6 @@
 #
 # For a description of the syntax of this configuration file,
-# see the file Documentation/kbuild/kconfig-language.txt in the
+# see the file Documentation/kbuild/kconfig-language.rst in the
 # Linux kernel source tree.
 #
 mainmenu "U-Boot $(UBOOTVERSION) Configuration"
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 703b9b899ee9..5245804bb337 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1117,7 +1117,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 	}
 
 	fprintf(stderr,
-		"For a resolution refer to Documentation/kbuild/kconfig-language.txt\n"
+		"For a resolution refer to Documentation/kbuild/kconfig-language.rst\n"
 		"subsection \"Kconfig recursive dependency limitations\"\n"
 		"\n");
 
diff --git a/scripts/kconfig/tests/err_recursive_dep/expected_stderr b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
index 84679b104655..c9f4abf9a791 100644
--- a/scripts/kconfig/tests/err_recursive_dep/expected_stderr
+++ b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
@@ -1,38 +1,38 @@
 Kconfig:11:error: recursive dependency detected!
 Kconfig:11:	symbol B is selected by B
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:5:error: recursive dependency detected!
 Kconfig:5:	symbol A depends on A
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:17:error: recursive dependency detected!
 Kconfig:17:	symbol C1 depends on C2
 Kconfig:21:	symbol C2 depends on C1
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:32:error: recursive dependency detected!
 Kconfig:32:	symbol D2 is selected by D1
 Kconfig:27:	symbol D1 depends on D2
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:37:error: recursive dependency detected!
 Kconfig:37:	symbol E1 depends on E2
 Kconfig:42:	symbol E2 is implied by E1
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:60:error: recursive dependency detected!
 Kconfig:60:	symbol G depends on G
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
 Kconfig:51:error: recursive dependency detected!
 Kconfig:51:	symbol F2 depends on F1
 Kconfig:49:	symbol F1 default value contains F2
-For a resolution refer to Documentation/kbuild/kconfig-language.txt
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
diff --git a/tools/buildman/kconfiglib.py b/tools/buildman/kconfiglib.py
index b9f37567559a..27abbf9a7a11 100644
--- a/tools/buildman/kconfiglib.py
+++ b/tools/buildman/kconfiglib.py
@@ -6,7 +6,7 @@ Overview
 ========
 
 Kconfiglib is a Python 2/3 library for scripting and extracting information
-from Kconfig (https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt)
+from Kconfig (https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.rst)
 configuration systems.
 
 See the homepage at https://github.com/ulfalizer/Kconfiglib for a longer
@@ -709,7 +709,7 @@ class Kconfig(object):
 
     mainmenu_text:
       The prompt (title) of the top menu (top_node). Defaults to "Main menu".
-      Can be changed with the 'mainmenu' statement (see kconfig-language.txt).
+      Can be changed with the 'mainmenu' statement (see kconfig-language.rst).
 
     variables:
       A dictionary with all preprocessor variables, indexed by name. See the
@@ -3562,7 +3562,7 @@ class Kconfig(object):
         #
         #  - Propagates dependencies from parent to child nodes
         #
-        #  - Creates implicit menus (see kconfig-language.txt)
+        #  - Creates implicit menus (see kconfig-language.rst)
         #
         #  - Removes 'if' nodes
         #
@@ -5030,7 +5030,7 @@ class Choice(object):
 
         0 (n) - The choice is disabled and no symbols can be selected. For
                 visible choices, this mode is only possible for choices with
-                the 'optional' flag set (see kconfig-language.txt).
+                the 'optional' flag set (see kconfig-language.rst).
 
         1 (m) - Any number of choice symbols can be set to m, the rest will
                 be n.
@@ -5498,7 +5498,7 @@ class MenuNode(object):
 
       Choices and menus naturally have children, but Symbols can also have
       children because of menus created automatically from dependencies (see
-      kconfig-language.txt).
+      kconfig-language.rst).
 
     parent:
       The parent menu node. None if there is no parent.
-- 
2.39.2

