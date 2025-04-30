Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E61C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794CE820E2;
	Wed, 30 Apr 2025 16:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gNEbcLr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8CD82A27; Wed, 30 Apr 2025 16:04:47 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B7F81F0B
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5BA7D3FC4D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746021883;
 bh=OaOsXfbPuSDqLV7URcVIKDnriXaf+DHGDFMWbmfrrxM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gNEbcLr/O/+y+pIgrGwZ7iUfSNhuj69dFxdy63gAZP8PeUqFKTAHVvRizY+9uOtm7
 kN4Gnj3ei9Tgy2Tle4RDkzda3exZ771Ybi0LgQCSPA2k69dtAdSFjKwky7/7WKtHyO
 2YdWP6MMLhrEDnr/buvuRgXuEJZ5HAtOr7uj7Z38+wASvwumZ3Rd8qKjL4+wYwPG48
 sx02M4GAYd4O4nKwoDc9XjSZxH1C+WCCv6ue51iiYwCA7uyfNLer/i+r2N5+KfcmI4
 QcvlUNTdt7azVffk7z5KA4JzJ8bOEwA/BPs6+3oqASBlGbsZSpZya1dO0yIOK49p0D
 PPZj3vwvgi9AA==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so52731915e9.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021883; x=1746626683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OaOsXfbPuSDqLV7URcVIKDnriXaf+DHGDFMWbmfrrxM=;
 b=OJFfLmH6UVq1ozWgCe+2/bT807Bq9ifWa+q1iPeAS1FN/QcFinTU0pkElh/0MhoL5y
 sGCtkoj0iDS6iGYMP/SKYd6eJJNWasXna3mLCTUB6qLJQ/oY+xT7UK/gXewEaUoiTwBa
 1vrv51AxgpcrUFkDkiJ6d9UGyvaouIo9P1Gpy5RFCLgGIBC1bQgB7yQ9WkDpr8ApL+0Z
 BVmUHqbDGe0JffFaOaP8ekttwnE1GKp3N4Mzg9IGrP6Si0PCa/MRUYow8eu9LOnBikZI
 ULYHtQF+u0dFmAUlP1HCy2cDUlYN5KRWokKYgIWT/cB98h4WE9mqO5oAAQqGTecq4Cgl
 Z2Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6DO6BW2TeDFoju7rA54xjYJKijXvlOugpcYnr4WZPqlmtyIkjbrROIXS+G+sql0o4SJ0tugw=@lists.denx.de
X-Gm-Message-State: AOJu0YwssQZfCbr7kJ1xULOa+/q1ujvnoMRL1NWx+JJ2FKm61OEjOqQH
 aUDW0/LOb0xylukPBPdwMJbBJo+ygZLVSUNZKPaJVE9JIaadIwegCPOu7p/ep/+H0G1CuP+kk8F
 qk15XR3dTyuB4L9fvg9h+sgnjT9zJfXamMFGAtkqRkpTPcTNyvEltTv0hnDVlnRSUKEY=
X-Gm-Gg: ASbGncv6mkvRYIGkXc7SX0eIBoz7Qpbxy6oOM6mIijxVY8jlFByHqOzNBJoDv75PtJF
 ETbTUQmnT7RBYvc/zW8QCAztg5bNiDlqgjv0tOTaM2zIhlFb7Ak05orpv49X6Dd8rtq6g9tLz7B
 LOfPMu1c14mAZDCKtZPrn0sxRtOXIz0qyR59R5T1jLQJcZ6YMDyjQuQOSKB0oMfNwQKPEytcl1J
 AAnj6oTFMrcnd9kJ9MZWKyhE1faHLS1/HZw6PAjac3ocRIfLgt9TTUKuFK9K4f0p0flTXDARnJ7
 PmfZmcr9ren4crw78fHpsDe8Nw4LjpaM87qSk0yumNWkkzM2wZiBTPs9Z4US94x3YYTcXcpogN5
 Gsg==
X-Received: by 2002:a05:600c:1c21:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441b1f3a3f2mr32695705e9.15.1746021882771; 
 Wed, 30 Apr 2025 07:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaYHjk7FsdLCI+hr/yJ12K90q8Q7cfEI1tlMP/zAs/3fcMKl5bG2EBLuECSZ9yjNZAtESmwQ==
X-Received: by 2002:a05:600c:1c21:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441b1f3a3f2mr32695285e9.15.1746021882401; 
 Wed, 30 Apr 2025 07:04:42 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4?
 ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ba4a12sm26132685e9.9.2025.04.30.07.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:04:41 -0700 (PDT)
Message-ID: <d7b41927-e375-4f85-b4fd-cda39defd9e3@canonical.com>
Date: Wed, 30 Apr 2025 16:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, =?UTF-8?B?54mbIOW/l+Wujw==?=
 <Zone.Niuzh@hotmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
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

On 30.04.25 15:54, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The EFI sub-system needs the load address and not the entry point
>> to boot the binary passed from the bootm command. The entry point
>> is derived from the PE-COFF header of the binary.
>>
>> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/bootm_os.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
>> index dc9d3e61fca..a3c7cb5332e 100644
>> --- a/boot/bootm_os.c
>> +++ b/boot/bootm_os.c
>> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>>          /* We expect to return */
>>          images->os.type = IH_TYPE_STANDALONE;
>>
>> -       image_buf = map_sysmem(images->ep, images->os.image_len);
>> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
>>
>>          /* Run EFI image */
>>          printf("## Transferring control to EFI (at address %08lx) ...\n",
>> -              images->ep);
>> +              images->os.image_start);
>>          bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>>
>>          ret = efi_binary_run(image_buf, images->os.image_len,
> 
> In this case ep should be set to image_start as it is with many
> methods. How come it isn't in this case?

As described above the entry point is encoded in the PE-COFF header.

What makes you think that a user would set it in an its file containing 
an EFI binary?

If it where set, it would point to an address after the load address and 
not to the start of the PE-COFF header.

The proper design would completely remove load and entry addresses in 
FIT images and use LMB for memory allocation.

Best regards

Heinrich
