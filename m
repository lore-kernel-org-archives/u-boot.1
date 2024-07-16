Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF5C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 19:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DAB8859C;
	Tue, 16 Jul 2024 21:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ply2ZLAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4837288453; Tue, 16 Jul 2024 21:04:21 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73B48859C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 51CC54319F; 
 Tue, 16 Jul 2024 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721156658;
 bh=sbMJTEu3IMRiRsPbpU+/LWlu66E5Nq3juT95d5ONsK8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ply2ZLAQ1I+Sd64zret1yP7+K9d9Q1XH2ip7a+1SErpO2YNF1j3An/hzqCJK1CLVy
 VACP1fnvv6RWmMPzC92SfcWQaW29mXzB8pU5sUReyiM4jYRZ/3xltkenHYebJSYspo
 LDcU4Gjea2f/kiPSRgt9wuID02SpIK3bQGGVXzoMgEtjNEHSynrlpOK8WVhgUWLI9k
 dF8XMpSosVw6qb7rh5EkSSZ9TIbVYF5ra2vJLGAkY7DQRfJ/8KBsjyKnvU2LbCCRyz
 nGCGFPlJ/OpSS/mgBs+sslEeHhck/Yt0mVr+dr3T/XYPerxkIakCJd59Q8Wx+Zgplp
 7dsGmdaMrVNiA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: enable ReadTheDocs addon management
Date: Tue, 16 Jul 2024 21:04:23 +0200
Message-ID: <20240716190423.12063-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Up to now ReadTheDocs has been injecting code when building on their
platform. This includes for instance improvements for the search function.

To maintain the current output ReadTheDocs requires setting html_baseurl
and html_context in conf.py.

See: https://about.readthedocs.com/blog/2024/07/addons-by-default/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/conf.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index c9138a5a5d4..e79134cc3d7 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -21,6 +21,12 @@ from subprocess import check_output
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
 
+# Set canonical URL from the Read the Docs Domain
+html_baseurl = os.environ.get("READTHEDOCS_CANONICAL_URL", "")
+
+# Tell Jinja2 templates the build is running on Read the Docs
+if os.environ.get("READTHEDOCS", "") == "True":
+    html_context["READTHEDOCS"] = True
 
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
-- 
2.45.2

