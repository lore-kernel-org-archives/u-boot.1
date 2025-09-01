Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F0CA1007
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EB183965;
	Mon,  1 Sep 2025 17:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="miXGIZCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A732583990; Mon,  1 Sep 2025 17:08:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C01D831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so38717155e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756739331; x=1757344131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mJ5VttNbIrBlM+AR4WUUDXB4mPB3XO4pLQTYjaCXrOc=;
 b=miXGIZCre3hoE7Cxx8dup7tqlN4oFprqOL0hg0oY9+kbOMlXWNvYVhQJS06DzTC9za
 4kHrb8ugmOIPs6KylYHIoa2s53zjASvSXXbLwoet9VOIe0YYIMWS8R4VEl1JEAoicIat
 Uewh3Ob9Ismfqz0Txw8I2RaKyhX89CuyqCHJgDGmzHeH4mU0Q3XOch5G+SOZMKSjHYFm
 lRlh4SVeWBIZ5IjZJQZ8r2Z+ZbO7BGDQ+4nb+xFBecWiVP7TvxEScPiZcTO7fx7QXBAP
 nKz4GCbeAFlvfI5pGB4o0dhX8J6BZpzpfsn35GnF+iK5KS6rEhuPfdi9kipQkf8CZpCZ
 NwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756739331; x=1757344131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJ5VttNbIrBlM+AR4WUUDXB4mPB3XO4pLQTYjaCXrOc=;
 b=DSxfF//6RUFy7+NYjforOQvrqYWCCEzjIJSa2cDF+gOUMMP+9jgcTsT42I7mFXEoQO
 zrSW16htzY6KNia8hXfjG5gLGzTX9DPdz+cvLEkHxvzF+JcruJgcJjsUS1fNDJ0AsnVY
 6BkxtOToYo6uyn8SXVoKK7qkmv/Gey0nRCFAjVMtu0NetlvbkF9DX5mLw8h8xQLrH9ge
 2Bi1ct31Pwqv3rLg2YDjf6pw89p4QyFQ84zbqFDfL5BvrdcRoN5f2IS4N5cQtwEBIEEw
 LXZR+8fPDLpiFDpVpxdyfMZqmCAJvH2aSljz9gI+sohA/OUDsU+/oQRVF4FAx9KhX59V
 tUmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+0hqDG8n3e0560Z171/wheNcpoYxlOcwRv6N0Ezy7sR2Zrs+Ha9A2IWAl+expBrOBNcdw1wo=@lists.denx.de
X-Gm-Message-State: AOJu0YzJk9z92ZMxBQZRzijLJl7o6yzSYT6sXeXILkxBSwFawlBtE2po
 azy3E+N/dn5r10m+2I1nIC2622lqo7IOXU0otuorfWNE/NsutMACqbUFUdHXLu/pRmQ=
X-Gm-Gg: ASbGncug0HuCaqjswQn2omljBjxFS1D2KxTMsEI6KlpjjBM3RR7+HgPF1U+OdPlh63S
 dYCUFb98pipdIxKXX3Ev2iI5OAiTO0TTGEIhV/YzYJkIDFH/gNSOD0QQsZnOX/wQwgAK8ZAqRct
 2OrU4m1z+8mbu/hB4RkcVHjrg4DfbsY9eLX1WnIQAzpj1YR7DBeLNcWzBlc+wfdpQHWIRIbLTmd
 gRjqVyMGV6pnzYIw34GWI75kpsSWEYSyeorNeGKyKImaCXJC0aoNNV9cAPmdspdGvOXu7EUW/cf
 GO7lDlOVBAEW82phWI+dui70TAzIv7PQOJZy4vRQKbOwW5D0QpF7gDcC8xiBZVBxSIqWuQ56sRd
 oovehrWUe1S5b4qAQs0DlDr89PzjHplEyDbmm/9Q4eg72zr+aFt7eADbN2rxTpAsy5S12DaJgfk
 6Tdw==
X-Google-Smtp-Source: AGHT+IHqsh+0D8obqszFQt1W3G/EriCaOY9It6w97KCXe2I49mF/umEf1fmVErTt3bwNWMUiKmvvcA==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45b85550704mr69044175e9.4.1756739330677; 
 Mon, 01 Sep 2025 08:08:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986?
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d23b7sm159987945e9.1.2025.09.01.08.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 08:08:49 -0700 (PDT)
Message-ID: <f192cec2-7796-48cf-83dd-9c31fdc4dbd7@linaro.org>
Date: Mon, 1 Sep 2025 16:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: exynos: Remove extra term from test
To: Minkyu Kang <promsoft@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250812-exynos_spi-v1-1-bd0813ff6593@linaro.org>
 <CALrBrZ3GHjVGWvSrn-oeDAycRv=h_1vMcDeeNvX9V6peYOXMfQ@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CALrBrZ3GHjVGWvSrn-oeDAycRv=h_1vMcDeeNvX9V6peYOXMfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 25/08/2025 03:17, Minkyu Kang wrote:
> Hi,
> 
> 
> 2025년 8월 12일 (화) 21:01, Andrew Goodbody <andrew.goodbody@linaro.org 
> <mailto:andrew.goodbody@linaro.org>>님이 작성:
> 
>     In spi_rx_tx there comes a test for execution of a code block that
>     allows execution if rxp is not NULL or stopping is true. However all the
>     code in this block relies on rxp being valid so allowing entry just if
>     stopping is true does not make sense. So remove this from the test
>     expression leaving just a NULL check for rxp.
> 
>     This issue was found by Smatch.
> 
>     Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org
>     <mailto:andrew.goodbody@linaro.org>>
>     ---
>       drivers/spi/exynos_spi.c | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
>     index 1b9bf004b7c..d11952afe5d 100644
>     --- a/drivers/spi/exynos_spi.c
>     +++ b/drivers/spi/exynos_spi.c
>     @@ -166,7 +166,7 @@ static int spi_rx_tx(struct exynos_spi_priv
>     *priv, int todo,
>                                                      stopping = 0;
>                                              }
>                                      } else {
>     -                                       if (rxp || stopping) {
>     +                                       if (rxp) {
> 
> 
> then, isn't the stopping variable no longer necessary?

Yes indeed, thanks for spotting that. V2 coming.

Andrew

> 
>                                                      if (step == 4)
>                                                              *(uint32_t
>     *)rxp = temp;
>                                                      else
> 
>     ---
>     base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
>     change-id: 20250812-exynos_spi-8172ecb31a83
> 
>     Best regards,
>     -- 
>     Andrew Goodbody <andrew.goodbody@linaro.org
>     <mailto:andrew.goodbody@linaro.org>>
> 
> 
> Thanks.
> Minkyu Kang.

