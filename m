Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664B8CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 14:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2ECF84931;
	Mon, 22 Jun 2026 16:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QohAUgXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438B2849BA; Mon, 22 Jun 2026 16:32:38 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CEC848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 16:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-396779b9a7fso40478621fa.3
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 07:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782138755; cv=none;
 d=google.com; s=arc-20240605;
 b=RTlDm5XZgrthRaf6X5V4v6mwS5cEG6Pawh4uwIeW/xohDLxDSn8D0gCz6bNQfY//Mi
 +ktVBpBSLuhomIcYypUO8gsi53kP1rdh4LNchr8AgPL6gstK6ZlsHZjkPk1rbx6DDOUN
 5LPSWeItmi/OnPcRJV+O0DxoBm5CtjrCOAHMEvdc662vv1BgoRs3iFsl/3EeewZWn4c7
 6MPBBQZ+gjidNFKGhpK3uFtge1T/uE6d0mqWxxZ60yeheOWyq6mNH4k+t1zPXv3Eo08x
 eB5slrP5iZtDfE7I7h/A6aNCR7WN7qcUhIQBypFs7GEMmU3T1KKIEpRPMx62vE82nDss
 Vtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qHm64OiTUCo8IzKvZPH2CEUejAvs5Yl562h5EY6iBII=;
 fh=xB9JIAryxjwldGJ3NBJ4qnAb38ct+d9xEuHultImQco=;
 b=RSX0lDygRonUiaBwKgu6zXiY+YMFM+EzlmFc9udSW3ZgmfSgS1ejyaXRJZwwWYlTOy
 60db/DI1ZXnIO4n9afrtptZO81MCEkxsZf13L1q+V93Ye7ja+4ic6GJMFHuqZhKN/uLE
 bJsrASklFGrgMPJQ+MuE1Ap+sVWnTUFKcmRzZtxj0i83+kPGOrtWiRv5rxkBVX5lTts7
 MyltLKkL8MqN2sDI1naRtvDRTv5417Ew4dA7zEmiK1d9I4jkA4TTfyoPvvCRLmJHYSsp
 DSoWQWwSxuJjDWryxzz+kQPjtu10MnwSLpIhC8ut1WhoDCvczvqrhAmCL5a/ICBHWuem
 zTYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782138755; x=1782743555; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHm64OiTUCo8IzKvZPH2CEUejAvs5Yl562h5EY6iBII=;
 b=QohAUgXyRWLrdVattAnPmsmmllVNC1Kg+GMeSqq860lJHN3d4LSQKOct02luc7Y/cH
 7KCsnlYpVFmrkPnHwP6AYD/EP2te4NkHQO42kwg5J8Zij81JCkNMUAVITojvVPifLgh2
 Cj4qvUxcMF8cFoZAso5Iu4knC2OaPJyIP0v5Omhv/kdmWvMEzz7FBZa4g+slbLBk3IgQ
 AdDODBcvyNy+BDETmYxnzGp1c9E1GNBNCTzNzxKspo5N6MArlZHw7OoJiFI6Mv9Sgy+U
 5RH9yGR3EBGkI1/4KRIjo+R71o3DZr89lvLHxj5N51rMuhTJPvBGZaqOWoPQ4fBc56aP
 cnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782138755; x=1782743555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qHm64OiTUCo8IzKvZPH2CEUejAvs5Yl562h5EY6iBII=;
 b=pePsU4332i8CnjJjJBjUo5kLTZ7ZIK6UGtqm1GCNQwMl4G/+pfPMsNZZJi6dK7EGLO
 lnuei4zy329qLHaezz6+jO8kXy+sLCQ4inUluxILUp2WNdnhU1JrGzNQCW3dc2yD8F8L
 SrVvysRIhds8IaiclWPKwBq7O7WqnEBaSQ3abJRGbvMcO2ZU6FBk4jbG0zL8g6AsemJA
 2U25x3Q3ZidmCzfahtR2J6R3AwsD3q+ehMaETL4iWXVeiLSSUYqcPayTgztQlg4vooro
 smXzKryKHJxfl9LSpY1+BqscgwMCR+nQWbsLXWmp8swpwK6kuV7fzLOwM91jpmISUKEz
 CcHw==
X-Gm-Message-State: AOJu0Yx6o3zKUlqTv0pS1pIDMU7dlJREsj0/TERBSDMOe42ykS5NPyGb
 EXUIK8EgZGu3osHryaCXTPXsnUwKPG45F7TwJnJTsWe31hQFoqqG1chOOQPzYlKfQ+wQc8MsAOL
 7VXF/kyQB7KNzc7iKpPZwSfSsdwRn3Vg=
X-Gm-Gg: AfdE7clMWGZ3XHZdHL8lucRnoxzCLialytSMXpsLAceXln3PBpR6IZTqpRuTfsM9D2J
 9xgL27N7K0gwpA5+Mblt9tnHJd+sa5vfD8f9y07pPhzqIO0A6jJWPCBadij0N0aOeEfaWLlLxxS
 LLzZUAUVKl0ZWP3E4lTwCSzyw7C0aFiy79W0D6fNiCGpRQsvVdR80YeoK65ZHOF4Ix4aOV5UIcl
 BFr8QNo6Km5UWkq1sIwh6mX5f6oFJONxVx5fxXJ8AOhcx5a+XCJ2CMBiNual170w4d/Cwjxw9j0
 kKXs3j7Q8OeWSXm2q+RCZtg3BDS8HkQhWqXyidO3UmZliR/QiHTj26QFz3sAgJsmZCCNxYDxu3T
 M0+/Gqwb50cUdL+wrVaJByjVnPVS2qCchPp4UmiGm6uxAvnDeRXQWlg64MHb/M3ueMi4=
