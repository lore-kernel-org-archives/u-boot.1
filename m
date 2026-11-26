Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=etNIhMyT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB7BC81189;
	Thu, 26 Nov 2026 19:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZeslpTQ9Ker6; Thu, 26 Nov 2026 19:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01E3281113
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795720007;
	b=OvNSZnHMdxzCVipykMvyMEzrdhCksYHwt2ZlaAaXfhuN5nh/l5dhbarsfn+pmCAuf2JJ
	 qRQvUT/ml+JXWzM+CUENrVgXrc0dctr+HWZVv/AC1lGgnBU6Y/N9e0DpSH8FfVnCi8EtZ
	 6rFfxaGLo7hCZobpGGKc5qId9Pd3ZRmnr+oOun4bJhPOcCqR/ySAXes9bYu1SAe1jt9zj
	 h/UYRv/XZOqakK1322T50clVEps9wUpxj8nsQxB3grP9KwS0nXss7LxMz3d960FNavVCi
	 2gRFuFBTHNuxsw7SviJTA0pj0/nv3N6hq+FJ3T0dXWa4pcl5yrstIhcifDfm24u2iTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795720007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8qiK8yaomU9p05pX+uhB5tQJGbysCz/Tv4JtnY1r4+M=;
	b=YSMmu8VWG6HU/OCbBl/eUmCg2eFwpU79FGMYBEfXqoPqBaMz9SZjrgeCKZ7D0pUI+pTN
	 jYi1XW63U6WZsqIZ4B5l57nv0robn0WHbqbhh7IQuPoz3idIF9T8bT7K7pXEgF4jmUO1p
	 RfE1WqpqpivXzFQRe+fGTt1rB3kSPicBDUQ2ysH1GS7Y6wZDL6eSBGYPN4YbgyPkcfDt8
	 2u6cFdVABxXLD2PR1xD3nmXFSMXk47UJCh8bgByKudxWNmg0mJsStx6LzcDSlWHbP8CtY
	 UHhZJg+QMasgScDdbkIz8enzXR17YCMxFYGjEK+eJ4DJpXFd+DPvq3BG2SM5X3meQXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795720007;
	bh=8qiK8yaomU9p05pX+uhB5tQJGbysCz/Tv4JtnY1r4+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=etNIhMyThZT2QlIhghyIQO0zeSuwLj5bCqcmMwHE7iQk08bYGqFsHKO1cHA+X4qdA
	 wmv1M5rq1gdPD32LWo9ZIAWXNpQcVuDd2zqxWI6MBR/f7qb1y33polxhQm9ROnEBdy
	 jl5eRNbEJU9YmDCq1jtif0byXJ3ecai8aTD3bn4KL5KkIC0+/SZqfJvQ+0VZT2Lbkb
	 3h3hBTHO0i4lpTepyjzm42Hki1bkxwi+DkwTaRN+TLUVJ3vIZZB1gErHcKW+R8PrrE
	 E3vqVG3j17rroBMqvgy50TdHgH9EaS5cPtrtXWmEV80fTYeB2FDbWK2PWEieb22/lp
	 5X8VqlOnZBRvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01E3281113;
	Thu, 26 Nov 2026 19:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CDDC2BD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6267D81113
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id penGqyry3yJD for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 19:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBE1B81111
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBE1B81111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:06:43 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xWeni-000000007rB-3kYv;
 Thu, 26 Nov 2026 19:06:34 +0000
Date: Thu, 26 Nov 2026 19:06:25 +0000
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
Subject: Re: [PATCH 15/26] sunxi: dram: a733: Add ARC PMU primitives, clock,
 telemetry, and CBT
Message-ID: <awiDMTcFCalJb_Q3@makrotopia.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-16-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113023236.569054-16-alastair@d-silva.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alastair,

I have been running this series on an Orange Pi 4 Pro with 4 GiB LPDDR5
(dual rank, two channels, pin swizzle enabled, 3600 MT/s). On that
board dual-rank training passes in about one attempt out of three (16
of 48 trainings in a loop in SPL); the others end in status 0xff and
the driver falls back or fails. The vendor boot0 trains the same board
reliably each time. The cause is in this patch, with two more problems
in patches 17 and 18 which I will comment on there.

On Fri, 13 Nov 2026 13:32:25 +1100, Alastair D'Silva wrote:
> [...]
> +void pmu_cbt_timing_pulse_coordinator(u16 cal_mode, u32 phase_sel)
> +{
> +	u32 zero = 0U;
> +	__volatile__ u16 *out_tbl =
> +		(__volatile__ u16 *)PMU_DMEM_DELAY_TAP_LUT;
> +	__volatile__ u16 *out_sub1 =
> +		(__volatile__ u16 *)PMU_DMEM_DELAY_TAP_SUB1;
> +	u32 mask_word;
> +	u32 phase;
> +
> +	out_tbl[0] = 100U;
> +
> +	for (phase = 0U; phase < 4U; phase++) {
> +		u32 pulse_mask;
> +		u16 step;
> +		u16 marker;
> +
> +		if (phase_sel == 0U) {
> +			if (phase == 0U)
> +				pulse_mask = 0x7f00U;
> +			else if (phase == 1U)
> +				pulse_mask = 0x7f0000U;
> +			else if (phase == 2U)
> +				pulse_mask = 0x7f007f7fUL;
> +			else
> +				pulse_mask = 0x7f7f007fUL;
> +		} else {
> +			if (phase == 0U)
> +				pulse_mask = 0x7fU;
> +			else if (phase == 1U)
> +				pulse_mask = 0x7f000000UL;
> +			else if (phase == 2U)
> +				pulse_mask = 0x7f007f7fUL;
> +			else
> +				pulse_mask = 0x007f7f7fUL;
> +		}
> +
> +		mask_word = pulse_mask;
> +		step = out_tbl[phase];
> +		pmu_cal_marker_pair_set((u16)(step << 2));
> +
> +		pmu_cal_sequence_pulse_send(0x41UL << 19, 7U, 8U, 0U,
> +					    zero, zero, zero);
> +		pmu_cal_pad_timing_delay_set(0U, 4U, 1U);
> +
> +		pmu_cal_window_params_dispatch((const u8 *)&mask_word, 2U, cal_mode);

The capture masks do not match what the PHY firmware in the vendor
boot0 sends for the two phase selectors, and the last two arguments of
pmu_cal_window_params_dispatch() are swapped: its prototype is
(params_buf, base_val, mode_flags), so cal_mode has to be the base
value and 2 the mode. With the masks as above CBT finds no CA window on
my board and the CA delays stay at their reset value 0x40.

With the change below dual-rank training passes in 48 of 48 attempts,
on the first try each time, and the CA delays of channel 0 end up
within one step of the values boot0 leaves in the PHY:

diff --git a/arch/arm/mach-sunxi/pmu/pmu_cbt.c b/arch/arm/mach-sunxi/pmu/pmu_cbt.c
index 6c97ad8532e..fe2d59f2d96 100644
--- a/arch/arm/mach-sunxi/pmu/pmu_cbt.c
+++ b/arch/arm/mach-sunxi/pmu/pmu_cbt.c
@@ -244,18 +244,18 @@ void pmu_cbt_timing_pulse_coordinator(u16 cal_mode, u32 phase_sel)
 		u16 step;
 		u16 marker;
 
-		if (phase_sel == 0U) {
+		if (phase_sel != 0U) {
 			if (phase == 0U)
 				pulse_mask = 0x7f00U;
 			else if (phase == 1U)
 				pulse_mask = 0x7f0000U;
 			else if (phase == 2U)
-				pulse_mask = 0x7f007f7fUL;
-			else
 				pulse_mask = 0x7f7f007fUL;
+			else
+				pulse_mask = 0x7f007f7fUL;
 		} else {
 			if (phase == 0U)
-				pulse_mask = 0x7fU;
+				pulse_mask = 0x7f0000U;
 			else if (phase == 1U)
 				pulse_mask = 0x7f000000UL;
 			else if (phase == 2U)
@@ -272,7 +272,7 @@ void pmu_cbt_timing_pulse_coordinator(u16 cal_mode, u32 phase_sel)
 					    zero, zero, zero);
 		pmu_cal_pad_timing_delay_set(0U, 4U, 1U);
 
-		pmu_cal_window_params_dispatch((const u8 *)&mask_word, 2U, cal_mode);
+		pmu_cal_window_params_dispatch((const u8 *)&mask_word, cal_mode, 2U);
 
 		pmu_cal_pad_timing_delay_set(0U, 20U, 1U);
 		pmu_cal_sequence_pulse_send(1UL << 18, 7U, 4U, 0U,

> [...]
> +
> +	*out_num_slices = (u8)(is_ch1 + 1U);
> +	return 0U;

pmu_cal_rx_en_pre_init() in patch 18 needs to know which AC slice this
call selected. Please also record it here, at the DMEM byte the CA
sampler pmu_dbyte_deskew_phase_sample() reads (0x80000b66, see my reply
to patch 18 for the name and the rest of that change):

diff --git a/arch/arm/mach-sunxi/pmu/pmu_telemetry.c b/arch/arm/mach-sunxi/pmu/pmu_telemetry.c
index ea47e991fcf..0e004448fea 100644
--- a/arch/arm/mach-sunxi/pmu/pmu_telemetry.c
+++ b/arch/arm/mach-sunxi/pmu/pmu_telemetry.c
@@ -565,6 +565,7 @@ u32 pmu_cal_channel_rank_config_get(u32 rank, u16 *out_cfg, u8 *out_mode_sel,
 		return 1U;
 
 	*out_num_slices = (u8)(is_ch1 + 1U);
+	dmem_write8(PMU_DMEM_ACTIVE_SLICE, (u8)is_ch1);
 	return 0U;
 }
 

Tested on the Orange Pi 4 Pro only: 48 trainings per step of the three
changes, each 48 of 48, plus ten boots of the result; training then
takes 4.65 s from the SPL banner, boot0 needs 5.04 s. The three
functions were also compared call by call against the boot0 firmware in
an emulator for other inputs (single rank, single channel, swizzle off,
other step sizes and data rates), where they behave the same; nothing
but the 4 GiB board has run on hardware.

For transparency: an LLM coding assistant was used for the emulator
comparison and for drafting these changes; the numbers above were
measured on the board.


Cheers


Daniel
