Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720ACC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEB3877F8;
	Sun, 14 Jan 2024 19:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QetI6oaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B7C878D0; Sun, 14 Jan 2024 19:58:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CC886EF1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 82C67413D3; 
 Sun, 14 Jan 2024 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705258730;
 bh=flNlCqvIq9llFsHMEeVoP21daiaMxoKNsRckUAW3XT8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QetI6oaRvPmhGoiG5ES1S75M9YwniLrlIoujsgD0QOJ7gZEQmydo43TBkCaxeKv98
 HrY99Iza0NDFfitXymph98yWdhi1Moo3Skh/naYEiu8vIrOvQLrlNvsIWGTQrsNIjI
 o1mxkz5U5vYnVr2rI8J9BUglYmCypj8lkgYYgOQzgeqKaaTfq7YDNQ40klyXVXOduv
 9G7eEV6TOTc7mOEC9dVtdHEL28JZ/flY5IVzWvg7vsv01h3qgh1NdqS3xDEe0RYSqz
 z/4IlZ5RlX7b6pJlle6Vtexa+1bmc7Di69rbdWScvJqiwDk/t1iwTvgBTE63nIaxY0
 apq0RvIgOFQ7g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] doc: add generated index to table of contents
Date: Sun, 14 Jan 2024 19:58:43 +0100
Message-ID: <20240114185843.88240-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Show the index in the navigation sidebar.

doc/genindex.rst is needed to create the navigation sidebar entry.
output/genindex.html will only contain the generated content.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Provide doc/genindex.rst
---
 doc/genindex.rst | 4 ++++
 doc/index.rst    | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 doc/genindex.rst

diff --git a/doc/genindex.rst b/doc/genindex.rst
new file mode 100644
index 0000000000..2e452cb8f5
--- /dev/null
+++ b/doc/genindex.rst
@@ -0,0 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Index
+=====
diff --git a/doc/index.rst b/doc/index.rst
index 57b42c68e4..43398627d8 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -99,4 +99,7 @@ Chromium OS-specific doc
 Indices and tables
 ==================
 
-* :ref:`genindex`
+.. toctree::
+   :maxdepth: 1
+
+   genindex
-- 
2.43.0

