Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90B8E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 15:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528448036B;
	Fri, 10 Jan 2025 16:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qbHK8tA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B9C805E9; Fri, 10 Jan 2025 16:14:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8F0801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736522032; x=1737126832; i=xypron.glpk@gmx.de;
 bh=F7crncZipUjp6nIFOGb6UwBSqUhpqaof/tEVN+sDXzk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qbHK8tA8Tlm/O3Wb3VR44q+jXuQMpWNMy1o89+2Qbriz4vuiq+3UIqGU9SMBS33e
 ewdVgbX4FOIxokNjCNO6ANCaVpy3HGikYl1OTPKpCzHz1hUGvP0rPc9U91v09DLL0
 o2AZW2xD+/0zj4CfLunvd7ldbOeQnVUEIEQ1k7yDDuWHlbQD1DB2+CKphM7bkw9s3
 emIKK5BzcUkqnuxURlFTqWXYdeR4rl6TZecxZidB7XYTNa93mfAr6xK8qZZibCway
 M9QNp+AGy3hwEGK6oEY0H3qWU/UIxLJGhl1GJOD4FvMYTY5i+xOiuZ9TbJM37Pu49
 Lfkp69AdBgA2c+yYRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1ta7GI0x4g-00GdrX; Fri, 10
 Jan 2025 16:13:52 +0100
Message-ID: <d5f2510a-2a72-4408-8cbf-8d32a3b738ba@gmx.de>
Date: Fri, 10 Jan 2025 16:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@linaro.org,
 ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
 <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
 <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ioDMHcL7gmY2/fFY1vs1K+5mqjeTVGlODZrPRuEG4PITu9TEgFO
 ibMtwGuYsRj3MDK7KA4tyO7XkGmsfy3fwhuUAnBNwKsiCVs03AYyiG00n6Z3eZibJ/73J7U
 DAVxWVP78znvnMXwIRKKS0R7dpVKr7B2yowybfhs81MX+cjl/MokU00p86VLsqxlx3iS9ct
 VDRUFzTgUBe/K/7G4Bllg==
UI-OutboundReport: notjunk:1;M01:P0:A6toyk8rGEA=;xLbaPupJq6rAYBGrBeJrnsestGH
 45NX7ZgUXn0KfgtoSi0dTP+TZ+mx1CVpxGQwQwIjZmYdeM+5uja0ZCEGD1i9OYtoRUPZKH8A8
 omUw8uso1rKkjwHXDI2IIv4H6K6zymuQEoxXdO730YG8UZBKeJ5RJ33Q7UbPYmNuyUa9dibuc
 HrIg2RtA92PuDyZimheNXpQdnnS6vNST7f/gnYfOw51JWGthu9qTD4/k1MlJ2gW81Xndwos27
 btwWN5cpYF5LizdHiVYMg9Hlwm37cBgIdkdnG9h+bbfT3btqZfT8qZeI0llWIy+xtipl7+F6M
 R8yPOemn/hUUp82R/eMYNVYQu99Dd+j6E9JkU/RYitPbbeT1dAIFhqFQOEeneWjVn/Jr3feik
 HKhTuWCjsXqObyKZ0WygL2vmlbvxID3GZIINFSg/uaLk6yc7pGLaEAJCFO7vTXUvrhBwcJQa3
 mpevfraj44OYGXgK/g4a+f1CWCdGTJEWx9J2sSziQIWhWmH2Y6z3nxmAfsKsrTP6TzMUW2Hu6
 C+/r0lJPRyF3G2e0ta1Q7lgPys9PSNprSqy1TRIFOKCBZT1gsZ0XDk8c74sa8/6EMu5aE1EPC
 ++qN+BDrl4HStQffbsEThH2zsumlYlpGDAz0SJZezwhqkyKkAd4yWwcfWLGnhUs/SSXPE2td/
 npj54Q+dH3gONkldKX6PGIhoPL5i+FDvf6e7GM2vTln32tyj3W0qjI42yBVe4TBNGuvrhLd5+
 BDXQYX0kz5zPmUbYh7kr2P5GlCkSLsxadn2coa4ZsYVe/TUGirkqaYb9FylwG2IusQYh0tHCL
 i2MJ0KMT49mOnPk5OgYJDpUinRR6sSB8esTTIdVBwBZjZ0es14gLmF7t0NhfiSRNJ7xpkbPaA
 OBryqQzaxBXFwUhbdLWW83h+JV88fwVKpaVWHUUFO6XMTAzdtowNMP/XH9qs5VyFuOhJD8M05
 WnX3tLAhI6xDQ1c2T45JjWyXNyqd7GYmvpfp5u5NiZN5GoI2mdCSxtkStDan38Ns1eWAr2qvB
 MqXZ7Es2k3aD1uzjostYYpkz8FR6hcAWy8OegvIYgWyBLyQCBwSiFp+aOBQe/OYI+c7dANKQ5
 /PVf2q7lF0J7GCvCmHTmp+gyvOD1Ax
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

