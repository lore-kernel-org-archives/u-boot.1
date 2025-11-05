Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07585CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9C1839B1;
	Wed,  5 Nov 2025 01:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sfzKKWLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2842A839B7; Wed,  5 Nov 2025 01:13:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5439C83981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 703FE40408; 
 Wed,  5 Nov 2025 00:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762301633;
 bh=b/c+U/RdIf7d9NhqEi1CG3Nhx1F7ivmGuy17u7zD9n4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sfzKKWLsQZ4kHYCXRGuFFleb21nVUADum+KDTw3gA2LOoHaUouhIxXy81CqDO5/mb
 7fOxGC6kmxNMTCpywC7dAHl9gpdEA/fahVc1ku2NhmoqVmabccscHkTraPpe+u+8nK
 lka97cLoTnG/Bdby/pCuIQiN/gBCuC2YCKu4WlYlAM3gjLvXWG7L6vYGZjFLPK9pu5
 Zx2GkFK8Lz2JDzJb9S8N4/r1E+k3gkcGq7lADUaVFGr1c61qWREE7KU6AkRHfaoleD
 7ZUi5SDlhqv4r1WoVEAaCOOHcFNfgqMO1EwNkO5sZWwB5HDlU91mcfps/2gslJKdpZ
 QvxRgU9PUnC7RZQ3zzEvvuPIHobHQ7uPcdBMDhzER9pmRmi8l8EQk1zzK3UFMi/P9m
 Mmntwi+cc66i0KH5Pjko/k+pHvhZtg5lQGHAtLeeyxvP9NWqtdQbC7V/W0KTSRgXBb
 C6Kr072T891xTQwgdrZvesJ6RLUno6xLXxOx1UGvbdeq/GWEk/Bg0T3H78RnVvo4ei
 2K6Z4+ExfYB9rzNgSp7XrbCrzhQAgVdeTngpv7cfPJs75WKO//AHNXD1a8z2Z8f4tZ
 fH1z55WzmuKdnZSMt8JNF/+sgKUfTQd9BrJMrY7k/Domgi+FPHhWEeC15/O9SHHh5g
 dSM5JFnbgtA2eMHJ/DQ9767c=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] spl: mmc: avoid including errno.h twice
Date: Wed,  5 Nov 2025 01:13:51 +0100
Message-ID: <20251105001351.92457-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Each include should only be included once.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 0a00d295575..d8ce3a84614 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -12,7 +12,6 @@
 #include <spl_load.h>
 #include <linux/compiler.h>
 #include <errno.h>
-#include <errno.h>
 #include <mmc.h>
 #include <image.h>
 #include <imx_container.h>
-- 
2.51.0

