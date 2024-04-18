Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6315DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93A58868F;
	Thu, 18 Apr 2024 19:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JFyzAegs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F8688693; Thu, 18 Apr 2024 19:58:34 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3664187842
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IHwTtv119356;
 Thu, 18 Apr 2024 12:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713463109;
 bh=ft8/kEO8eq/kaC8kUPIJBjSI935yngVe0BwW6DtwWiw=;
 h=From:To:CC:Subject:Date;
 b=JFyzAegsxrrmZBMKqW+eAvPtSk6UddWov3lcClxmlBVhzrPqtwp1OYOmNSryKC6lH
 HQWnGtdFXOjJJglCGikFHclT4/2Q9gHoBl1Op8NInlFCFvkafHy5jahX8+OyJYK5Yt
 VSd+t1agqL4OY/NyQgRNEFKKYwkVMRpJu/8cnP/o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IHwT9r061502
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 12:58:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 12:58:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 12:58:29 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IHwTQB052339;
 Thu, 18 Apr 2024 12:58:29 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Jon Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>, Andrew Davis
 <afd@ti.com>
Subject: [PATCH] arm: mach-k3: am642: Fix reset for workaround errata ID i2331
Date: Thu, 18 Apr 2024 12:58:28 -0500
Message-ID: <20240418175828.84548-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

To workaround an issue in AM642 we reset the SoC in early boot. For that
we first probed the sysreset driver by calling uclass_get_device(). The
ti-sci sysreset driver is now probed during the ti-sci firmware probe.
Update this call to probe the firmware driver which will then probe
the sysreset driver allowing do_reset() to again function as expected.

Reported-by: Jonathan Humphreys <j-humphreys@ti.com>
Fixes: fc5d40283483 ("firmware: ti_sci: Bind sysreset driver when enabled")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am642_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index ddf47ef0a9b..80c3cb3479f 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -226,7 +226,7 @@ void board_init_f(ulong dummy)
 	 * The warm reset realigns internal clocks and prevents the lockup from
 	 * happening.
 	 */
-	ret = uclass_first_device_err(UCLASS_SYSRESET, &dev);
+	ret = uclass_get_device_by_driver(UCLASS_FIRMWARE, DM_DRIVER_GET(ti_sci), &dev);
 	if (ret)
 		printf("\n%s:uclass device error [%d]\n",__func__,ret);
 
-- 
2.39.2

