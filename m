Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C05C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 04:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC7287F8D;
	Sat,  8 Jun 2024 06:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e8C9USJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359BA87EF6; Sat,  8 Jun 2024 06:12:56 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF44988005
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 06:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (ip-109-42-178-114.web.vodafone.de [109.42.178.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5DDE53F5F5; 
 Sat,  8 Jun 2024 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717819969;
 bh=YR26OgY2hM6mc/6ssvTw/2siXTKEgmOnPignyzCspKU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=e8C9USJ/GG3045w7cMSS0y1KAxBX5dBp1KjF2WxXDQmShRsFtA61zCqdh/qE8xSKu
 9g8piHgpQKE90ohYcHm3KN7sgu0KT4Y+zVzu5hQ3v+bne1L2EF/F4UJT34u0FliZI1
 4PGtsZRkVcjqX1+tbone4Ans4FI1QT4INlZ3BAobE9lYEbBYR/e9bQZQgSqmVCubYL
 RxpBiDbCW2fWjsJ9VV0yPg2ETAA8wbgQn/8Y60tgWVHy8nL97U/UHCoQQ3xW29w/S4
 cW8/fE6CJMAJZVF9xA9FLnhmBdsb3M6UGOIJQ0l9JBXs6sSvV7TydVzT1CIz2Hs1cg
 uROPjfSnLe4Dg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dm: typo prbing
Date: Sat,  8 Jun 2024 06:12:44 +0200
Message-ID: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
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

%s/prbing/probing/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 1081d61fcf0..754649f091e 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -113,7 +113,7 @@ config DM_EVENT
 	select EVENT
 	help
 	  This enables support for generating events related to driver model
-	  operations, such as prbing or removing a device. Subsystems can
+	  operations, such as probing or removing a device. Subsystems can
 	  register a 'spy' function that is called when the event occurs. Such
 	  subsystems must select this option.
 
-- 
2.43.0

