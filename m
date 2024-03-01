Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA6C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B17088146;
	Fri,  1 Mar 2024 16:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S/nXxhH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89C48814A; Fri,  1 Mar 2024 16:18:17 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A294288139
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 16:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so1551125f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709306295; x=1709911095;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VhZO9pb5L7FZEBJR9S8qTbg6BhFxDd/yFG4Vjbv5P1E=;
 b=S/nXxhH8OQKwEdZh4SNRC5w293wN+D8oNgNc28dvj3yaE60fgYAfVI573TPTKLAfte
 okBfAKR41qb/bvWBdaaH1yt3FB8JwAdRJud9MJhwZo4uYpfMMKaU989c0MrZzOP9/WvT
 +noQlVEgMfVn4km2crHZOZoQq2vgMxcXyFc/oKCZXa+auQqyr76svzKHJzScs0duo6Mj
 ffwCDn4fusIIirEznjuMBT/jgwkrJSPeMTbj3SrbszkVOQ5etDqxfONvPg3ymKvMp+e4
 /5fj9Xizht8EVZUg9P7ZbBJrnMcdXv+VAhrq/ujGxD3FddRiR7s2Tw1MJS684j2gn62d
 h91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709306295; x=1709911095;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhZO9pb5L7FZEBJR9S8qTbg6BhFxDd/yFG4Vjbv5P1E=;
 b=dJS8Y1KkQdKf988PbwqNAE8uTg34rXfuTFJN3BAynp8h9oWciudaW02bVXnTWAU+zw
 KTQ9cFb/OYSscTwUnxF92Rxc7ogysYKN82XPHAEZ5YIb3mSCAH5RWVpj+Nje4sOvTDi3
 IqZGEzUUo6VVnDIjfhnsnoS75f7Vh+tIZqMKC4mUiOwjuixBzH1i3IMwFmCfx7ufV/PQ
 9cCe9XvP7LPkKiod/2hB4yIJ53bapxai+hSHoGYHkqbDsJfMSxiW6R0+BFvuubrckqQr
 Z64LHMTyxK1G9tcGAILQhIHhETpdlMfYShR9cU3DGMt7M1gWSD8ahWFxlwirAfK/2x/n
 tcsw==
X-Gm-Message-State: AOJu0Yw8AUjm6ey/wV2wOsGtOMBgTUdceRr0yaca2tBVhLlLqfzYIrx3
 lNjLRPc35YdDDaql70QjeKkeFVevGAjVJpNaogqasAXY+BqL0KoP+KreO23+KXo=
X-Google-Smtp-Source: AGHT+IF/5RSZD1O85mONcUR3YcothuTKokzWBHtfG2pidum2mTreD5fzaUL7KMr+r512aka4oRmdDQ==
X-Received: by 2002:a05:6000:4026:b0:33e:83a:b4f with SMTP id
 cp38-20020a056000402600b0033e083a0b4fmr2043824wrb.2.1709306294783; 
 Fri, 01 Mar 2024 07:18:14 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 g3-20020adfe403000000b0033af3a43e91sm4809753wrm.46.2024.03.01.07.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 07:18:14 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when
 USB_DWC3_GADGET is disabled
In-Reply-To: <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
 <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
 <e14e9c06-ca37-4572-b410-c40a8c52898c@kwiboo.se>
 <1544e744-bbf7-4460-b2b4-12a971e70d49@denx.de>
 <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
Date: Fri, 01 Mar 2024 16:18:12 +0100
Message-ID: <87y1b2nfpn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Jonas, thank you for the patch.

On lun., f=C3=A9vr. 26, 2024 at 13:36, Jonas Karlman <jonas@kwiboo.se> wrot=
e:

> On 2024-02-26 11:18, Marek Vasut wrote:
>> On 2/26/24 10:50 AM, Jonas Karlman wrote:
>>> On 2024-02-26 09:22, Marek Vasut wrote:
>>>> On 2/26/24 8:54 AM, Jonas Karlman wrote:
>>>>> On 2024-02-26 02:47, Tom Rini wrote:
>>>>>> On Mon, Feb 26, 2024 at 01:02:04AM +0100, Jonas Karlman wrote:
>>>>>>> On 2024-02-25 23:01, Marek Vasut wrote:
>>>>>>>> On 2/25/24 4:27 PM, Jonas Karlman wrote:
>>>>>>>>> Build fail with the following error when DM_USB_GADGET is enabled=
 and
