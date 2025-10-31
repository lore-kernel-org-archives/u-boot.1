Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB0CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B3283642;
	Fri, 31 Oct 2025 10:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQ2afoKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D26836F0; Fri, 31 Oct 2025 10:41:09 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684DB8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7833765433cso2771202b3a.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761903665; x=1762508465; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Snbk5LCa5HEupGunNzseNos56kxpcxna1xYIhh9tCI=;
 b=mQ2afoKXivvf3+yCSu3utqNqOlhnitKAbEoGAXjZIamj4kW9aWKI6WizebX3BIGW+5
 vNJ1QMJCi22NsmfK91ZQHYW5RxSI5IN3MJx30tllC9rrlk1Cunuo7ycHdeiqYbMh74i3
 Jy+0mfwiQYy8r8dkEVb6XRdQgfIuPHcE9bIES2QpMP5Odd8grkRIZEScTA4+ZxDxvaXQ
 NVWOlFllVa5nemrnZbVKblHgwJrSxT77z0A2BUZkFwi3fC0o7Y8JRvYISjQ5ficTY6WW
 EmdCEFDxomJp7O+DtqniaXT8q80tubWQKOi4QOAnRva253qo9gaApCiqLp0wXH4HJsxy
 Jn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761903665; x=1762508465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Snbk5LCa5HEupGunNzseNos56kxpcxna1xYIhh9tCI=;
 b=qhZ9OcrYQW6Ktxjpj1LFlTR3fAOsrkyZtW7kugXPO4z9K8gZINziCNJNbWH606iLZv
 gbIKcKruDAJ6gb7PGHWNso2ROHWYFb6kEJnQqr8qFzuHvo3Bkzj57frWJVLgO0oE6I5N
 yREm/uNJg5+1K8B7tVwcneN0LapjsrjCg0ePdOqY0amPqfo9MpDu6f5ItfE//o8Xv6j8
 4mSEOf+mXbTq51QYt+u2GZ6njG3Bx12ReFPSQ05ThMGddx9x1teqofZ3h6sWhpRK2eYn
 XFhMNWmByDEA9H7zwWbQMM/Jwe8bI3EQg5f3P5CM0Ysdx1ngAC1yAiuSVarH8O4tzB4z
 dSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/uKWTzatxZ685cs9DBxdHU1OrU4ixQZkTmUWj3ge02hrJLU40n2BIIMvO9ROptzo0s8zX8xc=@lists.denx.de
X-Gm-Message-State: AOJu0YyfJ/6xxHT50o/4tu4IRRUdsk4B76mre0E+wjpYRkrY7gl7iCz+
 S0FfpFxhmCLVMtCxkwbcMLTopfhOY3K0Td9N5Q7F9x3VA/tW+9+Y1kDS
X-Gm-Gg: ASbGncsnP/7UA/CnTkyv/jQLmFUH2qysUiPG+v3YH1n8f/HwDCfkV8wcHQRlCJS+Fne
 h+caMbqklDNjM7K7/KzsQUMrXgCExBMxAPwx2r5g6s8Sb607ri7Izye1fEu9mBEPGY3ffcGDJ4j
 plmn/syj7ntMmtTrwiGGb/Cu3x/a8cyNhK+LogSYZJnHn61qidW1abZWnigGZFDhrKMJ5Ugimot
 kEd0to1DIAAIGTdXMQXHPEmAVYqCmav9l8TBmzzZtkwmITxgyRTQzFI/NTuTj4v3EQ8Wk+f799F
 QSt82voPxKn6ZCHlvFLoU0zPdM8VSQnEawb42zvHRPBaYW/P36+Enw+xAdYMEtJqEKQQ1F+1bOG
 IaHqrMOsr0sEcDLDGbM8F7hWMK3qf5fgzoSp3lCU3Gy9TLJtyRpTw
X-Google-Smtp-Source: AGHT+IFEb2BNtoD5710Z0loNJRerbEJgyK5I86LJaRJkZgDQc6FFCE1+ws9RRbE1sdwfpx/IAb7q6Q==
X-Received: by 2002:a05:6a20:3951:b0:334:97a6:17f2 with SMTP id
 adf61e73a8af0-348ca75a407mr4150481637.14.1761903664029; 
 Fri, 31 Oct 2025 02:41:04 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db28d3fbsm1598601b3a.43.2025.10.31.02.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:41:03 -0700 (PDT)
Message-ID: <bbde8b7b-fa1c-4526-845c-849ea1510c2d@gmail.com>
Date: Fri, 31 Oct 2025 17:40:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Fix eMMC write on RK3528
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250613224343.3521820-1-jonas@kwiboo.se>
 <6ae3eab1-3208-4317-8ae2-5f5cac1e2dfe@gmail.com>
 <dcbc1f40-f418-459f-9696-b39d22d63180@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <dcbc1f40-f418-459f-9696-b39d22d63180@kwiboo.se>
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

