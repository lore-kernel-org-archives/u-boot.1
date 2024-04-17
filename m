Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C33C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795E78840D;
	Wed, 17 Apr 2024 12:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O9eieKwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AD88842A; Wed, 17 Apr 2024 12:10:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C9B88344
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-415515178ceso33690675e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713348624; x=1713953424; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tNtoqL9GbbgnIZfFJgyckOgXSO5Qi1lhx+TcTZeQtE=;
 b=O9eieKwjiEaTEntjKYixp/MGcAyubgqd38hCAHhSUHVfjW9Z0DwNd9tz1IYrKYRhmu
 PFJvYLSEdg0vjdHQbYEqi/9qod9YTsNg43/CqOxfy4Hi/bhIys2AV/LlM4sayRR8x5Qw
 Keyv6DqKuKTsy1tuZNp370dm/2VGSABSQBYEeBpah8GfQR3XTDWDkc61GhmZt1P7yICt
 vN7ffjNdiFJffJZZbNlYvkyy2gPXOcKyI8GMv8hpm8mSDsEUwgEEu6p2XCILxRwbRVKK
 L6kJb/3Xo1aBYx9NJa2P6wLEtkYT3w5H5SUxG0wSDUbu35QVZ0IYkr+I+C9eQV+ZsDqk
 9sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713348624; x=1713953424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tNtoqL9GbbgnIZfFJgyckOgXSO5Qi1lhx+TcTZeQtE=;
 b=a+iFT1F8pO2cNfkPNsQOBRDBMjEeQnY6+l1ALcsyaB7o8wlR91JldnBVyzcVo3EN8v
 HsDG8q+NM9po1i/9s/kx+cZXWH9313G/QwGNRE/S5nqw8xRXoXnkPSJe0IwtISnRtplE
 V8gKYiJB3r4TNSygwHEBS1c4xPgSsILFpxjukOx1PfltnLbj3+qjUuC0O4SOx+fifyeq
 bIUCiIlp7KvGo7qxQxCFnghkzqsIAF5eUco14DYPGCsRYD2g5KDH9xLJQM9aKAC+9kyG
 wyOngjDpLBL84PGCAYtbTOT6yT1I/ItoKytsdL+AwnpD/T3pfTwxq7aS7Lgn4igpF4mv
 v/Tg==
X-Gm-Message-State: AOJu0Yyvxb433vJUTVnXwXfXWnF6jmCZPN50EqH4U5EmMV8kgup1e8W/
 FbJPEuwBhyHdAY0wTzNo2fi7l7KuZtfJjYJ9VJEI7/BfGe5GyzpTfg+gJw+EQn4=
X-Google-Smtp-Source: AGHT+IG+RjzzJ9F7coMaouA5NHUu2cU8F6RjvTU2lO+gxFBrCVw362C0hzky+JvxCLn4ZGcXhEZxLg==
X-Received: by 2002:a05:600c:3baa:b0:418:3d29:292b with SMTP id
 n42-20020a05600c3baa00b004183d29292bmr7468947wms.4.1713348624348; 
 Wed, 17 Apr 2024 03:10:24 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a05600c34ce00b004161bffa48csm2193355wmq.40.2024.04.17.03.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 03:10:23 -0700 (PDT)
Message-ID: <fe1d6b6a-eb59-45f0-b51b-c0659298f2d5@linaro.org>
Date: Wed, 17 Apr 2024 11:10:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
Content-Language: en-US
To: Jon Humphreys <j-humphreys@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Judith Mendez <jm@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
 <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
 <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
 <a2fb8782-66d5-44ad-8238-d565e0934de9@gmx.de>
 <CAC_iWjLEzeXmhc=EiGT3++1a5W5JRrZHivgSN=JMN+mQtpTZeQ@mail.gmail.com>
 <868r1iz1iw.fsf@udb0321960.dhcp.ti.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <868r1iz1iw.fsf@udb0321960.dhcp.ti.com>
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



