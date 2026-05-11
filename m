Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F7DCD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9890484715;
	Mon, 11 May 2026 09:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="QMMt5cHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BDF847C7; Mon, 11 May 2026 09:38:06 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D090846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 70269B0054C;
 Mon, 11 May 2026 09:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778485081;
 bh=566IA549MdzllkQd80H3RxEbFvZz73x/oyXADZ1kpUM=;
 h=From:To:Cc:Subject:Date:From;
 b=QMMt5cHaj+ix6IBWj0MKXxmt5dVDzmmrIwRxkYmFrl5CE54GDQn0cZp7PNGH/vQzu
 U38nHojvE93Uj5bpTUmupJWSH+lsKyvmE58K1DaM2omVSJmwnwMT4XRbq7KYhwBZrF
 x6rgnrF0nu2B1+ggfdTZ47YE5gEhRfWA9H2jcgYyDiJb+imP+LmWVL9tJzyu4zY3m4
 b7z8UdNR9U2R8RGHq0IrSocJNU7yf0aEgOFdp/Uy+HDqZyK3x/Hfx2xf0ajPvPUSYO
 9kcO3gY4RCCJrFHhPLb/eYs2c1jsnPUMPrNakzT56NwmUOnNNUC0AqyadgUQ4JSn3L
 3UGRDsbQ1Ohhg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Alice Guo <alice.guo@nxp.com>,
 Chunguang Li <chunguang.li_2@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Tom Rini <trini@konsulko.com>, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v1] board: nxp: lx2160a: without QIXIS, MC-ENET, PCI, LTC3882
Date: Mon, 11 May 2026 09:37:34 +0200
Message-ID: <20260511073746.636424-1-vjardin@free.fr>
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

The shared LX2160A board file calls helpers that only exist when
their subsystem is enabled. Gate them on the matching CONFIG_*:
 - pci_init() under CONFIG_PCI.
 - fdt_fixup_mc_ddr() and fsl_rgmii_init() under CONFIG_FSL_MC_ENET.
 - qixis_*() and the QIXIS branch of checkboard() under
   CONFIG_FSL_QIXIS; cpu_name(buf) moves out so the non-QIXIS path
   still prints "Board: <name>".
 - EVENT_SPY_SIMPLE on init_func_vid moves inside the
   CONFIG_VOL_MONITOR_LTC3882_READ guard (was outside, dangling
   symbol when LTC3882 off).

 #if / #ifdef, not IS_ENABLED(), because the helpers are themselves
conditionally compiled.

While here, lx2160a_common.h: fix BOOT_TARGET_DEVICES_MMC
1 arg vs 2 args and gate the MMC target on CONFIG_CMD_MMC,
not CONFIG_MMC.

No functional change for NXP boards: LX2160ARDB, LX2160AQDS, or
LX2162AQDS, but mainly build clean up in order to support
other NXP lx2160a boards without those HW dependencies.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c |  6 +++++-
 board/nxp/lx2160a/lx2160a.c             | 18 +++++++++++++-----
 include/configs/lx2160a_common.h        |  4 ++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index cfbaa475701..5144a1e3c0e 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1143,7 +1143,7 @@ int arch_early_init_r(void)
 #ifdef CONFIG_SYS_HAS_SERDES
 	fsl_serdes_init();
 #endif
-#ifdef CONFIG_SYS_FSL_HAS_RGMII
+#if defined(CONFIG_SYS_FSL_HAS_RGMII) && defined(CONFIG_FSL_MC_ENET)
 	/* some dpmacs in armv8a based freescale layerscape SOCs can be
 	 * configured via both serdes(sgmii, 10gbase-r, xlaui etc) bits and via
 	 * EC*_PMUX(rgmii) bits in RCW.
@@ -1158,6 +1158,10 @@ int arch_early_init_r(void)
 	 * function of SOC, the dpmac will be enabled as RGMII even if it was
 	 * also enabled before as SGMII. If ECx_PMUX is not configured for
 	 * RGMII, DPMAC will remain configured as SGMII from fsl_serdes_init().
+	 *
+	 * fsl_rgmii_init() itself is only built under CONFIG_FSL_MC_ENET
+	 * (drivers/net/ldpaa_eth/); gate the call the same way so builds
+	 * without MC-ENET still link.
 	 */
 	fsl_rgmii_init();
 #endif
diff --git a/board/nxp/lx2160a/lx2160a.c b/board/nxp/lx2160a/lx2160a.c
index 341f82ce724..da943f161da 100644
--- a/board/nxp/lx2160a/lx2160a.c
+++ b/board/nxp/lx2160a/lx2160a.c
@@ -242,13 +242,17 @@ int init_func_vid(void)
 
 	return 0;
 }
-#endif
 EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, init_func_vid);
+#endif
 
 int checkboard(void)
 {
-	enum boot_src src = get_boot_src();
 	char buf[64];
+
+	cpu_name(buf);
+
+#if IS_ENABLED(CONFIG_FSL_QIXIS)
+	enum boot_src src = get_boot_src();
 	u8 sw;
 #if defined(CONFIG_TARGET_LX2160AQDS) || defined(CONFIG_TARGET_LX2162AQDS)
 	int clock;
@@ -258,7 +262,6 @@ int checkboard(void)
 					   "100 separate SSCG"};
 #endif
 
-	cpu_name(buf);
 #if defined(CONFIG_TARGET_LX2160AQDS) || defined(CONFIG_TARGET_LX2162AQDS)
 	printf("Board: %s-QDS, ", buf);
 #else
@@ -325,7 +328,10 @@ int checkboard(void)
 	clock = sw >> 4;
 	printf("Clock1 = %sMHz Clock2 = %sMHz\n", freq[clock], freq[clock]);
 #endif
-#endif
+#endif /* LX2160ARDB-inside-QIXIS switch */
+#else /* !CONFIG_FSL_QIXIS */
+	printf("Board: %s\n", buf);
+#endif /* CONFIG_FSL_QIXIS */
 	return 0;
 }
 
@@ -554,7 +560,7 @@ int board_init(void)
 	out_le32(irq_ccsr + IRQCR_OFFSET / 4, AQR107_IRQ_MASK);
 #endif
 
-#if !defined(CONFIG_SYS_EARLY_PCI_INIT)
+#if defined(CONFIG_PCI) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
 	pci_init();
 #endif
 	return 0;
@@ -788,7 +794,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	ft_cpu_setup(blob, bd);
 
+#if IS_ENABLED(CONFIG_FSL_MC_ENET)
 	fdt_fixup_mc_ddr(&mc_memory_base, &mc_memory_size);
+#endif
 
 	if (mc_memory_base != 0)
 		mc_memory_bank++;
diff --git a/include/configs/lx2160a_common.h b/include/configs/lx2160a_common.h
index 45b5cbdd85a..dc0d24dca0a 100644
--- a/include/configs/lx2160a_common.h
+++ b/include/configs/lx2160a_common.h
@@ -197,10 +197,10 @@
 #define BOOT_TARGET_DEVICES_USB(func)
 #endif
 
-#ifdef CONFIG_MMC
+#ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_DEVICES_MMC(func, instance) func(MMC, mmc, instance)
 #else
-#define BOOT_TARGET_DEVICES_MMC(func)
+#define BOOT_TARGET_DEVICES_MMC(func, instance)
 #endif
 
 #ifdef CONFIG_SCSI
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/lx2160a-gate-feature-subsystems
