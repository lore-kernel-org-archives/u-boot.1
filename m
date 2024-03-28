Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94720CD1283
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105F28818F;
	Thu, 28 Mar 2024 17:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YsCP90Yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398D688193; Thu, 28 Mar 2024 17:01:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011BF87D9C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 17:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 400CA42482
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711641709;
 bh=HoupOopB+/w00YGoaEBJO6bI0/AGMBhUb+dRU9j36YE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YsCP90YfJ3mhrvmZvgbGcpWaTM3GLudfh1NibmpxDNfFFAYMPe6T5Q4j9QuKFbEEQ
 nz2YwMtrYKoQ27rtwjbHebgSASTXMnKuWGjYdnvMpxhK0mjTqPgNOXSrxtalrGOOSY
 yrsjQ4MWSFUFQjgkd4FHXlwaELJ0WlHG9KJHWCe8DNeN9DNeQ/uQKB/a5nwO0jrqcJ
 X5/p6dJCxEOvp15Vdzj2AOZAKXEl925kOyXWzQz+QQziUMoHGDWTqRDCKRAiuoZeeA
 6DvH0KjCDjwiSk6R2i+SipJ9NBTNv7S9C2MAAkRtIUlSr86T46ge21kfJWxy4qjvNj
 MYFnh1G8IvtuQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4148b78d733so5644775e9.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641708; x=1712246508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HoupOopB+/w00YGoaEBJO6bI0/AGMBhUb+dRU9j36YE=;
 b=L4+YAB1/j7eWxYYA0Zhr7OLs+Os5K3mCBN4Cp6xrhbQjnuIBbNfb6khe++jOgvwNkz
 CZMWVZg2ZbPWvBK+yQeEPV5X99Xs3Gu5zKMjJV8EuXVGxdA15vcsY9IiUKEXI0vnvTuL
 X5Q1aH5RG7hhD3L0YtsHAZArxqB1AcaOtU8JTZKwQm/YAMbmxZQ9mxbRvmL58P2AiWW0
 uplC07O1cF8zp36dqIjAnpmWXEpl8S4tgN6SrAjwirHqXcFLELEqwlCcOnmyixXi8j41
 SOAlelqOhrm7JhI8tum0yX8BP0olyK0X1wA/DImpqYyHIyVMA18Ufej7t17H0ygc/Exq
 xSbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy+TWZpkYyO2HfOuXAPWWMHxOTi96ut24IKQnN3rjpSk1bzz+bSOMUBYVVc8Zq1qnRXNTrSkKPVzsbUlK61r1NdGjo7Q==
X-Gm-Message-State: AOJu0YzR2Q70rjVD6xGXEID0Qz9FuSbcVH/SI4XyQKHn97Dg9mmuijJb
 p5EeSK+PvFrHRjoF3meTgjd2slWN2w3X4mFkB+8IkHS5lhuz0OYwTUhb+OXvenA3PtSGq1eCPqv
 TZUYXBZNuN9abNvXPFA+noW0f9R5JLlWHPhUB/g+n1V8bLYdS8oOMq5I8nZwqSfzOoxM=
X-Received: by 2002:a7b:ce89:0:b0:413:ee4b:cd8e with SMTP id
 q9-20020a7bce89000000b00413ee4bcd8emr1862267wmj.24.1711641708636; 
 Thu, 28 Mar 2024 09:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJdYKsobZ6wiNENDP2d1ZkfcLGRmSXyaHxNmnyXMAvY0H8REMhG9cJPOImZTLj+fSNQfqGQ==
X-Received: by 2002:a7b:ce89:0:b0:413:ee4b:cd8e with SMTP id
 q9-20020a7bce89000000b00413ee4bcd8emr1862237wmj.24.1711641708243; 
 Thu, 28 Mar 2024 09:01:48 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c154e00b00414674a1a40sm2685216wmg.45.2024.03.28.09.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 09:01:47 -0700 (PDT)
Message-ID: <b5af9050-aa50-4445-9de3-4e5f368621b7@canonical.com>
Date: Thu, 28 Mar 2024 17:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Shiji Yang
 <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZgBAFWBB0-213CfQ@aurel32.net>
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

On 24.03.24 16:00, Aurelien Jarno wrote:
> On 2024-03-21 19:11, Heinrich Schuchardt wrote:
>> The differences between the Milk-V Mars board and the VisionFive 2 board
>> are small enough that we can support both using the same U-Boot build.
>>
>> * The model and compatible property are taken from proposed Linux patches.
>> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
>> * The second Ethernet port is not available.
> 
>  From the device tree that have been submitted to the kernel [1] it seems
> another difference is that there is a CD gpio for mmc1.

Thank you for reviewing.

On all of Milk-V Mars, VisionFive 2 1.2B, and 1.3A I see GPIO 41 level 
changing when removing or inserting an SD card using U-Boot command 
'gpio status -a'. So this seems not to be Milk-V specific.

Could you, please, check.

> 
>  From the schematics, it also seems that the usb0 port is not in
> peripheral mode, but in host mode. That said on the submitted kernel
> device tree it seems simply disabled.

All three blue-colored USB 3.0 ports are able to read an SD-card in U-Boot.

The black port provides 5V but I could not make it work.

On the schema I found:

USB20: Do not support OTG mode and AVSS_USB0-AVSS_USB2 attached to ground.

Could you, please, specify which node in the device-tree you want to 
disable. I cannot see anything disabled for usb@10100000 and usb@0 in 
the kernel device-tree.

Best regards

Heinrich

> 
> Aurelien
> 
> [1] https://lore.kernel.org/linux-kernel/20240131132600.4067-2-jszhang@kernel.org/T/
> 

