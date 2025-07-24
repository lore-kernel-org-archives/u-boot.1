Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00871C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F30836A7;
	Thu, 24 Jul 2025 11:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cPCtQf6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D500C836A9; Thu, 24 Jul 2025 11:45:12 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EAC836A3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-41b8e41a2bdso772634b6e.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753350309; x=1753955109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4vNubt7zoAbg27YyzcJ9q37Ud9MOoV1QI+fqMzkne/k=;
 b=cPCtQf6JtHBkrcwsZQ4ZzhbNffrbvLnTnUDfODHH034fqqiFCWGQCT0b/g87LdRFkq
 8WuxipGef5AFpxQKTyxNa28sVfNlNFlNLdNGGipqQO04JJJPHSuJLZW50LmK0C2Z8tl/
 y/yr405GkdppPmLqh7lALd3+E2FW6c+Do0+Qj1ZooQrskNKYKn1jwAUFRfowthsfjHgR
 +SxdW5Gr9J7QZctv5WRiJeVp+hZfnwJCDJVcCzxjDlVkPBM5FC7kIa59X0Mdg0o3urew
 bWu7r4NMADliDQLSTJtsNJw6KpI2PAYk0X8Mi573OSEj2HBYilws0aAg/sC1fdyM9MVd
 N8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350309; x=1753955109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vNubt7zoAbg27YyzcJ9q37Ud9MOoV1QI+fqMzkne/k=;
 b=t25qobcgN4zzUsYAgoHtNobwTChvkcUlhR3UvoHQpeMHpSPIjrhVkV8FRDH9jJ4qej
 wpdvavAAkW1XNBo+lwHp1T59nWHXzQuPpnoZrlVN/HYPxF8+QNCYN1GGsbHPiOJAoLX9
 rsPZAuUAM2z1lNmp4OtvWGpmepaw/CXNKdzW5IgI/I/AjPAzn4I38vE/uG8fJMd7DRMW
 xFGSpgzKWlSqyAGWf/JuoHsNzW3DCmUBawRiPH5u1FsQ2aVekXUXJF6mTQ/yH6tjNRxm
 gTtqVq9HtzO+rFCED9ZAhnG2S+bsAT59idzLBgUdT2q74hkXg1w8/rFQ5WMoY4PSw2te
 aijA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvQFOi/GB3RQWQE8j4XqZdCtu9JRRq/rzv5kvjcYa7+rZb8iSyL6f10VcRvUUfHLgenArWKxg=@lists.denx.de
X-Gm-Message-State: AOJu0YxkCx26t8NtkSUG9CcwV6DYuIhMYhZ5UCMtDyawz5EjpWUeuw1J
 Yh0r3C5X5LzbSTFctidh+PYvDi02wRo+dD/lWtO+HQR+KIy9ryT+J3cb0+jAVdI59zwtGSJ98NH
 g3fN0rIl+SisABun2W+i4oeqLlE6WmQo=
X-Gm-Gg: ASbGncsluqhGLmuEi5v+4U1EOX60QgKXENpyJ6DAHNJj3DZZTRrfi/mOynONfUn/Qw5
 mL25GKNDPwWEsJ0yVl/Ta2DDQIvahpHra96VsDqU0nDQISCQUMmSvPKKOtXs7xCHNBL/vYKka0M
 td4+2f4zaMRFhUlct17dbw4qlWj+pWxyd+ZSCyq9K8P/x9ANZP/XEusdQc0jTzidAD9XuZoXl40
 +wqMayFZIJSN8hfGGLWa/FE2FQGvQJdkDvK7nCN
X-Google-Smtp-Source: AGHT+IHD5PkmGyijrgbHnHkoSF94POrkkpYrsUyZZ/etmr1fqljuPnfC5gi2FozQs4Ee5NB9MdhVZDaN51H+sVQWsWo=
X-Received: by 2002:a05:6808:4f66:b0:40a:5380:b8d1 with SMTP id
 5614622812f47-42a55e591e4mr597506b6e.3.1753350308642; Thu, 24 Jul 2025
 02:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
 <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
 <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
 <CAPLW+4=gdMZqoP3zZn0Dk6p5GY4N0pCDnKsXcqtLK41P-Qqu3w@mail.gmail.com>
