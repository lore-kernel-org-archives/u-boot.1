Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075E606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pWprTHQW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfOx67RZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAAAC40929;
	Thu, 26 Nov 2026 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E8dEOm3Zn1t; Thu, 26 Nov 2026 13:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CA2140939
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698127;
	b=oWqvGO8bkZhgljWS9sL9kG0YiOl7BDpkUKV2NXpH1dxbeE9ZpqfKlMEAN9Y8MX24BIbq
	 uhC7PW4OI8Y1S2DWDJ/lbn7aL0bONwI2rTFb7+Z0oXxCBvgah1lGSbqAQNeICwFk2FA2W
	 XvuHnPD1XkkSj10dn+ZtI5a6fQE6av3XsRgXnIThGTzuKDDb4y6KebmcoOc8SCIwR73E/
	 K0p86C2Givxe6U69j+PeYpRvDDHDN47ZLh9V4Pil6Y2+14cqHDMox3CQ5E4rSv/AGBV86
	 1thfZcB4KOWdZ1FCbbq7d9rPWcSt8CEKJlCp1Gf283X7GZMf4FyHXmQcEhYaZy8Z86w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sLc5dmYIU+uZHgwXkmnk95adlF9iNdcDJOPMTfyRJ08=;
	b=E5JMLrUzxiTNYAFVWQpFaQ9DQ2sZAmoinTLE5q10LKz5/35lt7/api77IC3g5+aCXFD5
	 Uf1mmwECO3N3YA/Iasr0QsyuujWkypZmKaSNrjUNcsTmi74NDn4VtBxwwdesz6XGhwAdO
	 /mGpYwtVOEGK9wLWSPN0IprmWhuG8Ezi6tQ3NaQw8vjEbRTrwlpTUtX6eUCNTCL9MhX1e
	 B/oEPmI86vsjqbd4aWpyPzbvoAtMFSI5RfOhwIqPAJBVJAbF6qxCbMvAP8eUBVeRW1ixn
	 kcLWmk2zF/Q/dlFh616y01u4dPv06/FEtANjiKX4fAL/d9kEMFTD3LB4JipDZ87hZGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698127;
	bh=sLc5dmYIU+uZHgwXkmnk95adlF9iNdcDJOPMTfyRJ08=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pWprTHQWOAajM8V+udD/yZ8ZwpwKqzcweWqyowT8ZRt0nzpwQU7lLaA4gfBchBcIH
	 YLIIPiWFVaNvAy027Vao1w8C5kjEPc6Q9b6rJ/wp6j+mSPid9RXyl2cq4qwbGk75GM
	 4HzHR7smZJmJ+IIEbqbkScdOpGemoZxq/qxbmxbVWnnY2kP9vkcVgzF2tMhDMUm55e
	 CAGo9nzjLHL4NC+1Z7xYWacf97zsqSvhZaQuBa07wsvzEehpuBBM3qnYeJuw4T493X
	 8sjoMHMW2+rzAwd05lj0e/6CZXFY5tHEXDiDOEuRbt4GfkBHxYEGeKMurYZtbItkPT
	 O+H6B54MrCPZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CA2140939;
	Thu, 26 Nov 2026 13:02:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB0832D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FE7460A67
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IDyfHKihFehT for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 415406066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dfOx67RZ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 415406066D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:02:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E50AA63341;
 Thu, 26 Nov 2026 13:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF12E1F000CF;
 Thu, 26 Nov 2026 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698121;
 bh=sLc5dmYIU+uZHgwXkmnk95adlF9iNdcDJOPMTfyRJ08=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=dfOx67RZMh6Qc43hZz3FOyjGWEUPGN8fnoZtrot37nzAQBTtbDuptfyK51LJ+OP15
 9cdo69f0b5nr5itiVxG5YKI7k0MQzFNi7yy/oIUwSp1CiBxhqEwXuDnPE4WWpX4CxI
 DE0O9pY5NqPgMJAZNmqy6rDrqUPA+OoO8zEu8hroZlOHuG80vrubXXGx2DKGOYi2Zk
 fkUtmARZC8KCQIKG6BMS8IfEAF89PSzf8DdhyGUD8GPBL0ZkRt4aqycZ3nD2npOPsE
 8so81M2Lkm57CKIgALdQqmAoZmszdCJCOkfKsWEVd4kDDmAGl2jz0Oj+S/Dx7sZfRN
 AkJWSkBXFa11g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: qcom: sa8775p: Add EMAC0 clock and GDSC support
