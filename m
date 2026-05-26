Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45831CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 03:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC2E84913;
	Tue, 26 May 2026 05:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PTYXPq3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B30848E6; Tue, 26 May 2026 03:42:27 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDE7848BF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B25B03F735
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779759742;
 bh=ps82Jcq2nf08eToUMLFzJgQIJb4a64eMyAEdwW+FMp0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PTYXPq3NwZvaC+2QtY1DpcICn2fmu6DhcoHwUgTjcxgzyDn0Iih8XAwv0gkpVcFjx
 wpR0MougT/W21kyCy5IN2B8XpVsipUwyWjocQFR1BsXJY3j3sEzyafTrYdrYxr39MR
 WYGF7WGYtSA93CYU+RXPcquGD6m3V6JSaGKSSn3LI1F/2eQFwxxz6gz+P3ELWCRMrY
 vthDvnGfTGsNkb7pSGw1spC5pG58AHacynjBe+blmzANBK08AdALMXspcAFr3Cbd/R
 cedGxC6SAY8cCTcDTDPvIFMVRYEl0zKoI0s511uQcXc/4Cmvfr36L9kEatcHo2xmke
 3JiqXIIAO87vsevVs9Mxd33OCBwm3EHNxZDrs67bAYDUMAe7FQFLjBRfEFJsQ0f0C6
 cc2pRCD9pF8cRwsIcfBn1Bv6/EmsD/JhjT/LEq9tz+bRDt+qyfBns6eWrd3LxB5B8t
 p/xB5RNxRq9VhVDmgwyFEpqlOowTSwZATbuixS831keYni7at3LMsph+FU5SNFUnB2
 pPZKBNhV4AMvjWu2Y82db2Lj+6cTjJunrYWq18eWPaaFe3zDgobb5Y7GmqGMoIlxBm
 BLkAnABLspTWRMBNK9r5yPYcQMXrnzCcS5SJlOAOS+8hyx/e8ZE7wT29XLKjM3BFE1
 ysVCBKOyqeHw4MUR2Hv5+EMc=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3684cb22502so9117420a91.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 18:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779759741; x=1780364541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ps82Jcq2nf08eToUMLFzJgQIJb4a64eMyAEdwW+FMp0=;
 b=MLauFiYyBOtVQhd6ENF7fsbikmmhBmB7LrCmAD2+RWUbnsJKMiwM4WnXFeIGdEIxKU
 o6JiuS+err1edDAxZR6ghIYdX8hPkSXVMIrLH3corwGM79ENlQZatSWDfIyt15QI7375
 OScSPatblZivdUiJ4MQK0W3L9ULxv29kbHzS/BsMX3TRxlxxez0lrrcIeT4Nl/c2IF1q
 CrB51IZzaQ5VyY/5l6C31/47frlLLayEzB99tPJUCtM6z+USbOp01/EGONDehybiPYtU
 rF4jqUQZbc6vsxv9knp4UdlyOBnXtRXUmm3etwrkePamLj4pq3rhZxJQ5NpPbAq0IvSY
 fHUw==
X-Gm-Message-State: AOJu0Yx6SwjeTFCsQRIvzAtwH6yEvo6rIClJZ4yAXnCYbNRhl6yUYJY8
 pXoymnS5A1G0vEnxhVLAX2lUsNrYXh9kGPvIcw2luffpU/mFFVO+/i2NJ1IRjWMmcv9uOXK9sQd
 icIGxnhSncWqDfDscp95/61PBm7ft1j7oI5Pd4w6TZ7SLZc5Mf/X3K0zlMrG+D/fWhlLn6QG0L/
 01OGDnd3ZC
