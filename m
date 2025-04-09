Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E4C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124C883929;
	Wed,  9 Apr 2025 19:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zGfdI4e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E83083933; Wed,  9 Apr 2025 19:23:14 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0441838FA
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4551580f8f.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219391; x=1744824191; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qOnbMxaaAZRMmjftT1FTgEhlpmYwNkzZvQQChTyb1lA=;
 b=zGfdI4e5Gzk7ddUu7G3uxzkzAuH6vQWds04YkiBciBYUguvMLGp18CsJWfdYacGLxO
 6WD/eGi9OOSLiCRiPhYjom7EZ3wRQFM7A0751XN+Qx/VTnWHQPBpOX5F2C+a5r4/06JG
 AvYPNhu4fKQKxCNtDAtgq9pt7BQaFcnd4I8I+qC3QYr+BAuCd2waqg7BRfzVT8Qt2tdR
 JjiznPSiGW8KPcwYItCnDw2VRDNvY2PJvH9AKMnRz81CYVKrLhqW3uQWAf1SvdahiNJC
 e9Cyjd4EPW+ZwzGB6TMmjnrGY169JinTwV7i8QFMZnT2gjrChCOPFo5JIsTosWfpvaJO
 ug6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219391; x=1744824191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOnbMxaaAZRMmjftT1FTgEhlpmYwNkzZvQQChTyb1lA=;
 b=vG6AkaaTu6IxJ5jTpzeXkfvXPXFP9hTvK2+vlrF6X15/tyAg3eyx51q+xBhDrnAFpi
 9WsMvcTz2aZts8D3Ktbq9+ycIgDfjORXArTOrpQnfdQAch6x2PZOxdxG3FdQ7sALezHs
 /2Dv9jATKa77hsPAQpdaP+hHVr+Z+Nm9cfAF8sTHLRO4iIvEOk6q9NQTLJm9B9sfSa4i
 sIlfmA+lPlyig8O6pMqyYbjHUyz6pPkTfiQKlrg5X1Qjf05N5i/o6C+50UQ60OKmYfwA
 tgQqa2nKXXHi9UtFkeaMRhAgNztkKP63aM2nzC2KKX1mr7l7x7pHGJrocHFSighiFcrT
 SzVg==
X-Gm-Message-State: AOJu0YwG2sYRM5rygzuNWqPKm2l0m1d1Vr3CMQcSY+JsSVt9dUC/NGwi
 MOpOYrBQaI04c2Mr/pLvuZZqtKMwZp3IUl1t+0EYbv9sdO+qg0ChcAWatLBwei4=
X-Gm-Gg: ASbGncsc/WMEIz+GbjsyQ0SnA3mUTDDeHeAyR7De6vKsunFjhcrki1IY3awRM2mRbQS
 kzQ+JvJgaw/e+IYfREzICAi634UIdxVsiAh1KhNwyYV9cqzwEd7GJIPCcbU931XkdndkSSJADmv
 eXEUv9UY0GXXSyiZNkylr5IlmA4GhU8L1Z5ci4ci2Fa9gYS8oQsWxtUqe6M1EHI0SfUSN5WSrxr
 L5X2YiOM4cLh6oWwZVOb2eKM0xJmHlbnvdoRYYEhk0aPuh3EL2oy3L/8TomLnoCRgC9k1vKw6NZ
 JdSk8d9rnBTtQexwglvNCbvlmZPNlnTkgNUN/5l9jIP/j0Bshe7HkGSEZRfp1YpQyxZW
X-Google-Smtp-Source: AGHT+IHLdbCeFHpTGdSK0ih89Nnxb/5Qk/oUKQqCBt5wLgdirDr5Hbdy8AMG0rzviqxv1xPhSEQePg==
X-Received: by 2002:a5d:64a9:0:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39d88537f30mr3407876f8f.33.1744219391147; 
 Wed, 09 Apr 2025 10:23:11 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893612adsm2133257f8f.8.2025.04.09.10.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 10:23:10 -0700 (PDT)
