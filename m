Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E0CC6B3D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82A0B8127E;
	Thu, 15 Oct 2026 14:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbBSC3G5-Wgl; Thu, 15 Oct 2026 14:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37CD28127A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074644;
	b=gIFVAMn1NIkJ4vJZcOJlDCUlqei/vSHnSvTMwZa1ZnTcg8z65ryYeFtpwP020EP1BNYW
	 /pOdWiprTxyYJNUOo0UU41dgXAYb+U5AnpxT6PyJlI+ulCkwOnbeJ/SdpF4eZk8lfxdGB
	 jBqYJ6UsLNgt6PNeOBOU/o4nn+YJmm6HXpyqmHGIy+3vTQzv4w/BdSu/RJ5K2XAs6VPi5
	 Ixm/kwIviT2xOF17p2AaI34HWMBq2XBxF0yN4MxWIUhNomjD8xcIwy7D+6QZK9fRIpUe3
	 8JSCIDFcfjlcT9JieAny1MOFktfZKhdOEVT+rkT/iU37WQZ5m2xvtWTfz5BUdvB/3Jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U/qtmD00IMCpWdMehaob/yYfgEgpx1O6w1vIlwInu5I=;
	b=IDaZD5VFX9eNK2a0Muo8Uhk4qOyy/P8R1vVS5NTBhUpRmkpf54023LWZkfqF+PDjWlzF
	 l+rmNw3XA9fxhYOVlJGFNLZwt7FEZPsQiMQFm6oiEYwh+XI/P4BKrDzF+EPa6lP5ui5Ly
	 0YUUElL5cW65wNlJytNDnp8I3GXdD9PTPMrfnsVnT5B5Z55xinL29zbQg2+aIj4FU3thH
	 SFPJMjIrMtaoR8EPuvMOFYTQhnRDCE2Vzlpa5EvZhWl0r1ZoLSpHjuVFloUh5u4ok1xF4
	 LThdVq+OXELN8zNzOs1E23jIrj4XUHjzxazi6COUuNJAh1QEo9QbM7x7NN5XDe7/vig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074644;
	bh=U/qtmD00IMCpWdMehaob/yYfgEgpx1O6w1vIlwInu5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HMaPd7baFDDPQX4Fbyd+vg/bE8qfHDGuVCjwe2KJSQ4gT6wamqQJ4kV1tYLZ3zkWX
	 MzQDLMT6TOqRmumP/Z/yoef0iZ/KgfHeOB/5U+cph/HlsEoVDdFKlbtN+vlfIZX0L8
	 SrJ0obrU82RY+ianef9UskiQiN09BrRVE9PMu7BuS2eQk9KSStciQZdwxORiml1RQ/
	 wOv8i+UXuvEcbgEEZ0vPb0e+DqO+ora0lfvvyOOn3bm9PvOJEG8nshtVsEinrIa14J
	 ck4EcAxhkSlniNfn8tINLBWDygPlVItUsXLV47Ib7RMWc0zpSTBs+K69MpQxfqsPNl
	 gWvQG7Y9RyMLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37CD28127A;
	Thu, 15 Oct 2026 14:30:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46345105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 380EC60821
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubS-kzwZEn_K for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EF1A605B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074638;
 b=UzEv65AaRYODLngUbxqMBb9Qiv754z9i2fMTli90kBrAmoe9CsLp/i5S85+ilSR1TtkD
 zHfgVbpvxLXvEbvBuRg2oM/V8rA/Q+tWbeRXS3AZI6nM5vXbKY4oGzfrj9LJxwh+W4Ay/
 Ff6e01N3ZL4+kfgoGOhcsEjR7UvvlJps39reMX/KajtQ3KXKrxRNH5J4/6sGGo0wXWifP
 ofxcRAgQPuOgFt3GP+tTGBzsoBmx8dPDUltdxsNSznab73K/Mt/T+ZLTxz6VJ8M0tp1Hi
 CMY4Vk3ZmtVePWpRz2XvBCD3CKslYpjKqEhSydQx7oHNIKmQa3+E0xLcXz0bIEFJIPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074638;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=U/qtmD00IMCpWdMehaob/yYfgEgpx1O6w1vIlwInu5I=;
 b=kblj/hFVr75+CF3ox8jp8H+1bv9LeJpZjJdLfOEMnbtIBOUG+XemuboSf63gOdOTveEF
 GEB7k147bx9j1QzEvZYXyIvVeiMmBTbsOt35PEg1yhto9NQnrlKTXf+ANHKVwSRHizDQM
 2f18GYPSf8Uqow9/bKrVOIzPzPIpyytonF/XBkhsQqtNCI87PGBak/WUvZcmlLc8PzrXZ
 0xKUTFctPxrnW5RVocTUPFGzXEzrm9ZaT2NZRl3RcBoPgblRz7O7aDkAmHmkUWcUHaCo0
 t2uFeyBGXPvX7xcveUuqFxfvW1ZbS/KVtNEgXuK10RpS9RrvKW1ToOHANh3Ez7SJ6ug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=iLRrlTuy; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=iLRrlTuy
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EF1A605B0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:36 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792074319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/qtmD00IMCpWdMehaob/yYfgEgpx1O6w1vIlwInu5I=;
 b=iLRrlTuyCySqAfx8/JPmrCsBECBFHOhH5Z2c0BOnjMZK11LceQHKgxw+GiUCIOLCuM28l7
 zk+plnbVRV6jSTRXnbHQITOcHVrJepaJvFS+65uLAgJouCqdrlOlWAh7KUBAzMbySDZj8g
 dzGqKOYHCTg35NXzOTJSJBriNs9z+xpI51Eq97Q/s/MIMmU8RUWhW8gDNS3gAda5oHP8qJ
 IFNOFwudGEZ0ktFRKJrqwATuh5KfrDxDGgTNpVWAMjVDV3LtXQmgRLfyPpNSLiEKFlDVxm
 b7wxOWw1aqcbPeh138yCon0QN/LtC+Fw3MdnXHD9pw+MYnkkLhKTCE34y+gmVg==
