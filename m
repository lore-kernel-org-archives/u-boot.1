Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4F606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DP3MBIqH;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=Uf3Zv23i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6541C60E82;
	Fri, 13 Nov 2026 02:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TP8Zo5EEKk2c; Fri, 13 Nov 2026 02:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33FB060E85
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537253;
	b=iG1E17rqCr6DrEThYC6VlCCFACK9dhslXtH1aN8TriOcOMLiNpvni1TH3Gv6tQpvNEr9
	 dSJ1LnbNEXcA6xLUsiUwicFpfzT+ghrJdCtPX4GpQBKs00R9FVBWInBxAxjSFysj6+eUZ
	 cUAKSCRd7fwzC6EdBUs6zkeWB3yjHDUiWnbSXTPNnif1GuEEPeR1PUG4GQ7V+M+M60dZk
	 8HXIvQdBlf5XSPPEpFmby7qO5syAoQfG6EhM/U04UP4W4N4HgrlgwlwJZk36i9aIFNpGw
	 ImY1m49b4aSg/jzOeDmbSK3uJ+H4j1QTE7D5Tbi//AB5nEApQYBM9sV2y8VSHlHqxKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dH1Khbm+o80h1bpMmxfMPqZ30fEpHFH/GjMbBD/i9+E=;
	b=d3LwN5r7ebC4gmSCj/o9E78bfIzU5uvT9WJCBH1k1boVfZ+xdDY3Ltzeu9uMoSmM9A9s
	 UF9lqBNgZC4HTbRIZTEpqPcKN6LRCB+0klgwSbETW8SW6UekK5ro52U3Lk0lZ+xVk6dZj
	 XH/L33a8D7xVldWa4bNdODQzuMPaixq67DA0UhiN3aGZz/zDI8f+naQiDAz2USbLqdOf/
	 IVPBwzTpzIfEbM/C1JLqbOJAU9bjQRTPWempOmT/SEFG7QhGR8PLsgt+/rNYBPJjSfOZH
	 5IKHjF95WNgfIbt6ZWiqw+Qs7ZJEbR8sDwzL3spbGUYgp/eAPwlDfBIExzlNDzV5uyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=Uf3Zv23i;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537253;
	bh=dH1Khbm+o80h1bpMmxfMPqZ30fEpHFH/GjMbBD/i9+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DP3MBIqHkID66wsFZut+A659V5YrXK9waHX7Ec4x24tYbksla5qx8l3PUV83pYKC1
	 gA2sgXDtkdbcqLERSSTmDDvVlMgszL9HRLwVlTFSHutHsKtJXqXh+TTn/72kBs5s9p
	 4rqln5fFHtS/iJafrgonYy3vfXOCMFcPddbb5Sf/AtUsPLEMdWNv9GihqiVmnVI669
	 KygKiuJH+rEqcH8GXLXN+yE8aSWDIRnf9Og7SWRHtSg1Gxdc68NEtT1MtgoamJcB7N
	 WnaxUHZPUSNYIdlD45GaURmpuldjiimwFVJEasSXErFLbklyLGordjM0RUHDJUWO2a
	 /YXIeW5F3vc5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33FB060E85;
	Fri, 13 Nov 2026 02:34:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DE961370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33A2E60E39
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2u_GLCXGCQs4 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26C2F60E4F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=Uf3Zv23i
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26C2F60E4F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:00 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 9418C4C8C0;
 Fri, 13 Nov 2026 13:33:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dH1Khbm+o80h1bpMmxfMPqZ30fEpHFH/GjMbBD/i9+E=;
 b=Uf3Zv23iSOjX+pPMJ5pywbP2+N6bnqdoJFknK9V5YziMElG/tY1SPJe+RyGuPes02aMNxG
 cdaUtOxn4ADFx4yxad5NLhWioRRVHLGx9xf4SDV5KiMThFFGQXYho2pds5Rfzf73lrLvJa
 P9ElcIz5n0b5xiHdb7r6koUiYpgm5YBSaeHsBqaT4N8l9PqwDs+GhVap1nxUl2ZI3MBaci
 9Bc6iO8evK4/GLQj3vXc5XaZX3ckuUMH/A/pUzUOqnWVDNepN/tmwI8I5T0gDl84s1YoFc
 SoKjoB7NMj6GyM3bBlKxFp4zb/b7aON9gO2xu+2LN4epsx/LTaiZZZhbAafUpA==
X-GPT-Reason: This email is classified as legitimate. The mailbox
 (alastair@d-silva.org) perfectly matches the sender (alastair@d-silva.org),
 and the content is a technical, peer-reviewed code patch related
 to hardware register specifications and firmware. There are no
 signs of marketing, phishing, or urgency; the message is a standard
 technical communication with no URLs or requests for sensitive
 information.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 15/26] sunxi: dram: a733: Add ARC PMU primitives, clock,
 telemetry, and CBT
Date: Fri, 13 Nov 2026 13:32:25 +1100
Message-ID: <20261113023236.569054-16-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the freestanding memory/division helpers, ARC auxiliary RTC delay
and PHY PLL clock-gate helpers, Synopsys mailbox IPC and panic handlers,
and JEDEC LPDDR5 Command Bus Training (CBT) routines for the Allwinner
A733 DDR PHY ARC EM4 firmware.

Written from clean-room hardware register and JEDEC JESD209-5 protocol
specifications (see doc/board/allwinner/a733-pmu.rst).

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/mach-sunxi/pmu/pmu_cbt.c        | 417 ++++++++++
 arch/arm/mach-sunxi/pmu/pmu_clock.c      | 938 +++++++++++++++++++++++
 arch/arm/mach-sunxi/pmu/pmu_primitives.c | 531 +++++++++++++
 arch/arm/mach-sunxi/pmu/pmu_telemetry.c  | 619 +++++++++++++++
 4 files changed, 2505 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_cbt.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_clock.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_primitives.c
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_telemetry.c

