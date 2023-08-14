Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6DCEB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 18:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC88865ED;
	Mon, 14 Aug 2023 20:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K310soqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E500186828; Mon, 14 Aug 2023 20:10:35 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0F580770
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 20:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso28447635ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692036628; x=1692641428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HppQPKsjhF4XXnx5hKhlq+ZZMP2j4f/edK+RHkvgZXA=;
 b=K310soqxNCMdjJYgYacc5HjXAmTUgUNzTZdWWk3CysxJpySTFv7UmZnPJ0G2zf1/ix
 lwzvCOjN4Ec9UUjjMgYqbotgRbz1S9EpjssikotUCrCu+GO69sFJzTAnxUSkWnRVzESv
 pgO/MRJ5qJyce8LBzPY+cBZzdFK7V6nhz4qLipPf0NZuuNwGsCl8mmFIauddhik7d2Ve
 5HebGRagTKXVF1Xl5eDoy1dT9B9FtzFZrlV1s82MLX+Rqn37LasBa9kqpSTaB2wmiTvl
 AQX51j9rJiLacBNtVgztcC0le48UIH71aqi11wvPsczjavCF4GEnmmfJG2phjF2vbWtO
 ww+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692036628; x=1692641428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HppQPKsjhF4XXnx5hKhlq+ZZMP2j4f/edK+RHkvgZXA=;
 b=KocAucOJjQERKRQMe2T4mQSO2WBiWRgsvp3mkQrW9O9Zbi64U+d1aWXOAY15o/lo3P
 LbOx/WchSqANbv6MZWbKDcGkD5sYgBQkWkunD0nZlPec4x3330Myyqo2MUuhL6kLgF1z
 kSeeclV2A/zYcZNjwVuNRKKr9WScoIbKU5Tsl+hgj6bDSm/VWpAsMbAdeWmgwPzgc7f2
 iB/RHKwKlLF6ypqopTjrFPc7U512+q2XNb9tEm/MuS9Gz+61hwIAB3ywUG76GeNz1YpW
 0mEY0BO4QC9qPvA54LvA3g0K8XyWFV6nP/MQwZYGzJOJ7DYkVZ9Xvc9snZASgVHONSV5
 2Bxg==
X-Gm-Message-State: AOJu0YwJGRVh7bMfBti9NfSgAp/Cyb3W9YVsGDbf04tgmfpxr4Oshuui
 NNz1GrIzVQG8BflRntmpX90=
X-Google-Smtp-Source: AGHT+IFpqsHpaTWuXzHgKDf+mirYSyXnAHTlz1O/HlFMPD1VFLYx0PEnTuHXm49q3kCS11+qNFZvpQ==
X-Received: by 2002:a17:90a:17ce:b0:262:f798:b60d with SMTP id
 q72-20020a17090a17ce00b00262f798b60dmr6160485pja.6.1692036628258; 
 Mon, 14 Aug 2023 11:10:28 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a190900b00268032f6a64sm10962163pjg.25.2023.08.14.11.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 11:10:27 -0700 (PDT)
Message-ID: <1af2d8fe-0516-e67d-15b8-71248ac80fa3@gmail.com>
Date: Mon, 14 Aug 2023 12:10:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] sunxi: psci: clean away preprocessor macros
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-2-CFSworks@gmail.com>
 <20230814173714.61bd09a2@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230814173714.61bd09a2@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Andre,

On 8/14/23 10:37, Andre Przywara wrote:
> So I think we can get rid of this:
> - GEN_H6 never compiles this code here, as both H6 and H616 are arm64.

Easy!

> - We can define SUNXI_PRCM_BASE for NCAT2, I believe Samuel once
> mentioned that the D1/T113 does have such a block, actually.

Will you be taking care of this in v2 of your T113s series, or should I 
be adding it (in which case I'll need to know the location of the block)?

> - The non-existing cpu_pwr_clamp member should go away when you switch to
> a BASE_ADDR + REG_OFFSET approach, I think.

Less easy, but still can do.

> Shouldn't that be the opposite? In the existing code, sun6i and H3 DO
> program the clamp (see the "-" section above).

And sun7i and R40, as well. It appears I simply read the #if 
defined(...) mess backwards. I'll fix that for v2. As a bonus, this 
lends itself to a rather nice refactoring of sunxi_cpu_set_power() where 
I can have the if block only determine the pwroff/clamp addresses, and 
have a single tail-call to sunxi_power_switch() at the bottom. Since the 
latter function is so simple, I may as well just inline it into 
sunxi_cpu_set_power() (which I suspect might be more readable).

> Cheers,
> Andre

Likewise,
Sam
