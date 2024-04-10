Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B171ECD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B4188089;
	Wed, 10 Apr 2024 10:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GqYE+OFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E76387572; Wed, 10 Apr 2024 10:31:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEB48809E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712737851; x=1713342651; i=xypron.glpk@gmx.de;
 bh=y886mhSmQcEWqzOwlZiMC+kWM8Vq3cEX1TzaF/zdxX8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=GqYE+OFkkfCPHsXJXgSQPmuQswYpy8iNWlFXcrved+f+7TZjcjAA7gmNSkZ+Tj5B
 zbk7VCYYbe9L/TLgbSLCHVhDGPTkRYqFV9A0fNe4HS5mvXUK9dwh4ncwJuZfd9NPd
 3KYaXSouPbD7nCjIHrJOFTHFcHqJLj76n9b0lypGUmYpLKe6sVDC4omELRX6CDqMQ
 wJqsfyM5tDoOc6b0ozSiF4O7Kh5uvZnk8dpCiWcBwqcWPYiKkpWTHzrvjraea27tg
 L6spg/ddafNaClHl/vyKJuVoMlF03LaIoPo1Zr0DejomsSAYRIgvCU/TpWfhfV+PS
 UD7eBfXzo1I2KeqjnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1sDuym2T7r-00KjfI; Wed, 10
 Apr 2024 10:30:51 +0200
Message-ID: <a2fb8782-66d5-44ad-8238-d565e0934de9@gmx.de>
Date: Wed, 10 Apr 2024 10:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
To: Jon Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Judith Mendez <jm@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
 <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
 <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JmtjWjdIpstQ0OIEU4Jn9+8IeYaqytNgmJdK7c9zAvYzJUUcYmT
 Pn3AlkcH+RlgYAyup1P+iuPxSk3TZT+O+WpwFOu1dUnSlvDRI29cEGK0B2gMiTeORnRkH/7
 2iQoT/S9sGqAO8YVi7yoHIOKyN1hcshzDT1lkX3Oy0BULlZjAXCezhKXRYUJx4uvHTlxWIM
 +q8zbwN1TGm+wr/xdRGkQ==
UI-OutboundReport: notjunk:1;M01:P0:bMf7k3bDYg4=;SbPrzc4kdEE46Pjl/yGdU4XL8F3
 2cKbGeZVEt5FJz+3pZu94T4nhWMD7uiJt29sivuXSNozMT+89M3MGF9P6FRzKHuQ9EpKs/sGJ
 8j5fWhuvfHJpgEFjO/O9IskktJQrtWFZ8TXEvHljAcPa7blE2+qTglFqMFZGa7qreThfJAZ+b
 ZyS52JIAzimXLxLaaMYPZbE96ytznT697dEOxN8VyQ3zjI66YVvn8paic47BEBsboAqahZLcy
 W24yO1ueGLLHMVGCHhG9AQYNByIqLbA3krJqCYekTAZaKHDGHOCHo3/jLYdjEr37mg2Mi0VKY
 6isBxtpqdyYbMuht6fflrUEXSbR1QYUr4TDtj+SgsS4xNBbgGkw8DLwPkbRL9TjbcpJ7G8bIz
 Uu2TD8GXlnSID7YpLUsv5+DpguXQ9xeniWasElGE8j92KswD5uk5WHN6io9dBlXKAdF8NIrTW
 gd2SBJE0E5EK4elTZ4LhSqomhTmPUfCs2zPMPXYdshvb9VqHffZESxTnUEuhlMQSVzv1T02FR
 nU8MZ10gtrbvpgLtD726JQf/v1g6J0V87jKXTeSH7WG57p87rLTUt8VISQ0vXAGFEQIEfxH0R
 xVxfnVg8D6H++dFOu2xh/8SVaG4Rb/DqGEqmcLPpR/D8kPg6L4TUc65VTAwJ/9DN+SP63hEs4
 4mkpO9txhq30Tt3DRq1X5IGQQkHkHuQZT9Tqt73OPdTxwR3sWhO3i6Kh+5uYYjPTnnxHBFeWC
 jSbci1azHstcRbieEIT96jxE+QSSUhB4prXlcYiXujadYNkf/UNGvhpnBmidt4TV9GEEFJlhY
 0S8qb2CaiWI7HXJ0emkzlBFXfmvDH3mHwERlfgLG6Ur7w=
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

On 09.04.24 23:05, Jon Humphreys wrote:
> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>
>> On 4/9/24 00:31, Jonathan Humphreys wrote:
>>> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin=
,
>>> u-boot.img, sysfw). >
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> ---
>>>    include/configs/ti_armv7_common.h | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_ar=
mv7_common.h
>>> index 3def7b1027e..4ce14a9b84c 100644
>>> --- a/include/configs/ti_armv7_common.h
>>> +++ b/include/configs/ti_armv7_common.h
>>> @@ -16,6 +16,23 @@
>>>    #ifndef __CONFIG_TI_ARMV7_COMMON_H__
>>>    #define __CONFIG_TI_ARMV7_COMMON_H__
>>>
>>> +/* GUIDs for capsule updatable firmware images */
>>
>> Please, provide code comments for the GUIDs, e.g.
>>
>> /**
>>    * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
>>    *
>>    * This GUID is used in capsules updates to identify the tiboot3.bin
>>    * binary.
>>    */
>>
>> Cf.
>> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-doc=
umentation
>>
>> Best regards
>>
>> Heinrich
>>
>
> Heinrich, thanks for reviewing!
>
> I modelled the GUID macros after how other boards and even core code
> defined there's.  (eg, include/configs/kontron-sl-mx8mm.h or
> include/efi_api.h).
>
> However, if this is the new direction, I will format as you suggest.
> Please confirm.

Hello Jon,

Without properly documenting macros we make the live of developers more
difficult. Yes, we still have a lot of missing code documentation. But
we should not follow poor example.

Best regards

Heinrich

>
> thanks
> Jon
>
>>> +#define K3_TIBOOT3_IMAGE_GUID \
>>> +	EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
>>> +		 0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
>>> +
>>> +#define K3_SPL_IMAGE_GUID \
>>> +	EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
>>> +		 0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
>>> +
>>> +#define K3_UBOOT_IMAGE_GUID \
>>> +	EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
>>> +		 0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
>>> +
>>> +#define K3_SYSFW_IMAGE_GUID \
>>> +	EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
>>> +		 0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
>>> +
>>>    /*
>>>     * We setup defaults based on constraints from the Linux kernel, wh=
ich should
>>>     * also be safe elsewhere.  We have the default load at 32MB into D=
DR (for

