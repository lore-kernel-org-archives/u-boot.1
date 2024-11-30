Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1271ED7360A
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 20:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B2889765;
	Sat, 30 Nov 2024 21:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fJqAToIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FAE898B1; Sat, 30 Nov 2024 21:24:42 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B57B89471
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso445068466b.2
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732998278; x=1733603078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FFgLOpmlhOSEixOAjj6qOpdXeVOBRprdtITD5jHpnrs=;
 b=fJqAToIgtwH35Sjo9lcu5BVOEuQaNHX8Je5dKD6Z71mLcG/VznBbXJgD9T1zMtA87k
 BTqE6pi2dWaFuamN1fjEu2gvr6kie3Uih0sGrqT6Q5dd3faXT7Rij5amt1RyMRfdrw3s
 i54JULNuNUNBRs785oqYaAsZOnXQ+By7SdMSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732998278; x=1733603078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFgLOpmlhOSEixOAjj6qOpdXeVOBRprdtITD5jHpnrs=;
 b=KyjPtEmFpXEtyDW5OHZievJffMCAp7M1kcaSXfClISfvhnY11zL7xnvTnRC4m6MySP
 OsahRbH13lbHAu114lpzj5aJvMQSAfBsLWxwy/1iA487nex5ECSq/fOM+DASxp2wRugG
 KceaMjAPz33GEhASdiSbUJVIhtQGLjSc3VDLz/N2aLAIICWH3XAvxmpbm6ri/DICXa/v
 wykZxHxHJs0YtQuvCZtmatVsEGzm3aIN+S5WIZLcQxXvN0iVnpXO8r/KpHVzq/9LzBoI
 FYehxnxhgEYI2SRHhJH+sfXVvKHYIJI7M7vO8KaxzyF0xM3iBNO7ukgWNylmM0C/E/o0
 BzPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX10bjFoCXMM2Azdff3Li1KM5IXpT6wNggwgRzRfKvm6dlatf7FSbl+5/fQ9EGALD0WJebPvP8=@lists.denx.de
X-Gm-Message-State: AOJu0YyjoW4a5VuIVTDguZhXLlHiH/82ZjULsfrb8vtIm/7BUzZH1G6P
 gE4KLuxC494+SinyU2g2N3IerH6fpLTo1A8XmdgdavbJ3qI6km9mLeYKYZ2GUdpDK2mqsTxh/D/
 nydqDutqBVYStxSGg/DIrEuRrYvHY6C39aS3h
X-Gm-Gg: ASbGnctOc7gKpK2b0XJyCOZTYqpz6pkNDIak5vf2TWG4nCS7LTKPS4TzdLo3imfAmSd
 7DIMjoDM1KERVZkS5UHpfmdDfPym0/cg=
X-Google-Smtp-Source: AGHT+IFuFFgxkoGXbr+Ym+ZjBDwgG0FIWqdQ7qKaZNFfh6YPPyaDaS9kFAoF3UOcD0pV3t2E4mniMt9dIOq3tqmNS6o=
X-Received: by 2002:a17:907:abb:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa58108aa75mr1341300366b.58.1732998277684; Sat, 30 Nov 2024
 12:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-7-sjg@chromium.org>
 <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
 <CAFLszThWDNCNhZ6wAaG3omKpT-ZEDkK-R1W-9DWyMuth8Vd55Q@mail.gmail.com>
 <CAFLszTjWgWZ6VZg8ZQOd2RVrX-+vGy1NuwaBZ+8vwGJ2R83wqw@mail.gmail.com>
 <87iks8zu79.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87iks8zu79.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 13:24:25 -0700
Message-ID: <CAFLszTij5XoTES+O_2AckL-iioaqxD_Ltw1u-ztquxu5kEMWbQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] efi_loader: Use the enum for memory type
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, akashi.tkhro@gmail.com, 
 caleb.connolly@linaro.org, j@jannau.net, marek.vasut+renesas@mailbox.org, 
 moritzf@google.com, pwildt@google.com, sughosh.ganu@linaro.org, 
 trini@konsulko.com, vincent.stehle@arm.com, u-boot@lists.denx.de
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

Hi Mark,

On Wed, 27 Nov 2024 at 06:23, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Wed, 27 Nov 2024 06:07:05 -0700
> >
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 08:37, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > On Tue, 26 Nov 2024 at 02:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > Rather than an integer, it is better to use the enum provided, when
> > > > > referring to an EFI memory-type. Update existing uses.
> > > >
> > > > The C standard provides no definition of the size of the integer used to
> > > > implement enums. It could use u8, u16, u32, or u64.
> > > >
> > > > As EFI applications may be compiled using a different compiler we need
> > > > to control the width used for passing parameters in the API interface.
> > > >
> > > > We should have used u32 instead of int here. We could use a typedef for
> > > > more verbosity though that is frowned upon in U-Boot.
> > >
> > > Yes, the ext function is debatable. The rest seem OK to me, though, as
> > > they are internal functions, See also [1].
> >
> > Hmm, but the spec uses enum, so arguably this patch is more correct?
>
> Only as a way to define the constants.  The actual interfaces that use
> the constants use UINT32, which would indeed be u32 in Linux land as
> Heinrich suggests.
>
> So no, the patch isn't correct.

Just to add a bit more detail...

I see the spec says this: "Element of a standard ANSI C enum type
declaration. Type INT32.or UINT32. ANSI C does
not define the size of sign of an enum so they should never be used in
structures. ANSI C
integer promotion rules make INT32 or UINT32 interchangeable when passed as an
argument to a function."

The compilers we use (at least gcc and clang) use int as the enum
type, and int is 32 bits on 32/64-bit machines.

So it looks safe to me. But since the spec goes out of its way to
mention this point, it seems best to keep the external interface using
int and just use the enum within the implementation code. That's what
I did on v2 onwards.

>
> > > >
> > > > Best regards
> > > >
> > > > Heinrich
> > > >
> > > > >
> > > > > Call the value 'mem_type' consistently. Fix up one instance of
> > > > > upper-case hex.
> > > > >
> > > > > Fix up the calls in struct efi_boot_services so that they use the same
> > > > > enum, adding the missing parameter names and enum efi_allocate_type.
> > > > >
> > > > > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > > > > is clear it is a return value.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >   include/efi_api.h                |  6 ++++--
> > > > >   include/efi_loader.h             | 28 ++++++++++++++-------------
> > > > >   lib/efi_loader/efi_boottime.c    | 13 +++++++------
> > > > >   lib/efi_loader/efi_device_path.c |  4 ++--
> > > > >   lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
> > > > >   5 files changed, 45 insertions(+), 39 deletions(-)
> > > > >
> > >
> > > Regards,
> > > SImon
> > >
> > > [1] https://stackoverflow.com/questions/4879286/specifying-size-of-enum-type-in-c/4879350#4879350

Regards,
Simon
