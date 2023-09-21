Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7851E71076
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3952C867D2;
	Thu, 21 Sep 2023 16:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZPNGg9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF455867B5; Thu, 21 Sep 2023 16:00:28 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3DA865D0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-532784c8770so1195724a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695304826; x=1695909626; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1JneSWiWrEOp0XkAjf0PX7JNZk5oCtSu/AYRZJWVc0=;
 b=IZPNGg9Pm3os2SO7OxEqU1/JQqjSAzItPsrSDV/GD3Msb+E/NfZn/0BEzuV0De8L7V
 5GYZQr0JCYeU6snDJhIMToFn6dE51SRaMcSIgTdwNnpXxXNPzX7vRYB+8aeMq5JcFw+u
 CgqrhiSGJ+2T/xB1oSollFue/ItjGPqRkkJtQOwGMRc4dO9NwRI5YNCAB0Wk5RjtGu8V
 cAbbNrp4OkTNqNdPzVgUpDCn2bBnZjvNFZUjyLKS7vBN9M2CXuUz7N6pZKGwJB3FHWde
 9/f3INxkxaguBVsNZRteH/ow8rGJPgFEZXOCfwNSs7NDg9yZwNqbN94nJDDX2q+34cQ0
 ZhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695304826; x=1695909626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1JneSWiWrEOp0XkAjf0PX7JNZk5oCtSu/AYRZJWVc0=;
 b=UmH+3W8rsv0IMeQLwSx+sZg4QGSWh40NCZnenomxnuoY+NztlNvv+ATgPtlz8/VZh3
 4fnzPgrvYwG0/nKKA8fJSA616eh8MlG84+sTjrBASwUuFA8za7QmP4NtbOKQTkfPkU07
 I+8yw0ryxW1NYWJT3ebBm0ikdPop3Vd+5Yle+fqVeAK0GSUBGF8iXRYXBdPM5OjKVTKk
 5wyy9PLNVLr5zbb/ocOShZ04wiDaKctXVuXmwKQk6U+Hyy2HL+e+BcWcEUdn4gnjhqml
 Nxk8gRqCfqUv3rvhndWeY8JFvMj8auqvXJERD1WnPXuuSftzMx9SeZgth3UYnvH2eLTp
 YLNw==
X-Gm-Message-State: AOJu0YxMDgDMgdfCsbvD4ousFxdZmQuH0y+DN8CjDrdxVUNEZkdUz9BL
 aa/P59+Lh3DwFIap5J5VWa6DfWdGZbQ=
X-Google-Smtp-Source: AGHT+IG3tDYe3XOGKh6j6Ut9ppNVmuEoheMwdNENHiqUg1hi476Q4SpX5sQz3wn1ZkHQ2mEI2pWxTw==
X-Received: by 2002:a17:906:8449:b0:9a5:d899:cc36 with SMTP id
 e9-20020a170906844900b009a5d899cc36mr4930091ejy.2.1695304826172; 
 Thu, 21 Sep 2023 07:00:26 -0700 (PDT)
Received: from [192.168.10.30] (14-5-142-46.pool.kielnet.net. [46.142.5.14])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170906089100b0099ccee57ac2sm1084154eje.194.2023.09.21.07.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 07:00:25 -0700 (PDT)
Message-ID: <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
Date: Thu, 21 Sep 2023 16:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
 <20230920185547.GP305624@bill-the-cat>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20230920185547.GP305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/20/23 20:55, Tom Rini wrote:
> On Wed, Sep 20, 2023 at 08:51:07PM +0200, Linus Walleij wrote:
>> On Wed, Sep 20, 2023 at 4:22 PM Tom Rini <trini@konsulko.com> wrote:
>>
>>>> + * This is a diet version of the device tree from Linux,
>>>> + * suitable for U-Boot.
>>>> + */
>>>
>>> We shouldn't need a diet version of the tree.  If it's reasonably done
>>> and stable in the kernel, we can even move towards just passing the
>>> U-Boot tree along to Linux.
>>
>> The device tree is not stable in the kernel.
>> It exists in OpenWrt and the creators of the bmips target are
>> kind of absent for the moment. The reason it is not in Linux
>> is that the "switch ethernet" driver and bindings need to be
>> upstreamed before the device trees can be upstreamed.
>>
>> But I can try to bring in more of it for sure :)
> 
> Just like ARM the goal is just to drop in the kernel dts here.

I guess this approach works well for ARM but not for MIPS. Most MIPS consumer boards
are just maintained in OpenWRT but not in mainline Linux. And there are a few boards
which have been just mainlined in U-Boot but not Linux so them also don't have a
stable Linux DT.

As MIPS is a dead architecture I suggest to just go with the minimal DT suited for U-Boot ;)

> 
>>>> +++ b/board/inteno/xg6846/xg6846.c
>>>> @@ -0,0 +1,6 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
>>>> + */
>>>> +
>>>> +#include <common.h>
>>>
>>> So basically just an empty object file.  Can we just _not_ have
>>> something here, if we perhaps don't set SYS_BOARD?  I assume if there's
>>> just nothing here the link rules fail.
>>
>> Admittedly my knowledge of U-Boot internals are not the
>> best and this is a bit of a copy and paste job from
>> board/comtrend/ar5387un/ar-5387un.c which looks like
>> this and sets a bad example I suppose.
> 
> Yeah, I didn't know we had someone doing that already here, whoops.
> 
>> I guess you are asking me to modify U-Boots build system to
>> make the whole .c and Makefile inside a board subdir optional
>> so we can delete all such empty boardfiles?
> 
> Well, it'd sure be nice if we could avoid having a dummy C file.  If
> it looks like a nightmare once you take a peek, we can just live with
> it.
> 

I just tested it, you can simply add an empty board/inteno/xg6846/Makefile and
remove board/inteno/xg6846/xg6846.c. But you can also remove the Makefile.
Just the Kconfig and MAINTAINERS file are needed.

-- 
- Daniel
