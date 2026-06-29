Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6033EC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF54484A4D;
	Mon, 29 Jun 2026 19:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bsLg3176";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1536984A5A; Mon, 29 Jun 2026 19:34:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8784D84A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d2b5=E2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782754444;
 bh=GLl5qJy52ECxGQXIFAhNbZ0rmkwFizPzzUB6Ht4rlM8=;
 b=bsLg3176VsMKuFLF3oj1i87W6DgqaCUuKy0FGyl+97TyvqHhcsfXV/783RA8nk/jBdbqH95pw
 XVaOV6gW/HiijtBTibmJrwq/FHUH60MJ42UUrneCqKzblSJ5uWqrCxCAOuRUEj61qn/6M3FALht
 6xdpXWAuA1SR1OJ0LX5WqenBd7xok5X2xT/HB1k4txwlJIsUD0grcRHaGLc8hVQA7nWSt9VBdx5
 aMq6eRi+hxfn5+aPPjU3EGA+LYIwUnkKDw9iu1Cjw1vNgQ4xVuw6cn4FAO0fugGG7uNtU0tzURI
 Nu5ToHBqyaKgAIUxuoJp02ABFiCrPLnh8TiZnLzM28hg==
X-Forward-Email-ID: 6a42ac8a5eb497aec47217a2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d327c3a1-cce7-4737-9ace-afe8cb1afade@kwiboo.se>
Date: Mon, 29 Jun 2026 19:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3568: make the TSADC trigger a first
 global reset
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, quentin.schulz@cherry.de
References: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
 <20260629170517.1436613-3-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260629170517.1436613-3-andreas.zdziarstek@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Andreas,

On 6/29/2026 7:05 PM, Andreas Zdziarstek wrote:
> Same rationale as the watchdog: the default second global reset leaves
> the SoC hung. Set the TSADC to the first global reset as well, so a
> thermal shutdown reliably resets the whole SoC.
> 
> Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
> ---
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 87bd443e9c4..50b61b7cd26 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -40,6 +40,7 @@
>  
>  #define CRU_BASE		0xfdd20000
>  #define WDT_GLB_SRST_CTRL	BIT(1)
> +#define TSADC_GLB_SRST_CTRL	BIT(0)
>  
>  /* PMU_GRF_GPIO0D_IOMUX_L */
>  enum {
> @@ -156,6 +157,9 @@ int arch_cpu_init(void)
>  	/* Make WDT trigger a first global reset */
>  	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
>  
> +	/* Make TSADC trigger a first global reset */
> +	setbits_le32(&cru->glb_rst_con, TSADC_GLB_SRST_CTRL);

There is likely no need to read and write this reg twice, please combine.

Regards,
Jonas

> +
>  	return 0;
>  }
>  

