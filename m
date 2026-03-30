Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329B61061B12
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD55D83DBF;
	Mon, 30 Mar 2026 17:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TiHk54+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD1483E7A; Mon, 30 Mar 2026 17:56:59 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA91583D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46701f2077cso4299564b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774886215; x=1775491015;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XxnBElRbbDuZawtQqubpc1wU5ZO1A2PgHDWGg8PD6DE=;
 b=TiHk54+qAHygLzTMiqX63ksKLt+dWvC3Er6J4A0FJJwSiXJsoLZnAOWvOLQspP7AmP
 wMNcUgWW2egZoYuhONN3PzlWGcXvuxn6j6MD08GnXh2DpQTobzNUpNzV8AR6gc6Cr/dj
 dSm5JzX0K82vMzCSlqdJDRCH7JKKCn+cwllK2lSAg78Whc7PNgluz4j3dAQNwMc1dzXu
 p4r9JL/GSuOzgqEB7j/YfPhJ8Xj20J3nE4kJNjEYp7+opDjQKQI+m4Jkvu15Ljhnw3qN
 Vex2Vgw8KVNo9n/uAGuENvmkxfKr1rg9VHH6bZ//hqmAT3J0+n8BmWsAiveKDL4p9Jbs
 Jhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886215; x=1775491015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxnBElRbbDuZawtQqubpc1wU5ZO1A2PgHDWGg8PD6DE=;
 b=qyjwvvW42v836FexXqezhOdryfCkNJ3elFu64Vz4o/0YtXK+R6GOUkJK0n5Enrsd1t
 /v+Urotmqt6A0sHpnLrN5cU33hYlh+yBLoTesbyZ6GlaDLAN/h0dpVNNkhuiS3sgGonR
 yu5EOl/slFbrsWoiI+t4D6TE29M9vgDNEaQYrBvVNHbwBg5bqPAOQnV7Cq4p3wjgw9A8
 eyQS4EBwsVqO3YCZZw+UNqMV2+C0HtW5PBRIVRF79ThqUregFttcuxIs2otjfwv95gqM
 Hrdla0RHNsC7PSGl3yZKW/uWEtHNgyw+/QfbSo8qzbQfGPoUFa2aqddtDeoVwboLpnro
 8+wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTez7gCsXfq/Hhy98t8XizwgtM4e+3jj9FoLUBk1Ky2HY7xYaKOAEWQWymZ/T5L+uG+GWi8NI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9zdWIRVCV7l38q8s/2zwvJEP4TZkkb8unbzTMwAIvMff1jUxI
 uaUI9RDjnDytMOsHV1lA4pXh6icrqn9867XvRh/m3QO6IynQOVKaIIZPwUaDuM/FVto=
X-Gm-Gg: ATEYQzz3510IdIFeSMAVa2MZX832uYyizK+u/pIVudkjUAR1m/RaDBM6j+ACE3+DVDH
 k4vhLzuyiHhWw2s+q7jr8U9ii/hOA1fTF9UcOM4VTKnxglmDSSJNi+dymVQzHelzBXz2h9FyAno
 ox93PfhSqyDjR6sVMqiO5oIkXpJWdcOu6lseT7Vk4Nw0Dtto2rEOpxo/4dPfO3zaKLDQcycASWk
 gjLuLSoJjddf6Vjpk9COnbHGWTZLYPaCLhoF5kjZzQuNVSv5z1GVjv/eeMslIaxRiuinB1wzjgr
 vwfasmKBrYCd1cX6+row4sn0LMeFyD8MMhaoXqEBFQ+2GxVn7fCPPlD7/uSYcRsI39P1SovLvrN
 /9ZzmUV8lUonRVpx+fewceENacItcwO04k8NCZzEJpdPQMR3RZKuUhcohJWVkDTJ7bsa4CSC3fT
 u87Eh1/sxn+OaM+uhfrvT4yP+ssiXmsy6EdXQOjLtoz9+of+fug+m9lLAFCt97SKopMFmk/v4lr
 Q==
X-Received: by 2002:a05:6808:10c3:b0:468:698:a626 with SMTP id
 5614622812f47-46acdc971demr39919b6e.22.1774886215167; 
 Mon, 30 Mar 2026 08:56:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a67f:a092:38d7:379e?
 ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a33546csm6767009a34.1.2026.03.30.08.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 08:56:54 -0700 (PDT)
Message-ID: <d88064e7-75d6-4fa8-83bb-ffd9d6374551@baylibre.com>
Date: Mon, 30 Mar 2026 10:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-6-19dd92f4543f@baylibre.com>
 <CAEHHSvanPwLr8GyUrCO1Pmo=PuS1Ymy1wmzdwXZeGW2KBiTagA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvanPwLr8GyUrCO1Pmo=PuS1Ymy1wmzdwXZeGW2KBiTagA@mail.gmail.com>
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

On 3/30/26 10:21 AM, Julien Stephan wrote:
> Le lun. 23 mars 2026 à 21:18, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>>
>> Add basic defconfigs for Genio 520 and 720 EVKs.
>>
>> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  board/mediatek/MAINTAINERS             |  7 +++++++
>>  configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++++++++
>>  configs/mt8371_genio_520_evk_defconfig |  4 ++++
>>  configs/mt8391_genio_720_evk_defconfig |  4 ++++
>>  4 files changed, 49 insertions(+)
>>
>> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
>> index 446a9e8e53c..4f371592059 100644
>> --- a/board/mediatek/MAINTAINERS
>> +++ b/board/mediatek/MAINTAINERS
>> @@ -1,3 +1,10 @@
>> +MT8189/MT8371/MT8391 EVK
>> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
> 
> Don't you want to add yourself here? Since you have all the boards to test..

I don't know how long I will have them. :-)

And now that we are custodians, we should be getting cc'ed on all
patches anyway.

> 
> Other than that, for the whole series:
> 
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> 
> Thanks
> Julien
> 
