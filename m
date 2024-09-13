Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C672FA3741
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE0D88966;
	Fri, 13 Sep 2024 12:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="RTehHZHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB678870D; Fri, 13 Sep 2024 12:40:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2A488CA1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 12:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so1995739f8f.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726224015; x=1726828815; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=o6tVs2TAMVMmsfqmiLESucK/FvGK2riR0hvTRZ4fGes=;
 b=RTehHZHDt9w6lgm3UKF8jFuW5mF3D/FzzWTMBQ/IXjKTidKAYILcdYBQ2+uHtqTWa1
 nQgL2X12OCNdejP7NbEVW22xaIZq5IBz32Xw75TBA2PEZwSrYGhf7SR3giL5GplAlnDQ
 VET1e8JM4OLGsj8wJftKx/jWdyDDd1VhImoCEOHzAG7nVIC0bfLmvhOr3tHNUMkSqLVc
 KZ6jvRKw9hQLAwBX+rApoEKbudiCmU++ZSI2aobzFGtyH2pij7TWp5v9PuY3oINg8Bcz
 Xd+oH6kyr0XBLRv6G2IKlNtODYTdttX6Toq68M/+vs7tZH9+p32eL45tGcTgxsTSboVF
 sdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726224015; x=1726828815;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6tVs2TAMVMmsfqmiLESucK/FvGK2riR0hvTRZ4fGes=;
 b=NlCo9TOXYVELaCaFi8mrZ3cwK+RS4IoGrzJCkja48YyZPtp//XpBV3+V+7tRsqhmDo
 I7gwVDOkGZmo5G2NRHe4Fzp1JrI11/KSUfFWBQs3imMWhmotANWL2x7Bile2gs25pOmk
 7vEKROGwjeuDvn3w3frCkq0Cl+6vQGTbH3yQ/OjE9KAIEmITEhtQ9GXvU4UWhT86qel9
 3o263XGlRfrnRLfFQNo+fqWVlFmkhtXewugjDgLFOv9xk8Kp6P9a9hXHChnzdSb9kog/
 qmcRc39SZHj5n0TZZNI/tpcsl5fdYd7RiH/2Z4t00mmohtygIOwGhV4Uzu7q3S/+h8Y3
 g1xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrgGqC9uHpb1+aEV4sxu1GuX0Pb15iEr1kmf5j62JQYooq8qcl3MNiwZHfMTGj6u7aB6b92/I=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb7j3tvUjtGF8fQoA1yfR2w7aG1rSfG6lO9Xkr0wLhtAw2RwGt
 E9Zo3ZkcvXmAzyiCNjTunGoNe9/7/NJhxaV1K/WNZ5i9G8toWgexkZfRzXE2MSI=
X-Google-Smtp-Source: AGHT+IEaOFPGJPEkdwqQTRbhi+IBBZlQaIjZzGXoxrSUEUAg2q8z2Rm1n8/e1iq2EKR8iZv+BBhlfw==
X-Received: by 2002:a5d:5f46:0:b0:36b:c65c:661e with SMTP id
 ffacd0b85a97d-378a8a1d30cmr10765286f8f.13.1726224013972; 
 Fri, 13 Sep 2024 03:40:13 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b179b29sm20418655e9.34.2024.09.13.03.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 03:40:13 -0700 (PDT)
Message-ID: <71204d13-164c-4b5c-805f-436fcc66d456@suse.com>
Date: Fri, 13 Sep 2024 12:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
 <CALeDE9OyUBQFmrwqfrM+A7K+pcvS0Bd6GzzvEFpxh8w2Qms2TQ@mail.gmail.com>
 <CAC_iWjKVxSf-RX+4msP=SE+LO6zD++CBu25VQy0o=fiB9CvPug@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <CAC_iWjKVxSf-RX+4msP=SE+LO6zD++CBu25VQy0o=fiB9CvPug@mail.gmail.com>
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



On 11/09/2024 12:05, Ilias Apalodimas wrote:
> On Wed, 11 Sept 2024 at 12:50, Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>> On Tue, 10 Sept 2024 at 08:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>>>
>>> On Tue, 10 Sept 2024 at 12:09, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Since RPI works well using EFI and has no size limitations with regards
>>>> to U-Boot, add the needed structures and Kconfig options needed to
>>>> enable capsule updates
>>>> ---
>>>>   board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
>>>>   configs/rpi_4_defconfig     |  2 ++
>>>>   2 files changed, 24 insertions(+)
>>>
>>> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>
>>> A couple of nits below.
>>>
>>>>
>>>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>>>> index ab5ea85cf9f8..1f342eee12b2 100644
>>>> --- a/board/raspberrypi/rpi/rpi.c
>>>> +++ b/board/raspberrypi/rpi/rpi.c
>>>> @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
>>>>          u32 end_tag;
>>>>   };
>>>>
>>>> +struct efi_fw_image fw_images[] = {
>>>> +       {
>>>> +               .fw_name = u"RPI_UBOOT",
>>>> +               .image_index = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +struct efi_capsule_update_info update_info = {
>>>> +       .dfu_string = "mmc 0=u-boot.bin fat 0 1",
>>>> +       .num_images = ARRAY_SIZE(fw_images),
>>>> +       .images = fw_images,
>>>> +};
>>>> +
>>>> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>>>> +void set_dfu_alt_info(char *interface, char *devstr)
>>>> +{
>>>> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>>>> +               env_set("dfu_alt_info", update_info.dfu_string);
>>>> +}
>>>> +#endif
>>>
>>> Is this really needed? We have a weak function in efi_firrmware.c
>>> which is doing exactly this.
>>>
>>>> +
>>>> +
>>>>   #ifdef CONFIG_ARM64
>>>>   #define DTB_DIR "broadcom/"
>>>>   #else
>>>> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
>>>> index f5fb322aa8fc..c70414e6fcaf 100644
>>>> --- a/configs/rpi_4_defconfig
>>>> +++ b/configs/rpi_4_defconfig
>>>> @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>>>>   CONFIG_VIDEO_BCM2835=y
>>>>   CONFIG_CONSOLE_SCROLL_LINES=10
>>>>   CONFIG_PHYS_TO_BUS=y
>>>> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>>>> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>>>
>>> Can we also add the efidebug and efi nvedit commands here. They are
>>> pretty handy especially when it comes to capsule updates. Thanks.
>>
>> Are they pretty handy for capsule updates for general users when
>> things should "just work", as a user applies them from Linux with
>> fwupdmgr and reboots, or for firmwre developers trying to debug
>> things? If it's the later I don't think we should be enabling them by
>> default :)
> 
> nvedit lets you print and see EFI variables, which is pretty basic if
> you want to boot with efi.
> efidebug is supposed to be a debug tool mostly, but unfortunately, we
> havent plugged in EFI HTTP boot into the 'eficonfig' command yet. So
> the only way you can add a boot option for HTTP is via efidebug
> 

I don't really understand why you are mentioning EFI HTTP. From what I can see 
we need efidebug to be able to do capsule updates from U-Boot command line. It 
is also needed for EFI HTTP boot but this needs CONFIG_EFI_HTTP_BOOT which we 
don't enable (and I think is out-of-scope for capsule update).

/me is puzzled :)

Regards,
Matthias
