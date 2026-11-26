Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB7606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eC7Kva2t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02E72409E9;
	Thu, 26 Nov 2026 19:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFIIiN0U3g41; Thu, 26 Nov 2026 19:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76119409FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795720041;
	b=pqgpjLIaX4z6cGunukuKhASRRv8ksirjpp21BNlsCxJrz/LLLGbU5lW2RiKBD/bnG0Bm
	 U2UD8KTvau4A8qXiqT+bwos3QwZET/nk4aj0Z8HwJzwP/0ab040srld5oIkFPTNLJaowF
	 rmE2YKuFf05yRiGgOZaypPm4odidTouMponJaHXhjPF2xAcE284mBMpfg/3Eks0bgwH+0
	 BniNqkG0P9eHxazlFxVceE/Nxh89yZDLXyGodMO49wvUK9nBs3k6pwUKEfswr1NwHUMoQ
	 POTqXAxr4cHmpj0UEj9/apS+FP5FFxVK03mGURRBQNVjzM8NErlffjz/GQz5Kn23njA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795720041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ozGPMf8lVlxPsrQsVOLkPBtDZRvPTOn4j1SJw2G+QtU=;
	b=nQlg/xdId5C88iA4av3tGRxguM5Xc8C/gF2ec3ncODahw6VblKR6aTSucFcTNvPFlDy0
	 bdkxNqAi4hkoOfHoR0xqS4FObTNcIB/1BQGgxXz2QLWo1EdYHLtoe8fsrBuzwxz2UwsKx
	 3/X0aYqNfv+TzYcy6nPRRHgXjdc8T06Rpodblaf6j5RyVmR/B8epbtyotS4gjHtE/stBu
	 PfGPtXzmvA+rKMmIrEQ2DWVMPO/sDkEX9VTdIawnPGX3nRWlfxwbSR6crCpyEExtUeS2N
	 Sq6ZprvcTZgU4UViwwAAvFqGU1hVankGGh1H/fsuChpZE0MCg7BUAnoch5lSD7TQOPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795720041;
	bh=ozGPMf8lVlxPsrQsVOLkPBtDZRvPTOn4j1SJw2G+QtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eC7Kva2tmEQ8iUSeODud+bINXf7J9Z+6t7Ak+82CsKiyuRhinjV7XaRs3RCEGzNM2
	 qDK0Hr1eqywW3hf7+uoQHW279L7l8j1fRfzkwB8BFSGEy43D/ICz3xlkiieL1kf/L1
	 NRyX3F/Bjm7Z2F5ZqYc76dXxr7bOoMWGcmNL7P+RpBGXarzxRu3/uaaXIewBd1tht3
	 /Ci+W3HwmwHNfqcJQ/bTeoDj7eGKhLjbI3x0Y79UsDFX4mszi6Xu3jOX4hbthFEksD
	 IWJBqwSjvsYqyoV2hT5KUIF+L8YcHmMHYfFB7Tx7IgCQqtQxPuXYQb4mPDFIBfIJ2C
	 4YviGPiBAQBXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76119409FC;
	Thu, 26 Nov 2026 19:07:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E0CC11AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C71D0811B9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CiQRpd76tO0S for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 19:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F02781189
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F02781189
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:07:17 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xWeoO-000000007sG-00U0;
 Thu, 26 Nov 2026 19:07:16 +0000
Date: Thu, 26 Nov 2026 19:07:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
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
Subject: Re: [PATCH 18/26] sunxi: dram: a733: Add ARC PMU training state
 machine
