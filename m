Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA29E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433538043F;
	Sat,  4 Jan 2025 20:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4zx+Bkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE608056E; Sat,  4 Jan 2025 20:29:54 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF42803DC
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso2735566166b.1
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736018991; x=1736623791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0f3JAy0uDkJ6BBGhP25vEBQqW8flHYlUjqO4lvYQDrU=;
 b=S4zx+BkkMxIZNG2FJ+u7trV5PFsSmX+uADGyGF+/PZlDJeZbxyYX6ojsx4Q6lZ5xvG
 c4NvdfDyjKu35OqQKkQQD8ZxQElhRXUJS1nc2AqbTqXI/K1W82scOKNVsAiRYhiPGOyl
 PRFGgTGUvaxxP1HA5/DJbOWriUT1rK2G27NPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736018991; x=1736623791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0f3JAy0uDkJ6BBGhP25vEBQqW8flHYlUjqO4lvYQDrU=;
 b=XRrII+uRb7FLoW19PMOtreVKc6tfTfGtOPQ6YNy3Jv1lUbIt4JqryQ+jj1CUyNRDYF
 N7SO+soTkDLdjRg2WuvuddRnLXALF8mEv/FSWBiBpzjqQuCqq/LwSPSWp12v9BTMF4UT
 B6Tc+ni+Iixc/m+271a0qZD1got8+wfmTMcZZs9p66tKvNJr2tmt7M8mJqjTFTt2J57D
 EIs1nZGiZGMrnDuzogXPRXJxWrs/eZUubZUm3W+X4z826wmTGR2BIVGS493dwbV0uBBv
 bVykEAzhpXVXxJ4MXrIcPSd+0BXW6Vc/Hdrcij9oiq0o9h0DtTZyV9viDk4I61A9kOcp
 qpDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8aCrE1KVZqTVy752yIMWTRSlUF2cs0povXIQGoFz7EelX/FCyaHPoAwooumkcK2jC9JUmNzo=@lists.denx.de
X-Gm-Message-State: AOJu0YyqpNrVH/NgsETd44YbXtd1Yn3MfTrO4KJPDIwGt8CDaW1UCfGI
 C+t9rjwvX7QeCZsjAAxZZWH6dIuNcVRZ9cAATINklCH4qlMp42oNg6VC0kYo23VfTeQObfGDBo1
 aDFItiLkx361KuhnVjIf7ZXzwjrPBTeqfDQ2lAhCQkM0sVnA=
X-Gm-Gg: ASbGncuPVO/DhAxLSrh10a8SDd8tpngRRvgoIg0A4yaODDhgycJyvO3TF5VqpvvQb6U
 7Jk1loK3gu34zO1il5yfw85h/Yx5LcTqnYMTZ9TPO
X-Google-Smtp-Source: AGHT+IFdKTZ327+uUzGQtTjxTCqIiSdos7VmzKVjP/66klUvbkug1ipF9N79FvEfUmWEk9MJg7zCpVQo+Gh5MyZVLt4=
X-Received: by 2002:a17:907:9804:b0:aaf:123a:f303 with SMTP id
 a640c23a62f3a-aaf123af418mr3376126766b.55.1736018991263; Sat, 04 Jan 2025
 11:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
In-Reply-To: <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:29:43 +1300
Message-ID: <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 4 Jan 2025 at 05:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 04:47, Kever Yang wrote:
> > The efi_stub is useing DEBUG_UART interface by default, Enable it.
>
> As Simon already wrote in a code comment the implementation of the EFI
> stub is broken as it is not hardware agnostic.

If I said that I was wrong, sorry. Actually that is the stub's intent,
to take over the machine, exit boot-services and carry on. It is the
EFI app which is designed to use boot services.

So the stub cannot be hardware-agnostic, unfortunately. It only runs
on x86 hardware, unless, for example, EFI has something like
serial_getinfo() or we disable the UART / keyboard input.

>
> In the EFI stub we should never directly access hardware. Please, use
> SimpleTextOutputProtocol.OutputString() for printing.

Once the stub starts, boot services are gone. See efi_main() for how
this works. There is a definite point at which we stop using that and
start using U-Boot's own thing.

At this point I think I may be misunderstanding what you said...

>
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> >
> >   configs/efi-x86_payload32_defconfig | 1 +
> >   configs/efi-x86_payload64_defconfig | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
> > index 071ddb8e36d..f0b9acc358d 100644
> > --- a/configs/efi-x86_payload32_defconfig
> > +++ b/configs/efi-x86_payload32_defconfig
> > @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
> >   CONFIG_PRE_CON_BUF_ADDR=0x100000
> >   CONFIG_VENDOR_EFI=y
> >   CONFIG_TARGET_EFI_PAYLOAD=y
> > +CONFIG_DEBUG_UART=y
>
> On x86 this uses the NS16550 UART driver. This is fine as long as we
> don't use the debug UART in the EFI stub. But correcting this is for a
> separate patch.
>
> Having a debug UART available after the EFI stub makes sense.
>
> I will update the commit message when merging.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> >   CONFIG_EFI=y
> >   CONFIG_EFI_STUB=y
> >   CONFIG_FIT=y
> > diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
> > index 71612d7fb19..b02a861e59c 100644
> > --- a/configs/efi-x86_payload64_defconfig
> > +++ b/configs/efi-x86_payload64_defconfig
> > @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
> >   CONFIG_PRE_CON_BUF_ADDR=0x100000
> >   CONFIG_VENDOR_EFI=y
> >   CONFIG_TARGET_EFI_PAYLOAD=y
> > +CONFIG_DEBUG_UART=y
> >   CONFIG_EFI=y
> >   CONFIG_EFI_STUB=y
> >   CONFIG_EFI_STUB_64BIT=y
>

Regards,
Simon
