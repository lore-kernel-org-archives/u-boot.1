Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E70C54736
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 20:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D9F88A54;
	Tue, 27 Aug 2024 22:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724789063;
	bh=hGxLdTzzqfZrp/knjmdZvQcplxVCym4D2RD2xkpUbY8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d8YEcoZkoTiEt60Q/R6O4VjFM/2r35oho1GRhho0ycf4aNBk1Yh599CCydmPs9VZq
	 HatnywGsG2FXi8xW3kWo7UUENCSGTAbnJ5OzGHf6wPNcFmLLuwgMe7jovV6JOREtMi
	 Ynah2SEmez3GCWvCn+NP7aYQeW4Uzma9/NdhFSCqDPvSNQ899tjMtNMqqS8CbF4mTT
	 bm+ah6KKrtTLi1S+V6+81f2V53+T4xLCJ4TPzDyQuuZ35Yo1Ijh1xM2PddKy5nss5d
	 MlsWyu6LbR+sr5p1AdxUUYCcQyytwIdXQh8dqkMoEdilCNIZYu7Lu1Ecc7WfEI9ljO
	 HqTkISwf7jx0g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C03AC88A30;
 Tue, 27 Aug 2024 22:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724789062;
 bh=hGxLdTzzqfZrp/knjmdZvQcplxVCym4D2RD2xkpUbY8=;
 h=From:To:Cc:Subject:Date:From;
 b=XoUgjwhdgFnqIPSGjzx8ppCoPN82O38zpZpl8ijVqUZrPhxXZc/pxMKipCsh9EWe/
 Po5lnVG/hJFEHeUDuUaB3hfD8D7cvI+lE8JdthkgrM10ZKmIooPBPnuFyi20fJnAgG
 ql/X1iGz+INOyM+BEMRFnTqw80/WcOLgwTm77Bl7z4nJwiclaXoZMi9ASnTQOV+D/n
 per5O0qYgTRkNR0aW/8JhmgBT2LMLJCUnhQtynJTHFSgsqb34c5VA7SAyL94cXj9bl
 rnEH+miXpURt75rmyuaBfOf7r6d64N04cdMzSW5qxWSfklwLnz8e8TvEEaEwZfIf7n
 vdeHP7dh8CXDw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: imx: Enable MMU and dcache very early on i.MX8M
Date: Tue, 27 Aug 2024 22:02:57 +0200
Message-ID: <20240827200400.217058-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Enable MMU and caches very early on in the boot process on i.MX8M
in U-Boot proper. This allows board_init_f to run with icache and
dcache enabled, which saves some 700 milliseconds of boot time on
i.MX8M Plus based device.

The 'bootstage report' output is below:

Before:
```
Timer summary in microseconds (8 records):
       Mark    Elapsed  Stage
          0          0  reset
    961,363    961,363  board_init_f
  1,818,874    857,511  board_init_r
  1,921,474    102,600  eth_common_init
  2,013,702     92,228  eth_initialize
  2,015,238      1,536  main_loop

Accumulated time:
                32,775  dm_r
               289,165  dm_f
```

After:
```
Timer summary in microseconds (8 records):
       Mark    Elapsed  Stage
          0          0  reset
    989,466    989,466  board_init_f
  1,179,100    189,634  board_init_r
  1,281,456    102,356  eth_common_init
  1,373,857     92,401  eth_initialize
  1,375,396      1,539  main_loop

Accumulated time:
                12,630  dm_f
                32,635  dm_r
```

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/imx8m/soc.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index be38ca52885..7ac26d501ac 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -206,6 +206,14 @@ void enable_caches(void)
 	int entry = imx8m_find_dram_entry_in_mem_map();
 	u64 attrs = imx8m_mem_map[entry].attrs;
 
+	/* Deactivate the data cache, possibly enabled in arch_cpu_init() */
+	dcache_disable();
+	/*
+	 * Force the call of setup_all_pgtables() in mmu_setup() by clearing tlb_fillptr
+	 * to update the TLB location udpated in board_f.c::reserve_mmu
+	 */
+	gd->arch.tlb_fillptr = 0;
+
 	while (i < CONFIG_NR_DRAM_BANKS &&
 	       entry < ARRAY_SIZE(imx8m_mem_map)) {
 		if (gd->bd->bi_dram[i].start == 0)
@@ -587,12 +595,50 @@ static void imx8m_setup_csu_tzasc(void)
 	}
 }
 
+/*
+ * Place early TLB into the .data section so that it will not
+ * get cleared, use 16 kiB alignment.
+ */
+#define EARLY_TLB_SIZE SZ_64K
+u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);
+
+/*
+ * Initialize the MMU and activate cache in U-Boot pre-reloc stage
+ * MMU/TLB is updated in enable_caches() for U-Boot after relocation
+ */
+static void early_enable_caches(void)
+{
+	phys_size_t sdram_size;
+	int entry, ret;
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		return;
+
+	if (CONFIG_IS_ENABLED(SYS_ICACHE_OFF) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		return;
+
+	/* Use maximum available DRAM size in first bank. */
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return;
+
+	entry = imx8m_find_dram_entry_in_mem_map();
+	imx8m_mem_map[entry].size = max(sdram_size, (phys_size_t)0xc0000000);
+
+	gd->arch.tlb_size = EARLY_TLB_SIZE;
+	gd->arch.tlb_addr = (unsigned long)&early_tlb;
+
+	/* Enable MMU (default configuration) */
+	dcache_enable();
+}
+
 int arch_cpu_init(void)
 {
 	struct ocotp_regs *ocotp = (struct ocotp_regs *)OCOTP_BASE_ADDR;
 
 #if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
 	icache_enable();
+	early_enable_caches();
 #endif
 
 	/*
-- 
2.45.2

