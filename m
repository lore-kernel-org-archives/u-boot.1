Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA3C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCB788044;
	Fri,  8 Mar 2024 10:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cYuUAtPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EAC88092; Fri,  8 Mar 2024 10:08:50 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F131F87D60
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA58948A9A
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 09:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709888923;
 bh=2h7+bGUKmLETczxC9Ea3Pctx1GmZ32VbPZCYW1yRzWI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cYuUAtPWMHEm9o3nvIfFg+KPyEfagMNiVZYD+sed5PPDFvDxhFJvHhhx27DpaE2A1
 A+/bbqWBRXGTLfBqo/PNt29nQ40skOupviGmJhX3eYJjcOc/0OMrB25ZCTOIonsilu
 w6YTNCGy4vASHbTnKU5OM/QJsc3BGWEEk97IztwV8vsxjOaCCkbw4X0eVmBg6JIBeF
 K6yCbSo9R7hYGHXBN9l+UWovHPsGYu2SQf/L/Av+MEUGloaIxbaXqgulqsCu/kSEq7
 ijajC9C4nHAayidQimvAnxpoieTBGgJXFTPB5ei+j33MCIlQTs3y9+iZ0T253MAOSF
 Y095SnX0dx0dw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e1d994f53so1117819f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 01:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709888923; x=1710493723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2h7+bGUKmLETczxC9Ea3Pctx1GmZ32VbPZCYW1yRzWI=;
 b=nzCkIOGZwJmdz2x9zYf+/cCkEe2JDqNLkeF2roKqwLs+1ZHyUx0FXV10/coyvgL21g
 KZ94LSPPwP4sxTk300cCt2rUjSyiwt8dW7FcjgbjP0Z7N/GEbarjUMkh5cczutkM+MtU
 uk5bkrlg7n8IvyxOjy6Ev6SrnW/PJdUTmGZncPpX7H+G6EQlxKoy3HQrniV0OXIiB1jf
 vdNjyqH3bWcqjuR6fdk+S2YJjm/YcfVCcdK5xNX0Zn8nyLoEKZjrxpyXGPeIKKmG26tJ
 pe0D1Xcd/jRj01o392Qcwy5u7KVmwzgcldJHNy1jydAyHTRw1zU4tcGd5FUcvc4WkAZv
 CkeA==
X-Gm-Message-State: AOJu0YwH55/Pcq/dLK9KUR9n96fBpQYLP5vhCMHM6VrBLI5LC6/tmkay
 yhD6oxRyfxIjRBw3SuuBzxjzJiUQkUQW2j8eUT/Pgq2Y4sk+hXUUhkkB3495/6gUAdkMO2Ruwwo
 kR+j7QMcgNuQHTpAdAjhVo8tIt2DEPmgbI2q5TrU8lzB91lyCNsEqHH+chDLSzvl6ebw=
X-Received: by 2002:adf:c007:0:b0:33e:2a74:381c with SMTP id
 z7-20020adfc007000000b0033e2a74381cmr11820024wre.71.1709888923148; 
 Fri, 08 Mar 2024 01:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm3FJ86X6xrxAgVh5uPWP0dKam6pDiV7pnsG9La2KoBNQkFycDM/Kp8msSCL5XtyGq6E1FBA==
X-Received: by 2002:adf:c007:0:b0:33e:2a74:381c with SMTP id
 z7-20020adfc007000000b0033e2a74381cmr11820003wre.71.1709888922472; 
 Fri, 08 Mar 2024 01:08:42 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:ad59:4fbd:1973:bed4?
 ([2a00:20:9:393f:ad59:4fbd:1973:bed4])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a5d58ea000000b0033d4cf751b2sm22266557wrd.33.2024.03.08.01.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 01:08:41 -0800 (PST)
Message-ID: <11ba1245-b02c-48d7-a55e-37af69561f3f@canonical.com>
Date: Fri, 8 Mar 2024 10:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] board: starfive: support Milk-V Mars board
Content-Language: en-US
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>, Shiji Yang
 <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
 <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
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

On 08.03.24 00:03, E Shattow wrote:
> 
> On Sun, Mar 3, 2024 at 5:02 AM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> ...
> 
>     * The EEPROM is atmel,24c02 according to the vendor U-Boot.
> 
> ...
> 
> The same vendor (Milk-V) U-Boot change is present on their branch for 
> Mars CM Lite (which despite the naming has more in common with Pine64 
> Star64 than Mars); However on visual inspection the silkscreen markings 
> are for 24c04. See: [Photo flatbed scans of Mars CM Lite 4GB rev 
> 1.01](https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-1872478605 <https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-1872478605>). Can this be determined at runtime, or I must trust that this is not a wrongly marked chip?


On the Milk-V Mars there is a chip marked "24C04F 21626P" like on the 
photo on the CM module from the thread above. This should be the EEPROM.

In some datasheets F is appended to mark the voltage range.

So this atmel,24c02 change seems really only be relevant if you have a 
CM module on a baseboard with an RTC at 0x51.

Best regards

Heinrich
