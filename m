Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C6CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 11:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5328394E;
	Wed,  8 Oct 2025 13:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wwD10Oxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DC083DA7; Wed,  8 Oct 2025 13:36:18 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E0D8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598BaCGq3966325;
 Wed, 8 Oct 2025 06:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759923372;
 bh=NT9t7sqHvz/pSGXWOkxm5Ky0qfyzMtW3HP+0cRsBoAg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wwD10OxbA99Y6wMij96/fjX3X8D9JWtKSS4wEtbwZCryJoWNpQwUa51vMF/1CmW0z
 938YxS5arW3hrY2oJezXF7w6zELrCs54vqEk+vx5rgOtbhLQx145+2O4PXaCCx4hcE
 hsZysgxPg5yhz24ww2LChpQdi9ykuUdngTX2dN0I=
Received: from DLEE205.ent.ti.com (dlee205.ent.ti.com [157.170.170.85])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598BaC2e609619
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Oct 2025 06:36:12 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 06:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 06:36:12 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598BaAmv2471057;
 Wed, 8 Oct 2025 06:36:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 2/2] spl: prevent loading args file in secure falcon mode
Date: Wed, 8 Oct 2025 17:06:04 +0530
Message-ID: <20251008113605.1055826-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008113605.1055826-1-anshuld@ti.com>
References: <20251008113605.1055826-1-anshuld@ti.com>
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

The expected payload for the SPL in secure falcon mode is a fitImage
that contains the kernel image and the DT. This removes the need to load
an additional args file, which exposes an additional attack vector since
it can not be verified.

Therefore this patch disables loading of the arg file when
SPL_OS_BOOT_SECURE is set.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 475ddacbbc4..38611f1d352 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -796,6 +796,7 @@ config SPL_FS_LOAD_PAYLOAD_NAME
 config SPL_FS_LOAD_KERNEL_NAME
 	string "File to load for the OS kernel from the filesystem"
 	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT
+	default "fitImage" if SPL_OS_BOOT_SECURE
 	default "uImage"
 	help
 	  Filename to read to load for the OS kernel when reading from the
@@ -1216,7 +1217,7 @@ config SPL_OS_BOOT_SECURE
 
 config SPL_OS_BOOT_ARGS
 	bool "Allow SPL to load args for kernel in falcon mode"
-	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) && !SPL_OS_BOOT_SECURE
 	help
 	  This option enables the SPL to load an args file (usually the FDT)
 	  alongside the kernel image in falcon boot mode.
-- 
2.51.0

