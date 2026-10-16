Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1248BCCF2C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 20:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A567981654;
	Fri, 16 Oct 2026 20:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gza6myJ84ZAs; Fri, 16 Oct 2026 20:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD37381678
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792182281;
	b=O4M9a5dUBLNyDVSdpQIVZatBb1Q7V+X64v/45pKlnFlJtyQ5+ZW0ttAR5ErOM2KRcCXJ
	 Cu/fy3FzpYCkCj3DHlJkBCvt22dldpX54MUHhslflZyYoL3tJm+YvFJPx+qE4H9Jyy0l6
	 LEo7wmUyiFpPVBiJN1EDq/ZzcE+s3NMi1QUi5Lpas4qchQgA3PTPBqx6TGvUkX2j1HqBL
	 5BsX0+JCuUXeS0LN0fYgWFbeUxhuSUb3iNwljuMcA7VU18viTSBJrFzWGfHEMkk1RSmyc
	 90W429JTBA6BHy8gztMKO1OexhEMxJY8vi5mqjGqjN8mWyqKDH9fYhLOIYAPey/u4NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792182281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7iQ5omVK6XoauehYlZiCrqIhUvnVoC4STZu18ftPx3g=;
	b=UUHq58lC9BnQK9h9NVYw82XyIozeOSpdori+ie0hGYWjKE+CZjx2VPF33OrfddFeLB+J
	 SHi61H+Pm8gaMmHkB2jk3GRanZPQvQNmgcyks/C5A3xAmLH817/AKPmKvcOM/9rs92Op/
	 zTmqbfKfWKbajYirmjXenvXn8A/HeodiJXKy8DR9p1x2FisbUy6U6gb8V6vQhjrJCgDQT
	 obtTOZPwxY13SE2J1fT4jwSduK2N7BA2hiQFhJKyZTmtdAUZ4dpnajhsr1gttPH4frYnu
	 LYzH3+bOKEEhLD4UrdlUw/WIkqHZ6xUbh4qCDKhYTzJFp7FmADm+LpJJ0ZKkiJ7apBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792182281;
	bh=7iQ5omVK6XoauehYlZiCrqIhUvnVoC4STZu18ftPx3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y7K4SClTrUb7Cq/Dclg9Jcgv2eLwF0acXhejvc+LVwdVygfNEZLk8PfacG7dSzAj6
	 cHFcFTkE9OTZfCYg8sz743JO8rsaKDhu8s5sd4+6CbKa5XoUnm+wf4oOiBZShkwz7p
	 aqQ8L3a5pQEkqw2PS/KO0iOKHHPm1JcSRwxCbL+7Is8oE8xSz8tUdLPMiFvWMq/REP
	 DirB1R3sHqodd2Knl2004syLzPlcXoPFKZz+1HoQXME23bDz743lqZQar1zFWHGDYs
	 I3+w9tjWAsmwzyyFY8UV0Rlh1im2qZ9PukfT+CG0AM4kM7kaIuaTrhwDLw63JRbdmq
	 t9CGxva3lMUJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD37381678;
	Fri, 16 Oct 2026 20:24:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 974B91DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 887C5409C2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oPd0GdrKp9qt for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 20:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72BA34094A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792182278;
 b=eYmIFvcCzItfVn/exR5rNiL+6UtD3cWq8WYJXhFjpSf5zzu6r2PZ3uo5MZihsqYfPg2c
 Yr5jElEyiYKd4pnIIWSD12TiAsOWf52oyuL+zjzXT+kDroyyNwK8cWy6Ni492xsvX2eKb
 8Bd6QkKI/ajswiJ1U9Qmq6D8TYf4uQyw9n/m8F9RQHW5ooa8IlseDy/PsPD2u6zOoVju9
 SfTDPzyKv/rW7JaRZ0KUPyXTLP5not6EngkYURLJdRK63uOdwsHQlJlcQz+afBLZCG+GJ
 3tnRzFaDEBYyqeNEh78APIAmlzmFY4SjwDcs08s2Xd+7LLXevuQWYI6NHwPkwwCQcfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792182278;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=7iQ5omVK6XoauehYlZiCrqIhUvnVoC4STZu18ftPx3g=;
 b=WZh4OnMOCYKheeTP0b/Gvm82rGYd2KvAlNUyX/5MYyPVQeWwsFyLh8loIuIXy44zgt9m
 2oeaD6b8dTHL+xIToJE86m4wq+NmawgdVf0J9EVv+K6pl+SdJqx2Xwc2mQGay9UnLN3V4
 aP3ZGEikxVGTAdFRMuSrqoaijuVtHlojx0SWLPvXsjWH4Mst2UDbB8XsdAnuZLhKew+E9
 KM+MZdcNuLJ5sS/M60fQsI1DWF0xqyIUjQOxIQI6AsUc6yZNy3nnlo5TWqRntgR3goPrg
 OweQ5YHzXBb2sWZFtr0JYzswtn8h4Ao3L6tChAqx9b2dX1g71o0CfzQJPZk+yxCvFEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ixit.cz;
 dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim
 header.b=HU9dAWsJ; 
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:830a:f787:8f00::2; helo=ixit.cz; envelope-from=david@ixit.cz;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256
 header.s=dkim header.b=HU9dAWsJ
