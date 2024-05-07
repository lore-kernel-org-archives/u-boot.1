Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8E8C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 12:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB59688725;
	Tue,  7 May 2024 14:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="KENHQ0Cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE1488662; Tue,  7 May 2024 09:17:50 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC7587FA0
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yoann.congal@smile.fr
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34e040ed031so1960121f8f.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715066268; x=1715671068;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6fMZgo6kmUvepm8TfQ14gkcWnNxD188ih5lFc9GnPU8=;
 b=KENHQ0Cq67gZ217K6C7ZA7Nipm44taEFKk0lKc3pWIp7EHEe/Y3I1Z7JoVW205htBh
 3j949UDNRxIdIa+A0zKJtbvIOjhTwb+D9uBXHcidsfle0eBfXfSrnyry1i9pqRQAQ6kJ
 gIrE2gOMgpLNO5sG6iNIrkDbqydcXPF+pWcuU9KXAdv8707RTdomQMSfPEfJW3zDpQP+
 K9xfE2B+IWqn+KwPXnkRG4wuetlpZ+ndJV470oB8y0tDvonkSB1p//BKKiUsFatVhGCd
 954o7hnnDJIUYubBzunj57A4+DOyVlclSTW40zTjMPSi6yKt8U1P9GyZV3uMZUdNmpXg
 mY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066268; x=1715671068;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fMZgo6kmUvepm8TfQ14gkcWnNxD188ih5lFc9GnPU8=;
 b=esMSwIgc1rW9NahjMnDlmTh6tR5Dp9vDOHg6PZZt+v5fjduhrtqFPWyavNHbJGZVrj
 i9EHA2afyrtOzOct4tuORAnOCIecfG0xBmQna6uJ3kazNM/lgWsfXIZjnOyKgH83invm
 G+fDqyYiCV2G/lDUbCh4PKCxXeptR9vK9CnUnA1Dy30dNzkAJv0UTstVnwx+wJ5bOdPK
 4W+W+TyJt2FM6jbdqPrajbqIWZqeddaYDoiuSgkXyS6ISM8AKnRsPHiu4gCX94NJ6Ju1
 csHuCC51ogpQiclEcfomNP+5wxOUshM7Pr4kt6GEihCjcCxbyulBNeKLaMcV0e8Jx7ad
 8Dvw==
X-Gm-Message-State: AOJu0YxCPCf9gURR/Jjr3EyBa422Rw6qk8DrD4Agy9FZwkTALWnuG3qb
 HMYVP+g5OOAzRwXv8NsOKxAutpS6f9KK+dH6g497VIOuTH4hxiA2xqKp+JTbsaM=
X-Google-Smtp-Source: AGHT+IFWMsoE4Zql9JeXuMTq2jMBfISgNqW+0MhR99W/aeOwcRBmZDh/gHi1ruU9UalUmg1LYVp4Wg==
X-Received: by 2002:a5d:68d2:0:b0:34d:79a2:260a with SMTP id
 p18-20020a5d68d2000000b0034d79a2260amr8035826wrw.60.1715066267708; 
 Tue, 07 May 2024 00:17:47 -0700 (PDT)
Received: from [192.168.0.27] ([89.159.1.53]) by smtp.gmail.com with ESMTPSA id
 gb30-20020a056000459e00b0034e0346317dsm12252775wrb.13.2024.05.07.00.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:17:47 -0700 (PDT)
Message-ID: <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
Date: Tue, 7 May 2024 09:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <20240506174332.GN2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 May 2024 14:27:34 +0200
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

Le 06/05/2024 à 19:43, Tom Rini a écrit :
> On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
> 
>> From: Masahiro Yamada <masahiroy@kernel.org>
>>
>> This is a cherry-pick from the kernel commit:
>> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)
>>
>> When a default property is missing in an int or hex symbol, it defaults
>> to an empty string, which is not a valid symbol value.
>>
>> It results in an incorrect .config, and can also lead to an infinite
>> loop in scripting.
>>
>> Use "0" for int and "0x0" for hex as a default value.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>>
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>> Added context that was not in the upstream commit:
>> The infinite loop case happens with a configuration defined like this
>> (a hex config without a valid default value):
>>   config HEX_TEST
>>   	hex "Hex config without default"
>>
>> And using:
>>   $ make oldconfig < /dev/null
>>   scripts/kconfig/conf  --oldconfig Kconfig
>>   *
>>   * General setup
>>   *
>>
>>   Error in reading or end of file.
>>
>>   Error in reading or end of file.
>>   Hex config without default (HEX_TEST) [] (NEW)
>>
>>   Error in reading or end of file.
>>   Hex config without default (HEX_TEST) [] (NEW)
>>   # This loops forever
>>
>> NB: Scripted config manipulation often call make with /dev/null as
>> stdin (Yocto recipe, CI build, ...)
>>
>> This was discovered when working on Yocto bug:
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136

Hi Tom,

> I'm surprised this was accepted. In the past I've wanted to avoid this
> kind of change in Kconfig because while the empty string can be easily
> be checked in the code as "user didn't really configure this, do
> nothing" a value of zero is a valid option in these cases and so then in
> the code we need a bool symbol to decide if the hex/int symbol is set or
> not.

For context (and what it's worth), before this patch was merged, I've tried to fix this problem with a patch of my own which only exited the config process when the infinite loop would start:
"[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
... the v5 version was a bit more severe and exited as soon as an error was hit, it was then removed from -next because it triggered a build failure [1].

> Today this is less of an issue than it used to be in U-Boot with
> everything CONFIG-related migrated to Kconfig and so there's no longer
> the question of if we missed migrating a file that defined the value but
> there's still places we have in the code where hex symbol is undefined
> is not the same thing as hex symbol is 0x0.
> 
> Is there a specific use case you have for this in U-Boot? It's been a
> while, but it's also been cases of newly introduced symbols in Kconfig
> files with incorrect dependencies, where the infinite loop in kconfig
> happened, CI failed and we caught the problem.

For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR like this (tested on today's master):
  make qemu_arm64_defconfig
  make menuconfig
   # activate CONFIG_CMD_PSTORE=y but forget to fill CMD_PSTORE_MEM_ADDR
  make < /dev/null # This emulates a Yocto/scripted/CI build and loops infinitely

But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).

I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.

Thanks!

Regards,

[0]: https://lore.kernel.org/lkml/20231031111647.111093-1-yoann.congal@smile.fr/
[1]: https://lore.kernel.org/lkml/20231107210004.GA2065849@dev-arch.thelio-3990X/
-- 
Yoann Congal
Smile ECS - Tech Expert