From: Sumit Garg <sumit.garg@kernel.org>
To: Deepak G <deepak.g10@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Royyan Zahir <royzah@gmail.com>, Deepak G <gde@qti.qualcomm.com>
In-Reply-To: <20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com>
References: <20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:31:55 +0530
Message-Id: <179569811538.130558.3343627827086290631.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 17:33 +0530, Deepak G wrote:
> Add the EMAC0 AXI, slave AHB, PHY AUX and PTP gate clocks, the
> EMAC0 GDSC, and rate-setting for the PHY AUX and PTP clocks.

How these clocks are being exercised? Is there a corresponding driver
being enabled?

-Sumit

> 
> Taken from 08c51ceb12f7
> ("clk: qcom: add the GCC driver for sa8775p")
> 
> Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcom.h    |  1 +
>  drivers/clk/qcom/clock-sa8775p.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 32ecda3f5f1..ecbe3833bcf 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -20,6 +20,7 @@
>  #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
>  #define CFG_CLK_SRC_GPLL7 (3 << 8)
> +#define CFG_CLK_SRC_GPLL7_EMAC0 (2 << 8)
>  #define CFG_CLK_SRC_GPLL4 (5 << 8)
>  #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
>  #define CFG_CLK_SRC_MASK  (7 << 8)
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index fa341d05f69..fd495b73635 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -27,6 +27,9 @@
>  #define APCS_GPLL9_STATUS			0x9000
>  #define APCS_GPLLX_ENA_REG			0x4b028
>  
> +#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
> +#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
> +
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>  #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -101,6 +104,19 @@ static const struct pll_vote_clk gpll9_vote_clk = {
>  	.vote_bit = BIT(9),
>  };
>  
> +/* EMAC0 PHY AUX clock frequency table */
> +static const struct freq_tbl ftbl_gcc_emac0_phy_aux_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	{ }
> +};
> +
> +/* EMAC0 PTP clock frequency table */
> +static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
> +	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
> +	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
> +	{ }
> +};
> +
>  static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -140,6 +156,14 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  	case GCC_UFS_PHY_PHY_AUX_CLK:
>  		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>  		return 19200000;
> +	case GCC_EMAC0_PHY_AUX_CLK:
> +		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return 19200000;
> +	case GCC_EMAC0_PTP_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
>  
>  	case GCC_SDCC1_APPS_CLK:
>  		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> @@ -209,6 +233,12 @@ static const struct gate_clk sa8775p_clks[] = {
>  	/* SDCC1 clocks */
>  	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
>  	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
> +
> +	/* EMAC0 clocks */
> +	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
> +	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
> +	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
> +	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
>  };
>  
>  static int sa8775p_enable(struct clk *clk)
> @@ -285,6 +315,7 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
>  static const struct qcom_power_map sa8775p_gdscs[] = {
>  	[UFS_PHY_GDSC] = { .reg = 0x83004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
>  	[USB30_PRIM_GDSC] = { .reg = 0x1B004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
> +	[EMAC0_GDSC] = { .reg = 0xb6004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
>  };
>  
>  static struct msm_clk_data sa8775_gcc_data = {
> 
> ---
> base-commit: 84cc3bc1c6d4b6042ad8d2dd565f881d46c25507
> change-id: 20261103-emac_clock-a06461d02699
> prerequisite-change-id: 20261103-lemans-ethernet-c5fcad136deb:v2
> 
> Best regards,
> --  
> Deepak G <deepak.g10@oss.qualcomm.com>
> 
> 
> 