Received: from ixit.cz (ixit.cz [IPv6:2a02:830a:f787:8f00::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72BA34094A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:24:36 +0000 (UTC)
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown
 [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 2395E5340281;
 Fri, 16 Oct 2026 22:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1792182270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7iQ5omVK6XoauehYlZiCrqIhUvnVoC4STZu18ftPx3g=;
 b=HU9dAWsJPGMlbwEre/W8XC+D/qYqGv26Vc6eypGP29yBeVcdqZD0R+ayQdffAKvWrjQzcX
 ObnMiQP7KTBUUgI3BdJiTEDCYnMEPNtoczhMaZfsd3rYpKI5d+81Pr9hpUitoPNX7Jov1D
 qkJ9MVlPnSyuCuGbVQHCmZGWD7BWqro=
Message-ID: <ee4696c5-483e-4f57-a0ab-48cc2380e805@ixit.cz>
Date: Fri, 16 Oct 2026 22:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: qcom: sdm845: select the mux value per pin
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, David Wronek <david.wronek@mainlining.org>,
 Petr Pavlata <petr@acrux.cz>
References: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
 <20261016-b4-sdm845-qupv3-s4-v1-1-672e9be21fd2@protonmail.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261016-b4-sdm845-qupv3-s4-v1-1-672e9be21fd2@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 16/10/2026 22:13, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> The raw TLMM function value of an alternate function is not the same on
> every pin.
> 
> On GPIO 89 "qup4" sits behind tsif1_clk (value 2), on GPIO 90..92 behind
> two other functions (value 3).
> 
> Add a per-pin table for the functions in use and register the "qup4"
> function for the QUP0 SE4 SPI pins (GPIO 89..92) next to "qup9".
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/pinctrl/qcom/pinctrl-sdm845.c | 45 +++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 24b42e94c7a..bfd412d8e34 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -18,9 +18,31 @@
>   #define MAX_PIN_NAME_LEN 32
>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>   
> +enum {
> +	FUNC_QUP9,
> +	FUNC_QUP4,
> +	FUNC_GPIO,
> +};
> +
>   static const struct pinctrl_function msm_pinctrl_functions[] = {
> -	{"qup9", 1},
> -	{"gpio", 0},
> +	[FUNC_QUP9] = {"qup9", -1},
> +	[FUNC_QUP4] = {"qup4", -1},
> +	[FUNC_GPIO] = {"gpio", 0},
> +};
> +
> +static const struct {
> +	u8 pin;
> +	u8 function;
> +	u8 mux;
> +} sdm845_pin_muxes[] = {
> +	/* GPIO 4..5: UART9 debug console */
> +	{ 4, FUNC_QUP9, 1 },
> +	{ 5, FUNC_QUP9, 1 },
> +	/* GPIO 89..92: GENI QUP0 SE4 SPI */
> +	{ 89, FUNC_QUP4, 2 },
> +	{ 90, FUNC_QUP4, 3 },
> +	{ 91, FUNC_QUP4, 3 },
> +	{ 92, FUNC_QUP4, 3 },
>   };
>   
>   static const unsigned int sdm845_pin_offsets[] = {
> @@ -80,10 +102,23 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
>   	return pin_name;
>   }
>   
> -static int sdm845_get_function_mux(__maybe_unused unsigned int pin,
> -				   unsigned int selector)
> +static int sdm845_get_function_mux(unsigned int pin, unsigned int selector)
>   {
> -	return msm_pinctrl_functions[selector].val;
> +	int i;
> +
> +	if (selector >= ARRAY_SIZE(msm_pinctrl_functions))
> +		return -EINVAL;
> +
> +	if (selector == FUNC_GPIO)
> +		return msm_pinctrl_functions[selector].val;
> +
> +	for (i = 0; i < ARRAY_SIZE(sdm845_pin_muxes); i++) {

you can use C99 for cleaner code, e.g.

for (int i = 0;...

series,

Acked-by: David Heidelberg <david@ixit.cz>

> +		if (sdm845_pin_muxes[i].pin == pin &&
> +		    sdm845_pin_muxes[i].function == selector)
> +			return sdm845_pin_muxes[i].mux;
> +	}
> +
> +	return -EINVAL;
>   }
>   
>   static const struct msm_pinctrl_data sdm845_data = {
> 

