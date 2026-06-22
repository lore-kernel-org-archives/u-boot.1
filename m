Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD7ECD98F6
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 06:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5658467F;
	Mon, 22 Jun 2026 08:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yltul9t3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED5E84832; Mon, 22 Jun 2026 08:48:36 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9776801A9
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 08:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-695f539fc8cso5280855a12.0
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 23:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782110913; cv=none;
 d=google.com; s=arc-20240605;
 b=cwY7mdePHQKEZwIPF5YwgXeiP0VdHnKFAA7oZiwSwFcUpYFCEH685DGuGl5ztpxj/M
 RnAPVD7Si+zorCA0PH78wz7hxbvnR5zZ7yy2r9YhBH1AIexYdkzqcmFyTwpfNLXBsENb
 abzwd0Nwe9I6MuVOGCDKeO6WoroxVuVVxXPnz+f7Dfo2fOBpglrt6sFgrCsNcwzwWv9v
 84uxu5HrT5rkwy0T954+YLU9MU4gIf5Afyf/JpEjP7ZZZzzYdM1igPc4y65Fx3ZmpQMh
 dFNcW+5djK/822c466iltWByEFQl2MVFHT9CZg/iJQDWi2t51Tw0OVx5yOWpGZLLmt7p
 87lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p4MTzdsdUw2Ctlc5Y1/2Aj55e3mrtNfDVZLo+gsH1yM=;
 fh=z8Fv8qoovpnooC66MRyMNzFYNXD5mKrJnpAhm5VjGg0=;
 b=TvFfI/NIC6XPgvSZB7A8Dqr1rR/kSN+l6O8zCeO8Fn1PNB8i+GbcoPr/75ueM7UmMx
 OJWnOW67MHlrfxeTK4nE6mQPkLD0ZyBTneWPbfh98v3l7o2vPnGlpzKUkcnjmM5fzHw8
 C+W4/vd3pTUO2Mc+8oTdk/iNO4pgXofEIOcwzsuGbFgJkS6JGybqkyByA9ilv3VHSBdl
 bwLdvP2J4wWQgLtZqdGaGrgMwDPLNVR8EVRuVAq/Hg5U3yaH4IBLLasIr6NWk3yUO+ru
 XAFYnAqE0pv0RPx2Ezg0Gyrg5E9mClpN674MFG22NSoA7WLf3dseVcLis+00/4Bz3YAd
 BltA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782110913; x=1782715713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4MTzdsdUw2Ctlc5Y1/2Aj55e3mrtNfDVZLo+gsH1yM=;
 b=Yltul9t3BDVxKzpiuD6eanse7Tsy2hgJ0i+8UTdHtPrE1GoIIxCQe0OaQktBPRA9p0
 PnUNTI6VElUdIeicfcYBR8NIyhdQ6Gha9XrKFqsmFGM7sJ+OUegqvFoaMXyC1RgYTsk9
 rjD2T9u0E13QIEsWKbU+11SgEcpNfBSxKZoAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782110913; x=1782715713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4MTzdsdUw2Ctlc5Y1/2Aj55e3mrtNfDVZLo+gsH1yM=;
 b=RuD0hRT+ZddjI4eva3xWlAVED337YvtfkFFJ1+ghIb020dvlafW1X72eHiM85kT8Zf
 04jRj90EIwQrfxfJXwGx5hC1DyrlgrpK73beCU49bUiys67nAArfy1KrqauYxjvo8iuh
 VfA81sZdntRzrlgmNUWFgzpCgm26ZOuV5jshdfxA++b9GcHOoeHZx5tMnKD83B1JaOFK
 Xrojo1zl8z/TdcT+23+twLMjnF6ra6K9MULwsdOMlYiRfOH4ZjX/HPQ0PCXwbQAKZxBC
 X9f3DiduENlXgQu9i/iMBorN0FpNAdZUbMO/33TQPid2U3sRTsbjqsfq9qIBy88KmsBk
 486g==
X-Gm-Message-State: AOJu0YwxUaJgXi/qH4WtSJV/ej/sE12475ja7Qxw7miNWD2guksAo1B8
 KkChk0oEmZH3Ybj04pIPah28Y9UX2N/pPNh65ftlub2/TG0MbASeb5jpT7C6o+/6oaxzTSj8z1l
 iV8l3TpjlGr6zPioeHMbOWLupMIrGrO5jurYVNTrN9jxh5HyDw6YCZg==
