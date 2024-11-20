Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6043D711D1
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 17:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0508389346;
	Wed, 20 Nov 2024 18:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="koOGNGnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFA589234; Wed, 20 Nov 2024 18:54:44 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58928912B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 18:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38231f84dccso1786819f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732125281; x=1732730081;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2mSSvYR6M3LefEAuVMqo653aoAx3Hdp8FcheopxUrD8=;
 b=koOGNGnWCJd2fkXKfry3n05P0cpYYB0Qe5gz4Ls9hf1Baa0qjKuIjFhO5ZZfTy7053
 r0Aw8wuWnZjcPgQ8QCmD/TzfSq21q6ZDAezMbk7Me2pTMP+wfWjm2v0Ats2OPq0/zJVn
 Y9O65bGqw3hIQJRNc3cixlCkPTLHNLLOECylqVj/KCJaQGjqI3P0MVMgtdBxOpjOb1mL
 mez27/BFtw7/nWG+6qd9xJfUcp3VIuBvfqlt/cpbue8pzLfxfcL2qWD/6gk4usbwwxOw
 99Z6UV/8WXSjPnfp/6l8Mxma+EuaSrLITyyP011MO1iQgCcHI2fk1GCwAOIZwFgN4M6O
 51SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732125281; x=1732730081;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2mSSvYR6M3LefEAuVMqo653aoAx3Hdp8FcheopxUrD8=;
 b=dyUOZiVX5rNw91lu2JDSdTwbo6Fg+f0zkQ/t9ygahytEVoEQYgymV/KPh+rqvocByK
 Ob1gJBl4wdjh68qpWoblEcYf2D7m4F3ei4Ha/lYcvjgrTrTjyHnGkyf09DoyxjuvdTzU
 rd+MMtZZ9hgZPmJqWeazCBTIp2E5VSsyrbFGBpyARlDe0ZjP6MqK3IUCgkQURIp9Tiiy
 ODXSXF419u0TsWlsq5XXaN+Ev0ifiVUCrHeNe+svlhFOJe40A5Rp6FHW9PQ1vJD/sIYB
 2U0bdOCm4pjkBS0nJxqkCrhsiykRt2mBYZk3v7HvGsyF2KvRRBSukx4kFrP2pCDaMuiJ
 8WTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJCcUhRLZMK9CDMLfSgyfbQn/8DILjs9pEp3KQhlicbp8JNwkfu8BGQVsuUdZJcKRCwHrzK3Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwiXKT2R24IdNhdstgVIqqOlbF3NJqYZB91hukANZl2eciPGkCu
 lPzZiRkIZ9v2BehCbfgAUzlk5NOgHOF3EbzlDPrOztZJoGiUlKi2rNaDpHD834Q=
X-Gm-Gg: ASbGncsR0M0nDBmJ9+gTxSN2E54iBNJPW1rvO37vO5tBkZ4ZmlnkQE2R32XnAM+lGSR
 xi3LvcoAAIGJ/A1Tlu0MlW0VAOVHxya+yILVlyTix58/4RWlZ2LQhuPxtDsryrUYH829ACbHsot
 lkvVgxVTLcsn8N/3GLvXoq+HzjBovDIuXaO985kcq2Ytmv7QttNv8ZjMDqMznm1+Wo7MaXPuKoF
 anABqfzJRD2XLgyLusRGxUdwfpe4wAXmaHOiL1mGaeUrTWcuDBzlohkc0nKwC9UxkQCjaVuwL3c
 4fr8oBorQDv8pDDrcx/b2Q==
X-Google-Smtp-Source: AGHT+IE9Y5ni/jOADx8OiZZLaFP32DV2Oo+q4BoE8Z8SwMZ19e2RF3iLZMLxsenE2TSChJWQSLsqtg==
X-Received: by 2002:a05:6000:1541:b0:382:383e:850e with SMTP id
 ffacd0b85a97d-38254ae5da8mr3235957f8f.13.1732125281262; 
 Wed, 20 Nov 2024 09:54:41 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea?
 ([2001:861:d40:ed60:e9ad:ffd0:5c6d:23ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254905495sm2669140f8f.20.2024.11.20.09.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 09:54:40 -0800 (PST)
Message-ID: <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
Date: Wed, 20 Nov 2024 18:54:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
From: Guillaume LA ROQUE <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
Content-Language: en-US
In-Reply-To: <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
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

unfortunately i don't find for now how i can fix issue in test.

i don't really understand with when we launch test individually it's 
working but if we launch test_ut test not working ,
I see on android test for image version 4 to mmc7 in bootflow list detected.

=> ut bootstd bootflow_android_image_v4
Test: bootflow_android_image_v4: bootflow.c
scan_mmc_android_bootdev: mmc7
order 0: mmc2
order 1: mmc1
order 2: mmc7
order 3: <NULL>
Enabled mmc mmc7 bootdev
       ab_select_slot() ANDROID: Attempting slot a, tries remaining 7
       ab_select_slot() ANDROID: Attempting slot a, tries remaining 7
Older order: mmc2
Showing all bootflows
Seq  Method       State   Uclass    Part Name Filename
---  -----------  ------  --------  ---- ------------------------ 
----------------
   0  extlinux     ready   mmc          1 mmc1.bootdev.part_1 
/extlinux/extlinux.conf
   1  android      ready   mmc          0 mmc7.bootdev.whole
   2  android      ready   mmc          0 mmc7.bootdev.whole
---  -----------  ------  --------  ---- ------------------------ 
----------------
(3 bootflows, 3 valid)

if we just launch bootflow_android_image_v4 we have only a 
mmc7.bootdev.whole and so test is ok.

if someone have an idea or can give some idea of what i can try or check .

thanks for helping.

Guillaume
Le 20/11/2024 à 13:56, Guillaume LA ROQUE a écrit :
> Hi,
>
> Le 19/11/2024 à 18:21, Mattijs Korpershoek a écrit :
>> Hi Guillaume,
>>
>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek 
>> <mkorpershoek@baylibre.com> wrote:
>>
>>> Hi,
>>>
>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>> Actually bootmethod android only support android boot image version 4
>>>> and with AB image, some old platform wtill use android boot image
>>>> version 2 with AB or without AB slot.
>>>>
>>>> This patchset add support of both version 2 and non-AB slot images.
>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board 
>>>> with 16GB eMMC
>>>>
>>>> [...]
>>> Thanks, Applied to 
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>
>>> [1/5] bootstd: android: add support of bootimage v2
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
>>> [2/5] bootstd: android: add non-A/B image support
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
>>> [5/5] bootstd: Add test for Android boot image v2
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a
>> CI has found some issues when applying these series:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>
>> Could you have a look please?
> i will check
>>
>> Thanks!
>>
>>> -- 
>>> Mattijs
>
>