X-Gm-Gg: Acq92OHj2euUzEeLUCRK/5mc+WpKKBJtCjywHng5SIoQZzd0j0B0bn47ns5pyJfst0L
 wRln9+V3HqjmumBmKBqlNgCnQ8A3pKW8JKmoPTElVUYNmXrLYpIM6c8GPc9WFxUGWf97ZeQQLH7
 5K0J8XObrvq64wd7YoFRD7Ab7HsNzcE5CRzanwqlJCtM7BfvBybm2kgzKExg8527vVoAka2vugd
 bgVsex7Pr5jaHY6mJjZ1ECeGEZlg41yVCCJa0tLtC1xMT9rw7Uc/873MAiZmr1wXxBzavvKb0q6
 wsNqJ8wYzO0ZiZy+BtsRDY3wrTjyxIttMHe+n3Fz9SOcejrGN/E0h6XMQ47PiARSLTpBsfuKWQr
 hIzkuMyKbxemIzEZBYwDqGUPPPS2bb0ySooJ+4aQu3IH85TnExq2LoSDdrJd7OGaboo7m+Yl6dM
 SsymtViItrN2aBzIk=
X-Received: by 2002:a17:90b:4b52:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36a67508574mr15578612a91.16.1779759740969; 
 Mon, 25 May 2026 18:42:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4b52:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36a67508574mr15578579a91.16.1779759740457; 
 Mon, 25 May 2026 18:42:20 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7263178dsm14398196a91.3.2026.05.25.18.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 18:42:18 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Siddarth Gore <gores@marvell.com>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Adriana Nicolae <adriana@arista.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Javen Xu <javen_xu@realsil.com.cn>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Francois Berder <fberder@outlook.fr>
Subject: [PATCH v1 1/1] treewide: prefer __func__ over __FUNCTION__ and
 __PRETTY_FUNCTION__
Date: Tue, 26 May 2026 01:41:40 +0000
Message-ID: <20260526014144.3519-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526014144.3519-1-aristo.chen@canonical.com>
References: <20260526014144.3519-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 05:44:15 +0200
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

__FUNCTION__ and __PRETTY_FUNCTION__ are gcc extensions that predate
the C99 __func__ identifier. scripts/checkpatch.pl emits a warning
for any new use of __FUNCTION__ and recommends __func__ instead. In
C (unlike C++) __PRETTY_FUNCTION__ is identical to __func__ because
C function names do not carry signature information, so the
distinction has no behavioural effect here. The majority of the tree
already uses __func__, but a handful of older files in arch/, board/,
boot/, drivers/, examples/ and include/ still carry the gcc spellings
(55 occurrences of __FUNCTION__ across 19 files plus one
__PRETTY_FUNCTION__ in drivers/usb/musb-new/omap2430.c). Convert
them all to the C99 form so the tree is consistent and new patches
in these areas do not have to follow an outdated local style.

Ten "Unnecessary ftrace-like logging - prefer using ftrace" warnings
remain on the printf("%s\n", __func__) and dbg("%s\n", __func__)
function-entry traces in drivers/net/rtl8169.c (behind DEBUG_RTL8169*
preprocessor guards) and drivers/usb/host/ohci-hcd.c. checkpatch
matches the literal "%s\n", __func__ shape regardless of the wrapper,
so silencing those warnings would require changing the debug message
text or removing the traces entirely.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/mach-kirkwood/cpu.c       | 10 +++++-----
 arch/mips/include/asm/system.h     |  4 ++--
 arch/powerpc/cpu/mpc85xx/liodn.c   |  2 +-
 board/Marvell/guruplug/guruplug.c  |  2 +-
 board/socrates/nand.c              |  2 +-
 boot/fdt_support.c                 | 14 +++++++-------
 drivers/ddr/fsl/main.c             |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen1.c |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen2.c |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen3.c |  2 +-
 drivers/fpga/spartan2.c            | 12 ++++++------
 drivers/fpga/spartan3.c            | 12 ++++++------
 drivers/fpga/xilinx.c              | 12 ++++++------
 drivers/net/mcfmii.c               |  2 +-
 drivers/net/rtl8169.c              | 18 +++++++++---------
 drivers/rtc/m41t62.c               |  4 ++--
 drivers/usb/host/ohci-hcd.c        |  2 +-
 drivers/usb/musb-new/omap2430.c    |  2 +-
 examples/standalone/sched.c        |  2 +-
 include/usbdevice.h                |  6 +++---
 20 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-kirkwood/cpu.c b/arch/arm/mach-kirkwood/cpu.c
