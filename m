Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77959C25B75
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 09:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6EA88087;
	Mon, 13 May 2024 11:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="yqsyIw8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D401E881BC; Mon, 13 May 2024 11:03:35 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533F087F39
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 11:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yoann.congal@smile.fr
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-420180b5922so4288735e9.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715591013; x=1716195813;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hoiSde8Nylg7ZqTCvGqXnunCsWWLd/RSRLuttUtR/y0=;
 b=yqsyIw8r9a9NIBjitssrdZ7nnw3KHBsVLqsBEH+DTDLGHD8x6CcPIT/rAoWl0L8D0x
 J2ioYyyRxE5PSrzom+nD56+2bCPjOKAy2VgosKcdi3i4bQuA+4nGEUaUb9d1ISaUvUBC
 o8e11HXFlK+Jw0ldYCOo3lbEJeDnoZ+ssIhugOg84az9E22AvW5KZDsLP1B/M9PnlMC8
 V7dxlOVMXzvtNHT0yJvo09CLZAvSb4OQnwIUuYSUn16fp9JWJm5Dg6Jcf3JNr7KRhqf2
 RPh7ezJeEXE6+WKhvfsFvgBh+reNiogPmeEAjtEXsFxbNol+w/isNtozVoFQohXyd7+1
 P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715591013; x=1716195813;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoiSde8Nylg7ZqTCvGqXnunCsWWLd/RSRLuttUtR/y0=;
 b=ngyEfGhAIGHNaJFWH9l+sn2OagL2TOnDIHRho2vMbs+tyoxcaRdb/aKg16SKSRlQwr
 vWiTfEqW7mBeLkItPUZW/TmWqqBFIxMk42dIzrHs2Vj+J1zTLo/5wkCB4l9qfaDpH9q/
 5ydQTcveVg1AzAGpyHHySYl8WcNHNucLiVM6Ns2R+fWdYfl+3T3dDIBuJ7MO41BzcSlb
 RXCvPj1C2mp4wHIvR99i4Hwm2fGaDGkEQpWBqe1pFbgO766dt8ZPtoCvwrvaotLJ/2uW
 aKf4NW7j6Wl8jCCsmgmatarCM9qvCBCTtBDei9Rex5HDdaK8XTYDDFwJOt4E0T/QszuX
 fS9Q==
X-Gm-Message-State: AOJu0YwG9KthWtPmY6SvBiLSAQ07NOVg7RjzXCizTpGxdCS7pHjfaAK9
 UrTxgMVj+IwwO2rUJN/BlC/nY/vrIvXeVWBqSSjYLmSYhKmDPdO3/qflYxJ5Co4=
X-Google-Smtp-Source: AGHT+IFbKBBPlk0/X8+Uh73vVh2HbhyTGBw722+D8kb8TqL7fu06NOaVBiG0GTeid2ob96yTOdYp4A==
X-Received: by 2002:a05:600c:444e:b0:41b:e244:164a with SMTP id
 5b1f17b1804b1-41fea9324cemr97176925e9.6.1715591012579; 
 Mon, 13 May 2024 02:03:32 -0700 (PDT)
