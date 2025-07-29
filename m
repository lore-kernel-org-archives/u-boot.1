Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AEBC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 06:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE8382B0F;
	Tue, 29 Jul 2025 08:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VAFMD0Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C5E82BCD; Tue, 29 Jul 2025 08:41:55 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F4C82ADA
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4brm3K57yNz9v6F;
 Tue, 29 Jul 2025 08:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753771309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jh62BgGE/McVHnTthH60KnZOwNbs1AoHYc6tCcOF2rU=;
 b=VAFMD0Jf6dlowrMLE4jdARtJEkcJ5ZZbv16oDTpKSg5A8fUEBoxChUW00o+Vc3ZREQcQ/A
 /aGpcDYBLRrBR9MvUrvTyBT3YWKowh0i193G4U5fSsYPFF2UkZc2fDQeE7DbPT1rpm4mLH
 aBQ6NXtmByjpTkwEspkDiwMWy9qfx6xlhA+fPRARmPwsL8sr/17Zoi3AYrATl4tif8kbd5
 7i7dhoWG1Mf4JEeRpxb8506mJ+z2+f+y1ocsbXP4rIDZJ0DLYcWCQ1RM44hB2LSQWrO2kz
 RjvFlDjd7CbxNoQXFRCA3p2HSSQNBD27/f0ZgXO4UqGwCAqdVgKVlDP+2v5i6g==
Message-ID: <fc2eb511-430e-406a-a9fc-b47e6eb9812f@mailbox.org>
Date: Tue, 29 Jul 2025 08:41:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ddr: marvell: a38x: Fix unsigned issues
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6cpd5hzoubqpfxqm8h7t486ec3hh4fjk
X-MBO-RS-ID: fc584988f5617de00a2
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

On 28.07.25 16:26, Andrew Goodbody wrote:
> Cannot test an unsigned variable to be less than 0, it will always fail.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> index 31b6209416b..84156a1e8ad 100644
> --- a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> +++ b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> @@ -64,7 +64,7 @@ static u8 center_high_element_get(u8 dir, u8 pbs_element, u16 lambda, u8 pbs_max
>   static int mv_ddr4_centralization(u8 dev_num, u16 (*lambda)[MAX_BUS_NUM][BUS_WIDTH_IN_BITS], u8 (*copt)[MAX_BUS_NUM],
>   				  u8 (*pbs_result)[MAX_BUS_NUM][BUS_WIDTH_IN_BITS], u8 (*vw_size)[MAX_BUS_NUM],
>   				  u8 mode, u16 param0, u8 param1);
> -static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, char delta, u8 *copt, u8 *dqs_pbs);
> +static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs);
>   static int mv_ddr4_copt_get(u8 dir, u16 *lambda, u8 *vw_l, u8 *vw_h, u8 *pbs_result, u8 *copt);
>   static int mv_ddr4_center_of_mass_calc(u8 dev_num, u8 if_id, u8 subphy_num, u8 mode, u8 *vw_l, u8 *vw_h, u8 *vw_v,
>   				       u8 vw_num, u8 *v_opt, u8 *t_opt);
> @@ -659,7 +659,7 @@ static int mv_ddr4_centralization(u8 dev_num, u16 (*lambda)[MAX_BUS_NUM][BUS_WID
>   	} /* if_id */
>   
>   	/* restore cs enable value*/
> -	for (if_id = 0; if_id < MAX_INTERFACE_NUM - 1; if_id++) {
> +	for (if_id = 0; if_id < MAX_INTERFACE_NUM; if_id++) {
>   		VALIDATE_IF_ACTIVE(tm->if_act_mask, if_id);
>   		status = ddr3_tip_if_write(dev_num, ACCESS_TYPE_UNICAST, if_id, DUAL_DUNIT_CFG_REG,
>   					   cs_ena_reg_val[if_id], MASK_ALL_BITS);
> @@ -895,7 +895,7 @@ static int mv_ddr4_copt_get(u8 dir, u16 *lambda, u8 *vw_l, u8 *vw_h, u8 *pbs_res
>    * It provides with a solution for a single subphy (8 bits).
>    * The calling function is responsible for any additional pbs taps for dqs
>    */
> -static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, char delta, u8 *copt, u8 *dqs_pbs)
> +static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs)
>   {
>   	u8 dq_idx;
>   	u32 pbs_max_val = 0;
> @@ -952,7 +952,8 @@ static int mv_ddr4_center_of_mass_calc(u8 dev_num, u8 if_id, u8 subphy_num, u8 m
>   	int t_opt_temp = 0, v_opt_temp = 0;
>   	int vw_avg = 0, v_avg = 0;
>   	int s0 = 0, s1 = 0, s2 = 0, slope = 1, r_sq = 0;
> -	u32 d_min = 10000, reg_val = 0;
> +	u32 reg_val = 0;
> +	int d_min = 10000;
>   	int status;
>   
>   	/*
> @@ -2189,7 +2190,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16 (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
>   				for (dq = 0; dq < BUS_WIDTH_IN_BITS; dq++) {
>   					idx = dq + subphy * BUS_WIDTH_IN_BITS;
>   					reg_val = new_dq_pbs[dq] - dq_pbs_diff;
> -					if (reg_val < 0) {
> +					if (new_dq_pbs[dq] < dq_pbs_diff) {
>   						DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
>   								("unexpected negative value found\n"));
>   						return MV_FAIL;
> @@ -2267,7 +2268,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16 (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
>   						idx = dq + subphy * BUS_WIDTH_IN_BITS;
>   						pad = dq_map_table[idx];
>   						reg_val = new_dq_pbs[dq] - dq_pbs_diff;
> -						if (reg_val < 0) {
> +						if (new_dq_pbs[dq] < dq_pbs_diff) {
>   							DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
>   									("unexpected negative value found\n"));
>   							return MV_FAIL;
> 
> ---
> base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
> change-id: 20250728-a38x_ddr-64c67d8a63a2
> 
> Best regards,

