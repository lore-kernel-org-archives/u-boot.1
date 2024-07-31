Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9EC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E2888A63;
	Wed, 31 Jul 2024 16:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xw8WVz4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551BE88A42; Wed, 31 Jul 2024 16:39:26 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C977A88955
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70944dc8dc6so2906355a34.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436762; x=1723041562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FPc+nIvxddwKJiHTlPT2/Q0G30vP48WkYcA6aRWEz4=;
 b=Xw8WVz4ro349I3UagC+HSCDczx44Sxht3G/G4r1sA8FQjq0gLYUmQIFidZLEXIEmzq
 l5ECJ/gVfMwW6yhraZ5iMKMCXl6loc3wHY/an3PznXCPWEVB6P4dHFAovwmQ6BnZqcdk
 3krJgs0Lo+fcdi/3gXOM925tXRIs0j3mCH9Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436762; x=1723041562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FPc+nIvxddwKJiHTlPT2/Q0G30vP48WkYcA6aRWEz4=;
 b=rCI6kI5aa4cEFB9NRS7Yb/LkW1F2vPlngB9BPRBLrqeg3o5WGa5teAdsPKol84yPSY
 UK309UHJx6+Q1wEeLUR5gof76aIVOaZHYYJeOStj7PPSVazell9LJvV1trLy8fsgGv6i
 eAXtNX0fyK7HiBWYL5YWvO0wziLyPGcMu5eJ1KU/riMIzkfP8ait21dC/dNCU1Xeh4BY
 L7KH4RanfUahU8HWwfULRA7MbTjMBG87v4UVei3o1+hOaMFfssFC9dhVqS4hsXR/EDQ8
 CEZV+hm0BV+BxFgyT+5wYhAS37/cC4m9fFlw7hfke7Ciy3i90AZDtuvdtX+u+nnZ6uAM
 h1sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe1e3gDDlDe2hCKNV84zLlFjwUxeBunojNSpujAnSjBSO4eVxczMis7KD+J60t/CKV7B/EruFV6bpC8u3U3xnZia1pCQ==
X-Gm-Message-State: AOJu0YwOwL5f+3k+w5DY8a03IEe/pG6g8SbnRjCAiRtcnIJ4MyURJHGA
 gIs0xsNgS845XxsGcNcPB4r5HljVOK86Ts64zmazcvEaAiHYSLVnuXrDALcV6f2tCpJKVbwz+D3
 +Bgv2VP/wJgJ905Gi/1yceau2YmpCFEQNB4d1
X-Google-Smtp-Source: AGHT+IGK5LLWzul+CUln9ZqrluweiLiFrkdwvbBxPvS4Yme6L2VS5HoMhoIlnRYX/ViQo0cqzXUIWl1IKpKZvIT3nuY=
X-Received: by 2002:a05:6358:9f95:b0:1aa:c73d:5a8a with SMTP id
 e5c5f4694b2df-1adc06857e9mr1405233955d.16.1722436762430; Wed, 31 Jul 2024
 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJbs=i6gWHzeHbsHwFv5BC+6PWy0NesKFFWC1=ERAvcQw@mail.gmail.com>
 <CAFLszTgkwUvou2i0zVCxJPDqGQPxbKUHE41gMs5Kt1_SToL9LA@mail.gmail.com>
 <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <CAC_iWj+9T0JC3VZi_Neq8o-+M1y4-EZVPBE=f_tN6ro5PgLf5g@mail.gmail.com>
In-Reply-To: <CAC_iWj+9T0JC3VZi_Neq8o-+M1y4-EZVPBE=f_tN6ro5PgLf5g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:11 -0600
Message-ID: <CAFLszTg3MGq-mBYHqqX1qy27bw_atxYyzdchsc3tPf=e-4f7mA@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Wed, 31 Jul 2024 at 01:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > > > >
> > > > > > > > Please also see below.
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > > > > > > > >
> > > > > > > > > > It still allocates memory 'in space' and uses 4KB for each allocation.
> > > > > > > > > >
> > > > > > > >
> > > > > > > > This is the key point that doesn't seem to be coming across. The
> > > > > > > > current allocator is allocating memory wherever it likes, potentially
> > > > > > > > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
> > > > > > >
> > > > > > > It is, but I don't think using malloc is solving it. It's papering
> > > > > > > over the problem, because if someone in the future launches an EFI app
> > > > > > > or allocates EFI memory with a different type you are back on the same
> > > > > > > problem.
> > > > > >
> > > > > > It is certainly solving this problem.
> > > > > >
> > > > > > Once the app is launched it is OK to overwrite memory...
>
> Why is it ok to overwrite memory? Do you assume that all EFI apps do
> is load something and boot it ?

I mean that by that point U-Boot has finished loading images etc., so
it doesn't matter if EFI starts putting things where it likes in the
address space.

>
> > after all it
> > > > > > has been loaded and is running. The issue is that these little
> > > > > > allocations can end up anywhere in memory. Did you see the qemu_arm
> > > > > > note?
> > > > >
> > > > > Isn't this another part of why we need the LMB rework? So that
> > > > > kernel_addr_r, et al, can be marked as reserved.
> > > >
> > > > If we mark them as reserved, we won't be able to load a file into that
> > > > region, so boot scripts will fail.
> > >
> > > No? We mark it as being overwriteable but allocated. This is part of the
> > > LMB rework series.
> >
> > Yes, I see, that makes sense. I don't know any way to guess the
> > expected size of the kernel or ramdisk. I see that Apple uses 128MB
> > for the kernel (plenty) and 1GB for the ramdisk.
>
> FWIW we dont preload the initrd in EFI. The kernel during the efi stub
> hadoff allocates pages, and loads it on the fly.

OK thanks.

>
> /Ilias
> >
> > >
> > > > Please take a look at the whole series and let me know if there is
> > > > anything missing from the descriptions I have given. I have had this
> > > > problem in the back of my mind for some time...but just a few hours of
> > > > investigation was enough to determine that it really is broken.
> > >
> > > I'm missing something, sorry. Yes, it is known that EFI can make some
> > > incorrect assumptions about what memory is/isn't available (as other
> > > implementations give EFI the world to work with), hence the LMB rework
> > > series to address some of these problems.
> >
> > My goal here is to tidy up EFI memory allocation so that it doesn't
> > result in allocating memory in strange places. Avoiding overlaps is
> > one thing, but the way this is heading, we will get overlap errors
> > randomly on platforms when someone tries to load something into RAM,
> > or we won't protect things that need to be protected. It is all a bit
> > mushy without a proper design.
> >
> > Does that make sense?
> >
> > Regards,
> > Simon
> >
> > [1] https://lore.kernel.org/all/CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com/T/

Regards,
Simon
