Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24495C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 13:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C58F82A9E;
	Sun, 13 Apr 2025 15:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="e7A0qzrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AFF82A65; Sun, 13 Apr 2025 13:01:44 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9C38210E
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 13:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbabic@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5DB54FFA36; Sun, 13 Apr 2025 13:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1744542101; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=udQ2VVn7JL3WUdWgZtZtk5XjIxj0s8GcIHl6J+yoMnA=;
 b=e7A0qzrFVmTsHqNg5ih+DaVcC5xLfp/t09fU/O68YTtWR/3DLCAYCV2AJZCqPV1TbasmGZ
 wlc19sZBqjjdecBbs5Hx1+rE7gpMqgkVK1BJihWLdQ0hf7XpLru/t6JYl2bPfPc/qMu0FD
 AatX+R45ZT+m0thqBci1E9qfMvskb9pyvlhPgjzaBih+ZPCvdCgA8LiCyK+vgYJ9GibewF
 0Zo9nzAgg1rLZIvGDNnQVLJhE2dGg7gv0IbXcAVVbFD61Bi0tVh5pCr+wibrK4KNN7cEP1
 AJMG7CwhtDXat9IntxS/OiDx4lWEwDi4XWtZWjFmQIE883jAC5n+r1NwmFr5NA==
From: Stefano Babic <sbabic@nabladev.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx: mx51evk: drop Stefano Babic from MAINTAINERS
Date: Sun, 13 Apr 2025 13:01:38 +0200
Message-ID: <20250413110138.1027438-1-sbabic@nabladev.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 13 Apr 2025 15:38:24 +0200
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

I haven't anymore the MX51EVK board.

Signed-off-by: Stefano Babic <sbabic@nabladev.com>
CC: Fabio Estevam <festevam@gmail.com>
---
 board/freescale/mx51evk/MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/freescale/mx51evk/MAINTAINERS b/board/freescale/mx51evk/MAINTAINERS
index 1ca55f7d14e..025a5f8b582 100644
--- a/board/freescale/mx51evk/MAINTAINERS
+++ b/board/freescale/mx51evk/MAINTAINERS
@@ -1,6 +1,5 @@
 MX51EVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
-M:	Stefano Babic <sbabic@denx.de>
 S:	Maintained
 F:	board/freescale/mx51evk/
 F:	include/configs/mx51evk.h
-- 
2.43.0

