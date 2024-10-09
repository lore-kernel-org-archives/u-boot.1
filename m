Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19085CEDD89
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 12:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0E888F42;
	Wed,  9 Oct 2024 14:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGtE+xMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C354C88F3D; Wed,  9 Oct 2024 14:31:58 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC33788F42
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 14:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so68505945e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728477115; x=1729081915; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ikV6PK34Vn+zzLBhr/sUb4yOrykHBCGa17CCWvgX/JM=;
 b=RGtE+xMovT+x6pWl0TorBqNBk+uEi1vybSQyTN4t15HisXozDTDWnRqJNFIjZmcucF
 uP0xlCaNPhdEhD0FSzPc3S8b/yd55+TfNrEc6IbOwvSulW0ZUTcGcbxcjA0NiRR5BqSy
 UKQrRDzssjSvUndOrjxxMSfRVUt8msw0Mv8oczMByl74IydAtDX1mSkuaEgfBo9nAJVx
 vKqCq1m0gYAevzSLcYb4DKE6bS1UCIH9TWOx8PBKPgO6UXsIr5g9xeh5mdjT359+U3th
 2ezO3MvqIvyS13pyNJ/OfqzabbbliysIbFkhy1FFmMVcaOo2WoMNncqepmAe61X70uJh
 baJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477115; x=1729081915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ikV6PK34Vn+zzLBhr/sUb4yOrykHBCGa17CCWvgX/JM=;
 b=BmVWDZkInDdJaKiOKE/s1Dzv0RnIolSM42XeSMasfatTiPGjCEWKeOUoANWryv5QBD
 fnVcToKEcTv3cqeG0/BGDVipYO3yTwWDfBHTqGr73ONrNt/iQvwEzvkiHbJF2ESB8SWU
 ihNWGTuRinL42iYjADBznGUwFmKDP5ZSP+RZ69rrug324Ad0wLLG0nPtP6+X9w/6jzQx
 Sw8PlKloNYbdx43hVyfOrzmQDQzXxN1G1AIPDYXaAJVI7AYTl0tyk7RoV6SXVndIYHPN
 7dU3r8zyJeoTWkpJjvlZlU5Jz4FWSAT35tOZdz8J6i48Q+pNwHh25Gx733KpWnI7tMLB
 cfgw==
X-Gm-Message-State: AOJu0YypbKNwDykNWchrC8ZI4KkGIQ+0VFo8Fk423zPLcxqNH4xKrLiy
 O6XZKMU9IZIrZx9aspoPv7hIa16pp7w9UA2ddxZIiGR1nMyxc/Y1DprHuMMkVgo=
X-Google-Smtp-Source: AGHT+IHZzpkeyJCkDJqD8OwkXg3DvC7MhrWF5Ln8epTImDFTMLJGbB/6QjS5XF+fvra/SQI7PqtSRA==
X-Received: by 2002:a5d:568a:0:b0:37c:d2ac:dd80 with SMTP id
 ffacd0b85a97d-37d3ab30ea9mr1438609f8f.42.1728477115238; 
 Wed, 09 Oct 2024 05:31:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3363:964:de3b:212f?
 ([2a01:e0a:3cb:7bb0:3363:964:de3b:212f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f767sm10294963f8f.20.2024.10.09.05.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 05:31:54 -0700 (PDT)
Message-ID: <6ab38554-07fa-4117-9bd0-0e3cd6ddf0f6@linaro.org>
Date: Wed, 9 Oct 2024 14:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/29] Make AVB_VERIFY depend on FASTBOOT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jagan Teki <jagan@amarulasolutions.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c32debd7420b430fdc6cc35695825bf01a5b7b0d.1727968902.git.jerome.forissier@linaro.org>
 <CAFLszTix5QG2mnvsrgSuFvg8vdN_7MYWjE9fA4YyXgrQLoWdxw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTix5QG2mnvsrgSuFvg8vdN_7MYWjE9fA4YyXgrQLoWdxw@mail.gmail.com>
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



On 10/9/24 03:51, Simon Glass wrote:
> On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Note: Patch posted separately [0].
>>
>> [0] http://patchwork.ozlabs.org/project/uboot/patch/20241002144845.1439316-1-jerome.forissier@linaro.org/
>>
>> AVB_BUF_ADDR, which is under "if AVB_VERIFY", defaults to
>> FASTBOOT_BUF_ADDR. Therefore AVB_VERIFY should depend on FASTBOOT.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  common/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks. Would you mind replying to the patch linked in the description?
As I will be removing that one from lwIP v12.

Regards,
-- 
Jerome


>> diff --git a/common/Kconfig b/common/Kconfig
>> index 957de0c5c02..c011ab6e820 100644
>> --- a/common/Kconfig
>> +++ b/common/Kconfig
>> @@ -850,6 +850,7 @@ config AVB_VERIFY
>>         depends on LIBAVB
>>         depends on MMC
>>         depends on PARTITION_UUIDS
>> +       depends on FASTBOOT
>>         help
>>           This option enables compilation of bootloader-dependent operations,
>>           used by Android Verified Boot 2.0 library (libavb). Includes:
>> --
>> 2.40.1
>>
