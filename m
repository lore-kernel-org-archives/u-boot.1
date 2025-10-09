Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729F0CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAEC844FF;
	Thu,  9 Oct 2025 13:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eAcBv78x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE795844FF; Thu,  9 Oct 2025 13:58:59 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58FA84459
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599BwsMc527509;
 Thu, 9 Oct 2025 06:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760011134;
 bh=PEc0ujwOvW3awtO2KpSBzVDXZB+vWT1GLAn6PyzK61I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eAcBv78xvzazIffukXXMEtCVm7b/XQmSB8rX/NQ27DhgTtajZDWRrwy2dpmw/uwHZ
 va1HwD0jawHafoTgppkwPcaRBPBMZ1krGNt1eDSjy5AzDUPXHJYdYWtuqeybzyA6p4
 AUfnwfzFsICXiJMqU4d4wcEqFFBaAnj3LYsXm+MM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599BwsWr1409772
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 9 Oct 2025 06:58:54 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 06:58:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 06:58:53 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599BwqCT210029;
 Thu, 9 Oct 2025 06:58:53 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 2/3] spl: prevent loading args file in secure falcon mode
Date: Thu, 9 Oct 2025 17:28:44 +0530
Message-ID: <20251009115846.897186-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009115846.897186-1-anshuld@ti.com>
References: <20251009115846.897186-1-anshuld@ti.com>
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

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 22ef43c3a6e..59be80dc55b 100644
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

