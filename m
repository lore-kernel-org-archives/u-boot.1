Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF9EC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF0E87F02;
	Mon, 26 Feb 2024 14:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PlFbcBlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2162887EDC; Mon, 26 Feb 2024 14:30:18 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4096387EED
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
 bh=OMu7i76e3CCP4ZkMwXJcm0h+n0mUrHPEpccVv+yEgQ0=;
 b=PlFbcBlShPWNGBLdknJx+IcWd6CbkpzNGGIQ+RWO8KZjfrIZdPzH6h9rwxobgm8m
 pMIm+e+JEirneoZdWrVcCXpZQqirK49pfl0V1iiLjAdhpqikF/85PuTqVGBZhgcb
 idP52HHQUN7ue9demc9IeIhiuaE268AbDZFcnGyk4xo=;
X-AuditID: ac14000a-fbefe7000000290d-e3-65dc92677255
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 41.B8.10509.7629CD56;
 Mon, 26 Feb 2024 14:30:15 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Feb
 2024 14:30:40 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
Date: Mon, 26 Feb 2024 14:30:05 +0100
Message-ID: <20240226133006.3279993-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226133006.3279993-1-w.egorov@phytec.de>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWyRpKBRzd90p1Ug9bnIhZz3xxgtXjz4yyT
 xdu9newW3e/UHVg8zt7ZwejR393C6nH8xnamAOYoLpuU1JzMstQifbsEroy7L/YwFpyQr3jW
 +Y25gfGXZBcjJ4eEgInE0afXWboYuTiEBBYzSZzZt54FJCEk8JhR4sAqUxCbTUBd4s6Gb6wg
 toiAlMTLzo3MIDazgIXEuRNX2EBsYYFQiVl/VzKC2CwCqhKNWz+zg9i8ApYSM97MZ4JYJi8x
 89J3sDingJXE/aWNULssJWav2gZVLyhxcuYTFoj58hLNW2dD7ZKQOPjiBTNEvbzEi0vLWWBm
 Tjv3mhnCDpXY+mU70wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgQF
 twgD1w7GvjkehxiZOBgPMUpwMCuJ8IbL3EwV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhV
 SCA9sSQ1OzW1ILUIJsvEwSnVwMjWPN1CPJTXhYGP6++bD5cuBCeHH/W/tMM2M2BfgUyH3MNt
 kTIbrPwYY/J/6+9JC9nEu311VopgxbR/RT2p35h7DWKseXZca+gricoJUN63Ivola1CuiPak
 vW8P6S069lHa5QHbf4eDfyYwRYq83X66cs+Kz7MkxD7W9H3lfNo1W2ONd8guUyWW4oxEQy3m
 ouJEAMs/R81cAgAA
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

Texas Instruments has begun enabling security settings on the SoCs it
produces to instruct ROM and TIFS to begin protecting the Security
Management Subsystem (SMS) from other binaries we load into the chip by
default.

One way ROM and TIFS do this is by enabling firewalls to protect the
OCSRAM and HSM RAM regions they're using during bootup.

The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
itself from the main domain applications. This means the 'bootindex'
value in HSM RAM, left by ROM to indicate if we're using the primary
or secondary boot-method, must be moved to OCSRAM (that TIFS has open
for us) before we make the jump to the main domain so the main domain's
bootloaders can keep access to this information.

Based on commit
  b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/Kconfig                      |  3 ++-
 arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
 arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 03898424c9..f5d06593f7 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x41cffbfc if SOC_K3_J721E
 	default 0x41cfdbfc if SOC_K3_J721S2
 	default 0x701bebfc if SOC_K3_AM642
-	default 0x43c3f290 if SOC_K3_AM625
+	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
+	default 0x7000f290 if SOC_K3_AM625 && ARM64
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
 	help
diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 6c96e88114..67cf63b103 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
 static void store_boot_info_from_rom(void)
 {
 	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
-	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
-	       sizeof(struct rom_extended_boot_data));
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
+		       sizeof(struct rom_extended_boot_data));
+	}
 }
 
 static void ctrl_mmr_unlock(void)
@@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
 		k3_sysfw_loader(true, NULL, NULL);
 	}
 
+#if defined(CONFIG_CPU_V7R)
+	/*
+	 * Relocate boot information to OCRAM (after TIFS has opend this
+	 * region for us) so the next bootloader stages can keep access to
+	 * primary vs backup bootmodes.
+	 */
+	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+#endif
+
 	/*
 	 * Force probe of clk_k3 driver here to ensure basic default clock
 	 * configuration is always done.
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 54380f36e1..9f504f4642 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -76,8 +76,23 @@
 #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
 
 #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
 
+/*
+ * During the boot process ROM will kill anything that writes to OCSRAM.
+ * This means the wakeup SPL cannot use this region during boot. To
+ * complicate things, TIFS will set a firewall between HSM RAM and the
+ * main domain.
+ *
+ * So, during the wakeup SPL, we will need to store the EEPROM data
+ * somewhere in HSM RAM, and the main domain's SPL will need to store it
+ * somewhere in OCSRAM
+ */
+#ifdef CONFIG_CPU_V7R
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
+#else
+ #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001
+#endif /* CONFIG_CPU_V7R */
 
 static inline int k3_get_core_nr(void)
 {
-- 
2.34.1

