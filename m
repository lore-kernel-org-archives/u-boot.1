Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9522C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 12:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4AD871D7;
	Tue, 24 Oct 2023 14:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="Yv3nUQ8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90C88716D; Tue, 24 Oct 2023 14:03:37 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2E9870C4
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 14:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=MJPVqS9L/lllnI+hKCbrgHmUDPUiZ7Gn8tdFAdsJO+c=; b=Yv3nUQ8YTLHYVjvsxo7hXh/o7F
 1NAW7Wv2liohuueK/oeLTPit8QJ8JS1OWctqXEqR2VeDS1FO56+2Z6F/ZyMg9++tou/RPmj08EJyY
 j7zkQh11qE63+DUljZ1EnZwd/LVQS/OHAR3L8yAv0rRiDNVKCMJmlm6wjMARF2BX6Nf44pEpTWUxO
 vgM2z/HqJVSodskDBd/fPHZZepu7+LowZgYp7gazXgHBHRsfImFLNvMoLrnxVIS7VwZm4BXcDnS0K
 uA1x4WHxvOCM/cFy+bR5HevZmPJaWG43RMN4JT0pjAVeXP1R97FYAAY/Rv6oqzbQruHuTw24htnDE
 Bl1vuCoA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qvG8A-006DRJ-VZ; Tue, 24 Oct 2023 13:03:31 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: 
Cc: u-boot@lists.denx.de,
	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH] doc: usage: fix ordering of shell commands
Date: Tue, 24 Oct 2023 23:03:00 +1100
Message-ID: <20231024120307.17896-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
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

I initially didn't find the bootz docs when I went looking for them. :)
---
 doc/usage/index.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 98b4719c408..839589c2147 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -37,8 +37,8 @@ Shell commands
    cmd/bootm
    cmd/bootmenu
    cmd/bootmeth
-   cmd/button
    cmd/bootz
+   cmd/button
    cmd/cat
    cmd/cbsysinfo
    cmd/cedit
@@ -56,8 +56,8 @@ Shell commands
    cmd/env
    cmd/event
    cmd/exception
-   cmd/extension
    cmd/exit
+   cmd/extension
    cmd/false
    cmd/fatinfo
    cmd/fatload
@@ -93,15 +93,15 @@ Shell commands
    cmd/rng
    cmd/saves
    cmd/sbi
-   cmd/sf
    cmd/scp03
    cmd/seama
    cmd/setexpr
+   cmd/sf
    cmd/size
    cmd/sleep
+   cmd/sm
    cmd/sound
    cmd/source
-   cmd/sm
    cmd/temperature
    cmd/tftpput
    cmd/trace
-- 
2.42.0

