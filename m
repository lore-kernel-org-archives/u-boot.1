Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D715BCD4F33
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 08:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E9186504;
	Fri, 22 Sep 2023 10:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83238658E; Fri, 22 Sep 2023 10:54:18 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 5409D864D8
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 10:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 22 Sep 2023 17:54:12 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 418592059053;
 Fri, 22 Sep 2023 17:54:12 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Fri, 22 Sep 2023 17:54:12 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 0DD69B6326;
 Fri, 22 Sep 2023 17:54:12 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dai Okamura <okamura.dai@socionext.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] MAINTAINERS: Step up as maintainers of UniPhier SoC platform
Date: Fri, 22 Sep 2023 17:54:09 +0900
Message-Id: <20230922085409.1880176-1-hayashi.kunihiko@socionext.com>
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

Update maintainers for UniPhier SoC platform.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a10a436bcec..281a3f81f73a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -723,7 +723,10 @@ F:	drivers/usb/musb-new/ux500.c
 F:	drivers/video/mcde_simple.c
 
 ARM UNIPHIER
-S:	Orphan (Since 2020-09)
+M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+R:	Dai Okamura <okamura.dai@socionext.com>
+S:	Maintained
+F:	arch/arm/dts/uniphier-*
 F:	arch/arm/mach-uniphier/
 F:	configs/uniphier_*_defconfig
 N:	uniphier
-- 
2.25.1

