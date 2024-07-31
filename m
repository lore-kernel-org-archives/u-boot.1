Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C669C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D637388971;
	Wed, 31 Jul 2024 09:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FoQ0WV7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2138897E; Wed, 31 Jul 2024 09:40:34 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657A288958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d5aecbe0a9so3339781eaf.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722411631; x=1723016431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9H/6G1qovknqGga8jvcPgIuSanipY7q4sDUxFJciG4I=;
 b=FoQ0WV7CsqbWNWk40abEB5c72b7J+OsgyRcfPtxCunAxDrgn+JwRRWrumYVPy3wsmk
 eK/dbMWGHwYq4atFrpaD0Rza8Lb3LqPQMuU13Y2BfepLxGIo6iLVMn4K6THAdCyv9TVS
 P+XuLhqCMKOPwkX0T+/3DWSD/O9uqkx+CKaj+RitXgdC4NUwtEfVCoQWeU836t0Q5T0B
 MxI9mhSj026L+zvofyqMHfa9P56nEOJpnExmAOFFXmwxfGOQAWQQBdQvk0mkjeEavFEl
 zk2J9U2rFNL+AP0W0d43GKA7RIDehaOTUQMt7zisVWJwBkX2zTa1X0AnUi+HDPYBKwRZ
 1CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722411631; x=1723016431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9H/6G1qovknqGga8jvcPgIuSanipY7q4sDUxFJciG4I=;
 b=EZcZFfnmElVa/4x9Xrc7LXpln+j+uOORMMtKlY8JtW8YS2Et0D9e/Ce3vHhTqmvoxO
 JxVDhliz2St+flu/P285p2ZthyLmfA/wD1c6KqoHPlViDdo/6Vb/rZxtNi8OCHKNCiOw
 a8BL4+R0NTElsrnUMuLUCBZ42Lh6lIYecQsCvDzD+Ka8S0+LsEJYAPtTW1v4mX0+NOox
 tNWzI4kEJAYQkXnZp/hIT/YyfV+pXp8/FP3xYLgoJHuNbThABsSblr9NjBR7QTpfG0bq
 pSyCVFNffKQSlM8z4Wu+4IxvYupvxS9gYkN9aYoMisQmMuL5wJPrl0oErhnq8/YhkS+s
 6sZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUffD8+bdSLIP16n7EMhkLiehp8IMn0/FZKNqv6GxxBW3+2h9jnjr+BynPs2mXElXHhWFRB4jzrGgmwWAL2/UTiBipB7A==
X-Gm-Message-State: AOJu0YwY3db6uPVGcdCS+zFAjsDWtc2kD4Z5hcy6BNArPFiSpP03h6lh
 OOiIGp2HckXQZ1MtVu7xJnoUMJSfi6MxgcV9a1AhH0lgN7bhYSvAJ1kNGzW1H4EF1iJQJ949uaj
 pDZKK/YEu3hQkSLJsoQxruoMCbyUkZYsO98RJ9Q==
X-Google-Smtp-Source: AGHT+IFDq/1NSFAMK0iO4oRgQXOxFx1iettCu3iioN/mERmCpULLQfXUACbUi+1vPgGA3HS/ZAcHtWQkf9Du5b/+g7E=
X-Received: by 2002:a05:6870:2252:b0:25e:bd07:4743 with SMTP id
 586e51a60fabf-267d49e67a9mr17036802fac.0.1722411631019; Wed, 31 Jul 2024
 00:40:31 -0700 (PDT)
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
In-Reply-To: <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 10:39:30 +0300
Message-ID: <CAC_iWj+9T0JC3VZi_Neq8o-+M1y4-EZVPBE=f_tN6ro5PgLf5g@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
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

[...]

> > > > > > >
> > > > > > > Please also see below.
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > > > > > > >
> > > > > > > > > It still allocates memory 'in space' and uses 4KB for each allocation.
> > > > > > > > >
> > > > > > >
> > > > > > > This is the key point that doesn't seem to be coming across. The
> > > > > > > current allocator is allocating memory wherever it likes, potentially
> > > > > > > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
> > > > > >
> > > > > > It is, but I don't think using malloc is solving it. It's papering
> > > > > > over the problem, because if someone in the future launches an EFI app
> > > > > > or allocates EFI memory with a different type you are back on the same
> > > > > > problem.
> > > > >
> > > > > It is certainly solving this problem.
> > > > >
> > > > > Once the app is launched it is OK to overwrite memory...

Why is it ok to overwrite memory? Do you assume that all EFI apps do
is load something and boot it ?

> after all it
> > > > > has been loaded and is running. The issue is that these little
> > > > > allocations can end up anywhere in memory. Did you see the qemu_arm
> > > > > note?
> > > >
> > > > Isn't this another part of why we need the LMB rework? So that
> > > > kernel_addr_r, et al, can be marked as reserved.
> > >
> > > If we mark them as reserved, we won't be able to load a file into that
> > > region, so boot scripts will fail.
> >
> > No? We mark it as being overwriteable but allocated. This is part of the
> > LMB rework series.
>
> Yes, I see, that makes sense. I don't know any way to guess the
> expected size of the kernel or ramdisk. I see that Apple uses 128MB
> for the kernel (plenty) and 1GB for the ramdisk.

FWIW we dont preload the initrd in EFI. The kernel during the efi stub
hadoff allocates pages, and loads it on the fly.

/Ilias
>
> >
> > > Please take a look at the whole series and let me know if there is
> > > anything missing from the descriptions I have given. I have had this
> > > problem in the back of my mind for some time...but just a few hours of
> > > investigation was enough to determine that it really is broken.
> >
> > I'm missing something, sorry. Yes, it is known that EFI can make some
> > incorrect assumptions about what memory is/isn't available (as other
> > implementations give EFI the world to work with), hence the LMB rework
> > series to address some of these problems.
>
> My goal here is to tidy up EFI memory allocation so that it doesn't
> result in allocating memory in strange places. Avoiding overlaps is
> one thing, but the way this is heading, we will get overlap errors
> randomly on platforms when someone tries to load something into RAM,
> or we won't protect things that need to be protected. It is all a bit
> mushy without a proper design.
>
> Does that make sense?
>
> Regards,
> Simon
>
> [1] https://lore.kernel.org/all/CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com/T/
