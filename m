Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0DEC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 08:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B729B8788D;
	Wed, 10 Jan 2024 09:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="mzh5JMfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A8D878B1; Wed, 10 Jan 2024 09:30:13 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB218876F6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 09:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c6ce4dffb5so1671650a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1704875408; x=1705480208; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUNCdQX5cMNo7YaDK5jee95ZtdPgJTftQv1f6kVln+4=;
 b=mzh5JMfv0vRpd7R3XB3/JZi7rCQEWri+TaFoOirzL9e4rRijyN5AWZBHoWm3m1v4zY
 Om+PCdFhGbYOhjVr5h0v4TvTCvuHfa5rGyN3rTfEgTTNXpdCiavHZfQLbvTMG/hwdRDQ
 MIOGzO2aQPBfdQcYGPo4fD5V+6GSxT/somEsVTzOHFk0XoMLb6Z3SOmkvJpY99A0b5c7
 uU28YN+uUgJW6dy6RE2fYCGmlFHmYAHwi3PyMOeBt80Z791LC1hOu0+NL8w7txDFvKtw
 nvXMYcp5VBj/hDritSoS1DjLBnerp/KxGOFHNLjmMh2dBugRQX9RT91G+xc9enGTA6lY
 f1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704875408; x=1705480208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUNCdQX5cMNo7YaDK5jee95ZtdPgJTftQv1f6kVln+4=;
 b=DVuRhHqUzLmHfq07n4mwTEEa7HbC4x2P26i6ETuLZx2hmqm7RPk4Qpe++UpW1rr/qs
 Uzv4j1v9GNlK3aXuZrtFDqD+xPQPnB/52rLYHkbfqzr+BP2Qd/Ig16Yn41vBk0R3dMj4
 ejA5XoDwWojNo6WVhVgbKS/adl0CH0geda0pwzlHjB6U7GkfNzxk8Gui/xfyVobFmFdP
 Yg6Q1p+dsNnQWWdL78MmGIzrAcgpPVIJNLuFTTnBfFe/ubxhECPjRL3Pj6l2GAJXVaVb
 bE6qW9YXUHUHLwcejqMlWnVnMtzHSR86vj4ZNTe6K9h1UeuPIUfMu8xcJX/JiwsyPhFK
 x7nA==
X-Gm-Message-State: AOJu0Yxc6G7lJ4l0yZ9ttptJH/IN83TYFaAY8HoxH3hkr6wfirAzfAeC
 BnYHRKRw8TSkQucqhvbU7+D7JgrUtZlxNonaKqCz+MkCfKyqmlekBEVdvzpO
X-Google-Smtp-Source: AGHT+IGQDzwtETHP4yj10pl9eUmtMYIOMAtDVjxyXEsyOPASL3x+csgDruGjmKRWFgcwnJReJzceyfj0uLQJZUeaKs4=
X-Received: by 2002:a05:6a20:3d18:b0:199:c2d6:8999 with SMTP id
 y24-20020a056a203d1800b00199c2d68999mr450004pzi.103.1704875407959; Wed, 10
 Jan 2024 00:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20231129101117.60177-1-robert.marko@sartura.hr>
 <CA+HBbNFbLjSwY9QRP09SXVDMm=TJ1q4isgkce6p-H7LAnwZZ2g@mail.gmail.com>
 <2f81957a-ab26-4220-9125-d0a788446e60@denx.de>
In-Reply-To: <2f81957a-ab26-4220-9125-d0a788446e60@denx.de>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 10 Jan 2024 09:29:56 +0100
Message-ID: <CA+HBbNHArsjXqxe6Znh=cZ0T=kxTN1v1iJM6GeD6Sa=6SZXafw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
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

On Tue, Jan 9, 2024 at 4:34=E2=80=AFPM Stefan Roese <sr@denx.de> wrote:
>
> Hi Robert,
>
> On 1/9/24 14:16, Robert Marko wrote:
> > On Wed, Nov 29, 2023 at 11:11=E2=80=AFAM Robert Marko <robert.marko@sar=
tura.hr> wrote:
> >>
> >> Currently, Esspresobin FDT is being fixed up directly in ft_board_setu=
p()
> >> which makes it hard to add support for any other board to be fixed up.
> >>
> >> So, lets just move the FDT fixup code to a separate function and call =
it
> >> if compatible matches, there should be no functional change.
> >>
> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >> Reviewed-by: Stefan Roese <sr@denx.de>
> >
> >
> > Hi Stefan,
> > Since 2024.01 was released, can this series be pulled in now?
>
> It's on my list. I actually already started with some CI build tests.
> Hope to get this done by end of this week, before I leave for a
> short vacation.

Sounds good.

Regards,
Robert
>
> Thanks,
> Stefan
>
> > Regards,
> > Robert
> >
> >>
> >> ---
> >>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
> >>   1 file changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/m=
vebu_armada-37xx/board.c
> >> index 04124d8014..1471caa9a6 100644
> >> --- a/board/Marvell/mvebu_armada-37xx/board.c
> >> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> >> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage=
_init);
> >>   #endif
> >>
> >>   #ifdef CONFIG_OF_BOARD_SETUP
> >> -int ft_board_setup(void *blob, struct bd_info *bd)
> >> +static int espressobin_fdt_setup(void *blob)
> >>   {
> >> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> >>          int ret;
> >>          int spi_off;
> >>          int parts_off;
> >>          int part_off;
> >>
> >>          /* Fill SPI MTD partitions for Linux kernel on Espressobin */
> >> -       if (!of_machine_is_compatible("globalscale,espressobin"))
> >> -               return 0;
> >> -
> >>          spi_off =3D fdt_node_offset_by_compatible(blob, -1, "jedec,sp=
i-nor");
> >>          if (spi_off < 0)
> >>                  return 0;
> >> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd=
)
> >>                  return 0;
> >>          }
> >>
> >> +       return 0;
> >> +}
> >> +
> >> +int ft_board_setup(void *blob, struct bd_info *bd)
> >> +{
> >> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> >> +       if (of_machine_is_compatible("globalscale,espressobin"))
> >> +               return espressobin_fdt_setup(blob);
> >>   #endif
> >>          return 0;
> >>   }
> >> --
> >> 2.43.0
> >>
> >
> >
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
