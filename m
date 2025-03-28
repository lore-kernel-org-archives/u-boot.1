Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F9AC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8433181951;
	Fri, 28 Mar 2025 17:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uYxiOSce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F95A81951; Fri, 28 Mar 2025 17:11:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4808144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743178298;
 bh=+4ciNL48RPWw7LGp6PBJO/27j4/itKlvAzPpS+qK2Xo=;
 b=uYxiOScearCHav/QzjQgn331d/jW0zc6bb1oiuL1Nkvhtrh04xlBMMtJBhznXfkXd/FZUDY3r
 Cgc6umjvlaEdMr0sfLA7ESscigxFyeOBKsCMDgSl2h0tuxSw96nwEWXipqcL+F57zf4P9hkavVo
 FKJh2MRQtxen0nHo1d+kkzF6i1n+HXvggjyJgTVoAK/ERLYrSo5ap33ztQrTn+Me9+WtsgqhjVa
 3E/RUBuEkOjSo5uVv5/VXZPCgPJKBc2qknqXCeoYT55XiwJBIElYo0lirHwJUPI0xx1G0MVNfc2
 taOhag49jxGQGy4l++hcDaa6KFup8BymVzMENm5pJGXw==
X-Forward-Email-ID: 67e6ca3837e81528de2b9ead
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9a1cc222-3562-4e28-82d3-cb03f527a5fc@kwiboo.se>
Date: Fri, 28 Mar 2025 17:11:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/31] rockchip: Update rk3399 bootph-tags for VPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-19-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-19-sjg@chromium.org>
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

Hi Simon,

On 2025-03-28 16:34, Simon Glass wrote:
> When VPL is in use, memory init happens in SPL, so there is no need to
> include the DMC device before that. Adjust the tags to save space.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Only enable MMC when VPM is in use.
> 
>  arch/arm/dts/rk3399-u-boot.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 81a3c6fc972..c3d0da62c8f 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -71,7 +71,12 @@
>  	       0x0 0xffa88800 0x0 0x1800
>  	       0x0 0xffa8a000 0x0 0x2000
>  	       0x0 0xffa8c000 0x0 0x1000>;
> -	bootph-all;
> +#ifdef CONFIG_VPL
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +#else
> +		bootph-all;

Please use correct indentation for above bootph- props,
they now use two instead of one tab.

Regards,
Jonas

> +#endif
>  	status = "okay";
>  };
>  
> @@ -118,6 +123,10 @@
>  };
>  
>  &sdmmc {
> +#ifdef CONFIG_VPL
> +	bootph-pre-sram;
> +	bootph-verify;
> +#endif
>  	bootph-pre-ram;
>  	bootph-some-ram;
>  

