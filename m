Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A6CE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1592380291;
	Wed, 18 Dec 2024 20:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F0C80312; Wed, 18 Dec 2024 20:45:51 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E243C8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1tNzzQ-002gKE-Ec;
 Wed, 18 Dec 2024 19:45:48 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] drivers: misc: gsc: add support for fan controller
Date: Wed, 18 Dec 2024 11:45:41 -0800
Message-Id: <20241218194542.1867618-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Add support for Gateworks System Controller fan tach input.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/misc/gsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/gsc.c b/drivers/misc/gsc.c
index dee0bdd9663a..bab405bb7226 100644
--- a/drivers/misc/gsc.c
+++ b/drivers/misc/gsc.c
@@ -330,6 +330,9 @@ static int gsc_hwmon(struct udevice *dev)
 
 			printf("%-8s: %d.%03dV\n", label, val / 1000, val % 1000);
 			break;
+		case 4: /* revolutions per minute */
+			printf("%-8s: %drpm\n", label, val * 30);
+			break;
 		}
 	}
 
-- 
2.25.1