Message-ID: <1f01f1ed-f9f7-4f93-ae79-158c25be1500@linaro.org>
Date: Wed, 9 Apr 2025 19:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: Add override for RB1
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-2-sumit.garg@kernel.org>
 <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org> <Z_UouNz11eRxIIa-@sumit-X1>
 <deb7ccd0-978b-4b97-bf67-de540dc02fe6@linaro.org> <Z_ZpeSFEyJan2mZB@sumit-X1>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z_ZpeSFEyJan2mZB@sumit-X1>
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



On 4/9/25 14:35, Sumit Garg wrote:
> On Tue, Apr 08, 2025 at 04:43:49PM +0200, Caleb Connolly wrote:
>>
>>
>> On 4/8/25 15:46, Sumit Garg wrote:
>>> On Tue, Apr 08, 2025 at 02:17:29PM +0200, Caleb Connolly wrote:
>>>>
>>>>
>>>> On 4/7/25 15:28, Sumit Garg wrote:
>>>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>
>>>>> Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
>>>>> supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
>>>>> works fine though.
>>>>>
>>>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>> ---
>>>>>     arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
>>>>>     1 file changed, 11 insertions(+)
>>>>>     create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>>>>
>>>>> diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>>>> new file mode 100644
>>>>> index 00000000000..1e136ee405a
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
>>>>> @@ -0,0 +1,11 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +/* This is usually OTG but U-Boot doesn't support that properly */
>>>>> +&usb_dwc3 {
>>>>> +	dr_mode = "host";
>>>>> +};
>>>>> +
>>>>> +/* SDHC_2 isn't supported in U-Boot as of now */
>>>>
>>>> I'd rather avoid disabling this here, I guess it's just missing clocks and
>>>> regulators which doesn't justify modifying DT. An error that mmc1 couldn't
>>>> be enabled seems fine to me?
>>>
>>> I totally echo with your thinking that we should avoid modifying DT but
>>> at the same point we shouldn't enable peripherals in U-Boot which throws
>>> errors. It's also possible that U-Boot misconfiguring mmc1 which might
>>
>> I disagree, DT isn't enabling or disabling peripherals, it's describing
>> hardware.
> 
> It would be helpful if you can describe the use-case for "status"
> property then.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#status

These all describe the functionality of hardware, since implementation 
details of the software (U-Boot) which is parsing the DT has absolutely 
nothing to do with it.>
>> U-Boot lacking proper support for that hardware isn't a good
>> justification to disable it. Especially since you might boot Linux with the
>> same DT and now have no working sdcard for seemingly no reason.
> 
> We shouldn't use same DT unless both U-Boot and Linux support that
> without modifications and *not* being in a broken state. The similar argument
> holds true for USB OTG mode too.
Well, the main difference with the OTG fixup is that we undo it later 
on, so if we boot an OS with this DT it won't have the override -- our 
hacks aren't exposed.

> 
>>
>> An error in U-Boot is exactly the behaviour we want to see, masking it only
>> created confusion.> turn as a problem for later stages.
> 
> IMO, our first priority should be to fix U-Boot issues and then see if
> we can use unmodified DT.
> 
>>>
>>> I have been totally working with a remote lab to fix issues on RB1. I
>>> will soon get one on my desk then I will be able to fix mmc1 too.
>>
>> In that case we can surely land the proper fixes for 2025.07 anyway, so I'd
>> just keep the errors until then.
> 
> Fixing errors in mainline will help other people confidence who are
> trying to boot U-Boot on RB1. If you still have a strong preference to
> keep SD card support enabled in broken state then I can live with that
> until I fix it for real.

I decided to just have a crack at it and managed to get everything 
cleaned up. sdcard seems to work on my RB1 with these patches on top of 
qcom-next and the u-boot specific DTS hacks are removed.

USB phy init seems to fail for me, but the board I'm testing on is some 
super early DVT so I'm hoping it's a silicon issue....

Please give these a spin and let me know how it goes.

https://lore.kernel.org/u-boot/20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org

Kind regards,>
> -Sumit
-- 
Caleb (they/them)

