Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFFCD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 22:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B3B84664;
	Fri, 12 Jun 2026 00:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LLwCxY9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ADB84701; Fri, 12 Jun 2026 00:49:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A78838BB
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E157B11722C; Fri, 12 Jun 2026 00:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781218142; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=xUDnYgH2DjkYnprBPWl/sjYZocFNdgii63CaG+SS96c=;
 b=LLwCxY9T8qRJVbdYi6bVxIFiX3Ge+8T+BXa7Gr4RTsM2MmzkGvOuuKFjy8wiZR47P9Keu5
 4RHa7eGu6kCbZ9DaHEcfbSF3l04e7R+9zGCk9Tn13gHc6mch1wmSIM8olBIpTI+WKyI4Wn
 giII+oVM65q0j7dwBmt0PipIe5BtVkDGmbfKxxnznpnsm2odoLduvK1NdiQwR8muU1gnEG
 6giTouJN6BZ/ODdCyVlIAyQqk43dCEMeTgg598+QXJPRQIUcr+BAUqd23KHjWE4VqRyfDD
 XKzVR9ZN8FTE9Z6xkEMFUNyyY2V0/03spsC/ugzYQnc0nhnXoVv3G2IlVgFRug==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] env: Avoid mixing of environment and driver prints on env load
Date: Fri, 12 Jun 2026 00:48:34 +0200
Message-ID: <20260611224856.213757-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Alexander Koch <akoch@initse.com>

The current environment loading code prints a partial string
"Loading Environment from %s..." and then triggers env driver
loading function. That env driver loading function may trigger
further prints, either from the env driver itself or from any
other driver that gets probed at that time. The result is a
print which mixed environment loading code prints and driver
code prints, as follows:

"
       Environment code print        _________________________
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv                          vv
Loading Environment from SPIFlash... SF: Detected w25q128jw... OK
                                     ^^^^^^^^^^^^^^^^^^^^^^
                                        Driver code print
"

Adjust the environment loading code print such, that it places
CR at the end of the line. This way, when the driver code prints
something, it overwrites the previous "Loading Environment from %s"
output and the result is not mixed. Furthermore, in case the env
was loaded correctly, print the "Loading Environment from %s ... OK"
in full again. This either overwrites the "Loading Environment from"
message and appends the print with "OK", or, it prints the line in
full after all the driver code prints.

This is not ideal, but it is the best we can do with only CR and
without ANSI control sequences. The result looks as follows:

"
SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
Loading Environment from SPIFlash... OK
"

Signed-off-by: Alexander Koch <akoch@initse.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Koch <akoch@initse.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 env/env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/env/env.c b/env/env.c
index 7a9c96b4078..404e8b7a26c 100644
--- a/env/env.c
+++ b/env/env.c
@@ -189,7 +189,7 @@ int env_load(void)
 		if (!env_has_inited(drv->location))
 			continue;
 
-		printf("Loading Environment from %s... ", drv->name);
+		printf("Loading Environment from %s...\r", drv->name);
 		/*
 		 * In error case, the error message must be printed during
 		 * drv->load() in some underlying API, and it must be exactly
@@ -197,7 +197,7 @@ int env_load(void)
 		 */
 		ret = drv->load();
 		if (!ret) {
-			printf("OK\n");
+			printf("Loading Environment from %s... OK\n", drv->name);
 			gd->env_load_prio = prio;
 
 			return 0;
@@ -206,7 +206,7 @@ int env_load(void)
 			if (best_prio == -1)
 				best_prio = prio;
 		} else {
-			debug("Failed (%d)\n", ret);
+			debug("Loading Environment from %s... Failed (%d)\n", drv->name, ret);
 		}
 	}
 
-- 
2.53.0

