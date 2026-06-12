Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F111BCD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447A88063E;
	Fri, 12 Jun 2026 20:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gh1Fea9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9F9839A8; Fri, 12 Jun 2026 20:08:36 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34F58056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso2608797a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781287713; cv=none;
 d=google.com; s=arc-20240605;
 b=ZH4fBi7B7fGwVI1cdfENRVdwX6jybfEN6kRyeHYAuQn98+Rg/2i4oPrzMn4YAM2IDM
 wYyIGVDMd9tHb9C9kWO4t8j+29nKNtk826u1sif30/3oUPIxLn441O6FyjOiuLC6woj5
 aJB1IKa5n9iNCmKQhe9HVWPa+q/5yhS+Z8QWsGLrt3OMSfGudMJTghWwl5nFI8bKWTSD
 DMRIZnwRD1Z4Fq0DZ+wQRoWD8I3L+ICcoCXzUMhUL5GQamQ2ZCfRgfw8u+h8cvNGvPAB
 6woChlYsFUxy50rAxxsI5J1M06ReU2+eu8QSfU2TDsY7zfsP/130mtIs3kPGseVGixDz
 Acrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vaHu4/aM18zbdiRGXWnMhQ7N2lUJrT2ZnULBCZfB2s8=;
 fh=QHawX9D2AmlXhmHNb2asZqMGJKBvAb4337Qj/jrp9G4=;
 b=lAca9VquUKdwaly21aYVvcIKUSZyxLv+I2LPBLmzMxzUswnrG1l1I8uBkQxUk1So2o
 f5w7RCCgo0QpLe5CFUeXE8uVHdkDGS0kI23Lll+MT6gOqsUTwEIzVUAM2uBF/AFYyYh0
 jcRhWF7mLYPE5WCCC2Ud44c0hXYykMqm3vn8uXq+jrmJ0I/CVFUN0Q5xky8QqRabbxh0
 XRgt+s7gehDT46WnQ2mtsTImvzdUfGbNEAYQVmIiHTNYykTvhzHwqLrNRfQwKzuCzaI0
 ZcSU4d6PtJ+T6P7lY+mEFsHaHnIKs/p5fGEz9R4k1jXIt6C8ek/eOHEIeL9DqBrNjiHc
 PjWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781287713; x=1781892513; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaHu4/aM18zbdiRGXWnMhQ7N2lUJrT2ZnULBCZfB2s8=;
 b=Gh1Fea9oKoMQcAZKQxIJXwaQ0oSN6jW/q+wZKB4NBcKhX4812a5+0zzfp2N5gIjV33
 nFPIB/VYw0eftnfZTbXIC+QpM5ffH6qoVWECuhw7nZGaMy0G6DxYlMTUPr4QTb0IVa74
 0jsq//oeYy1/Re629QV9Vm7vybpXmiblxC32s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781287713; x=1781892513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vaHu4/aM18zbdiRGXWnMhQ7N2lUJrT2ZnULBCZfB2s8=;
 b=UEcaRP87pbkGqD0+D8eUWfPxyLhCK0sUU0C7UhzId7/zC4bv0W9TgDSbMUhXq/gQf5
 8IssaJptXkENrkTiBvNqeRTQQRANTiqyfR5wuapaK7tISY3I8oSOy6lwrnWoSPaqS8Xt
 kc+k6GU7VYOa6YvLS5Krb+i3vGRRyKrdi2uFXcZSoYm7dpzwIQStO4btU6OSsC4c6atd
 yNqtfVzeNW27OrTESav8P6lmzo03A+PKGUmmgAqJsncSQpTtEQrzzCxTzpGRmXOnOS+X
 RQ0MvlGASfhwujOQo9PuRDdxYaX7J1LEp0tC1bVn0ETb/eKFIADD0G4rNYIAxX/PiTFQ
 cJdQ==
