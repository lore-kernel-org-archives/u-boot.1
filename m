Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4650FC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1FF86EB5;
	Sun,  5 Nov 2023 21:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CMRJGSOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBE886E95; Sun,  5 Nov 2023 21:06:46 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829BC86EB5
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so7573266a12.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214796; x=1699819596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CA6ZeOoyQd3+A1hpKay+Q09ivyG132Fs7OkaVdf/yA4=;
 b=CMRJGSOAnhHDUvsJQ4xIobKqw75xtNQ7iRjLqr8kFoMrrV8yPOn/w5DPdJKxQAKDpi
 cr9Wc2X/HVT9kv3I4simtEPcDCR3Rjso9tM+QzgJZZak6rd7m3NHFv+Ha+XWrN28WXEQ
 n7dcuHROTcrum6l5HopV1JumhMAbGaoenyK4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214796; x=1699819596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CA6ZeOoyQd3+A1hpKay+Q09ivyG132Fs7OkaVdf/yA4=;
 b=ZfzF8R8x95sCLlLtfe1ohTip6ounTfmxyKGzqSRUsm2A/nBRLfT2/16zbHfoDwYaDC
 yG/CLs8ZrnuZLIIClqfWc5emQvxzsnTOwskg84N5hspL5xCTXchKE4NXSYh9GAUgSgGj
 s/oUyl94EpJNidHNCkE+bwhUwITCv9mELFMTwN3yKFE1kXzAzgPshisiDfVZGlxTGHaq
 c5R0CplDSvli3Q090achN0ltbdqVVSGAses6gpgQMMLg3V0RXQcKqHyfAAuxx4YrUE75
 DYbyXpA9HBqs47tARGg+Wer7/uuR0R+Rqua3p+uw76kwScwPzjMnhucsMdFsHP8jqna4
 ZxOA==
X-Gm-Message-State: AOJu0YzEw0BmTphkP6mjiL981Bsm+1HfT/VvWix/nSJS0n7IpTbKtPpr
 SGvdMhHU8RbJaaO3IKUZIJJRxUQCpQf98AidWAELu4vk1Wb5t+Qw4pg=
X-Google-Smtp-Source: AGHT+IGlJCnclEiewrc6LfcHQrlgBcWD1B86ekPKSP7YF5L1OjSE1If5tSgJU6fYn2Unf4aOjCQhvTo6Z+og3M/0FqQ=
X-Received: by 2002:a50:d71d:0:b0:544:7a0d:9f83 with SMTP id
 t29-20020a50d71d000000b005447a0d9f83mr2051073edi.20.1699214796310; Sun, 05
 Nov 2023 12:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
In-Reply-To: <20231105200453.1887418-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Nov 2023 20:06:19 +0000
Message-ID: <CAPnjgZ2y+9jtJCd4TVf28C7gVxVkqSNtbXbmKMhYOctt3=EwKw@mail.gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>, 
 Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Sun, 5 Nov 2023 at 20:05, Simon Glass <sjg@chromium.org> wrote:
>
> This little series corrects a problem I noticed with arm64 images,
> where the kernel is not recognised:
>
>    ## Loading kernel from FIT Image at 10000000 ...
>       Using 'conf-930' configuration
>       Verifying Hash Integrity ... OK
>       Trying 'kernel' kernel subimage
>         Description:  Linux-6.6.0-rc7-next-20231024-00003-g259c196f194c
>         Type:         Kernel Image (no loading done)
>         Compression:  gzip compressed
>         Data Start:   0x10000138
>         Data Size:    13667956 Bytes = 13 MiB
>       Verifying Hash Integrity ... OK
>    Bad Linux ARM64 Image magic!
>
> The problem is that the arm64 magic is checked before the image is
> decompressed.
>
> Another issue is that the load address is read from the 'load' property
> even with a kernel_noload image. This means that the kernel is loaded
> to address 0, which may not be valid on the board. We can use the
> kernel_addr_r environment variable instead.
>
> A patch is included to show the kernel load-address, so it is easy to
> see what is going on.
>
>
> Simon Glass (4):
>   bootm: Allow ignoring the load address with kernel_noload
>   bootm: Move arm64-image processing later
>   image: Show the load address when decompressing
>   image: Correct load_bug typo
>
>  boot/bootm.c    | 61 ++++++++++++++++++++++++++++++-------------------
>  boot/image.c    | 13 +++++++----
>  include/image.h |  2 +-
>  3 files changed, 48 insertions(+), 28 deletions(-)
>
> --
> 2.42.0.869.gea05f2083d-goog
>

This series has a few problems still, but I am sending it now since I
believe it fixes a real problem on arm64. I will tidy it up soon.

Regards,
Simon
