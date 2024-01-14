Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B63C4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 13:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386EB879AC;
	Sun, 14 Jan 2024 14:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TYtu8G82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F42318796E; Sun, 14 Jan 2024 14:18:44 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43B78743A
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 29CEE41BC2; 
 Sun, 14 Jan 2024 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705238320;
 bh=xXCH6kdwkmpkdsz3rbb7wxH4FOQu08jy61iMdOKPpik=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TYtu8G821fMbye/on+WbCnU+cBIRxllkVa3ihW8AAZsKEBxggqLpUQXXecgqJl1lM
 9CMyA3Sjt8lea8LBz4noxsClQzRj6p5IYkghAmS1wFnzfaVFOb4o1TkDCG3XdO1HJ0
 zPSH0JMdhYMcdTZQG0OJ1nsfhbmpv6IrgXhyAdS8V92ntpvkbt9y9VtEgK4mRNl92W
 kaNlsOaEkYdP5n+7nf8YGhkG+cBoRtHkOZvPQ/fgkE+xNanL5HeU9qXplLlmNC4648
 7TQixYWjsmodcWfb2Hp67bvqDMgXIwTiwZLwEG9maM7isTNSQcKtlW+PE0CBbu8E0V
 TndeegwDPIXzQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/5] doc: import Sphinx theme.css and pygments.css
Date: Sun, 14 Jan 2024 14:18:22 +0100
Message-ID: <20240114131824.68298-5-heinrich.schuchardt@canonical.com>
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

We want to override the Sphinx theme only partially. So we need to
import the Sphinx theme.css. Cf.
https://docs.readthedocs.io/en/stable/guides/adding-custom-css.html

We also need to import the pygments.css for syntax highlighing.

Use sans-serif for body.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx-static/theme_overrides.css | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/sphinx-static/theme_overrides.css b/doc/sphinx-static/theme_overrides.css
index f6f2b941a5..02e1151815 100644
--- a/doc/sphinx-static/theme_overrides.css
+++ b/doc/sphinx-static/theme_overrides.css
@@ -5,10 +5,13 @@
  * work for both normal and dark modes.
  */
 
+@import 'css/theme.css';
+@import 'pygments.css';
+
 /* Improve contrast and increase size for easier reading. */
 
 body {
-	font-family: serif;
+	font-family: sans-serif;
 	font-size: 100%;
 }
 
-- 
2.43.0

