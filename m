Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C87ECD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E893A8063E;
	Fri, 12 Jun 2026 20:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBt1zzA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEB3846D3; Fri, 12 Jun 2026 20:10:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1618056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso1819410a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781287831; cv=none;
 d=google.com; s=arc-20240605;
 b=E7Bll9i2/zNdYXQpZ0dbeHIgz8pK4A0hLi2Ex3ESGPhMMZXUSBiG1EwFw9tK5JMkOd
 tkdEc3KG/X10cEzfCz6MfQqi6dox/9/iOd6cIx9wBr/9jQQv6VaMUqYSt3gA+09ewCsl
 grMO66CBVOX3eQ0G9f5D8M7odunt8Pxg2W6XHjx66FmDits7xo9gJKY3LBq6vjU3ewJu
 maQvlROl/hgL2Ze9SlDrhRWu4/FHQ1psY0+pKkCHCPhirhto0EPa/+41nB1Ixcdh383H
 JmzTxGDZ7VTRAzzoyUFe39JnHZVUcNYQbid+EctWBxae2w33R3AiBnWzQy4M9oXRU3EK
 BS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8bFU6I8s4fZvi+7rWE0iBgsh0xMqxELex2SzJT2P7B8=;
 fh=4XVT3gnKadYWGxT62OzvvxGJsLtNP/mATIK8L6ic5As=;
 b=b3Y8/3XNW+znYyNrfWcW6ON+slMBzcvEucgsBKgbdeiFEEoTzPyl7TENdYBFmSujuN
 WZ9fdNTTtuA11uXMkM6DFRTHq1NRCNjTIwVeBJjEDUnIGlRyPqL8W2pvoUbPMh9dYyH0
 VP+N7N63Utm7e3AOOgFMLIPHJm6horHj7ibMh/rif/CGVexTOD2HIeDWsYeadxVSjspu
 4NU9z2pnyum9m4r8U9jFLr0Yfam1G6ekCqFPZK6OWptk7KtXWwyMO9enY+h4vagZ30VE
 1JhcB7gQeO6Nq2rbxALp/5RhU+fdoJcdylkWeiq+H87vdrNgLrdjKtN0N1ohoRiL4e28
 tILw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781287831; x=1781892631; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bFU6I8s4fZvi+7rWE0iBgsh0xMqxELex2SzJT2P7B8=;
 b=CBt1zzA9Kld0s89ncFFZ08Kd2RodSHZVDaFq7HTosUY2hFMxYELJv2Xdpq8S3Ew7vd
 +afkjCaABMs7gptuzLg3QyL4poC109imXzwQINvXMnsNPtIMPy7JE0X17o4Cg+gl7k2L
 Oz5BWUrAT0qX6W5WwUM3UOoC77nPSKEYdlW+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781287831; x=1781892631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8bFU6I8s4fZvi+7rWE0iBgsh0xMqxELex2SzJT2P7B8=;
 b=Nki0Vr4pTyrjcjwCbmuZLo5hLO8A5DDHGI76Aa84gj1+MN+T4tsmFu07DGg2JRpIGq
 wSfVYnA9awEfiTaURcQVvC06QNO3eM+FawGPpX/6xIiSA8ALzfs6iE3gzcNx6s68RHBQ
 ol+HqT9UTEsmc9m0a50bwEmbbJpt3Nm90gcS/XQw7FN4mgUgRTLcIwNwHac360zLs1DX
 Tr06DuZ38x11/z+5H48vL/p9ox3+BicRLWBt6NNn2O8XDLSWDBhiy2lU+R2qsv5Ou3dI
 9geItddwfZItp4J4TJoV2y2EUcRlScUbyn8O5CI+okBONy7hG86ypy+bOMuQEqVm7SqM
 qwEw==
X-Gm-Message-State: AOJu0YwvNxGG8kOO5eFg7laRoenTHR2H6KLbJVa/3lG21JQ9iI9GPvKh
 NWZDRkq6gfcBPgUa7Yqce5BU7O4v/YlXMrnBQ/NzjDvgY32hYcugAn1e+uNR3KPWg06ZTvy2sQX
 yiF8U8Vl2EBLzlnBsYe1qcwH/7jPpwft/RSa2YaByv47WPJFZoHXmcw==
X-Gm-Gg: Acq92OEYV2BxMTRtpBrFLg9J6o31m11kL71vHRsqP2z1Dwtp39fAcJ3US0Gogm/Zgon
 lZRV6cDrmL0QcbOGwecGb5P+ep3WJFRt8JClnl7VGLio53v8gCqIyFcLoUQLIo3hwC0eqBf+AUu
 ZpwexbTykTygT/2qP6wC6Btskvm8ww54XeArhYoUiafwrPFgnaI4/NjQrhLnjthloxMdEGWr5gR
 oAbLs5bTnCuqb10EGq63Ut4cy5q8P3FO73FjfiamOrmz9OUz5oR7WJZb/59wOdCkSKWAj1jj6Ub
 ZtiRVA==
X-Received: by 2002:a05:6402:4408:b0:672:f3e:1475 with SMTP id
 4fb4d7f45d1cf-693c6a638c8mr129993a12.12.1781287831130; Fri, 12 Jun 2026
 11:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