In-Reply-To: <CAPLW+4=gdMZqoP3zZn0Dk6p5GY4N0pCDnKsXcqtLK41P-Qqu3w@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Thu, 24 Jul 2025 18:44:55 +0900
X-Gm-Features: Ac12FXzdk13XCcQ-N7vpiPmMN0DuTHa3umhCNTtvvnacQC9lii9sz5cn-uV4c9g
Message-ID: <CALrBrZ2Rouk+G9HCS=pbAwxJ76ZvLKhkWp=mW_ztE5R5OPiPSQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marex@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Simon Glass <sjg@chromium.org>, 
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


2025=EB=85=84 7=EC=9B=94 23=EC=9D=BC (=EC=88=98) 04:22, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Tue, Jul 22, 2025 at 2:42=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> =
wrote:
> >
> > Hi,
> >
> >
> > 2025=EB=85=84 7=EC=9B=94 22=EC=9D=BC (=ED=99=94) 13:30, Sam Protsenko <=
semen.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On Mon, Jul 21, 2025 at 4:26=E2=80=AFAM Mattijs Korpershoek
> >> <mkorpershoek@kernel.org> wrote:
> >> >
> >> > On Sun, Jul 20, 2025 at 14:57, Sam Protsenko <
> semen.protsenko@linaro.org> wrote:
> >> >
> >> > > On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
> >> > > <mkorpershoek@kernel.org> wrote:
> >> > >>
> >> > >> Hi Sam,
> >> > >>
> >> > >> Thank you for the patch.
> >> > >>
> >> > >
> >> > > [snip]
> >> > >
> >> > >> > +
> >> > >> > +#define EXYNOS850_DRD_UTMI                   0x50
> >> > >> > +#define UTMI_FORCE_SLEEP                     BIT(0)
> >> > >> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
> >> > >> > +#define UTMI_DM_PULLDOWN                     BIT(2)
> >> > >> > +#define UTMI_DP_PULLDOWN                     BIT(3)
> >> > >> > +#define UTMI_FORCE_BVALID                    BIT(4)
> >> > >> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
> >> > >>
> >> > >> Comparing with the linux driver using
> >> > >> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD
> 3.2 4nm controller")
> >> > >>
> >> > >> I notice that the defines are in reverse order (from 0 to 5 and
> linux
> >> > >> has from 5 to 0).
> >> > >>
> >> > >> Is there any particular reason for this?
> >> > >> I don't mind it too much but it makes diffing between linux and
> U-Boot a
> >> > >> bit harder.
> >> > >>
> >> > >> Anyway, I've compared this with the linux driver and it looks goo=
d
> to
> >> > >> me!
> >> > >>
> >> > >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> >> > >>
> >> > >
> >> > > Thank for reviewing this, Mattijs! Yeah, I kinda flipped the
> register
> >> > > bits w.r.t. kernel's version, just because it looks better to me
> this
> >> > > way (easier to read when it's sorted properly). Due to the driver
> >> > > model API differences between kernel and U-Boot I had to rework th=
e
> >> > > whole structure of the driver, and I only added Exynos850 support
> for
> >> > > now, so the difference between U-Boot and kernel versions is quite
> big
> >> > > as it is anyway, so I figured it's not a big deal to reorder thing=
s
> >> > > even more. Hope it's ok with you?
> >> >
> >> > It's ok with me. I was just curious if there was any special reason
> for
> >> > re-ordering. I agree that it's easier to read with the sorting you
> have
> >> > applied.
> >> > I've noticed that only Exynos850 is supported for now. That's fine a=
s
> >> > well in my opinion!
> >> >
> >> > Feel free to pick this up through your tree.
> >>
> >> I don't have a maintainer tree unfortunately. The easiest way for this
> >> series would be probably to go through Samsung tree (Minkyu)?
> >
> >
> > Yep. This patch is delegating to me.
> > But unfortunately I have trouble to access to denx git on my office.
>
> Hi Minkyu,
>
> FYI: it might not be on your side. I can't access denx gitlab right
> now as well. There is some relevant discussion going on on #u-boot
> IRC. See also [1] thread.
>
> [1] https://lists.denx.de/pipermail/u-boot/2025-July/594671.html
>

Yes, now it works.
But, patchset was failed to apply on latest tree.
Could you please rebase?


>
> > I'm trying to fix it but not sure when it can be.
> > So I'll ask to Tom to pick this up at this time.
> >
> > Dear Tom,
> >
> > Could you pick this up?
> >
> > Reviewed-by: Minkyu Kang <mk7.kang@samsung.com>
> >
> >
> > Thanks,
> > Minkyu Kang.


Thanks.
Minkyu Kang.
