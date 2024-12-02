Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAEED78333
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 16:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C2F88F68;
	Mon,  2 Dec 2024 17:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LSjtFiXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DA888FAB; Mon,  2 Dec 2024 17:49:03 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2D488A1C
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 17:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so5422444a12.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 08:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733158140; x=1733762940; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vt0PnmkIMphiTjBL+N3H2AOaivO7CXTNCjhU6ozjhbo=;
 b=LSjtFiXYaetNNj5yitJuDKRAajbNopBygwWU07yvN+XkhMLZfNzL0RJhDgBMdBBxPL
 hxBuq+Buc00DVZeTnp0HdDQc2LledPJTfLb3aJaNDUN31Vq/j1zH76Uf7u0czJyRx1oi
 6N+rpejlpov/bUHeWy3TdKJ79hi6SR70v47Z88FHj2jWjGeKPvFNp3CWTRC/7LK28eiw
 Ro5WEMW6+7AK4/3IeWBgjzUefzmCOwct7TEohZhugFsW9At3uP+Ve3q1cd3K1y7FLnhS
 slRhvFibrNjBxr72sYTF4r2Gi5ZYosr+qtwumXR+1mkTuar19837h4zMQ9QqMFJAiTt3
 fAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158140; x=1733762940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vt0PnmkIMphiTjBL+N3H2AOaivO7CXTNCjhU6ozjhbo=;
 b=d2+u3BsaaYUJEtVl+Zo9K3cTqNXf1R/9UKiXmRHqwmPny31X0Rmp4sq7BzbTs1hSet
 F3+zrBL9w8xfiy/bzA7itQv7mWFxE5Env2a+u7D3JkZz5Qb/mZ1RpctfvJhS77dwA8cR
 MVybLY/UaMMsecBK2AeKIYS+TD22hqCkTjbnduR+dUWvgAVtX1M7Y1OwQsUXU/cNBmfb
 5/lERl1+4tJb0LLFhGfw2Oyc3eOVCdOwYZUjhUxPj0Hf4fm9w/54iJ0ANNLuUZKi3QHl
 vbLO1SI2GEKk+zEeE1DyTnp+aGweErs4nKAz1Geos3MRSQgkRHbczAH0l1R1+WNC7DlP
 DtTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0zeu6v7Ooy2JEzNOdRhVncGtcxiDT+HmFmXEuLDIBH2xnCNOALZuevtDpuEv1eqMU9fSdOyA=@lists.denx.de
X-Gm-Message-State: AOJu0YwvY4pW96bpZG1ebHuyc72CKNodB+x/mTi5zNxZYpVMXWwWnmNZ
 VT6vexFaLpZinsDx5dqIWL6WnRillMuDGNkzjb8Eat3vZurzmEDRmoJRrXrpd6Sei0t+df/UeMm
 4g66ST7S9/0r5L5RBTlyiL9iSH+H0g8tDrgdo2A==
X-Gm-Gg: ASbGncvRaKzO0Zh4dePPK70et2YGFjzT3N5F4bSIOjQy1Ir5W5T8xZymXBKGPyxWJp8
 PAigcD0n16/T3cF3HlT2JbShx+WkDO8qc
X-Google-Smtp-Source: AGHT+IElocQhbDg16yPB2qFRilDOjjor8MCQOgYX5A3QdG0v9UTR19PZnn9VTJD48dfWrL7h20C7NZJuc4ESr18Rr1w=
X-Received: by 2002:a05:6402:3219:b0:5d0:b74f:6422 with SMTP id
 4fb4d7f45d1cf-5d0b74f66b8mr17219894a12.32.1733158140335; Mon, 02 Dec 2024
 08:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <mvmfrn6mh4j.fsf@suse.de>
 <CANV2PTNmUp013xDT1bqKYcyo=aP4NXtLN_u01pXmdNM417RygQ@mail.gmail.com>
