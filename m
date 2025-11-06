Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB74CCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 09:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6091583B4F;
	Thu,  6 Nov 2025 10:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWvxspFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F4A83B5B; Thu,  6 Nov 2025 10:22:18 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AFA83B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-33292adb180so765025a91.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762420934; x=1763025734; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPUxFg88tl9aLQAvtXb5+tt46zLL4Wli/6i+yrT+LmI=;
 b=BWvxspFO5tpoe7ini7lZgASCIjO4aCj3xK2KgwrwhApzuLxETcJDbxIukC6+35IcIT
 Gc2NGWczfa/sb3d7CgYq9w6peSAHl9eTsYWTI/2wKW5DnuBCbBCqQyQ7nSddvm5DMpqk
 HLGkf1qcsCyB/x7nmBwZWG2M36X6ukmfkSGSB2dxenKOaQhRO45KoufqLoA9+E7vR2XF
 HNbPkaHaGmC5VuuRorcXbU6ZL5kCCVXSRGUdlq5AAPqRyrAC+/7ZhP1LtsqRbddhWWb8
 NqGi67MTJ753DP65huuLxgH3YIAkvgfrpa3W3D/RaZYkJqaspmIYmwfuCk0iQIoKvnNF
 su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762420934; x=1763025734;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OPUxFg88tl9aLQAvtXb5+tt46zLL4Wli/6i+yrT+LmI=;
 b=KOItZBUCfdLCeAdkxWb2/bXZJ4jNRDtj1fY+EXHfTq2fCMaZip6Tf3ViTc3bNmczbL
 w4S1N42VGm0jiI4wvfMDlips6H5eVjqFiq3TzmNjg9I67xt040zPivUwMOeUn3xgzNK8
 tmNpMjHRenC5rxLKHX/OzyNaedbHbkEzDuoXe9+M+Qxzfz0eYhoVP5zZryV0qoNNEG4j
 flug5fgJ1E3iWOpQ2tGvnxdMuGFPnNoNfaIYSR7Y2hgTU3IJ7itRd1uRC5XsZKgJmBLd
 4C0XtdBPLUH214ZeVKSSi1mGg358KaF2F9ZrclDguBQ4nkb/1uxutY47RABrmiDk51RT
 foxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFhc8T4F/kejwgrBSsMdXZzPiOGN/RaIjgDNR+rjyBZAWoBTk/jSLNPxKfrOz+m179L2DrYj0=@lists.denx.de
X-Gm-Message-State: AOJu0YwSse/yCKSYFf1KSEQmjvslwP4tpwGB01mOiKOU8+r6EsBfefon
 2kJ0RPkBGgyMm+k/7pDFLT6aPAUJGyFMC8Ng028ACAP/NdQjHg9NuZr2
X-Gm-Gg: ASbGncuTMKeTFi3GTjZN42K/crotBOfXk2difVR87m7YyMXbp5vQY4+hhNCulmNJma/
 HKc9ohjyag423Iw2CbXH3VH76stcTTZXP5BO4bHadGaGHZYETOIB8cMxsvsgPRm+z3hU9NJdtNu
 Deb3m+U2tV6JEkQCdJ2BK9n9S2p8Ah1zfx9ckwitakqIaIlZ9BLDc7kDckABYMTyeFacapNGK8P
 nnLlPxmZqgdnOkz730wtGQ5PXk1s65lkUfXbNJ4Nz6EJIAvZkLL3edm0fSH67E2g2XptQkLIGCz
 yCMsJ91/Xj0ZV7T3OjR5VCkROWRGVjLl2yn40ihoBZJ1ikfQW8ttfsqwP2K+iaV4sdT4jZtbapk
 lL6ldd/cWeoS7P4+SKw1BO2fhxl7lGk+NHcRGm1Xo8AwbxLGOtTU7
X-Google-Smtp-Source: AGHT+IH6r0BWCg9gyDzS3y7GK2Quny9Xu2sl7qzwuB9EKONc7MBVLJo4X7c3YZkECzWG+aT24T24RA==
X-Received: by 2002:a17:90b:5104:b0:341:3ea2:b615 with SMTP id
 98e67ed59e1d1-341a6c43868mr9030840a91.15.1762420933431; 
 Thu, 06 Nov 2025 01:22:13 -0800 (PST)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341d125c93fsm666546a91.14.2025.11.06.01.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 01:22:13 -0800 (PST)
Message-ID: <7619d309-070e-4bbb-bffa-0f4cf225f74c@gmail.com>
Date: Thu, 6 Nov 2025 17:22:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
From: Tianling Shen <cnsztl@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250613224343.3521820-1-jonas@kwiboo.se>
 <6ae3eab1-3208-4317-8ae2-5f5cac1e2dfe@gmail.com>
 <dcbc1f40-f418-459f-9696-b39d22d63180@kwiboo.se>
 <bbde8b7b-fa1c-4526-845c-849ea1510c2d@gmail.com>
In-Reply-To: <bbde8b7b-fa1c-4526-845c-849ea1510c2d@gmail.com>
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