On 10.01.25 14:40, Simon Glass wrote:
> Hi Heinrich,
>
> On Fri, 3 Jan 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 06.12.24 18:30, Adriano Cordova wrote:
>>> The command bootefi calls efi_init_obj_list to do the efi set up
>>> before launching an .efi payload, but efi_init_obj_list is called
>>> only once. There are some initializations which depend on the
>>> environment and should be done each time a payload gets launched and
>>> not only once and can now be done in efi_start_obj_list(). A motivatio=
n
>>> for this change is the following order of events:
>>>
>>> 1. Launch an EFI application (e.g. bootefi hello)
>>> 2. Change the ip address
>>> 3. Launch another application which uses the pxe protocol
>>
>> Hello Adriano,
>>
>> Thanks for addressing this issue.
>>
>> There are a number of events that can lead to updating the IP address:
>>
>> * EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
>> * EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
>> * EFI_HTTP_PROTOCOL.Configure()
>> * command set env ethaddr#
>> * command dhcp
>>
>> All of these events require:
>>
>> * Updating the relevant ethaddr* variable.
>> * Updating any other references to the IP address.
>>
>> When not only considering EFI applications but also EFI drivers
>> installed via the bootefi command all of these events can occur during
>> the runtime of EFI binaries.
>>
>> Function efi_init_obj_list() is used for setups that are needed only
>> once before accessing the UEFI sub-system. It is not able to handle eve=
nts.
>>
>> If we need to update any internal UEFI data structures, we should do
>> this instantaneously when the event occurs and not when executing a UEF=
I
>> related shell command.
>>
>> U-Boot already has callbacks invoked when variables are changed. These
>> are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
>> callbacks' to list these callbacks.
>>
>> You could define a new function to handle changes of the IP address and
>> invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
>> U_BOOT_ENV_CALLBACK(netmask, <function name>).
>>
>> With lwIP we can have multiple network interfaces. Each has a different
>> variable ipaddr# assigned to it. We will have to extend the concept of
>> U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
>> find_env_callback(). With CONFIG_REGEX=3Dy regular expressions could be
>> used for this purpose (cf. include/slre.h) but we should better avoid
>> the code size increase.
>>
>
> I have been saying for some time that EFI_LOADER should make use of
> U-Boot's existing tables, rather than creating its own duplicate ones
> with extra info.

What structures are you referring to concerning this patch?

>
> This seems to have been understood as 'hang the EFI tables onto
> existing data structures', e.g. efi_disk_create_part(). But this leads
> to duplication.

We have to present the U-Boot DM devices in a way that an EFI binary can
consume.

Unless U-Boot's DM-layer is re-implemented via EFI structures we will
end up with two representations.

>
> Perhaps the EFI_LOADER init should be quite small, and be done each
> time an app starts, to deal with the 'current' state of U-Boot?

No, we can load both EFI apps and EFI drivers with the bootefi command.
In the case of EFI drivers we must not remove the handles and protocols
representing U-Boot DM devices after the binaries return.

Best regards

Heinrich
