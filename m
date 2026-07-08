Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9DEC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7823484AA2;
	Wed,  8 Jul 2026 22:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I/txLnzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AE084A92; Wed,  8 Jul 2026 22:37:40 +0200 (CEST)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BFA5847AF
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543057; x=1783802257;
 bh=epBoxA56Fcj9OCJSMYhPA+72Rs16XiNOVFyEjXRn0pA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=I/txLnzkY4BYdaC2RQmt/ZXWWu/wsGRxskfiSALJe/2pThBC1XV0w2NPhTQHLwu7K
 mG+rI4FD4+qUjZGXl2y9l2voUZuJoxx07MWxpAXLlCs3JL7SALAhibW3u0ifgVi9Jw
 gzVY7MGf58s/8MEG0d0zM1FFleExMul83jSQ7xgCvYowJZx8AQrem/SPW4uysO+/iB
 M++Jehs2cYt9OK09b5GLwA1Cj2ndd0WoTH11Nfjad87nruv6SG3XHAeOayNQW6y2wI
 aPm97NWqn0jcReisBot6s9YNU6E6MdPjiaXJptwoMdjOjaa7CrjXhWNfW2t4wpNE4U
 dugKOW1MWOXxg==
X-Pm-Submission-Id: 4gwVJw3nzJz2ScND
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 09/10] doc: document 'config' command
Date: Wed,  8 Jul 2026 22:37:10 +0200
Message-ID: <20260708203711.849489-10-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
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

Add a little documentation for the config command and its new ability
to filter the output.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 doc/usage/cmd/config.rst | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 doc/usage/cmd/config.rst

diff --git a/doc/usage/cmd/config.rst b/doc/usage/cmd/config.rst
new file mode 100644
index 00000000000..bd8aa65ddbc
--- /dev/null
+++ b/doc/usage/cmd/config.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: config (command)
+
+config command
+==============
+
+Synopsis
+--------
+
+::
+
+    config [<str>]
+
+Description
+-----------
+
+The config command prints the `.config` file used when building U-Boot
+to the console. Note that the `.config` file is usually several 1000
+lines long.
+
+If the optional argument is given, only lines containing that string
+(case insensitively) are printed. That can be useful if one wants to
+check whether a specific option is enabled, or just to limit the
+output to the subsystem of interest.
+
+The `.config` file is stored inside the U-Boot binary in
+gzip-compressed format.
+
+Examples
+--------
+
+.. code-block:: bash
+
+    # Print the entire .config
+    config
+
+    # Print all lines related to pinctrl
+    config pinctrl
-- 
2.55.0