Date: Thu, 15 Oct 2026 16:24:48 +0200
Subject: [PATCH 2/3] ddr: imx: Recreate the power-on state before repeating
 ddr_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-feature-main-imx8m-ddr-reinit-v1-2-994706166ada@kontron.de>
References: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
In-Reply-To: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10361;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=w107ajKcRFh9w3JWzrEDg/J1EZD1BlQd1WjJABxieyg=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevCI79Dy6wCnTi2vPJXOCv0SvyoZNjO10ty/tyZ5rY5S
 9vIptW4o5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCIPuRn+Ci9RaDJil3h3oWbv
 rUVcvmucA7UU0toXH+E4HSKX8eNxEiPDyjC/GTk3NNSlrQTTn+0qTFw0YzXn513xX/9N3v43NvM
 2AwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Boards that support several DDR types probe them by calling ddr_init()
with different configurations until one of them succeeds. The power up
procedure at the beginning of ddr_init() assumes a DDRMIX that is still
in its power-on state, which is only true for the first call.

Repeating the initialization after a failed run happens to work, as such
a run never gets to the point where it configures the DDR device and
leaves a trained state behind. Repeating it after a successful run does
not: the DDRC is in normal operating mode and the PHY holds the results
of the previous training run in registers that neither ddrphy_cfg[] nor
the SRC resets cover. The next ddr_init() still reports a successful
training, but the DRAM is not functional afterwards.

This is reproducible on a Kontron OSM-S i.MX8MP with 4GB DDR: the 8GB
configuration is tried first and succeeds, the following init with the
4GB configuration returns success and the first access to the DRAM
freezes the SoC.

