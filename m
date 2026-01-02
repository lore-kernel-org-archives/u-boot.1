Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171AFA3729
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBC98427F;
	Fri,  2 Jan 2026 16:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OEqbgsLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B372384280; Fri,  2 Jan 2026 16:15:55 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF4E84255
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F21473F5A1
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767366953;
 bh=nUR0y7X9sft5DMemPALEDh9JDsqLOfOgU92BZNduaGc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=OEqbgsLrm2b8M2InfO5h3n51+U4R9cE5m3eoBYRaF+09TsQCOC2ZpJDHr4ez4Dy3f
 fdGeN/zwiEIzdPeH0Sy4h1vOt1Un1dE1npurI8HQwmbFFp8rtzlQCneAEIK4Y3iwAV
 kak42otWwrqne9f13e+J4sxoRsv3+/Gxi6MmVO1cnlylECWl3kGIHf5wCz9fvn7IzI
 n8azd0h9+DUo9S3Vg4DbsIzmfGXaAlgPQ6JgGgO/MUG11HfaEpMyEzbpKar8hgR+h8
 w8fcqA9ISpbjmZxOqbD1RQ02wVH2N2V9ca1q+CRt2uk0fMwHLytKG8qhsu81kpDd/D
 Sdyz3P+kViO386GugFaVZd1SiC9rj5lBFdksQeRFdbYAeW7q7TaYEf81o4T8g8y9Ry
 iZTMMj0lk7LGhhdzvcadojAP2CbY4mtgn8oBY/CouUxjOO0ux7Pczs1R4QTRXwuWtv
 AB6UPNybWFgdM0TgvbHKsEGseEYIzT3kBySm4f4LaAq79vnd4xS1hykhjEnZPcwW8N
 27+cKd0vL4N5vkJErrASrF4LgluH1SB+mYBg57PW3OgN3eC9UurWXsMga+KYWISFU3
 L2uk5sf/OgyTmLXH9Trxh3k35E2RllSlnNSGpXWl68pyDGvcPoBuIowAxeHJ4lnfb/
 a0DwqrSzwEE5TZLyo26urRiE=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so8690206f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767366952; x=1767971752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUR0y7X9sft5DMemPALEDh9JDsqLOfOgU92BZNduaGc=;
 b=GXTKDC9oWMLBYOCgUFV0v/Sb145Qq39DnLUedEh1WE3SmmTRkEKhoWF8t5i2FIcS78
 eLalusbr584Zy5nQXfQrMT4xlHcFbsbbkxI5gblw7agWyCKsChb774yAOeEkYnEIJnNo
 uWDuZPIYVF4krY4jjIkAqQTz+kkKtAkA/48RtQj1VbcR60vqJ1IAxTxprKnChPsJDtvo
 kVI1UPUyYk3zzzTiov2lGsTqNl/X1WhqeCiqzM9xFGaf6pjXoswOX7tDp5oop4raFEhx
 BwhfU/t2Lnzx+KlpAsuzIhutwBv90/E6RjIleW4agUxX8+B6aZ95KJh/bElem9e8vYzg
 QAMQ==
X-Gm-Message-State: AOJu0YzWbD5dQspkKcTrCXUokYNMGAKHZ5eMoVx2m8yvpm0qmb8byBgH
 Jajq8VXCCJECtoMsNK92kBnyYR9Id2qXvjIBklyBzcwCfyh2uN7TBRuuNQ6dZ9qM2N0ABq1TRy1
 mtfbt70ET3pSrXjfBISx2affSwZ9vgi0rVTFHM53KvlH90/aqzvFD+L0E+DUXdNWUAm2ZHgk=
