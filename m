Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84299C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8000882B7;
	Mon, 24 Jun 2024 10:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hi4cjHRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7258F8836E; Mon, 24 Jun 2024 10:53:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F3287D07
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660c=N2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719219197;
 bh=R3DEMfEeveDEvlm1BSJGoiHxD8K6mOZi4k+VlHarApE=;
 b=hi4cjHRYJK+SDEAMisO0jz+LQ0Tu9erWKZgdp8+zAtN7zS8gTR6hc9cVc6hBavbs6KbZ/JABk
 FoWB1JyaEUwUhk8HdLYN7LroUZc/V+K/m8AQEtbCl6OfePSrmoNcWmp/lUafsx9m8+nHamB8jRb
 nizx7pbrLc/w3UFrxLVvXg76rrOPiVnOahDYqoX+bIEfOTnpQ2PB2VkCa8eHUqz7lnZ7SSKexH/
 plS2BD/PSCvBBUWi+gU0s1Fft7UZFImtVM4TLZch7Y/JkWBrlR8qPGZgksczrieQfvdGyglz5jC
 Xt9WvB8bnidYOps7UooehSbH0HqAtb2Fn1YXL4QOWYIw==
Message-ID: <c74cd79e-8df6-4d89-96d8-50175e452a78@kwiboo.se>
Date: Mon, 24 Jun 2024 10:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 huang lin <hl@rock-chips.com>
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240623175302.1463973-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667933ea78c9998650f04769
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

On 2024-06-23 19:53, Simon Glass wrote:
> The code here is confusing due to large blocks which are #ifdefed out.
> Add a function phase_sdram_init() which returns whether SDRAM init
> should happen in the current phase, using that as needed to control the
> code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Drop the non-dcache optimisation, since the cache should normally be on
> 
> Changes in v3:
> - Split out the refactoring into a separate patch
> 
>  drivers/ram/rockchip/sdram_rk3399.c | 42 +++++++++++++++--------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 3c4e20f4e80..949a082d00c 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c

[snip]

> @@ -191,6 +186,17 @@ struct io_setting {
>  	},
>  };
>  
> +/**
> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> + *
> + * Returns: true to do SDRAM init in this phase, false to not
> + */
> +static bool phase_sdram_init(void)
> +{
> +	return spl_phase() == PHASE_TPL ||
> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());

This also need to check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL).

Regards,
Jonas

> +}
> +

[snip]