X-Gm-Message-State: AOJu0YwA9oa+eUSODJ5Fork0GHmNNRlfkyzQ/6hahlukxvbpQoldHPkQ
 ULmVj8+srqY9kEVek91rT+df7a8u6aCIlLcNWfvOv6pm/XkzRjKQaLPL3tt8jOpFvREjdStdETw
 j4T8cWy3FT2wBmLlWvTceN6ehCkMFrSbe5lWCVPaSgctq0O+AQrf1Ww==
X-Gm-Gg: Acq92OHEv7Gqlz69iH/pDyx/hhr4jp9UJH0dwKfc/FnnWaaDj8l87r0zY3EPw9AMPiU
 zi9CoptudqQsy6+pDji4KmIJZeLTsgDOVkA05cjA8woDpE+codoXBKfoywiEBLtUuwo9qipvqd/
 2ntBhzhCUOYnl7r0RdnLtYvswR9uJl/LAAn7Opxr6GPiaZ1+ZauBYvx+ntSAIsiRVajO2hQsJz6
 XngxYhOzdovq+eFNBSGUN9oALjg0FxE8ArHOXIp+jzDB4mhJIPqpxwSUKyyN/lbh17cCrb6mPTs
 CYfxWQ==
X-Received: by 2002:a05:6402:1655:b0:66a:6f5f:d77e with SMTP id
 4fb4d7f45d1cf-69369d7b7d3mr1312139a12.14.1781287713092; Fri, 12 Jun 2026
 11:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <DJ04CQW0NOFG.1904K2K2X7IOI@linaro.org>
In-Reply-To: <DJ04CQW0NOFG.1904K2K2X7IOI@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:08:21 -0600
X-Gm-Features: AVVi8CfEmRmYZ6m_wzSWdViZGDVbFH9_ps_7TwP-sufff2EG1ghA-wja8pJJ4Ic
Message-ID: <CAFLszTijRcZoQztTjFw3S=tw2i__8ZqPy3Siv1uMb-ifs7R-DQ@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Thu, 4 Jun 2026 at 02:24, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed Jun 3, 2026 at 8:06 AM EEST, Simon Glass wrote:
> > Dear U-Boot Contributors,
>
> Hi Simon
>
> >
> > I would like to introduce the U-Boot Concept tree along with a few thou=
ghts
> > on its role in U-Boot.
> >
> > By way of background, I have been a contributor for about 15 years - ar=
ound
> > 10k commits and countless reviews. I have introduced many innovations i=
nto
> > the project: e.g. sandbox, device tree, C test infrastructure, Binman,
> > standard boot. Of course I could not have done any of this without the
> > U-Boot community (nor would there be any point).
> >
> > As the U-Boot project has matured, the demands for mainline stability a=
nd
> > rigorous review have created a natural friction for landing complex,
> > large-scale feature and refactoring series at the necessary pace. This
> > structural reality, which has slowed the adoption of ambitious efforts =
like
> > bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Conc=
ept
> > tree is designed to alleviate.
> >
>
> Well the problem here -- at least from my side, is that a lot of these fe=
atures
> are useful but feel half baked. E.g we found bugs in the bootstd uefi met=
hod and
> those were not corner cases bugs. We couldn't even boot boards with it un=
til [0].

From memory that was the work to allow booting an EFI app without
needing CONFIG_CMDLINE to be enabled. The Fixes tag on that commit
points to a commit by akashi.tkhro@gmail.com, not me (perhaps the
-next merge has bug though, but strange to add a Fixes tag for that?).
Certainly I was booting Ubuntu on a Chromebook using this long before
the end of 2023 (but yes, there were fixes to the original code, there
are always fixes).

>
> I also think to an extent that's expected. Introducing big features will =
carry bugs
> etc and that's fine. What's not fine is trying to merge all of them in a =
short
> period of time. We need to find a working model, where new features are t=
ested,
> at least on a number of boards and become the default. Those changes also=
 need
> to be sent incrementally and be reviewable. You can't send a 50 patch ser=
ies and
> expect them to get merged in a week. You need to find a way to send small=
er patches
> that people can reliably review and accept.
> FWIW there's similar code all over the place in the driver model.

