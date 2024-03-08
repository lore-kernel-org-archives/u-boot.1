Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6309C54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C9F87B7C;
	Fri,  8 Mar 2024 03:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eYLA7keD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF5B87B77; Fri,  8 Mar 2024 03:37:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D9287DCD
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36B824368A
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 02:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709865463;
 bh=6AwF/PG4JzB3XWZNUBC4ZTq6FGhFvw/q3du12B6J1GY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=eYLA7keD765wJgHVIQiLRl7mZHvEDjX6Vx3xKsQDOlK9rVjXE8mYtDzt9kZy/LHe+
 zlnfvTW55bESsiEsLBZPv+KZrZ3wOTjGh5PDmHgeDJjNg3cdq/SICXZXq+UfpkeDgS
 CP/h1MQFgedsINKQZIg72kwsJ9BkT5LfYhgyBR4M9faHoC83nBZIUrBlebU3VKC6tz
 QT7/75WWYj46hNDgCa8xrhNx3wbl+LFI5ScQmJwwanuvFGWL6ds8MfEcx8t1KFwxyj
 qs8bYX9WtEZVK4OKTiUz3+Nzl4VXaBL9/8wyF5nU/hXu6L6LqVobB3LTaWilIWx1uK
 24eqikjzsljbw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e0edcf4f4so581976f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709865462; x=1710470262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AwF/PG4JzB3XWZNUBC4ZTq6FGhFvw/q3du12B6J1GY=;
 b=DnmRgrdsRCdD87V2K+Mq2+QPf4FYXv0Sqbf4HK0J735D22P6xw9gw+eDIeIel2FzRa
 D1qa01jOMIkTf8zF2wgHEozjMdImz66XjGkeX1GCGkxmFSRC4hjG1CVvm0cXVm/BQZLE
 kylW/iAIUZ8n5IDjFxiiryegKz4CHxIVrjYv2X+2hREacDtAy/6XGuxb+/U85COAYpEK
 +oF2Wf2v+81TJ6oXDExHEBmvhuj9QStsn2lfIgWx96yAnM9lJF55ExiHNRpcN6/GkWoc
 bIY3OZAYCy8BonT7v80AVafqcyQCLQbtwUBOatG2QU79dzrzN2XXQFbPVg9+u/h+Rba0
 RmLA==
X-Gm-Message-State: AOJu0Yw095PYBfqsOY5CRydNa+ogYUkkfKg7Mu+37yEiTD3fnZZbWOVV
 5M6EyS8Z/RvAku054ViVMXwPQN0Z1GvsaUv/TtOF3g5AlufLrGE8RYpCVy2V8ie/BXEF3S1qYFN
 WEMW9Y2QaIqtTe8si4loFEuVE2OERL4j90v5ErDm7Adlz7rwRoWMEHIDOxcZH4wDtwhw=
X-Received: by 2002:a05:600c:470e:b0:412:bcc1:44cc with SMTP id
 v14-20020a05600c470e00b00412bcc144ccmr15189660wmo.3.1709865462573; 
 Thu, 07 Mar 2024 18:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF27B63Bvz4D1B5OFJK2tHwi6tTxLAMrbVAFqX3cgiQ5pRoF6djzBdyPthv1VPqNCt+4r7whg==
X-Received: by 2002:a05:600c:470e:b0:412:bcc1:44cc with SMTP id
 v14-20020a05600c470e00b00412bcc144ccmr15189649wmo.3.1709865462156; 
 Thu, 07 Mar 2024 18:37:42 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:4294:78eb:608e:9569?
 ([2a00:20:9:393f:4294:78eb:608e:9569])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b00412f2136793sm4544131wmq.44.2024.03.07.18.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 18:37:41 -0800 (PST)
Message-ID: <937b1f61-7412-4609-b9a5-549d7fd6a950@canonical.com>
Date: Fri, 8 Mar 2024 03:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] doc: describe Milk-V Mars board
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
 <CANV2PTOCK--hOr_HbbjHcjYT40fVm5DD2GsfV3cZu2XFm7WX=Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTOCK--hOr_HbbjHcjYT40fVm5DD2GsfV3cZu2XFm7WX=Q@mail.gmail.com>
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

On 3/8/24 00:20, E Shattow wrote:
> 
> On Sun, Mar 3, 2024 at 5:02 AM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> ...
> 
>     +The board provides the DIP switches MSEL[1:0] to select the boot
>     device out of
>     +SPI flash, eMMC, SD-card, UART. To select booting from SD-card set
>     the DIP
>     +switches MSEL[1:0] to 10.
> 
> 
> This does not match the [Milk-V Mars vendor 
> documentation](https://milkv.io/docs/mars/getting-started/bootloader 
> <https://milkv.io/docs/mars/getting-started/bootloader>). Maybe you have 
> a different board revision?

Thank you for reviewing.

My board revision is V1.21 according to the silk screen.

The Milk-V Mars has DIP switches for the boot selection as shown in
https://gist.github.com/xypron/e28f95b1ed6911aeb9699ba63ae1a885

If you look at the photo 
https://milkv.io/assets/images/mars-icon-04-e8814f18158a0e9d4387f4fa330693f1.webp 
in the https://milkv.io/mars page, it also shows DIP switches (in the 
SPI-Flash position) on a rev 1.2 board.

Did you see a board without DIP switches being sold?

The silk screen markings on the board and the switch don't match.
The same confusion exists on the VisionFive2.

So maybe I should better write in a table:

SPI-Flash:
GPIO0=L
GPIO1=L

SD-Card:
GPIO0=H
GPIO1=L

eMMC:
GPIO0=L
GPIO1=H

UART:
GPIO0=H
GPIO1=H

Best regards

Heinrich
