Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E82BC369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8CB82F50;
	Tue,  8 Apr 2025 14:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n40LfI4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C2C833FA; Tue,  8 Apr 2025 14:29:49 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0E582EFC
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso2421730f8f.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744115387; x=1744720187; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXL5TG5LubE9j8EMtnCuzdyAQb1U8xVTuSggeYio6uw=;
 b=n40LfI4X+GH7tZ9UvNfB0FnhJvU5HYaqaxOGB+94RoJUKOlci8y4cWWtNtD9iseoPO
 zcYVav5mJcwTgDrutKOQ9jS3G+nmd/ijY+V/j2JtpZ0gxyXMP8Fh+2I2LDL4lGx14G5/
 VoDDhs16DOkk8WXP07To7DUhv8u7sGrLP4Gms8z7pWQLgdkrXreO+AGj0IhvtTTQmKt8
 O1lS2qbBNbYkW8wjWvR3h1XqPIv8wAPqRvljR+JNIAE4CuC5wAOLW7E5QiEocLQ2qiLQ
 VIyXQCHk3GfCuPlCGkNjBxgkRrxENsNfCr+7hAhuRSAaVaq12Yy51zNmadqdTl9wjOgm
 zuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744115387; x=1744720187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXL5TG5LubE9j8EMtnCuzdyAQb1U8xVTuSggeYio6uw=;
 b=ZagWmGa4jfT+/iOPxfTFIXjIGGB4MOb4WBliftL6JeOXLo2FRiJ1NO+GMoIsyOecac
 KCZryp67OU8OlxiaTj0hUbI1Go9E4VgldTX9PvmX2IqZPV0SQ0JCOBTIb6eGLatIYMJp
 DOOqA744V8PD/uY0MrWxu26zI/RsiqZVFWTw7zNKJLmjHXoiduwwv+MH/ISm7peu748F
 +CGabz7xtD1EyJ3uecQ/Zfax7NQNYq+GSO/mtoO0FZfed81zRLro7bYciUFmSc+VqcLn
 cL6UyEyv2BdWwZZ5lTyuLHBgWp0edB031TA9tMqzx9Y43NJb9OVoMLKQrJM5R/N66KYe
 K/dw==
X-Gm-Message-State: AOJu0YymMeP+Tw2NSfgIqSTOuyHUVX9NxK3VUP21pVE6/Cqwp2qdzCDL
 Yfl2Tul/eycRBMfbx5+OCp7zaddDEMbO1rZhrczsKx08JVJplTBbP+BhN4qw79I=
X-Gm-Gg: ASbGnctLr7Pd58JaHTiBJ5Dpfl4X9mrVOW54RNi9Pq8koNLjm2NExMbFZgb/afRYf1r
 EeCX9nwOqoAOQm50zV8Ls62GJkI5mglEDsf2jFyw1FpWVaWf+Oz1UzW+NPDh/+4GqxxJagorm7z
 wELsSPVP/QGUB/gKyJx4RurUDCBy/IYCutRPMaaRGiHZNDbydtI7ojWllfLtHmAX99tMa5r+ljd
 sQQeqbvb2rr9XFU29R5IAmzYrYT2um3IWLAf2rxIPyaluzWhhZEu/EFD9vYWiFf+JlaMjwveeJe
 TwYE6YnAv8S7eZa3gQFSp8ckNEdEs3DVmCz0UOzeLkY/vlfvxExq
X-Google-Smtp-Source: AGHT+IEtDngaiupvZpCGxwx3nkIobKNzsFQYX0DKcNSriM+Kyc2j2sT/rrxHXBo7qDlHkcZIJyYrAg==
X-Received: by 2002:a05:6000:18a6:b0:39a:c9ac:cd58 with SMTP id
 ffacd0b85a97d-39d6fc4e711mr9009486f8f.29.1744115387114; 
 Tue, 08 Apr 2025 05:29:47 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226acfsm14529925f8f.88.2025.04.08.05.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:29:46 -0700 (PDT)
Message-ID: <a231af06-b3db-4e8f-bf5f-ce621fb9158b@linaro.org>
Date: Tue, 8 Apr 2025 15:29:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: sama5d27_wlsom1_ek: Select
 CONFIG_NET_RANDOM_ETHADDR
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250408001639.469298-1-festevam@gmail.com>
 <fe0ac3f4-6c79-4ce5-b63a-6a2b1b8c5386@linaro.org>
 <CAOMZO5AZSmcGA067EM6PuHonTQweD-HYa5yHK6Eo7H0R2izAZQ@mail.gmail.com>
 <CAOMZO5DBsrKoJytCw23h=3=0jrWAewCpbWqRVpHR=TNb08a5-g@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAOMZO5DBsrKoJytCw23h=3=0jrWAewCpbWqRVpHR=TNb08a5-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 4/8/25 15:12, Fabio Estevam wrote:
> On Tue, Apr 8, 2025 at 8:29 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> Yes, it seems this is the case, as the following SPI NOR error is seen:
>>
>> jedec_spi_nor spi_flash@0: unrecognized JEDEC id bytes: ff, ff, ff
> 
> After opening jumper J8:
> 
> SF: Detected sst26vf064b with page size 256 Bytes, erase size 4 KiB, total 8 MiB
> Net:   eth0: ethernet@f8008000
> 
> QSPI is detected and Ethernet is functional.
> 
> This patch can be discarded, thanks.

Great, thanks for sharing , other people may also have this issue.