Received: from [192.168.0.27] ([89.159.1.53]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c235b4sm184740605e9.11.2024.05.13.02.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:03:32 -0700 (PDT)
Message-ID: <7192141a-248b-44cd-8030-3e1a3b30b6ca@smile.fr>
Date: Mon, 13 May 2024 11:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
 <20240507172359.GX2568172@bill-the-cat>
 <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
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



Le 13/05/2024 à 10:28, Rasmus Villemoes a écrit :
> On 07/05/2024 19.23, Tom Rini wrote:
>> On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:
>>> Le 06/05/2024 à 19:43, Tom Rini a écrit :
>>>> On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
>>>>
>>>>> From: Masahiro Yamada <masahiroy@kernel.org>
>>>>>
>>>>> This is a cherry-pick from the kernel commit:
>>>>> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)
>>>>>
>>>>> When a default property is missing in an int or hex symbol, it defaults
>>>>> to an empty string, which is not a valid symbol value.
>>>>>
>>>>> It results in an incorrect .config, and can also lead to an infinite
>>>>> loop in scripting.
>>>>>
>>>>> Use "0" for int and "0x0" for hex as a default value.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>>> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>>>>>
>>>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>>>> ---
>>>>> Added context that was not in the upstream commit:
>>>>> The infinite loop case happens with a configuration defined like this
>>>>> (a hex config without a valid default value):
>>>>>   config HEX_TEST
>>>>>   	hex "Hex config without default"
>>>>>
>>>>> And using:
>>>>>   $ make oldconfig < /dev/null
>>>>>   scripts/kconfig/conf  --oldconfig Kconfig
>>>>>   *
>>>>>   * General setup
>>>>>   *
>>>>>
>>>>>   Error in reading or end of file.
>>>>>
>>>>>   Error in reading or end of file.
>>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>>
>>>>>   Error in reading or end of file.
>>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>>   # This loops forever
>>>>>
>>>>> NB: Scripted config manipulation often call make with /dev/null as
>>>>> stdin (Yocto recipe, CI build, ...)
>>>>>
>>>>> This was discovered when working on Yocto bug:
>>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>>
>>> Hi Tom,
>>>
>>>> I'm surprised this was accepted. In the past I've wanted to avoid this
>>>> kind of change in Kconfig because while the empty string can be easily
>>>> be checked in the code as "user didn't really configure this, do
>>>> nothing" a value of zero is a valid option in these cases and so then in
>>>> the code we need a bool symbol to decide if the hex/int symbol is set or
>>>> not.
>>>
>>> For context (and what it's worth), before this patch was merged, I've tried to fix this problem with a patch of my own which only exited the config process when the infinite loop would start:
>>> "[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
>>> ... the v5 version was a bit more severe and exited as soon as an error was hit, it was then removed from -next because it triggered a build failure [1].
>>>
>>>> Today this is less of an issue than it used to be in U-Boot with
>>>> everything CONFIG-related migrated to Kconfig and so there's no longer
>>>> the question of if we missed migrating a file that defined the value but
>>>> there's still places we have in the code where hex symbol is undefined
>>>> is not the same thing as hex symbol is 0x0.
>>>>
>>>> Is there a specific use case you have for this in U-Boot? It's been a
>>>> while, but it's also been cases of newly introduced symbols in Kconfig
>>>> files with incorrect dependencies, where the infinite loop in kconfig
>>>> happened, CI failed and we caught the problem.
>>>
>>> For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR like this (tested on today's master):
>>>   make qemu_arm64_defconfig
>>>   make menuconfig
>>>    # activate CONFIG_CMD_PSTORE=y but forget to fill CMD_PSTORE_MEM_ADDR
>>>   make < /dev/null # This emulates a Yocto/scripted/CI build and loops infinitely
>>>
>>> But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
>>> In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).
>>>
>>> I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.
>>
>> Exactly, but to me it's worse to cover up the build issue and introduce
>> a runtime issue instead. Something builds but then crashes at run time
>> is worse to me than builds fail / get stuck. Using your example,
>> CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
>> CMD_PSTORE in a config fragment but doesn't define the address, the
>> build should not complete. Using 0x0 means that oops, now it fails to
>> work and might not be obvious why either.
> 
> I agree with Tom. Yes, we've also hit those yocto failures with a
> multi-GB do_configure log file, and that's pretty annoying when one just
> starts a build cooking over night and then the next day one's laptop has
> a filled disk. So clearly there is/was a problem to solve.
> 
> However, blindly adding a "default default" of 0 is not the right thing
> to do. It seems much better that, when there's no configured default and
> kconfig gets EOF when asking the user for input (as in the 'make
> oldconfig < /dev/null' case), kconfig should exit with an error
> explicitly saying "no value given for CONFIG_XYZ which also doesn't have
> a default value". That stops the build, and leaves precisely an
> indication what the problem is. Then the developer must either provide a
> value for CONFIG_XYZ in the fragments, or send a patch to add a
> reasonable default when that is at all possible (not so for e.g. PSTORE).


Agreed, that was the spirit of my first attempt at a fix[0] which was then made broader[1] and finally rejected from "-next" because it triggered a build failure[2].

I still think my first approach (exit with an error instead of starting the infinite loop) was the right one (at least for U-Boot). The problem is that this approach was rejected by the Linux kconfig maintainer (Masahiro Yamada CC'd). I'm willing to clean it up for U-boot but this would diverge from linux kconfig... Is that acceptable?

[0]: https://lore.kernel.org/all/20231031111647.111093-1-yoann.congal@smile.fr/
[1]: https://lore.kernel.org/all/20231104222715.3967791-1-yoann.congal@smile.fr/
[2]: https://lore.kernel.org/all/20231107210004.GA2065849@dev-arch.thelio-3990X/

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert
