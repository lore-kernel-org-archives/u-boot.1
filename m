Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC395D4335B
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 01:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D86883837;
	Fri, 12 Dec 2025 02:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J1XDnboP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD9D83869; Fri, 12 Dec 2025 02:00:39 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6406C8334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 02:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9ECD43F4A;
 Fri, 12 Dec 2025 01:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597E3C4CEF7;
 Fri, 12 Dec 2025 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765501235;
 bh=48NRPzCZa3dGdq1RMbuobRiT/l+XCCnIl8OQDR4u02Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J1XDnboP9DpfcmBNNXxgQfXp0CgA8o4/0VXOK+GHxCwaZYkVK9n2fSxMm7XurKVjv
 w3bJ/XU8kKZnxaoixrJ0B2hVvoE0JQ0+WFl7VZjhI8k5HFpCBV6Oh1KL3g+Z4aQWaQ
 fDzHAfBSU5KBOVSBQl0Ae340BFY55KRL/KEZzhf/VmKKBJ5j6iBlIYyxsYMt4Z+S1I
 lGInAwQQSPWS+hZsVwIXNRfdZprxSURCFbl2wfv95iH7fvG0ZefuREtqud5tip6mfi
 P4H/BfTVbAyYmogCIDlqUluCUs+DZ2irjrTmPE9Q76mye4kinaKJYDkvThKbRJZoj9
 68OHyP0Xew3lQ==
Date: Fri, 12 Dec 2025 10:00:28 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] clk/qcom: qcm2290: Add SDCC1 apps clock frequency
 table
Message-ID: <aTtpLOP2WGkmoUQd@sumit-X1>
References: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
 <20251210155454.1561611-2-loic.poulain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210155454.1561611-2-loic.poulain@oss.qualcomm.com>
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

On Wed, Dec 10, 2025 at 04:54:53PM +0100, Loic Poulain wrote:
> Add support for configuring the SDCC1 apps clock on QCM2290 by introducing
> a frequency table and enabling dynamic rate setting. Previously, the clock
> was assumed to be fixed at 384 MHz by firmware, which limited flexibility
> and correctness when selecting optimal rates for SD/MMC operations.
> 
> Suggested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcm2290.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
> index fad104fb91a..5a599085b50 100644
> --- a/drivers/clk/qcom/clock-qcm2290.c
> +++ b/drivers/clk/qcom/clock-qcm2290.c
> @@ -17,6 +17,8 @@
>  
>  #define QUPV3_WRAP0_S4_CMD_RCGR 0x1f608
>  #define SDCC2_APPS_CLK_CMD_RCGR 0x1e00c
> +#define SDCC1_APPS_CLK_CMD_RCGR 0x38028
> +
>  
>  static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>  	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
> @@ -55,6 +57,25 @@ static const struct pll_vote_clk gpll7_clk = {
>  	.vote_bit = BIT(7),
>  };
>  
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
> +	{}
> +};
> +
> +static const struct pll_vote_clk gpll6_clk = {
> +	.status = 0x6000,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x79000,
> +	.vote_bit = BIT(7),
> +};
> +
>  static const struct gate_clk qcm2290_clks[] = {
>  	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, 0x00000001),
>  	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a084, 0x00000001),
> @@ -109,8 +130,12 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
>  				     8);
>  		return freq->freq;
>  	case GCC_SDCC1_APPS_CLK:
> -		/* The firmware turns this on for us and always sets it to this rate */
> -		return 384000000;
> +		clk_enable_gpll0(priv->base, &gpll6_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src,
> +				     8);
> +		return freq->freq;
>  	default:
>  		return 0;
>  	}
> -- 
> 2.34.1
> 
