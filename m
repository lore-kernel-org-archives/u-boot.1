Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55814CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 15:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE61E8329F;
	Fri, 19 Sep 2025 17:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ns8aarWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC3BA83314; Fri, 19 Sep 2025 17:51:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6E783285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b149efbed4eso370488666b.1
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758297088; x=1758901888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5s13hlHzrZPZEbKJe68HxXNgwxNL0nbo/gr7nK1qzc=;
 b=ns8aarWlXqUjjht2b3NX4ULBy1INhytYaTzlwtDb608lyfhW6Xj9GLF2xc96aZ8TUW
 aYd55bO8YEtfs+b2QKWksfcNXzHSVW9b62TB27u4I51zrNGLFj1RYBvYo8KFrW1Oz6PH
 /aMLx5L0eeS7D0QjPHW7VqXAy9zyMWoPaY2ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758297088; x=1758901888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5s13hlHzrZPZEbKJe68HxXNgwxNL0nbo/gr7nK1qzc=;
 b=n9xbJ+cAay9bJOaDRZtVOfHYZ0uD2BGV+VJNVCue7kYmiS9sIFrPvcwjZJlAYc3S1i
 U/xJ99S7BwpG31K1Sovk0p0Aqhs6As4J/NhZAlx4DPx3E3kufEQXOdSZYNXynHWcV6fP
 ddzqy8m0dOrlW/Jy0MhMYQ56W5ghCfgtGVC4+l+cPULaGbaz2EbzVcZTQq2hjBOMy3HQ
 nZDdOzvq8LzHcV03KL2NPsKzK/2waK7WaL1PifX6jkg9sJhhA54krhrUCwcQp/0wmUHY
 VDxIse31E0jUbYoDFEnUKSoSLpytPN/bA9nAK+DQTG7WnJVMu95YhZGPkffaSYapGfhl
 Jruw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjMwfMSeL/yxhA/JF7yfoX3bDDx6ynxB84nyUtXD6YzAZZbGEtW1/fexFdSuyy21dFD/EzIqs=@lists.denx.de
X-Gm-Message-State: AOJu0YznUz+wFVenmRGsvoHrgu+Rkg84kZJIu4DtQBOiSM9YAjbOvV11
 4fIVrMBatW9F724wZyVAUuMBPgCbsfMONM7mQuFMi9MeUoSe4y1v+ApWEjiOOSfi6JsfLrH1d1B
 ypPYE717e9th56gj/bebq3fQrskEY1rFSTrSXP4l3EIAcOjfL5o2TSQ==
X-Gm-Gg: ASbGnctdkdEw4uHtt9C6+xO3+R3u3xPZROQdwhNUaM2EAyJB9Uh2HSen3wwAHMeMiI3
 uaqUQ8XodZAwjCuE74Nm771UMTSMjL47EWZBYFn0ztSPr/mVapDKAAs2+AYW0mEgMuaaoFetsmE
 L8IzszmiXYvHkElfCVdNnyet2OZ6qTqVdTcmeILu5TRIQq0IXAPU0EbPY8i9GAafzKDrnFTg6SO
 5bY4g==
X-Google-Smtp-Source: AGHT+IEKcwFYaYzw1qlxG3X5Yz5JKaJw867FvIYCGAfRBE/dDc8wt1A4rt0lVla1tGai1BVYaTEybryVgp4SjrSAAAw=
X-Received: by 2002:a17:907:843:b0:b07:cdda:12fb with SMTP id
 a640c23a62f3a-b24f442a2bemr375452966b.49.1758297088189; Fri, 19 Sep 2025
 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
 <20250812150359.GS124814@bill-the-cat>
 <56d03251-1185-44ca-98e6-f45ac0e0af53@linaro.org>
 <aJx54frzXkLRFcGO@kitsune.suse.cz>
In-Reply-To: <aJx54frzXkLRFcGO@kitsune.suse.cz>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Sep 2025 09:51:15 -0600
X-Gm-Features: AS18NWD5o2PjQZGPKVK_Ncu4JMgKYCZQZpnZ1A2JF1k1hTNO38wmxOPa3U6YuZ8
Message-ID: <CAFLszTicwDH4wY4UcN=tebfFJnqKa8us5A4cGOy_ZvXPE69a_w@mail.gmail.com>
Subject: Re: Seeking advice on API return type inconsistency
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,

