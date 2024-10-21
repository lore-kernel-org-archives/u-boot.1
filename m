Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25F9D17123
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3293A88D56;
	Mon, 21 Oct 2024 20:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YWKWTrz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563A388EBB; Mon, 21 Oct 2024 20:08:38 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7472788C60
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F34D03F772; 
 Mon, 21 Oct 2024 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729534116;
 bh=pX6T/gKMYKFXEq3+LYYgTpNpp0zXigVD28bnW3Mre+w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YWKWTrz1pFRsb7i4WNZt7aMtQ1oCJdwHStFsc1PRH60gmK8aVli45bUBxk0qtvMxK
 vcrL9lbJYM+vHkGu9jSVtXMMY7WRtKPV9ylMfE0qgt5ZVT9rr4h5RW2qlJ64FFU1cK
 TaPC0X2ueTo7uzrY7G2XX1jAGFXKEH80Iix2OX2Bbbf53+4ODzdhKxp7PLEBvIa0Jx
 48Y9Vx8be+2baRYIgD9YPMTGl5+uHP+m3OYRlJezm8TdakgiGrgBkyMfk+85oZIgZF
 0sNY/AMR3+GgGukSI3cLpKTPLcPEny8PhnD15pDRru+yTa3qHPsOr5OoAVrG1MSQv2
 K6qDSNZG9SMHQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: update Python requirements
Date: Mon, 21 Oct 2024 20:08:31 +0200
Message-ID: <20241021180831.19120-1-heinrich.schuchardt@canonical.com>
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

Update Sphinx, sphinx-rtd-theme, and their dependencies.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/requirements.txt | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 40dde599916..13e0327c0f6 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,25 +1,26 @@
-alabaster==0.7.16
-Babel==2.15.0
-certifi==2024.7.4
-charset-normalizer==3.3.2
-docutils==0.20.1
-idna==3.7
+alabaster==1.0.0
+babel==2.16.0
+certifi==2024.8.30
+charset-normalizer==3.4.0
+docutils==0.21.2
+idna==3.10
 imagesize==1.4.1
 Jinja2==3.1.4
-MarkupSafe==2.1.5
+MarkupSafe==3.0.2
 packaging==24.1
+pip==24.2
 Pygments==2.18.0
 requests==2.32.3
 six==1.16.0
 snowballstemmer==2.2.0
-Sphinx==7.3.7
-sphinx-prompt==1.8.0
-sphinx-rtd-theme==2.0.0
-sphinxcontrib-applehelp==1.0.8
-sphinxcontrib-devhelp==1.0.6
-sphinxcontrib-htmlhelp==2.0.5
+Sphinx==8.1.3
+sphinx-prompt==1.9.0
+sphinx-rtd-theme==3.0.1
+sphinxcontrib-applehelp==2.0.0
+sphinxcontrib-devhelp==2.0.0
+sphinxcontrib-htmlhelp==2.1.0
 sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
-sphinxcontrib-qthelp==1.0.7
-sphinxcontrib-serializinghtml==1.1.10
-urllib3==2.2.2
+sphinxcontrib-qthelp==2.0.0
+sphinxcontrib-serializinghtml==2.0.0
+urllib3==2.2.3
-- 
2.45.2

