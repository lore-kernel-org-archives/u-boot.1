Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6731C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 10:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A0182BA1;
	Fri, 18 Apr 2025 12:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VZ9yZrl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DCA82BA4; Fri, 18 Apr 2025 12:45:03 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC29A82B9C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 12:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5f620c5f7b9so1471892a12.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744973040; x=1745577840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqKMcVOQlT7F/mdSgilPAnViDEKDUn696CoR8+gxb44=;
 b=VZ9yZrl0FM3JnMnkWx29KTbDgsz+lnYNMyjo7AE3maChCN/gRUyZSldRlzw1eA0at+
 iBw/fyABjRs6e6mhGWf1EIR9r30NXweOo4eCd0CPvlg0TAjmgMqKWgmBM6GAfXRULc4p
 EGodh+9Gsqt9tbD1JH7qjD0SayoXoU51i5/tI+p0/grudnUUo1Q+TPppasu6FChL1i8c
 QOQdAjSXUBWN6Ye+UwbnfypLHIprHyPOgU6dQd68eLjvn+4DZHcpAV0Yb3tilgyIl0vw
 /35g0XPn1GbDRM5CNhJqoaUWMAaqXnQbum2IvJ/B41Aas1FwPiUtUOhnbPEcIAKo/+Gs
 DL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973040; x=1745577840;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqKMcVOQlT7F/mdSgilPAnViDEKDUn696CoR8+gxb44=;
 b=dP8BS7b3HNYX9pZJ1ZuRsn4ezWQ37sL2c7U0Jy5TQC1LLT3QFvK2LqZApzLJh/Oqef
 HfKqAEn7aSOIsBV8BZLUDa//2HCLi39rxEhaiqq0SpUYDq3M375kXBY3Stkc0BytvL11
 U6lyZ1xPvAoP5HagfZPixmza0mtdnFgwO++ixi9wvgc9AbnRsk04XJc9a61udo5Yvrtr
 TXNkcwwjIkxJfGqrx/3kEFmpLf2gr8T/D1t5IQgs32cbt+3Qyi6kiYiAXdES+wd4WH9g
 r9lxWYU+wvOFGDzSbl+d06GuydIb02A2/N/nG/saYvNpP7IB8CI8ebytiHaH8IFL7tFZ
 2EBw==
X-Gm-Message-State: AOJu0YxA5xxQh+KbLLsoPlnlnNkvrNTQyeRsHbiPNfYJdHEkdU5A3OLh
 GngaMWGcbEclex0k9CNEyVRuod3qQFGRoCy/lAL40SBjPySxs6itBZ2bcm8F9sQ=
X-Gm-Gg: ASbGncs3xlfJ4UBZ1Vg8T8xxm9GeLiDylpzQksxCNcLcDusGub2o4en6yuK8CSKRn/c
 ncasFlF8Y5l+iQSK34Q3KcaMoC1UoOOMaGucmUEjIViF7sMO80nNiF1ykoWe3PPKLa6yADk91BA
 1LWb0YQvhNIkWfiLvHJ6CvLsZo1BYfoL3SQZsxQkEo19uNy60CpDGq5GL5tKWA+JyhZZfM7zOjQ
 uNt5AWTqNYPjiKtGN3MdJ1iw7mxD+7YRxpKzZK8W6+vuowIg/242WzOphOIowt5QN9I1OwF0Vls
 CKUZvcLdsnuEw0l29TXlOcsqqzKDrkzXACyYS1tdsjqk6ReY
X-Google-Smtp-Source: AGHT+IFvi20lEw2MAejG/XERp5+6Si/Xm1dFOETfg01KjGmVB5xvUn69PaABQ9nuOYt/bIs84/CDvA==
X-Received: by 2002:a17:906:7315:b0:ac7:d0fe:e9e4 with SMTP id
 a640c23a62f3a-acb74b2c99bmr199246266b.19.1744973035384; 
 Fri, 18 Apr 2025 03:43:55 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec90a95sm105563566b.76.2025.04.18.03.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 03:43:54 -0700 (PDT)
Message-ID: <e5f9b2fa-a7c2-4770-a6e8-c60825d011e6@linaro.org>
Date: Fri, 18 Apr 2025 13:43:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 1/3] usb: gadget: atmel: Add SAM9X60 support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-2-admin@hifiphile.com>
 <174427495638.286402.9855514984625058076.b4-ty@kernel.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <174427495638.286402.9855514984625058076.b4-ty@kernel.org>
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



On 4/10/25 11:49, Mattijs Korpershoek wrote:
> Hi,
> 
> On Mon, 31 Mar 2025 18:26:07 +0200, Zixun LI wrote:
>> Compared to SAM9X5 the only difference is the DPRAM memory from the
>> USB High Speed Device Port (UDPHS) hardware block was increased,
>> so we can reuse the same endpoint data.
>>
>> Also add compatible "microchip,sam9x60-udc".
>>
>>
>> [...]
> 
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)
> 
> [1/3] usb: gadget: atmel: Add SAM9X60 support
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dc22cf37af6d604513f8c6f02d4cb551d5a59435
> 
> --
> Mattijs

Applied 2 and 3 to u-boot-at91/master, thanks !
