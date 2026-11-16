Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7861606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LuY6O+58;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXXW/4Jl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7782E80FBA;
	Mon, 16 Nov 2026 16:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39Buv0PIW0cM; Mon, 16 Nov 2026 16:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62C1E80FB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845769;
	b=DjYUgpw61kXfQU+8+6aQxlElX4R9QGXftcgjuZ+QS39PRC2ddS8GlF7Yk9NV5VCwWzKt
	 UVg/ZSiX/Sk4Loh9OZUPz0eOXq86oddDZN2DHZSbqELNl5uUxVZ6tV6P5qcWKRJz+YobU
	 Ai5JFXP6ffOZqXVFDaHZ67EdbhtQsCk/d9pAgbJiP+dadjY1wjQsUjKU36l7T3Qq6gisK
	 fvsVvZFGevGokdxf6ThzhebGQ4Wz+ZoN4h8TstU295tJmS24EQe7srWp3tMyxbUoMCM/9
	 CduyirUEu/abomosdP5Zc+Y/NIoXbq1gMblT1HN1lyNZy2mJ8AflH7rbCyah/ZjC55w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qtrDcfIs1RXQSTpE7uG/zxCKVtGTml2zDU7GmazGxpA=;
	b=fsgwZtp87ywLczNmVu9+yweHjs+I4rzznpEe4VsykXr08wNVavsOVVPM+1le64gGeNb6
	 bM/spkmtQoEglK9dU/qDzyhNieL621/SGSxjxQMmUUauvAcjCzLbeOeosnAVqwDT6DjFF
	 SfLoAwiNT/bdrCwi8m5hrvUOkWdQ2yPKWTMt7qxl6wXxAChW+S5qpO1NEed+dJBLJWwVn
	 UMZU5ZATni2L/XK84tshJK/W90WNHCsSkXDS+ER7aArK/AsIjK1anig9FJl+qJ2eW1IGU
	 /8AHClZOoAdb4IF7TnzQpuu/ZhgFuDfumWCqvluSjmuXp2I5iCROLOSroJCyuDGXPYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AXXW/4Jl";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845769;
	bh=qtrDcfIs1RXQSTpE7uG/zxCKVtGTml2zDU7GmazGxpA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LuY6O+58LHm20IWiwSnaalJoAhcE3zrxg6F0Pgg3vX90zDKxy5j8CrMrii2oZHocZ
	 KYU940+3SJeMd7ZtmvbZJ6TsG7ZotuH/ckwMVY1YxEmyavDyhCugxwfSdtpcGFOvxh
	 QJnr2nSWyVUi/V6Pp8gUznaEhyHD6l6FCUJal5VXnnOn7adtylPQEiGXytzL3FtwED
	 JSf4KQishf8+S0fyB2CxcFOkBjHLqHlRmRk5pUnnbEn0rlfDbns2JfN4wuA4sLrkZ4
	 UTsPuI7X5BuFPTSUbSKA2Tl/w0SKNVKxc1xuAwVr8Q74pmZ6jZ2srO02p5YbmsYF14
	 4VmPON+R2Xk9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62C1E80FB3;
	Mon, 16 Nov 2026 16:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CD2E260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49EF380FB3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEHa1_k1FvZQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6EE8E80ED8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AXXW/4Jl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EE8E80ED8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:16:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F3074022C;
 Mon, 16 Nov 2026 16:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DFC1F000C4;
 Mon, 16 Nov 2026 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794845766;
 bh=qtrDcfIs1RXQSTpE7uG/zxCKVtGTml2zDU7GmazGxpA=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=AXXW/4JliNaMbiGkT7HNWFpQDzs2lFP5+ofe5B9BuvKuqZchpAZvsZGxq0qczHwfn
 +3ojQ6JXH5yfo/+GMi5IsQioX0XvvrJoKVGL6HAWUneKYDKJqtuvALqZBmyAkb4r+l
 ylULvQYcN/X16pRUlUgstAVHSrvW3GW8Vdo+k4mCgt3en+ip9pVX2QWz8b5KbI+2TP
 0O9vFOY8f5lXSnydu0d3AJLSnfA/IQkQYQ5ZR4u+CfJV7CXnrVNmgGLiPATrhPPML3
 mJrn1NVmmZ6MJYp05NuYW7MQLJoRByXSaPvAjFuKSzMbBRGD2EtVxV7zhb2W3zGm6V
 ZebT6SuNC6Zuw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: qcom: qcs615: add SDCC2 apps clock support
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260911-pll-sdcc-talos-v1-1-403f61254a19@oss.qualcomm.com>
References: <20260911-pll-sdcc-talos-v1-1-403f61254a19@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 21:46:02 +0530
Message-Id: <179484576280.21534.4899449642113823435.b4-reply@b4>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-09-11 15:01 +0530, Balaji Selvanathan wrote:
> Add the SDCC2 apps clock used by the external SD card port on qcs615.
> The frequency table covers the standard SD rates up to 202 MHz.
> 
> The 202 MHz rate sources from GPLL8 which is currently disabled.
> Vote GPLL8 on before programming the RCG whenever the selected
> frequency uses it.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> This patch is dependent on this previous submission:
> https://lore.kernel.org/u-boot/20260721-emmc-v3-1-35cebc036994@oss.qualcomm.com/
> ---
>  drivers/clk/qcom/clock-qcs615.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index e9572951e7d..8113effae77 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -52,6 +52,16 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>  	{ }
>  };
>  
> +#define GPLL8_STATUS 0x1b000
> +#define GPLL8_ENA_VOTE 0x52000
> +
> +static const struct pll_vote_clk gpll8_vote_clk = {
> +	.status = GPLL8_STATUS,
> +	.status_bit = BIT(31),
> +	.ena_vote = GPLL8_ENA_VOTE,
> +	.vote_bit = BIT(8),
> +};
> +
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>  #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -140,6 +150,8 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  		return freq->freq;
>  	case GCC_SDCC2_APPS_CLK:
>  		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		if (freq->src == CFG_CLK_SRC_GPLL8)
> +			clk_enable_gpll0(priv->base, &gpll8_vote_clk);
>  		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
>  				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>  		return freq->freq;
> 
> ---
> base-commit: c325d05e486ffc7298796ef1aa22c5a1196b8113
> change-id: 20260911-pll-sdcc-talos-d61d6ac463f5
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


