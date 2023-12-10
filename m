Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC169C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 07:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D398754B;
	Sun, 10 Dec 2023 08:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PEvRzyLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F88C8755D; Sun, 10 Dec 2023 08:41:35 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AD386DEE
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 08:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ca0715f0faso47112721fa.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 23:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702194092; x=1702798892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H8S1dN+lrU90NkMK2AZcVmFPWjusY7vdXg4ir2HiQfs=;
 b=PEvRzyLLGJNq39VsD/rELtl8dFlIFSRLk/2ZsNCQzBRRFtiohRJSUcSM+BMUyCb5UX
 4McdygywWS4azaCOcDqikNSuP5C497cUf5xx5OGGdcKmcCX5wWUkjGaJoRwXD+mH41wB
 Hj94OnpEK2154wTWOu92ht9nv2XiXBp8rkskujOPz/+naJJx49/rDVQ/1oT0bsl3nb8L
 S79XajBJOw3Q6by3mv2dWdybToeXRVJwWmyEUX/FpwqWfGRPFV3MkkVZrfhUOU14Gfy8
 V3l9JLcKSCzMY5t001VZJC4SDOwQ3LOiUQ6MlwnQ4inHjhH/tExMfhXCjDSlFCcYHn7N
 5/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702194092; x=1702798892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H8S1dN+lrU90NkMK2AZcVmFPWjusY7vdXg4ir2HiQfs=;
 b=o1xBM23hSibmD9BE5HbBbp0JtofTAgVf78cnzWA+OPwzgI2K6eDBHkU5zD3Ob6V9Hf
 FY2byuZcsHSQnMwf33G3oIGKAn9M3+85qTJO+2yakBtJY/UxuasMGSkZQ7wcVcMBSBF4
 wkV8sA7Xly0GXS2rlLW9kebky66zV/hVH+Jd2voWlDFxKI8/zunf8u3I4YIqn8+AcDkX
 Cx0bRkd3oSKUz/GR1kDg+y3JnG95+4XXHYbRlMpzUjO1hjsZOohMWMVikqX1btjlfN3A
 AS7fJBatg9sibGwwGZAFIixjs4d+Y8jgN2TqwKLDu9Rqdi7mijpH1LNLmit2F79lu6qx
 s8FQ==
X-Gm-Message-State: AOJu0YwGHSQQLo5+OpWdHSGhe7b5FfdoWTUjXSqpNEO9yvm3ZlCLcQCZ
 N3AB8a3KRSqgB4HejOj+ssTtOHoH/upx3nzOAXOpow==
X-Google-Smtp-Source: AGHT+IFtX3qJ5Q93d2Bzvbkyi8uuEeWjz80sCnWnIVmDnQzyC9wjXxZFlTzxb75JRGYELF/zUtn68vOTO4iMitC6UfQ=
X-Received: by 2002:a05:651c:1145:b0:2cc:1cc1:586a with SMTP id
 h5-20020a05651c114500b002cc1cc1586amr487493ljo.19.1702194091552; Sat, 09 Dec
 2023 23:41:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
 <CAPnjgZ04C=_MoCjKBYUdmBXyQn-zviAMQJxMHQAfj1MwvqOMzw@mail.gmail.com>
 <CAHc5_t2mQGQ4WLSXjh105QXnxMTeF3=x69N28dDiSdRMBHq3kg@mail.gmail.com>
 <1e2bad87-3372-452d-ae27-01c100378ecf@canonical.com>
 <CAPnjgZ05pDOATqw9wha-pOZsgjCF-4dgLL7-a4r-JPUjtMospg@mail.gmail.com>
 <671228f5-8a11-4be9-b8fe-1331232e7498@canonical.com>
 <CAPnjgZ1dghg2T8D8fSpHUgstgipwv+jRQssimpAGqTaPjvvQTA@mail.gmail.com>
 <638c9f48-693c-466e-a510-6004896a466c@canonical.com>
 <CAPnjgZ2=zCJbmA4CAjgRFUhGfojq6cOJMUeC4jB3Dm+u8UNG+A@mail.gmail.com>
 <c1ff4723-18f6-4fc4-bbba-8cc7490ca480@canonical.com>
 <CAPnjgZ3+dEFYazXKaGMfrLKAS5aKBhN-+HnH_3xy3qWaLNCtzg@mail.gmail.com>
 <CAHc5_t30UFOdpqDVtrC3kCKayMTF3oRovkxA1wrVkr+beKpoyw@mail.gmail.com>
In-Reply-To: <CAHc5_t30UFOdpqDVtrC3kCKayMTF3oRovkxA1wrVkr+beKpoyw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Dec 2023 09:40:55 +0200
Message-ID: <CAC_iWj+R4OmjHn8THLv_uivrhPFSGMLk+JLnYYB19r4PBRGEww@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Shantur Rathore <i@shantur.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 u-boot@lists.denx.de, trini@konsulko.com
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

Hi Shantur

[...]

> >
> > >
> > > >
> > > > Also the information is very limited, e.g. it does not show the Ubuntu
> > > > version, kernel version, etc.
> > >
> > > The length of the labels is only limited by available storage. It is the
> > > OS'es choice to opt for a such a short label.
> >
> > Yes, really I am looking for metadata that includes more detail at
> > different leaves, not just a label.
> >
>
> The job of these EFI is to load grub bootloader and rest all details
> (kernel version,
> OS, etc) is supposed to be handled by Grub.

Not necessarily. I'd prefer skipping GRUB for embedded boards that
don't boot distros. You can load the kernel directly and u-boot allows
to configure that (see eficonfig and efidebug). WE just need to make
sure that a bootflow with grub works as intended

Cheers
/Ilias
>
> [0] - https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> [1] - https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2471
>
> Kind Regards,
> Shantur
