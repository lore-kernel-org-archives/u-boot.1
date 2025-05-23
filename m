Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA582C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ECD833F9;
	Fri, 23 May 2025 19:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C10483285; Fri, 23 May 2025 19:20:33 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB29883394
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4K-0076pt-HZ;
 Fri, 23 May 2025 17:20:28 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 06/13] board: venice: use baseboard model for family
Date: Fri, 23 May 2025 10:20:11 -0700
Message-Id: <20250523172018.4164647-6-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
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

The venice family of baseboards which is normally GW7xxx
is being expanded to GW8xxx so we need to use the baseboard
number instead of the som.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index abe25256e668..351d18886f14 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -322,7 +322,7 @@ int venice_eeprom_init(int quiet)
 	/* create model strings */
 	if (base_info.model[0]) {
 		sprintf(venice_model, "GW%c%c%c%c-%c%c-",
-			som_info.model[2], /* family */
+			base_info.model[2], /* family */
 			base_info.model[3], /* baseboard */
 			base_info.model[4], base_info.model[5], /* subload of baseboard */
 			som_info.model[4], som_info.model[5]); /* last 2digits of SOM */
-- 
2.25.1

