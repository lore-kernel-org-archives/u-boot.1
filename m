Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A25C27C77
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 08:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCB08804F;
	Sun, 16 Jun 2024 10:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pXhfhzaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DE388054; Sun, 16 Jun 2024 10:59:55 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B3480C58
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 10:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6D42D40EE9; 
 Sun, 16 Jun 2024 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718528392;
 bh=5BhJK7KCS11agOIzx3o2lSd5rYcz5v6TBiXBWHmHUiY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pXhfhzaj/vzb1qzQ3akmr90x4HyQgh+TzNw0z2emKFFa5SE3n6ZR08kpWovXNoOg/
 MlreRQNx4/chKjLe4cQ/2yZT2DwE/0MHTsBdelA6HWY1PnojtED7QDWJMNZkpQHI1b
 96jRM8mx2yAom01P/IRJkHm2nMcgprOtdP0lW9tGXhv8ZGX6jaQRCfcSxHj34M4s2z
 QuF3HiE+HvQHx2dUzYXWM1TgeT7uyPlD8A4JVoIBzlXu4c8TFmZuVoIv0yxCBo9iGV
 MydxlBP0N8YJF8uPv76nxjF7r3PIUVg0rxuqS+H2UwrIeXdeA3xCVjvewl5kv4yvpL
 0fR5HwXfGZAzQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: update requirements.txt
Date: Sun, 16 Jun 2024 10:59:48 +0200
Message-ID: <20240616085948.16692-1-heinrich.schuchardt@canonical.com>
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

Update all required Python packages to current release.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/requirements.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 54eb70aa92c..306b05a995e 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,18 +1,18 @@
 alabaster==0.7.16
-Babel==2.14.0
-certifi==2023.11.17
+Babel==2.15.0
+certifi==2024.6.2
 charset-normalizer==3.3.2
 docutils==0.20.1
 idna==3.7
 imagesize==1.4.1
 Jinja2==3.1.4
-MarkupSafe==2.1.3
-packaging==23.2
-Pygments==2.17.2
-requests==2.32.2
+MarkupSafe==2.1.5
+packaging==24.1
+Pygments==2.18.0
+requests==2.32.3
 six==1.16.0
 snowballstemmer==2.2.0
-Sphinx==7.2.6
+Sphinx==7.3.7
 sphinx-prompt==1.8.0
 sphinx-rtd-theme==2.0.0
 sphinxcontrib-applehelp==1.0.8
@@ -22,4 +22,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==1.0.7
 sphinxcontrib-serializinghtml==1.1.10
-urllib3==2.1.0
+urllib3==2.2.1
-- 
2.43.0

