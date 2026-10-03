Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B06BCA5FE2
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 01:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CC9060649;
	Sat,  3 Oct 2026 01:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkpk_xqBXeR3; Sat,  3 Oct 2026 01:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4E8E06064D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790989500;
	b=qs52JJMJ7Rocuk5O8Chgf3FJJMSqtyl3P87X37FY5CbhtiRnTzdIWq/ZXlJKMCQ6U4c2
	 5Kom5M+l2SFQu9EvMFwK07IWCeUZKOayNQ3VQsy1qMN5xnMj6i3QvXxg7PDpcRR7bp5lV
	 PVSWsN7HMt9DKalgcIXJ+PGtPMgDKIJ65kwhrq9HVlMB7CjIp1N36L4KL3disetvtBqdQ
	 YHu2sXi2LqxXuRMumf9tTfE1aStA8KdkKpj9TbYcHsbHUvgXt/P3hyRgAX57opWpJ8fG1
	 8xGqODEi1pF5ljfgGCAhDiNlLyhXuk+E9glZPwM5FKFsf/r8BPUtHNWoFkTWV17tapA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790989500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XgxfawDBFvf3ghYlhphK0srlo23SSOLmmvmhooStnIg=;
	b=Ah7zX/nTB47yls1aLiR4agLhNcfACbgAMc5yTkslBOQDXYpcFL2MhBjvY+FOyk8icGzN
	 JJ9wAqbhKc6OQj8cknG9sEUrCOw1oXkJfLflgyRm//WNtY8Mo3EiDF7On5RbPeMGgI53w
	 ODcKVJ5M1O0cMXKeApdF/4NRfg1yamWbzxoVDPBmeBg/lHdbOzYF4bsrDzJnEfB27A8z3
	 Ye6JtgrifVyM8ZIGTCuNxg9aepsg8C0Wx2ub9qM/XSOnNGyP3P2Sk3ozlKdp3L/CSQSkg
	 DBaSLoPnQCw2j9Z8taK49Tat3WM21pgWr7gursF48w2Qa1Oj7ryYwvTzEnaex/dTiBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itrNKo+E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790989500;
	bh=XgxfawDBFvf3ghYlhphK0srlo23SSOLmmvmhooStnIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jHVeAlUMhBfV8lxg16r1xo3+nA24pcjBHP/ZQcVQ153ChInufDfCESrwWjbaHp/Sl
	 HyeY50o1Jyhq1cFisMNPyb4bDeuvSLkcIPxe6wmf8XoTjAbxao727aVHArgLmjdK7j
	 9cplz+4MnBoCan0ikubPpb+U3apF7bbC30dAYgSTfMzU+kOi8q33hp5jzvfexMe3iz
	 fNPwQ3oYyVYQyOd8iyenpIudBRJWr2CrUF6iaxSJ71WZKO9vHzLp7eimI/o5yDjYn5
	 9kpYxbzkk3z8rCpPWULdQSgYqg037vmKs4p2mV+6zhwvDNNnCdrCeRKNnGjJfN3TtW
	 hB8lB9SvnUZPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E8E06064D;
	Sat,  3 Oct 2026 01:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DA8F263
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 01:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1ED4C6064D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 01:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGoB_rE9yHun for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 01:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4D52D60649
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790989498;
 b=T3yVXMcR/BYVeEE3YQUbSvRrPqG8EXmbuQg0B7ZJgSuR7yGcqQiSXc4p9uyshmH2mRBa
 OCLD6UNF+WyTxhBrokW3s1AVSveU+NBmA5Sn5ZGFgNDo5tNluruS7P8HuZFGx7+lPC57e
 WN02xe0zKmaNNpGuq89mUr2fEvIwP8MbMJaz2pOhNis4i9GnlP2KME3lM23sX7LkEw9sM
 Ek8PST4gjjZ9YrXWO/UDI8tJ/JtCF0paZjee5F/ia/GFgeTw3jP7p4mUqhd9M86FCfznb
 5W++4Ftujod6YyIF/PuVgEKHwXG6MoXbM0RS03d0Q+SsDGpkhxEyd7tRzuR/FrYe+ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790989498;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=XgxfawDBFvf3ghYlhphK0srlo23SSOLmmvmhooStnIg=;
 b=OriJaVWVM65E4LOi+JL6RXJMvkC6G2CdpUhevUdb2jjhjg185JX5bzEST87FX4RwLWCM
 M2yAJkyckIEYz0qOcy09cIA3ZG5+8ISOvHcAEunvudVqUPrfm2spVlLFjLJJ6T2VCXVIj
 ppzcaOKfNAcmECZ/dbYanv3F9XVnTqCHQcywyfHrmgycVFCXxfyDZHGZI3ZGFTHKjoFlu
 cYyPX0+GPzaFmD6aX1OC8aoQHaRUweU+YLszIUlg7a+57HnXr7kadSdgDqtQpY7zFBke0
 aVLdDG0lzmWzW+vyREw8aNvaU7h6OL38ZklR7sfRcdHMe/fYveG/bfjikvTTnjT9bWw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=itrNKo+E; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=itrNKo+E
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D52D60649
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 01:04:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7493460A97;
 Sat,  3 Oct 2026 01:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6B1F000FF;
 Sat,  3 Oct 2026 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790989495;
 bh=XgxfawDBFvf3ghYlhphK0srlo23SSOLmmvmhooStnIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=itrNKo+EsDDhnc//pN49+6fhicY7cVw6GRXITG1NzAUDAjs9oKYNwEnnJk951OvtC
 2kvuO0AWnsAvahNHjYUwGBIgaMrEvQT4QZ7uNb5YVUjUJ9HWwdY5SGEyV/b/Di5j9l
 rsSdoq4zT8uXnb1yGY3xT8eWgY72CocxBQQ545L1Gytmvmyoeqi5uPcypwub+jUZIo
 rH6wWszmCm8dn/zhoHqbidyp9n3hqDxRiFNUJ5uSHwyTZMbkh/O1sCPV5h99excWmL
 CcKeT5q5aobThFa12/ifb8OlelPDC+A6+FvKBHdqMrgPHNFhEgxVmHEzHCWlleZA99
 /JrcEUstlCAdQ==
Date: Sat, 3 Oct 2026 01:04:52 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] clk: spacemit: program the mux when setting a mix
 clock's rate
Message-ID: <20261003010452-GKG51329@kernel.org>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

hi Dave,

On 21:29 Fri 02 Oct     , Dave Klotz wrote:
> ccu_mix_set_rate() picks the best parent and divider but writes only
> the divider. U-Boot's CCF has no determine_rate step that would reparent
> the clock first, so the clock keeps running from whatever source the
> mux selects, at a rate the caller never asked for. Worse, when the
> hardware mux selects a source that this build's parent list does not
> contain (the K1 SPL lists only pll1_d6_409p6 for the SDH clocks), init
> registers the clock under parents[0] and the clock framework's idea of
> the parent no longer matches the hardware.
> 
> Write the chosen parent's mux index and the divider together and latch
> both with one frequency change. Enable the new parent first and reparent
> the clock device after, so the framework follows the hardware. Nothing
> is written when the mux and divider already match, so a clock left
> running at the requested rate by an earlier stage is not disturbed.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
> Tested on an OrangePi R2S booting from eMMC, where the SDH2 io clock
> moves from the BootROM's 409.6 MHz to 204.8 MHz in the SPL, together
> with "clk: spacemit: ccu_mix: fix inverted condition in
> ccu_mix_trigger_fc()" from the K3 clock series, and on an OrangePi RV2
> booting from microSD.
> 
>  drivers/clk/spacemit/clk_mix.c | 54 +++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
> index a1158512a9..3521ab9374 100644
> --- a/drivers/clk/spacemit/clk_mix.c
> +++ b/drivers/clk/spacemit/clk_mix.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <dm/device.h>
> +#include <dm/device-internal.h>
>  #include <dm/uclass.h>
>  #include <div64.h>
>  #include <regmap.h>
> @@ -136,26 +137,63 @@ ccu_mix_calc_best_rate(struct clk *clk, unsigned long rate,
>  	return best_rate;
>  }
>  
> +/*
> + * U-Boot's CCF has no determine_rate, so the parent is chosen here along with
> + * the divider. The mux is programmed from the chosen parent rather than left
> + * where it was found: init falls back to parents[0] when the hardware mux
> + * selects a source this build does not list (the SPL lists only a subset), and
> + * the clock would otherwise keep running from that source at a rate nobody
> + * computed. Mux and divider are written together and latched by one frequency
> + * change, and nothing is written when both already match, so a clock left
> + * running by an earlier stage is not disturbed.
> + */
>  static unsigned long ccu_mix_set_rate(struct clk *clk, unsigned long rate)
>  {
>  	struct ccu_mix *mix = clk_to_ccu_mix(clk);
>  	struct ccu_common *common = &mix->common;
>  	struct ccu_div_config *div = &mix->div;
> -	u32 current_div, target_div, mask;
> +	struct ccu_mux_config *mux = &mix->mux;
> +	struct clk *parent = NULL;
> +	unsigned long parent_rate;
> +	u32 target_div = 0, mask, val;
> +	int i, ret;
>  
> -	ccu_mix_calc_best_rate(clk, rate, NULL, NULL, &target_div);
> +	ccu_mix_calc_best_rate(clk, rate, &parent, &parent_rate, &target_div);
>  
> -	current_div = ccu_read(common, ctrl) >> div->shift;
> -	current_div &= (1 << div->width) - 1;
> +	mask = GENMASK(div->width + div->shift - 1, div->shift);
> +	val = target_div << div->shift;
> +
> +	if (mux->width && parent) {
> +		for (i = 0; i < common->num_parents; i++)
> +			if (!strcmp(parent->dev->name, common->parents[i]))
> +				break;
> +		if (i == common->num_parents)
> +			return -EINVAL;
> +		mask |= GENMASK(mux->width + mux->shift - 1, mux->shift);
> +		val |= i << mux->shift;
> +	} else {
> +		parent = NULL;
> +	}
>  
> -	if (current_div == target_div)
> +	if ((ccu_read(common, ctrl) & mask) == val)
>  		return 0;
>  
> -	mask = GENMASK(div->width + div->shift - 1, div->shift);
> +	if (parent && clk->dev->parent != parent->dev) {
> +		ret = clk_enable(parent);
> +		if (ret)
> +			return ret;
> +	}
>  
.. this will enable parent, would be it ok to combine below
device_reparent() together? to simply use clk_set_parent(clk,
parent)? it make sense to me to reparent first then program
the divider

> -	ccu_update(common, ctrl, mask, target_div << div->shift);
> +	ccu_update(common, ctrl, mask, val);
>  
> -	return ccu_mix_trigger_fc(clk);
> +	ret = ccu_mix_trigger_fc(clk);
> +	if (ret)
> +		return ret;
> +
..
> +	if (parent && clk->dev->parent != parent->dev)
> +		return device_reparent(clk->dev, parent->dev);
> +
reparent clk
> +	return 0;
>  }
>  

-- 
Yixun Lan (dlan)