On 2025/10/31 17:40, Tianling Shen wrote:
> On 2025/10/31 3:41, Jonas Karlman wrote:
>> Hi Tianling,
>>
>> On 10/30/2025 7:12 PM, Tianling Shen wrote:
>>> Hi Jonas,
>>>
>>> On 2025/6/14 6:43, Jonas Karlman wrote:
>>>> Writing to eMMC on RK3528 is affected with the same or a similar issue
>>>> as on RK3588, where eMMC must init to HS200 at least once to fully 
>>>> work.
>>>>
>>>> Trying to write u-boot-rockchip.bin to eMMC fails with:
>>>>
>>>>     => mmc write $fileaddr 40 5000
>>>>     MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>>>>     0 blocks written: ERROR
>>>>
>>>> For U-Boot to enable HS200 mode the mmc-hs200-1_8v prop must be defined
>>>> in the device tree. Linux does not seem to be affected and is able to
>>>> detect and use HS200 without this prop.
>>>>
>>>> Enable use of HS200 and fix eMMC write on RK3528 by adding the missing
>>>> mmc-hs200-1_8v prop for affected boards:
>>>>
>>>>     => mmc write $fileaddr 40 5000
>>>>     MMC write: dev # 0, block # 64, count 20480 ... 20480 blocks 
>>>> written: OK
>>>>
>>>
>>> Sorry for the noise.
>>>
>>> I recently got an E20C board, and I ran into a very stange issue, the
>>> U-Boot throw errors with any mmc r/w operation, like `boot` or `mmc 
>>> erase`:
>>>
> 
> <snip>
> 
>>>
>>> I tried to use the generic-rk3528 configuration, and it seems to work.
>>> After making some tests (about 50 times reboot/reset), I found the eMMC
>>> works fine if `CONFIG_REGULATOR_PWM=y` is disabled.
>>> This is a bit weird. Maybe disabling this option just hides the real 
>>> issue?
>>
>> Interesting information and thanks for testing!
>>
>> Without REGULATOR_PWM=y the cpu and logic regulators will keep their 
>> reset
>> init values instead of U-Boot trying to configure these pwm regulators.
>>
>> The generic-rk3528 target does not include information about any of these
>> regulators so they would keep using the reset init values.
>>
>> There could be two issues related to this, first both the pwm regulator
>> and rk pwm driver are not fully aligned with Linux and round values a
>> little bit different. I have some local work-in-progress patches that I
>> should complete and send out to fix this discrepancy.
>>
>> The second issue could be that the logic regulator should be configured
>> with a higher regulator-init-microvolt value so that U-Boot do not
>> re-configure the regulator with a lower voltage than it has after reset.
>>
>> Did your testing also include the "mmc: rockchip_sdhci: Set xx_TAP_VALUE
>> for RK3528" [1] patch?
> 
> Thank you for the quick reply!
> 
> I tested this patch and it works like a charm (30 times soft reboot + 10 
> times cold boot).
> 
>>
>>>
>>> Here's the build information:
>>> U-Boot commit: 4cad9faf8d28 ("MAINTAINERS: update my email address")
>>> rkbin commit: 74213af1e952 ("rv1126b: bl31: update version to v1.07")
>>> Build command:
>>> make CROSS_COMPILE=aarch64-linux-musl-
>>> BL31=../rkbin/bin/rk35/rk3528_bl31_v1.20.elf
>>> ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.11.bin
>>
>> I will make some runtime test on my E20C using these as a base and see
>> if I can replicate a similar issue.
>>
>> I have also pushed my local pwm-regulator/rk-pwm relates patches to [2],
>> they need some re-work before being ready to be sent out.
> 
> I have tested this patchset, and the eMMC works as well even without the 
> rockchip_sdhci patch/commit applied.
> 
> I will make more tests these days and report then ;)

After 300 times soft reboot/reset, 70 times cold boot and 30 times mmc 
write + erase operations, the eMMC works very stable with the 
pwm-regulator/rk-pwm patches (with commit e34dd9146b29 "mmc: 
rockchip_sdhci: Set xx_TAP_VALUE for RK3528" reverted).

For the pwm series:
Tested-by: Tianling Shen <cnsztl@gmail.com>

Thanks,
Tianling.

> Many thanks again!
> 
> Thanks,
> Tianling.
> 
>>
>> [1] https://lore.kernel.org/u-boot/20250714203410.1782783-1- 
>> jonas@kwiboo.se/
>> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/ 
>> commits/rk3528
>>
>> Regards,
>> Jonas
>>
>>>
>>> Any help will be greatly appreciated!
>>>
>>> Thanks,
>>> Tianling.
>>>
>>>> Fixes: b112a44531cb ("board: rockchip: Add minimal generic RK3528 
>>>> board")
>>>> Fixes: ccbddf645310 ("board: rockchip: Add Radxa E20C")
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> Kever, Tom: Please consider this for the v2025.07 release as support 
>>>> for
>>>> RK3528 was added in v2025.07-rc1.
>>>> ---
>>>>    arch/arm/dts/rk3528-generic.dts            | 1 +
>>>>    arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ++++
>>>>    2 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528- 
>>>> generic.dts
>>>> index 792d3e04a4cb..3f6f0bed108d 100644
>>>> --- a/arch/arm/dts/rk3528-generic.dts
>>>> +++ b/arch/arm/dts/rk3528-generic.dts
>>>> @@ -18,6 +18,7 @@
>>>>    &sdhci {
>>>>        bus-width = <8>;
>>>>        cap-mmc-highspeed;
>>>> +    mmc-hs200-1_8v;
>>>>        no-sd;
>>>>        no-sdio;
>>>>        non-removable;
>>>> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/ 
>>>> dts/rk3528-radxa-e20c-u-boot.dtsi
>>>> index 9c2f03a786cf..1372d8f1e38a 100644
>>>> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>>>> @@ -2,6 +2,10 @@
>>>>    #include "rk3528-u-boot.dtsi"
>>>> +&sdhci {
>>>> +    mmc-hs200-1_8v;
>>>> +};
>>>> +
>>>>    &sdmmc {
>>>>        bus-width = <4>;
>>>>        cap-mmc-highspeed;
>>>
>>
> 