Message-ID: <awiDYf0T8BVXib0I@makrotopia.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-19-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113023236.569054-19-alastair@d-silva.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 13:32:28 +1100, Alastair D'Silva wrote:
> [...]
> +static u32 pmu_rx_en_poll_rx_fifo_ranks(u8 ch0_rank, u8 ch1_rank,
> +					s8 *initial_step, u8 *scan_matrix)
> +{
> +	u32 num_slices = (ch1_rank != 0) ? 2 : 1;
> +	u32 idx;
> +
> +	for (idx = 0; idx < 4; idx++) {
> +		u16 out_cfg;
> +		u8 out_mode_sel;
> +		u8 out_num_slices;
> +		u32 csr_offset;
> +		u32 reg_base;
> +		u8 channel;
> +		u8 rank;
> +		s8 ret;
> +
> +		if (pmu_cal_channel_rank_config_get(idx, &out_cfg,
> +						    &out_mode_sel,
> +						    &out_num_slices) != 0)
> +			continue;
> +
> +		num_slices = (u32)out_num_slices;
> +		dmem_write8(PMU_DMEM_AC_CAL_ACTIVE, 1);
> +		pmu_phy_mode_cfg_dispatch(num_slices);
> +
> +		/* Re-assert both analog receiver power rails */
> +		phy_write16(PHY_REG_CH0_ANALOG_PWR, (u16)ch0_rank);
> +		phy_write16(PHY_REG_CH1_ANALOG_PWR, (u16)ch1_rank);
> +
> +		channel = out_num_slices - 1U;
> +		rank = dmem_read8(PMU_DMEM_ACTIVE_RANK);
> +		csr_offset = dmem_read32(PMU_DMEM_ACTIVE_CH_OFFSET);
> +		reg_base = (((u32)channel << 12) | csr_offset) << 1;
> +
> +		phy_write16(PHY_AC_GATE_CTRL_RESET | reg_base, 0);
> +		phy_write16(PHY_AC_BASE_OFFSET_CTRL | reg_base, 0);
> +
> +		/* Primary Scan: enable_scan = 1 */
> +		ret = pmu_cal_dbyte_rx_fifo_reset_poll(channel,
> +						       (u32)out_mode_sel, 1,
> +						       scan_matrix);
> +		initial_step[((u32)rank << 1) + (u32)out_cfg] = ret;
> +
> +		/* Baseline Scan: enable_scan = 0, first arg is out_mode_sel */
> +		(void)pmu_cal_dbyte_rx_fifo_reset_poll(channel,
> +						       (u32)out_mode_sel, 0,
> +						       scan_matrix);
> +	}
> +
> +	return num_slices;
> +}

This scans the wrong AC slice. "channel" is derived from the slice
count, and the initial step table is indexed by the active rank byte,
where both have to use the slice pmu_cal_channel_rank_config_get() just
selected. That function does not record the slice either (see my reply
to patch 15), so the CA sampler reads the DBYTEs of channel 0 for all
four passes. On my Orange Pi 4 Pro (4 GiB, two channels) the CA delays
of channel 1 keep their reset value 0x40 as a result; the vendor boot0
trains them to 0x33..0x3b.

The firmware in boot0 also does not write the analogue power registers
at this point.

[...]
> +		if (best_len == 0) {
> +			/* Nominal midpoint fallback (0x40) */
> +			center_delay[ca] = 0x40;
> +		} else {
> +			s32 center = (s32)best_start +
> +				     (s32)((best_len & ~1U) / 2) +
> +				     lower_bound;
> +
> +			if (center < 0)
> +				center = 0;
> +			if (center > upper_bound)
> +				center = upper_bound;
> +			center_delay[ca] = (u16)center;
> +		}
> +	}

A lane without any passing delay gets 0x40 here and training carries
on. The boot0 firmware treats that as fatal (assert 0x01390000). Its
window search also differs at the end of the scan: a run that reaches
the last delay is only used when no other window was found.

[...]
> +static void pmu_cal_rx_en_pre_init(void)
> +{
> +	u8 *scan_matrix = (u8 *)dmem_ptr(PMU_DMEM_RX_SCAN_MATRIX);
> +	u8 swizzle_map[14] = { 0 };
> +	s8 initial_step[4] = { 0 };
> +	u8 descriptor_backup[6];
> +	u8 ch0_rank;
> +	u8 ch1_rank;
> +	u8 raw_step;
> +	u32 num_slices;
> +	u32 ch_offset;
> +	u8 step;
> +	u32 ca;
> +	u32 s;
> +
> +	ch0_rank = dmem_read8(PMU_DMEM_CH0_ANALOG_EN);
> +	ch1_rank = dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG);
> +	if (ch0_rank == 0 && ch1_rank == 0)
> +		return;
> +
> +	/* Pre-condition clock gate check */
> +	if ((dmem_read8(PMU_DMEM_CLK_GATE_FLAG) & BIT(3)) != 0) {
> +		pmu_assert_or_halt(0, PMU_ERR_LPCA_CLK_GATE_PRECOND);
> +		return;
> +	}
> +
> +	/* Retain analog receiver power rails continuously */
> +	phy_write16(PHY_REG_CH0_ANALOG_PWR, (u16)ch0_rank);
> +	phy_write16(PHY_REG_CH1_ANALOG_PWR, (u16)ch1_rank);
> +
> +	/* Activate AC macro pad drivers & assert Master CKE */
> +	phy_write16(PHY_REG_AC_TX_EN_BCAST, 0x01ff);
> +	phy_write16(PHY_REG_MASTER_CFG,
> +		    phy_read16(PHY_REG_MASTER_CFG) | 0x0100);
> +
> +	/* Enable DBYTE broadcast strobe gating */
> +	pmu_dbyte_cal_strobe_pulse_seq(1, 2047, 0);
> +
> +	/* Save 6-byte AC PHY register 0x0001008b descriptor */
> +	memset(descriptor_backup, 0, sizeof(descriptor_backup));
> +	descriptor_backup[0] = 0x8bU;
> +	descriptor_backup[2] = 0x01U;
> +	pmu_phy_reg_buffer_stream(descriptor_backup, 1, 1);
> +
> +	/* One-hot power-of-2 step stride normalization */
> +	raw_step = dmem_read8(PMU_DMEM_STEP_CFG_RAW) >> 4;
> +	if (raw_step & 8U)
> +		step = 8U;
> +	else if (raw_step & 4U)
> +		step = 4U;
> +	else if (raw_step & 2U)
> +		step = 2U;
> +	else
> +		step = 1U;
> +	dmem_write8(PMU_DMEM_NORM_STEP_STRIDE, step);
> +
> +	memset(scan_matrix, 0, PMU_RX_SCAN_MATRIX_BYTES);
> +	pmu_cal_struct_mask_remap();