On Wed, 13 Aug 2025 at 05:41, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> Hello,
>
> On Wed, Aug 13, 2025 at 11:58:19AM +0100, Andrew Goodbody wrote:
> > On 12/08/2025 16:03, Tom Rini wrote:
> > > On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
> > > > On 12/08/2025 15:33, Tom Rini wrote:
> > > > > On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
> > > > > > On 11/08/2025 17:36, Quentin Schulz wrote:
> > > > > > > Hi Andrew,
> > > > > > >
> > > > > > > On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > I was wondering what people's thoughts were on API return t=
ypes. In
> > > > > > > > particular there is this and other examples in include/clk-=
uclass.h
> > > > > > > >
> > > > > > > > /**
> > > > > > > >     * get_rate() - Get current clock rate.
> > > > > > > >     * @clk:    The clock to query.
> > > > > > > >     *
> > > > > > > >     * This returns the current rate of a clock. If the cloc=
k is
> > > > > > > > disabled, it
> > > > > > > >     * returns the rate at which the clock would run if it w=
as enabled. The
> > > > > > > >     * following pseudo-code should hold::
> > > > > > > >     *
> > > > > > > >     *   disable(clk)
> > > > > > > >     *   rate =3D get_rate(clk)
> > > > > > > >     *   enable(clk)
> > > > > > > >     *   assert(get_rate(clk) =3D=3D rate)
> > > > > > > >     *
> > > > > > > >     * Return:
> > > > > > > >     * * The rate of @clk
> > > > > > > >     * * -%ENOSYS if this function is not implemented for @c=
lk
> > > > > > > >     * * -%ENOENT if @clk->id is invalid. Prefer using an as=
sert
> > > > > > > > instead, and doing
> > > > > > > >     *   this check in request().
> > > > > > > >     * * Another negative error value (such as %EIO or %ECOM=
M) if the
> > > > > > > > rate could
> > > > > > > >     *   not be determined due to a bus error.
> > > > > > > >     */
> > > > > > > > ulong get_rate(struct clk *clk);
> > > > > > > >
> > > > > > > >
> > > > > > > > get_rate is declared as returning a ulong but the descripti=
on says
> > > > > > > > that it can return negative errors. A simple test of the re=
turn
> > > > > > > > value for being less than 0 will always fail so errors can =
go
> > > > > > > > undetected. Casting to a signed type seems less than ideal.
> > > > > > > >
> > > > > > > > What is the best way to deal with this? Cast to a signed or=
 update
> > > > > > > > the API to be signed or...?
> > > > > > > >
> > > > > > >
> > > > > > > Note that clk_get_rate() in the kernel has the same function =
signature
> > > > > > > so I would refrain from changing the type otherwise we'll hav=
e some
> > > > > > > "funny" bugs to handle considering it isn't that uncommon to =
import
> > > > > > > drivers almost as-is from the Linux kernel.
> > > > > >
> > > > > > Ah yes. The difference being that the kernel does not seem to a=
ttempt to
> > > > > > push an error code through this API, you get a rate or you get =
0.
> > > > >
> > > > > How is the error code pushed? Or is it up to the caller to decide=
 that 0
> > > > > means on a case by case basis?
>
> Presumably it returns -EBUSY which is then implicitly converted to a larg=
e
> positive value. For pointers there is IS_ERR macro to decode that, and
> for integers there is another corresponding macro (I don't recall the
> name).
>
> For memory this assumes that the last page that holds the 'error'
> pointers cannot be mapped, and there was already a bug in the kernel
> that this was not true.
>
> For clock rates this assumes that rates close to the maximum value are
> invalid which is not guaranteed in any way whatsoever.
>
> Consequently, this should not be used.
>
> 0 is the only clock rate guaranteed to be invalid.
>
> As far as I have seen in the u-boot code almost no caller checks the
> result, and those that do cannot do anything meaningful with it anyway,
> at most a message is printed. That can be done by the driver without
> passing around the error.
>
> > > > In the Linux kernel almost no code checks the return of clk_get_rat=
e at all.
> > > > Some code will check the value is sensible and 0 is obviously not s=
ensible.
> > > > But pretty much the call to clk_get_rate is not expected to fail.
> > >
> > > Perhaps getting lost in the specifics then, but perhaps for this case=
 we
> > > should just do the same? But your question was more general, so anoth=
er
> > > example might help.
> >
> > I suspect that the answer is always going to that it depends on the
> > specifics of each case. The U-Boot implementation of clk_get_rate seems=
 to
> > have become more complicated leading to the addition of returning error
> > codes. This leads to the question about what level of compatibility sho=
uld
> > there be maintained with the kernel? That addition of returning error c=
odes
> > in U-Boot already means that the API is no longer compatible with that =
of
> > the kernel.
>
> I would suggest to abolish returning 'errors' as clock rates.

I don't think that is a good idea. Debugging drivers then becomes
quite complicated since there is no feedback and you must head into
the clock subsystem to see what is going on. Bring this into U-Boot
more generally and it will be very painful. At the moment at least you
can enable CONFIG_LOG_ERROR_RETURN and see what happened.

Better I think to create some new functions with the API you want
(e.g. panic on failure, ignore failure). Or rename clk_get_rate_int()
- for internal - and create a new clk_get_rate() that does what you
want / what Linux does.

Regards,
Simon
