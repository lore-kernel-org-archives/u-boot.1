Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95720CD128D
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 15:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04637880E4;
	Mon,  1 Apr 2024 17:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LY8IOVhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915B3882DC; Mon,  1 Apr 2024 17:54:36 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F74B8787C
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 17:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D18D54249A
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711986873;
 bh=Id0GinkNybFmzq+aoGeS4v6LW6UxMcRpDOHYiaidsh4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=LY8IOVhBMwQ64V6Y/YiWiZAr89Hs5ZdxfDMuXo9MrFIZEMb+RClBtzeBneTgcmneU
 iNLk/VhAGuTOpBB8iBHF2qtjEJkqrmeC/F320I9ESCWtpYnh4xctbcLnOMQQBmvXFv
 agRHF7OKG9v+/lLNIlDkZU/q00vCMneMIi/GZyuSV8Ldw1cTYweWe76Q8xvpqtW/o1
 MoOSU3T8QbkQ6fXiR/fPwmKpxAvnVFfsheqgbsnS0DeUKM2ASZRDBjUNGAiM866nuM
 nLUbGMAaZ7XnRQ1Fm/tEkBWYpNrxMl6e245K+z0od0MsmzU+iuIZS+AxvnngOIaBaj
 ap3Y0nXwGD57A==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ecf15c037so3840182f8f.3
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 08:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711986873; x=1712591673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Id0GinkNybFmzq+aoGeS4v6LW6UxMcRpDOHYiaidsh4=;
 b=FDpq8/6LIsfHFnsYemdkIhmoGu4baDF5p6rUlhSnVeW5yNGI+2ClcbI4JaPa0K9znJ
 J0ikTWztrlI8vvOsw38mpTLJnhdrqhGagtvIi3WAmCY7pchsj5E+S2wv2W46RpQuBSaP
 7vxc6umICr/0lwJnfVu59XzMoHjtSZwamsJtcZ7gS42wktHidJfA7Flh6+rstbRgU3GO
 9tABORfzxdSZlD4sPWjIEpaqZavc6zyBNtBZ+lqXCqYU55xcGgZvFKBLgPhGtXdfBeWJ
 UeBKW9FDO9iqNs504iUIqfxO3CAYLrPO7NZm/naoA9DUdqd3U7EI1yU6kOLDBWL6fOsP
 Wuyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTwieALj/j4OiG8A48G0QrXbu71IK7LDIpeFEy3HSeH7rCAEAq5G9TXTcV8vxuYobpVKeGzEXI7Hy4xzvwuQiLI1vvsw==
X-Gm-Message-State: AOJu0Yxe8tbWY1AfN8Y9xQH2ywT+PekLOQRzUHgFLSkXpxchcIdkTxZ1
 mUwQhMTpeeu/dMBcR34RPWA/JiQPyXcPlb+1uc4IK4qh+qH6F95pDNZtduiNeZqOJV7FIHzZdqW
 fRT3bRkJNLNU4UacVkUvIrOIFMd4uLTTqK9IDBw7wn/nmxpU//SuCoB25FCD7m0O0MQY=
X-Received: by 2002:a5d:4843:0:b0:343:2e09:3597 with SMTP id
 n3-20020a5d4843000000b003432e093597mr8744372wrs.64.1711986872931; 
 Mon, 01 Apr 2024 08:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOCd6Hp8sPAxhFOORfv3d6Uccg4RWDJpRBfGm8fFhJXF5Qcm1SWz7gQyOwGGSirRyk5RjNEA==
X-Received: by 2002:a5d:4843:0:b0:343:2e09:3597 with SMTP id
 n3-20020a5d4843000000b003432e093597mr8744352wrs.64.1711986872394; 
 Mon, 01 Apr 2024 08:54:32 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 dq6-20020a0560000cc600b00341c3071c93sm11925673wrb.73.2024.04.01.08.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 08:54:31 -0700 (PDT)
Message-ID: <a94ea391-5b0a-49b1-8277-f6d018ce780b@canonical.com>
Date: Mon, 1 Apr 2024 17:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de, Hal Feng <hal.feng@starfivetech.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
 <b5af9050-aa50-4445-9de3-4e5f368621b7@canonical.com>
 <ZgrSnExL1iTg8nSC@aurel32.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZgrSnExL1iTg8nSC@aurel32.net>
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

On 4/1/24 17:28, Aurelien Jarno wrote:
> On 2024-03-28 17:01, Heinrich Schuchardt wrote:
>> On 24.03.24 16:00, Aurelien Jarno wrote:
>>> On 2024-03-21 19:11, Heinrich Schuchardt wrote:
>>>> The differences between the Milk-V Mars board and the VisionFive 2 board
>>>> are small enough that we can support both using the same U-Boot build.
>>>>
>>>> * The model and compatible property are taken from proposed Linux patches.
>>>> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
>>>> * The second Ethernet port is not available.
>>>
>>>   From the device tree that have been submitted to the kernel [1] it seems
>>> another difference is that there is a CD gpio for mmc1.
>>
>> Thank you for reviewing.
>>
>> On all of Milk-V Mars, VisionFive 2 1.2B, and 1.3A I see GPIO 41 level
>> changing when removing or inserting an SD card using U-Boot command 'gpio
>> status -a'. So this seems not to be Milk-V specific.
>>
>> Could you, please, check.
> 
> This already have been answered by others, thanks.
> 
>>>   From the schematics, it also seems that the usb0 port is not in
>>> peripheral mode, but in host mode. That said on the submitted kernel
>>> device tree it seems simply disabled.
>>
>> All three blue-colored USB 3.0 ports are able to read an SD-card in U-Boot.
>>
>> The black port provides 5V but I could not make it work.
>>
>> On the schema I found:
>>
>> USB20: Do not support OTG mode and AVSS_USB0-AVSS_USB2 attached to ground.
>>
>> Could you, please, specify which node in the device-tree you want to
>> disable. I cannot see anything disabled for usb@10100000 and usb@0 in the
>> kernel device-tree.
> 
> Disclaimer, I have no such board, but I remember people on IRC trying to
> use the device tree from the VF2 on a Milk-V Mars and getting an error
> with the USB being in a wrong mode.
> 
> The difference I have noticed is not a node but the dr_mode property:
> 
> &usb0 {
>          dr_mode = "peripheral";
>          status = "okay";
> };

Thanks Aurelien for the explanation.

The node usb@10100000 (aka usb0) does not exist in the U-Boot 
VisionFive2 device-tree, yet. There isn't any dr_mode property either.

We will have to consider this node once we merge the Linux device-tree.

Best regards

Heinrich

> 
> This does not appear on the patches submitted on the Linux side for the MilkV
> Mars.
> 
> Aurelien
> 

