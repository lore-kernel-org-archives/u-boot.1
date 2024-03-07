Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D5C54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 01:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C503D87DB3;
	Fri,  8 Mar 2024 02:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SEucXzTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9982A87061; Thu,  7 Mar 2024 23:36:27 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D7386F6E
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov0322@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412b30be60dso2012045e9.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709850984; x=1710455784; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XIUDgwa5EN9JM6D/9cW8LV/Bhn8GFcL+J33FNXlOTfE=;
 b=SEucXzTf4zSI4CKhve4Qkjli3iPsc0OCC4eCHSdWjFAmQ3eszWMtn1hHmyG8MBkAE4
 PgJiKHwkJbv+q/HsqrX3v51TverVu08Qqu31VoanAIblnpi70bfD3Z8ckQKbEhqqx3xd
 KtvP1YP9fSlUZxguH7oBWCnD4dNp0vmz40HksHxrPOgm+tksVce5W8rzvoyrXhG6mo07
 bzeEPR7fbLKsqgm9em/aOmNpKGEQAMlzRjIcql1NaGpbxj1MSTx+iUOLtldctJiFh5kt
 efwOpMkbUE1ONAV9Em8vmaxHzC8O964P5oLHty7JozzDVUlWeSjWp7597/TvbrI9FlNz
 upwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709850984; x=1710455784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIUDgwa5EN9JM6D/9cW8LV/Bhn8GFcL+J33FNXlOTfE=;
 b=B2Sgax+CqBNMhCqXf4DIe1zT1ZSVlu2i5AZj88Geo5E4nURi/faT1i9f59XiB6Vh8L
 kYCn9b+F/VYEPbIVOMEifTm6vw2S1hntkxixh64iOKjiEyrd9jWJw9NwV6QEActMKkt2
 r7v42s6XNjflcCx4v3wxqmKl4es69F7V5l/12Ya6hiYVsxqngUuvcNE8RXrDktobksDI
 26vn2D1rpA74ehEtaaSougepJyIwm4U3CMuTaRpOg9dzi/T5cXkonyu8Pb/307u0x3QQ
 1jZG3m9J+aB3a+Ur+gpmwaCsC9KpDrrGXQg4YmnYkbcvTieB2jAnGDQio05MtxADkoMq
 AkJQ==
X-Gm-Message-State: AOJu0YyZCCIfPGtpEBBdyHa+bbySsMZ8N0448EKtKlagKsaY29BG1aTr
 GNutuIKR0nX630QRWgTv99f2YnLabcp0aD1n5RSb+7H81eohBqxynYBlgIRq
X-Google-Smtp-Source: AGHT+IGHX+64QPzWiWKIol16TJdkqkJE74oizWYCEDWJvYsXHavhcESGuhBhc9In8uNloKIEqsw7tA==
X-Received: by 2002:a05:600c:4f48:b0:413:7c2:6639 with SMTP id
 m8-20020a05600c4f4800b0041307c26639mr105285wmq.4.1709850983997; 
 Thu, 07 Mar 2024 14:36:23 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:3c69:a13f:39c0:f2bc?
 ([2a01:4b00:d20e:7300:3c69:a13f:39c0:f2bc])
 by smtp.gmail.com with ESMTPSA id
 co14-20020a0560000a0e00b0033e3ce48ba1sm12454664wrb.16.2024.03.07.14.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 14:36:23 -0800 (PST)
Message-ID: <05868d76-697d-4528-b4f4-52ce82c29766@gmail.com>
Date: Thu, 7 Mar 2024 22:36:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: Fix paths in the bash block
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, yanhong.wang@starfivetech.com
References: <20240304221532.368453-1-ivan.orlov0322@gmail.com>
 <5d6b9fa0-bdac-47e6-8b2d-62ee3702227c@gmx.de>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <5d6b9fa0-bdac-47e6-8b2d-62ee3702227c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Mar 2024 02:37:09 +0100
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

On 3/5/24 19:52, Heinrich Schuchardt wrote:
> On 3/4/24 23:15, Ivan Orlov wrote:
>>  From the current documentation it is not entirely obvious where to take
>> some of the u-boot build artifacts in order to flash them to the sd
>> card. Extend the "Program the SD card" block by providing relative paths
>> to the jh7110-starfive-visionfive-2.dtb and u-boot-spl.bin.normal.out
>> files.
>>
>> Add "$(linux_image_dir)/" prefix to the Image.gz and initramfs.cpio.gz
>> files in order to provide some information about where they could be
>> taken from.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>>   doc/board/starfive/visionfive2.rst | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/doc/board/starfive/visionfive2.rst 
>> b/doc/board/starfive/visionfive2.rst
>> index abda8ac21b..031d66fbfb 100644
>> --- a/doc/board/starfive/visionfive2.rst
>> +++ b/doc/board/starfive/visionfive2.rst
>> @@ -103,15 +103,15 @@ Program the SD card
>>
> 
>>   .. code-block:: bash
>>
>> -    sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
>> +    sudo dd if=spl/u-boot-spl.bin.normal.out of=/dev/sdb1
>>       sudo dd if=u-boot.itb of=/dev/sdb2
>>
>>       sudo mount /dev/sdb3 /mnt/
> 
> Following the instructions the partition in not formatted.
> You won't be able to mount it anywhere.
> 
> Looking at the boot log the author FAT formatted the drive which is not
> recommendable.
> 
>> -    sudo cp u-boot-spl.bin.normal.out /mnt/
>> +    sudo cp spl/u-boot-spl.bin.normal.out /mnt/
>>       sudo cp u-boot.itb /mnt/
>> -    sudo cp Image.gz /mnt/
>> -    sudo cp initramfs.cpio.gz /mnt/
>> -    sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>> +    sudo cp $(linux_image_dir)/Image.gz /mnt/
>> +    sudo cp $(linux_image_dir)/initramfs.cpio.gz /mnt/
> 
> I have no clue why all users should copy the kernel to the root
> partition on the SD card.
> 
> If you have a Linux installation on the SD-card, you want the kernel in
> boot/. But this board boots fine without any SD-card from NVMe, USB, or
> eMMC.
> 
>> +    sudo cp arch/riscv/dts/jh7110-starfive-visionfive-2.dtb /mnt/
> 
> Copying the U-Boot device-tree makes no sense it is already available at
> $fdtcontroladdr. If you ever wanted to copy a device-tree, it should be
> the one provided with the kernel.
> 
> This whole section is rather misleading for inexperienced users who just
> want to boot a Linux distro on the board.
> 

Hi Heinrich,

Thank you very much for the review. I agree that this documentation is 
far from being perfect, so I will try to improve it and fix all the 
flaws in the V2 of this patch :)

-- 
Kind regards,
Ivan Orlov

