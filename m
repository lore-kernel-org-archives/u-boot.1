Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85546CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B886B8758B;
	Tue,  9 Apr 2024 20:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KiwACCIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED3887666; Tue,  9 Apr 2024 20:45:53 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9078B87572
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3208F40F4A; 
 Tue,  9 Apr 2024 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712688350;
 bh=V5Imf4cPSjHOcpogt+PFMyi99usRFQux3JL4RrkzPiQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KiwACCIM0n/VK1CxcOsI7A3YSxu80t5BtRaCVKEioEA+7jqJQhZgYO/UE5EslLmYw
 atLhdWxNMX39v7NytuHIljE/B4zSE8/ibe0JhajiqmZJmIvAPdgDqEMn0sq8soD/3M
 VKNUquvQyVXKMqAfWrKX60q3by4ZOSz9IyHplUjuiAFbMfq3J5rhVK324xDHiv3Dx5
 EnrfBFL8GRlmaZw6yhJBaAyV/lLX0NbyN6TLEtTQkkgJOgirZCsH+3wB1PsHpSQwB0
 SD04S13YVaMIhIPJWJAL/5DKB9lyn/21KMgtj5H3ucufEd5ubno43997pHVZO9Uhs7
 MSAj4SdAtb05Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Nandor Han <nandor.han@vaisala.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] reboot-mode: must depend on CONFIG_DM_RTC
Date: Tue,  9 Apr 2024 20:44:22 +0200
Message-ID: <20240409184422.45023-1-heinrich.schuchardt@canonical.com>
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

Reading the boot mode from RTC memory requires a real time clock.
Add the missing Kconfig dependency.

Fixes: c74675bd904b ("reboot-mode: read the boot mode from RTC memory")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/reboot-mode/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index d57baacc93d..bb518935188 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -24,6 +24,7 @@ config DM_REBOOT_MODE_GPIO
 
 config DM_REBOOT_MODE_RTC
 	bool "Use RTC as reboot mode backend"
+	depends on DM_RTC
 	depends on DM_REBOOT_MODE
 	help
 		Use RTC non volatile memory to control the reboot mode. This will allow users to boot
-- 
2.43.0