The step stride and the base delay come from the high byte of the step
configuration (0x8000001b); both bytes happen to be zero with the
message block the driver builds, so this is not visible on the board.
The writes to the analogue power, pad driver and CKE registers here and
at the end of the function, and the early return, are not in the boot0
firmware.

Suggested change for all of the above (the three constants belong into
dwc_ddrphy_pmu_regs.h of patch 14). The firmware binary it produces is
the one I tested:

diff --git a/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h b/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
index 119fbc9c644..f2a57e712b4 100644
--- a/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
+++ b/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
@@ -72,6 +72,7 @@
 #define PMU_DMEM_ANALOG_CFG		0x80000015UL /* Byte: Analog cfg flag */
 #define PMU_DMEM_RX_CLK_EN		0x80000019UL /* Byte: Receiver clock enable flag */
 #define PMU_DMEM_CAL_STEP_CONFIG	0x8000001aUL /* Half: Calibration step configuration */
+#define PMU_DMEM_CAL_STEP_CONFIG_HI	0x8000001bUL /* Byte: Step configuration, high byte */
 #define PMU_DMEM_DESKEW_LIM		0x8000001cUL /* Byte: Dual-rank deskew cfg */
 #define PMU_DMEM_CH0_DQ_WIDTH		0x80000024UL /* Byte: Total DQ bit width Ch0 */
 #define PMU_DMEM_CH0_ANALOG_EN		0x80000025UL /* Byte: Ch0 analog power enable */
@@ -133,6 +134,7 @@
 #define PMU_DMEM_SLICE_CNT_LIMIT	0x80000b20UL /* Base: Slice cnt limit array */
 #define PMU_DMEM_SLICE_IMP_CFG		0x80000b24UL /* Base: Sec rank slice map */
 #define PMU_DMEM_TIMING_LIM		0x80000b64UL /* Byte: Gate timing limit */
+#define PMU_DMEM_ACTIVE_SLICE		0x80000b66UL /* Byte: Active AC slice index */
 #define PMU_DMEM_ACTIVE_RANK		0x80000b67UL /* Byte: Active rank / byte index */
 #define PMU_DMEM_CH_RANGE		0x80000b68UL /* Base: Active ch [min, max] */
 #define PMU_DMEM_CH_ACTIVE_RANGE	0x80000b6aUL /* Base: Primary ch [min, max] */
@@ -446,6 +448,7 @@
 #define PMU_ERR_DESKEW_SAMPLE_CHECK	0x01160000UL
 #define PMU_ERR_RX_FIFO_SCAN_OVERFLOW	0x011c0000UL
 #define PMU_ERR_LPCA_CLK_GATE_PRECOND	0x01280000UL
+#define PMU_ERR_LPCA_NO_CA_WINDOW	0x01390000UL
 #define PMU_ERR_AC_STEP_COORD_ADJUST	0x019f0003UL
 #define PMU_ERR_BIST_PATTERN_IDX_INVALID	0x01a40001UL
 #define PMU_ERR_BIST_VALIDATION_MODE	0x01a50000UL
