Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0644C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E23F87EFD;
	Mon, 26 Feb 2024 14:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VWtSsb3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEE687F07; Mon, 26 Feb 2024 14:30:20 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB0487EFB
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708954215; x=1711546215;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HjR7zU2/mcDp8qe+SPU6O9jQFC8+xq00yMDVoo/LH8I=;
 b=VWtSsb3RzZ+LiOjMTs9xBmKmjMqwcULMBaOZHtwYMfmrWvqXQhgv+dqYxQ3TyCOO
 D4a45BaDSzbpfszJPnr7RJcNxqZln7vDBvpcgwF42FNTVhCSuisyw+93+aN9v7M0
 tgtZHgFXqVEKTCr/00qJ0whckfyxYDOxoVIqJinvVT0=;
X-AuditID: ac14000a-fadff7000000290d-e4-65dc92670c69
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 91.B8.10509.7629CD56;
 Mon, 26 Feb 2024 14:30:15 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Feb
 2024 14:30:40 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
Subject: [PATCH 2/2] arm: mach-k3: am625: Provide a way to obtain boot device
 for non SPLs
Date: Mon, 26 Feb 2024 14:30:06 +0100
Message-ID: <20240226133006.3279993-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226133006.3279993-1-w.egorov@phytec.de>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWyRpKBRzd90p1Ug61nZC3mvjnAavHmx1km
 i7d7O9ktut+pO7B4nL2zg9Gjv7uF1eP4je1MAcxRXDYpqTmZZalF+nYJXBmzz95gLThtVTH5
 /XXmBsZuwy5GTg4JAROJ9vOb2EFsIYHFTBJ/JhtB2I8ZJQ6sMgWx2QTUJe5s+MYKYosISEm8
 7NzIDGIzC1hInDtxhQ3EFhaIkpjz5hiYzSKgKrF+wj+wGl4BS4lF3aeZIXbJS8y89B1sF6eA
 lcT9pY0sELssJWav2sYOUS8ocXLmExaI+fISzVtnQ+2SkDj44gUzRL28xItLy1lgZk479xpq
 fqjE1i/bmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMotEUYuHYw
 9s3xOMTIxMF4iFGCg1lJhDdc5maqEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp
 2ampBalFMFkmDk6pBsZcg5xpUikMJpJpWrvu1/+eIROToX/t0mzFt43Oc3U25O2ZI3/hTdWW
 1VwRepqH68w09s/q3er5RVHQVXTRuS15rJMDl+m/lO1njH762l3te0Hhxc4lT2R2eL9u++Sa
 wh3VelPT9WJBXUXh7Dj/IK+7Ha1BRw4etFx5Ni/GLXpXT+Q3do6H85RYijMSDbWYi4oTAZwX
 2s1bAgAA
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

Introduce get_boot_device() to obtain the booting device. Make it also
available for non SPL builds so u-boot can also know the device it is
booting from.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/Makefile                |   1 +
 arch/arm/mach-k3/am625_init.c            |  95 +--------------------
 arch/arm/mach-k3/am62x/Makefile          |   2 +
 arch/arm/mach-k3/am62x/boot.c            | 103 +++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/hardware.h |   1 +
 5 files changed, 108 insertions(+), 94 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62x/Makefile
 create mode 100644 arch/arm/mach-k3/am62x/boot.c

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 4216137646..61ec4ea13c 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
 endif
 obj-y += common.o security.o
+obj-$(CONFIG_SOC_K3_AM625) += am62x/
diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 67cf63b103..85cd3f895a 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -246,100 +246,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	}
 }
 
-static u32 __get_backup_bootmedia(u32 devstat)
-{
-	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_USB;
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
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 devstat)
-{
-	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
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
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
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
-	u32 bootmedia;
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		bootmedia = __get_primary_bootmedia(devstat);
-	else
-		bootmedia = __get_backup_bootmedia(devstat);
-
-	debug("am625_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
-	      __func__, devstat, bootmedia, bootindex);
-
-	return bootmedia;
+	return get_boot_device();
 }
diff --git a/arch/arm/mach-k3/am62x/Makefile b/arch/arm/mach-k3/am62x/Makefile
new file mode 100644
index 0000000000..acf09c3426
--- /dev/null
+++ b/arch/arm/mach-k3/am62x/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier:	GPL-2.0+
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
new file mode 100644
index 0000000000..966500edc9
--- /dev/null
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62_spl.h>
+
+static u32 __get_backup_bootmedia(u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg =
+			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bkup_bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_USB;
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
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
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
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
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
+	debug("am625_init: %s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index a1a9dfbde6..0511d9fbdf 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -105,4 +105,5 @@ struct k3_qos_data {
 extern struct k3_qos_data am62a_qos_data[];
 extern u32 am62a_qos_count;
 
+u32 get_boot_device(void);
 #endif /* _ASM_ARCH_HARDWARE_H_ */
-- 
2.34.1

