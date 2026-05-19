Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD45CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9AC284705;
	Tue, 19 May 2026 16:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="B8fJR78l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E9284843; Tue, 19 May 2026 16:09:30 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C20F846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-484ba8bc89eso2246875b6e.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779199767; x=1779804567; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YSknIunbxI86riwnbP+VhULjLUOZkq3uWPVWlpp9i40=;
 b=B8fJR78lCj1dcuENA5wC4Dfyc2Np78HQTWycLKkg6nrZ7upKn8Fkngc+qxyatApjvY
 +B13lwehMMDTt8Lfz8HzEeeD3KSiUQ/VjsGgCbPHJooI2zzONy+P8BWE2h21Mg2Yw24m
 xLnIRC0/CGITN0vx5yj/V4pksM+4bTQOunjgwq59yS9G2xZFxQfVPApVJv92wKqp0jko
 jg9kT4CYq3WXvJ7seaN1MewTyjR1uQdmSR2TkcvUtROmKDdnGbvugNfEuiKQiBKqxiNp
 ZlTl30gkW33fFesPQ627Qz0TqzVOTmnqefEg23YIwAOSWGMioYqbJ5cdJ4i4K/KvEfAu
 QvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779199767; x=1779804567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSknIunbxI86riwnbP+VhULjLUOZkq3uWPVWlpp9i40=;
 b=BKLSPHjxB+BphGJI5gDLVv2HjrMvJ0lAxnCROVsnyiLYhuSOwL0RLFjvV4Oho6JHWA
 m4ACnDD//KNpSQDQ5MVkxYnKy6bu33QZ7MQtau4wEXoaHoc4K/s5mhklXDwWOkQctMnx
 OXvvm6WHZ/IZ6GGIrAlKwIZcJUKw0IiY2TXzgZ1FKv7boxllqP7YNG51OutUdYjFBuH0
 mSON+v6J/RsFDU3hFmsL/6yqDFccxsjZ4Q/ctjrzrGPWbXdXK/pK1AdLGJ5IZ3PyqPwP
 5oBP8D6oQtRnB4/uWMrMPw7dARiNTjX16jFBPOsOWJe4IvVVtXjgZNvpzc3Aq6mZPypF
 gGxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fIyFdplSqlYOETiI4K8nfIW5B4NponAGKdKOfwHBY2V8OyB59DuH6jEEDbi+foFOtJKwXD4U=@lists.denx.de
X-Gm-Message-State: AOJu0Ywk/JoVO6JCnCv3DQViNf0E0+OqU+WEZETz7oGjD5n0m/Ihs/US
 Li/OJFqDG/CteKfw5mfYyxCsp9YuHqH4snhIoxOk6XOopAeH3v+ej32m8iwIidZkRu5V+Ktix1D
 cjjlZACE=
X-Gm-Gg: Acq92OHiCiPBsMVBMGwQZyAIwoTGIoK/1fR2JdBgZluXQ/johlu2/tUV7xFa+tWjSpE
 KkcXT4i52JPsbzIfjZ7nhQ66AYcqo8g/MwxObbvuy7hs4I3GeyLxumInsV24+PCoxKR28AGznog
 t8APOOesOnYqDJhVlBEa+A8B06skxJ4fe9y6KODygqxZrN8uJDBgEAp1vIr4PVju0eaOtNgagFX
 uvBlVWkhLi4JH00yoNahOJdil0Rc14vzWd1fOGF5VGrC1fyJ1KRIcurRX97ZkSWveGlPAuyxri7
 +xtmLoCq00RW0CnADwe4aQeMrPjsUUJODckGvkaC6J0HWOzF2TAYNNyKr1UDAQFH7urge5ojjkn
 dapSf1e03fv9VOOSoYOyBBChp4tNIoafbNDCQ2+B082FLIknFKoXRqk4RQ57NoRappOQ+9Wwu+5
 8QlAqFHU2EA0ZgH/TPCf0OC+41URDD3i+VOgZdKtmn1aqtYOCslnoAKOeJNjvbG1LX9HrFpmRzt
 Q==
X-Received: by 2002:a05:6808:e3ca:b0:467:27d2:96a7 with SMTP id
 5614622812f47-482e5613d70mr9463358b6e.15.1779199766694; 
 Tue, 19 May 2026 07:09:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:73eb:68af:d2cd:c2a4?
 ([2600:8803:e7e4:500:73eb:68af:d2cd:c2a4])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm9928083a34.26.2026.05.19.07.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:09:26 -0700 (PDT)
Message-ID: <fe4af92b-ccfa-412e-8786-efc34f575ff3@baylibre.com>
Date: Tue, 19 May 2026 09:09:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: add gated-fixed-clock driver
To: Daniele Briguglio <hello@superkali.me>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
References: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
 <20260519-rock-5-itx-pcie-refclk-dtsi-v2-1-738b67857cac@superkali.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-1-738b67857cac@superkali.me>
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

On 5/19/26 6:55 AM, Daniele Briguglio wrote:
> Add a UCLASS_CLK driver matching the Linux DT binding documented at
> Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml, a
> fixed-rate oscillator whose output is enabled by toggling a
> regulator supply.  The optional enable-gpios variant is not
> implemented.
> 

...

> +static int clk_gated_fixed_enable(struct clk *clk)
> +{
> +	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
> +
> +	return regulator_set_enable_if_allowed(priv->supply, true);
> +}
> +
> +static int clk_gated_fixed_disable(struct clk *clk)
> +{
> +	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
> +
> +	return regulator_set_enable_if_allowed(priv->supply, false);
> +}
> +
It seems a bit odd to use regulator_set_enable_if_allowed()
since the point of the binding is to provide a clock that
is gated by a regulator. Why would someone use this binding
with a regulator that can't be enabled/disabled?
