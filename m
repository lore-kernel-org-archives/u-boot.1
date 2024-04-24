Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D138C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE93887A1;
	Wed, 24 Apr 2024 14:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nPTtqJWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D02887A4; Wed, 24 Apr 2024 14:43:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8AC88871C
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713962609; x=1716554609;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EI5Jg2Hn3CyHIATBtKRdGpZyeEWqAM6UTcD3e5tvFLQ=;
 b=nPTtqJWUDVT+lmXaFhU9noiURnTOnPJLwvkKLbqpZvbe0bjjvyC6wYuDchBdyEgJ
 CRJFNJ8DmVD+LqHEEKR+4Sy9dCtmqFUKJsdQbbopjzMeZd3mzt04oLZJhugEAjzs
 Qc6sUF5wdiOYU6EIdNep0JQli4hkakGqQCm5+narFZU=;
X-AuditID: ac14000a-fbefe7000000290d-66-6628fe717d50
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 80.2A.10509.17EF8266;
 Wed, 24 Apr 2024 14:43:29 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Apr
 2024 14:43:28 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>, <bb@ti.com>, <vigneshr@ti.com>
Subject: [PATCH] arm: mach-k3: am642: Provide a way to obtain boot device for
 non SPLs
Date: Wed, 24 Apr 2024 14:43:20 +0200
Message-ID: <20240424124320.2056543-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWyRpKBR7fwn0aawZJXShZz3xxgtXjz4yyT
 xdu9newW3e/ULf6f/cDuwOpx9s4ORo/+7hZWj+M3tjMFMEdx2aSk5mSWpRbp2yVwZTS+uMxa
 0G9W8X7LcrYGxsW6XYycHBICJhI9n+axdzFycQgJLGGSuPjxMhuE85hR4uTvE4wgVWwC6hJ3
 NnxjBbFFBKQkXnZuZAaxmQW8JWYt+scCYgsLhEm8OrwHLM4ioCqxY+UDsF5eAUuJ7mvdLBDb
 5CVmXvrODhEXlDg58wkLxBx5ieats6FmSkgcfPECzBYCir+4tByud9q518wQdqjE1i/bmSYw
 CsxCMmoWklGzkIxawMi8ilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMocEUYuHYw9s3xOMTIxMF4
 iFGCg1lJhPfmR400Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJM
 HJxSDYzGd1S//2StuzxVUjo//PYMWa3fiZUnl0uebjnyZfZJBeulHWcSTgme2Xljf1nOuuvb
 /+awe1q8buHh3qNQmLKC6drLgr1az54WsbgVMrtaZD/enS7Bw7rv0pn3AZ+ESzvnMZ/LrVrA
 N0Gpqyk3jWPKlv2aIn8FRZ9cj0uT2rYzaO+yvpC//lFKLMUZiYZazEXFiQBvj8uaSgIAAA==
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

Let's provide get_boot_device() for AM64, similar to what we did
in commit 2f9095e2bf59 ("arm: mach-k3: am625: Provide a way to obtain boot
device for non SPLs") for AM62.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/Makefile       |   1 +
 arch/arm/mach-k3/am642_init.c   |  92 +---------------------------
 arch/arm/mach-k3/am64x/Makefile |   2 +
 arch/arm/mach-k3/am64x/boot.c   | 105 ++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-k3/am64x/Makefile
 create mode 100644 arch/arm/mach-k3/am64x/boot.c

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 1bd523329a4..3101f57d324 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
 endif
 obj-y += common.o security.o
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
+obj-$(CONFIG_SOC_K3_AM642) += am64x/
diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index ddf47ef0a9b..feadad8c5a8 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -285,97 +285,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	}
 }
 
-static u32 __get_backup_bootmedia(u32 main_devstat)
-{
-	u32 bkup_bootmode =
-	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-	    MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-	    MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-
-
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BACKUP_BOOT_DEVICE_MMC:
-		if (bkup_bootmode_cfg)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 main_devstat)
-{
-	u32 bootmode = (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg =
-	    (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
-
-	switch (bootmode) {
-	case BOOT_DEVICE_OSPI:
-		fallthrough;
-	case BOOT_DEVICE_QSPI:
-		fallthrough;
-	case BOOT_DEVICE_XSPI:
-		fallthrough;
-	case BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BOOT_DEVICE_ETHERNET_RGMII:
-		fallthrough;
-	case BOOT_DEVICE_ETHERNET_RMII:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BOOT_DEVICE_EMMC:
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_NAND:
-		return BOOT_DEVICE_NAND;
-
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-		     MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_DFU:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
-		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-
-	case BOOT_DEVICE_NOBOOT:
-		return BOOT_DEVICE_RAM;
-	}
-
-	return bootmode;
-}
-
 u32 spl_boot_device(void)
 {
-	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		return __get_primary_bootmedia(devstat);
-	else
-		return __get_backup_bootmedia(devstat);
+	return get_boot_device();
 }
diff --git a/arch/arm/mach-k3/am64x/Makefile b/arch/arm/mach-k3/am64x/Makefile
new file mode 100644
index 00000000000..acf09c3426c
--- /dev/null
+++ b/arch/arm/mach-k3/am64x/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier:	GPL-2.0+
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
new file mode 100644
index 00000000000..ce8ae941be6
--- /dev/null
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/spl.h>
+
+static u32 __get_backup_bootmedia(u32 main_devstat)
+{
+	u32 bkup_bootmode =
+	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+	    MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg =
+	    (main_devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+	    MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bkup_bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bkup_bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 main_devstat)
+{
+	u32 bootmode = (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg =
+	    (main_devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+	    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_OSPI:
+		fallthrough;
+	case BOOT_DEVICE_QSPI:
+		fallthrough;
+	case BOOT_DEVICE_XSPI:
+		fallthrough;
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_ETHERNET_RGMII:
+		fallthrough;
+	case BOOT_DEVICE_ETHERNET_RMII:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_NAND:
+		return BOOT_DEVICE_NAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+		     MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
+	u32 bootmedia;
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(devstat);
+	else
+		bootmedia = __get_backup_bootmedia(devstat);
+
+	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
-- 
2.34.1