>>>>>>>>> USB_DWC3_GADGET is disabled:
>>>>>>>>>
>>>>>>>>>      dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_inter=
rupts':
>>>>>>>>>      dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrup=
ts+0x10):
>>>>>>>>>        undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>>>>>>>
>>>>>>>>> Build also fail with the following error when USB_GADGET_DWC2_OTG=
 +
>>>>>>>>> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>>>>>>>>>
>>>>>>>>>      gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_int=
errupts':
>>>>>>>>>      gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_ga=
dget_handle_interrupts';
>>>>>>>>>        dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined=
 here
>>>>>>>>>
>>>>>>>>> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GA=
DGET.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>>>> ---
>>>>>>>>>     drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>>>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/d=
wc3-generic.c
>>>>>>>>> index 6fb2de8a5ace..891d01957619 100644
>>>>>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>>>>>> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct ude=
vice *dev)
>>>>>>>>>     	return 0;
>>>>>>>>>     }
>>>>>>>>>=20=20=20=20=20
>>>>>>>>> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>>>>>>> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_U=
SB_GADGET)
>>>>>>>>
>>>>>>>> Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADG=
ET ,
>>>>>>>> since I think the DWC3 code doesn't work without DM anyway .
>>>>>>>
>>>>>>> Do you mean in addition to this? I do not think that alone is somet=
hing
>>>>>>> that will address my intention to be able to disable the gadget par=
t of
>>>>>>> the dwc3-generic driver.
>>>>>>>
>>>>>>> Before this patch it was possible to enable disable host or gadget =
by
>>>>>>> using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET opt=
ions.
>>>>>>>
>>>>>>> However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying=
 to
>>>>>>> use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
>>>>>>> possible and result in the build errors reported, i.e. multiple
>>>>>>> definition of dm_usb_gadget_handle_interrupts() and undefined refer=
ence
>>>>>>> to dwc3_gadget_uboot_handle_interrupt().
>>>>>>>
>>>>>>> After this patch I can use dm dwc2 gadget and dwc3 host without iss=
ue.
>>>>>>
>>>>>> Note that *DM_* symbols can be confusing. At this point, in SPL
>>>>>> SPL_DM_USB and SPL_DM_USB_GADGET are encouraged but not required for
>>>>>> host/gadget drivers. In full U-Boot, DM_USB is required for all host
>>>>>> drivers and really should be enabled in all cases for DM_USB_GADGET.=
 We
>>>>>> can't enforce that at the Kconfig level because of, iirc, some of the
>>>>>> armv7 part gadget drivers (more than one). But for newer and still v=
ery
>>>>>> active chips, we should be using DM_USB_GADGET unconditionally in fu=
ll
>>>>>> U-Boot.
>>>>>
>>>>> The issue is that with DM_USB_GADGET we can only have one driver
>>>>> providing the dm_usb_gadget_handle_interrupts() function.
>>>>
>>>> DM was always intended to permit multiple drivers, so this is a bug and
>>>> should be fixed, e.g. by turning the interrupt handling function into a
>>>> driver-specific callback.
>>>
>>> I fully agree, and I hope that someone can work on that separate issue
>>> and that it does not block this build error fix patch.
>>=20
>> Please, let's fix this properly instead of piling up another ifdef=20
>> workaround.

I agree with Marek.

>
> Reworking the core usb gadget interrupt handling is unfortunately not
> something I can spend any of my already limited hobbyist free time on.

I understand you don't have time for this.

I will try to tackle it, but I have limited time in the upcoming weeks.

I will keep you posted.

>
> If this workaround is not acceptable I can just drop the RK3328 cleanup
> and leave usb in current semi-broken state.
>
>>=20
>> Since CI does pass, where is there a build error ?
>
> Currently there is no board with a configuration that cause build errors,
> that happens when I add DM_USB_GADGET=3Dy to RK3328 boards in a separate
> series.
>
> Previously you have requested that I do not send usb patches as part of
> a larger series targeted to rockchip maintainers. So this time I sent
> the usb part as a standalone patch ahead of such series.
>
> Will send out that series later, and if no one wants to pick this up or
> have time to rework gadget interrupt handling that is fine with me :-)
>
> Regards,
> Jonas