index a432abe615d..af59d63811c 100644
--- a/arch/arm/mach-kirkwood/cpu.c
+++ b/arch/arm/mach-kirkwood/cpu.c
@@ -99,16 +99,16 @@ static void kw_sysrst_action(void)
 
 	if (!s) {
 		debug("Error.. %s failed, check sysrstcmd\n",
-			__FUNCTION__);
+			__func__);
 		return;
 	}
 
-	debug("Starting %s process...\n", __FUNCTION__);
+	debug("Starting %s process...\n", __func__);
 	ret = run_command(s, 0);
 	if (ret != 0)
-		debug("Error.. %s failed\n", __FUNCTION__);
+		debug("Error.. %s failed\n", __func__);
 	else
-		debug("%s process finished\n", __FUNCTION__);
+		debug("%s process finished\n", __func__);
 }
 
 static void kw_sysrst_check(void)
@@ -152,7 +152,7 @@ int print_cpuinfo(void)
 	u8 revid = readl(KW_REG_PCIE_REVID) & 0xff;
 
 	if ((readl(KW_REG_DEVICE_ID) & 0x03) > 2) {
-		printf("Error.. %s:Unsupported Kirkwood SoC 88F%04x\n", __FUNCTION__, devid);
+		printf("Error.. %s:Unsupported Kirkwood SoC 88F%04x\n", __func__, devid);
 		return -1;
 	}
 
diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index 00699c4c11a..1156e299433 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -259,9 +259,9 @@ extern void __die_if_kernel(const char *, struct pt_regs *, const char *where,
 	unsigned long line);
 
 #define die(msg, regs)							\
-	__die(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die(msg, regs, __FILE__ ":" __func__, __LINE__)
 #define die_if_kernel(msg, regs)					\
-	__die_if_kernel(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die_if_kernel(msg, regs, __FILE__ ":" __func__, __LINE__)
 
 static inline void execution_hazard_barrier(void)
 {
diff --git a/arch/powerpc/cpu/mpc85xx/liodn.c b/arch/powerpc/cpu/mpc85xx/liodn.c
index af6731cbb3a..ddf0ac99cf6 100644
--- a/arch/powerpc/cpu/mpc85xx/liodn.c
+++ b/arch/powerpc/cpu/mpc85xx/liodn.c
@@ -110,7 +110,7 @@ static void setup_fman_liodn_base(enum fsl_dpaa_dev dev,
 		break;
 #endif
 	default:
-		printf("Error: Invalid device type to %s\n", __FUNCTION__);
+		printf("Error: Invalid device type to %s\n", __func__);
 		return;
 	}
 
diff --git a/board/Marvell/guruplug/guruplug.c b/board/Marvell/guruplug/guruplug.c
index 7c3cea22b93..78a6d1094b5 100644
--- a/board/Marvell/guruplug/guruplug.c
+++ b/board/Marvell/guruplug/guruplug.c
@@ -111,7 +111,7 @@ void mv_phy_88e1121_init(char *name)
 	/* command to read PHY dev address */
 	if (miiphy_read(name, 0xEE, 0xEE, (u16 *) &devadr)) {
 		printf("Err..%s could not read PHY dev address\n",
-			__FUNCTION__);
+			__func__);
 		return;
 	}
 
diff --git a/board/socrates/nand.c b/board/socrates/nand.c
index b8e6e2cd76e..fc0c04efdd1 100644
--- a/board/socrates/nand.c
+++ b/board/socrates/nand.c
@@ -135,7 +135,7 @@ static void sc_nand_hwcontrol(struct mtd_info *mtdinfo, int cmd, unsigned int ct
 			break;
 
 		default:
-			printf("%s: unknown ctrl %#x\n", __FUNCTION__, ctrl);
+			printf("%s: unknown ctrl %#x\n", __func__, ctrl);
 		}
 
 		if (ctrl & NAND_NCE)
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 1c215e548db..c4d3cc043c5 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -545,13 +545,13 @@ int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[], int banks)
 	if (banks > MEMORY_BANKS_MAX) {
 		printf("%s: num banks %d exceeds hardcoded limit %d."
 		       " Recompile with higher MEMORY_BANKS_MAX?\n",
-		       __FUNCTION__, banks, MEMORY_BANKS_MAX);
+		       __func__, banks, MEMORY_BANKS_MAX);
 		return -1;
 	}
 
 	err = fdt_check_header(blob);
 	if (err < 0) {
-		printf("%s: %s\n", __FUNCTION__, fdt_strerror(err));
+		printf("%s: %s\n", __func__, fdt_strerror(err));
 		return err;
 	}
 
