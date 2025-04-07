Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C30C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA15882C87;
	Mon,  7 Apr 2025 08:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vubu5enw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D6D82CA2; Mon,  7 Apr 2025 08:59:41 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F6282C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-136.46.114.pool.telefonica.de
 [46.114.108.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3F88540393; 
 Mon,  7 Apr 2025 06:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744009177;
 bh=1pTdrworQkb1qX+C0F6dquAuqRtvi3JAc2F4EZn9jWQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vubu5enw3R15xIiMLR083xURB6GxQIbSCig5BjWzdF2cIqmenq8T/qW4RqQ5TCZOJ
 P+yI4pGlA7IUZRSoQgo6TW2//xBn9li5knfCyAGYoPdGrSu/SiENirZMQ9URW3x7AP
 b8ZO/T36EVKm1Cf/xZhRAt0dz6roqjC8SKBPuhkvAIyMv6r2ou/4WTA6nvHepJ9BG2
 Cn4H0cIUDEA2cJ6PwqV5Ey6GWEFi45b9pX/e4fobpNBVSeRGR03qaPH5NQfcsxeLFC
 u/UvtBRhzOJbDCXCwZJhYNJrWBRHc5v/otBk5zSfex3r98rcz7udgPYeHaBpDR6D43
 Y0UZ2h+x03y3g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc/buildman: typo 'require'
Date: Mon,  7 Apr 2025 08:59:24 +0200
Message-ID: <20250407065924.72277-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

%s/require/required/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 924564b5700..07ecc5c110c 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -247,7 +247,7 @@ Setting up
    section is ignored. If more than one line is provided, only the last one
    is taken.
 
-#. Make sure you have the require Python pre-requisites
+#. Make sure you have the required Python pre-requisites
 
    Buildman uses multiprocessing, Queue, shutil, StringIO, ConfigParser and
    urllib2. These should normally be available, but if you get an error like
-- 
2.48.1

