Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA394FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B9884308;
	Sat, 25 Apr 2026 22:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Swm+URC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD6A8437C; Sat, 25 Apr 2026 22:14:51 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA7D784178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-67e0d3f288aso5539294eaf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777148088; cv=none;
 d=google.com; s=arc-20240605;
 b=SfF7KI0Waa3sB5M9y4wkDT0QaQPSKlNTLCEULp44jY9MtIPoe0PupYb+EQRm8t0Bb9
 P41xvpXYnLD8BFOgT0kiF7uXEdtTD9kOfmlS3WGWilhefuK6uDuk/tKDY+RYHcmR3iwX
 rsUfd7MZVGR1/I8j5CFxy2tQ6u+Y9it8O2Nkt0KIA1wOT7awdBckbx0kPS5MDrRe0b8g
 XpqtCIlYdkf1lhJRv0kb1vPISoqfzdce43EeNk41shjfHsWRcI79l7EOaEfgUYDmcY4F
 MZYl3C7i9tAXbLXllqbixq3DCZau3EGeHOOp6m8REueZj7AFOQmZigFErzTGaLlDXBSs
 o85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FRN/HTs1GWpMnPsI/nbsgyuPMeMMax58Frmu13DK0Kw=;
 fh=XmvCthC/BjXYU0ZrHKfxQew09xn0WtefmKj6MWJpbfI=;
 b=ZoC7nGMmbjQsn07HVRGcS0Gr2Y84TQ36EJTe3mDKGWcK6+mvF8zrltNoKSJtnrGpuq
 LEO4aN63qvZNWIiUF0mIvAK835jzjKyRQLUQaG40LbOOhVy8ahZO76upsSYs6vAh/CKO
 G2eZLkYxt+iEMDMLWKomN5sTdJiOgKUE+NYK6a5+G5WGA+PfiClNsm2wFVKrnYxXRZEJ
 MOkGBQs1K5MrCKwDIM/Jp6eb8pUNVU+PjtSMwgdA/P6Qu3j408mRaL2bDfNcEa7oJc3Q
 Q2tW0ZoxZ5pOALohmh0eA1NaF+q/w5oLf6jEaDfjVCrOCm6GIuUfmHSRsWHNEmpWfpUZ
 8v8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777148088; x=1777752888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRN/HTs1GWpMnPsI/nbsgyuPMeMMax58Frmu13DK0Kw=;
 b=Swm+URC31SDguGP5eqyHCaSfKY/jr61ud8nyTGaeNi/BERPTliyfpc62w0GDM4CPod
 /dKIPmCYdHpJZSGyzDPEsx/5FIkspJaFfSkqeRG7xxLAaHgxe0qGRSO/zY5Aaia7ygN6
 fAma4OAUJKavdR0LuAtpvzqE+wtyl1R5qOx4lvx0zcw/0GjTvV0f8PFViGyZqwGzHDX6
 quqgCjSzqcclMGc75nqWsg+/hOfSESBBAcZU7Yrlpc1Z3KIK/83noBKDyMjvgXBUGUlk
 WUW2TRgfQp4Bx7o6KRgYTuFZTTecacZzqR3aWcHpdWzpwZQv3LEHzPrsqf0HX9gCGxkT
 djjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777148088; x=1777752888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FRN/HTs1GWpMnPsI/nbsgyuPMeMMax58Frmu13DK0Kw=;
 b=sFEWXkB/N/ybq6xqCtAmcrshcy4z6bq01VKr9NBmqri9bayvR3MvDXE14Mdwxpm1Xr
 iETST2xBqCbk8Z+XaiQRGQugSc9KD6LxoV8pQhlJhZW0E4FwMtzrxFYAWPwoJP/TqTCC
 xqQVVilMWcg2d7suP7DqvPVM+q5CXItFKSho5CJVEadjognLpBdpXDhViTeIvNAPii1L
 Lk6r22jg+5Z+3oUkdyTxx6ZEvswLvhfh58SwP+S82/V/XJXBw8aK032jGmzAQlUZXjrF
 ArQGdgo1PRDeKCXU0+AWpjXMIaa6GiRmsu4nGHZQPrl704LfObe7Eb7FPrh18+4BYjuo
 yJrw==
X-Gm-Message-State: AOJu0YztDGUE7/14xIZ/V8YZQ84KflC7QJjzbwn+NmFajYGb/PvJvIS+
 PM7XtVnbId8K8kKNRE5xdItHLTAcuRiHXv7VH0+ErRNc2QilwjmUlLq2EgDAz6lVI3cXNS388FI
 4sQ45PJ4y/S8uEnnGemGFogQK0QFaacSpIfC8eKHj2ONR
X-Gm-Gg: AeBDiethn0TpKapPU55r14pCQUfQvCEsKQQFtO5F1HMT/xbaoAmzTDKFbvpIOGm1fLI
 4qnP4KgG/Sq6KavEkSqWwuNKhWLlsPn8tWx/54wq3gUhZG5ClZhPtcgkAptsuKOiN//fjDhTL0x
 bGUJIXSrhnJxaUbu5R/ZMFW8fz2GxQAypGEiSBmausF2+CGjpaSr7jKPeX/ZGANuAYVeKz1yM65
 +/zV59a/kWuMLUspD7fCbSBSJRiWgEEAdH284Dut4A/3AZlEefjmbCAgqBicu+5yhG5EF2L2qPu
 MoG2XzMAbEm7mYEMck0=