diff --git a/arch/arm/mach-sunxi/pmu/pmu_cbt.c b/arch/arm/mach-sunxi/pmu/pmu_cbt.c
new file mode 100644
index 00000000000..6c97ad8532e
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu_cbt.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Allwinner A733 Synopsys DDR PHY PMU Command Bus Training (CBT) Helpers
+ */
+
+#include "pmu_fw.h"
+
+/**
+ * pmu_cal_rank_offset_get() - Compute JEDEC CBT read latency entry for rank and channel
+ * @rank: Active DRAM rank index (0 or 1)
+ * @channel: Active DRAM channel index (0 or 1)
+ *
+ * Extracts the 4-bit MR2[3:0] RL index from byte +2 of the 54-byte per-slice
+ * descriptor at DCCM 0x800009a4 + (@rank * 2 + @channel) * 54 and computes the
+ * corresponding JEDEC read latency (doubled when pmu_cbt_config_get() == 2).
+ *
+ * Return: 8-bit CBT read latency entry for @rank and @channel.
+ */
+u8 pmu_cal_rank_offset_get(u32 rank, u32 channel)
+{
+	u32 slice_idx = (rank << 1) + channel;
+	u32 desc_addr = PMU_DMEM_CAL_STRUCT_ADDR +
+			slice_idx * PMU_SLICE_DESC_SIZE;
+	u32 idx = dmem_read8(desc_addr + PMU_SLICE_DESC_MR2_OFF) & 0x0fU;
+	u32 rl;
+
+	if (idx >= 12U)
+		return 0U;
+
+	rl = idx + 3U + (idx >= 4U) + (idx >= 7U) + (idx >= 9U);
+	if (pmu_cbt_config_get() == 2U)
+		return (idx < 6U) ? (u8)(rl << 1) : 0U;
+
+	return (u8)rl;
+}
+
+/**
+ * pmu_cal_cbt_desc_unpack() - Unpack CBT step multiplier from slice descriptor
+ * @rank: Active DRAM rank index (0 or 1)
+ * @channel: Active DRAM channel index (0 or 1)
+ *
+ * Return: 8 or 4 when DCCM 0x80000008 == 2 (else 4 or 2) based on bit 4 of
+ *         descriptor byte +3 at 0x800009a4 + (@rank * 2 + @channel) * 54.
+ */
+u32 pmu_cal_cbt_desc_unpack(u32 rank, u32 channel)
+{
+	u32 slice_idx = (rank << 1) + channel;
+	u8 byte_val = dmem_read8(PMU_DMEM_CAL_STRUCT_ADDR +
+				 slice_idx * PMU_SLICE_DESC_SIZE +
+				 PMU_SLICE_DESC_MR3_OFF);
+	u32 res = (byte_val & 0x10U) ? 2U : 4U;
+
+	if (dmem_read8(PMU_DMEM_PLL_RATIO) == 2U)
+		res <<= 1;
+
+	return res;
+}
+
+/**
+ * pmu_cal_search_win_max_calc() - Scan slice registers and update master delay table
+ * @channel: Target DRAM channel index (0 or 1)
+ * @rank: Target DRAM rank index (0 or 1)
+ * @dir: Direction step selector (0 adds +4 offset, non-zero adds 0)
+ */
+void pmu_cal_search_win_max_calc(u32 channel, u32 rank, u32 dir)
+{
+	u8 slice_start;
+	u8 slice_end;
+	s32 max_val = -1;
+	u32 addr;
+	s32 i;
+	u8 pll_ratio;
+	u32 shift;
+	s32 v;
+
+	if (rank == 1U && dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG) == 0U) {
+		__volatile__ u16 *tbl = pmu_sdata()->master_dly_tbl[channel];
+
+		tbl[1] = tbl[0];
+		return;
+	}
+
+	slice_start = dmem_read8((rank != 0U) ? PMU_DMEM_RANK1_SLICE_START :
+						PMU_DMEM_RANK0_SLICE_START);
+	slice_end = dmem_read8((rank != 0U) ? PMU_DMEM_RANK1_SLICE_END :
+					      PMU_DMEM_RANK_BOUNDARY);
+	addr = PHY_REG_DBYTE_BASE |
+	       (((pmu_sdata()->active_csr_offset |
+		  (channel + (((dir == 0U) ? 1U : 0U) << 2) + 0x20U) |
+		  ((u32)slice_start << 12)) << 1));
+
+	for (i = (s32)slice_end + 1 - (s32)slice_start; i > 0; i--) {
+		s16 val = (s16)phy_read16(addr);
+
+		if ((s32)val > max_val)
+			max_val = (s32)val;
+		addr += PHY_DBYTE_SLICE_STRIDE;
+	}
+
+	pll_ratio = dmem_read8(PMU_DMEM_PLL_RATIO);
+	shift = 511U >> (pll_ratio == 2U);
+
+	v = (max_val >> ((pll_ratio >> 1) + 7U)) +
+	    (s8)dmem_read8(PMU_DMEM_SEARCH_WINDOW_BIAS_LO) +
+	    (((u32)max_val & shift) != 0U ? 1 : 0) + 2;
+	pmu_sdata()->master_dly_tbl[channel][rank] = (u16)v;
+}
+
+/**
+ * pmu_phy_reg_offset_diff_adjust() - Program CA Vref DAC and trim registers for rank
+ * @rank: Target rank index (0 or non-zero)
+ */
+void pmu_phy_reg_offset_diff_adjust(u32 rank)
+{
+	__volatile__ u16 *apb =
+		(__volatile__ u16 *)(PHY_REG_CA_VREF_DAC +
+				     (pmu_sdata()->active_csr_offset << 1));
+	u8 ca_vref_r1 = dmem_read8(PMU_DMEM_CA_VREF_RANK1_ADDR);
+	u8 ca_vref_r0 = dmem_read8(PMU_DMEM_CA_VREF_RANK0_ADDR);
+	u8 val = (rank == 0U) ? ca_vref_r0 : ca_vref_r1;
+	s32 diff;
+	u16 ca_reg_a, ca_reg_b, ca_reg_c;
+	u16 ca_reg_val;
+
+	apb[0] = (apb[0] & 0x3f00U) | val;
+	apb[1] = (apb[1] & 0x3f00U) | val;
+	apb[4] = (apb[4] & 0x3f00U) | val;
+
+	diff = (s32)ca_vref_r1 - (s32)ca_vref_r0;
+	if (rank == 0U)
+		diff = -diff;
+
+	ca_reg_a = apb[13];
+	ca_reg_val = (u16)((ca_reg_a & 0x3f00U) | (((ca_reg_a & 0x3fU) + diff) & 0x3fU));
+	apb[13] = ca_reg_val;
+	apb[14] = ca_reg_val;
+
+	ca_reg_b = apb[15];
+	apb[15] = (u16)((ca_reg_b & 0x3f00U) | (((ca_reg_b & 0x3fU) + diff) & 0x3fU));
+
+	ca_reg_c = apb[16];
+	apb[16] = (u16)((ca_reg_c & 0x3f00U) | (((ca_reg_c & 0x3fU) + diff) & 0x3fU));
+}
+
+/**
+ * pmu_dmem_reg_stream_unpack() - Clear CBT/deskew status CSRs and pulse reset
+ * @cfg_desc: Pointer to CBT configuration descriptor (32-bit offset at +0x18)
+ */
+void pmu_dmem_reg_stream_unpack(const void *cfg_desc)
+{
+	__volatile__ u16 *apb = (__volatile__ u16 *)PHY_REG_RESET_TRIGGER;
+	__volatile__ u16 *bcast_base = (__volatile__ u16 *)PHY_REG_DBYTE_BCAST_BASE;
+	const u8 *desc = (const u8 *)cfg_desc;
+	u32 rank_cfg_off = *(const u32 *)(desc + 0x18U);
+	u32 zero = 0U;
+	u16 val;
+
+	phy_write16(PHY_REG_DBYTE_UPPER_SAMPLE_B, (u16)zero);
+	bcast_base[176] = (u16)zero;
+	bcast_base[177] = (u16)zero;
+	apb[71] = (u16)zero;
+	apb[0] = (u16)zero;
+	bcast_base[rank_cfg_off] = (u16)zero;
+
+	val = phy_read16(PHY_REG_BIST_PLL_CFG);
+	phy_write16(PHY_REG_AC_BCAST, val & (u16)~0x0010U);
+
+	pmu_phy_cal_trig_pulse();
+	if (pmu_sdata()->freq_mode <= 1U)
+		pmu_phy_soft_reset_pulse();
+}
+
+/**
+ * pmu_cbt_delay_offset_lookup() - Compute JEDEC CBT write latency offset for rank and channel
+ * @rank: Active DRAM rank index (0 or 1)
+ * @channel: Active DRAM channel index (0 or 1)
+ *
+ * Extracts the 4-bit MR1[7:4] clock-frequency index and MR3[5] write-latency
+ * set selector from the 54-byte per-slice descriptor at DCCM 0x800009a4 and
+ * computes the corresponding JEDEC WL Set A or Set B delay entry.
+ *
+ * Return: 8-bit CBT write latency offset for @rank and @channel.
+ */
+u32 pmu_cbt_delay_offset_lookup(u32 rank, u32 channel)
+{
+	u32 slice_idx = (rank << 1) + channel;
+	u32 desc_addr = PMU_DMEM_CAL_STRUCT_ADDR +
+			slice_idx * PMU_SLICE_DESC_SIZE;
+	u32 idx = (u32)(dmem_read8(desc_addr + PMU_SLICE_DESC_MR1_OFF) >> 4);
+	u32 wl;
+
+	if (idx >= 12U)
+		return 0U;
+
+	if (dmem_read8(desc_addr + PMU_SLICE_DESC_MR3_OFF) & 0x20U)
+		wl = idx + 2U + (idx >= 4U) + (idx >= 7U) + (idx >= 9U);
+	else
+		wl = ((idx * 11U + 2U) >> 4) + 2U;
+
+	if (pmu_cbt_config_get() == 2U)
+		return (idx < 6U) ? (wl << 1) : 0U;
+
+	return wl;
+}
+
+/**
+ * pmu_cbt_cal_pulse_seq() - Execute 6-step CBT calibration pulse sequence
+ * @pulse_cmd: Pulse command flags for intermediate phases
+ */
+noinline void pmu_cbt_cal_pulse_seq(u32 pulse_cmd)
+{
+	u32 zero = 0U;
+
+	pmu_cal_sequence_pulse_send(0x41U << 19, 7U, 4U, 0U, zero, zero, zero);
+	pmu_cbt_cal_active_set();
+	pmu_cal_sequence_pulse_send(pulse_cmd, 7U, 4U, 0U, zero, zero, zero);
+	pmu_cbt_cal_active_clear();
+	pmu_cal_sequence_pulse_send(pulse_cmd, 7U, 4U, 0U, zero, zero, zero);
+	pmu_cal_sequence_pulse_send(0x80U | (1U << 19), 7U, 4U, 0U,
+				    zero, zero, zero);
+}
+
+/**
+ * pmu_cbt_timing_pulse_coordinator() - Coordinate 4-channel CBT timing pulse sweep
+ * @cal_mode: Calibration mode halfword forwarded to pmu_cal_window_params_dispatch()
+ * @phase_sel: Phase pattern selector (0 for primary masks, non-zero for alternate)
+ */
+void pmu_cbt_timing_pulse_coordinator(u16 cal_mode, u32 phase_sel)
+{
+	u32 zero = 0U;
+	__volatile__ u16 *out_tbl =
+		(__volatile__ u16 *)PMU_DMEM_DELAY_TAP_LUT;
+	__volatile__ u16 *out_sub1 =
+		(__volatile__ u16 *)PMU_DMEM_DELAY_TAP_SUB1;
+	u32 mask_word;
+	u32 phase;
+
+	out_tbl[0] = 100U;
+
+	for (phase = 0U; phase < 4U; phase++) {
+		u32 pulse_mask;
+		u16 step;
+		u16 marker;
+
+		if (phase_sel == 0U) {
+			if (phase == 0U)
+				pulse_mask = 0x7f00U;
+			else if (phase == 1U)
+				pulse_mask = 0x7f0000U;
+			else if (phase == 2U)
+				pulse_mask = 0x7f007f7fUL;
+			else
+				pulse_mask = 0x7f7f007fUL;
+		} else {
+			if (phase == 0U)
+				pulse_mask = 0x7fU;
+			else if (phase == 1U)
+				pulse_mask = 0x7f000000UL;
+			else if (phase == 2U)
+				pulse_mask = 0x7f007f7fUL;
+			else
+				pulse_mask = 0x007f7f7fUL;
+		}
+
+		mask_word = pulse_mask;
+		step = out_tbl[phase];
+		pmu_cal_marker_pair_set((u16)(step << 2));
+
+		pmu_cal_sequence_pulse_send(0x41UL << 19, 7U, 8U, 0U,
+					    zero, zero, zero);
+		pmu_cal_pad_timing_delay_set(0U, 4U, 1U);
+
+		pmu_cal_window_params_dispatch((const u8 *)&mask_word, 2U, cal_mode);
+
+		pmu_cal_pad_timing_delay_set(0U, 20U, 1U);
+		pmu_cal_sequence_pulse_send(1UL << 18, 7U, 4U, 0U,
+					    zero, zero, zero);
+		pmu_cal_sequence_pulse_send((1UL << 19) | 0x80UL, 7U, 8U, 0U,
+					    zero, zero, zero);
+
+		marker = pmu_cal_stride_get();
+		out_tbl[phase + 1U] = marker;
+		out_sub1[phase] = (u16)(marker - 1U);
+	}
+}
+
+/**
+ * pmu_cbt_strobe_pulse_train() - Generate CBT strobe pulse train
+ * @pulse_cmd: Slice / pulse command selector
+ * @is_stage2: Non-zero for stage 2 short sequence, 0 for full repeat sequence
+ */
+void pmu_cbt_strobe_pulse_train(u32 pulse_cmd, u32 is_stage2)
+{
+	u32 zero = 0U;
+	u8 pll_ratio = dmem_read8(PMU_DMEM_PLL_RATIO);
+	u32 repeat_cnt;
+	u32 i;
+
+	pmu_cal_strobe_pulse_init();
+	pmu_cal_sequence_pulse_send(0U, 7U, 4U, 0U, zero, zero, zero);
+	pmu_cbt_cal_active_set();
+
+	repeat_cnt = (pll_ratio == 2U) ? 4U : 2U;
+
+	if (is_stage2 != 0U)
+		pmu_cal_sequence_pulse_send(0U, 7U, 2U, 0U, zero, zero, 4U);
+
+	pmu_cal_sequence_pulse_send(0x200000U, 5U, 0U, 256U, zero,
+				    pulse_cmd, zero);
+
+	if (is_stage2 == 0U) {
+		pmu_cal_sequence_pulse_send(0x1000004U, 0x2bU, repeat_cnt, 0U,
+					    zero, pulse_cmd, zero);
+		pmu_cal_sequence_pulse_send(0x1000004U, 0x2bU, repeat_cnt, 0U,
+					    zero, pulse_cmd, zero);
+	}
+
+	pmu_cal_sequence_pulse_send(0x1040000U, 0x2bU, repeat_cnt, 0U, zero,
+				    pulse_cmd, zero);
+	pmu_cal_sequence_pulse_send(0U, 7U, 10U, 0U, zero, zero, zero);
+
+	for (i = 0U; i < 2U; i++) {
+		pmu_cal_sequence_pulse_send(1U << (15U + i), 7U, 0U, 0U,
+					    zero, zero, zero);
+		pmu_cal_sequence_pulse_send(1U << (16U + i), 7U, 0U, 0U,
+					    zero, zero, zero);
+		if (i == 0U)
+			pmu_cbt_cal_active_clear();
+	}
+
+	pmu_cal_sequence_pulse_send(0x80U | (1U << 19), 7U, 4U, 0U,
+				    zero, zero, zero);
+}
+
+/**
+ * pmu_cbt_deskew_pulse_train() - Generate CBT deskew pulse train
+ * @pulse_cmd: Slice / pulse command selector
+ * @is_alternate: Non-zero to add 1 to second repeat count
+ */
+void pmu_cbt_deskew_pulse_train(u32 pulse_cmd, u32 is_alternate)
+{
+	u32 zero = 0U;
+	u8 pll_ratio = dmem_read8(PMU_DMEM_PLL_RATIO);
+	u32 repeat_cnt;
+	u32 second_cnt;
+
+	pmu_cal_strobe_pulse_init();
+	pmu_cal_sequence_pulse_send(0U, 7U, 0U, 0U, zero, zero, zero);
+	pmu_cal_sequence_pulse_send(0x480000U, 5U, 0U, 512U, zero,
+				    pulse_cmd, zero);
+	pmu_cbt_cal_active_set();
+
+	repeat_cnt = (pll_ratio == 2U) ? 5U : 2U;
+	second_cnt = (is_alternate != 0U) ? (repeat_cnt + 1U) : repeat_cnt;
+
+	pmu_cal_sequence_pulse_send(0x0cU, 0x2bU, repeat_cnt, 0U, zero,
+				    pulse_cmd, zero);
+	pmu_cal_sequence_pulse_send(0x0cU, 0x2bU, second_cnt, 0U, zero,
+				    pulse_cmd, zero);
+	pmu_cal_sequence_pulse_send(0x40000U, 0x2bU, repeat_cnt, 2U, zero,
+				    pulse_cmd, zero);
+	pmu_cal_sequence_pulse_send(0x0cU, 0x2bU, repeat_cnt, 2U, zero,
+				    pulse_cmd, zero);
+
+	pmu_cal_sequence_pulse_send(0U, 7U, 4U, 0U, zero, zero, 10U);
+	pmu_cal_sequence_pulse_send(1U << 15, 7U, 4U, 0U, zero, zero, zero);
+	pmu_cal_sequence_pulse_send(0U, 7U, 8U, 0U, zero, zero, zero);
+	pmu_cbt_cal_active_clear();
+	pmu_cal_sequence_pulse_send(0U, 7U, 4U, 0U, zero, zero, zero);
+
+	pmu_cal_sequence_pulse_send(0U, 5U, 4U, 896U, zero, pulse_cmd, zero);
+	pmu_cal_sequence_pulse_send((1U << 19) | 0x80U, 7U, 0U, 0U, zero,
+				    pulse_cmd, zero);
+}
+
+/**
+ * pmu_cbt_3phase_pulse_dispatch() - Dispatch 3-phase CBT calibration pulse sequence
+ * @cal_mode: Target calibration mode / rank selector
+ * @step_table: Base pointer to calibration step table
+ * @step_idx: Step index within @step_table
+ * @flags: Control bitmask (bit 0 skips profile program, bit 1 skips AC setup)
+ */
+void pmu_cbt_3phase_pulse_dispatch(u32 cal_mode, const u8 *step_table,
+				   u32 step_idx, u32 flags)
+{
+	u8 val = step_table[step_idx];
+	u32 is_final_step = (step_idx == 16U) ? 1U : 0U;
+	u32 p2 = ((step_idx - 14U) < 2U) ? 0x20U : (is_final_step ? 4U : 6U);
+	u32 is_final_ovr = 0U;
+
+	pmu_cal_strobe_pulse_init();
+	if ((flags & 2U) == 0U) {
+		pmu_ac_lane_profile_setup();
+		pmu_cal_pad_timing_delay_set(0U, 5U, 1U);
+	}
+
+	pmu_dbyte_cal_step_latch(step_idx, val, cal_mode);
+	pmu_cal_sequence_pulse_send(0U, 7U, p2, 0U, 0U, is_final_step, 0U);
+
+	if (is_final_step != 0U && (val & 0x20U) != 0U) {
+		u32 arg = (dmem_read8(PMU_DMEM_CBT_LANE_LIM) == 0U) ?
+			  (1U << 19) : 0U;
+
+		pmu_cbt_cal_pulse_seq(arg);
+		is_final_ovr = 1U;
+	}
+
+	pmu_cbt_3phase_pulse_seq();
+	pmu_cal_slice_step_diff_latch(0U, is_final_ovr ^ 1U);
+	if (is_final_ovr != 0U)
+		pmu_delay_us(0x1388U, 0x14U);
+	if ((flags & 1U) == 0U)
+		pmu_phy_profile_param_program();
+}
+
diff --git a/arch/arm/mach-sunxi/pmu/pmu_clock.c b/arch/arm/mach-sunxi/pmu/pmu_clock.c
new file mode 100644
index 00000000000..0ba564bb10b
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu_clock.c
@@ -0,0 +1,938 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Allwinner A733 Synopsys DDR PHY PMU Hardware Timer, PLL & Broadcast Helpers
+ */
+
+#include "pmu_fw.h"
+
+static inline void pmu_phy_clk_gate_clear(void);
+static void pmu_phy_pll_lock_poll(u32 timeout);
+static void pmu_profile_param_stride_cfg(u32 mode);
+static inline void pmu_phy_clk_gate_set(void);
+
+/**
+ * pmu_freq_ratio_mult() - Compute scaled DRAM frequency ratio multiplier
+ * @mult: Multiplier factor applied to DRAM frequency
+ *
+ * Return: (((u32)freq * @mult) / ((u32)type * 2000U)) + 1U.
+ */
+u32 pmu_freq_ratio_mult(u32 mult)
+{
+	u32 freq = dmem_read16(PMU_DMEM_DRAM_FREQ_OFF);
+	u32 type = dmem_read8(PMU_DMEM_DRAM_FREQ_OFF + 2U);
+
+	if (type == 0U)
+		type = 2U;
+
+	return ((freq * mult) / (type * 2000U)) + 1U;
+}
+
+/**
+ * pmu_phy_pll_lock_init() - Initialize CBT PLL lock and control registers
+ *
+ * Sets bit 0 of PHY register 0x90040144 into 0x900401f0, executes 4-tick and
+ * 31-tick hardware timer delays, and writes 0x0001 to 0x90040144.
+ */
+void pmu_phy_pll_lock_init(void)
+{
+	u16 val = *(__volatile__ u16 *)PHY_REG_CBT_CTRL;
+
+	*(__volatile__ u16 *)PHY_REG_CBT_PLL = val | 0x0001U;
+	pmu_hw_timer_delay(4U);
+	pmu_hw_timer_delay(31U);
+	*(__volatile__ u16 *)PHY_REG_CBT_CTRL = 0x0001U;
+}
+
+/**
+ * pmu_phy_dbyte_broadcast_enable() - Enable DBYTE broadcast mode after PLL lock
+ *
+ * Executes 31-tick and 4-tick hardware timer delays, clears PHY register
+ * 0x900401f0 to 0, and sets bit 1 of PHY register 0x90040144.
+ */
+void pmu_phy_dbyte_broadcast_enable(void)
+{
+	u16 val;
+
+	pmu_hw_timer_delay(31U);
+	pmu_hw_timer_delay(4U);
+	*(__volatile__ u16 *)PHY_REG_CBT_PLL = 0x0000U;
+	val = *(__volatile__ u16 *)PHY_REG_CBT_CTRL;
+	*(__volatile__ u16 *)PHY_REG_CBT_CTRL = val | 0x0002U;
+}
+
+/**
+ * pmu_hw_timer_delay() - Execute rollover-safe ARC auxiliary RTC delay
+ * @count: Requested raw delay count
+ *
+ * Scales @count by the shift factor in DCCM 0x80000404, ensures the ARC
+ * auxiliary RTC counter (0x104/0x105) is enabled, performs a fast APB dummy
+ * read turnaround when ticks < 16, or spins across the 64-bit counter with
+ * 32-bit rollover handling when ticks >= 16.
+ */
+noinline void pmu_hw_timer_delay(u32 count)
+{
+	u32 s = pmu_sdata()->timer_shift & 31U;
+	u32 ticks = (count == 0U) ? 0U : ((count + 1U) >> s);
+	u32 start_lo;
+	u32 start_hi;
+	u32 headroom;
+
+	if ((__builtin_arc_lr(PMU_AUX_RTC_CTRL) & 1U) == 0U) {
+		u32 two = 2U;
+		u32 one = 1U;
+
+		__builtin_arc_sr(two, PMU_AUX_RTC_CTRL);
+		__builtin_arc_sr(one, PMU_AUX_RTC_CTRL);
+	}
+
+	if (ticks < 16U) {
+		(void)*(__volatile__ u16 *)PHY_REG_TIMER_DUMMY;
+		return;
+	}
+
+	start_lo = __builtin_arc_lr(PMU_AUX_RTC_LOW);
+	start_hi = __builtin_arc_lr(PMU_AUX_RTC_HIGH);
+	headroom = ~start_lo;
+
+	if (headroom < ticks) {
+		u32 rem = ticks - headroom;
+
+		while (__builtin_arc_lr(PMU_AUX_RTC_LOW) >= start_lo)
+			;
+		while (__builtin_arc_lr(PMU_AUX_RTC_LOW) < rem)
+			;
+	} else {
+		u32 target = start_lo + ticks;
+
+		while (__builtin_arc_lr(PMU_AUX_RTC_LOW) < target &&
+		       __builtin_arc_lr(PMU_AUX_RTC_HIGH) == start_hi)
+			;
+	}
+}
+
+/**
+ * pmu_delay_us() - Convert microsecond/unit delay into timer ticks and wait
+ * @count: Delay duration count
+ * @unit: Delay unit selector passed to pmu_freq_delay_step_calc()
+ */
+void pmu_delay_us(u32 count, u32 unit)
+{
+	pmu_hw_timer_delay(pmu_freq_delay_step_calc(count, unit));
+}
+
+/**
+ * pmu_cal_strobe_pulse_init() - Reset PHY strobe registers and DCCM 0x458 markers
+ * Return: Always 0.
+ */
+u32 pmu_cal_strobe_pulse_init(void)
+{
+	pmu_phy_deskew_dly0_set(0U);
+	pmu_phy_deskew_dly1_set(0U);
+	pmu_cal_marker_pair_set(0U);
+	pmu_cal_marker_clear();
+	return 0U;
+}
+
+/**
+ * pmu_phy_pll_lock_poll() - Poll PHY clock gate status 0x90040042 with timeout
+ * @timeout: Maximum poll iterations before raising assertion 0x00240000
+ */
+static noinline void pmu_phy_pll_lock_poll(u32 timeout)
+{
+	u32 locked = 0U;
+	u32 i;
+
+	for (i = 0U; i < timeout; i++) {
+		if (*(__volatile__ u16 *)PHY_REG_CLK_GATE_STAT != 0U) {
+			locked = 1U;
+			break;
+		}
+	}
+
+	if (!locked)
+		pmu_assert_or_halt(0U, PMU_ERR_PLL_LOCK_TIMEOUT);
+}
+
+/**
+ * pmu_cal_slice_step_diff_latch() - Latch slice step difference and timing strobe
+ * @timing: 16-bit timing parameter written to PHY 0x9004004e
+ * @wait_ack: Non-zero to poll PHY 0x90040042 (timeout 25000) and clear 0x90040040
+ */
+void pmu_cal_slice_step_diff_latch(u32 timing, u32 wait_ack)
+{
+	pmu_phy_clk_timing_set((u16)(timing));
+	pmu_hw_timer_delay(6U);
+	pmu_phy_deskew_dly1_set((u16)(pmu_cal_stride_get()) - 1U);
+	pmu_phy_clk_gate_set();
+	if (wait_ack != 0U) {
+		pmu_phy_pll_lock_poll(25000U);
+		pmu_phy_clk_gate_clear();
+	}
+}
+
+/**
+ * pmu_cal_slice_timing_latch() - Latch slice timing value and strobe PHY 0x90040040
+ * @timing: 16-bit timing parameter written to PHY 0x9004004e
+ * @wait_ack: Non-zero to poll PHY 0x90040042 (timeout 25000) and clear 0x90040040
+ */
+void pmu_cal_slice_timing_latch(u32 timing, u32 wait_ack)
+{
+	pmu_phy_clk_timing_set((u16)(timing));
+	pmu_hw_timer_delay(6U);
+	pmu_phy_clk_gate_set();
+	if (wait_ack != 0U) {
+		pmu_phy_pll_lock_poll(25000U);
+		pmu_phy_clk_gate_clear();
+	}
+}
+
+/**
+ * pmu_cal_delay_line_accum_dispatch() - Compute frequency-scaled delay with floor
+ * @count: Raw delay duration count passed to pmu_freq_delay_step_calc()
+ * @limit: Minimum step floor returned when computed ticks are smaller
+ *
+ * Return: max(pmu_freq_delay_step_calc(@count, 0), @limit).
+ */
+u32 pmu_cal_delay_line_accum_dispatch(u32 count, u32 limit)
+{
+	u32 ticks = pmu_freq_delay_step_calc(count, 0U);
+
+	return (ticks < limit) ? limit : ticks;
+}
+
+/**
+ * pmu_freq_delay_step_calc() - Convert delay duration and unit into timer steps
+ * @count: Requested delay duration
+ * @unit: Calibration delay unit multiplier
+ *
+ * Scales @count by DRAM frequency (DCCM 0x80000006) and rounding bias
+ * (DCCM 0x80000008), using overflow-safe division for @count > 200000, and
+ * enforces the minimum calibration delay floor from DCCM 0x80000a7c/0x80000b64.
+ *
+ * Return: Computed timer step count.
+ */
+noinline u32 pmu_freq_delay_step_calc(u32 count, u32 unit)
+{
+	u32 f = dmem_read16(PMU_DMEM_DRAM_FREQ_MHZ);
+	u32 t = dmem_read8(PMU_DMEM_PLL_RATIO);
+	u32 cycles;
+	u32 cycle_delay;
+	u32 cal_delay;
+
+	if (t == 0U)
+		t = 2U;
+
+	if (count > 200000U)
+		cycles = (count / 100000U) * f;
+	else
+		cycles = (count * f) / 100000U;
+	cycles /= 20U;
+
+	cycle_delay = (cycles + t + 1U) / t;
+	cal_delay = unit + 1U;
+	if (dmem_read8(PMU_DMEM_AC_CAL_ACTIVE) != 0U &&
+	    (dmem_read8(PMU_DMEM_CLK_GATE_FLAG) & 8U) == 0U) {
+		u32 w_steps = dmem_read8(PMU_DMEM_SEARCH_WINDOW_STEPS);
+
+		if (w_steps != 0U)
+			cal_delay = w_steps * unit *
+				    dmem_read8(PMU_DMEM_SEARCH_WINDOW_SCALE);
+	}
+
+	return (cal_delay < cycle_delay) ? cycle_delay : cal_delay;
+}
+
+/**
+ * pmu_clk_gate_handoff() - Hand off PHY PLL clock gate and wait 5000 units
+ *
+ * Clears PHY register 0x90040062, spins until PHY status register 0x90040042 is
+ * non-zero, clears PHY clock gate register 0x90040040, and delays 5000 units.
+ */
+void pmu_clk_gate_handoff(void)
+{
+	u32 timeout = 100000U;
+
+	phy_write16(PHY_REG_PLL_CLK_CTRL, 0x0000U);
+	while (phy_read16(PHY_REG_CLK_GATE_STAT) == 0U) {
+		if (--timeout == 0U)
+			pmu_assert_or_halt(0U, PMU_ERR_CLK_GATE_TIMEOUT);
+		pmu_delay_us(1U, 0U);
+	}
+	phy_write16(PHY_REG_CLK_GATE, 0x0000U);
+	pmu_delay_us(5000U, 0U);
+}
+
+/**
+ * pmu_phy_analog_cfg_mode_set() - Program channel analog receiver bias registers
+ * @mode: Channel mode selector (0: Ch0 only, 1: Ch1 only, >=2: both Ch0 and Ch1)
+ */
+void pmu_phy_analog_cfg_mode_set(u32 mode)
+{
+	u8 m = (u8)mode;
+	u16 v0 = (m != 1U) ? dmem_read8(PMU_DMEM_CH0_ANALOG_EN) : 0U;
+	u16 v1 = (m != 0U) ? dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG) : 0U;
+
+	phy_write16(PHY_REG_CH0_ANALOG_PWR, v0);
+	phy_write16(PHY_REG_CH1_ANALOG_PWR, v1);
+}
+
+/**
+ * pmu_cal_pll_lock_settle_spin() - Interrogate AC and DBYTE PLL lock status
+ * @out_dbyte_pll: Output pointer receiving DBYTE PLL lock mask (0x900201c0 & 0x01ff)
+ * @out_ac_pll: Output pointer receiving AC PLL lock mask (0x9006017e & 0x01ff)
+ */
+void pmu_cal_pll_lock_settle_spin(u16 *out_dbyte_pll, u16 *out_ac_pll)
+{
+	__volatile__ u16 *p1 = (__volatile__ u16 *)PHY_REG_AC_PLL_CTRL;
+	__volatile__ u16 *p2;
+	u32 v0;
+	u32 v4;
+	u32 saved;
+
+	v0 = p1[3];
+	v4 = p1[5];
+	saved = (v4 << 16) | v0;
+	p1[5] = (u16)(v4 & ~0x001fU);
+	p1[3] = (u16)(v0 | 0x0800U);
+	p1[3] = (u16)(v0 | 0x0c00U);
+	pmu_hw_timer_delay(10U);
+	p2 = (__volatile__ u16 *)PHY_REG_AC_PLL_CTRL;
+	p2[3] = (u16)(saved | 0x0800U);
+	*out_ac_pll = *(__volatile__ const u16 *)PHY_REG_AC_PLL_LOCK &
+		      0x01ffU;
+	*out_dbyte_pll = *(__volatile__ const u16 *)PHY_REG_DBYTE_PLL_LOCK &
+			 0x01ffU;
+	p2[3] = (u16)saved;
+	p2[5] = (u16)(saved >> 16);
+}
+
+/**
+ * pmu_cal_seq_table_timed_replay() - Replay 6-byte [addr, data] sequence records
+ * @seq_table: Pointer to array of 6-byte [u32 addr, u16 data] sequence records
+ * @total_bytes: Total byte length of @seq_table (divided by 6 for record count)
+ */
+void pmu_cal_seq_table_timed_replay(const void *seq_table, u32 total_bytes)
+{
+	const u8 *ptr = (const u8 *)seq_table;
+	u32 count = total_bytes / 6U;
+	u32 i;
+
+	for (i = 0U; i < count; i++) {
+		u32 addr = (u32)ptr[0] | ((u32)ptr[1] << 8) |
+			   ((u32)ptr[2] << 16) | ((u32)ptr[3] << 24);
+		u16 data = (u16)((u16)ptr[4] | ((u16)ptr[5] << 8));
+
+		ptr += 6U;
+		if (addr == 0xffffffffUL)
+			pmu_hw_timer_delay(data);
+		else
+			*(__volatile__ u16 *)(PHY_REG_PUB_BASE |
+					      (addr << 1)) = data;
+	}
+}
+
+/**
+ * pmu_phy_pll_cfg_quad_write_stream() - Write 4 PLL words and append shadow trace
+ * @reg_offset: Register offset shifted left by 1 into 0x90140000
+ * @p0: First 16-bit parameter word
+ * @p1: Second 16-bit parameter word
+ * @p2: Third parameter word (low 16 bits written to +4, bits [18:16] to tag)
+ * @flags: Control flags shifted left by 3 into the 4th tag halfword
+ */
+void pmu_phy_pll_cfg_quad_write_stream(u32 reg_offset, u16 p0, u16 p1, u32 p2,
+				       u32 flags)
+{
+	__volatile__ u16 *reg =
+		(__volatile__ u16 *)(PHY_REG_SHADOW_TRACK_BASE |
+				     (reg_offset << 1));
+	u16 *trace = (u16 *)(*(__volatile__ u32 *)PMU_DMEM_SHADOW_TRACE_PTR);
+	u16 tag = (u16)(((flags & 0xffU) << 3) | ((p2 >> 16) & 0x07U));
+
+	reg[0] = p0;
+	reg[1] = p1;
+	reg[2] = (u16)p2;
+	reg[3] = tag;
+
+	trace[0] = p0;
+	trace[1] = p1;
+	trace[2] = (u16)p2;
+	trace[3] = tag;
+	*(__volatile__ u32 *)PMU_DMEM_SHADOW_TRACE_PTR = (u32)(trace + 4);
+}
+
+/**
+ * pmu_phy_clk_phase_toggle_pulse() - Toggle PHY clock phase and settle PLL aligners
+ *
+ * Pulses the master PHY clock phase and clear strobes around 0x90040606, delays
+ * for phase stabilization, and restores the original 8-bit configuration.
+ */
+void pmu_phy_clk_phase_toggle_pulse(void)
+{
+	__volatile__ u16 *p = (__volatile__ u16 *)PHY_REG_CLK_PHASE_BASE;
+	u16 orig;
+
+	orig = p[3];
+	p[16] = 1U;
+	p[3] = (orig & 0x00efU) | 0x0010U;
+	p[16] = 0U;
+	p[13] = 1U;
+	p[13] = 0U;
+	p[17] = 1U;
+	pmu_delay_us(0x07bfa480UL, 0U);
+	p[17] = 0U;
+	p[32] = 0U;
+	p[32] = 1U;
+	p[32] = 0U;
+	p[3] = (u8)orig;
+}
+
+/**
+ * pmu_cal_pad_timing_delay_set() - Stream pad timing delay halfword frames
+ * @bypass_min_clamp: Non-zero to force val = step regardless of @steps
+ * @steps: Target delay steps
+ * @use_fixed_unit: Non-zero for unit step 1, 0 for (DCCM 0x8000045a << 1)
+ */
+void pmu_cal_pad_timing_delay_set(u32 bypass_min_clamp, u32 steps,
+				  u32 use_fixed_unit)
+{
+	u16 marker_val = pmu_sdata()->cal_marker_a;
+	u16 buf[8];
+	u32 step = (use_fixed_unit == 0U) ?
+		   (u32)((u8)(pmu_sdata()->cbt_state << 1)) : 1U;
+	u32 val, div;
+
+	if (step == 0U)
+		step = 1U;
+	val = (bypass_min_clamp == 0U && steps > step) ? steps : step;
+	div = val / step;
+	u32 count;
+	u16 v3 = 0U;
+	u16 v7 = 0U;
+
+	if (val != div * step)
+		div++;
+	count = (div - 1U) & 0xffffU;
+
+	memset(buf, 0, sizeof(buf));
+	if ((marker_val & 0x7U) == 4U) {
+		memset((void *)pmu_tracker()->slot1, 0,
+		       sizeof(pmu_tracker()->slot1));
+		pmu_cal_marker_status_update();
+		pmu_sdata()->cal_marker_a = marker_val + 4U;
+	}
+
+	while (count > 255U) {
+		u16 s0 = 0x1fU << 10;
+
+		buf[3] = (u16)(s0 - 0x100U);
+		buf[7] = s0;
+		pmu_cal_tracker_reset_and_apb_zero(buf, 8U);
+		count -= 255U;
+	}
+
+	if (count != 0U) {
+		v3 = (u16)(((count << 12) & 0x7000U) | 0x0b00U);
+		v7 = (u16)((count << 7) & 0x7c00U);
+	}
+	buf[3] = v3;
+	buf[7] = v7;
+
+	pmu_cal_tracker_reset_and_apb_zero(buf, 8U);
+}
+
+/**
+ * pmu_pll_quad_param_tuple_stream() - Stream 2x2 PLL quad parameter tuples
+ * @param_array: Input 8-halfword parameter array
+ * @out_ctr: In/out trace counter incremented per streamed tuple
+ * @base_ptr: In/out base register index incremented per outer iteration
+ */
+void pmu_pll_quad_param_tuple_stream(const u16 *param_array, u16 *out_ctr,
+				     u16 *base_ptr)
+{
+	u32 iter;
+
+	for (iter = 0U; iter < 4U; iter++) {
+		if ((dmem_read32(PMU_DMEM_PLL_GATE_CH0_ADDR) |
+		     dmem_read16(PMU_DMEM_PLL_SEQ_EN_ADDR)) != 0U) {
+			u32 target = ((u32)(*base_ptr) << 1) +
+				     (iter & 1U) + 0x20800UL;
+
+			pmu_phy_pll_cfg_quad_write_stream((u32)(*out_ctr) << 2,
+							  param_array[0],
+							  param_array[1],
+							  target & 0x7ffffUL,
+							  3U);
+			*out_ctr += 1U;
+		}
+		param_array += 2;
+		if ((iter & 1U) != 0U)
+			*base_ptr += 1U;
+	}
+}
+
+/**
+ * pmu_phy_mode_cfg_dispatch() - Configure PHY analog bias and channel bounds for mode
+ * @mode: Channel/rank dispatch mode (1 = Ch0, 2 = Ch1, else broadcast)
+ */
+void pmu_phy_mode_cfg_dispatch(u32 mode)
+{
+	__volatile__ u16 *apb = (__volatile__ u16 *)PHY_REG_CH0_ANALOG_PWR;
+	u8 m = (u8)mode;
+	u16 v0 = dmem_read8(PMU_DMEM_CH0_ANALOG_EN);
+	u16 v1 = dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG);
+
+	if (m == 2U)
+		v0 = 0U;
+	if (m == 1U)
+		v1 = 0U;
+	apb[0] = v0;
+	apb[1] = v1;
+	apb[12] = 0U;
+
+	if (m == 2U) {
+		dmem_write16(PMU_DMEM_CH_RANGE,
+			     dmem_read16(PMU_DMEM_CH_SEC_RANGE));
+		apb[8] = 0x000fU;
+	} else if (m == 1U) {
+		dmem_write16(PMU_DMEM_CH_RANGE,
+			     dmem_read16(PMU_DMEM_CH_ACTIVE_RANGE));
+		apb[8] = 0x00f0U;
+	} else {
+		apb[8] &= ~0x0011U;
+		dmem_write8(PMU_DMEM_SLICE_START,
+			    dmem_read8(PMU_DMEM_RANK0_SLICE_START));
+		dmem_write8(PMU_DMEM_SLICE_END,
+			    dmem_read8(PMU_DMEM_RANK1_SLICE_END));
+		apb[8] = 0U;
+	}
+
+	pmu_profile_param_stride_cfg(mode);
+}
+
+/**
+ * pmu_clk_ratio_pulse_trigger() - Trigger frequency-scaled 2000-step pad timing delay
+ */
+void pmu_clk_ratio_pulse_trigger(void)
+{
+	u32 scaled = pmu_freq_ratio_mult(2000U);
+
+	pmu_cal_pad_timing_delay_set(0U, (u16)scaled, 0U);
+}
+
+/**
+ * pmu_phy_pll_clock_divider_align() - Compute DBYTE slice bounds and active slice mask
+ */
+void pmu_phy_pll_clock_divider_align(void)
+{
+	u8 dq0 = dmem_read8(PMU_DMEM_CH0_DQ_WIDTH);
+	u8 dq1 = dmem_read8(PMU_DMEM_CH1_DQ_WIDTH);
+	u8 rank1_en = dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG);
+	u8 d1c = dmem_read8(PMU_DMEM_DESKEW_LIM);
+	u8 num_slices0 = (u8)((dq0 + 7U) >> 3);
+	u8 end_slice0 = num_slices0 - 1U;
+	u8 start_slice1 = num_slices0;
+	u8 end_slice1;
+	u8 mask;
+	int i;
+	u32 rank, ch;
+
+	dmem_write8(PMU_DMEM_RANK0_SLICE_START, 0U);
+	dmem_write8(PMU_DMEM_RANK_BOUNDARY, end_slice0);
+
+	if (rank1_en != 0U) {
+		start_slice1 = (u8)(pmu_sdata()->active_slice_cnt >> 1);
+		num_slices0 = (u8)(((dq1 + 7U) >> 3) + start_slice1);
+		end_slice1 = num_slices0 - 1U;
+	} else {
+		end_slice1 = end_slice0;
+	}
+	dmem_write8(PMU_DMEM_RANK1_SLICE_START, start_slice1);
+	dmem_write8(PMU_DMEM_RANK1_SLICE_END, end_slice1);
+
+	mask = dmem_read8(PMU_DMEM_ACTIVE_SLICE_MASK);
+	for (i = 0; i <= (int)end_slice0; i++)
+		mask |= (u8)(1U << i);
+	dmem_write8(PMU_DMEM_ACTIVE_SLICE_MASK, mask);
+
+	if (end_slice1 >= start_slice1) {
+		for (i = (int)start_slice1; i <= (int)end_slice1; i++)
+			mask |= (u8)(1U << i);
+		dmem_write8(PMU_DMEM_ACTIVE_SLICE_MASK, mask);
+	}
+
+	for (rank = 0U; rank < 2U; rank++) {
+		for (ch = 0U; ch < 2U; ch++) {
+			u8 dq = (ch == 0U) ? dq0 : dq1;
+			u8 shift = (u8)(ch * 2U);
+			u8 slice_cnt = ((d1c >> shift) & (1U << rank)) ?
+				       (u8)((dq + 7U) >> 3) :
+				       (u8)((dq + 15U) >> 4);
+
+			dmem_write8(PMU_DMEM_SLICE_CNT_LIMIT +
+				    ch * 2U + rank, slice_cnt);
+		}
+	}
+}
+
+/**
+ * pmu_profile_param_stride_cfg() - Broadcast profile delay across slices and pulse strobe
+ * @mode: Channel/rank mode selector (3 = max across channels, else offset)
+ */
+static void pmu_profile_param_stride_cfg(u32 mode)
+{
+	u8 byte_idx;
+	u32 val;
+	u32 csr_ch_off;
+	u32 count;
+	u32 i;
+	u32 reg;
+	__volatile__ u16 *strobe;
+
+	if (dmem_read16(PMU_DMEM_SEQ_CTRL) == 1U)
+		return;
+
+	byte_idx = dmem_read8(PMU_DMEM_ACTIVE_RANK);
+	if (mode == 3U) {
+		const u16 *tbl = (const u16 *)
+			dmem_ptr(PMU_DMEM_CAL_TABLE + byte_idx * 4U);
+
+		val = tbl[0];
+		if (dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG) != 0U && tbl[1] > val)
+			val = tbl[1];
+	} else {
+		u32 offset = (mode & ~1U) + byte_idx * 4U;
+
+		val = dmem_read8(PMU_DMEM_CAL_TABLE + offset);
+	}
+
+	csr_ch_off = pmu_sdata()->active_csr_offset << 1;
+	val = (u16)(s8)val;
+	*(__volatile__ u16 *)(PHY_REG_MASTER_DELAY | csr_ch_off) = (u16)val;
+
+	count = pmu_sdata()->active_slice_cnt;
+	reg = PHY_REG_DBYTE_BASE | csr_ch_off;
+	for (i = 0U; i <= count; i++, reg += PHY_DBYTE_SLICE_STRIDE)
+		*(__volatile__ u16 *)reg = (u16)val;
+
+	strobe = (__volatile__ u16 *)PHY_REG_PUB_CAL_STROBE;
+	*strobe = 1U;
+	pmu_hw_timer_delay(0x20U);
+	*strobe = 0U;
+}
+
+/**
+ * pmu_cal_tracker_csr_commit() - Commit multi-channel calibration step tracker to CSR stream
+ * @tracker: Pointer to 22-halfword calibration step tracker structure
+ *
+ * Return: Updated 16-bit calibration marker from 0x8000045e.
+ */
+u32 pmu_cal_tracker_csr_commit(__volatile__ void *tracker)
+{
+	__volatile__ u16 *t = (__volatile__ u16 *)tracker;
+	u8 mask = (u8)pmu_sdata()->active_slice_mask;
+	u32 popcount = 0U;
+	u16 marker_val;
+	u8 step_ext_val;
+	u8 ch_range_val;
+	u16 has_step_ext;
+	u16 sample[8];
+	u32 base;
+	u32 i;
+
+	while (mask != 0U) {
+		mask &= (u8)(mask - 1U);
+		popcount++;
+	}
+
+	marker_val = pmu_sdata()->cal_marker_b;
+	step_ext_val = pmu_sdata()->cbt_step_ext;
+	ch_range_val = pmu_sdata()->ch_range_lim;
+	has_step_ext = (step_ext_val != 0U) ? 1U : 0U;
+
+	t[19] = has_step_ext;
+
+	sample[0] = (t[3] & 0x7fU) | ((t[4] & 0x7fU) << 7) | (t[5] << 14);
+	sample[1] = (t[6] & 0x0fU) | (t[7] << 4);
+	sample[2] = (t[7] >> 12) & 1U;
+	sample[3] = (u16)((u8)(t[2] << 7)) |
+		    ((t[0] << 4) & 0x10U) |
+		    ((t[1] << 5) & 0x60U) |
+		    ((t[18] << 8) & 0x300U) |
+		    ((t[20] << 11) & 0x800U) |
+		    (has_step_ext << 10) |
+		    ((t[17] << 12) & 0x7000U);
+
+	sample[4] = (t[11] & 0x7fU) | ((t[12] & 0x7fU) << 7) | (t[13] << 14);
+	sample[5] = (t[14] & 0x0fU) | (t[15] << 4);
+	sample[6] = (t[15] >> 12) & 1U;
+	sample[7] = (u16)((u8)(t[10] << 7)) |
+		    ((t[8] << 4) & 0x10U) |
+		    ((t[9] << 5) & 0x60U) |
+		    ((t[16] << 8) & 0x300U) |
+		    ((t[17] << 7) & 0x7c00U);
+
+	if (ch_range_val != 0U) {
+		s32 sum;
+
+		if (ch_range_val != 1U)
+			return (u32)marker_val;
+
+		sum = (s8)popcount + pmu_sdata()->tracker_popcnt_acc;
+		if (sum < 8) {
+			*(__volatile__ u8 *)&pmu_sdata()->active_slice_mask = 0U;
+			pmu_sdata()->tracker_popcnt_acc = sum % 8;
+			return (u32)marker_val;
+		}
+	}
+
+	base = PHY_REG_CSR_RESULT_STREAM | ((u32)marker_val << 1);
+	for (i = 0U; i < 8U; i++)
+		*(__volatile__ u16 *)(base + (i * 2U)) = sample[i];
+
+	marker_val += 8U;
+	pmu_sdata()->cal_marker_b = marker_val;
+
+	if ((t[18] & 3U) != 0U)
+		pmu_sdata()->step_mode_ovr = (u8)(1U & ~t[18]);
+
+	if (ch_range_val == 1U) {
+		s32 sum;
+
+		pmu_tracker()->slot1_mode = 0U;
+		sum = (s8)popcount + pmu_sdata()->tracker_popcnt_acc;
+		*(__volatile__ u8 *)&pmu_sdata()->active_slice_mask = 0U;
+		pmu_sdata()->tracker_popcnt_acc = sum % 8;
+	}
+
+	return (u32)marker_val;
+}
+
+/**
+ * pmu_pll_clk_gate_cfg() - Program PLL clock timing and PUB transceiver gates
+ */
+void pmu_pll_clk_gate_cfg(void)
+{
+	u32 csr_sh1 = pmu_sdata()->active_csr_offset << 1;
+	u16 val0 = *(__volatile__ const u16 *)(csr_sh1 | PHY_REG_DBYTE_XCVR_GATE);
+	__volatile__ u16 *phy_base = (__volatile__ u16 *)PHY_REG_MASTER_BASE;
+	u8 cal_mode_flag;
+
+	*(__volatile__ u16 *)(csr_sh1 | PHY_REG_DBYTE_BCAST_XCVR_GATE) =
+		(val0 & 0xff78U) | 6U;
+
+	phy_base[0x00c2 >> 1] = 1U;
+
+	cal_mode_flag = *(__volatile__ const u8 *)PMU_DMEM_CAL_MODE_FLAG_ADDR;
+	if (cal_mode_flag != 0U) {
+		pmu_delay_us(0U, 4U);
+		phy_base[0x00c2 >> 1] = 0U;
+		phy_base[0x01c2 >> 1] = 1U;
+		phy_base[0x01c0 >> 1] = 1U;
+		phy_base[0x0620 >> 1] = 0U;
+		pmu_delay_us(0x989680U, 0U);
+		phy_base[0x0186 >> 1] = 0U;
+		phy_base[0x0400 >> 1] = 0x33U;
+		phy_base[0x0144 >> 1] = 0U;
+		pmu_hw_timer_delay(0x20U);
+		phy_base[0x00f0 >> 1] = 1U;
+		phy_base[0x0144 >> 1] = 2U;
+		pmu_hw_timer_delay(1024U);
+	} else {
+		pmu_hw_timer_delay(4U);
+		phy_base[0x0092 >> 1] = 496U;
+		phy_base[0x00c2 >> 1] = 0U;
+		phy_base[0x01c2 >> 1] = 0U;
+		phy_base[0x0620 >> 1] = 0U;
+		phy_base[0x01c0 >> 1] = 0U;
+		phy_base[0x0186 >> 1] = 0U;
+		pmu_delay_us(0xf4240U, 0U);
+		phy_base[0x01c4 >> 1] = 3U;
+		pmu_delay_us(0xf4240U >> 1, 0U);
+		phy_base[0x01c4 >> 1] = 2U;
+		pmu_delay_us(0x989680U, 0U);
+		phy_base[0x01c4 >> 1] = 0U;
+		phy_base[0x00f0 >> 1] = 1U;
+		phy_base[0x0400 >> 1] = 0x33U;
+		phy_base[0x0144 >> 1] = 0U;
+		pmu_hw_timer_delay(6U);
+		phy_base[0x00f0 >> 1] = 2U;
+		pmu_delay_us(0U, 0x2710U);
+		phy_base[0x0144 >> 1] = 2U;
+	}
+
+	phy_base[0x00f0 >> 1] = 0U;
+	phy_base[0x0144 >> 1] = 0U;
+	pmu_delay_us(0U, 0x20U);
+	phy_base[0x0400 >> 1] = 0U;
+	phy_base[0x01f0 >> 1] = 0U;
+	phy_base[0x0144 >> 1] = 2U;
+}
+
+/**
+ * pmu_channel_rank_avail_check() - Dispatch mode configuration for active channel
+ * @channel: Target channel index (0 = Ch0, 1 = Ch1, >1 = broadcast)
+ * @rank: Rank bit index to test in Ch0 (0x80000025) or Ch1 (0x80000040)
+ *
+ * Return: 1 if dispatched (mode 1, 2, or 3), or 0 if rank bit is inactive.
+ */
+u32 pmu_channel_rank_avail_check(u32 channel, u32 rank)
+{
+	u32 mode = 3U;
+
+	if (channel <= 1U) {
+		u8 flags = (channel == 0U) ?
+			   dmem_read8(PMU_DMEM_CH0_ANALOG_EN) :
+			   dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG);
+
+		if (((flags >> rank) & 1U) == 0U)
+			return 0U;
+		mode = channel + 1U;
+	}
+
+	pmu_phy_mode_cfg_dispatch(mode);
+	return 1U;
+}
+
+/**
+ * pmu_phy_clk_gate_clear() - Clear PHY control register 0x90040040 to 0
+ */
+static inline void pmu_phy_clk_gate_clear(void)
+{
+	*(__volatile__ u16 *)PHY_REG_CLK_GATE = 0;
+}
+
+/**
+ * pmu_phy_cal_stat_read() - Read 16-bit value from PHY register 0x90040148
+ *
+ * Return: 16-bit register value at 0x90040148.
+ */
+u16 pmu_phy_cal_stat_read(void)
+{
+	return *(__volatile__ u16 *)PHY_REG_CAL_STAT;
+}
+
+/**
+ * pmu_phy_dbyte_cal_trig_pulse() - Execute 5-step strobe pulse on PHY reg 0x176
+ * @slice: Target DBYTE slice index (0..3)
+ * @bit_idx: Lane bit index (0..8, or 15 for all 9 lanes 0x1ff)
+ *
+ * Sequences 0 -> mask -> (mask | 0x200) -> mask -> 0 on the slice's PHY
+ * register at 0x90020176 + (slice << 13).
+ */
+void pmu_phy_dbyte_cal_trig_pulse(u32 slice, u32 bit_idx)
+{
+	__volatile__ u16 *reg =
+		(__volatile__ u16 *)(PHY_REG_DBYTE_CAL_TRIG + (slice << 13));
+	u32 mask = (bit_idx == 15) ? 511U : (1U << bit_idx);
+	u32 strobe = mask | (1U << 9);
+	u16 zero = 0;
+
+	*reg = zero;
+	*reg = (u16)mask;
+	*reg = (u16)strobe;
+	*reg = (u16)mask;
+	*reg = zero;
+}
+
+/**
+ * pmu_phy_sec_cal_strobe_pulse() - Pulse PHY register 0x9005e140 high for 32 timer ticks
+ */
+void pmu_phy_sec_cal_strobe_pulse(void)
+{
+	*(__volatile__ u16 *)PHY_REG_PUB_CAL_STROBE = 1;
+	pmu_hw_timer_delay(32);
+	*(__volatile__ u16 *)PHY_REG_PUB_CAL_STROBE = 0;
+}
+
+/**
+ * pmu_phy_cal_trig_pulse() - Pulse PHY register 0x90040146 high for 32 timer ticks
+ */
+void pmu_phy_cal_trig_pulse(void)
+{
+	*(__volatile__ u16 *)PHY_REG_CAL_TRIG = 1;
+	pmu_hw_timer_delay(32);
+	*(__volatile__ u16 *)PHY_REG_CAL_TRIG = 0;
+}
+
+/**
+ * pmu_phy_soft_reset_pulse() - Toggle PHY register 0x900400f2 high then low
+ */
+void pmu_phy_soft_reset_pulse(void)
+{
+	__volatile__ u16 *p = (__volatile__ u16 *)PHY_REG_RESET_TRIGGER;
+
+	*p = 1;
+	*p = 0;
+}
+
+/**
+ * pmu_phy_clk_gate_set() - Set PHY control register 0x90040040 to 1
+ */
+static inline void pmu_phy_clk_gate_set(void)
+{
+	*(__volatile__ u16 *)PHY_REG_CLK_GATE = 1;
+}
+
+/**
+ * pmu_phy_deskew_dly0_set() - Write 16-bit value to channel-indexed PHY reg 0x90040044
+ * @val: Halfword value to write
+ */
+void pmu_phy_deskew_dly0_set(u16 val)
+{
+	u32 ch_offset = pmu_sdata()->active_csr_offset;
+
+	*(__volatile__ u16 *)(PHY_REG_DESKEW_DLY0 + (ch_offset << 1)) = val;
+}
+
+/**
+ * pmu_phy_deskew_dly1_set() - Write 16-bit value to channel-indexed PHY reg 0x90040046
+ * @val: Halfword value to write
+ */
+void pmu_phy_deskew_dly1_set(u16 val)
+{
+	u32 ch_offset = pmu_sdata()->active_csr_offset;
+
+	*(__volatile__ u16 *)(PHY_REG_DESKEW_DLY1 + (ch_offset << 1)) = val;
+}
+
+/**
+ * pmu_phy_clk_timing_set() - Write 16-bit value to PHY register 0x9004004e
+ * @val: Halfword value to write
+ */
+void pmu_phy_clk_timing_set(u16 val)
+{
+	*(__volatile__ u16 *)PHY_REG_CLK_TIMING_CTRL = val;
+}
+
+/**
+ * pmu_phy_clk_gate_sync_pulse() - Conditionally pulse PHY clock gate reg 0x9005e0a4
+ *
+ * When bit 0 of DCCM 0x80000001 is set, asserts PHY register 0x9005e0a4 to 1,
+ * waits 10 hardware timer ticks, and clears it back to 0.
+ */
+void pmu_phy_clk_gate_sync_pulse(void)
+{
+	u8 flag = *(__volatile__ u8 *)PMU_DMEM_CLK_GATE_FLAG;
+
+	if ((flag & 1) != 0) {
+		*(__volatile__ u16 *)PHY_REG_SEC_CLK_GATE = 1;
+		pmu_hw_timer_delay(10);
+		*(__volatile__ u16 *)PHY_REG_SEC_CLK_GATE = 0;
+	}
+}
+
+/**
+ * pmu_phy_pll_cfg_quad_write() - Broadcast halfword mask to PHY 0x900e00c2..0x900e00c8
+ * @v0: Halfword mask written to 0x900e00c2, 0x900e00c4, 0x900e00c6, and 0x900e00c8
+ */
+void pmu_phy_pll_cfg_quad_write(u16 v0)
+{
+	__volatile__ u16 *p = (__volatile__ u16 *)PHY_REG_PLL_CFG;
+
+	p[0] = v0;
+	p[1] = v0;
+	p[2] = v0;
+	p[3] = v0;
+}
diff --git a/arch/arm/mach-sunxi/pmu/pmu_primitives.c b/arch/arm/mach-sunxi/pmu/pmu_primitives.c
new file mode 100644
index 00000000000..23277c7f7d3
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu_primitives.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Allwinner A733 Synopsys DDR PHY PMU Foundation Memory Primitives
+ */
+
+#include "pmu_fw.h"
+
+/**
+ * memset() - Fill memory region with a constant byte value
+ * @s: Pointer to destination memory block
+ * @c: Byte value to replicate across @n bytes
+ * @n: Number of bytes to set
+ *
+ * Aligns the destination pointer to a 4-byte boundary using byte stores, fills
+ * 32-bit words using the replicated pattern (u8)@c * 0x01010101UL, and writes
+ * any trailing bytes.
+ *
+ * Return: Original destination pointer @s.
+ */
+void *memset(void *s, int c, size_t n)
+{
+	u8 *p = (u8 *)s;
+	u8 val = (u8)c;
+	u32 pat = (u32)val * 0x01010101UL;
+
+	while (n > 0 && ((uintptr_t)p & 3U) != 0U) {
+		*p++ = val;
+		n--;
+	}
+
+	while (n >= 4U) {
+		*(u32 *)p = pat;
+		p += 4;
+		n -= 4U;
+	}
+
+	while (n > 0) {
+		*p++ = val;
+		n--;
+	}
+
+	return s;
+}
+
+/**
+ * memcpy() - Copy memory region from source to destination
+ * @dest: Destination buffer pointer
+ * @src: Source buffer pointer
+ * @n: Number of bytes to copy
+ *
+ * Copies 32-bit words when both @dest and @src are 4-byte aligned, followed by
+ * any trailing bytes; otherwise copies byte-by-byte.
+ *
+ * Return: Original destination pointer @dest.
+ */
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	u8 *d = (u8 *)dest;
+	const u8 *s = (const u8 *)src;
+
+	if ((((uintptr_t)d | (uintptr_t)s) & 3U) == 0U) {
+		while (n >= 4U) {
+			*(u32 *)d = *(const u32 *)s;
+			d += 4;
+			s += 4;
+			n -= 4U;
+		}
+	}
+
+	while (n > 0) {
+		*d++ = *s++;
+		n--;
+	}
+
+	return dest;
+}
+
+/**
+ * pmu_cal_tracker_step_advance() - Advance calibration step tracker across step count
+ * @marker: Initial 16-bit calibration marker
+ * @count: Number of step iterations to advance
+ * @mode: Step mode selector (1 for fast multi-step mode, 0 for single-step)
+ *
+ * Return: Updated 16-bit calibration marker.
+ */
+u32 pmu_cal_tracker_step_advance(u32 marker, u32 count, u32 mode)
+{
+	__volatile__ struct pmu_cal_tracker *trk = pmu_tracker();
+	__volatile__ u32 *slot0 = (__volatile__ u32 *)(uintptr_t)trk->slot0;
+	__volatile__ u32 *slot1 = (__volatile__ u32 *)(uintptr_t)trk->slot1;
+
+	while ((u16)count != 0U) {
+		if (count >= 4U && mode == 1U) {
+			if ((marker & 7U) != 0U) {
+				count--;
+				slot1[0] = 0U;
+				slot1[1] = 0U;
+				slot1[2] = 0U;
+				slot1[3] = 0U;
+				marker = pmu_cal_marker_status_update();
+				mode = 1U;
+			} else {
+				memset((void *)trk->slot0, 0,
+				       PMU_TRACKER_SLOTS_BYTES);
+				if (count >= 513U) {
+					count -= 512U;
+					trk->repeat_cnt = 0x00ffU;
+					trk->slot0_mode = 0x0003U;
+					marker = pmu_cal_marker_status_update();
+					mode = 1U;
+				} else {
+					u32 half_cnt = (count >> 1) - 1U;
+
+					trk->repeat_cnt = (u16)half_cnt;
+					if ((count >> 1) == 0U) {
+						trk->slot0_mode = 0U;
+						marker = pmu_cal_marker_status_update();
+						goto reset_slot_next;
+					}
+					trk->slot0_mode = 0x0003U;
+					return (u16)(marker + 8U);
+				}
+			}
+		} else {
+			mode = 0U;
+			if ((marker & 7U) != 0U) {
+				slot1[0] = 0U;
+				slot1[1] = 0U;
+				slot1[2] = 0U;
+				slot1[3] = 0U;
+				if (count == 1U)
+					return (u16)(marker + 4U);
+				marker = pmu_cal_marker_status_update();
+				if (count == 2U)
+					goto reset_slot_next;
+				count--;
+			} else {
+				memset((void *)trk->slot0, 0,
+				       PMU_TRACKER_SLOTS_BYTES);
+				if (count == 1U)
+					goto reset_slot_next;
+				if (count == 2U)
+					return (u16)(marker + 8U);
+				marker = pmu_cal_marker_status_update();
+				count -= 2U;
+			}
+		}
+	}
+
+	return pmu_sdata()->cal_marker_a;
+
+reset_slot_next:
+	slot0[0] = 0U;
+	slot0[1] = 0U;
+	slot0[2] = 0U;
+	slot0[3] = 0U;
+	return (u16)(marker + 4U);
+}
+
+/**
+ * pmu_default_exception_handler() - Dump ARC exception state to DCCM and halt
+ */
+__attribute__((naked))
+void pmu_default_exception_handler(void)
+{
+	__asm__ __volatile__("mov     r2, 0x80000000\n\t"
+			     "mov     r3, 0x1234dead\n\t"
+			     "st      r3, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "lr      r3, [0x400]\n\t"
+			     "st      r3, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "lr      r3, [0x403]\n\t"
+			     "st      r3, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "st      r0, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "st      r1, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "st      sp, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "st      fp, [r2]\n\t"
+			     "add_s   r2, r2, 4\n\t"
+			     "mov     r3, 0xabcddead\n\t"
+			     "st      r3, [r2]\n\t"
+			     "flag    1\n\t"
+			     "nop_s\n\t");
+}
+
+/**
+ * pmu_start() - ARC EM4 CRT0 reset entry point
+ *
+ * Clears core registers, initializes the stack pointer (0x80010000) and
+ * small-data global pointer (0x80000400), invokes pmu_main_wrapper(),
+ * and halts the processor upon return.
+ */
+__attribute__((naked))
+void pmu_start(void)
+{
+	__asm__ __volatile__("mov_s   r0, 0\n\t"
+			     "mov_s   r1, 0\n\t"
+			     "mov_s   r2, 0\n\t"
+			     "mov_s   r3, 0\n\t"
+			     "mov_s   r10, 0\n\t"
+			     "mov_s   r11, 0\n\t"
+			     "mov_s   r12, 0\n\t"
+			     "mov_s   r13, 0\n\t"
+			     "mov_s   r14, 0\n\t"
+			     "mov_s   r15, 0\n\t"
+			     "mov_s   gp, 0\n\t"
+			     "mov_s   fp, 0\n\t"
+			     "mov_s   sp, 0\n\t"
+			     "mov     ilink, 0\n\t"
+			     "mov     r30, 0\n\t"
+			     "mov_s   blink, 0\n\t"
+			     "mov_s   sp, 0x80010000\n\t"
+			     "mov_s   gp, 0x80000400\n\t"
+			     "mov_s   fp, 0\n\t"
+			     "jl      pmu_main_wrapper\n\t"
+			     "1:\n\t"
+			     "flag    1\n\t"
+			     "nop_s\n\t"
+			     "b_s     1b\n\t");
+}
+
+/**
+ * pmu_vector_table() - ARC EM4 interrupt and exception vector table
+ */
+__attribute__((naked))
+void pmu_vector_table(void)
+{
+	__asm__ __volatile__(".word pmu_start\n\t"
+			     ".rept 15\n\t"
+			     ".word pmu_default_exception_handler\n\t"
+			     ".endr\n\t"
+			     ".rept 4\n\t"
+			     ".word 1f\n\t"
+			     ".endr\n\t"
+			     "1:\n\t"
+			     "nop\n\t"
+			     "nop\n\t"
+			     "nop\n\t"
+			     "nop\n\t"
+			     "rtie\n\t");
+}
+
+/**
+ * pmu_cal_struct_mask_remap() - Remap calibration struct shadow masks
+ */
+void pmu_cal_struct_mask_remap(void)
+{
+	u32 base =
+		(PMU_DMEM_BASE | PMU_DMEM_CAL_STRUCT_BASE);
+
+	pmu_cal_eye_table_save((void *)(uintptr_t)(base), PMU_SLICE_DESC_MR16_OFF);
+	pmu_cal_lane_mask_or_all(base, PMU_SLICE_DESC_MR16_OFF, 0x41U);
+	pmu_cal_lane_mask_and_all(base, PMU_SLICE_DESC_MR16_OFF, 0xf3U);
+	pmu_cal_eye_table_save((void *)(uintptr_t)(base), PMU_SLICE_DESC_MR41_OFF);
+	pmu_cal_lane_mask_and_all(base, PMU_SLICE_DESC_MR41_OFF, 0x1fU);
+	pmu_multirank_slice_cal_dispatch((void *)(uintptr_t)base, 0U,
+					 0xfffeffffUL, (u32)-513, 0xffU, 0U);
+	pmu_delay_us(20000U, 0U);
+	pmu_cal_eye_table_restore((u8 *)(uintptr_t)base, PMU_SLICE_DESC_MR41_OFF);
+}
+
+/**
+ * pmu_adjust_step_limit() - Adjust coarse/fine step limit byte pair
+ * @pair: Two-byte array holding [0] coarse count and [1] fine tap offset
+ * @flag: Parity selector (non-zero adjusts odd counts; zero adjusts non-zero even counts)
+ *
+ * Decrements @pair[0] by 1 and adds 64 fine taps to @pair[1] when @pair[0]
+ * matches the parity condition selected by @flag.
+ */
+void pmu_adjust_step_limit(u8 *pair, u32 flag)
+{
+	u32 count = pair[0];
+
+	if (flag ? (count & 1U) : (count != 0U && !(count & 1U))) {
+		pair[0] = (u8)(count - 1U);
+		pair[1] = (u8)(pair[1] + 64U);
+	}
+}
+
+/**
+ * pmu_bist_pattern_bit_get() - Extract 1-bit truth value from 0xe4 lookup constant
+ * @shift: Left shift applied to @mask before indexing
+ * @mask: Input mask value
+ *
+ * Return: 1-bit lookup result ((0xe4 >> ((mask << shift) & 6)) & 1).
+ */
+u32 pmu_bist_pattern_bit_get(u32 shift, u32 mask)
+{
+	u32 lut;
+
+	mask = (mask << shift) & 6U;
+	lut = 0xe4U;
+	return (lut >> mask) & 1U;
+}
+
+struct map_pair {
+	u8 match;
+	u8 bit;
+};
+
+struct map_entry {
+	u8 base_mask;
+	u8 count;
+	struct map_pair pairs[8];
+};
+
+/**
+ * pmu_map_mask() - Remap bitmask through DCCM lookup table at 0x80000a7e
+ * @val: Input bitmask byte
+ * @index: Table entry index (0..N)
+ *
+ * Return: Remapped 8-bit mask combining base_mask and matched bit pairs.
+ */
+u8 pmu_map_mask(u8 val, u32 index)
+{
+	const struct map_entry *table =
+		(const struct map_entry *)PMU_DMEM_DQ_PIN_MAP_BASE;
+	const struct map_entry *entry = &table[index];
+	u8 result = entry->base_mask & val;
+	u32 i;
+
+	for (i = 0; i < entry->count; i++) {
+		if (val & entry->pairs[i].match)
+			result |= (1U << entry->pairs[i].bit);
+	}
+	return result;
+}
+
+/**
+ * pmu_math_freq_scale_div() - Divide signed value by scaled frequency factor
+ * @val: Signed dividend
+ *
+ * Divides @val by (dmem[0x80000008] << 7), rounding positive values toward
+ * +infinity and negative values toward 0.
+ *
+ * Return: Scaled signed quotient.
+ */
+s32 pmu_math_freq_scale_div(s32 val)
+{
+	u32 pll_ratio = dmem_read8(PMU_DMEM_PLL_RATIO);
+	u32 divisor;
+	u32 pos;
+
+	if (pll_ratio == 0U)
+		pll_ratio = 2U;
+	divisor = pll_ratio << 7;
+
+	if (val >= 1) {
+		u32 num = (u32)(val - 1);
+
+		return (s32)((num + divisor) / divisor);
+	}
+
+	pos = (u32)(-val);
+	return -(s32)(pos / divisor);
+}
+
+/**
+ * pmu_unpack_6() - Combine coarse and 6-bit fine delay pair into linear tap value
+ * @p: Two-byte array holding [0] coarse step and [1] 6-bit fine offset
+ *
+ * Return: Combined linear delay value ((p[0] << 6) + p[1]).
+ */
+u32 pmu_unpack_6(const u8 *p)
+{
+	return ((u32)p[0] << 6) + p[1];
+}
+
+/**
+ * pmu_unpack_7() - Combine coarse and 7-bit fine delay pair into linear tap value
+ * @p: Two-byte array holding [0] coarse step and [1] 7-bit fine offset
+ *
+ * Return: Combined linear delay value ((p[0] << 7) + p[1]).
+ */
+u32 pmu_unpack_7(const u8 *p)
+{
+	return ((u32)p[0] << 7) + p[1];
+}
+
+/**
+ * pmu_unpack_byte_pair() - Split packed delay value into coarse/fine byte pair
+ * @val: Packed delay value
+ * @out: Two-byte output buffer receiving [0] (val >> 6) and [1] (val & 0x3f)
+ */
+void pmu_unpack_byte_pair(u32 val, u8 *out)
+{
+	out[1] = (u8)(val & 0x3fU);
+	out[0] = (u8)(val >> 6);
+}
+
+/**
+ * pmu_cal_param_unpack() - Unpack fine and rounded coarse delay fields into byte pair
+ * @val: Packed 10-bit delay line parameter
+ * @out: Two-byte output array receiving [0] rounded coarse delay and [1] 6-bit fine delay
+ */
+void pmu_cal_param_unpack(u32 val, u8 *out)
+{
+	u32 c = val >> 6;
+	u32 f = val & 0x3fU;
+
+	out[1] = (u8)f;
+	out[0] = (u8)(((c >> 1) & 0x07U) + (c & 0x01U));
+}
+
+/**
+ * pmu_dly_line_repack() - Repack fine and shifted coarse delay fields
+ * @val: Input delay value
+ *
+ * Return: Recombined delay tap ((val & 0x3f) + (val & 0x40) + ((val >> 1) & 0x1c0)).
+ */
+u32 pmu_dly_line_repack(u32 val)
+{
+	return (val & 0x3fU) + (val & 0x40U) + ((val >> 1) & 0x1c0U);
+}
+
+/**
+ * pmu_midpoint_deviation_calc() - Compute signed LCDL tap deviation from nominal midpoint
+ * @val: Input LCDL tap value
+ *
+ * Return: (s8)(64 - val) when @val < 65, or (s8)((val << 2) + 48) when @val >= 65.
+ */
+s8 pmu_midpoint_deviation_calc(u32 val)
+{
+	u32 c = 64U;
+
+	if (val <= c)
+		return (s8)(c - val);
+
+	return (s8)((val << 2) + 48U);
+}
+
+/**
+ * pmu_cal_lane_mask_and_all() - Bitwise-AND byte across all 4 slice descriptors
+ * @base: Base DCCM address of the 4-slice (4 x 54-byte) descriptor table
+ * @offset: Byte offset within each 54-byte slice descriptor
+ * @mask: 8-bit mask applied via bitwise AND to each slice byte
+ */
+void pmu_cal_lane_mask_and_all(u32 base, u32 offset, u32 mask)
+{
+	__volatile__ u8 *p = (__volatile__ u8 *)(base + offset);
+	u32 i;
+
+	for (i = 0U; i < PMU_SLICE_DESC_TOTAL_BYTES; i += PMU_SLICE_DESC_SIZE)
+		p[i] &= (u8)mask;
+}
+
+/**
+ * pmu_cal_lane_mask_or_all() - Bitwise-OR byte across all 4 slice descriptors
+ * @base: Base DCCM address of the 4-slice (4 x 54-byte) descriptor table
+ * @offset: Byte offset within each 54-byte slice descriptor
+ * @mask: 8-bit mask applied via bitwise OR to each slice byte
+ */
+void pmu_cal_lane_mask_or_all(u32 base, u32 offset, u32 mask)
+{
+	__volatile__ u8 *p = (__volatile__ u8 *)(base + offset);
+	u32 i;
+
+	for (i = 0U; i < PMU_SLICE_DESC_TOTAL_BYTES; i += PMU_SLICE_DESC_SIZE)
+		p[i] |= (u8)mask;
+}
+
+/**
+ * pmu_cal_lcdl_coarse_fine_pair_pack() - Pack coarse/fine LCDL delay pairs into table
+ * @ch_idx: Channel index
+ * @threshold: Channel threshold value
+ * @limit: Channel limit value
+ * @pair_a: Primary coarse/fine pair A
+ * @pair_b: Primary coarse/fine pair B
+ * @pair_c: Secondary coarse/fine pair C
+ * @pair_d: Secondary coarse/fine pair D
+ * @table_base: Base pointer of destination LCDL delay table
+ */
+void pmu_cal_lcdl_coarse_fine_pair_pack(u32 ch_idx, u32 threshold, u32 limit,
+					const u8 *pair_a, const u8 *pair_b,
+					const u8 *pair_c, const u8 *pair_d,
+					void *table_base)
+{
+	u8 *entry = (u8 *)table_base + (ch_idx << 2);
+	bool use_sec = (u8)limit > (u8)threshold;
+	const u8 *pa = use_sec ? pair_c : pair_a;
+	const u8 *pb = use_sec ? pair_d : pair_b;
+	const u8 *src = entry + (use_sec ? 0x02U : 0x12U);
+	u16 h_a = *(const u16 *)src;
+	u16 h_b = *(const u16 *)(src + 8U);
+
+	*(u16 *)(entry + 0x22U) = h_a;
+	*(u16 *)(entry + 0x2aU) = h_b;
+	*(u16 *)(entry + 0x20U) = (u16)(((u16)pa[0] << 7) + pa[1]);
+	*(u16 *)(entry + 0x28U) = (u16)(((u16)pb[0] << 7) + pb[1]);
+}
+
+/**
+ * pmu_cal_eye_margin_quadratic_cost_calc() - Compute weighted quadratic eye-centering cost
+ * @val: Packed eye sample word (low byte: center offset, high byte: magnitude)
+ * @target: Signed 8-bit target center offset
+ * @min_bound: Minimum valid magnitude bound
+ * @max_bound: Maximum valid magnitude bound
+ * @out_overflow: Output pointer receiving 0x3f on violation or abs(delta) in-bounds
+ *
+ * Return: Weighted quadratic cost ((delta^2 * w1) + (overflow^2 * w2)).
+ */
+u32 pmu_cal_eye_margin_quadratic_cost_calc(u32 val, u32 target, u32 min_bound,
+					   u32 max_bound, u8 *out_overflow)
+{
+	s32 delta = (s32)((s8)val) - (s32)((s8)target);
+	u32 mag = (u16)val >> 8;
+	u32 min_b = (u8)min_bound;
+	u32 max_b = (u8)max_bound;
+	s32 over;
+	u8 out = 0x3fU;
+
+	if (delta < 0)
+		delta = -delta;
+	over = (s32)(min_b - mag);
+	if (over <= 0) {
+		over = (s32)(mag - max_b);
+		if (over <= 0) {
+			over = 0;
+			out = (u8)delta;
+		}
+	}
+	*out_overflow = out;
+	return (u32)(u16)(delta * delta) * dmem_read16(PMU_DMEM_COST_WEIGHT_1) +
+	       (u32)(u16)(over * over) * dmem_read16(PMU_DMEM_COST_WEIGHT_2);
+}
diff --git a/arch/arm/mach-sunxi/pmu/pmu_telemetry.c b/arch/arm/mach-sunxi/pmu/pmu_telemetry.c
new file mode 100644
index 00000000000..ea47e991fcf
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu_telemetry.c
@@ -0,0 +1,619 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Allwinner A733 Synopsys DDR PHY PMU Mailbox POST IPC & Assertion Handlers
+ */
+
+#include "pmu_fw.h"
+
+static void pmu_mailbox_post_exec_wait(void);
+
+/**
+ * pmu_mailbox_post_cmd_dispatch() - Dispatch 16-bit POST command to PHY mailbox
+ * @cmd: Command code to transmit (pulses 0x90040238 for terminal codes 0xff or 7)
+ */
+noinline void pmu_mailbox_post_cmd_dispatch(u32 cmd)
+{
+	if (cmd == 255U || cmd == 7U) {
+		phy_write16(PHY_REG_CMD_DISPATCH,
+			    (cmd == 255U) ? 0x0004U : 0x0001U);
+		phy_write16(PHY_REG_CMD_DISPATCH, 0x0000U);
+	}
+
+	phy_write16(PHY_REG_MAILBOX_STREAM, (u16)cmd);
+	phy_write16(PHY_REG_MAILBOX_STREAM + 2U, 0x0000U);
+	pmu_mailbox_post_exec_wait();
+}
+
+/**
+ * pmu_mailbox_post_exec_wait() - Handshake PHY mailbox interrupt and busy status
+ *
+ * Waits for bit 0 of PHY register 0x90180008 to clear, triggers the mailbox
+ * interrupt at 0x90180066 with 1, and waits for bit 0 of 0x90180008 to assert.
+ */
+static noinline void pmu_mailbox_post_exec_wait(void)
+{
+	while ((phy_read16(PHY_REG_MAILBOX_STAT) & 1U) != 0U)
+		;
+	phy_write16(PHY_REG_MAILBOX_TRIG, 0x0001U);
+	while ((phy_read16(PHY_REG_MAILBOX_STAT) & 1U) == 0U)
+		;
+}
+
+/**
+ * pmu_assert_or_halt() - Validate condition or record panic code and halt PMU
+ * @cond: Condition value (non-zero continues execution; zero triggers fatal halt)
+ * @assert_code: 32-bit diagnostic code recorded at DCCM 0x8000000c on failure
+ */
+void pmu_assert_or_halt(u32 cond, u32 assert_code)
+{
+	if (cond != 0U)
+		return;
+
+	*(__volatile__ u32 *)PMU_DMEM_ASSERT_CODE = assert_code;
+	*(__volatile__ u8 *)PMU_DMEM_PSTATE_FLAGS |= 0x02U;
+	pmu_mailbox_post_cmd_dispatch(255U);
+	__builtin_arc_sr(0U, PMU_AUX_RTC_CTRL);
+	__builtin_arc_flag(1);
+	for (;;)
+		;
+}
+
+/**
+ * pmu_ac_lane_profile_setup() - Program AC lane profile registers and gate settle delay
+ */
+void pmu_ac_lane_profile_setup(void)
+{
+	const u8 *ac_desc = (const u8 *)PMU_DMEM_AC_PROFILE_EN_ADDR;
+	u16 saved_gate_mask;
+	u16 saved_gate_ctrl;
+	u8 cal_status;
+	s32 delay_diff;
+
+	saved_gate_mask = phy_read16(PHY_REG_GATE_MASK);
+	saved_gate_ctrl = phy_read16(PHY_REG_GATE_CTRL);
+
+	phy_write16(PHY_REG_GATE_CTRL, 0U);
+	phy_write16(PHY_REG_GATE_MASK, 0x00ffU);
+
+	cal_status = *(const u8 *)PMU_DMEM_TIMING_LIM;
+	phy_write16(PHY_REG_VREF_STAT, (u16)cal_status | 0x0100U);
+
+	delay_diff = (s32)(*(const u8 *)PMU_DMEM_LANE_STATUS + cal_status) - 2;
+
+	if (ac_desc[0] != 0U) {
+		const u16 *ac_words = (const u16 *)(ac_desc + 4);
+		u32 csr_off = pmu_sdata()->active_csr_offset << 1;
+
+		phy_write16(PHY_REG_AC_DRIVE_CFG5 + csr_off, ac_words[0]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG6 + csr_off, ac_words[1]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG3 + csr_off, ac_words[2]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG4 + csr_off, ac_words[3]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG0 + csr_off, ac_desc[3]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG1 + csr_off, ac_desc[1]);
+		phy_write16(PHY_REG_AC_DRIVE_CFG2 + csr_off, ac_desc[2]);
+	}
+
+	if (delay_diff < 0)
+		delay_diff += (s32)((u32)cal_status *
+				    *(const u8 *)PMU_DMEM_PLL_RATIO);
+
+	phy_write16(PHY_REG_DRAM_TYPE_CFG, (u16)delay_diff);
+	pmu_delay_us(11000U, 0U);
+
+	phy_write16(PHY_REG_GATE_MASK, saved_gate_mask);
+	phy_write16(PHY_REG_GATE_CTRL, saved_gate_ctrl);
+
+	*(__volatile__ u8 *)PMU_DMEM_AC_SIGNED_STEP =
+		(u8)(((cal_status >> 1) & ~1U) - 1U);
+}
+
+/**
+ * pmu_cmd_code_map_log() - Map command/subcode to CBT lane limit code and log
+ * @cmd_code: Primary command code
+ * @sub_code: Sub-command selector (0 selects @cmd_code mapping)
+ */
+void pmu_cmd_code_map_log(u32 cmd_code, u32 sub_code)
+{
+	u8 map_code = 9U;
+
+	if (sub_code == 0U) {
+		u32 masked = cmd_code & 0x0fffU;
+
+		if (masked >= 257U && masked <= 261U)
+			map_code = (u8)(masked - 255U);
+		else if (masked == 272U)
+			map_code = 7U;
+		else if (masked == 512U)
+			map_code = 8U;
+	} else if (sub_code == 1U) {
+		map_code = 0U;
+	} else if (sub_code == 2U) {
+		map_code = 1U;
+	} else if (sub_code == 4U || sub_code == 17U) {
+		map_code = 2U;
+	} else if (sub_code == 18U) {
+		map_code = 3U;
+	} else if (sub_code == 8U || sub_code == 19U) {
+		map_code = 4U;
+	} else if (sub_code == 20U) {
+		map_code = 5U;
+	} else if (sub_code == 21U) {
+		map_code = 6U;
+	} else if (sub_code == 26U) {
+		map_code = 7U;
+	} else if (sub_code == 0x20U) {
+		map_code = 8U;
+	} else {
+		pmu_assert_or_halt(0U, PMU_ERR_CMD_SUBCODE_INVALID);
+		map_code = pmu_sdata()->freq_mode;
+	}
+
+	pmu_sdata()->freq_mode = map_code;
+}
+
+/**
+ * pmu_slice_metric_scan_and_program() - Scan slice metrics and program DBYTE delay CSRs
+ */
+void pmu_slice_metric_scan_and_program(void)
+{
+	u8 start_slice;
+	u8 end_slice;
+	u16 num_ranks;
+	u32 ch_offset;
+	u32 slice;
+
+	start_slice = dmem_read8(PMU_DMEM_SLICE_START);
+	end_slice = dmem_read8(PMU_DMEM_SLICE_END);
+	num_ranks = pmu_sdata()->num_ranks;
+	ch_offset = pmu_sdata()->active_csr_offset;
+
+	for (slice = start_slice; slice <= end_slice; slice++) {
+		const __volatile__ u16 *slice_metrics =
+			(const __volatile__ u16 *)(PMU_DMEM_CBT_DELAY_ARR +
+						   (slice << 3));
+		u16 max_val = slice_metrics[0];
+		u16 min_val = max_val;
+		u32 k;
+		u32 midpoint;
+		u32 diff;
+		u16 reg_val_lo;
+		u16 reg_val_hi;
+		u32 slice_base;
+		u32 bank;
+
+		for (k = 0U; k < num_ranks; k++) {
+			u16 val = slice_metrics[k];
+
+			if (val > max_val)
+				max_val = val;
+			if (val < min_val)
+				min_val = val;
+		}
+
+		midpoint = (max_val + min_val) >> 1;
+		diff = 12U - midpoint;
+
+		reg_val_lo = (u16)((diff << 4) | midpoint);
+		reg_val_hi = (u16)(diff | (midpoint << 4));
+		slice_base = PHY_REG_DBYTE_BASE |
+			     (((slice << 12) | ch_offset) << 1);
+
+		for (bank = 0U; bank < 2U; bank++) {
+			u32 reg_low = (bank != 0U) ? 0x5eU : 0x62U;
+			u32 reg_high = reg_low + 2U;
+			u16 w1 = (*(__volatile__ const u16 *)
+				  (PHY_REG_DBYTE_BASE +
+				   ((reg_low | ch_offset) << 1)) & 768U) |
+				 reg_val_lo;
+			u16 w2 = (*(__volatile__ const u16 *)
+				  (PHY_REG_DBYTE_BASE +
+				   ((reg_high | ch_offset) << 1)) & 768U) |
+				 reg_val_hi;
+			u32 a1 = slice_base + (reg_low << 1);
+			u32 a2 = slice_base + (reg_high << 1);
+
+			*(__volatile__ u16 *)a1 = w1;
+			*(__volatile__ u16 *)(a1 + 2U) = w1;
+			*(__volatile__ u16 *)a2 = w2;
+			*(__volatile__ u16 *)(a2 + 2U) = w2;
+		}
+	}
+}
+
+/**
+ * pmu_mr22_bit4_check() - Query bit 4 of training configuration byte 0x96
+ *
+ * Return: 1 if bit 4 of DCCM 0x80000096 is set, 0 otherwise.
+ */
+u32 pmu_mr22_bit4_check(void)
+{
+	return (*(__volatile__ u8 *)PMU_DMEM_MR22_ADDR >> 4) & 1;
+}
+
+/**
+ * pmu_stage_slice_flag_check() - Extract 2-bit mode field gated by DCCM 0x407 bit 6
+ *
+ * Return: Bits [4:3] of halfword at DCCM 0x80000408 if bit 6 of DCCM 0x80000407
+ *         is set, or 0 otherwise.
+ */
+u32 pmu_stage_slice_flag_check(void)
+{
+	u32 flag = pmu_sdata()->stage_slice_idx;
+
+	if (!(flag & 0x40U))
+		return 0;
+
+	return (pmu_sdata()->stage_lane_idx >> 3) & 3U;
+}
+
+/**
+ * pmu_check_freq_lt_3200() - Check whether DRAM data rate is below 3200 MT/s
+ *
+ * Return: 1 if halfword at DCCM 0x80000006 is less than 3200, 0 otherwise.
+ */
+u32 pmu_check_freq_lt_3200(void)
+{
+	return dmem_read16(PMU_DMEM_DRAM_FREQ_OFF) < 3200U;
+}
+
+/**
+ * pmu_is_lpddr4() - Check if DRAM protocol configuration is set to LPDDR4
+ *
+ * Return: 1 if bits [1:0] of DCCM 0x8000008a equal 1, 0 otherwise.
+ */
+u32 pmu_is_lpddr4(void)
+{
+	return (dmem_read8(PMU_DMEM_MR19_OFF) & 3U) == 1U;
+}
+
+/**
+ * pmu_is_lpddr5() - Check if DRAM protocol mode bits [1:0] at 0x8e are zero
+ *
+ * Return: 1 if bits [1:0] of DCCM 0x8000008e equal 0, 0 otherwise.
+ */
+u32 pmu_is_lpddr5(void)
+{
+	return (dmem_read8(PMU_DMEM_MR20_ADDR) & 3U) == 0U;
+}
+
+/**
+ * pmu_check_stage() - Check whether stage index belongs to {0, 6, 14, 40}
+ * @val: Calibration stage index to test
+ *
+ * Return: 1 if @val is 0, 6, 14, or 40; 0 otherwise.
+ */
+u32 pmu_check_stage(u32 val)
+{
+	if (val <= 14)
+		return (0x4041U >> val) & 1;
+	return val == 40;
+}
+
+/**
+ * pmu_cal_marker_clear() - Clear 16-bit calibration state halfword at DCCM 0x80000458
+ */
+void pmu_cal_marker_clear(void)
+{
+	pmu_sdata()->cal_marker_a = 0;
+}
+
+/**
+ * pmu_cbt_cal_active_clear() - Clear byte flag at DCCM 0x8000045c to 0
+ */
+void pmu_cbt_cal_active_clear(void)
+{
+	pmu_sdata()->cbt_cal_active = 0;
+}
+
+/**
+ * pmu_cbt_cal_active_set() - Set byte flag at DCCM 0x8000045c to 1
+ */
+void pmu_cbt_cal_active_set(void)
+{
+	pmu_sdata()->cbt_cal_active = 1;
+}
+
+/**
+ * pmu_cbt_step_stat_set() - Set byte flag at DCCM 0x8000046b to 1
+ */
+void pmu_cbt_step_stat_set(void)
+{
+	pmu_sdata()->cbt_step_stat = 1;
+}
+
+/**
+ * pmu_cbt_config_get() - Read calibration status byte from DCCM 0x8000046a
+ *
+ * Return: 8-bit value stored at DCCM 0x8000046a.
+ */
+u8 pmu_cbt_config_get(void)
+{
+	return pmu_sdata()->cbt_config;
+}
+
+/**
+ * pmu_cal_mode_flag_get() - Read configuration byte from DCCM 0x80000005
+ *
+ * Return: 8-bit value stored at DCCM 0x80000005.
+ */
+u8 pmu_cal_mode_flag_get(void)
+{
+	return *(__volatile__ u8 *)PMU_DMEM_CAL_MODE_FLAG_ADDR;
+}
+
+/**
+ * pmu_lane_mask_bit_get() - Extract bit from DCCM 0x8000001c status byte
+ * @word_idx: 2-bit pair index (multiplied by 2)
+ * @bit_shift: Additional bit offset within the pair
+ *
+ * Return: Extracted bit ((dmem[0x1c] >> ((word_idx << 1) + bit_shift)) & 1).
+ */
+u32 pmu_lane_mask_bit_get(u32 word_idx, u32 bit_shift)
+{
+	u32 val = dmem_read8(PMU_DMEM_LANE_MASK);
+	u32 shift = (word_idx << 1) + bit_shift;
+
+	return (val >> shift) & 1U;
+}
+
+/**
+ * pmu_phy_query_operating_mode() - Query normalized PHY operating mode
+ *
+ * Return: Operating mode index (0..4) derived from PHY register 0x90020012.
+ *
+ * Reads the channel-adjusted PHY operating mode register at 0x90020012 and
+ * maps raw mode bits [2:0] into the normalized PMU operating mode code.
+ */
+u32 pmu_phy_query_operating_mode(void)
+{
+	u32 ch_offset = *(__volatile__ u32 *)PMU_DMEM_ACTIVE_CH_OFFSET;
+	u16 val = *(__volatile__ u16 *)(PHY_REG_OP_MODE | (ch_offset << 1));
+	u32 mode = val & 7;
+
+	if (mode <= 1)
+		return mode;
+
+	return ((val & 6) >> 1) + 1;
+}
+
+/**
+ * pmu_cal_marker_pair_set() - Write 16-bit value to DCCM 0x80000458 and 0x8000045e
+ * @val: Halfword value to store at both offsets
+ */
+void pmu_cal_marker_pair_set(u16 val)
+{
+	pmu_sdata()->cal_marker_a = val;
+	pmu_sdata()->cal_marker_b = val;
+}
+
+/**
+ * pmu_cbt_config_set() - Set DCCM 0x8000045a flag to 1 and store byte at 0x8000046a
+ * @val: Byte value to write to DCCM 0x8000046a
+ */
+void pmu_cbt_config_set(u8 val)
+{
+	pmu_sdata()->cbt_state = 1;
+	pmu_sdata()->cbt_config = val;
+}
+
+/**
+ * pmu_post_cmd_conditional_dispatch() - Conditionally dispatch post-command and sync clock gate
+ * @val: Command code to pass to pmu_mailbox_post_cmd_dispatch()
+ *
+ * Dispatches @val to pmu_mailbox_post_cmd_dispatch() when DCCM 0x80000012 is
+ * at most 0xc8, then pulses the PHY clock gate synchronizer.
+ */
+void pmu_post_cmd_conditional_dispatch(u32 val)
+{
+	u8 threshold = *(__volatile__ u8 *)PMU_DMEM_POST_THRESH;
+
+	if (threshold <= 0xc8)
+		pmu_mailbox_post_cmd_dispatch(val);
+
+	pmu_phy_clk_gate_sync_pulse();
+}
+
+/**
+ * pmu_cal_stride_get() - Read calibration step stride from DCCM 0x80000458
+ *
+ * Return: 16-bit halfword at DCCM 0x80000458 logically shifted right by 2 bits.
+ */
+u16 pmu_cal_stride_get(void)
+{
+	return pmu_sdata()->cal_marker_a >> 2;
+}
+
+/**
+ * pmu_cal_marker_verify() - Compare calibration markers A and B and dispatch fallback
+ *
+ * Return: 0 if halfwords at DCCM 0x80000458 and 0x8000045e match, or the result
+ *         of pmu_cal_marker_status_update() when they differ.
+ */
+u16 pmu_cal_marker_verify(void)
+{
+	u32 marker_a;
+	u32 marker_b;
+	u32 diff;
+
+	marker_a = pmu_sdata()->cal_marker_a;
+	marker_b = pmu_sdata()->cal_marker_b;
+	diff = marker_a ^ marker_b;
+	if (diff == 0U)
+		return (u16)diff;
+
+	return pmu_cal_marker_status_update();
+}
+
+/**
+ * pmu_dram_cfg_bit13_check() - Query bit 13 of DRAM config flags at DCCM 0x0a
+ * @rank: Rank index (returns 0 if equal to 4)
+ * @flag: Secondary gating flag (returns 0 if non-zero)
+ *
+ * Return: Bit 13 of DCCM 0x8000000a when @rank != 4 and @flag == 0, else 0.
+ */
+u32 pmu_dram_cfg_bit13_check(u32 rank, u32 flag)
+{
+	u16 cfg;
+
+	if (rank == 4U || flag != 0U)
+		return 0U;
+
+	cfg = *(__volatile__ u16 *)(PMU_DMEM_BASE + PMU_DMEM_DRAM_CFG_FLAGS);
+	return (u32)((cfg >> 13) & 1U);
+}
+
+/**
+ * pmu_dmem_training_flags_eval() - Assemble 5-bit composite Vref/training mode byte
+ *
+ * Return: 5-bit composite flag byte combining DCCM 0x62, 0x72, and 0x96.
+ */
+u8 pmu_dmem_training_flags_eval(void)
+{
+	u32 mr3_val = dmem_read8(PMU_DMEM_MR3_ADDR);
+	u32 mr13_val = dmem_read8(PMU_DMEM_MR13_ADDR);
+	u32 mr22_val = dmem_read8(PMU_DMEM_MR22_ADDR);
+	u32 res = (mr3_val >> 7) | ((mr3_val >> 5) & 2U);
+
+	if (mr22_val & 0x40U)
+		res |= 4U;
+	if (mr22_val & 0x10U)
+		res |= 8U;
+	if (!(mr13_val & 0x20U))
+		res |= 16U;
+
+	return (u8)res;
+}
+
+/**
+ * pmu_cal_marker_status_update() - Recompute calibration marker A and clear tracker
+ *
+ * Return: Updated 16-bit calibration marker written to DCCM 0x80000458.
+ *
+ * Sets DCCM 0x80000dc4 to 1 when 0x80000dbe is non-zero, invokes
+ * (u16)pmu_cal_tracker_csr_commit(0x80000d9c) to compute the updated marker stored at
+ * DCCM 0x80000458, zeroes the 32-byte tracker block at 0x80000d9c, and clears
+ * the four trailing status halfwords at 0x80000dbe..0x80000dc4.
+ */
+u16 pmu_cal_marker_status_update(void)
+{
+	__volatile__ struct pmu_cal_tracker *trk = pmu_tracker();
+	u16 zero = 0U;
+	u16 marker;
+
+	if (trk->repeat_cnt != 0U)
+		trk->commit_flag = 1U;
+
+	marker = (u16)pmu_cal_tracker_csr_commit(trk);
+	pmu_sdata()->cal_marker_a = marker;
+	memset((void *)trk->slot0, 0, PMU_TRACKER_SLOTS_BYTES);
+	trk->commit_flag = zero;
+	trk->ext_flag = zero;
+	trk->slot0_mode = zero;
+	trk->repeat_cnt = zero;
+	return marker;
+}
+
+/**
+ * pmu_cal_pad_voltage_dac_set() - Evaluate Vref DAC polarity and override state
+ * @val: Input step/direction indicator (tested for non-zero byte value)
+ * @mode: Vref domain selector ((@mode & ~1) == 2 selects bit 7 of DCCM 0x62, else bit 6)
+ *
+ * Return: 1 or 0 from DCCM 0x800000e7 override bits [1:0] when active, or
+ *         ((u8)@val != 0) masked by the selected polarity bit of DCCM 0x80000062.
+ */
+u32 pmu_cal_pad_voltage_dac_set(u32 val, u32 mode)
+{
+	u32 ctrl = dmem_read8(PMU_DMEM_VREF_OVR_CTRL_ADDR);
+	u32 dir;
+	u32 bit;
+
+	if (ctrl & 3U)
+		return ctrl & 1U;
+
+	dir = dmem_read8(PMU_DMEM_MR3_ADDR);
+	bit = ((mode & ~1U) == 2U) ? (dir >> 7) : ((dir >> 6) & 1U);
+	return ((u8)val != 0U) & bit;
+}
+
+/**
+ * pmu_cal_channel_rank_config_get() - Interrogate channel and rank configuration
+ * @rank: Logical rank/slice index (0..1 for channel 0, 2..3 for channel 1)
+ * @out_cfg: Output pointer receiving the 16-bit rank polarity bit (0 or 1)
+ * @out_mode_sel: Output pointer receiving the 1-hot rank bitmask (1 << bit)
+ * @out_num_slices: Output pointer receiving the active channel mode (1 or 2)
+ *
+ * Return: 0 if the requested rank is enabled in the channel mask (updating
+ *         *@out_num_slices), or 1 if disabled.
+ */
+u32 pmu_cal_channel_rank_config_get(u32 rank, u16 *out_cfg, u8 *out_mode_sel,
+				    u8 *out_num_slices)
+{
+	u32 idx = (u16)rank;
+	u32 is_ch1 = (idx >= 2U);
+	u32 base = is_ch1 ? PMU_DMEM_CH1_ACTIVE_FLAG :
+			    PMU_DMEM_CH0_ANALOG_EN;
+	const __volatile__ u8 *cfg_base =
+		(const __volatile__ u8 *)dmem_ptr(base);
+	u32 bit = (cfg_base[13] ^ idx) & 1U;
+	u8 mask = (u8)(1U << bit);
+
+	*out_cfg = (u16)bit;
+	*out_mode_sel = mask;
+	if ((cfg_base[0] & mask) == 0U)
+		return 1U;
+
+	*out_num_slices = (u8)(is_ch1 + 1U);
+	return 0U;
+}
+
+/**
+ * pmu_cal_channel_rank_bounds_verify() - Dispatch fatal assertion for status 1..7
+ * @err_id: Error status code (1..7)
+ */
+void pmu_cal_channel_rank_bounds_verify(u32 err_id)
+{
+	u32 idx = (err_id & 0xffU) - 1U;
+
+	if (idx < 7U)
+		pmu_assert_or_halt(0U, PMU_ERR_RANK_BOUNDS_BASE + (idx << 16));
+}
+
+/**
+ * pmu_dbyte_dq_deskew_regs_save_and_ramp() - Extract and clamp gate eye margin descriptors
+ * @out_a: Output pointer for primary margin descriptor byte
+ * @out_b: Output pointer for secondary margin descriptor byte
+ * @out_c: Output pointer for tertiary margin descriptor byte
+ * @flag: Mode/rank flag selector
+ * @extra: Secondary offset selector
+ */
+void pmu_dbyte_dq_deskew_regs_save_and_ramp(u8 *out_a, u8 *out_b, u8 *out_c,
+					    u32 flag, u32 extra)
+{
+	u32 f8 = (u8)flag;
+	u32 e8 = (u8)extra;
+	u32 offset = (f8 == 4U) ? 4U :
+		     (((e8 == 0U) ? 2U : 0U) + (((f8 >> 1) == 1U) ? 1U : 0U));
+	const u8 *desc = (const u8 *)dmem_ptr(PMU_DMEM_GATE_DESC + offset);
+	u8 c = desc[10];
+
+	if (c == 0U)
+		return;
+
+	*out_a = desc[0];
+	*out_b = desc[5];
+	*out_c = c;
+
+	if (f8 != 4U && e8 == 0U) {
+		if ((dmem_read16(PMU_DMEM_DRAM_CFG_FLAGS) & 0x2000U) != 0U) {
+			u32 sum = (u32)(*out_b) + (u32)(*out_a);
+			u32 lim = 127U;
+
+			if (sum > lim)
+				sum = lim;
+			*out_b = (u8)sum;
+			*out_a = 0U;
+		}
+	}
+}
-- 
2.53.0