Here i am talking about the Concept tree, rather than mainline. I hope
you will agree that for mainline I have been sending small series and
waiting for a while for them to be applied, before sending more. That
is certainly been what I've tried to do.

>
> The pattern here is that you add some code for an idea, but you spend lit=
tle
> effort plugging it in to the rest of the ecosystem and boards. You just m=
agically
> expect people to follow that and then you personally treat it as a U-Boot=
 standard.

Most of the new features are independent of the board (e.g. code in
boot/ is generic). I did try very hard to enable VBE in rk3399, even
sending a rebased series a few weeks back, but it hasn't happened.
Perhaps I could do better, but it isn't for lack of effort.

>
> > I strongly believe that projects must evolve in order to stay relevant =
in
> > the long term. This includes code-refactoring, new features and subsyst=
ems,
> > along with migration of old code to use them.  A look back at the U-Boo=
t of
> > 2010 shows how far the project has come. I don't think anyone would sti=
ll
> > be using U-Boot if it had not evolved.
>
> Agree
>
> >
> > I have set up a 'Concept' tree, a possible future for U-Boot, as a way =
to
> > regain the old pace of innovation. This environment is a proving ground=
 for
> > new features where we maintain a lower bar for risk tolerance and
> > completeness. We will accept partial and speculative features, provided=
 the
> > underlying code remains robust and of high quality, with the shared
> > understanding that features may be dropped if they do not prove benefic=
ial.
> >
> > Another difference is AI. I believe that AI is the next step on from
> > compilers, which also took a long time to produce good code and find
> > acceptance. The Concept tree welcomes (and encourages) high-quality AI
> > contributions and reviews. It accepts PRs and allows reviews on PRs or =
the
> > mailing list.
>
> Do you plan to merge patches that were written and reviewed only by AI ag=
ents?

No, there needs to be human review by the author before the patches
are sent, then by reviewers. AI is just an assistant, although we'll
see what happens next year.

>
> > It relies 99% on automated tests (sandbox, QEMU and labs) so
> > sets a high bar for testing. It uses a separate Gitlab instance for now=
 and
> > of course uses a separate mailing list and Patchwork project to avoid
> > cluttering the main list. Concept runs an AI-powered cherry-picker so t=
hat
> > it keeps up with mainline. In no sense is it operated as a fork.
> >
> > Once features are landed and functional in Concept I hope that many wil=
l
> > find their way to mainline, although inevitably some rework will be nee=
ded.
> >
> > I recognise that introducing a new 'Concept' tree might initially cause
> > confusion or concern. This is an invitation to work together to define =
its
> > role. I welcome all feedback - positive or negative - here on the maili=
ng
> > list, privately, or on irc. Let=E2=80=99s discuss how this initiative c=
an help
> > U-Boot remain the defining firmware for the 2030s.
> >
> > [1]
> > https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2oaHf=
gLf3_nC+xXA9g@mail.gmail.com/
> >
>
> [0] commit 4b151562bb8e541 ("bootmeth: pass size to efi_binary_run()")
>
> Thanks
> /Ilias
>
> > Concept tree:
> >                        :
> >                        ::
> >                      ...:::.
> >                  ::  :. -
> >            .   ::::::-  - ::. ..
> >           .:: .:      -=3D=3D  =3D.:.
> >         ::.- ::::. ::. :=3D:. ::::
> >   ::. ::   =3D..  :.-::: =3D:
> >     .:-:-. -.::  ::=3D-:=3D:
> >   ::::::=3D.  -.::   =3D=3D=3D:       ::.
> >     ::.:::=3D::=3D:   -=3D=3D=3D:--=3D=3D-::--::
> >       :.    :-=3D-.:=3D=3D:.   .:  ::
> >                =3D=3D=3D:       ::  :
> >                =3D=3D:
> >                =3D=3D
> >               :=3D=3D
> >               -=3D=3D:
> >               -+=3D:
> >               =3D++=3D.
> >              .-=3D=3D=3D:
>

Regards,
Simon
