Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB8C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 07:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E7481417;
	Fri,  7 Mar 2025 08:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OycrOA3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9FE812BB; Fri,  7 Mar 2025 08:56:25 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2DC81335
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 08:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uJDx4008380
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 01:56:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334179;
 bh=HTyqcKfhbvSRlsV0ef4PRNTBkHmBuFXcXqGfFQIb9Es=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OycrOA3fZZmohRf7K+c26JfYmbRJS4Sbemb50W6umQFe9roOKE7Ycy9pqwqHh4hwh
 XtISysKOdJbjyiqznLm3lsew+BQHVkJYLL2O/lptU+eg5+1mB5GYQYbVR+Cv5wcaxa
 vHDXxJzVkHcfG5Z42Zqvf7TG00Y6hT4nBHnyLjW0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uJ6J022187
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 01:56:19 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 01:56:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 01:56:19 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uIKN015031;
 Fri, 7 Mar 2025 01:56:19 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Date: Fri, 7 Mar 2025 13:25:29 +0530
Message-ID: <20250307075541.2571104-2-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307075541.2571104-1-anshuld@ti.com>
References: <20250307075541.2571104-1-anshuld@ti.com>
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

We also set the default SPL_PAYLOAD_ARGS_ADDR which holds the DTB to
match ATF's K3_HW_CONFIG_BASE.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 94e118f8465..42fe2abe75b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1148,7 +1148,7 @@ config SPL_ONENAND_SUPPORT
 
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
-	depends on !TI_SECURE_DEVICE
+	depends on !TI_SECURE_DEVICE || ARCH_K3
 	help
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
@@ -1156,6 +1156,7 @@ config SPL_OS_BOOT
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	default 0x82000000 if ARCH_K3
 	default 0x88000000 if ARCH_OMAP2PLUS
 	default 0x99000000 if ARCH_SC5XX && SC59X_64
 	default 0xA0000000 if ARCH_SC5XX && TARGET_SC594_SOM_EZKIT
-- 
2.43.0