On 12/04/2024 22:58, Jon Humphreys wrote:
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
> 
>> Hi both
>>
>> On Wed, 10 Apr 2024 at 10:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>>
>>> On 09.04.24 23:05, Jon Humphreys wrote:
>>>> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>>>>
>>>>> On 4/9/24 00:31, Jonathan Humphreys wrote:
>>>>>> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
>>>>>> u-boot.img, sysfw). >
>>>>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>>>>> ---
>>>>>>    include/configs/ti_armv7_common.h | 17 +++++++++++++++++
>>>>>>    1 file changed, 17 insertions(+)
>>>>>>
>>>>>> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
>>>>>> index 3def7b1027e..4ce14a9b84c 100644
>>>>>> --- a/include/configs/ti_armv7_common.h
>>>>>> +++ b/include/configs/ti_armv7_common.h
>>>>>> @@ -16,6 +16,23 @@
>>>>>>    #ifndef __CONFIG_TI_ARMV7_COMMON_H__
>>>>>>    #define __CONFIG_TI_ARMV7_COMMON_H__
>>>>>>
>>>>>> +/* GUIDs for capsule updatable firmware images */
>>>>>
>>>>> Please, provide code comments for the GUIDs, e.g.
>>>>>
>>>>> /**
>>>>>    * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
>>>>>    *
>>>>>    * This GUID is used in capsules updates to identify the tiboot3.bin
>>>>>    * binary.
>>>>>    */
>>
>> I'd go one step further tbh.  Those GUIDs can be used by OEMs/ODMs
>> producing capsules for their future products.
>> Currently, we don't have a documented way to allow users to redefine
>> this (but Linaro is working on it).  If both TI and an OEM use the
>> same GUID and try to upload the firmware to LVFS, we will have a GUID
>> clash.
>> I think we should have that on the comment as well, until we can
>> properly sort it out
> 
> Ilias, I realized I may have defined the GUID's a bit incorrectly.  I
> was thinking that the GUID's identify the firmware type (eg, SPL vs
> Uboot for TI devices).  However, the SPL binary for say am62 will be
> different than the SPL binary for say am64, so I should have unique
> GUID's per firmware type *per board*.  Correct?
> 
> If so, I'll need to move these definitions to the board .h files, and my
> generic capsule binman nodes will need to have each board override the
> image GUID used.

Yes, consider for example if you wanted to maintain community firmware
images on LVFS, for a given image (like U-Boot itself) you would
presumably update it for each board, which requires each board to have
it's own GUID so you can tell them apart.

If one of the payloads is identical for a bunch of boards then it might
make sense to use one GUID for it.
> 
> thanks
> Jon
> 
>>
>> Thanks
>> /Ilias
>>>>>
>>>>> Cf.
>>>>> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
>>>>>
>>>>> Best regards
>>>>>
>>>>> Heinrich
>>>>>
>>>>
>>>> Heinrich, thanks for reviewing!
>>>>
>>>> I modelled the GUID macros after how other boards and even core code
>>>> defined there's.  (eg, include/configs/kontron-sl-mx8mm.h or
>>>> include/efi_api.h).
>>>>
>>>> However, if this is the new direction, I will format as you suggest.
>>>> Please confirm.
>>>
>>> Hello Jon,
>>>
>>> Without properly documenting macros we make the live of developers more
>>> difficult. Yes, we still have a lot of missing code documentation. But
>>> we should not follow poor example.
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>
>>>> thanks
>>>> Jon
>>>>
>>>>>> +#define K3_TIBOOT3_IMAGE_GUID \
>>>>>> +   EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
>>>>>> +            0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
>>>>>> +
>>>>>> +#define K3_SPL_IMAGE_GUID \
>>>>>> +   EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
>>>>>> +            0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
>>>>>> +
>>>>>> +#define K3_UBOOT_IMAGE_GUID \
>>>>>> +   EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
>>>>>> +            0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
>>>>>> +
>>>>>> +#define K3_SYSFW_IMAGE_GUID \
>>>>>> +   EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
>>>>>> +            0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
>>>>>> +
>>>>>>    /*
>>>>>>     * We setup defaults based on constraints from the Linux kernel, which should
>>>>>>     * also be safe elsewhere.  We have the default load at 32MB into DDR (for
>>>

-- 
// Caleb (they/them)
