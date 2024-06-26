Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFD9C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC37B87FED;
	Wed, 26 Jun 2024 18:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DfQevRkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE93187E49; Wed, 26 Jun 2024 18:16:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83A9882DC
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d9e3=N5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719418598;
 bh=N/AxBZf1GXasaByyoIezxRNUxwvCjO6T4KtZXXQ0Uqk=;
 b=DfQevRkP4wVC+O4vWc5MalSdk1OG6XkDoBDOtyY7ThTxeS0mhNZBmnwsUr4JaSB0Z+d4dUp3i
 flt8D5fCKKNxJbKbpwT/1vhOIUUYHqgwYj3mZKCR2nhi+nvTH2ADf7vRVMCM7D4MJBYKAFnHRwN
 EKwSIpxDkdPxg4Qz3xFSX/Wd6VTfH1+V/1Axzuh+DabY/oBWZsUCMVdSJHZvr3gKZDSr4Kw0W8Q
 QC3+04fiGALAp/JRGi4ObF6bBeG8IysR5/CmRMZeMVsGg/M793oPaLHjxCt5wAG+5jAo79nVzcX
 VgXJryq96fYnvZ+NQIIKdXi8E5TOQ1/RYTDzF7e2khVw==
Message-ID: <e6df1db5-745d-4398-9207-7f08faa1628d@kwiboo.se>
Date: Wed, 26 Jun 2024 18:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
References: <20240626155945.278640-1-sjg@chromium.org>
 <20240626155945.278640-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240626155945.278640-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 667c3ee33ee5435cb7e65d12
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

Hi Simon,

On 2024-06-26 17:59, Simon Glass wrote:
> The code here is confusing due to large blocks which are #ifdefed out.
> Add a function phase_sdram_init() which returns whether SDRAM init
> should happen in the current phase, using that as needed to control the
> code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.
> 
> - Drop the non-dcache optimisation, since the cache should normally be on
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v5:
> - Move setting of pmugrf into the probe() function
> 
> Changes in v3:
> - Split out the refactoring into a separate patch
> 
>  drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 3c4e20f4e80..b259e8e3dd6 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c

[snip]

> +/**
> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> + *
> + * Returns: true to do SDRAM init in this phase, false to not
> + */
> +static bool phase_sdram_init(void)
> +{
> +	return spl_phase() == PHASE_TPL ||
> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());

This still need to check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL)
to be correct, else you must build with both CONFIG_TPL and
CONFIG_ROCKCHIP_EXTERNAL_TPL or the generated SPL will incorrectly try
to initialize DRAM.

DRAM should only be initialized in TPL or ROCKCHIP_EXTERNAL_TPL,
or if none of them are defined in SPL. All other phases should
just read and report dram size.

Regards,
Jonas

> +}
> +

[snip]
