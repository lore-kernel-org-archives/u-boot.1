Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFE3C10DC1
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 00:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2F487073;
	Thu, 30 Nov 2023 01:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Caw/NIR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE523870B3; Thu, 30 Nov 2023 01:20:38 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD22786D33
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 01:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d00689f5c8so4003675ad.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701303635; x=1701908435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bpJduYuROYEa7GlONa/imIaOhaPtws/KthA5P0/Y0do=;
 b=Caw/NIR1W9UI7Dp5rf5XLMICvurnW0d41+vXbrL7h4t09fwJ3PYekrMVE0weS82PJ6
 zWM8EdhwKkzITo1yyfTh6bEbIqiXNZ1E2MVT/O6SqjBvBpFDWCibpfxFT1NxAtqsKCNO
 XsHuyc9dQKvBdhsb6XK6bEbxrXOsuZsyekqMo2quSnRz7E5jczF5FpOuKrtJSB7tNGf5
 cfkn+E4AU6iAO7+ZA8Hhv4xp4g+RT8p5bhFwfkGzsW/gjCbgmdBY9TOvClXvJN6M3oiR
 5Hhlb7Iy8+iWwL5an7G8dkNcnJqsOFlOdm5nCv5CGPedCy1h6wn5QSyQClLYUSVaZfvi
 mdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701303635; x=1701908435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bpJduYuROYEa7GlONa/imIaOhaPtws/KthA5P0/Y0do=;
 b=AUPBaBVVu2ub1ISE8w5P3fmtbgsYi+rrtyL4fbqC/4wbWvquqQrlW31QDurd6RZn21
 ljakUTqFcGEtAXovb6NnDma1ygJJ7/JdT1nY7rnFvS0FuQkI4NWWCORVUgwORXibbgMB
 cIYsLjyO/eMP7d3Z/93uVDeGnzpUOAA+mrzZL2OHVnY52ceM4r+Ewwep6xjYXJnc5aCs
 b5JTESPPVF03MCWz2psyEuil9ZQoZokByyyg5DWvemUPw9Y6uv6pezYZ+YxlT42Z26TL
 eOXnzyENlikpJRzFThimQWopuJfMTIGszaV8+fuuIRXyifIAURO8dNY7O6KLjy3znJwh
 5fkw==
X-Gm-Message-State: AOJu0YzrGQjqHXYvwjdbg1JZyVh7+WNEgpNappHSVe7gtz3TWEENk2lG
 Vr2nobbWWpDCzekvGR84osg=
X-Google-Smtp-Source: AGHT+IGGyCcUq2xQjNrW9L1yMPDfpnoUlFv5iZtC9TBlRTPaxJJ1c97PEYFMHgxIaJTLAnInk68qeg==
X-Received: by 2002:a17:902:c3c6:b0:1d0:3090:9584 with SMTP id
 j6-20020a170902c3c600b001d030909584mr455213plj.41.1701303634914; 
 Wed, 29 Nov 2023 16:20:34 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a170902c28100b001cf658f20ecsm12992036pld.96.2023.11.29.16.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 16:20:34 -0800 (PST)
Message-ID: <a2e62d55-8209-432e-b01f-253e05c11186@gmail.com>
Date: Wed, 29 Nov 2023 16:20:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mdt_debug write
Content-Language: en-CA
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
 <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
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

Thank you for the update Andre.

The flashcp worked.  I rebooted without an SD card and the new u-boot 
started properly.

Now as to making a patch file, I will give it a try.  Keep in mind that 
when I started my working career the concept of patching was to shuffle 
a deck of IBM 80 column punched cards.

Console output:

root@orangepizero3:~# flashcp -v 
/home/sysadmin/u-boot-sunxi-with-spl.bin_with_792_clk /dev/mtd0
Erasing blocks: 206/206 (100%)
Writing data: 822k/822k (100%)
Verifying data: 822k/822k (100%)
root@orangepizero3:~#




On 2023-11-29 3:57 p.m., Andre Przywara wrote:
> Hi Stephen,
> 
> On 28/11/2023 20:07, Stephen Graf wrote:
>> Below is the consol log from trying to use mtd_debug write. It 
>> returned immediately with a strange success message.
>>
>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 
>> /home/sysadmin/u-boot-sunxi-with-spl.bin
>> file_to_flash: fread, size 0xf0000, n 0xf0000
>> fread(): Success
> 
> interesting, I was under the impression that "mtd_debug write" would be 
> the way to write to flash. In hindsight, the "debug" in that name should 
> have probably put me off. Anyway, "cat" is probably not a good choice, 
> "dd" is better, but it looks like "flashcp" (also part of mtdutils) is 
> the go-to tool, since it does the required erasing automatically and 
> also reportedly does some error detection. Can you please test this?
> # flashcp u-boot-sunxi-with-spl.bin /dev/mtd0
> I would test this on my end ASAP as well.
> 
> Do you feel like sending a patch to the U-Boot documentation to get this 
> changed then?
> 
> Thanks,
> Andre
> 
