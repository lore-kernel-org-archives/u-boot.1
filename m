Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43285C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510298338C;
	Fri, 23 May 2025 19:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85408337A; Fri, 23 May 2025 19:20:34 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D95833C8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4L-0076pt-Mb;
 Fri, 23 May 2025 17:20:29 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 08/13] board: venice: flip logic for GSC supervisor enable
Date: Fri, 23 May 2025 10:20:13 -0700
Message-Id: <20250523172018.4164647-8-tharvey@gateworks.com>
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

Flip the logic used to determine if a board has the proper hardware to
support enabling the GSC voltage supervisor so that we do not need to
keep adding new models to the list.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/spl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index f14ab1497d70..e813f3e763ec 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -62,14 +62,16 @@ static int power_init_board(const char *model, struct udevice *gsc)
 	struct udevice *dev;
 	int ret;
 
-	/* Enable GSC voltage supervisor for new board models */
-	if ((!strncmp(model, "GW7100", 6) && model[10] > 'D') ||
-	    (!strncmp(model, "GW7101", 6) && model[10] > 'D') ||
-	    (!strncmp(model, "GW7200", 6) && model[10] > 'E') ||
-	    (!strncmp(model, "GW7201", 6) && model[10] > 'E') ||
-	    (!strncmp(model, "GW7300", 6) && model[10] > 'E') ||
-	    (!strncmp(model, "GW7301", 6) && model[10] > 'E') ||
-	    (!strncmp(model, "GW740", 5) && model[7] > 'B')) {
+	/* Enable GSC voltage supervisor only for newew board models */
+	if ((!strncmp(model, "GW7100", 6) && model[10] < 'E') ||
+	    (!strncmp(model, "GW7101", 6) && model[10] < 'E') ||
+	    (!strncmp(model, "GW7200", 6) && model[10] < 'F') ||
+	    (!strncmp(model, "GW7201", 6) && model[10] < 'F') ||
+	    (!strncmp(model, "GW7300", 6) && model[10] < 'F') ||
+	    (!strncmp(model, "GW7301", 6) && model[10] < 'F') ||
+	    (!strncmp(model, "GW740", 5) && model[7] < 'C')) {
+		printf("GSC     : voltage supervisor disabled\n");
+	} else {
 		u8 ver;
 
 		if (!dm_i2c_read(gsc, 14, &ver, 1) && ver > 62) {
-- 
2.25.1

