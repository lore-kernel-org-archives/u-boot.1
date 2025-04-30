Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71BAC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66BB8210F;
	Wed, 30 Apr 2025 16:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Dd1cnzSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316C782B45; Wed, 30 Apr 2025 16:34:45 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A35D8210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E3BF3F2A9
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746023682;
 bh=P9uPTvKQN/BDNe357teraufsf6pkWWNEHLrIWLIMC94=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Dd1cnzSIL3WpdPIq10QdFkzqr/aVSrnRCuLgxiUp/0f8zrKXYreIRXlCORuixRT+C
 YsOQrxtNKnMk4UJjKvp8s9SWJs1Pir4KiTRczMAZ/8cvUFiC6+OSHmnzFPLLOpZmpq
 jgF1FSG6NP+1bLVdq1kTNXMe8iHyxFtg1hYNUt1J5t2bWPVXN5UZnxj07GVawGC0DF
 sg0qMjE3iqotkGcmYintiLcwI2I9itP0ynRm2clfVBcK/IdYDYmfWEYTYqyakwk4Fx
 f20fVxtrl12SgnaG3dvCiK3INiPcv1x8q1doKHgEjoRw7/427lqsmtMwOsvTCobt9d
 oKthIzjehaxdg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so30856255e9.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023681; x=1746628481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9uPTvKQN/BDNe357teraufsf6pkWWNEHLrIWLIMC94=;
 b=OZXY0D0ZiYgbTMuWtUwALHEasC/n07uT3FOduKlKMoAEiQyhQ3wZq2yiePX04dDSVY
 u9FHwFL/v0c5QlKIKYlPRkrUS1ZQrlHiQXvWF+8xhgOg3B8T4/w0KV8JoMdx+ZXaBXgC
 6mUOmw0PiYChPz/uMzLc+NX+/qw2QXbFAvgfi+CFjIK8z3/PInD/5XdfyxGiSpytDQls
 77HMCNhFO44eISWirji4mGzmZRJe94nLaEyl5wnQohAb1fsUUdiRPFQ+vBP/RVp22M5s
 4buQ82aDqaQAvN+l8IBk7bhsakUtcS0tlF8VNK3U6o2ExSAnqaaHoB+rLCDSRESit1ph
 v1Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiDUhA3Z8T+9j88MZIREA1Xs9Gfof0EguP+v8NYb/FPIHeXXh0tbVCjEU9VMMLz4/+0/gUdOM=@lists.denx.de
X-Gm-Message-State: AOJu0YyhQkD6PuipiMp1UQvgXRbRqpbp5Hsll+6BGcw5YiHfK6WU3bKZ
 Qmfw3FTom0qlhFAQJ62bhiRQGpn1PUK+RgQGdDp22cyRPvOT0Tj3Ge0wEZYSTbAANitdPVxDM60
 jo2qlRdU2If+LIxEFgEsjRICD04BL1HfqSaF8m/FvBVKvLky8T7iWEJVLNN2XYZ0w1do=
X-Gm-Gg: ASbGnctSywThBESxFd4TGS5pmVFm6adSHqBbs1tG76wQGvyCc4FcPC09JUeJbntEW4u
 WQZiSKg6L5uo2HYvLcj2vnuLsxi6HE0NUlA5hTUhakOjOeFP+at29dc9WoKLb4BUtSM4LqGp7ri
 /RD71ANPTp+kaKNGG5WQZ4Pz2+2P4YSH/ZHctADx3Tki5viYfl2O0MK0YylwOs2AHRPclJDlsqs
 EZanyg6nmMVeEZYQ6Ll+IU6AC4q+IwYtOG4evZuPnLqGpygd+JEF/Ikv6Ox6gTooL3fE8u+ST3k
 FSMKYTZK5X1FyXazNwewgZxm/Iw0gtGW/PmZxCfWq3MberAznteO8hFyUfWj1KGybpUFaH183xr
 kxw==
X-Received: by 2002:a05:600c:c86:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-441b1f35e4emr40042325e9.10.1746023681627; 
 Wed, 30 Apr 2025 07:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+26Q59mSQQhNovZ4UHmhPUPVf8LUoyMzUXGuPD070xwGpKEBo8bx5qaLXZElFUOYrgxfwqA==
X-Received: by 2002:a05:600c:c86:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-441b1f35e4emr40042025e9.10.1746023681225; 
 Wed, 30 Apr 2025 07:34:41 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4?
 ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bb3f72sm26753525e9.21.2025.04.30.07.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:34:40 -0700 (PDT)
Message-ID: <e7d6597b-609f-4b52-ad92-4c37fd60ea22@canonical.com>
Date: Wed, 30 Apr 2025 16:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot/image-fit: improve 'No Image' message
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Maxim Moskalets <maximmosk4@gmail.com>, Raymond Mao
 <raymond.mao@linaro.org>, u-boot@lists.denx.de
References: <20250430071613.13508-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgoo=_0WK+ks8nccOUX4X8CqTryQnUQZuP8EwwLy0SEgA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgoo=_0WK+ks8nccOUX4X8CqTryQnUQZuP8EwwLy0SEgA@mail.gmail.com>
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
> On Wed, 30 Apr 2025 at 01:16, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> If an initrd is invalid, we see output like
>>
>>      No Unknown OS RISC-V RAMDisk Image Image
>>      Ramdisk image is corrupt or invalid
>>
>> As most image type descriptions end on Image, we should not repeat that
>> word.
> 
> Instead of that, remove the 'Image' from all the types and reduce the
> size of U-Boot by 200+ bytes.

There are more places where genimg_get_type_name() is called. We would 
have to consider all of these.

> 
>> Instead of misleading 'No' we should write 'Invalid' here.
>>
>>      Invalid Unknown OS RISC-V RAMDisk Image
>>      Ramdisk image is corrupt or invalid
> 
> What this is actually saying is that the image is not of the requested
> type. It may be a valid image but it doesn't match the requested
> image_type. So calling it invalid is going to be very confusing.
> People might then start trying to figure out whether the image was
> created incorrectly, etc.

"No foo image" means there is no image of type "foo image" at all.

"Invalid foo image" clearly expresses that it is not an image that can 
be interpreted as "foo image".

No clue what confuses you here.

Best regards

Heinrich

> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/image-fit.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 41ab1f552b0..856de6b731a 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2196,7 +2196,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>>           */
>>          if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
>>                  fit_image_get_os(fit, noffset, &os);
>> -               printf("No %s %s %s Image\n",
>> +               printf("Invalid %s %s %s\n",
>>                         genimg_get_os_name(os),
>>                         genimg_get_arch_name(arch),
>>                         genimg_get_type_name(image_type));
>> --
>> 2.48.1
>>
> 
> Regards,
> Simon

