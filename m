Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A7CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 022168341A;
	Thu, 11 Sep 2025 15:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="khIu6Pwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F3D8334F; Thu, 11 Sep 2025 15:14:29 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915E3833F5
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEOY9808370;
 Thu, 11 Sep 2025 08:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596464;
 bh=50kzTfeYYBIaDo/XF2V3wfhU/RGfpWMcwvbSzAP2ZS0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=khIu6Pwgik/nJ5eLuRvw3ZMrivKKRptRY/fWJefuRBtcynTI0uleivhnAGt40ki+k
 u1dHJs6/+BQzbQ9TT9tkxR/rV4Aa2toMwz/wGL73t+6PFPb/eTsaUsj2rfYEyl+gXV
 h2KegHIhavVXvlMC7HaOGarvKA9QHW7vUP9Ra0mc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDENgO1179139
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:23 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:23 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEMFL2168795;
 Thu, 11 Sep 2025 08:14:22 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 03/17] spl: Kconfig: allow K3 devices to use falcon mode
Date: Thu, 11 Sep 2025 18:43:59 +0530
Message-ID: <20250911131414.3296697-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911131414.3296697-1-anshuld@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
HS devices and can be enabled on K3 devices.

For secure boot, the kernel with x509 headers can be packaged in a fit
container (fitImage) signed with TIFS keys for authentication.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7e87e50f693..4f817fd31c5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1201,7 +1201,8 @@ config SPL_ONENAND_SUPPORT
 
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
-	depends on !TI_SECURE_DEVICE
+	depends on !TI_SECURE_DEVICE_K2_OMAP2PLUS
+	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE_K3
 	help
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
-- 
2.51.0

