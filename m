Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EF5CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A81B88EAF;
	Fri, 27 Sep 2024 00:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727390321;
	bh=hrv+vqpEqQgUGMjmhBoNYjFCgQk5OZ3eTVBAL6qefAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fRnDe4AS8LqhBSW+6y1SQZibazo5zMCWAqw3+VMnHJiE6XgqmPh+7zhxTCOgwi6ij
	 9Be2RJl2T3ZbvU2b4R0LkGN2dk8yovDNSFW3v3Hbsf0NzyWNGilx9ST0nJs9PHYW7I
	 Kr4wfp3dNU3DO5v2aAA5t5RRFjlaHpM0QKplGdDQ2wpdsv/aInY99s8XsFGmtqtK52
	 pxjX7JED8wPWi9POghya3j8S9LpdhdzleNDQR/Z0XNAinXAe1TEJPGHAlcG6XSOAwE
	 UC/NvEbskixIkFQKRzBhaklZnswJ4v90dP3x/jyZgLMc52GhQeeeCoew6u8zzMp/V5
	 SdOs9X9FWaXrg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BD2F588966;
 Fri, 27 Sep 2024 00:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727390320;
 bh=hrv+vqpEqQgUGMjmhBoNYjFCgQk5OZ3eTVBAL6qefAk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ANh/69s1a+UsOb7sfmrRmvOvMEUge7YhB0udMa097eMAi9ldBDBbdEWjQKXl0JEk1
 xOt/3Bi83bxFYSOl0C/HkbecFmFJ+UwCNBiU3ILAKiBZNap506mOm6ynqz4kXvEjpe
 1HzR/rnj9/SLqo9EovvvwnaHDD+yZhu6S4p2ND1C/33CjDVbvf9W6UMk0O7kaLjH+v
 r0ygvOub6YZqoehUTnCEDthEjDtZOrs23rsE4W2xEWTX5SFcvAM1YD4ofPpxr/iBHl
 g/SV22VvBhbXkvn3kSyDwQo/sGmG3J3v9TfdzOZWFYTZdffTBa2qEoZ2+ed3BFyQA9
 6WRWt6lRmpWxg==
Message-ID: <e0f1877a-c3e4-49dd-aa42-b92c2262f6df@denx.de>
Date: Fri, 27 Sep 2024 00:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
 <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
 <3aa8bf84-ea2e-4485-8a2d-e1af9d483c98@denx.de>
 <CO6PR11MB55854FEA82DE5B61948975F2D26A2@CO6PR11MB5585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CO6PR11MB55854FEA82DE5B61948975F2D26A2@CO6PR11MB5585.namprd11.prod.outlook.com>
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

On 9/26/24 8:02 AM, Chee, Tien Fong wrote:
> Hi,

Hi,

>>>> arch/arm/cpu/armv7/lowlevel_init.S:.pushsection .text.s_init, "ax"
>>>> arch/arm/cpu/armv7/lowlevel_init.S:WEAK(s_init)
>>>> arch/arm/cpu/armv7/lowlevel_init.S:ENDPROC(s_init)
>>>> arch/arm/cpu/armv7/lowlevel_init.S:     bl      s_init
>>>>
>>>> Maybe such a default lowlevel_init for armv8 could also have an s_init ?
>>>>
>>>>> What's concern with lowlevel_init()? It's also wired into existing
>>>>> early hook function which's located inside start.S
>>>> I would like to avoid duplicating lowlevel_init functionality as much
>>>> as possible , common lowlevel_init would be very welcome .
>>>
>>> Sure, I can add the s_init to common lowlevel_init and moving the codes to
>> s_init.
>> Thanks. Then the question is, how much of this stuff can be removed
>> because it is part of generic lowlevel_init, I hope a lot.
> 
> I'm not sure I completely understand your question, but I can share what we're going to do.

I am wondering if some of the code here can be deduplicated by using the 
generic lowlevel_init.S , i.e. if some of the code in lowlevel_init.S is 
duplicate of the code in this custom lowlevel_init.S implementation.

> Declaring a weak s_init function at lowlevel_init.S
> 
> .pushsection .text.s_init, "ax"
> WEAK(s_init)
> 	bx	lr
> ENDPROC(s_init)
> .popsection
> 
> Calling s_init before lowlevel_init returned to parent call
>                [...]
> 	bl s_init
> 	move lr, x29
>                ret
> 
> We will move the codes to s_init which is declared in our platform driver, arch/arm/mach-socfpga .
> 
> The codes is needed to backup the data section as earlier as possible to support
> warm reset / watchdog due to warm reset use case, where reloading SPL would be skipped after reset.
If you need to run code very early and back up critical data, look at 
save_boot_params .
