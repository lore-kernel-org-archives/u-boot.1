Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86887E6F06C
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 10:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C826D88C53;
	Sun,  3 Nov 2024 11:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cf9rC1y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F24088FBD; Sun,  3 Nov 2024 11:57:14 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27471888BE
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 11:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2FF303FD23; 
 Sun,  3 Nov 2024 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730631431;
 bh=VxmA/PAeHdYFGDbTuzD4l2TrbuCDvnrgQSMctd9J8+c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cf9rC1y8bQhGnhb6NnuQDVm1oZEhKaZQDvKmi3jzDOk5/8oimh04XTJEewm3ogKTE
 Jg2aTk2Exw3Fhu1e/xIc5iU5yzzkUYpTVil4pbzVgtHujUvorUj+yweEhfj5C4ni7D
 7m/GlyOjpsKuR5U/qkV7b98z4ijbcFWD654J02dmVya0hVsXIwqZB3LBk42IPZ5J5w
 aWIWAYEHDPVtylkEpKT56zzrYBrBgnp6hQ2g4mwdW2Ndsf2N+CZehGlKSqrLi9pqQp
 lNHOugh7hoXP/UktW0oTBaNY/gumIZBiDdxxcE4m75ReCJ/w0u16V3OHj0QlSYQFh+
 +Gw3k7k1/zftg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] .readthedocs.yml: update Python version and Ubuntu release
Date: Sun,  3 Nov 2024 11:56:35 +0100
Message-ID: <20241103105635.107181-1-heinrich.schuchardt@canonical.com>
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

The current documentation build dependencies are not compatible with
Python 3.9. Update to Python 3.12.

Use the current Ubuntu LTS release, i.e. 24.04 Noble Numbat.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .readthedocs.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 7c6c25541a3..16418f286dc 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -6,11 +6,11 @@
 version: 2
 
 build:
-  os: "ubuntu-20.04"
+  os: "ubuntu-24.04"
   apt_packages:
     - python3-six
   tools:
-    python: "3.9"
+    python: "3.12"
 
 # Build documentation in the docs/ directory with Sphinx
 sphinx:
-- 
2.45.2