X-Gm-Gg: AY/fxX6HVjpX83hSXjcS2vvXjNPektbdu5bU8r7YVERoja/Fe5+zj+IJrF/SgH4wIBS
 v3D4HVTHXwI5lKAHBykT6lqLA9Y+dGmoI+dAjkFju92nE5xDBxBtGlyvu4RFqP8x6/NS83pKu9z
 myB4UNA6WliFG6IxGtjpXzwSrETAcJFWHxsYaWpSDXKgkD5pJLRD7X2zfBOtk22Kx8c4rUD5usl
 yCckfzROCuF99u7jxZzAt6hJJnSE088x9FwUxtKQP3nOyfqTc1RJIYb2aIJrQp7Ro0FSE2wdOI5
 +/iwuxr2bBHO18h3kveRrTNxoFOf4FMJbs6TdPK+dE0ZhJamsMCZDPtsIQHARHIPmeaEmWAN/rs
 mof9bz1V/rJ52d2F+equGgXyi1171WDJmilOch0ikfYJfX+c4CZd1u5wFQKFs0bT5SdILKY1Htp
 qk3fJxRzQ=
X-Received: by 2002:a5d:51cb:0:b0:432:7068:17d with SMTP id
 ffacd0b85a97d-432706801f3mr28866870f8f.20.1767366952452; 
 Fri, 02 Jan 2026 07:15:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhmyj36XtRvu0NdYxti/4vxuhjc4YGP+B79COiel4yj5WpHyInmCkCqHweGSmp2JltC235UQ==
X-Received: by 2002:a5d:51cb:0:b0:432:7068:17d with SMTP id
 ffacd0b85a97d-432706801f3mr28866836f8f.20.1767366952009; 
 Fri, 02 Jan 2026 07:15:52 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4327791d2f3sm52393553f8f.11.2026.01.02.07.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:15:51 -0800 (PST)
Message-ID: <18a3fe38-c6dd-48e2-9273-c6862b99b7c9@canonical.com>
Date: Fri, 2 Jan 2026 16:15:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
 <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
 <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
 <CALeDE9NVNR8pA5G6um7p0CTmuQqmK4LWLoxj--jRKnBWJ5+dhg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CALeDE9NVNR8pA5G6um7p0CTmuQqmK4LWLoxj--jRKnBWJ5+dhg@mail.gmail.com>
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

On 1/2/26 15:50, Peter Robinson wrote:
> On Fri, 2 Jan 2026 at 14:36, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 1/2/26 3:22 PM, Peter Robinson wrote:
>>> On Fri, 2 Jan 2026 at 13:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 1/2/26 1:56 PM, Heinrich Schuchardt wrote:
>>>>> USB keyboards are identified via a USB interface descriptor or via USB
>>>>> vendor and product IDs but never via the device-tree.
>>>>>
>>>>> Remove the device-tree match string.
>>>> The commit message is wrong, you can actually describe USB devices in
>>>> DT, see e.g. Linux:
>>>>
>>>> arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi:              compatible =
>>>> "usb424,2514";
>>>>
>>>> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml:          -
>>>> usb424,2514
>>>
>>> I think there's nuance there because I think those USB hubs at times
>>> can have a GPIO to control power or something like that and hence the
>>> compat.
>>
>> I can imagine laptop keyboard can have the same thing, either for power
>> regulator or for backlight under keys.
> 
> To date the backlights have been controlled under different
> interfaces, at least on the Lenovo laptops, the Pinebooks (the only
> laptops we have in U-Boot) don't have fancy interfaces like that and
> the power buttons are some times different GPIO buttons.

Looking at https://gitlab.com/CalcProgrammer1/OpenRGB/ the protocols 
used to control keyboard backlights vary a lot between vendors.

But anyway the vendor ID and product ID is used to identify the USB 
keyboard and to look up which protocol it uses. There is no need for a 
device-tree description.

Best regards

Heinrich

> 
> I think, at least for what we support ATM, this patch should be fine.
> 
>>>> However, it seems this particular compatible string is ad-hoc and
>>>> unused. I wonder if this might break some users like RPi which supply
>>>> external DT and may depend on this support ?
>>>
>>> I've never seen the USB keyboards described in any of the RPi DTs
>>
>> OK

