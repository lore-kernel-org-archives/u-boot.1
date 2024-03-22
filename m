Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD56C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA3A8812B;
	Fri, 22 Mar 2024 08:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DyA03azM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717FC8817F; Fri, 22 Mar 2024 08:57:41 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9B78812B
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6146342F58; 
 Fri, 22 Mar 2024 07:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711094258;
 bh=CCruBKVgHYpTjWCIW/vQACcO8fnJOae0b5D6ZLmBLtU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DyA03azMiwzVRct8qUTBmS4vKYHVVAwgyRMf5mjLRXtyM7JlLKPVR1psngjpu2btf
 vQt83Yu52eDvP3XV1Kuyn/OriLCduuZhn4i6xol3luEbiGm/Q4zqiTagCStTwszaPn
 Rb2OLQLGGWlZoUc/yq3cM/2gcvR/7n0vmhEpEAK7YI9AVh0tHwRwxmlAKBWxnybcuC
 Izb921Wm7ePq0ggEKGNFVZs4uTQe+qM/QqLbepu+1bawvSGSxvUPJM7HpJnnQ5la4K
 WcVjOLpA1RyP/ObiE/5wr8UMapCy9iqbJWCJ4xRK5BjuqYo7z+PxAkbqfcLUM7EqKD
 ay4HWcMu52E7g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] doc: add reference to itest in if man-page
Date: Fri, 22 Mar 2024 08:57:31 +0100
Message-ID: <20240322075731.33390-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322075731.33390-1-heinrich.schuchardt@canonical.com>
References: <20240322075731.33390-1-heinrich.schuchardt@canonical.com>
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

Add a cross reference to the itest command.

Fix a typo: %s/Example/Examples/.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/if.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/usage/cmd/if.rst b/doc/usage/cmd/if.rst
index 6b3dbe7b0a0..813f903a8d8 100644
--- a/doc/usage/cmd/if.rst
+++ b/doc/usage/cmd/if.rst
@@ -33,11 +33,11 @@ test statement
     $? becomes 0 (true) the statements after the **then** statement will
     be executed. Otherwise the statements after the **else** statement.
 
-Example
--------
+Examples
+--------
 
 The examples shows how the value of a numeric variable can be tested with
-**itest**.
+the :doc:`itest <itest>` command.
 
 ::
 
-- 
2.43.0