X-Gm-Gg: AfdE7ckLfOc31Mf5vQ0qz8n4GwCsVZkUnUQJdmM1TawW3iySjPOYyD+HmsUf9D7GXHj
 nWG0JlFWrT5IVdEp7+GDJKikK8CYHxdX6zNmM8uE58r57+acz8mnXq/P6SQWHSuO7H9GU4nTCro
 7rcnhfnXhQBaDi7qFoftMw5neLwtvmhed6LyEoB5WGJLsRXIDqzP8AnM/eYuBPuNVXqrfGn/doZ
 D/CSlEgRefumMiIEKA2ehLBjSZcMrX5zzoMkgbGTu1r+qP64Nw6qFtche5ndptvOPB8PdhUew==
X-Received: by 2002:a17:906:5189:10b0:bee:d654:a00e with SMTP id
 a640c23a62f3a-c09b96816c9mr384248866b.28.1782110912257; Sun, 21 Jun 2026
 23:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
In-Reply-To: <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 22 Jun 2026 07:48:21 +0100
X-Gm-Features: AVVi8CeKMUJr_fPPKNKRFQjXOx9BAPsKoiKT_zeuvtCpYihtsiriYOfjFnujCMo
Message-ID: <CAFLszTgjX7nv-MBX0ayEcoowBRUCSCS7XE3jHSjL=o0GH2POag@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
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

Adding to cc

On Thu, 18 Jun 2026, 16:08 Simon Glass, <sjg@chromium.org> wrote:

> Hi,
>
> On Wed, 3 Jun 2026 at 06:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > Dear U-Boot Contributors,
> >
> > I would like to introduce the U-Boot Concept tree along with a few
> thoughts on its role in U-Boot.
> >
> > By way of background, I have been a contributor for about 15 years -
> around 10k commits and countless reviews. I have introduced many
> innovations into the project: e.g. sandbox, device tree, C test
> infrastructure, Binman, standard boot. Of course I could not have done an=
y
> of this without the U-Boot community (nor would there be any point).
> >
> > As the U-Boot project has matured, the demands for mainline stability
> and rigorous review have created a natural friction for landing complex,
> large-scale feature and refactoring series at the necessary pace. This
> structural reality, which has slowed the adoption of ambitious efforts li=
ke
> bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Concep=
t
> tree is designed to alleviate.
> >
> > I strongly believe that projects must evolve in order to stay relevant
> in the long term. This includes code-refactoring, new features and
> subsystems, along with migration of old code to use them.  A look back at
> the U-Boot of 2010 shows how far the project has come. I don't think anyo=
ne
> would still be using U-Boot if it had not evolved.
> >
> > I have set up a 'Concept' tree, a possible future for U-Boot, as a way
> to regain the old pace of innovation. This environment is a proving groun=
d
> for new features where we maintain a lower bar for risk tolerance and
> completeness. We will accept partial and speculative features, provided t=
he
> underlying code remains robust and of high quality, with the shared
> understanding that features may be dropped if they do not prove beneficia=
l.
> >
> > Another difference is AI. I believe that AI is the next step on from
> compilers, which also took a long time to produce good code and find
> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> contributions and reviews. It accepts PRs and allows reviews on PRs or th=
e
> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) s=
o
> sets a high bar for testing. It uses a separate Gitlab instance for now a=
nd
> of course uses a separate mailing list and Patchwork project to avoid
> cluttering the main list. Concept runs an AI-powered cherry-picker so tha=
t
> it keeps up with mainline. In no sense is it operated as a fork.
> >
> > Once features are landed and functional in Concept I hope that many wil=
l
> find their way to mainline, although inevitably some rework will be neede=
d.
> >
> > I recognise that introducing a new 'Concept' tree might initially cause
> confusion or concern. This is an invitation to work together to define it=
s
> role. I welcome all feedback - positive or negative - here on the mailing
> list, privately, or on irc. Let=E2=80=99s discuss how this initiative can=
 help
> U-Boot remain the defining firmware for the 2030s.
> >
> > [1]
> https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2oaHfgL=
f3_nC+xXA9g@mail.gmail.com/
>
> Just to report that after some brief discussions, we have agreed on a
> path forward here (thank you Peter!).
>
> Concept will become a custodian tree in U-Boot's Gitlab instance. I
> will run it, with access to my hardware lab. It will cherry-pick from
> mainline and accept code through its own channels (PRs and separate
> mailing list + patchwork). When features are ready for mainline, I
> will send patches to the main list for review in the normal way.
>
> I have been working to migrate things off u-boot.org (lab, gitlab,
> blog... and email). I am transferring u-boot.org to the SFC once this
> is finished in the next few days. If we do end up setting up email
> addresses for people on u-boot.org, I'd appreciate keeping sjg@
>
> Tom, Neil Peter, please can you ack this to confirm you are happy with it=
?
>
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
>
