Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A655CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED5C834D4;
	Wed, 15 Oct 2025 12:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IUOHep5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228F8832BC; Wed, 15 Oct 2025 12:47:12 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CED8323A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FAl7E71736218;
 Wed, 15 Oct 2025 05:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760525227;
 bh=/7PDrz6UO4dHEW+KWaD2w3iN5s5thNaMUF5cEEPz07Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IUOHep5Y4LnWDZ/0dtZnfzoklk1JpaVK9pmO1F4vmsQuc7pcRlO+IN+drNhCoCPmO
 f1B/hBPtQfmCfvqgx4Yq5CoOkknZ2p0Q/dR+mmdtGGTxbCP48BxuXcTOYhfgvKh/ja
 UWRnweHXZKFh/qj8A+s2erxMLbAJb0la9qh/SoAQ=
Received: from DLEE211.ent.ti.com (dlee211.ent.ti.com [157.170.170.113])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FAl77t1166489
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Oct 2025 05:47:07 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 05:47:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 05:47:07 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FAl6PL1778424;
 Wed, 15 Oct 2025 05:47:07 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v2 1/5] spl: Kconfig: allow falcon mode for TI secure devices
Date: Wed, 15 Oct 2025 16:16:43 +0530
Message-ID: <20251015104702.3726411-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015104702.3726411-1-anshuld@ti.com>
References: <20251015104702.3726411-1-anshuld@ti.com>
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
HS devices and but can now be enabled with the addition of
OS_BOOT_SECURE.

For secure boot, the kernel with x509 headers can be packaged in a fit
container (fitImage) signed with TIFS keys for authentication.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0fe5db43d5d..10f4a175c6b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1202,7 +1202,7 @@ config SPL_ONENAND_SUPPORT
 
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
-	depends on !TI_SECURE_DEVICE
+	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE
 	depends on ARM || MICROBLAZE || PPC
 	help
 	  Enable booting directly to an OS from SPL.
-- 
2.51.0

