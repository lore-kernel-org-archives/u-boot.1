Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A78D63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C95895D2;
	Wed, 20 Nov 2024 13:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o6zqomTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76527893EA; Wed, 20 Nov 2024 13:56:55 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 004628967A
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso40397735e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732107412; x=1732712212;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkVFgaRDwf7z4n4lpcwh4MPreti3lTKYhW0vgfPUMVI=;
 b=o6zqomTywNiILFDg9TYJVzgNArSqWkF05aOEFUUFxFv34G9DBPF2ENICgrBz8NCZzM
 4EKP8tS1MpKAdhEnSjTFmUqeab9dM34wOd+qyqQUDkfInj+m5nwqsjNIkIBvgCCg6Ox8
 3Xx57vKCB7hdmwKW92945yDMLmCWvBFKheZx6GSG3Tu6e4uPjP3XJinxEaI/tOYC/pIm
 qsjhptoen8B7fyzYSm7mLgja2RNhQ2RLV37hocCwfTaXoUfMzUzfLoqZho5dBmmc5+la
 yRBJJLaKI9AtR9YJqTe35IVPF4U47+rERSd+1Og8bPj44PUiNdkULucS98J7PBCodx1Z
 OSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732107412; x=1732712212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AkVFgaRDwf7z4n4lpcwh4MPreti3lTKYhW0vgfPUMVI=;
 b=dWgzD05jTYToU5wmlGQKSmN1cdFhMdbDLEJ8XofR2ZHDmcUwGc53M3HJr9qsCmhKOg
 slmHamF7IynQASleUdL3uz8fGNQ9WUe5A3wT3x73zAFFMdne2HiIbVm4iXWXqFE89nOe
 q5AWZ5omKlBQ46irnS2jlEkXNC0uRFvQ929RdyLQV2PRC4XZE1NupMnmSYRK5/PMr8Mm
 PEwuLCahsLZG907K3g8h8LOMRvdemJCEQWWdo1dX7/a17HhnRKVHOgNV9pUwzTUO8W7E
 xdZAjtjj9ZFTx3cnkVzKGxtl6/L6dRH7+LtFtri14mdxR9blp0TiQ1UtyT49zONUVY8F
 dZEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvAD/rxOZQ75nJ09UWl8TmesYnaTGYhCLtsy2jrNdmRwdHuGwRhwccAMBeIf6isSf5cKG95Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyJuroscuL/ZEvgtquvJe6j92HApUlweZeGnU1KJy06bufQk7sj
 DVSchZVDYTnbVXLmGrdbA4dj+Bld1MOoRe0xTKb2fy80d/gDb5PsI/UpaX/7j8A=
X-Google-Smtp-Source: AGHT+IGvb8Gp4vrSqd8+L/OVAzmvfbm/xX7sEzxiy/f5wBe97V5OWtPTIecAx/7BBjnQI6TifkuQPQ==
X-Received: by 2002:a05:600c:4712:b0:431:518a:683b with SMTP id
 5b1f17b1804b1-433489cac2dmr22961055e9.18.1732107412398; 
 Wed, 20 Nov 2024 04:56:52 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea?
 ([2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e1188sm19256995e9.1.2024.11.20.04.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 04:56:51 -0800 (PST)
Message-ID: <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
Date: Wed, 20 Nov 2024 13:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87mshvxhq3.fsf@baylibre.com>
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

Hi,

Le 19/11/2024 à 18:21, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>
>> Hi,
>>
>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>> Actually bootmethod android only support android boot image version 4
>>> and with AB image, some old platform wtill use android boot image
>>> version 2 with AB or without AB slot.
>>>
>>> This patchset add support of both version 2 and non-AB slot images.
>>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>>>
>>> [...]
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>
>> [1/5] bootstd: android: add support of bootimage v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
>> [2/5] bootstd: android: add non-A/B image support
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
>> [5/5] bootstd: Add test for Android boot image v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a
> CI has found some issues when applying these series:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>
> Could you have a look please?
i will check
>
> Thanks!
>
>> --
>> Mattijs


