Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C83ED1036D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 00:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766068416F;
	Wed, 26 Nov 2025 01:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L8/i8AQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89FC8414B; Tue, 25 Nov 2025 23:29:20 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E50A840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c75387bb27so1810046a34.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764109757; x=1764714557;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JPKMNO7/OAHj2gxP0X0kPzIOR3mIbgLvSnHjnMTxBQ=;
 b=L8/i8AQKHVpI4H0tJiQMYSoLS3bUbo0ufA/uxvfZsWT5WQ+geCVng/MHYD04Sdd35H
 90EbLE3z95FGmbh0A+I5ZQf5oFrsPNMULvzaZJzCy76G9IxZl++xk0rgmuVP7Z6hmyJ3
 dD4aDabNH9+7aVH1326nov/HI5twK03QVVznRQ20XuStlnJu+yDz4/3Z92Pb4xp9oSFg
 yH0k28k+AnArz6kfC21OC5vOeHj8l+x13ZauEiWY2k0yD9GGIejlRsRclhQGo///C+ev
 c6/Ol6J/JgWTbcXEznT+k6AewKYGImmEzB/qcKab9RytGtiQ/HuseLfwq/7gjKQcJGda
 nXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764109757; x=1764714557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JPKMNO7/OAHj2gxP0X0kPzIOR3mIbgLvSnHjnMTxBQ=;
 b=ueSo2SK3NZzzbLxEkSz4b19Fcg71crflIGf9YLJceOoDwopScYes4Lvl4jNJOtJf1T
 MT5FH2Ti8lRsbugQKdDGgIC+gGkxMAbpeNZyJfy+3rk+D+zhMKtOJJfaKypR8EoZdWAq
 mrDmJzeBXRRu3yuggsLFP7oA5oXEGYnzEbS7+ypw6tj0osUkLqeKsj1uvsn7J/zvhydo
 EkRbJVT8xXigyb8t/2JuWGVwCTUKEYM/VoGen06ggOK/w7fxdSnJFXL173C1Y3qdmkZn
 tm/jxO8TBCPYHgSz61OtTTEcQwV2qYxVHy7EF82VllGNLSBkVmJKHYci2uV4biXpY8WU
 wHcg==
X-Gm-Message-State: AOJu0YyDMiY+QgzljneskKUQlqgy2gTv2li/ZmXTWs+G96YeK9RIb8ok
 GR+iqBd2R3CkBSmvNd4SvwtYR+t8RnkAufkk1enjVfGi84aIxrQUwsylj+PGbbSqEh0=
X-Gm-Gg: ASbGncuuQJzKWHWahANSEbWpmHqEdba+sZk+2pZS3BRfuA+yQ6E+8pYBvrkUUlKQaqY
 adWtuRYGV+XRZXYHr3fCyINftuer3d3wpS99Kty3xPJCBkFKJAB7KBOVWYvzSyr9c3A/4CIWIhv
 jElbsgodEWXgEFN0lAoBBRbAs3c7E3VwQWYtrbC8Z2v0ep/DcR7oI47tA4j/hpy+hE1lkeRkiSN
 fkNxjIJdw2RG2jL+IFF2n2b/rWNILkvgNQmsgIGkxkNW8BHds6rF6/gyETDPebKJ2uJsjF0GJ47
 mOkTyc2yW3Qm+9zs922qDYcEw09Ck53NyyTfDOxr+yPwOF5kiM2Ph4gYTEvfvcJkHpzZOIvtj1J
 nEmWnBbZ90dt+cekjJ8pv1GQ6D6fSBMDYLcSQ9QxEVyit5wH44AjHVM7y07rFDGApntUMrsLTfC
 HOiGtcviIdLR+8G2dN7XDoGQtaReJ+GlGdcSKSE0VPIqW6QvJCyjML3xHr6L8R
X-Google-Smtp-Source: AGHT+IH4CLb75mDzEgyzCiLRrdGj4G0cSBpOUr3RYuLPMSE1uicYUjIhBW2UnfWW41II01uiCDsrAA==
X-Received: by 2002:a05:6830:909:b0:7c7:8280:9207 with SMTP id
 46e09a7af769-7c798ce83fbmr9978595a34.37.1764109757142; 
 Tue, 25 Nov 2025 14:29:17 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:9937:7d3f:f670:fbe2?
 ([2600:8803:e7e4:500:9937:7d3f:f670:fbe2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d428f28sm6905812a34.30.2025.11.25.14.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 14:29:16 -0800 (PST)
Message-ID: <0d1a05c3-6a29-404c-98a2-3b820bfe077b@baylibre.com>
Date: Tue, 25 Nov 2025 16:29:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test.py: check ubconfig exists before using it
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-2-bacb4148fb0d@baylibre.com>
 <CAFLszTjm94_iH5srp44mTMDJ-vJSAJMtgisBs+E=fNWk++KP6Q@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFLszTjm94_iH5srp44mTMDJ-vJSAJMtgisBs+E=fNWk++KP6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 26 Nov 2025 01:14:48 +0100
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

On 11/25/25 4:14 PM, Simon Glass wrote:
> Hi David,
> 

...

>> diff --git a/test/py/conftest.py b/test/py/conftest.py
>> index 8ce680a92a0c37f36489b0782921d6cf4078850d..f889e3d3ae26db3ae19f79e236a281471d4b6de9 100644
>> --- a/test/py/conftest.py
>> +++ b/test/py/conftest.py
>> @@ -613,7 +613,7 @@ def show_timings():
>>          if too_long:
>>              show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
>>          log.info(buf.getvalue())
>> -    if ubconfig.timing:
>> +    if "ubconfig" in globals() and ubconfig.timing:
>>          print(buf.getvalue(), end='')
> 
> Please put 'ubconfig = None' at the top of the file, then this can be:
> 
>      if ubconfig.timing:

I think you mean this?

	if ubconfig and ubconfig.timing?