Bring the DDRMIX back to a defined state before repeating the
initialization. Stop the DRAM traffic and the periodic controller
activity, park DfiClk on the bypass clock and power cycle the DDRMIX
domain. Asserting the reset chain alone is not sufficient, only removing
the power returns the PHY to its defaults. The power down sequence
follows dram_enter_retention() in TF-A, which powers the domain down for
retention suspend.

This is implemented for i.MX8MM, i.MX8MN and i.MX8MP. The i.MX8MQ has a
second DDR domain that would need its own handling, so it is skipped
there and repeating ddr_init() behaves as before.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/include/asm/arch-imx8m/imx-regs.h |  10 ++
 drivers/ddr/imx/imx8m/ddr_init.c           | 172 +++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx8m/imx-regs.h b/arch/arm/include/asm/arch-imx8m/imx-regs.h
index 95a8cc1c637..150cd0a0c92 100644
--- a/arch/arm/include/asm/arch-imx8m/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8m/imx-regs.h
@@ -130,10 +130,20 @@
 #define SRC_SCR_M4C_NON_SCLR_RST_MASK	BIT(0)
 #define SRC_DDR1_ENABLE_MASK		0x8F000000UL
 #define SRC_DDR2_ENABLE_MASK		0x8F000000UL
+#define SRC_DDR1_RCR_SYS_RESET_MASK	BIT(4)
 #define SRC_DDR1_RCR_PHY_PWROKIN_N_MASK	BIT(3)
 #define SRC_DDR1_RCR_PHY_RESET_MASK	BIT(2)
 #define SRC_DDR1_RCR_CORE_RESET_N_MASK	BIT(1)
 #define SRC_DDR1_RCR_PRESET_N_MASK	BIT(0)
+/*
+ * All of the above, a set bit always means "reset asserted". Bit 5
+ * (DDRC1_PHY_WRST) is left out, the power up procedure doesn't use it either.
+ */
+#define SRC_DDR1_RCR_ALL_RESET_MASK	(SRC_DDR1_RCR_SYS_RESET_MASK | \
+					 SRC_DDR1_RCR_PHY_PWROKIN_N_MASK | \
+					 SRC_DDR1_RCR_PHY_RESET_MASK | \
+					 SRC_DDR1_RCR_CORE_RESET_N_MASK | \
+					 SRC_DDR1_RCR_PRESET_N_MASK)
 
 #define SNVS_LPSR			0x4c
 #define SNVS_LPLVDR			0x64
diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index 0706face14a..8e059249ef6 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -9,19 +9,39 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
 
 /* GPC registers for the DDRMIX (DDR1) power domain */
 #ifdef CONFIG_IMX8MP
 #define GPC_PGC_CPU_MAPPING		0x1cc
 #define GPC_PGC_CPU_MAPPING_ALL		0x003fffff
 #define GPC_PU_PGC_SW_PUP_REQ		0x0d8
+#define GPC_PU_PGC_SW_PDN_REQ		0x0e4
+#define GPC_PU_PWRHSK			0x190
 #define GPC_DDR1_SW_Pxx_REQ		BIT(19)
+#define GPC_DDRMIX_ADB400_SYNC		BIT(11)
+#define GPC_DDRMIX_ADB400_ACK		BIT(27)
+/* DDRMIX is PGC 31 and occupies 0xfc0 - 0xfff */
+#define GPC_PGC_DDR1_CTRL		0xfc0
 #else
+/*
+ * i.MX8MQ shares the registers used by the power up procedure, but has
+ * different ADB400 handshake bits. It doesn't use the DDRMIX reset, though.
+ */
 #define GPC_PGC_CPU_MAPPING		0x0ec
 #define GPC_PGC_CPU_MAPPING_ALL		0x0000ffff
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
+#define GPC_PU_PGC_SW_PDN_REQ		0x104
+#define GPC_PU_PWRHSK			0x1fc
 #define GPC_DDR1_SW_Pxx_REQ		BIT(5)
