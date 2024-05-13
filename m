Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08161C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 08:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA79887F13;
	Mon, 13 May 2024 10:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="b7Epn+y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D888B87E74; Mon, 13 May 2024 10:02:32 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2075F8815E
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yoann.congal@smile.fr
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e4b90b03a9so45562391fa.1
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715587348; x=1716192148;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pyaVCcdRBkJ82BCSiwgj4NGZrzyAXi2thL0Mspjp5qA=;
 b=b7Epn+y93ECUDjOCIJ+/LCQsr7ClTbSm0hOj9IH7Ra0nYLXXUxJimueDSi4doZbV1N
 VuZ0TLDXoiKweFHf1kQX7tF5kLwYXuymUL3NC9MAnop4kFNjMngvR+4BW0wMyUVntYQ1
 WmZr2LTk0LSfXw/ygnvKEUje1myLoyH676GIc7GnyCLo6KUvueDL+yJ0iy/t+XN9UlgR
 KAXVUht8XizLxTFU5qdueh9uyFlzlpH5kVU0eZHWp2JUtob3OiR9JIs4BGsHfXaXGHn8
 LU9cM9ctyx779/aNY16nxzz59iebrdUn7xrpZ0FJ6oDcHOvcRYTFlYk5nXPFMdAbnhxl
 MUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715587348; x=1716192148;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyaVCcdRBkJ82BCSiwgj4NGZrzyAXi2thL0Mspjp5qA=;
 b=D2DhUUbWeANpONGVQj8x+yEQx5MYRk280zRYVa9qgP14nC7PiBbZZT+t6G0Zvnlzmn
 l02Uq6bp3UyAPkktpj8+x/TjRV9pVVzr+H7JE68udXdEyYvfwoJ9inDxU3Add/KX/GRZ
 TfIWFXwFm6uPCg6Sot8S6MUdbuJ/Cjgq971VQ679lbdRQcs7x7sl7bV6zOSkfgSFrGhp
 pA59PeHpTD5eOgAtAjuo1DzqAQJVME4suZWWvJ25naQk3f6oLb79pfR80vefLYhciC4u
 KKOKvZwq01NBRVOINJjW1DiywLiaWSwnBpycSkg+oLPcK2gCYz+724y5Y9mZlONi+IyT
 j3SA==
X-Gm-Message-State: AOJu0YzPyeYAzR7CbupkR3aoYgZC13uBkwh0GBz04pAGLZQzaXW6uIQG
 m52PHKACuS4QaDpievYTarAWjxEviFukvgXaSwYWLFSH3kMutt+0Ew6QuPMAxIQ=
X-Google-Smtp-Source: AGHT+IFjLA1ZQKFp+ALnhO/iG8Siq2eY+/JEOXk86Z+J1i5PKPhrDTThoTyfSXEaqZqw1lI0Ondcgw==
X-Received: by 2002:a2e:8255:0:b0:2db:4f3f:55a7 with SMTP id
 38308e7fff4ca-2e5204cc8d2mr52467601fa.45.1715587348256; 
 Mon, 13 May 2024 01:02:28 -0700 (PDT)
Received: from [192.168.0.27] ([89.159.1.53]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbe43sm10419644f8f.99.2024.05.13.01.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 01:02:27 -0700 (PDT)
Message-ID: <c106c17c-b5ac-4a3b-b730-2df5844faef2@smile.fr>
Date: Mon, 13 May 2024 10:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
 <20240507172359.GX2568172@bill-the-cat>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <20240507172359.GX2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Le 07/05/2024 à 19:23, Tom Rini a écrit :
> On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:
>> Le 06/05/2024 à 19:43, Tom Rini a écrit :
>>> On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
>>>
>>>> From: Masahiro Yamada <masahiroy@kernel.org>
>>>>
>>>> This is a cherry-pick from the kernel commit:
>>>> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)
>>>>
>>>> When a default property is missing in an int or hex symbol, it defaults
>>>> to an empty string, which is not a valid symbol value.
>>>>
>>>> It results in an incorrect .config, and can also lead to an infinite
>>>> loop in scripting.
>>>>
>>>> Use "0" for int and "0x0" for hex as a default value.
>>>>
>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>>>>
>>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>>> ---
>>>> Added context that was not in the upstream commit:
>>>> The infinite loop case happens with a configuration defined like this
>>>> (a hex config without a valid default value):
>>>>   config HEX_TEST
>>>>   	hex "Hex config without default"
>>>>
>>>> And using:
>>>>   $ make oldconfig < /dev/null
>>>>   scripts/kconfig/conf  --oldconfig Kconfig
>>>>   *
>>>>   * General setup
>>>>   *
>>>>
>>>>   Error in reading or end of file.
>>>>
>>>>   Error in reading or end of file.
>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>
>>>>   Error in reading or end of file.
>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>   # This loops forever
>>>>
>>>> NB: Scripted config manipulation often call make with /dev/null as
>>>> stdin (Yocto recipe, CI build, ...)
>>>>
>>>> This was discovered when working on Yocto bug:
>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>
>> Hi Tom,
>>
>>> I'm surprised this was accepted. In the past I've wanted to avoid this
>>> kind of change in Kconfig because while the empty string can be easily
>>> be checked in the code as "user didn't really configure this, do
>>> nothing" a value of zero is a valid option in these cases and so then in
>>> the code we need a bool symbol to decide if the hex/int symbol is set or
>>> not.
>>
>> For context (and what it's worth), before this patch was merged, I've tried to fix this problem with a patch of my own which only exited the config process when the infinite loop would start:
>> "[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
>> ... the v5 version was a bit more severe and exited as soon as an error was hit, it was then removed from -next because it triggered a build failure [1].
>>
>>> Today this is less of an issue than it used to be in U-Boot with
>>> everything CONFIG-related migrated to Kconfig and so there's no longer
>>> the question of if we missed migrating a file that defined the value but
>>> there's still places we have in the code where hex symbol is undefined
>>> is not the same thing as hex symbol is 0x0.
>>>
>>> Is there a specific use case you have for this in U-Boot? It's been a
>>> while, but it's also been cases of newly introduced symbols in Kconfig
>>> files with incorrect dependencies, where the infinite loop in kconfig
>>> happened, CI failed and we caught the problem.
>>
>> For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR like this (tested on today's master):
>>   make qemu_arm64_defconfig
>>   make menuconfig
>>    # activate CONFIG_CMD_PSTORE=y but forget to fill CMD_PSTORE_MEM_ADDR
>>   make < /dev/null # This emulates a Yocto/scripted/CI build and loops infinitely
>>
>> But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
>> In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).
>>
>> I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.
> 
> Exactly, but to me it's worse to cover up the build issue and introduce
> a runtime issue instead. Something builds but then crashes at run time
> is worse to me than builds fail / get stuck. Using your example,
> CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
> CMD_PSTORE in a config fragment but doesn't define the address, the
> build should not complete. Using 0x0 means that oops, now it fails to
> work and might not be obvious why either.
> 
> I won't revert this change when in the future we're able to sync up with
> the kernel again, but I'm not eager to bring this in by itself as it
> feels like the wrong way to deal with the problem. Thanks for explaining
> the history here.

Ok, I understand your position (I agree that runtime failure is bad)

Thanks for looking at this. I need to find another solution.

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert
