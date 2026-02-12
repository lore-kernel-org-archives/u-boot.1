Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41B9EE36A6
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 16:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF71783A47;
	Thu, 12 Feb 2026 17:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wBukHh7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1078C83AAB; Thu, 12 Feb 2026 17:43:30 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9321A83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 17:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40ee486a76eso141834fac.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770914606; x=1771519406;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oO6+GTEe3plJj3hBKl6NKhHIH3Z6LN37ASaDWJvxTTQ=;
 b=wBukHh7mlCwpapUIF+78jxc5I9xtSKCLHyA6wgCyV94frIDkhyGh7pU83bMuTyKor3
 KD85IrhSln9NdweHIIYylHePodyOVWK/VqveK70XAhe3EAgp36f/rs3inF73DA52P4kn
 D1PJnEpv9xH8MpORxtlnmqb10+5GrOPqyuYzVMRKCZq9zk9cPKIafzX5jpoHfHrY2di9
 iA2SM+9xySuiuuettyJRn1N+X4nRHL/LLJ5s+FTFqZ6VzerRY8oBiRwcodVQdfKmaT/S
 0fxF/FRtMKgIlAya7LQ4z1qiYvRqgUiVB5Ebli6f4xcFGo8eNMNl7nEWllfJ8iS16KBB
 e6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770914606; x=1771519406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oO6+GTEe3plJj3hBKl6NKhHIH3Z6LN37ASaDWJvxTTQ=;
 b=LEWI7T2ZOZzr5ZD3Xib5i+VJnk7TUR4lysWKmVu94UBDsoUFvqNnpX0AxtJeGDcKvD
 VYD541uQsQ479LiFSkQ+8GnYJEe29xnVczkfIHKe/iiWZ5+L5d2uMdBi+icM359L3/NX
 LB2JJkGZUvLhw2C4y9BGATrBXNh1pUZwjsXdKJwoqH6mrbtdFIRUtYWm54KBIPjYBdqn
 F3hDziUifzUyGD82GRn3MoSQ2egs9uM6PgzTO6iLfsLSmTzWmTngHBlgxiRWlVWF2gdB
 ux1vEqMB/aHzhm39xBm/Ewd71bVuOo8L+8IY4F+63HB/m67OdsnfqDqkoPDMy81HXfAj
 h7SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZPFcJ0U9bMYM/njZYcwwQ1btUSI46mH5kpPVFH0AgccX/Z3STh7PJw22mn+Ww1Is+cRMNLAM=@lists.denx.de
X-Gm-Message-State: AOJu0YxnOIWw6JmsaILtQnLx0uVYbUrqTLtoNphZbrho/8fbenawCsGG
 kDxvLRBIXw1V67Wy7qJjAXyXHcg/kzRNqFDiYAZPKpALluNXQUAvx+gDOpmqVn4RR4w=
X-Gm-Gg: AZuq6aK+NIwkkeLYEKNyit2dpFTVmXrHUGl/KejTSbvaaJ9zclpfRDtvusRNX/N8Hk2
 gxCeo4+y6ynW4AzcdA2Z20bkC6kOdgIicpnhS621lp6qhV7SXgpZyXx38cURQ0vDBtWt0AO0kvS
 R+V1gpgQMehyKp2mxzmxnKeI+SSMeMwQI3U45P8/D/YAn8uHfFFgQDfKz58//GGjmA2sEM5KUBk
 njYhvQmknF6BWwMnId4qQkBXYMNRmzeHroxK8eJAPMIxe91uA4jqgHz0mg/wPjJHA9w6K5/0VdY
 kL8B1kRGTkGTRZTiL8Q5akb84a732UacVmIS9z3rXrXEY7foWjQqEXKKGluGSz/p7Ua7ySbBkuL
 5PRKVPB0j0tEB7OrAU4om0Ihz3ixKS+M4w0yuyWUICZ3ezA0fy97hl80B9C/1/yIKVBPU01HOHv
 jN3Xw6fbrWJR37MMpdSfOnnMQ7/9lTMYLyPcQXvltE6j7gNm3+Pvwk0LXrQ5q+IzFw/6puDQ==
X-Received: by 2002:a05:6870:b1c4:b0:3d1:d26e:e163 with SMTP id
 586e51a60fabf-40ec6ea16f4mr1500556fac.3.1770914606138; 
 Thu, 12 Feb 2026 08:43:26 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:935d:e139:4a1:b4c0?
 ([2600:8803:e7e4:500:935d:e139:4a1:b4c0])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm4209456fac.12.2026.02.12.08.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:43:25 -0800 (PST)
Message-ID: <2241d6aa-c979-4305-abb3-f2cce85d90b6@baylibre.com>
Date: Thu, 12 Feb 2026 10:43:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
 <f517099b1f4fcfb974d106316dd31c4826872b42.camel@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f517099b1f4fcfb974d106316dd31c4826872b42.camel@mediatek.com>
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

On 2/12/26 4:26 AM, Macpaul Lin (林智斌) wrote:
> On Mon, 2026-02-09 at 17:34 -0600, David Lechner wrote:
>> Increase the maximum number of base addresses that can be handled by
>> the
>> mediatek pinctrl driver from 10 to 15. This is needed for the MT8189
>> which has 15 base addresses.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
>> b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
>> index 15ab3c1bf07..58f13613633 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
>> @@ -9,7 +9,7 @@
>>  #define MTK_PINCTRL_V0 0x0
>>  #define MTK_PINCTRL_V1 0x1
>>  #define BASE_CALC_NONE 0
>> -#define MAX_BASE_CALC 10
>> +#define MAX_BASE_CALC 15
>>  
>>  #define MTK_RANGE(_a)		{ .range = (_a), .nranges =
>> ARRAY_SIZE(_a), }
>>  
>>
> 
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> 
> However, shouldn't this patch be re-ordered before  
> [PATCH 1/3] of this patch set for avoiding build error? 
> (However, it seems not much issues between these 2 patches).

Since the macro already exists, there should not be any build error.

I checked this with buildman to build each commit.

> 
> Thanks!
> Macpaul Lin

