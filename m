Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9360C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 13:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5EA82161;
	Sat,  3 May 2025 15:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ecSOJvQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402D582169; Sat,  3 May 2025 15:32:08 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4758682153
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 15:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-064.46.114.pool.telefonica.de
 [46.114.111.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 13B2C3FAC8; 
 Sat,  3 May 2025 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746279121;
 bh=2gIJRvV0AQN08ZOb9QmFCtF37AZTVkfopY5cLqwu3ow=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ecSOJvQUxrLy4f3z2qaPbUP24nXaJg75wKC5szhKF/N02pnF484gj4WKYVXgwjkia
 qjPPaRkPY841ynBZsoFj5d7EEZJT8pzO2Jd0cKp7J1JIqESSOe1rdxYoynPYWYzY9D
 dzi4gB/O6kTaQ2/bWQUHSCPySgmGXYGsoXdIniX64+rSv6UZE1PhxxqC0h0dSqHMjD
 mZnLjJWrQ81+U/4gnnbrlu3o4d23fYgjtXAryddkL+4fLuh+7s8yZHYSd0Rgjwfjwm
 +NhTCNjefQqduG5VYuRgpOl+8xHagbFGZPfTX4ck5tcLttOoz30TMKZNiPrg+yHmU3
 10xARSZ7UwnHA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] test: allow multiple config options in buildconfigspec
Date: Sat,  3 May 2025 15:31:54 +0200
Message-ID: <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
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

In some cases we have alternative configuration options that supply the
same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.

Allow to specify all of them as arguments for buildconfigspec() and execute
the text if any of these is fulfilled, e.g.

    @pytest.mark.buildconfigspec('net', 'net_lwip')

Update the documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
 test/py/conftest.py        | 10 +++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 217ae447035..7dbed8833bf 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -514,3 +514,27 @@ of the `ubman.config` object, for example
 Build configuration values (from `.config`) may be accessed via the dictionary
 `ubman.config.buildconfig`, with keys equal to the Kconfig variable
 names.
+
+A required configuration setting can be defined via a buildconfigspec()
+annotation. The name of the configuration option is specified in lower case. The
+following annotation for a test requires CONFIG_EFI_LOADER=y:
+
+.. code-block:: python
+
+    @pytest.mark.buildconfigspec('efi_loader')
+
+Sometimes multiple configuration option supply the same functionality. If
+multiple arguments are passed to buildconfigspec(), only one of the
+configuration options needs to be set. The following annotation requires that
+either of CONFIG_NET or CONFIG_NET_LWIP is set:
+
+.. code-block:: python
+
+    @pytest.mark.buildconfigspec('net', 'net lwip')
+
+The notbuildconfigspec() annotation can be used to require a configuration
+option not to be set. The following annotation requires CONFIG_RISCV=n:
+
+.. code-block:: python
+
+    @pytest.mark.notbuildconfigspec('riscv')
diff --git a/test/py/conftest.py b/test/py/conftest.py
index 5aea85647af..6c3ac67979a 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -711,9 +711,13 @@ def setup_buildconfigspec(item):
     """
 
     for options in item.iter_markers('buildconfigspec'):
-        option = options.args[0]
-        if not ubconfig.buildconfig.get('config_' + option.lower(), None):
-            pytest.skip('.config feature "%s" not enabled' % option.lower())
+        nomatch = True
+        for arg in options.args:
+            if ubconfig.buildconfig.get('config_' + arg.lower(), None):
+                nomatch = False
+        if nomatch:
+            argsString = ', '.join(options.args)
+            pytest.skip(f'.config features "{argsString}" not enabled')
     for options in item.iter_markers('notbuildconfigspec'):
         option = options.args[0]
         if ubconfig.buildconfig.get('config_' + option.lower(), None):
-- 
2.48.1

