Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4038BC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 20:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A818863E;
	Mon,  1 Jul 2024 22:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Mgw5D8PY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E90288655; Mon,  1 Jul 2024 22:43:06 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B87884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0935540155; 
 Mon,  1 Jul 2024 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719866581;
 bh=IqYjwUQlJHqFR4qkL3blEviFkNBCiwVI/XZDOsvc+pQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Mgw5D8PYTL0Otjxr3yGHuI/BaZHkTIoRzYRV133mK6X0WWxQEiKY8rW+afYOMS8gE
 t6aghP00SvhL/jsdeszct5mJPff2rwDiJe/X3dYj/SNuaI8vUcc5pdfY64ZeQwqcjc
 FnFykJkxzv5e12OTFp7asvR/LLiGzrqC8isJyQYuCw/zZrasqJJgbX8P1SPLvH0VIx
 cwTkdXL+myjiJ8JtBT1sP7TZ3hHBb4L/4IQUnyKOi0l207fUTVDtyho8bAYf0ae2FR
 kRbZjwxLJKyeUkSptqir15JFt3dwUyMfkSXzllzY67tzSFTMj/gAURqXIdLYqrCd/Z
 ryIzxinj+JN0A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: fix heading level of itest examples
Date: Mon,  1 Jul 2024 22:42:42 +0200
Message-ID: <20240701204242.6036-1-heinrich.schuchardt@canonical.com>
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

The Examples section should be on the second heading level.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/itest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/itest.rst b/doc/usage/cmd/itest.rst
index 9c307fb4bf4..adcad05b2d4 100644
--- a/doc/usage/cmd/itest.rst
+++ b/doc/usage/cmd/itest.rst
@@ -58,7 +58,7 @@ op
     ======== ======================
 
 Examples
-========
+--------
 
 The itest command sets the result variable $? to true (0) or false (1):
 
-- 
2.45.2

