Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECF606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDqd1UKO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuE2obSn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1214960A86;
	Thu, 26 Nov 2026 13:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEYUxnYDp2Ui; Thu, 26 Nov 2026 13:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A818606F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795701564;
	b=nSL7BVV2HE6XWVVx8z1UkjoVf1UFidEcU1mctepBEw2HxncRhsXyp/GmVcM7bZ9hg6kf
	 ax6f2rJpQ+mrbB/yIapFtR76KMZjt5gt/z9TZGa7YeFiYljJmRDy2IHJkmUvNzt0cF/0d
	 lN+10pBHEx17erMYoPf7+Hn4tTBtwPohGUFEpmdfmPQY6KDkq/1Q40jnpjZbf0mIY9/na
	 bEpfhtESM2TDZMgu+0+7mf2Si2TIngErNW1eIuyMpF3xyUWGo+egQ78S+3I0k7fTR1h5n
	 dIMb/sU5fpfJcJnmp6teIUMtwze5yagAh1pgL55Q4hOiJ9VImznTvd6pOOTgMl01LHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ga/7gMAyXDeJniK4njyruAvTE5fLRHmQiBF7KlD1CXw=;
	b=gLted4G0gevjmqoKinAuRplc14m6Tf+hGRGBzPxmAoLS/2NKxHmuL5PvYCyZJ9rL+l1l
	 gBBabZ0eGIfI7xrcCAggFKZ+IOUTEhGjYMbHrrqja6vfr5VkE9r2GGIHzOX4o1NzCzQrU
	 QztqUYwlMqChAP6FZycxWWSfJKqz+uaAj49r/jsUkP+ceVE73vRsaYcb3tmxSMcu9qRSm
	 iHkR6MoHuNZiZROEmapyFa4+DmENVpx9YWHea3L7bdeZNhXSPj7gvbrOCFRcthIdXaJgP
	 KUct/lO/jbqyPo4EQ2ThlGXh1QcyfYvEU9w4ohHJ6y3cj9n4VZ72ttUxIT6cRqKfgeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuE2obSn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795701564;
	bh=Ga/7gMAyXDeJniK4njyruAvTE5fLRHmQiBF7KlD1CXw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDqd1UKOlEWazuPlYPY8aZ62DHyIm1PngOxLP0I0ydFZ8q7KkgqhtKQ3UKpPBC8TL
	 TV2G/juF5+Rexc9qGR71FjF518Xa7NWdqfeEY6ddvm68P6V3cgT0sxwt6zXLtqqC8C
	 4F6mdrjMsQGeb3erlrtfiROuC6POQ5E8ed3pswerTfuIYOxFNWOcjCRMELNPoREKXi
	 TS6Pj5gMXgduvGxPzQ8CsxxzFZ+nM1p0Whf/GIz1Puo4JjwLXkOPz3aKlUGihUpCDH
	 BQv+zdqQnktAMoyfDCYHydqJyHZYv0Yz/KqhKb8Yu7FXmeMFh0cm5da2hAROuu08bG
	 9gUMYpNImJb+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A818606F1;
	Thu, 26 Nov 2026 13:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E636F10B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCE3E606F1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBEoLqjoPiEv for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2AF260690
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CuE2obSn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2AF260690
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:59:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C5DA4036D;
 Thu, 26 Nov 2026 13:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCA81F000C6;
 Thu, 26 Nov 2026 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701560;
 bh=Ga/7gMAyXDeJniK4njyruAvTE5fLRHmQiBF7KlD1CXw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=CuE2obSnwXhfw8zCBWRW2qpa+lf/esoYAkFANNjO/4flDJ+kE0MmzpZlsBZfHtFI3
 MxkPr/t9n3U8BlR81WXspzEe2H9Z/DufG12+uij/x8jKeTFILiPU5SGGdDE9umiCYL
 xzZgLfMGHIWtxkb+BIqAXZ9q2jKAr+Hl3sZdcqtte/kObHzXMq+a9wdXVeXD3ZbOYK
 eHnbfyR1cqd4C7Li+2FUxgOk1WFlmZfHNqGdEQ6Rhtc5mnWT5dK70E52E2wZ1OEImp
 EgJGTOfpEujWci45ndoE8VMFzjMK4Z8jLA5MNAoeQo+VEOEAtfF+e63/jH8ev3TY97
 8/fMJp1VeDuoQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: qcom: shikra: add rate setting for USB20 clocks
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20261116-shikra-usb2-clocks-v1-1-1807bba5f437@oss.qualcomm.com>
References: <20261116-shikra-usb2-clocks-v1-1-1807bba5f437@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:29:14 +0530
Message-Id: <179570155466.130558.15898251981569347654.b4-reply@b4>
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

On 2026-11-16 21:33 +0530, Balaji Selvanathan wrote:
> Add set rate support for GCC_USB20_MASTER_CLK and
> GCC_USB20_MOCK_UTMI_CLK.
> 
> Taken from Linux commit 01cf3e27824d ("clk: qcom: Add Global clock
> controller support on Qualcomm Shikra SoC")
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> This depends on Aswin's series "arm64: qcom: Add initial support for
> Shikra SoC" (v5):
> https://lore.kernel.org/u-boot/20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com/

Please squash this patch in Aswin's series where USB is said to be
supported.

-Sumit

> ---
>  drivers/clk/qcom/clock-shikra.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
> index edf001d81a1..fe3fc471304 100644
> --- a/drivers/clk/qcom/clock-shikra.c
> +++ b/drivers/clk/qcom/clock-shikra.c
> @@ -16,6 +16,8 @@
>  #define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
>  #define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
>  #define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
> +#define GCC_USB20_MASTER_CLK_CMD_RCGR		0xb003c
> +#define GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR	0xb0020
>  #define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
>  #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
>  #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
> @@ -76,6 +78,12 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>  	{ }
>  };
>  
> +static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
> +	F(60000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 0, 0),
> +	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
> +	{ }
> +};
> +
>  static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
>  	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
>  	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> @@ -114,6 +122,17 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
>  		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
>  				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>  		return freq->freq;
> +	case GCC_USB20_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB20_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB20_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000,
> +		     "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR,
> +				 0, CFG_CLK_SRC_CXO);
> +		return rate;
>  	case GCC_USB30_PRIM_MASTER_CLK:
>  		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
>  		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,
> 
> ---
> base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
> change-id: 20261116-shikra-usb2-clocks-6e3d98c4f026
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


