Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F96C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 16:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C694A82C79;
	Thu, 12 Jun 2025 18:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A7082B97; Thu, 12 Jun 2025 17:59:45 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2484C828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pom.pumba@gmail.com
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so6934155e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 08:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749743982; x=1750348782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3N7kzSTQPKxn9vGffRriLeUPtD8LGvBW4sSEdAV6Kko=;
 b=VfbVuUrhsiGNwLXho+RzrAkCl/j2ZZQVT7Lh13KLS+hSznBD7uoI1gcHmT1OpQKXEw
 t/Vn1y5dBJImQ0BIKNepQDOCTVxZXdyfxH5+R1uX/1Piro/IRR3S7vmcIkjNjXiqNX7U
 LKv4pe+DJvtKf7Dxa+nkzTxVzn/OGBbwxSnCZ6etGvWcgqu/3ytVGf+Y9GtlGKGj5MDf
 D/yobK+1ArDSgnYkbG2yTRf8uknTo2yZ+/6A1oUmGZkaE7QZSsuqsV1DQDqpypjJ9gxl
 ++62kaCEKo01agXYdxAA9e9ouJpZ5QRPmDesbUliegbLcuxHSB5NtMDxCUBtUfXAp3zK
 QI6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa4oN6emPAYvjT6sS3vZjRwsUrAMxBn6nE7VpkHfgP+PDjOUa6sZUR0FyZCXEFt0+rP71XG0o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx83QD27sE3PmzpiWDRgQnTdNI3ye1VFyRtsoeULWz/WsQZXp8b
 Yl7HwsmD9OC7e7g03+M6tB7Os0HWO1uxs0Fp2gyUahLfnsCWz9s9/BAM
X-Gm-Gg: ASbGncsWoXcibflVWs9V6pMDzAfLURGt3yczqEmi22ELirEbGrH00HFpwlat0uWPrVL
 Pc0WK6f8mkcIS4LhVgOIPzUG8L0+xPgnwQ/BUh4fbvKTDCZjGcRW0cQXYlsX0+TODPpwIUy2WB9
 GN2bqNCM+IzM1JNE3EbIDg8ugOpk43JaP3l7gE/Foe+tH8ACfZq9dvehDwnlOhMmYTa1qYH35yj
 Y51+lcpC5okatcZem+1oYiQS0GNyD9oCJWwddMg2OB4UdWAADtPuQZv3C4vnrq1hk1gOSMovZTT
 cYALcd/a0y1AWOW8iTfNzjJrbz2Vqm7QlAQ38od/hHEefyrqujawpem5spHSyKckDagIC1imdn3
 Y4eMueXf4VgKm4vrT3VkkxGy1ii7UZsEAGA3wFNEbp5kwu4Q8Sx2fqnOH1rTsAZf53feLwAodqn
 ftsY35CTo+5wZIWTKp2akx
X-Google-Smtp-Source: AGHT+IGhlEEckzPPGoFuHLiiWING6BXdKJleEq+YbCxsCZvE3/vWZdCcO5YoECkCWgC+Szd1W1eSrg==
X-Received: by 2002:a05:600c:a409:b0:442:e03b:589d with SMTP id
 5b1f17b1804b1-4533436f9f7mr1680345e9.24.1749743982096; 
 Thu, 12 Jun 2025 08:59:42 -0700 (PDT)
Received: from ?IPV6:2003:e0:6f23:53de:74bc:ab1e:f82a:e3c2?
 (p200300e06f2353de74bcab1ef82ae3c2.dip0.t-ipconnect.de.
 [2003:e0:6f23:53de:74bc:ab1e:f82a:e3c2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232219sm24165735e9.9.2025.06.12.08.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 08:59:41 -0700 (PDT)
Message-ID: <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
Date: Thu, 12 Jun 2025 17:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
Content-Language: en-GB, de-DE
From: MichaIng <micha@dietpi.com>
In-Reply-To: <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 12 Jun 2025 18:09:03 +0200
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

Hi Quentin,

thanks for the review!

 > You could set the eth2addr in your board file if you wanted instead of
 > setting it for everybody.

We provide OS images for everyone, and our users complained about the 
changing MAC addresses. I agree with them that generally the exception 
is that MAC addresses are static by default, and randomising them being 
an optional privacy feature when connecting to untrusted networks, like 
a WiFi hotspot with a mobile phone. Setting eth2addr in boot 
script/environment would require a random MAC address generation our end 
on first boot or so on each system, to rule out collisions. Since U-Boot 
has the feature implemented already, it just makes sense to make use of 
it and extend it for the affected Rockchip builds, also to have the 
somewhat nicely aligned with the last digit deferring only. So we 
currently patch our sources.

 > What's the number when we'll decide this is too many? I have a board
 > with 5 Ethernet ports for example :)

Good question. In Germany we say "Aller guten Dinge sind drei" (All good 
things come in threes). Jokes aside: not sure whether there are Rockchip 
SoC boards which provide more Ethernet NICs, but I have 3 with 3 ones 
(in one case provided by an official expansion board), all RK3588 with 
two onboard PCIe adapters. There is another PCIe bus, but commonly used 
for an M.2 socket, not sure whether it could theoretically provide a 4th 
Ethernet adapter. I don't know the background about why the Ethernet 
driver/firmware is not able to read/assign the hardware MAC, or why 
there is no hardware MAC, as I understand that this is an IEEE 
requirement. So what U-Boot does seems a workaround, and I agree that, 
if there is no generic approach, it has limits.

 > I don't know how far we want to go to avoid defining unused ethXaddr
 > variables in the environment? We could use of_alias_get_highest_id for
 > example and generate enough environment variables based on that info?

This sounds reasonable. But are ethXaddr variables not generated before 
boot scripts are called, when the number of alias IDs cannot be known 
yet, and MAC addresses assigned afterwards, when the OS device tree was 
loaded? When generating the variables afterwards, all good, but then 
existing values assigned by boot script/env should not be overwritten, 
of course. Then a generic approach would be possible, incrementing the 
bit mask by one each loop, to assign up to a quite large number of MAC 
addresses to ethernet aliases.

Best regards,

Micha (aka MichaIng)
DietPi project lead
