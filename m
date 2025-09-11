Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B2FCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F6583403;
	Thu, 11 Sep 2025 15:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JIzlOfz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBA083403; Thu, 11 Sep 2025 15:14:26 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF81783327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDELxs808362;
 Thu, 11 Sep 2025 08:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596461;
 bh=y+t6GWcNCMLed7Kiw23ObmjstfNGFFe3Kc0vOJt0vy8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JIzlOfz9OSQWR5mk1c6XzDpoSouEi8USjyTKH/NdAswI8Kd5gtXCXgVzT/BP6se7d
 ot7NvED9dnWUeyFgb/eatPaCWqdxxBd14DJih0zaXSmqpD1SexdMzQr7cyTbtkkT7D
 6TIx4UEv2C7nGSFSA6WakCVUmglD0utW3lJVHIaE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDELxF515729
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:21 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:21 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEKe82168770;
 Thu, 11 Sep 2025 08:14:20 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 02/17] arm: Kconfig: add per device symbols for
 TI_SECURE
Date: Thu, 11 Sep 2025 18:43:58 +0530
Message-ID: <20250911131414.3296697-3-anshuld@ti.com>
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

The TI_SECURE_DEVICE config symbols enables support for HS devices. When
enabled some insecure options are disabled such as falcon mode. Even
though falcon mode can be enabled for k3 devices securely.

Thus to allow for more granular disablement of options, this patch
introduces two new hidden symbols for legacy and k3 architectures.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297..68df62c1d01 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2255,9 +2255,17 @@ config TFABOOT
 	  Enabling this option will make a U-Boot binary that is relying
 	  on other firmware layers to provide secure functionality.
 
+config TI_SECURE_DEVICE_K2_OMAP2PLUS
+	bool
+
+config TI_SECURE_DEVICE_K3
+	bool
+
 config TI_SECURE_DEVICE
 	bool "HS Device Type Support"
 	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
+	select TI_SECURE_DEVICE_K2_OMAP2PLUS if ARCH_KEYSTONE || ARCH_OMAP2PLUS
+	select TI_SECURE_DEVICE_K3 if ARCH_K3
 	help
 	  If a high secure (HS) device type is being used, this config
 	  must be set. This option impacts various aspects of the
-- 
2.51.0

