Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B7DC28B2E
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD9380F9C;
	Thu, 13 Mar 2025 12:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Oa6t0ToM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B879E80756; Thu, 13 Mar 2025 12:45:38 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B81C80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so491524f8f.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741866334; x=1742471134; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WTGhuLzPwyK/czq5TYKKuPWOGdo9jL/3hLX3f4patK4=;
 b=Oa6t0ToMyBZsa0/7Yx9wTMdxv9K9z0CUYxgqpNts0KMoDkGVABrDT2hI7cI5WnbekR
 Kv3HoqgKxPIUcFcKzzbSxdf0U7duu0FIGFkWckJhlElE5V5zj/gwKAAbTxqbN0wTyKO5
 1hIuONTJry7mwae87Tnrd6igKbxyf4YcZou7jQP3BtLsVgkBboXpEIjgPSx4SXjANinX
 Q+5JPHQPH4JS818bP9j97CKbC6kzlfYRt+1lBjzA5Ef8f6uuI9OxnCwzjiB2UsfqLGTa
 6fTgVlBTsHbRSAUcaBU6cI2cXzW6CiVH4kSXgBOtcJ0P1+FLsATY30Qss0el91xLFQsm
 r5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741866334; x=1742471134;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTGhuLzPwyK/czq5TYKKuPWOGdo9jL/3hLX3f4patK4=;
 b=WXD19zJYPyukPpDxgBNzG7CWg9Yg/w6ZDuVCpaM0HNtPe2TbnMdd8x5aXhYqgwOkPh
 s1++gkXsAQ7uyjavz1w3c+cFJblsou6ii6RScE2032lboSzz3eI1gZL4lMxKQhpih3Dt
 hnUPE96ei75QStowxDP/zRsFoTXVvfbY5+IUYtTuXizwolxNCxeKfCdTynUDvjAhEP9u
 7Z1c7+TfXheu9OmuAWG9Qd8zERa99lx8w8OKR6jwEZ1MPfZ+0aGrP1A6jz25VqA3bIkL
 hn/AfihwuRaJypqnWVw8I8CNFwCFU77eeUHQwISi0tPoJJ9ts6Y9huyzKdtmvPiT41cJ
 KeSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4q3DmT/5VZ+7k4g+9jkcvHIVZPc5ma98o0mIq2eS+8HDiNhvG8JCRV9bf3zXeKVhaC0GN77g=@lists.denx.de
X-Gm-Message-State: AOJu0YxlM6L4GnQjKLRVVUWo+rbL6MFBM/tZYUZbITZmtqFW04zt7+U3
 W/iXHg6mHvnF2c3OXXgO2damFdrwUVFu02sLFNJ3hkHlnDg6cZxF8f/Wxxx25Kk=
X-Gm-Gg: ASbGncvySR3sFmFl+RpJEnvSTqAwU5fPryDVMm6dI7+dx98Wdw06EzembaOSjOS1kRu
 VgUHlX8QSfu1T0n8s4exq8yY16OUe955SpHZurWBEUHqD+9GJQMHft+6SjxdspEsjYH9A6k0WqQ
 YFPnZRatDSTQAKsK7URnCFKCElcDOMja7inc0IpLFh+dpJgZHReVG3+2Dre80ayDOALeFKYVDPB
 Y1BpCM2pSaCwpFcrDEMgSpN2EYMQSkTa/JWGAAQXv2I4icoo4foxfellbx0qUX7synizREhaaO6
 0xRWiJYrRR42L3EwzxGLl/0uAi7HIqGSeS9RfrDqBg==
X-Google-Smtp-Source: AGHT+IFABLU/4dwCV6mH6XIIFlo//mvKBelc7ReafWJ0Og/3r+Uhgf6XRiW0mp1TNJrt2C2R+1rHTQ==
X-Received: by 2002:a05:6000:4103:b0:391:39fb:59b4 with SMTP id
 ffacd0b85a97d-39139fb5e40mr16241756f8f.27.1741866334451; 
 Thu, 13 Mar 2025 04:45:34 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6e87sm1935793f8f.32.2025.03.13.04.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 04:45:34 -0700 (PDT)
Message-ID: <335a650a-1401-40ea-9ce1-fa86a66b3906@suse.com>
Date: Thu, 13 Mar 2025 12:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: rpi-2025.04
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
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

Hi Peter,

On 13/03/2025 12:18, Peter Robinson wrote:
> Hi Tom,
> 
> Please pull the updates for the Raspberry Pi.
> 
> Updates for RPi for 2025.04:
> - Copy Bluetooth device address in DT
> - Keep warnings from firmware in DT, if any
> - Only add frame buffer node if CONFIG_FDT_SIMPLEFB is set
> - Add identifiers for the new RPi 5 series
> 
> The following changes since commit a383b9bd4d7e430fe7c254297540bae596649dba
> 
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git <https:// 
> source.denx.de/u-boot/custodians/u-boot-raspberrypi.git>
> tags/rpi-2025.04-rc4

Thanks for taking care.

I wasn't able to find that tag but I think all the commits are in branch 
rpi-2025.04-rc3 [1]. Maybe you forgot to push your tag?

Regards,
Matthias

[1] 
https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/commits/rpi-2025.04-rc3

> 
> Apologies for the later requirest. I was out for a medical reason, so I've 
> limited it to simple fixes/bugs because it's later than I'd hoped.
> 
> I'll do the remainder for the next release.
> 
> Cheers,
> Peter

