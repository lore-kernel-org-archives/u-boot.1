Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC2882114;
	Tue,  1 Apr 2025 15:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jbzr9Dat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678778212A; Tue,  1 Apr 2025 15:30:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6008209D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so940579366b.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514228; x=1744119028; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DhJUiX/8hSO8+NSGskSs4YW8cpoddwdBS5NGnoanJg=;
 b=Jbzr9DatLsVJAvV055C1VR9Rc+TIh8xptEvGhX5P9xHb6vij3CPgkIqyETsqR9T1yT
 trZ2MHdWj+PniyyvkLevox9/EhUZqY709EmiSPt6gUfThv5iIl33an4/am+Qmse8vTH6
 GAWfVtiVIcl0dUeomA7eKtaaPCXpxjsjLH0qT97EQqueF4QNUmCeIKr/cqMeVv/I9z2H
 u20Ku3fVXnOPA5cy3voU5h/GdAibnF2aeUT73qhLMjMUd5WBFqoBdwfRSyo+fWHxOhMp
 JsNLhEOKs4tptZ1bxcoia9frI1Xp0k7zBsu+X75N5pHCJ85laVlscA5oVBU2hlkJBxPf
 l1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514228; x=1744119028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DhJUiX/8hSO8+NSGskSs4YW8cpoddwdBS5NGnoanJg=;
 b=t7XkhanXKsif/9lgUgH0Bhi/JqAQnm7Jrfys8KY1N6WWNT7zHhSzsLVZ78sFSIELoY
 sRhaduQbIz6uFl+xpmPxIxvfw6zFUZF6Tkt8/7F0Pe5StnzDsL9js5cKTUXEaB8/4jWh
 wGdHhR/icVKlfskLgePRflfgiiWGXdq958hZtC2sm+UxnDBnPnMHZGYNqHaPoN1vChWV
 EzcCr6O0WElBjUjiRw7cId0xRsnZZgaKDsW4F4p1zpyO880rLxgDhWOmxRxyJWn2mDJU
 fRKS5I03xwA8WXgxkpm+gLDFjavn+r2MWp+wYfHvWB3nurZPMFickwSuCE4Qv5l5ix/5
 v9ug==
X-Gm-Message-State: AOJu0YxWLoghN0eEburdUJbPAHcCsIzCgKpynBBopRCH3juFtj/JpVci
 /Mk7lBT3AN0Qn0NwMqQvNKPGNLtHnMkh6y07w+T+ht4nE4CacvhwAWREwg==
X-Gm-Gg: ASbGncvxP9bVLvfUg0AlkAT0Ps0+o/qWg7EmSf9XWQOAa00rIqBx3YMlPk1Ux5lrHns
 9rzbz0P6117hccZ3J6kxaqQesZAgv1lXeASzf8sCUJkEbcbcwUq1THwtZbt8BoL4tNxlqQpfAri
 LC+Um0rhiHImYPmS/QzB9yy4YJ0tYgWq6nzarREDOs6srOXb1vmO4kEZd7P03Spv4imxPgOfiyf
 KnaqAN04/vn32uzM0hfaLB2viGF7aeEzXPELxJsuV2whGJbGSydC7+YYP2c9eBb3N67jieuleet
 t6wy7oZrtkfkI91EuuWHq5EMt8kUKdqNc+fu+ONB55gRqlWkZ2bq86woj8OSZqD2nLjuN3iP7M4
 5YnNF9ajrDTsMyMKvSzM0
X-Google-Smtp-Source: AGHT+IGiuL02HhOzPc55G6I4MGsC0mk0HWduDZ+06e2JnOrCkupauyl7pYUfkbk90VnDUNC9wO8uYg==
X-Received: by 2002:a17:907:1b27:b0:ac2:49de:3969 with SMTP id
 a640c23a62f3a-ac738ba8dc9mr905175866b.47.1743514227893; 
 Tue, 01 Apr 2025 06:30:27 -0700 (PDT)
Received: from [192.168.0.15] (89-64-20-160.dynamic.chello.pl. [89.64.20.160])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196dc370sm758709566b.163.2025.04.01.06.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:30:27 -0700 (PDT)
Message-ID: <bae6ce3f-df88-4ddf-b1cc-dcb14bb54ea0@gmail.com>
Date: Tue, 1 Apr 2025 15:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tegra: respect CONFIG_TEGRA_ENABLE_UART* options
 on Transformer T20
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.2.I04194142897633b6272f2f235daed4f3a0b8939b@changeid>
 <CAPVz0n2qCOx6dF7DnwEdnptw1hmvbR7ky70zB6ESM7pqeEuVdw@mail.gmail.com>
Content-Language: pl
From: Artur Kowalski <arturkow2000@gmail.com>
In-Reply-To: <CAPVz0n2qCOx6dF7DnwEdnptw1hmvbR7ky70zB6ESM7pqeEuVdw@mail.gmail.com>
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


W dniu 31.03.2025 o 07:48, Svyatoslav Ryhel pisze:
> нд, 30 бер. 2025 р. о 22:27 Artur Kowalski <arturkow2000@gmail.com> пише:
>> If debug UART is set to anything other than UARTD, U-Boot's SPL hangs
>> trying to communicate with UARTD which clock won't be ungated. With this
>> patch it is possible to boot with UARTA enabled.
>>
>> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
>> ---
>>
>> (no changes since v1)
>>
>>   include/configs/transformer-t20.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
>> index 6a3d9b24036..d3a98cc5a70 100644
>> --- a/include/configs/transformer-t20.h
>> +++ b/include/configs/transformer-t20.h
>> @@ -16,7 +16,17 @@
>>   #define CFG_TEGRA_BOARD_STRING         "ASUS Transformer"
>>
>>   /* Board-specific serial config */
>> +#if defined(CONFIG_TEGRA_ENABLE_UARTA)
>> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTA_BASE
>> +#elif defined(CONFIG_TEGRA_ENABLE_UARTB)
>> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTB_BASE
>> +#elif defined(CONFIG_TEGRA_ENABLE_UARTC)
>> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARCD_BASE
>> +#elif defined(CONFIG_TEGRA_ENABLE_UARTD)
>>   #define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTD_BASE
>> +#elif defined(CONFIG_TEGRA_ENABLE_UARTE)
>> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTE_BASE
>> +#endif
>>
> Here you are actually hitting much much deeper thing. You are applying
> fix to the result, not the cause. Adjustment should be done in the
> tegra board itself with amending all existing tegra boards. As a
> maintainer I cannot insist on you doing this unless you willingly
> agree. You have time to answer till 02.03.25 and if no answer I will
> apply patch on my own to custodian tegra/staging branch.
I'd like to do it but unfortunately I won't have enought time this week.
>>   #include "tegra-common-post.h"
>>
>> --
>> 2.48.1
>>
