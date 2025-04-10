Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA6AC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4471883ABF;
	Thu, 10 Apr 2025 10:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZWft/Pvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF3B83AC6; Thu, 10 Apr 2025 10:51:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477B383A98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0E394A23A;
 Thu, 10 Apr 2025 08:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C6AC4CEDD;
 Thu, 10 Apr 2025 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744275102;
 bh=gAFkht3vODf9rdxA95PhPPGT62r0xC81/S30uzsA2+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZWft/PvoFA1IApv8a/tNfpo6+QQ83ymz4hlFgsbnlD4SVTs4mXK2plx56Wn+CqKZ0
 CzaEkvfhsXWlf9AYVbtSFG/cX2ha0f9a86Kwbuklt5BrNOVul7gyQdTp6bX+ZWomE3
 1wg1fQLk1QiZhn0bWLW+aD2usjNdB7IVImcjXkoHF2oUm9gR/3rRiWoH9zdFDvlJuR
 n5UAf/tiAYLj+33OcyCLDWz4ykXhNNusMKCP7r1DmkQx/UJlMqfFm369/hqtMa6CSu
 d6pBdej5neMx/BRAZyzhyMQ7ewn0j76H9eW2NbGHMkv1tZc3/Qql2kf4fq2c2RqCAb
 RJoLuecLXmLaA==
Date: Thu, 10 Apr 2025 14:21:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 4/6] clk/qcom: qcm2290: show clock name in set_rate()
Message-ID: <Z_eGmUkX4G_gF1ob@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-4-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-4-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:27PM +0200, Caleb Connolly wrote:
> The device name is always clk_qcom... Not very useful.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-qcm2290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
> index 1326b770c3ebd723120de4b6657aafac726023d6..fad104fb91aec8917de66b63dd546926c8856011 100644
> --- a/drivers/clk/qcom/clock-qcm2290.c
> +++ b/drivers/clk/qcom/clock-qcm2290.c
> @@ -87,9 +87,9 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>  	const struct freq_tbl *freq;
>  
> -	debug("%s: clk %s rate %lu\n", __func__, clk->dev->name, rate);
> +	debug("%s: clk %s rate %lu\n", __func__, qcm2290_clks[clk->id].name, rate);
>  
>  	switch (clk->id) {
>  	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
>  		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> 
> -- 
> 2.49.0
> 