In-Reply-To: <CANV2PTNmUp013xDT1bqKYcyo=aP4NXtLN_u01pXmdNM417RygQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 2 Dec 2024 22:18:49 +0530
Message-ID: <CADg8p971xk8qkeXnM6fSK0iy5UfSd5x8ekNwBL3DAt+hhSM0qA@mail.gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: E Shattow <lucent@gmail.com>
Cc: Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, 2 Dec 2024 at 19:16, E Shattow <lucent@gmail.com> wrote:
>
> Hi Sughosh, Andreas, et. al
>
> On Mon, Dec 2, 2024 at 3:58=E2=80=AFAM Andreas Schwab <schwab@suse.de> wr=
ote:
> >
> > On Dez 02 2024, Sughosh Ganu wrote:
> >
> > > There are platforms which set the value of ram_top based on certain
> > > restrictions that the platform might have in accessing memory above
> > > ram_top, even when the memory region is in the same DRAM bank. So,
> > > even though the LMB allocator works as expected, when trying to
> > > allocate memory above ram_top, prohibit this by marking all memory
> > > above ram_top as reserved, even if the said memory region is from the
> > > same bank.
> >
> > This fixes the boot failure on the VisionFive2 board as reported in
> > <mvm8qtnv310.fsf@suse.de>.
> >
> > Tested-by: Andreas Schwab <schwab@suse.de>
> >
> > --
> > Andreas Schwab, SUSE Labs, schwab@suse.de
> > GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B=
9D7
> > "And now for something completely different."
>
> Echoing what Andreas finds in testing, this avoids the platform issue
> with dw_mmc driver and the visionfive2 board support on 4GB Star64,
> 4GB Mars CM Lite, and 8GB Mars CM Lite WiFi.
>
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 14b9b8466ff..be168dfb8dc 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -615,6 +615,7 @@ static __maybe_unused void lmb_reserve_common_spl(v=
oid)
> >  void lmb_add_memory(void)
> >  {
> >   int i;
> > + phys_addr_t bank_end;
> >   phys_size_t size;
> >   u64 ram_top =3D gd->ram_top;
> >   struct bd_info *bd =3D gd->bd;
> > @@ -628,6 +629,8 @@ void lmb_add_memory(void)
> >
> >   for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >       size =3D bd->bi_dram[i].size;
> > +     bank_end =3D bd->bi_dram[i].start + size;
> > +
>
> Delete newline? Unless existing style is wrong here.

It's not about style, but the above two lines are more of an
initialisation within the block, which is the reason for a newline
here.

>
> >       if (size) {
> >           lmb_add(bd->bi_dram[i].start, size);
> >
> > @@ -639,6 +642,9 @@ void lmb_add_memory(void)
> >           if (bd->bi_dram[i].start >=3D ram_top)
> >               lmb_reserve_flags(bd->bi_dram[i].start, size,
> >                         LMB_NOOVERWRITE);
> > +         else if (bank_end > ram_top)
> > +             lmb_reserve_flags(ram_top, bank_end - ram_top,
> > +                       LMB_NOOVERWRITE);
>
> Please guard this somehow that it will be enabled per each platform
> that needs it, and/or give warning when conditions this specific code
> path is a workaround for are reached that are different than before
> the patch. Any similar platform-specific memory addressing bug/quirk
> having previously avoided a trigger will silently continue to work
> here instead of getting documented; we should at least uncover these
> assumptions.

Instead of putting some check here, and complicating the code, I would
say that the board maintainer would know why the ram_top has not been
put at the top of DRAM memory -- if possible, the ram_top should be
the highest possible DRAM address. So this is the responsibility of
the board maintainer instead. Ideally, for a 64 bit machine, like the
one where you hit this issue, there is no reason for the board to not
use the highest possible DRAM address as ram_top, unless there is some
issue, like accessing memory address above a certain value. So, this
would not be an issue if the board is using the highest possible value
of memory as ram_top, especially when it comes to a single DRAM bank.

>
> In the theoretical situation where we are to just fix the visionfive2
> mmc platform specific issue in the dw_mmc driver and not need this
> workaround code anymore, there's not visibility for us to easily
> diagnose if a similar assumption or previously un-triggered platform
> quirk exists elsewhere. There's no warning, and no easy on/off config
> option to test with and without. The memory rework commit 22f2c9ed9f53
> is here a useful tool to break and bring attention to assumptions in
> code and documentation.

Fixing the mmc driver issue may or may not be possible. And if this is
indeed a fixable issue, then, after fixing the mmc driver, the
subsequent change should also remove this restriction on the ram_top
value, which will automatically take care of this restriction.

-sughosh

>
> >       }
> >   }
> >  }
>
> CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy added to visionfive2 config in
> 6c791b6646c1 does not make sense to me as when I tested it did not
> avoid the platform issue. Restricting the memory allocations is an
> effective workaround to the visionfive2 platform issue. I leave that
> to the experts if a revert is appropriate given that we have an
> effective workaround now.
>
> Thank you Sughosh! This is (meanwhile until more comments and review)
> a functional workaround.
>
> Tested-by: E Shattow <lucent@gmail.com>