X-Received: by 2002:a05:6830:f95:b0:7dc:e0d4:70c5 with SMTP id
 46e09a7af769-7dce0d4726bmr4405025a34.25.1776896997959; Wed, 22 Apr 2026
 15:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260421004719.73491-1-briansune@gmail.com>
 <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
 <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
 <CAFLszTiafeVeAm-A6KVDoiXbEKLOQAWEyojO2msDB-yMPrBUVQ@mail.gmail.com>
In-Reply-To: <CAFLszTiafeVeAm-A6KVDoiXbEKLOQAWEyojO2msDB-yMPrBUVQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 23 Apr 2026 06:29:46 +0800
X-Gm-Features: AQROBzBscW54Xxfjk7RtpkNP_UsNFicw4wI1Cp-EL87gx4avEF7wktiBJO1qdi8
Message-ID: <CAN7C2SDZhThgON+4r318ka=gKsu3OWrEeZ=OW=Q0xppOj1xYTw@mail.gmail.com>
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Chee Tien Fong <tien.fong.chee@altera.com>
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

On Thu, Apr 23, 2026 at 6:10=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Brian,
>
> On Wed, 22 Apr 2026 at 15:13, Sune Brian <briansune@gmail.com> wrote:
> >
> > On Wed, Apr 22, 2026 at 10:54=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Brian,
> > >
> > > On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
> > > > Improve handoff prepare on SoCFPGA
> > > >
> > > > There are some cases that the Python scripts
> > > > are run and the qts files are not replaced.
> > > >
> > > > This patch introduces:
> > > > 1) TMP folder for Python script
> > > > 2) TMP folder will automatically remove on exit
> > > > 3) If PY script fails, the replace will not conduct.
> > > > 4) Only when PY script passed the replace with keep
> > > > or without keep will be done via NEW HANDOFF_KEEP=3Dxxx
> > > > 5) When keep is selected the old files are renamed to
> > > > xxx.h.handoff.<timestamp>
> > > >
> > > > As such this ensure qts folder h files are properly
> > > > updated.
> > > >
> > > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > >
> > > > arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
> > > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Some thoughts though.
> > >
> >
> > Hi Simon.
> >
> > > We try to add a change log for each revision and use imperative
> > > present tense (Introduce a temp folder... rather than This patch
> > > introduces...). Spell out Python script rather than PY script, and
> > > reword as prose or a bullet list instead of 1), 2), ... You could als=
o
> > > explain *why* the qts files were sometimes not being replaced - the
> >
> > Because it is not fully traceable, git pull sometimes could introduce
> > some kind of unknown cases that even run make prepare will not update
> > the h files or the python script itself does not fully replace it from
> > first place.
> > So the easiest way to play safe in any possible condition is
> > [remove and replace] or simply [rename and create].
> >
> > And I don't even fully confirm the cases, while this patch does improve
> > the previous .mk operation no matter if it is solving the unreplacing i=
ssue
> > or not.
> >
> > So the motivation was explained from the title itself.
> >
> > > motivation paragraph currently just says some cases without saying
> > > what goes wrong.
> > >
> > > The message says kept files are renamed to xxx.h.handoff.<timestamp>
> > > but the code uses .h.handoff_backup.<timestamp> - they should match.
> >
> > That my mistake on the description, indeed it should be
> > .h.handoff_backup.<timestamp>
> >
> > The idea just follows T.F. previous optional idea so I don't fully pay =
attention
> > to the wordings.
> >
> > >
> > > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpg=
a/config.mk
> > > > @@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
> > > > +                     if [ -n '$${HANDOFF_KEEP+x}' ] && [ '$${HANDO=
FF_KEEP:-1}' !=3D '0' ]; then \
> > >
> > > How about:
> > >
> >
> > No I don't like this because you ignored my original idea on:
> > 1) HANDOFF_KEEP=3D should run keep
> > because HANDOFF_KEEP cannot without =3D in .mk usage
> > 2) When users use this flag, hence,  it is telling that they want to
> > keep the thingy.
> > So it makes no sense to =3D1 or =3D0 to further control it from first p=
lace.
> > This flag is inherently boolean logic.
> > But due to your suggestion I further elaborated this boolean flag to
> > support =3D0 or =3D1 or =3Dx cases.
> >
> > Sorry for this part, I will not change.
>
> That's fine...note that you have my review tag, so you can add that to
> a new version, if you do one.
>
> >
> > Cheers,
> > Brian
> >
> > > if [ '$${HANDOFF_KEEP:-0}' !=3D '0' ] ; then \

Hi Simon,

V5 has been released.
Due to T.F. "please to use your check condition"

Logically speaking.

The check condition now has become:

A person has no intention to use the restroom.
But that person intentionally walk in front of the restroom door and
speak out not going to use the restroom,
Then that person simply goes back to where he came from and does
not even enter the restroom.

What a wonderful world =3D]

Enjoy,
Brian

> Regards,
> Simon