diff --git a/arch/arm/mach-sunxi/pmu/pmu_train.c b/arch/arm/mach-sunxi/pmu/pmu_train.c
index c0b5e1d7dd1..8bf9da42c48 100644
--- a/arch/arm/mach-sunxi/pmu/pmu_train.c
+++ b/arch/arm/mach-sunxi/pmu/pmu_train.c
@@ -2370,160 +2370,60 @@ static void pmu_rx_en_build_swizzle_map(u8 *swizzle_map, u8 ch1_rank)
 	}
 }
 
-/**
- * pmu_rx_en_poll_rx_fifo_ranks() - Execute dual-scan multi-rank RX FIFO polling
- * @ch0_rank: Active rank mask for Channel 0
- * @ch1_rank: Active rank mask for Channel 1
- * @initial_step: Output 4-element signed initial delay step array
- * @scan_matrix: Output 3584-byte eye scan matrix
- *
- * Return: Updated active slice count (1 or 2).
- */
-static u32 pmu_rx_en_poll_rx_fifo_ranks(u8 ch0_rank, u8 ch1_rank,
-					s8 *initial_step, u8 *scan_matrix)
-{
-	u32 num_slices = (ch1_rank != 0) ? 2 : 1;
-	u32 idx;
-
-	for (idx = 0; idx < 4; idx++) {
-		u16 out_cfg;
-		u8 out_mode_sel;
-		u8 out_num_slices;
-		u32 csr_offset;
-		u32 reg_base;
-		u8 channel;
-		u8 rank;
-		s8 ret;
-
-		if (pmu_cal_channel_rank_config_get(idx, &out_cfg,
-						    &out_mode_sel,
-						    &out_num_slices) != 0)
-			continue;
-
-		num_slices = (u32)out_num_slices;
-		dmem_write8(PMU_DMEM_AC_CAL_ACTIVE, 1);
-		pmu_phy_mode_cfg_dispatch(num_slices);
-
-		/* Re-assert both analog receiver power rails */
-		phy_write16(PHY_REG_CH0_ANALOG_PWR, (u16)ch0_rank);
-		phy_write16(PHY_REG_CH1_ANALOG_PWR, (u16)ch1_rank);
-
-		channel = out_num_slices - 1U;
-		rank = dmem_read8(PMU_DMEM_ACTIVE_RANK);
-		csr_offset = dmem_read32(PMU_DMEM_ACTIVE_CH_OFFSET);
-		reg_base = (((u32)channel << 12) | csr_offset) << 1;
-
-		phy_write16(PHY_AC_GATE_CTRL_RESET | reg_base, 0);
-		phy_write16(PHY_AC_BASE_OFFSET_CTRL | reg_base, 0);
-
-		/* Primary Scan: enable_scan = 1 */
-		ret = pmu_cal_dbyte_rx_fifo_reset_poll(channel,
-						       (u32)out_mode_sel, 1,
-						       scan_matrix);
-		initial_step[((u32)rank << 1) + (u32)out_cfg] = ret;
-
-		/* Baseline Scan: enable_scan = 0, first arg is out_mode_sel */
-		(void)pmu_cal_dbyte_rx_fifo_reset_poll(channel,
-						       (u32)out_mode_sel, 0,
-						       scan_matrix);
-	}
-
-	return num_slices;
-}
+#define PMU_RX_SCAN_MATRIX_BYTES	3584U
 
 /**
- * pmu_rx_en_search_and_commit_slice() - Find 256-tap eye centers and commit AC slice delays
- * @s: Slice index (0 or 1)
+ * pmu_cal_ca_window_search() - Find the centre of the widest passing CA window
+ * @lane_scan: 256-entry scan row of one CA lane, zero marks a passing delay
  * @step: Normalized step stride (1, 2, 4, or 8)
- * @swizzle_map: 14-byte pin-to-lane swizzle lookup table
- * @initial_step: 4-element signed initial delay step array
- * @scan_matrix: 3584-byte eye scan matrix
+ * @base: Base delay offset of the AC slice
+ * @center: Output centre delay of the selected window
+ * @no_window: Set to 1 if the lane has no passing delay
  */
