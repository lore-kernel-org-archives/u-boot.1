Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB88C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952BE8796E;
	Sun, 14 Jan 2024 14:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cO79kUd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE89C87968; Sun, 14 Jan 2024 14:18:44 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478908796B
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 14:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8F62C41BC1; 
 Sun, 14 Jan 2024 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705238319;
 bh=6CrnuCSadLj/ohCVwCxDk3VqS0c3WwyVFzC+FwgEITQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cO79kUd4PeYnUxCIq2E8rgEgJgSfgl1vqzQ5eKta9DYbi+fUbvmqEMbr3yytWfcpO
 V435voRmVXnsm/708K2fP6j9QAmO2DsptnrasekG5b65s3GTWgMrBG9Jeoju0MR/rf
 OHOoWoUdmk3y4feOOJDcbcnj6rXBepfylLj3joyJA3K+3UIcGy5ydh5VomUVSsIc/9
 yuTq4q+JzyFeuKBqimXlkbsHLDf0IcmLRrGRQYC/4uFd6vqM8ZlP+XcEa3UbPlcM1u
 clV+oPBVYai9tmY4mv0DDSzEVGyjoZHyTKT7F6F7qNs3hSLO7lEWeM7dt0/9gmd24h
 E6jMJxN/cPm6A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/5] doc: update theme_overrides.css
Date: Sun, 14 Jan 2024 14:18:21 +0100
Message-ID: <20240114131824.68298-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
References: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
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

Update theme_overrides.css from Linux v6.7.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx-static/theme_overrides.css | 44 ++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/doc/sphinx-static/theme_overrides.css b/doc/sphinx-static/theme_overrides.css
index 522b6d4c49..f6f2b941a5 100644
--- a/doc/sphinx-static/theme_overrides.css
+++ b/doc/sphinx-static/theme_overrides.css
@@ -1,9 +1,38 @@
 /* -*- coding: utf-8; mode: css -*-
  *
  * Sphinx HTML theme customization: read the doc
- *
+ * Please don't add any color definition here, as the theme should
+ * work for both normal and dark modes.
  */
 
+/* Improve contrast and increase size for easier reading. */
+
+body {
+	font-family: serif;
+	font-size: 100%;
+}
+
+h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
+	font-family: sans-serif;
+}
+
+div[class^="highlight"] pre {
+	font-family: monospace;
+	font-size: 100%;
+}
+
+.wy-menu-vertical {
+	font-family: sans-serif;
+}
+
+.c {
+	font-style: normal;
+}
+
+p {
+	font-size: 100%;
+}
+
 /* Interim: Code-blocks with line nos - lines and line numbers don't line up.
  * see: https://github.com/rtfd/sphinx_rtd_theme/issues/419
  */
@@ -15,6 +44,16 @@ div[class^="highlight"] pre {
     line-height: normal;
 }
 
+/* Keep fields from being strangely far apart due to inheirited table CSS. */
+.rst-content table.field-list th.field-name {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+.rst-content table.field-list td.field-body {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+
 @media screen {
 
     /* content column
@@ -56,13 +95,10 @@ div[class^="highlight"] pre {
     /* Menu selection and keystrokes */
 
     span.menuselection {
-	color: blue;
 	font-family: "Courier New", Courier, monospace
     }
 
     code.kbd, code.kbd span {
-	color: white;
-	background-color: darkblue;
 	font-weight: bold;
 	font-family: "Courier New", Courier, monospace
     }
-- 
2.43.0

