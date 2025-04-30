Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6950AC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC67282B81;
	Wed, 30 Apr 2025 17:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Lq2SkKgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4703B82B9D; Wed, 30 Apr 2025 17:17:13 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F538215F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC0213FC4A
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746026228;
 bh=P20OJDgj+t54RDugNaSK+S3qKGC8r7+1MC4WJ9ElwgI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Lq2SkKgZxHydVc5Bb79z4ZxdXosRzyrNmxJgwak+nAu2RPtPLVHmN14EuFvGjs9H+
 xSASqqcPQu3zvTfbdAt1wkmgtMG8ep1FxsHP2d3+ynJNo+P/qFm8XzMjHcvqUG/P1b
 wKSLZ1Bn/OY8BPf4l2epJ4epf79UyztxlJt8iONQG/p/KZwVluSsv08H+2v3addmM0
 eRCxZkrJWLu4+be4KhTzMq6lFjVXOMho2Uo0MAFZ20vJcOfch4q0Y4naeg0bkZl6TR
 +6x0li1OmcrCB2ivaobOfq9mcislc1QGnbC7pDwy5bjBBDpOLlSAWPGzVrsiOLnQTv
 C5QbEEqNLz6MQ==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so2483519f8f.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746026228; x=1746631028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P20OJDgj+t54RDugNaSK+S3qKGC8r7+1MC4WJ9ElwgI=;
 b=uequ47eaPhZ0M61cYWNVInJbYsqcLf2APN0fsp4n0LW2PfLJs88PYcCtOOy4NjNpFR
 NF0MGF9ATBkhtiH2xu3a0Dh1KFbs/C+TXgN/dYBAIidAsxRlDNrEB2gA3ZmIQV0Ly8hd
 yVWjbs7SKy2cpJuFzci0nBwTCUwmHpR5brsHmevxzgHarjYUdZFMUhM2aYuRKfXcio1W
 L8yS9ldGcG6RhY6gDBahQvVsIBS8yvAcaiveg5+Qdzq5lTsttDLk7HPTNpyl/iIcTPcp
 NHwnBwA/28UJh0FFtwO31XpFiOLpVXHpFxJw+QTa3EiMP5uZGjehbtGDUv1oWFox2BxP
 qc7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZd0VS/P5wR/H+huXzNt+HalrYW1u7uvVaTbWwmT4lkHaDUw/SSe7QKhsrfRuIMUf/wnJmcg=@lists.denx.de
X-Gm-Message-State: AOJu0YzRO618N17U7rfgAHa+NxV2nOw093zwNu42bd4vapyC2+1XMCaB
 EAtZrpuYYlvsj0No/BusC8izvSJayPFIKPqCFutOS2D4O1UG5DEcjli0DLJEBWNBvImBJR1kn1l
 NgOQIdZDduIXTmS1zDKPOl99CKPWkE+2zDNstNWjN894zCanpIKp7yJcoBJJ8STmKZLCgEX4uLe
 s=
X-Gm-Gg: ASbGncvwZ5RKVPtJ2SRMvff7m3M/XdeXNWG2VZOWwLaW27Y2LNbL3ErbhMSe2bmU0u2
 LxCiCIOvb4VeiLFAdhBDDKgvyulh1ij5EWq4CcsgGnrybGTEVpkFvP0yKw0eMma/+UGhrU+kI8Z
 bp+B8UUhA97f9RgtbzRQL7JiUSTQxW1yW2CG5QxGsDacJZT6DyQjfkHYsMElveJ/WPYT4sGEt55
 dzKjXROjd1bE8LnzYg8wPNZZZv9pznyfp/L3wNcWS4HTh82JhRWzm7vQGkJehLfInHm8Azss/AP
 6oe64THk1rC2u3gSkoeAdTWQV10Ou6VBNzSbWzEHpwUfccj6++wijizBR3Lq50alEj9GcqbYwy9
 yzA==
X-Received: by 2002:a5d:58d0:0:b0:3a0:92a3:24bf with SMTP id
 ffacd0b85a97d-3a092a324edmr245956f8f.30.1746026228337; 
 Wed, 30 Apr 2025 08:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwerfFNz6avJvuDS2XZVQrOj+DNFrQck+pT1xBbk6LY28Ln+5LguuXPDMAKkDv+2SUlAwcfQ==
X-Received: by 2002:a5d:58d0:0:b0:3a0:92a3:24bf with SMTP id
 ffacd0b85a97d-3a092a324edmr245920f8f.30.1746026227857; 
 Wed, 30 Apr 2025 08:17:07 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4?
 ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da02sm17429303f8f.93.2025.04.30.08.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 08:17:07 -0700 (PDT)
Message-ID: <0ce6f15b-7fb9-46d6-b06f-15174d318e79@canonical.com>
Date: Wed, 30 Apr 2025 17:17:05 +0200
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
 <d7b41927-e375-4f85-b4fd-cda39defd9e3@canonical.com>
 <CAFLszTiEKdf2F6=jomTfxj-cmECefxmwd=MQ3drsP0pNC-4oFQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiEKdf2F6=jomTfxj-cmECefxmwd=MQ3drsP0pNC-4oFQ@mail.gmail.com>
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

On 30.04.25 17:01, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 30 Apr 2025 at 08:04, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 30.04.25 15:54, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> The EFI sub-system needs the load address and not the entry point
>>>> to boot the binary passed from the bootm command. The entry point
>>>> is derived from the PE-COFF header of the binary.
>>>>
>>>> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    boot/bootm_os.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
>>>> index dc9d3e61fca..a3c7cb5332e 100644
>>>> --- a/boot/bootm_os.c
>>>> +++ b/boot/bootm_os.c
>>>> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>>>>           /* We expect to return */
>>>>           images->os.type = IH_TYPE_STANDALONE;
>>>>
>>>> -       image_buf = map_sysmem(images->ep, images->os.image_len);
>>>> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
>>>>
>>>>           /* Run EFI image */
>>>>           printf("## Transferring control to EFI (at address %08lx) ...\n",
>>>> -              images->ep);
>>>> +              images->os.image_start);
>>>>           bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>>>>
>>>>           ret = efi_binary_run(image_buf, images->os.image_len,
>>>
>>> In this case ep should be set to image_start as it is with many
>>> methods. How come it isn't in this case?
>>
>> As described above the entry point is encoded in the PE-COFF header.
>>
>> What makes you think that a user would set it in an its file containing
>> an EFI binary?
>>
>> If it where set, it would point to an address after the load address and
>> not to the start of the PE-COFF header.
>>
>> The proper design would completely remove load and entry addresses in
>> FIT images and use LMB for memory allocation.
> 
> You are missing the point entirely.
> 
> However the image calculates the entry point is up to that image. But
> the correct entry point should be put into ->ep
> 
> We can't have some OS--booting functions using ->ep and some using ->os.load
> 
> So please dig in a little more and fix whatever is going wrong here
> and ensure that ->ep is set correctly. If you need help, please ask.

The only information that the EFI sub-system cares about is the start of 
the image. That information is in os.start_image.

Field ep is for the entry point and not for the start of the image and 
EFI should never take it from the FIT meta-information.

This is why whatever value I put into the field entry of my handcrafted 
its file is completely irrelevant.

Best regards

Heinrich