-static void pmu_rx_en_search_and_commit_slice(u32 s, u8 step,
-					      const u8 *swizzle_map,
-					      const s8 *initial_step,
-					      const u8 *scan_matrix)
+static void pmu_cal_ca_window_search(const u8 *lane_scan, u32 step, s32 base,
+				     u16 *center, u32 *no_window)
 {
-	u16 center_delay[7];
-	s32 base_delay = (dmem_read8(PMU_DMEM_CAL_STEP_CONFIG) &
-			  BIT(3)) ? 0 : 0x40;
-	s32 lower_bound = base_delay - 128;
-	s32 upper_bound = base_delay + 128;
-	u32 csr_offset;
-	u32 s_base;
-	s32 dly0, dly1;
-	u32 ca;
-
-	for (ca = 0; ca < 7; ca++) {
-		u32 best_start = 0;
-		u32 best_len = 0;
-		u32 run_start = 0;
-		u32 cur_len = 0;
-		u32 in_run = 0;
-		u32 delay;
-
-		for (delay = 0; delay < 256; delay += step) {
-			u32 mat_idx = s * 1792 + ca * 256 + delay;
-
-			if (scan_matrix[mat_idx] == 0) {
-				if (!in_run) {
-					run_start = delay;
-					cur_len = 0;
-					in_run = 1;
-				}
-				cur_len += step;
-			} else if (in_run) {
-				if (cur_len > best_len && delay >= 129) {
-					best_start = run_start;
-					best_len = cur_len + step;
-				}
-				in_run = 0;
-				cur_len = 0;
+	u16 best_start = 0U;
+	u16 best_len = 0U;
+	u16 cur_len = 0U;
+	u16 run_start = 0xffU;
+	u32 delay;
+	s32 pos;
+
+	for (delay = 0U; delay <= 0xffU; delay += step) {
+		if (run_start == 0xffU) {
+			if (lane_scan[delay] == 0U) {
+				run_start = (u16)delay;
+				cur_len = 0U;
 			}
-		}
-
-		if (in_run &&
-		    (cur_len > best_len || (best_len == 0 && cur_len != 0))) {
-			best_start = run_start;
-			best_len = cur_len + step;
-		}
-
-		if (best_len == 0) {
-			/* Nominal midpoint fallback (0x40) */
-			center_delay[ca] = 0x40;
+		} else if (lane_scan[delay] == 0U) {
+			cur_len += (u16)step;
 		} else {
-			s32 center = (s32)best_start +
-				     (s32)((best_len & ~1U) / 2) +
-				     lower_bound;
-
-			if (center < 0)
-				center = 0;
-			if (center > upper_bound)
-				center = upper_bound;
-			center_delay[ca] = (u16)center;
+			if (best_len < cur_len && delay >= 0x81U) {
+				best_len = (u16)(cur_len + step);
+				best_start = run_start;
+			}
+			run_start = 0xffU;
 		}
 	}
 
-	/* Commit Calibrated Delays to Physical AC Slice */
-	csr_offset = dmem_read32(PMU_DMEM_ACTIVE_CH_OFFSET);
-	for (ca = 0; ca < 7; ca++) {
-		u8 mapped_lane = swizzle_map[s * 7 + ca];
-		u32 addr = PHY_AC_PIN_DELAY_BASE |
-			   ((csr_offset | (s << 12) |
-			     ((u32)mapped_lane << 8)) << 1);
+	if (best_len == 0U && cur_len != 0U) {
+		best_len = (u16)(cur_len + step);
+		best_start = run_start;
+	}
 
-		phy_write16(addr, center_delay[ca]);
+	if (best_len == 0U) {
+		*no_window = 1U;
+		return;
 	}
 
-	csr_offset = dmem_read32(PMU_DMEM_ACTIVE_CH_OFFSET);
-	s_base = (csr_offset | (s << 12)) << 1;
-	dly0 = base_delay + (s32)initial_step[s * 2 + 0];
-	dly1 = base_delay + (s32)initial_step[s * 2 + 1];
-	phy_write16(PHY_AC_MASTER_DESKEW0 | s_base,
-		    (dly0 < 0) ? 0 : (u16)dly0);
-	phy_write16(PHY_AC_MASTER_DESKEW1 | s_base,
-		    (dly1 < 0) ? 0 : (u16)dly1);
-	phy_write16(PHY_AC_BASE_OFFSET_CTRL | s_base, (u16)base_delay);
+	pos = (s16)(((best_len & 0xfffeU) >> 1) + (u32)(base + 0xff80) +
+		    best_start);
+	if (pos < 0)
+		pos = 0;
+	else if (pos > base + 0x80)
+		pos = base + 0x80;
+	*center = (u16)pos;
 }
 
 /**
@@ -2532,83 +2432,60 @@ static void pmu_rx_en_search_and_commit_slice(u32 s, u8 step,
  * Orchestrates initial Command-Address (CA) timing calibration across active
  * DRAM channels, ranks, and Address/Command (AC) slices:
  *
- * 1. Checks active channel rank flags (`0x80000025` and `0x80000040`), verifies
- *    the pre-condition clock gating flag (`0x80000001`), powers both Channel 0
- *    and Channel 1 analog receiver rails (`0x900400e4` and `0x900400e6`),
- *    enables AC macro pad drivers (`0x900e00ca = 0x01ff`), asserts Master CKE
- *    (`0x9004000e |= 0x0100`), and enables DBYTE broadcast calibration strobe
- *    gating.
- * 2. Backs up the 6-byte AC PHY descriptor block from DCCM `0x8000099c`,
- *    enforcing the Cold-Boot Zero-Token APB Bus Guard (`0x0001008bUL` fallback
- *    when `token == 0`), and streams it to PHY registers.
- * 3. Normalizes the 4-bit calibration step configuration (`0x8000041a`) into a
- *    one-hot power-of-2 stride (`1`, `2`, `4`, or `8`) at `0x8000047c` and
- *    zero-initializes the 3,584-byte raw eye scan matrix.
- * 4. Remaps calibration structure masks and reads hardware AC pin swizzle
- *    registers (`0x90060120` and conditionally `0x90062120`, with strict `< 7`
- *    pin bounds on both slices) into `swizzle_map[14]`.
- * 5. Iterates across ranks `0..3` using a 16-bit halfword `out_cfg` output
- *    pointer, re-asserts analog receiver power rails after
- *    `pmu_phy_mode_cfg_dispatch`, resets AC slice timing registers, and
- *    executes dual-phase 3-argument RX FIFO reset polling to populate
- *    `initial_step[4]` and `scan_matrix[3584]`.
+ * 1. Enables DBYTE broadcast calibration strobe gating, clears the scan
+ *    matrix and verifies the pre-condition clock gating flag (`0x80000001`).
+ * 2. Normalizes the 4-bit calibration step configuration (`0x8000001b`) into a
+ *    one-hot power-of-2 stride (`1`, `2`, `4`, or `8`) at `0x8000047c`.
+ * 3. Backs up the 6-byte AC PHY descriptor block and streams it to PHY
+ *    registers.
+ * 4. Reads hardware AC pin swizzle registers (`0x90060120` and conditionally
+ *    `0x90062120`, with strict `< 7` pin bounds on both slices) into
+ *    `swizzle_map[14]` and remaps calibration structure masks.
+ * 5. Iterates across ranks `0..3`, resets the timing registers of the AC
+ *    slice selected by `pmu_cal_channel_rank_config_get()`, and executes
+ *    dual-phase RX FIFO reset polling to populate `initial_step[4]` and
+ *    `scan_matrix[3584]`.
  * 6. Clears AC profile lane registers (`0x9007e002` with `ca << 8` stride) and
  *    master register (`0x9007e004`), then pulses the primary calibration strobe.
- * 7. Executes a 256-tap contiguous zero-run eye window search (`delay >= 129`
- *    threshold, nominal midpoint fallback `0x40`) and
- *    programs per-lane AC delays and master deskew registers.
- * 8. Pulses primary and secondary calibration strobes, restores the 6-byte AC
- *    PHY descriptor backup, disables DBYTE broadcast strobe gating, and
- *    re-asserts Master CKE (`0x9004000e |= 0x0100`).
+ * 7. Searches each CA lane for its widest passing window and programs
+ *    per-lane AC delays and master deskew registers.
+ * 8. Asserts that every lane had a window, pulses primary and secondary
+ *    calibration strobes, restores the 6-byte AC PHY descriptor backup, and
+ *    disables DBYTE broadcast strobe gating.
  */
-#define PMU_RX_SCAN_MATRIX_BYTES	3584U
-
 static void pmu_cal_rx_en_pre_init(void)
 {
 	u8 *scan_matrix = (u8 *)dmem_ptr(PMU_DMEM_RX_SCAN_MATRIX);
-	u8 swizzle_map[14] = { 0 };
-	s8 initial_step[4] = { 0 };
 	u8 descriptor_backup[6];
-	u8 ch0_rank;
-	u8 ch1_rank;
+	u16 center_delay[7];
+	u8 swizzle_map[14];
+	s8 initial_step[4];
+	u8 out_num_slices = 0U;
+	u8 out_mode_sel = 0U;
+	u32 no_window = 0U;
+	u16 out_cfg = 0U;
+	u32 csr_offset;
+	u32 reg_base;
 	u8 raw_step;
-	u32 num_slices;
-	u32 ch_offset;
+	u32 slice;
+	s32 base;
+	s32 dly;
 	u8 step;
+	u32 idx;
 	u32 ca;
 	u32 s;
+	s8 ret;
 
-	ch0_rank = dmem_read8(PMU_DMEM_CH0_ANALOG_EN);
-	ch1_rank = dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG);
-	if (ch0_rank == 0 && ch1_rank == 0)
-		return;
-
-	/* Pre-condition clock gate check */
-	if ((dmem_read8(PMU_DMEM_CLK_GATE_FLAG) & BIT(3)) != 0) {
-		pmu_assert_or_halt(0, PMU_ERR_LPCA_CLK_GATE_PRECOND);
-		return;
-	}
-
-	/* Retain analog receiver power rails continuously */
-	phy_write16(PHY_REG_CH0_ANALOG_PWR, (u16)ch0_rank);
-	phy_write16(PHY_REG_CH1_ANALOG_PWR, (u16)ch1_rank);
-
-	/* Activate AC macro pad drivers & assert Master CKE */
-	phy_write16(PHY_REG_AC_TX_EN_BCAST, 0x01ff);
-	phy_write16(PHY_REG_MASTER_CFG,
-		    phy_read16(PHY_REG_MASTER_CFG) | 0x0100);
-
-	/* Enable DBYTE broadcast strobe gating */
 	pmu_dbyte_cal_strobe_pulse_seq(1, 2047, 0);
+	memset(scan_matrix, 0, PMU_RX_SCAN_MATRIX_BYTES);
+	memset(swizzle_map, 0, sizeof(swizzle_map));
+	memset(initial_step, 0, sizeof(initial_step));
+	memset(center_delay, 0, sizeof(center_delay));
 
-	/* Save 6-byte AC PHY register 0x0001008b descriptor */
-	memset(descriptor_backup, 0, sizeof(descriptor_backup));
-	descriptor_backup[0] = 0x8bU;
-	descriptor_backup[2] = 0x01U;
-	pmu_phy_reg_buffer_stream(descriptor_backup, 1, 1);
+	pmu_assert_or_halt(!(dmem_read8(PMU_DMEM_CLK_GATE_FLAG) & BIT(3)),
+			   PMU_ERR_LPCA_CLK_GATE_PRECOND);
 
-	/* One-hot power-of-2 step stride normalization */
-	raw_step = dmem_read8(PMU_DMEM_STEP_CFG_RAW) >> 4;
+	raw_step = dmem_read8(PMU_DMEM_CAL_STEP_CONFIG_HI) >> 4;
 	if (raw_step & 8U)
 		step = 8U;
 	else if (raw_step & 4U)
@@ -2619,39 +2496,74 @@ static void pmu_cal_rx_en_pre_init(void)
 		step = 1U;
 	dmem_write8(PMU_DMEM_NORM_STEP_STRIDE, step);
 
-	memset(scan_matrix, 0, PMU_RX_SCAN_MATRIX_BYTES);
+	memset(descriptor_backup, 0, sizeof(descriptor_backup));
+	descriptor_backup[0] = 0x8bU;
+	descriptor_backup[2] = 0x01U;
+	pmu_phy_reg_buffer_stream(descriptor_backup, 1, 1);
+
+	pmu_rx_en_build_swizzle_map(swizzle_map,
+				    dmem_read8(PMU_DMEM_CH1_ACTIVE_FLAG));
 	pmu_cal_struct_mask_remap();
 
-	/* Phase 2-3: Build swizzle map and run dual-scan RX FIFO polling */
-	pmu_rx_en_build_swizzle_map(swizzle_map, ch1_rank);
-	num_slices = pmu_rx_en_poll_rx_fifo_ranks(ch0_rank, ch1_rank,
-						  initial_step, scan_matrix);
+	for (idx = 0; idx < 4; idx++) {
+		if (pmu_cal_channel_rank_config_get(idx, &out_cfg,
+						    &out_mode_sel,
+						    &out_num_slices) != 0)
+			continue;
+
+		dmem_write8(PMU_DMEM_AC_CAL_ACTIVE, 1);
+		pmu_phy_mode_cfg_dispatch(out_num_slices);
 
-	/* Phase 4: Clear AC Profile Registers with ca << 8 stride */
-	ch_offset = dmem_read32(PMU_DMEM_ACTIVE_CH_OFFSET);
-	for (ca = 0; ca < 7; ca++) {
-		u32 addr = PHY_AC_PROFILE_LANE_BASE |
-			   ((ch_offset | (ca << 8)) << 1);
+		slice = dmem_read8(PMU_DMEM_ACTIVE_SLICE);
+		reg_base = ((slice << 12) | pmu_sdata()->active_csr_offset) << 1;
+		phy_write16(PHY_AC_GATE_CTRL_RESET | reg_base, 0);
+		phy_write16(PHY_AC_BASE_OFFSET_CTRL | reg_base, 0);
 
-		phy_write16(addr, 0);
+		ret = (s8)pmu_cal_dbyte_rx_fifo_reset_poll(slice, out_mode_sel,
+							   1, scan_matrix);
+		initial_step[out_cfg + 2U * dmem_read8(PMU_DMEM_ACTIVE_SLICE)] = ret;
+		(void)pmu_cal_dbyte_rx_fifo_reset_poll(dmem_read8(PMU_DMEM_ACTIVE_SLICE),
+						       out_mode_sel, 0,
+						       scan_matrix);
 	}
-	phy_write16(PHY_AC_PROFILE_MASTER_CTRL | (ch_offset << 1), 0);
+
+	csr_offset = pmu_sdata()->active_csr_offset;
+	for (ca = 0; ca < 7; ca++)
+		phy_write16(PHY_AC_PROFILE_LANE_BASE |
+			    ((csr_offset | (ca << 8)) << 1), 0);
+	phy_write16(PHY_AC_PROFILE_MASTER_CTRL | (csr_offset << 1), 0);
 	pmu_phy_cal_trig_pulse();
 
-	/* Phase 5: 256-Tap Eye Margin Search with delay >= 129 Bias */
-	for (s = 0; s < num_slices; s++)
-		pmu_rx_en_search_and_commit_slice(s, step, swizzle_map,
-						  initial_step, scan_matrix);
+	for (s = 0; s < out_num_slices; s++) {
+		base = (dmem_read8(PMU_DMEM_CAL_STEP_CONFIG_HI) & BIT(3)) ? 0 : 0x40;
+
+		for (ca = 0; ca < 7; ca++)
+			pmu_cal_ca_window_search(scan_matrix + s * 1792U +
+						 ca * 256U, step, base,
+						 &center_delay[ca], &no_window);
+
+		csr_offset = pmu_sdata()->active_csr_offset;
+		for (ca = 0; ca < 7; ca++)
+			phy_write16(PHY_AC_PIN_DELAY_BASE |
+				    ((csr_offset | (s << 12) |
+				      ((u32)swizzle_map[s * 7U + ca] << 8)) << 1),
+				    center_delay[ca]);
+
+		reg_base = (pmu_sdata()->active_csr_offset | (s << 12)) << 1;
+		dly = base + (s32)initial_step[s * 2U];
+		phy_write16(PHY_AC_MASTER_DESKEW0 | reg_base,
+			    (dly < 0) ? 0 : (u16)dly);
+		dly = base + (s32)initial_step[s * 2U + 1U];
+		phy_write16(PHY_AC_MASTER_DESKEW1 | reg_base,
+			    (dly < 0) ? 0 : (u16)dly);
+		phy_write16(PHY_AC_BASE_OFFSET_CTRL | reg_base, (u16)base);
+	}
 
-	/* Phase 6: Epilogue, Strobes, Descriptor Restore & Master CKE Re-Assertion */
+	pmu_assert_or_halt(no_window == 0U, PMU_ERR_LPCA_NO_CA_WINDOW);
 	pmu_phy_cal_trig_pulse();
 	pmu_phy_sec_cal_strobe_pulse();
 	pmu_phy_reg_buffer_stream(descriptor_backup, 1, 0);
 	pmu_dbyte_cal_strobe_pulse_seq(0, 0, 0);
-
-	/* Re-assert Master CKE */
-	phy_write16(PHY_REG_MASTER_CFG,
-		    phy_read16(PHY_REG_MASTER_CFG) | 0x0100);
 }
 
 /**

With this on top of the CBT fix the CA delays of both channels are
within one step of what boot0 leaves in the PHY. Note that a
single-rank board probed with the dual-rank mask now fails that attempt
at CBT, as with boot0, and relies on the single-rank fallback in
dram_sun60i_a733.c; I could not test that path on hardware.


Cheers


Daniel
