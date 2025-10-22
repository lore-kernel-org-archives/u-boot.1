Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F67CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 05:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF358334F;
	Wed, 22 Oct 2025 07:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XpBviR8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC4D8357F; Wed, 22 Oct 2025 07:16:48 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D9E8334F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 07:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C05D108913; Wed, 22 Oct 2025 07:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761110206;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=E3QhASqbU8YuyFc8wx41l5o/efcwkMGECKCs/xIChAw=;
 b=XpBviR8kScGkx0R3pmmhR1ey/NgCkOYWJ8h+Wx96PRwVGsCDT0i1TGdXL9fllmiEI+P3bj
 /F4KeLbWIYNMroHtnc30A20iKv7OryS6236I+LMxL2uiJVNmY9QpnitRutlRGz24OugSb4
 NjgAaLT+khU7omG5MzzRTwkmIoBSNhkZpAjfhwJR/gb/LEDC99NMMjzgJeMemtlz6VaQiC
 Ne3c4mmZ0ci1k/is+WlqkOofTwg35c/IJuRb6Ur4LsjCvxpWQMkKAkmLhMZe78yBJ6NPPy
 FJVjTirEyTjcFbLNkmXpEv66Hm7qTzQSVRA8vDjE8891t0BwxlUWVH58BvdH1w==
Message-ID: <9ba9e3ed-9317-8608-9a18-53321fe1bb33@nabladev.com>
Date: Wed, 22 Oct 2025 07:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/6] i2c: imx_lpi2c: Fix error detection
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, Jim Liu <JJLIU0@nuvoton.com>,
 Stanley Chu <yschu@nuvoton.com>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
 <20251021-clk_funcs-v1-5-acf51a40eea7@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251021-clk_funcs-v1-5-acf51a40eea7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Andrew,

On 21.10.25 18:08, Andrew Goodbody wrote:
> Testing an unisgned ivariable to be <= 0 will only detect the
> case when it is 0. So correct this error test to a working version that
> will behave as expected.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/i2c/imx_lpi2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index 4636da9f3015ec8854c471fe3041fb8560f70041..a309fd6f07ce0dad22ae49bb4414c6e331b29927 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -304,7 +304,7 @@ static int bus_i2c_set_bus_speed(struct udevice *bus, int speed)
>   
>   	if (CONFIG_IS_ENABLED(CLK)) {
>   		clock_rate = clk_get_rate(&i2c_bus->per_clk);
> -		if (clock_rate <= 0) {
> +		if (!clock_rate || IS_ERR_VALUE(clock_rate)) {
>   			dev_err(bus, "Failed to get i2c clk: %d\n", clock_rate);
>   			return clock_rate;
>   		}
> 


Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
