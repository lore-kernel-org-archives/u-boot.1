Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F92CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E958486E39;
	Thu, 12 Oct 2023 04:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D9SqvzWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108C786E09; Thu, 12 Oct 2023 04:18:57 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8645F86E0B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7740c8509c8so30511185a.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697077071; x=1697681871; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8pU4ZP2knDbCkNnHNuWueGLSlkqCFMsNcevCDfuCH4M=;
 b=D9SqvzWdjGosdNNjW5POgi9BQ8GXrONMkqOQ/PvE55Ue+Wmjz7Xldz2efQpuNvE76U
 1vs+JTwKvS9ZQ0Q8L9xEnU0ugxHF4XER7uQVoWMzEz5uvyTv8DcZAdovpuUhBS0WN07a
 culzR7YOPeBtiAPUUHSfA+idWY990TfyqYNJKjFGUZLmmzUN6KpgVGgjFvsiQNi6J94K
 v033kT39SX3TqsxJnPZVXgHEqbWhKSkOumx9q2RZzt1lSVfXbtrGAO4MiQeJymcJ71Jd
 ehmtteJgTyFpoHAA2Xg0Tf8DTeprNq3MPbEmc1qf8WNbAMKlhPOamMwvPEd/qjgznyUS
 awKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697077071; x=1697681871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8pU4ZP2knDbCkNnHNuWueGLSlkqCFMsNcevCDfuCH4M=;
 b=A8cpBAuDwz3GWysjMLQEhsg5/K1t9Z3t/T9yRLkzAU3XzD1sY6Gmmac2in//veN9JR
 eOE/wwySUK9HjOpLLrSu+KPAtl+IePuIoGg3JPgNNNwYuNnrRmP6o7dv4EqVSddA8jxH
 l625c0arqYUCqk44sMIbDrKhifB8oI3X2IqVz5ZEoobA3BDpmQjrZhkNCqNAxvm0bDgB
 ONwYu71S292j5YCC0RkTCOziaJ8sx9shgCSGUPbVWalqF1pRAioCH7GghU8TtwcFwPUp
 JY6Kg5Of4NohNLHybjQwr1nDDfSb2GxLx9voZhLncuCz6sw6cqLTNn43NngfM2mVMlZ7
 pi3A==
X-Gm-Message-State: AOJu0Yz5QSLpvBSn7Ek05npqfUmPqJfF5nKL2DP/i6/UK0sLfeiFG04i
 UYNH1BemtZnNKv2l934vlzg=
X-Google-Smtp-Source: AGHT+IEZrBE+/AHQOhVotx6yLaVibgH5aymA70DJmHxium4C8CQIL6nlS/3VLytY13Yzdfb1zogjMg==
X-Received: by 2002:a05:620a:2848:b0:76f:22f7:408f with SMTP id
 h8-20020a05620a284800b0076f22f7408fmr23596002qkp.34.1697077071450; 
 Wed, 11 Oct 2023 19:17:51 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 x13-20020a05620a14ad00b007756736aed7sm5657257qkj.106.2023.10.11.19.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 19:17:50 -0700 (PDT)
Message-ID: <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
Date: Wed, 11 Oct 2023 22:17:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
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

Hi Rasmus,

On 10/11/23 15:07, Rasmus Villemoes wrote:
> On 11/10/2023 20.37, Tom Rini wrote:
>> On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:
>>
>>> The man page correctly said that -B was ignored without -E, while the
>>> `mkimage -h` output suggested otherwise. Now that -B can actually be
>>> used by itself, update the man page.
>>>
>>> While at it, also amend the `mkimage -h` line to mention the
>>> connection with -E.
>>>
>>> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
>>> modified, while its alignment is a property of the address in RAM one
>>> loads the FIT to, so not something mkimage can affect in any way. (In
>>> the file itself, the header is of course at offset 0, which has all
>>> possible alignments already.)
>>>
>>> Reported-by: Sean Anderson <seanga2@gmail.com>
>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Applied to u-boot/master, thanks!
>>
> 
> Thanks, but I'm afraid that was premature.
> 
> The original series which this was a fixup/followup for hasn't been
> applied, and Sean had reservations. I'm leaving it to Simon or Tom or
> whoever has final say to decide if they should eventually go in, but it
> would probably be good to get a verdict soonish (it really shouldn't be
> too controversial), and if it's a no, this should just be reverted.

I was hoping you would respond to my most-recent email regarding this series.
In particular:

| Why does mkimage have to do this? Can't you just use truncate or, in a
| binman context, align-size?

Presumably you have some reason for wanting this in mkimage rather than using
existing tooling.

--Sean
