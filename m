Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EB9FA373C
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75D788B49;
	Fri, 13 Sep 2024 12:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726222182;
	bh=EdGXiZZqoHDYIE1olELDHfCWFL/+D1I5y4iwH/RhdAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=St+otfYb/2d93TSycErjFEGwaSC626CG6u1qrQAh9DreaocDUyo9+0Lgsrcq5K+WP
	 AsJEGB//veSKXk7drPe+RsR/YB83Iydv4Uyy0ElnvuOYLjTmi9YxUzHkC75jO7fJWl
	 WheTjdBZq34xbu8AoJvt6RLMe5jk7o7keYrYCv7QzdizsLRvBDBqlcSXtIdNk2t4B5
	 Xi3kbqyXJ7JaOTWo90tol4EM5ofag3jA9ULH3QnNoGR4L3YFB+8wb8PuNu0SR3Fses
	 ADPPnFeF00eq3wR7v4StUT5w08jUucQCAplWJq16FZpq5q2Z6+UaLu0zMckKcHIGKq
	 lcqmt5KcrEQaQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0B94E886FD;
 Fri, 13 Sep 2024 12:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726222181;
 bh=EdGXiZZqoHDYIE1olELDHfCWFL/+D1I5y4iwH/RhdAA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rLHDox37dYFN9SQ8utFKJQG2hCkAL6uPln3aZRunCdR+07gYC/u7BX754jZKcfUe4
 zR+N8kaJ1zxBV/pUW6N8QmbP4+pMU6i2DJsygeS9+w/fVA8PgihHRxN7XLbgKipKLG
 FS0YdTk9t36XOIV+tEPmgixwnMrxki4sQOS4SWg3rv7/6EzXv6qL7iaJCpnWhbmnVj
 MGMIWrHYLEyzEjLISAwV9kAnLfZzugvea4gCfC3XEzAbvwtKnLa7dvqTLpt5EOA1XO
 d17ovmIIKv2yg21rX8zmb3brNjoH30s2xDgiELr2GKEKsrLzi4NiA/wLqNCwD8sahl
 Pi0zVaxY9yVGg==
Message-ID: <0ae21532-7ffb-4d6e-a729-77408e737327@denx.de>
Date: Fri, 13 Sep 2024 12:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] clk: imx8mm: Prevent clock critical path from
 disabling during reparent and set_rate
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-4-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240913095622.72377-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/13/24 11:55 AM, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> This commit ensures that critical clock paths are not disabled during
> reparent and set_rate operations within the clock framework, paving the
> way for the inclusion of new features.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/clk/imx/clk-imx8mm.c | 64 +++++++++++++++++++++++++++++-------
>   1 file changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index a91c6767fac5..432348a15cad 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -27,11 +27,25 @@ static const char * const imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "
>   					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
>   					       "audio_pll1_out", "sys_pll3_out", };
>   
> +#ifndef CONFIG_SPL_BUILD
> +static const char * const imx8mm_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
> +					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
> +					       "video_pll1_out", "audio_pll2_out", };
> +
This seems to be adding a lot of new clock, such a change is not 
described in the commit message.

What problem is this patch solving ? The commit message needs to be 
updated, it does not seem to match the patch at all.