X-Received: by 2002:a05:651c:553:b0:399:854f:9933 with SMTP id
 38308e7fff4ca-39989ff357emr38535771fa.0.1782138754631; Mon, 22 Jun 2026
 07:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
In-Reply-To: <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 22 Jun 2026 15:32:21 +0100
X-Gm-Features: AVVi8CeX3w6aQRYiCaTLEGwtv28oUfacPvTIbtCx7zDljFo6pNG7rkRSED_MAIA
Message-ID: <CALeDE9P8GozaHwkV54LXkES6sWXyNUibs5tmvuV1VgMtxEpLiA@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>
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

On Thu, 18 Jun 2026 at 16:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Wed, 3 Jun 2026 at 06:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > Dear U-Boot Contributors,
> >
> > I would like to introduce the U-Boot Concept tree along with a few thou=
ghts on its role in U-Boot.
> >
> > By way of background, I have been a contributor for about 15 years - ar=
ound 10k commits and countless reviews. I have introduced many innovations =
into the project: e.g. sandbox, device tree, C test infrastructure, Binman,=
 standard boot. Of course I could not have done any of this without the U-B=
oot community (nor would there be any point).
> >
> > As the U-Boot project has matured, the demands for mainline stability a=
nd rigorous review have created a natural friction for landing complex, lar=
ge-scale feature and refactoring series at the necessary pace. This structu=
ral reality, which has slowed the adoption of ambitious efforts like bootst=
d, VBE, xPL [1], and CI-connected hardware labs, is what the Concept tree i=
s designed to alleviate.
> >
> > I strongly believe that projects must evolve in order to stay relevant =
in the long term. This includes code-refactoring, new features and subsyste=
ms, along with migration of old code to use them.  A look back at the U-Boo=
t of 2010 shows how far the project has come. I don't think anyone would st=
ill be using U-Boot if it had not evolved.
> >
> > I have set up a 'Concept' tree, a possible future for U-Boot, as a way =
to regain the old pace of innovation. This environment is a proving ground =
for new features where we maintain a lower bar for risk tolerance and compl=
eteness. We will accept partial and speculative features, provided the unde=
rlying code remains robust and of high quality, with the shared understandi=
ng that features may be dropped if they do not prove beneficial.
> >
> > Another difference is AI. I believe that AI is the next step on from co=
mpilers, which also took a long time to produce good code and find acceptan=
ce. The Concept tree welcomes (and encourages) high-quality AI contribution=
s and reviews. It accepts PRs and allows reviews on PRs or the mailing list=
. It relies 99% on automated tests (sandbox, QEMU and labs) so sets a high =
bar for testing. It uses a separate Gitlab instance for now and of course u=
ses a separate mailing list and Patchwork project to avoid cluttering the m=
ain list. Concept runs an AI-powered cherry-picker so that it keeps up with=
 mainline. In no sense is it operated as a fork.
> >
> > Once features are landed and functional in Concept I hope that many wil=
l find their way to mainline, although inevitably some rework will be neede=
d.
> >
> > I recognise that introducing a new 'Concept' tree might initially cause=
 confusion or concern. This is an invitation to work together to define its=
 role. I welcome all feedback - positive or negative - here on the mailing =
list, privately, or on irc. Let=E2=80=99s discuss how this initiative can h=
elp U-Boot remain the defining firmware for the 2030s.
> >
> > [1]  https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT=
2oaHfgLf3_nC+xXA9g@mail.gmail.com/
>
> Just to report that after some brief discussions, we have agreed on a
> path forward here (thank you Peter!).
>
> Concept will become a custodian tree in U-Boot's Gitlab instance. I
> will run it, with access to my hardware lab. It will cherry-pick from
> mainline and accept code through its own channels (PRs and separate
> mailing list + patchwork). When features are ready for mainline, I
> will send patches to the main list for review in the normal way.

Thanks not entirely what I envisioned with the custodian tree, cherry
pickign from mainline and accepting PRs is very much a fork in my
opinion.

My intention was that it's a place for you to collaborate with others
on feature branches to get them to a point they are ready to go out
for review to go into mainline, not pull features from others etc
which sounds like to me a fork of stuff that may not reach mainline.

> I have been working to migrate things off u-boot.org (lab, gitlab,
> blog... and email). I am transferring u-boot.org to the SFC once this
> is finished in the next few days. If we do end up setting up email
> addresses for people on u-boot.org, I'd appreciate keeping sjg@

As I've stated elsewhere the only emails will be for the admin
required for the running of the project as a whole.

> Tom, Neil Peter, please can you ack this to confirm you are happy with it=
?

With the caveats outlined above, basically yes.

> >
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
> Regards,
> Simon
