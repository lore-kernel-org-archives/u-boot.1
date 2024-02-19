Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7082CC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 17:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7256687F4C;
	Mon, 19 Feb 2024 18:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qBAZ6BAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922EA87DA2; Mon, 19 Feb 2024 18:22:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B49F4878A5
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=35c4=J5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708363286;
 bh=FLiMCA9kJ9p75qaVuQ14zDy1tpJKBjSBYcB6o8RE/wE=;
 b=qBAZ6BAqdK4LWXduQF6SO6oHKN4jzM9Kq7gMK56DThRqzEURGBrel7GjQ6VcVJcLYy7kAQc5a
 ASnUvJwQZLZ2LTsjFu92PEJ9cZ7MoWhvz1BmHbA43sPMNU230o5nL0O9+Aa+I2NomsW5itNzwZg
 O4irk9cSgA5rDhk74DQh/WcuS45Ev2H2ct1a98cdM9t3Xy9Pffhc6Kzfl6AAzVaznb7+P5JIfEr
 ROpItlq0Za8ELZ6ADMB9rDUkxcfD6C4WlDzT8beuycpomWqe9aSoN+Zl1sRSWV2RtleHqhWwNJB
 3mrAo7pSjsO3z1JRZu24TwZYFFr7dnZZOf1EswUjSUAQ==
Message-ID: <8facae6f-425b-4389-a826-8269eef92aa3@kwiboo.se>
Date: Mon, 19 Feb 2024 18:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/17] ARM: dts: rk3328: Enable VOP for bootph-all
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Anatolij Gustschin <agust@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Robin
 Murphy <robin.murphy@arm.com>, Da Xue <da.xue@libretech.co>,
 u-boot@lists.denx.de
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-15-jagan@amarulasolutions.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240117075154.58747-15-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d38e1551a7e407b4100c39
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

Hi Jagan,

On 2024-01-17 08:51, Jagan Teki wrote:
> Model: Firefly roc-rk3328-cc
> DRAM: 1 GiB (effective 1022 MiB)
> Video device 'vop@ff370000' cannot allocate frame buffer memory -ensure the device is set up before relocation
> Error binding driver 'rockchip_rk3328_vop': -28
> Some drivers failed to bind
> initcall sequence 000000003ffcd5e8 failed at call 000000000021a5c4 (err=-28)
>  ### ERROR ### Please RESET the board ###
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3, v2:
> - none
> 
>  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index a9f2536de2..5258fec566 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -68,3 +68,7 @@
>  &spi0 {
>  	bootph-all;
>  };
> +
> +&vop {
> +	bootph-all;

bootph-some-ram is better, TPL or SPL does not need or use the vop node.

I am working on a cleanup series for rk3399 and that series will include
a change from bootph-all to bootph-some-ram of vop nodes on rk3399.

Regards,
Jonas

> +};

