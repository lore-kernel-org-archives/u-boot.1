Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F0C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74CA8215D;
	Tue, 15 Apr 2025 00:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jV/EqlFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B812826AD; Tue, 15 Apr 2025 00:45:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D97982102
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=02b5=XB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744670709;
 bh=elx0/NqiIXVahyX4E6YxyuHQRfEH0bSpFkaVEdUN6jQ=;
 b=jV/EqlFidgPrQHNhymbUiWJM1qlFi1dEb7Xp6Mu4R2dj0kwPAqECfKZjvHnHrt8JXJ+QSLuBY
 rDA4hK4s8YR/0Vi0D+3bmBvK71LZXmuDMgKNIa/5HdGfJ1rv8jSLr8O13MvJUYXmpOlyQAkX+Lh
 ViSHSL4zplaAh1QD/wU81TFrvY67ANjLjCaDJvHN6WPB1E3gZfIsD2gRLpVYY5YuhO1R4eiKYJx
 BPVkRzgeBi/yFRoP6HKT4ZsX4cfD3CGCs7TXM8pU6a84y+2uQLyENweg1KsuuEMb8DoI11UEJo6
 fd6Ak4ebWUOGL9TeuQ/WTn+/nqgoF1wRccWLh3sgRxKw==
X-Forward-Email-ID: 67fd8fe740cbaa005ededaf0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8493ad37-bdb1-458b-b936-078239cfb4e2@kwiboo.se>
Date: Tue, 15 Apr 2025 00:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] arm: rockchip: add RK3576-specific syscon ids
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-4-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-4-heiko@sntech.de>
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

Hi Heiko,

On 2025-04-14 22:00, Heiko Stuebner wrote:
> From: Detlev Casanova <detlev.casanova@collabora.com>
> 
> The rk3576 defines some more different syscons, namely the IOC-syscon
> holding io-controller registers and sdgmac holding settings for the
> gmac controller.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/include/asm/arch-rockchip/clock.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index a9921fbb6e4..533f8bd89eb 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -39,6 +39,8 @@ enum {
>  	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
>  	ROCKCHIP_SYSCON_VOP_GRF,
>  	ROCKCHIP_SYSCON_VO_GRF,
> +	ROCKCHIP_SYSCON_IOC,
> +	ROCKCHIP_SYSCON_SDGMAC,

These are not really needed, the gmac and pinctrl drivers get these
syscon/regmap using the phandle from rockchip,grf/php-grf props.

I also have a very slow going work-in-progress series that eventually
hopefully will drop most if not all of these syscon ids, see [1].

So please drop this patch.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/optimize

Regards,
Jonas

>  };
>  
>  /* Standard Rockchip clock numbers */