@@ -1497,7 +1497,7 @@ static u64 __of_translate_address(const void *blob, int node_offset,
 	/* Cound address cells & copy address locally */
 	bus->count_cells(blob, parent, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, node_offset, NULL));
 		goto bail;
 	}
@@ -1524,8 +1524,8 @@ static u64 __of_translate_address(const void *blob, int node_offset,
 		pbus = of_match_bus(blob, parent);
 		pbus->count_cells(blob, parent, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
-			printf("%s: Bad cell count for %s\n", __FUNCTION__,
-				fdt_get_name(blob, node_offset, NULL));
+			printf("%s: Bad cell count for %s\n", __func__,
+			       fdt_get_name(blob, node_offset, NULL));
 			break;
 		}
 
@@ -1612,7 +1612,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 	bus_node = of_match_bus(blob, node);
 	bus_node->count_cells(blob, node, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, node, NULL));
 		return -EINVAL;
 		goto out;
@@ -1621,7 +1621,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 	bus_node = of_match_bus(blob, parent);
 	bus_node->count_cells(blob, parent, &pna, &pns);
 	if (!OF_CHECK_COUNTS(pna, pns)) {
-		printf("%s: Bad cell count for %s\n", __FUNCTION__,
+		printf("%s: Bad cell count for %s\n", __func__,
 		       fdt_get_name(blob, parent, NULL));
 		return -EINVAL;
 		goto out;
diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index d59e94779ff..2b879c63b5f 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -221,7 +221,7 @@ void fsl_ddr_get_spd(generic_spd_eeprom_t *ctrl_dimms_spd,
 	unsigned int i2c_address = 0;
 
 	if (ctrl_num >= CONFIG_SYS_NUM_DDR_CTLRS) {
-		printf("%s unexpected ctrl_num = %u\n", __FUNCTION__, ctrl_num);
+		printf("%s unexpected ctrl_num = %u\n", __func__, ctrl_num);
 		return;
 	}
 
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen1.c b/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
index a8520754006..e43dc869fc5 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
@@ -21,7 +21,7 @@ void fsl_ddr_set_memctl_regs(const fsl_ddr_cfg_regs_t *regs,
 		(struct ccsr_ddr __iomem *)CFG_SYS_FSL_DDR_ADDR;
 
 	if (ctrl_num != 0) {
-		printf("%s unexpected ctrl_num = %u\n", __FUNCTION__, ctrl_num);
+		printf("%s unexpected ctrl_num = %u\n", __func__, ctrl_num);
 		return;
 	}
 
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen2.c b/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
index 00b4b376dd4..3a8ad6cc86b 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
@@ -26,7 +26,7 @@ void fsl_ddr_set_memctl_regs(const fsl_ddr_cfg_regs_t *regs,
 #endif
 
 	if (ctrl_num) {
-		printf("%s unexpected ctrl_num = %u\n", __FUNCTION__, ctrl_num);
+		printf("%s unexpected ctrl_num = %u\n", __func__, ctrl_num);
 		return;
 	}
 
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen3.c b/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
index b0a61fa2b41..ee9811481ab 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
@@ -71,7 +71,7 @@ void fsl_ddr_set_memctl_regs(const fsl_ddr_cfg_regs_t *regs,
 		break;
 #endif
 	default:
-		printf("%s unexpected ctrl_num = %u\n", __FUNCTION__, ctrl_num);
+		printf("%s unexpected ctrl_num = %u\n", __func__, ctrl_num);
 		return;
 	}
 
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index 792e4033428..e3715bf2b24 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -52,7 +52,7 @@ static int spartan2_load(xilinx_desc *desc, const void *buf, size_t bsize,
 
 	default:
 		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
+				__func__, desc->iface);
 	}
 
 	return ret_val;
@@ -75,7 +75,7 @@ static int spartan2_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 
 	default:
 		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
+				__func__, desc->iface);
 	}
 
 	return ret_val;
@@ -234,7 +234,7 @@ static int spartan2_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -279,7 +279,7 @@ static int spartan2_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 
 		/* XXX - checksum the data? */
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -423,7 +423,7 @@ static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -434,7 +434,7 @@ static int spartan2_ss_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 	/* Readback is only available through the Slave Parallel and         */
 	/* boundary-scan interfaces.                                         */
 	printf ("%s: Slave Serial Dumping is unavailable\n",
-			__FUNCTION__);
+			__func__);
 	return FPGA_FAIL;
 }
 
diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
index 98405589134..6221041e092 100644
--- a/drivers/fpga/spartan3.c
+++ b/drivers/fpga/spartan3.c
@@ -57,7 +57,7 @@ static int spartan3_load(xilinx_desc *desc, const void *buf, size_t bsize,
 
 	default:
 		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
+				__func__, desc->iface);
 	}
 
 	return ret_val;
@@ -80,7 +80,7 @@ static int spartan3_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 
 	default:
 		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
+				__func__, desc->iface);
 	}
 
 	return ret_val;
@@ -241,7 +241,7 @@ static int spartan3_sp_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -286,7 +286,7 @@ static int spartan3_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 
 		/* XXX - checksum the data? */
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -442,7 +442,7 @@ static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
 #endif
 
 	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
+		printf("%s: NULL Interface function table!\n", __func__);
 	}
 
 	return ret_val;
@@ -453,7 +453,7 @@ static int spartan3_ss_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 	/* Readback is only available through the Slave Parallel and         */
 	/* boundary-scan interfaces.                                         */
 	printf ("%s: Slave Serial Dumping is unavailable\n",
-			__FUNCTION__);
+			__func__);
 	return FPGA_FAIL;
 }
 
diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 44d7ad6bd54..b6966c7d2cb 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -149,8 +149,8 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 int xilinx_load(xilinx_desc *desc, const void *buf, size_t bsize,
 		bitstream_type bstype, int flags)
 {
-	if (!xilinx_validate (desc, (char *)__FUNCTION__)) {
-		printf ("%s: Invalid device descriptor\n", __FUNCTION__);
+	if (!xilinx_validate(desc, (char *)__func__)) {
+		printf("%s: Invalid device descriptor\n", __func__);
 		return FPGA_FAIL;
 	}
 
@@ -200,8 +200,8 @@ int xilinx_loads(xilinx_desc *desc, const void *buf, size_t bsize,
 
 int xilinx_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 {
-	if (!xilinx_validate (desc, (char *)__FUNCTION__)) {
-		printf ("%s: Invalid device descriptor\n", __FUNCTION__);
+	if (!xilinx_validate(desc, (char *)__func__)) {
+		printf("%s: Invalid device descriptor\n", __func__);
 		return FPGA_FAIL;
 	}
 
@@ -217,7 +217,7 @@ int xilinx_info(xilinx_desc *desc)
 {
 	int ret_val = FPGA_FAIL;
 
-	if (xilinx_validate (desc, (char *)__FUNCTION__)) {
+	if (xilinx_validate(desc, (char *)__func__)) {
 		printf ("Family:        \t");
 		switch (desc->family) {
 		case xilinx_spartan2:
@@ -293,7 +293,7 @@ int xilinx_info(xilinx_desc *desc)
 
 		ret_val = FPGA_SUCCESS;
 	} else {
-		printf ("%s: Invalid device descriptor\n", __FUNCTION__);
+		printf("%s: Invalid device descriptor\n", __func__);
 	}
 
 	return ret_val;
diff --git a/drivers/net/mcfmii.c b/drivers/net/mcfmii.c
index 9bf887035d7..79ad6348de8 100644
--- a/drivers/net/mcfmii.c
+++ b/drivers/net/mcfmii.c
@@ -112,7 +112,7 @@ uint mii_send(uint mii_cmd)
 	ep->eir = FEC_EIR_MII;	/* clear MII complete */
 #ifdef ET_DEBUG
 	printf("%s[%d] %s: sent=0x%8.8x, reply=0x%8.8x\n",
-	       __FILE__, __LINE__, __FUNCTION__, mii_cmd, mii_reply);
+	       __FILE__, __LINE__, __func__, mii_cmd, mii_reply);
 #endif
 
 	return (mii_reply & 0xffff);	/* data read from phy */
diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 5b093623619..e203faed26b 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -404,7 +404,7 @@ static int rtl8169_init_board(unsigned long dev_iobase, const char *name)
 	u32 tmp;
 
 #ifdef DEBUG_RTL8169
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 	ioaddr = dev_iobase;
 
@@ -534,7 +534,7 @@ static int rtl_recv_common(struct udevice *dev, unsigned long dev_iobase,
 	int length = 0;
 
 #ifdef DEBUG_RTL8169_RX
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 	ioaddr = dev_iobase;
 
@@ -608,7 +608,7 @@ static int rtl_send_common(struct udevice *dev, unsigned long dev_iobase,
 
 #ifdef DEBUG_RTL8169_TX
 	int stime = currticks();
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 	printf("sending %d bytes\n", len);
 #endif
 
@@ -679,7 +679,7 @@ static void rtl8169_set_rx_mode(void)
 	u32 tmp = 0;
 
 #ifdef DEBUG_RTL8169
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 
 	/* IFF_ALLMULTI */
@@ -701,7 +701,7 @@ static void rtl8169_hw_start(struct udevice *dev)
 
 #ifdef DEBUG_RTL8169
 	int stime = currticks();
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 
 #if 0
@@ -771,7 +771,7 @@ static void rtl8169_init_ring(struct udevice *dev)
 
 #ifdef DEBUG_RTL8169
 	int stime = currticks();
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 
 	tpc->cur_rx = 0;
@@ -810,7 +810,7 @@ static void rtl8169_common_start(struct udevice *dev, unsigned char *enetaddr,
 
 #ifdef DEBUG_RTL8169
 	int stime = currticks();
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 
 	ioaddr = dev_iobase;
@@ -851,7 +851,7 @@ static void rtl_halt_common(struct udevice *dev)
 	int i;
 
 #ifdef DEBUG_RTL8169
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 
 	ioaddr = priv->iobase;
@@ -906,7 +906,7 @@ static int rtl_init(unsigned long dev_ioaddr, const char *name,
 	int option = -1, Cap10_100 = 0, Cap1000 = 0;
 
 #ifdef DEBUG_RTL8169
-	printf ("%s\n", __FUNCTION__);
+	printf("%s\n", __func__);
 #endif
 	ioaddr = dev_ioaddr;
 
diff --git a/drivers/rtc/m41t62.c b/drivers/rtc/m41t62.c
index 7bfea9e0b31..b3734baf63e 100644
--- a/drivers/rtc/m41t62.c
+++ b/drivers/rtc/m41t62.c
@@ -66,7 +66,7 @@ static void m41t62_update_rtc_time(struct rtc_time *tm, u8 *buf)
 {
 	debug("%s: raw read data - sec=%02x, min=%02x, hr=%02x, "
 	      "mday=%02x, mon=%02x, year=%02x, wday=%02x, y2k=%02x\n",
-	      __FUNCTION__,
+	      __func__,
 	      buf[0], buf[1], buf[2], buf[3],
 	      buf[4], buf[5], buf[6], buf[7]);
 
@@ -83,7 +83,7 @@ static void m41t62_update_rtc_time(struct rtc_time *tm, u8 *buf)
 
 	debug("%s: tm is secs=%d, mins=%d, hours=%d, "
 	      "mday=%d, mon=%d, year=%d, wday=%d\n",
-	      __FUNCTION__,
+	      __func__,
 	      tm->tm_sec, tm->tm_min, tm->tm_hour,
 	      tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 }
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1d6711ccec4..3fcf9d53d59 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1750,7 +1750,7 @@ static int hc_reset(ohci_t *ohci)
 	int timeout = 30;
 	int smm_timeout = 50; /* 0,5 sec */
 
-	dbg("%s\n", __FUNCTION__);
+	dbg("%s\n", __func__);
 
 #ifdef CONFIG_PCI_EHCI_DEVNO
 	/*
diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index 7fd6639013a..c8c6bf0c84f 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -100,7 +100,7 @@ static int omap2430_musb_enable(struct musb *musb)
 #ifdef CONFIG_TWL4030_USB
 	if (twl4030_usb_ulpi_init()) {
 		serial_printf("ERROR: %s Could not initialize PHY\n",
-				__PRETTY_FUNCTION__);
+				__func__);
 	}
 #endif
 	return 0;
diff --git a/examples/standalone/sched.c b/examples/standalone/sched.c
index 64518c6890f..969628350d5 100644
--- a/examples/standalone/sched.c
+++ b/examples/standalone/sched.c
@@ -58,7 +58,7 @@ static uchar dbg = 0;
 
 #define PDEBUG(fmt, args...)	 {					\
 	if(dbg != 0) {							\
-		printf("[%s %d %s]: ",__FILE__,__LINE__,__FUNCTION__);\
+		printf("[%s %d %s]: ", __FILE__, __LINE__, __func__);\
 		printf(fmt, ##args);				\
 		printf("\n");					\
 	}								\
diff --git a/include/usbdevice.h b/include/usbdevice.h
index d173c1c4e37..76fda5ff90b 100644
--- a/include/usbdevice.h
+++ b/include/usbdevice.h
@@ -22,19 +22,19 @@
 #define MAX_URBS_QUEUED 5
 
 #if 1
-#define usberr(fmt,args...) serial_printf("ERROR: %s(), %d: "fmt"\n",__FUNCTION__,__LINE__,##args)
+#define usberr(fmt, args...) serial_printf("ERROR: %s(), %d: " fmt "\n", __func__, __LINE__, ##args)
 #else
 #define usberr(fmt,args...) do{}while(0)
 #endif
 
 #if 0
-#define usbdbg(fmt,args...) serial_printf("debug: %s(), %d: "fmt"\n",__FUNCTION__,__LINE__,##args)
+#define usbdbg(fmt, args...) serial_printf("debug: %s(), %d: " fmt "\n", __func__, __LINE__, ##args)
 #else
 #define usbdbg(fmt,args...) do{}while(0)
 #endif
 
 #if 0
-#define usbinfo(fmt,args...) serial_printf("info: %s(), %d: "fmt"\n",__FUNCTION__,__LINE__,##args)
+#define usbinfo(fmt, args...) serial_printf("info: %s(), %d: " fmt "\n", __func__, __LINE__, ##args)
 #else
 #define usbinfo(fmt,args...) do{}while(0)
 #endif
-- 
2.43.0

