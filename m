Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF25AC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 07:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D515830F6;
	Tue, 22 Jul 2025 09:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fHEKtB6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4171583285; Tue, 22 Jul 2025 09:42:27 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B513682E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73e88bc371cso1912726a34.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753170143; x=1753774943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGF7YnZOSKFuoaXu47tsnw7ZbscKvLrl1KGlHLZ8cX8=;
 b=fHEKtB6VB1bjCKsqwZb1sJWRvOgHuDl2pEG2JTpX9cPcl8o2Bjg1j6Qu9R49TQv4/+
 6FHWHcjMA9PMycz4ptQFe9JpiMUzQ2EJFjyW00W3UmDDLyS4Yq7cQ8VWGcAUd7Y+jveS
 bJE1ICPVMVLWl+yqlPUi3ZN0srJBo+GlDjAUHxFBnV0sgY67mo/myT8ANjcjjQNMnI5o
 yHftdrld4oNx4Smx4v2STdF+1ZGKCOUfURrqFeJlUJ4JOD6+nSUXuxAPZXwnW8jMxS5k
 r1292KQvgPQqrsfH7I3LgJTe3tIvhLM1faS6a9idIC1xents1OuNRBcBsxN/FMx6dg3z
 kEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753170143; x=1753774943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGF7YnZOSKFuoaXu47tsnw7ZbscKvLrl1KGlHLZ8cX8=;
 b=UKbLQW2EtgKxcHIXd6DtbH9U86GZJDOMa//Yqg57iigcLsxuL3Z97zL8NF8uWnpo9K
 zj0kb0ulYgUIF10+zbeoFangY/nu0e7fFJhVz+PxknrqkuSaROn7uOdW0Pg92DxVqoRc
 jUh3k+1rYbXkTU2zw1av+NGjzRyLhiSbVf0Kq9Spca7bzAiMnbOqqGVI69tQzdO7OP1D
 +tXyUWHieien5hAh67q5ELKWck7gdtExLPWkFJSdRo/Az2euOT74xqoxo6yV1MFR/fP2
 3O+qPvIN/ctaG3iFZzyB9hZkh7fr1inGcOV9cFPJw/hCQGFkddiiGiQsAKssHp1NFxVM
 F+Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9zakHEX6rrVM9R191Ufulwk/G0y2yYkDLCy8QS4+waY3u9lMFWOiJwLBSjuUBYCK1Gh7Zm68=@lists.denx.de
X-Gm-Message-State: AOJu0YwqtLh/njx5u7Loh06hI5Q6uRuVGXQSxqWCZCJ2B3uqZfw2lP+G
 FjU/a/+EUFMom6WWsnESH1hjqW13MSodEpUR7PB30x+pMLz/4ijMDpPrfsnDzDEGlF7gWLoz7gF
 huv5a9VpildiXBe07cEzsBnf5aYD3CBs=
X-Gm-Gg: ASbGnctfDtbNOXOwt4BvaAF61zBZhjGvnUoPL97H36U5RSTDxqZaWuyCFoJOT+9uN5C
 PhOirBxhgMSkScAytW85lMmTPga0WQb4O8tDDXnZTgCY0ylMYeWmfLnYwwE9UMmbRPHQl+F0Mrg
 xLfSDwb8NMG224nDmPX+zEVM9XlRCVGr4xcnVJUfdHqcn6MtM7FjIXoTLw63NGiUl3qJ3TvAduP
 Rcb8nwZRgoxPDLT76Q1X3igr7pPlib2BLB39G9l
X-Google-Smtp-Source: AGHT+IEUsxfFh0j4nTG82tXuX2XLh72RsUM8dacIF6kqK1XAhej/Z0gaDBU4eAhyW4+1CcIvNfNF1DhBqZ9CYfcKYd8=
X-Received: by 2002:a05:6808:3c4b:b0:40a:56aa:c806 with SMTP id
 5614622812f47-41d04c9599emr18486798b6e.22.1753170143441; Tue, 22 Jul 2025
 00:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
 <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
In-Reply-To: <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 22 Jul 2025 16:42:12 +0900
X-Gm-Features: Ac12FXyjolU_xZToM-G-ubIJflfvIAWMbPrT4_bz2adrM7gRqx-59vty7EhK1h8
Message-ID: <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


2025=EB=85=84 7=EC=9B=94 22=EC=9D=BC (=ED=99=94) 13:30, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon, Jul 21, 2025 at 4:26=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
> >
> > On Sun, Jul 20, 2025 at 14:57, Sam Protsenko <semen.protsenko@linaro.or=
g>
> wrote:
> >
> > > On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
> > > <mkorpershoek@kernel.org> wrote:
> > >>
> > >> Hi Sam,
> > >>
> > >> Thank you for the patch.
> > >>
> > >
> > > [snip]
> > >
> > >> > +
> > >> > +#define EXYNOS850_DRD_UTMI                   0x50
> > >> > +#define UTMI_FORCE_SLEEP                     BIT(0)
> > >> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
> > >> > +#define UTMI_DM_PULLDOWN                     BIT(2)
> > >> > +#define UTMI_DP_PULLDOWN                     BIT(3)
> > >> > +#define UTMI_FORCE_BVALID                    BIT(4)
> > >> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
> > >>
> > >> Comparing with the linux driver using
> > >> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2
> 4nm controller")
> > >>
> > >> I notice that the defines are in reverse order (from 0 to 5 and linu=
x
> > >> has from 5 to 0).
> > >>
> > >> Is there any particular reason for this?
> > >> I don't mind it too much but it makes diffing between linux and
> U-Boot a
> > >> bit harder.
> > >>
> > >> Anyway, I've compared this with the linux driver and it looks good t=
o
> > >> me!
> > >>
> > >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > >>
> > >
> > > Thank for reviewing this, Mattijs! Yeah, I kinda flipped the register
> > > bits w.r.t. kernel's version, just because it looks better to me this
> > > way (easier to read when it's sorted properly). Due to the driver
> > > model API differences between kernel and U-Boot I had to rework the
> > > whole structure of the driver, and I only added Exynos850 support for
> > > now, so the difference between U-Boot and kernel versions is quite bi=
g
> > > as it is anyway, so I figured it's not a big deal to reorder things
> > > even more. Hope it's ok with you?
> >
> > It's ok with me. I was just curious if there was any special reason for
> > re-ordering. I agree that it's easier to read with the sorting you have
> > applied.
> > I've noticed that only Exynos850 is supported for now. That's fine as
> > well in my opinion!
> >
> > Feel free to pick this up through your tree.
>
> I don't have a maintainer tree unfortunately. The easiest way for this
> series would be probably to go through Samsung tree (Minkyu)?


Yep. This patch is delegating to me.
But unfortunately I have trouble to access to denx git on my office.
I'm trying to fix it but not sure when it can be.
So I'll ask to Tom to pick this up at this time.

Dear Tom,

Could you pick this up?

Reviewed-by: Minkyu Kang <mk7.kang@samsung.com>


Thanks,
Minkyu Kang.