On 2025/10/31 3:41, Jonas Karlman wrote:
> Hi Tianling,
> 
> On 10/30/2025 7:12 PM, Tianling Shen wrote:
>> Hi Jonas,
>>
>> On 2025/6/14 6:43, Jonas Karlman wrote:
>>> Writing to eMMC on RK3528 is affected with the same or a similar issue
>>> as on RK3588, where eMMC must init to HS200 at least once to fully work.
>>>
>>> Trying to write u-boot-rockchip.bin to eMMC fails with:
>>>
>>>     => mmc write $fileaddr 40 5000
>>>     MMC write: dev # 0, block # 64, count 20480 ... mmc write failed
>>>     0 blocks written: ERROR
>>>
>>> For U-Boot to enable HS200 mode the mmc-hs200-1_8v prop must be defined
>>> in the device tree. Linux does not seem to be affected and is able to
>>> detect and use HS200 without this prop.
>>>
>>> Enable use of HS200 and fix eMMC write on RK3528 by adding the missing
>>> mmc-hs200-1_8v prop for affected boards:
>>>
>>>     => mmc write $fileaddr 40 5000
>>>     MMC write: dev # 0, block # 64, count 20480 ... 20480 blocks written: OK
>>>
>>
>> Sorry for the noise.
>>
>> I recently got an E20C board, and I ran into a very stange issue, the
>> U-Boot throw errors with any mmc r/w operation, like `boot` or `mmc erase`:
>>

<snip>

>>
>> I tried to use the generic-rk3528 configuration, and it seems to work.
>> After making some tests (about 50 times reboot/reset), I found the eMMC
>> works fine if `CONFIG_REGULATOR_PWM=y` is disabled.
>> This is a bit weird. Maybe disabling this option just hides the real issue?
> 
> Interesting information and thanks for testing!
> 
> Without REGULATOR_PWM=y the cpu and logic regulators will keep their reset
> init values instead of U-Boot trying to configure these pwm regulators.
> 
> The generic-rk3528 target does not include information about any of these
> regulators so they would keep using the reset init values.
> 
> There could be two issues related to this, first both the pwm regulator
> and rk pwm driver are not fully aligned with Linux and round values a
> little bit different. I have some local work-in-progress patches that I
> should complete and send out to fix this discrepancy.
> 
> The second issue could be that the logic regulator should be configured
> with a higher regulator-init-microvolt value so that U-Boot do not
> re-configure the regulator with a lower voltage than it has after reset.
> 
> Did your testing also include the "mmc: rockchip_sdhci: Set xx_TAP_VALUE
> for RK3528" [1] patch?

Thank you for the quick reply!

I tested this patch and it works like a charm (30 times soft reboot + 10 
times cold boot).

> 
>>
>> Here's the build information:
>> U-Boot commit: 4cad9faf8d28 ("MAINTAINERS: update my email address")
>> rkbin commit: 74213af1e952 ("rv1126b: bl31: update version to v1.07")
>> Build command:
>> make CROSS_COMPILE=aarch64-linux-musl-
>> BL31=../rkbin/bin/rk35/rk3528_bl31_v1.20.elf
>> ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.11.bin
> 
> I will make some runtime test on my E20C using these as a base and see
> if I can replicate a similar issue.
> 
> I have also pushed my local pwm-regulator/rk-pwm relates patches to [2],
> they need some re-work before being ready to be sent out.

I have tested this patchset, and the eMMC works as well even without the 
rockchip_sdhci patch/commit applied.

I will make more tests these days and report then ;)
Many thanks again!

Thanks,
Tianling.

> 
> [1] https://lore.kernel.org/u-boot/20250714203410.1782783-1-jonas@kwiboo.se/
> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> 
> Regards,
> Jonas
> 
>>
>> Any help will be greatly appreciated!
>>
>> Thanks,
>> Tianling.
>>
>>> Fixes: b112a44531cb ("board: rockchip: Add minimal generic RK3528 board")
>>> Fixes: ccbddf645310 ("board: rockchip: Add Radxa E20C")
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Kever, Tom: Please consider this for the v2025.07 release as support for
>>> RK3528 was added in v2025.07-rc1.
>>> ---
>>>    arch/arm/dts/rk3528-generic.dts            | 1 +
>>>    arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ++++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
>>> index 792d3e04a4cb..3f6f0bed108d 100644
>>> --- a/arch/arm/dts/rk3528-generic.dts
>>> +++ b/arch/arm/dts/rk3528-generic.dts
>>> @@ -18,6 +18,7 @@
>>>    &sdhci {
>>>    	bus-width = <8>;
>>>    	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>>    	no-sd;
>>>    	no-sdio;
>>>    	non-removable;
>>> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>>> index 9c2f03a786cf..1372d8f1e38a 100644
>>> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
>>> @@ -2,6 +2,10 @@
>>>    
>>>    #include "rk3528-u-boot.dtsi"
>>>    
>>> +&sdhci {
>>> +	mmc-hs200-1_8v;
>>> +};
>>> +
>>>    &sdmmc {
>>>    	bus-width = <4>;
>>>    	cap-mmc-highspeed;
>>
> 