In-Reply-To: <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:10:17 -0600
X-Gm-Features: AVVi8Cf2vKb512ADOGnKdZieUAN5C1a2sIVnqP-s1uhgHN2RZkN8wwrOHgYGIqU
Message-ID: <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Neil,

On Thu, 4 Jun 2026 at 07:17, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:
>
> Hi Simon,
>
> On 6/3/26 07:06, Simon Glass wrote:
> > Dear U-Boot Contributors,
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
>
> The main issue to land complex large-scale feature and refactoring series=
 is
> mainly the lack of human highly qualified reviewers, proper shared projec=
t
> infrastructure and funding for paid work. Not developers.

That's not quite what I am seeing. I am actually seeing quite a bit of
rejection and deferring. Perhaps that is just because of what you are
saying, but in any case, it is creating challenges.

Re infrastructure, I am already providing a lot. I have offered to Tom
to help with other pieces, if needed.

>
> >
> > I strongly believe that projects must evolve in order to stay relevant =
in
> > the long term. This includes code-refactoring, new features and subsyst=
ems,
> > along with migration of old code to use them.  A look back at the U-Boo=
t of
> > 2010 shows how far the project has come. I don't think anyone would sti=
ll
> > be using U-Boot if it had not evolved.
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
>
> I'm clearly against having a separate official "U-Boot" fork tree, this w=
ill
> only lead to confusion to users and contributors if it shares the same
> mailing-list and name.

Yes it cannot share the same mailing list - we tried that last year.
Do you think "U-Boot Concept Tree' is different enough for "U-Boot",
to avoid confusion?

>
> >
> > Another difference is AI. I believe that AI is the next step on from
> > compilers, which also took a long time to produce good code and find
> > acceptance. The Concept tree welcomes (and encourages) high-quality AI
> > contributions and reviews. It accepts PRs and allows reviews on PRs or =
the
> > mailing list. It relies 99% on automated tests (sandbox, QEMU and labs)=
 so
> > sets a high bar for testing. It uses a separate Gitlab instance for now=
 and
> > of course uses a separate mailing list and Patchwork project to avoid
> > cluttering the main list. Concept runs an AI-powered cherry-picker so t=
hat
> > it keeps up with mainline. In no sense is it operated as a fork.
>
> I'm clearly against using AI for any of development or review work as it
> can't be fully trusted and will monopolize precious reviewers time review=
ing
> AI code instead of reviewing legitimate contributions from individual and=
 companies.
>
> Using AI for CI testing and regression testing could help if it doesn't a=
dd
> a burden for maintainers by reporting false positives.

RIght, Tom has been very clear about this too, even suggesting that AI
is actually unethical. This is indeed one of my motivations for the
Concept tree.

>
> >
> > Once features are landed and functional in Concept I hope that many wil=
l
> > find their way to mainline, although inevitably some rework will be nee=
ded.
>
> Still I don't understand your point, Linux or Zephyr can land very comple=
x
> features with a single tree, what make U-Boot different here ?

I made some guesses above ("the demands for mainline stability and
rigorous review"), but I'm open to your thoughts on the root cause.

No project is immune though. I worked a lot in Zephyr - one-hour
meetings every week across several areas, lots of engagement, but even
then one feature we did took over two years to land (luckily the
company could afford the cost :-) You may be aware that FIT (a fairly
minor feature) was kept out of the kernel for 15+ years. Another
example is perhaps the bootph tags. I introduced these into U-Boot in
2015 and found their way into linux around 7 years later.

>
> >
> > I recognise that introducing a new 'Concept' tree might initially cause
> > confusion or concern. This is an invitation to work together to define =
its
> > role. I welcome all feedback - positive or negative - here on the maili=
ng
> > list, privately, or on irc. Let=E2=80=99s discuss how this initiative c=
an help
> > U-Boot remain the defining firmware for the 2030s.
>
> Our immediate priority is helping U-Boot establish the proper technical a=
nd
> legal infrastructure to receive funding. Adding AI features, maintaining
> separate forks, and managing competing domains only distracts us from the
> critical task of switching off the dying Denx infrastructure.

I am not aware of what is going on there, but am happy to learn about
it if you can share details. From my experience, apart from patchwork
being down quite a bit, the infra is mostly holding up. In any case
you seem to be making my point about the limited bandwidth people have
to land features.

>
> This is my personal opinion,
> Neil

Yes, understood.

Regards,
- Simon


>
> >
> > [1]
> > https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2oaHf=
gLf3_nC+xXA9g@mail.gmail.com/
> >
> > Concept tree:
> >                         :
> >                         ::
> >                       ...:::.
> >                   ::  :. -
> >             .   ::::::-  - ::. ..
> >            .:: .:      -=3D=3D  =3D.:.
> >          ::.- ::::. ::. :=3D:. ::::
> >    ::. ::   =3D..  :.-::: =3D:
> >      .:-:-. -.::  ::=3D-:=3D:
> >    ::::::=3D.  -.::   =3D=3D=3D:       ::.
> >      ::.:::=3D::=3D:   -=3D=3D=3D:--=3D=3D-::--::
> >        :.    :-=3D-.:=3D=3D:.   .:  ::
> >                 =3D=3D=3D:       ::  :
> >                 =3D=3D:
> >                 =3D=3D
> >                :=3D=3D
> >                -=3D=3D:
> >                -+=3D:
> >                =3D++=3D.
> >               .-=3D=3D=3D:
>
