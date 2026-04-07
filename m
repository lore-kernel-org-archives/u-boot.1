Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710F3FEEF25
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 11:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF42183A41;
	Tue,  7 Apr 2026 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M7E/qRmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7A083F98; Tue,  7 Apr 2026 13:39:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EDD8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 13:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 724804193E;
 Tue,  7 Apr 2026 11:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C157FC116C6;
 Tue,  7 Apr 2026 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775561943;
 bh=Kj3mymmWfdeSuX5OiyWSd5WD4Ma6eHcqXvtY5dJdl4o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M7E/qRmtvAzu3YSL+66q97ehnEV6/4B7R9xdZHsgYSqsjfZX0l+HmpW8WmiQQ7lHU
 pXcDDliTAHPXhz/7bbfV+Hm4NdVcDSV31eCxsesp8z1nMso4N87QYNQdFm8r1zNIeb
 j21PX1XJ795I5+s23fP+ErwbsxHY3ZqK2dq7ebXJMuHJd5KkNNiy75HMDsDJk0jLne
 j4XQocWSYLk4WG8QDh4f1fBvafQe+/wCh6cG6MgV6ozj4By5ZeKtvLtq2C+HPhNVDq
 Xb8yNVaYkrzz731zqjK/2ke7ppTRrHN462U13QtJzzMmfm+wDnS1id+4qvSk1wVhlx
 qVJwnoUGR2q2w==
Date: Tue, 7 Apr 2026 17:08:57 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: casey.connolly@linaro.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/2] serial: msm-geni: allow invalid clock
Message-ID: <adTs0aMJmGrIPKeR@sumit-xelite>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
 <20260320-casey-qcom-rpmh-serial-fixes-v1-1-b81d05832eec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-casey-qcom-rpmh-serial-fixes-v1-1-b81d05832eec@linaro.org>
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

On Fri, Mar 20, 2026 at 04:45:40PM +0100, Casey Connolly via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Pre-relocation we probably won't have a clock but it's usually
> been enabled for us already, or worst case we will enable it after
> relocation.
> 

Not sure if this is the right approach, since the UART driver might just
hang without clock being enabled. What's the motivation for this change?

-Sumit

> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/serial/serial_msm_geni.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index bb5a2cb4d2cd..c37255f57d05 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -211,9 +211,9 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
>  	}
>  	ret = clk_set_rate(priv->se, clk_rate);
>  	if (ret < 0) {
>  		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
> -		return ret;
> +		return 0;
>  	}
>  	geni_serial_baud(priv->base, clk_div, baud);
>  
>  	return 0;
> @@ -516,15 +516,14 @@ static int msm_serial_probe(struct udevice *dev)
>  	int ret;
>  	u32 proto;
>  	struct clk *clk;
>  
> -	clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> -	priv->se = clk;
> +	clk = devm_clk_get_optional(dev, NULL);
> +	if (!IS_ERR(clk))
> +		priv->se = clk;
>  
>  	/* Try enable clock */
> -	ret = clk_enable(clk);
> +	clk_enable(clk);
>  
>  	/* Check if firmware loading is needed (BT UART) */
>  	proto = readl(priv->base + GENI_FW_REVISION_RO);
>  	proto &= FW_REV_PROTOCOL_MSK;
> @@ -546,12 +545,8 @@ static int msm_serial_probe(struct udevice *dev)
>  	/* Don't actually probe non-debug UARTs */
>  	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
>  		return -ENOENT;
>  
> -	/* Now handle clock enable return value */
> -	if (ret)
> -		return ret;
> -
>  	ret = geni_set_oversampling(dev);
>  	if (ret < 0)
>  		return ret;
>  
> 
> -- 
> 2.51.0
> 
> 