+#define GPC_DDRMIX_ADB400_SYNC		BIT(2)
+#define GPC_DDRMIX_ADB400_ACK		BIT(20)
+/* DDR1 is a PU type PGC and occupies 0xd40 - 0xd7f */
+#define GPC_PGC_DDR1_CTRL		0xd40
 #endif
+#define GPC_PGC_CTRL_PCR		BIT(0)
+
+static bool ddrmix_initialized;
 
 static unsigned int g_cdd_rr_max[4];
 static unsigned int g_cdd_rw_max[4];
@@ -323,6 +343,146 @@ void update_umctl2_rank_space_setting(unsigned int pstat_num)
 	}
 }
 
+/*
+ * Stop all DRAM traffic and the periodic controller activity, so that the
+ * DDRC and the PHY are idle when the resets below are asserted.
+ */
+static void ddrc_quiesce(void)
+{
+	unsigned int tmp;
+
+	/* There is nothing to do if the DDRC is still held in reset */
+	if (reg32_read(SRC_DDRC_RCR_ADDR) & SRC_DDR1_RCR_PRESET_N_MASK)
+		return;
+
+	/* Block the AXI port from accepting further transactions */
+	reg32_write(DDRC_PCTRL_0(0), 0x0);
+
+	/* Disable auto-refresh, self-refresh, powerdown and dfi_dram_clk_disable */
+	reg32_write(DDRC_RFSHCTL3(0), 0x1);
+	clrbits_le32(DDRC_PWRCTL(0), 0xb);
+
+	/*
+	 * Wait for the controller to fall back to normal operating mode, in
+	 * case it was in self-refresh or powerdown. A previous init may have
+	 * failed half way through, so this must not wait forever.
+	 */
+	tmp = 1000;
+	while (tmp-- && (reg32_read(DDRC_STAT(0)) & 0x3) != 0x1)
+		udelay(1);
+}
+
+/*
+ * Assert the whole reset chain, including PwrOkIn, and hold it. Unlike on the
+ * initial power up, the PHY is running here, so it needs a PwrOkIn low phase of
+ * a defined length to clear its internal state.
+ */
+static void ddrmix_assert_resets(void)
+{
+	reg32_write(SRC_DDRC_RCR_ADDR,
+		    SRC_DDR1_ENABLE_MASK | SRC_DDR1_RCR_ALL_RESET_MASK);
+	mdelay(1);
+}
+
+static int poll_bits_clear(ulong reg, u32 mask, unsigned int timeout_us)
+{
+	do {
+		if (!(reg32_read(reg) & mask))
+			return 0;
+		udelay(1);
+	} while (timeout_us--);
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * Power cycle the DDRMIX power domain. Asserting the resets alone leaves parts
+ * of the PHY state intact, only removing the power actually returns it to the
+ * power-on defaults.
+ *
+ * The order of the steps below follows dram_enter_retention() in TF-A
+ * (plat/imx/imx8m/ddr/dram_retention.c), which powers the DDRMIX down for DRAM
+ * retention suspend.
+ */
+static void ddrmix_reset(void)
+{
+	/*
+	 * pwrdnreqn_async adbm/adbs of ddr: request the ADB400 bridge to drain,
+	 * wait for it to acknowledge and release the request again, which is
+	 * also the reset value of GPC_PU_PWRHSK.
+	 */
+	clrbits_le32(GPC_BASE_ADDR + GPC_PU_PWRHSK, GPC_DDRMIX_ADB400_SYNC);
+	if (poll_bits_clear(GPC_BASE_ADDR + GPC_PU_PWRHSK,
+			    GPC_DDRMIX_ADB400_ACK, 10000))
+		printf("DDR: timeout on the DDRMIX ADB400 handshake\n");
+	setbits_le32(GPC_BASE_ADDR + GPC_PU_PWRHSK, GPC_DDRMIX_ADB400_SYNC);
+
+	/* Remove PowerOk and hold the DDRMIX in reset */
+	ddrmix_assert_resets();
+
+	/* Stop the DDRMIX clock while the domain is powered down */
+	clock_enable(CCGR_DDR1, false);
+
+	/*
+	 * The DDR1 domain must be mapped to the A53 domain, otherwise the
+	 * requests below are ignored. Map all domains, just like the normal
+	 * power up procedure further down does.
+	 */
+	reg32_write(GPC_BASE_ADDR + GPC_PGC_CPU_MAPPING, GPC_PGC_CPU_MAPPING_ALL);
+
+	/*
+	 * Enable the PHY isolation. Without PCR set, the requests below only run
+	 * the isolation handshake and leave the domain powered.
+	 */
+	setbits_le32(GPC_BASE_ADDR + GPC_PGC_DDR1_CTRL, GPC_PGC_CTRL_PCR);
+
+	setbits_le32(GPC_BASE_ADDR + GPC_PU_PGC_SW_PDN_REQ, GPC_DDR1_SW_Pxx_REQ);
+	if (poll_bits_clear(GPC_BASE_ADDR + GPC_PU_PGC_SW_PDN_REQ,
+			    GPC_DDR1_SW_Pxx_REQ, 10000))
+		printf("DDR: timeout powering down the DDRMIX\n");
+
+	udelay(100);
+
+	setbits_le32(GPC_BASE_ADDR + GPC_PU_PGC_SW_PUP_REQ, GPC_DDR1_SW_Pxx_REQ);
+	if (poll_bits_clear(GPC_BASE_ADDR + GPC_PU_PGC_SW_PUP_REQ,
+			    GPC_DDR1_SW_Pxx_REQ, 10000))
+		printf("DDR: timeout powering up the DDRMIX\n");
+
+	/* Leave the power gating cell as we found it */
+	clrbits_le32(GPC_BASE_ADDR + GPC_PGC_DDR1_CTRL, GPC_PGC_CTRL_PCR);
+
+	clock_enable(CCGR_DDR1, true);
+}
+
+/*
+ * The power up procedure in ddr_init() assumes a DDRMIX that is still in its
+ * power-on state. That is not the case if ddr_init() has already been run, for
+ * example by a board that probes several DDR configurations: the DDRC is in
+ * normal operating mode and the PHY holds the results of the last training run
+ * in registers that are not covered by ddrphy_cfg[]. Starting a new training
+ * run from there either fails outright or, worse, reports a successful training
+ * while leaving the DRAM completely non-functional.
+ *
+ * Return the DDRMIX to a defined state, so that the regular power up procedure
+ * can be applied again.
+ */
+static void ddrmix_cold_reset(void)
+{
+	debug("DDRINFO: cold reset the DDRMIX\n");
+
+	ddrc_quiesce();
+
+	/*
+	 * Park DfiClk on the bypass clock. The PHY must not see the DRAM PLL
+	 * being reprogrammed for the next run while it is still out of reset,
+	 * and the DDRC APB clock has to keep running to be able to release the
+	 * resets again.
+	 */
+	dram_enable_bypass(MHZ(100));
+
+	ddrmix_reset();
+}
+
 int ddr_init(struct dram_timing_info *dram_timing)
 {
 	unsigned int tmp, initial_drate, target_freq;
@@ -330,6 +490,18 @@ int ddr_init(struct dram_timing_info *dram_timing)
 
 	debug("DDRINFO: start DRAM init\n");
 
+	/*
+	 * Return the DDRMIX to a defined state if it has been initialized
+	 * before. This is also needed if the previous init failed half way
+	 * through, so the flag is set unconditionally below.
+	 *
+	 * This is not implemented for i.MX8MQ, which has a second DDR domain
+	 * that would need its own handling.
+	 */
+	if (!IS_ENABLED(CONFIG_IMX8MQ) && ddrmix_initialized)
+		ddrmix_cold_reset();
+	ddrmix_initialized = true;
+
 	/* Step1: Follow the power up procedure */
 	if (is_imx8mq()) {
 		reg32_write(SRC_DDRC_RCR_ADDR + 0x04, 0x8F00000F);

-- 
2.55.0

