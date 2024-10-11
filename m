Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33113D0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 16:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3BE89069;
	Fri, 11 Oct 2024 18:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3HjoYay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9462E89386; Fri, 11 Oct 2024 18:01:38 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DA48900F
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimiliano.minella@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so1451156a12.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728662494; x=1729267294; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKH+YzdTJTe3VQtz/byGwrIRugegG6XAcNYA7/ApqBQ=;
 b=Y3HjoYay7IgZR+/VSFbA0cEQpfABxrcn5jk4WzDd/71sHFUAhEr6EaaHiAZNZlZRt4
 JXVGo06B/YkvPl266vLQfL2wdCo8FeYwlWkvcGEkqC+GzNzI56Ioi7ow+70r1RChVeJm
 SKCYdnkXFsLGnuXaYoefz1LyAEl8IUZ1yR2xFrAIQz+Q0vytyAX0djaWVzNwUaBmuie4
 hym9pmo2zdajKaC4/mCbKHT0iSnAYj0v6fG0A4hqaVtSB6QAnN4OPeqXphmBGgvLP7QC
 9LI3ph+7yLOCvI6AmsdBg6V72LqGyPF+M97Oh41OxyC6EesGNpAuwsdsOjAjaPC+S1AD
 Ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728662494; x=1729267294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKH+YzdTJTe3VQtz/byGwrIRugegG6XAcNYA7/ApqBQ=;
 b=e6hicyypZIIo+gtW5gtG6b/uf8ll6IIYHbTjj8TkvZU52MGdIpP2R7ODiFGdo5wl7G
 7oe6+qgT0WDokO9fESzdhP+V7HGXe7cBBEq+4Meb9fKRHITCbUb1HgCwZPoR6nGRI4Ys
 C6ocin7yEuvBX3vdQkkT/lRxoltoqb2EyuVYQ+cI498fQSqeBqA9tQKayxJji/ILyICk
 n4xmxEeYz5oUsiI3e9NaQ/GtXDEUzzLX3DWW3TkZ+/RoHxZ3ItLK+TBxPC70lmqzId3o
 wPRCG+hcIv/07uBDxN4ze5LJt2Dbbd6O5umuwi3FQMYYMaNXyQAjMKz5Y+O30wd+gX6t
 HA8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXCBapTbw5VnLfmPNyhLEsAateUv2X2lRn/3cerq1wIzQ3RcVdkUbPmh1StsYbP+0Y5UExn/o=@lists.denx.de
X-Gm-Message-State: AOJu0YxBcd7cvUoYWFVuMJotm5eeu+47AuCPYvOODp1ppPMG2zTyByjS
 7+4xW6i168Rfxj5WPOf3QKFn4vY0lqZnSQSjgThMrCD6rj2g8XoTApI7GufIBebV2iLKQ2fqg+8
 zpPQHliLJhwug1ABUwVMR+OLJN/g=
X-Google-Smtp-Source: AGHT+IGokYmqAYxU9yYF0LfjfG3fnBY7Kro03T9Z1LyCIRqvhT4SGskU0AzmU2ENyGwjG2Nqdl0qdt3BTjVDuZWWGY8=
X-Received: by 2002:a17:90a:12cb:b0:2e2:ee31:87 with SMTP id
 98e67ed59e1d1-2e2f0ad0818mr4256255a91.21.1728662493966; Fri, 11 Oct 2024
 09:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
 <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
 <20241008172035.GA66965@francesco-nb>
In-Reply-To: <20241008172035.GA66965@francesco-nb>
From: Massimiliano Minella <massimiliano.minella@gmail.com>
Date: Fri, 11 Oct 2024 18:01:22 +0200
Message-ID: <CAGS_c3WoCApeh4QVDrG7=tF=wwEsFStKmRphzfVGTtwKT9yJhQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: setexpr: fix no matching string in gsub return
 empty value
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de, Lukas Funke <lukas.funke-oss@weidmueller.com>, 
 Massimiliano Minella <massimiliano.minella@se.com>,
 Michal Simek <monstr@monstr.eu>
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

Hello,

On Tue, Oct 8, 2024 at 7:20=E2=80=AFPM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> +Tom
>
> Hello Massimiliano,
>
> On Tue, Sep 03, 2024 at 01:06:21PM +0200, Michal Simek wrote:
> > HI,
> >
> > =C4=8Dt 8. 2. 2024 v 16:00 odes=C3=ADlatel Massimiliano Minella
> > <massimiliano.minella@gmail.com> napsal:
> > >
> > > From: Massimiliano Minella <massimiliano.minella@se.com>
> > >
> > > In gsub, when the destination string is empty, the string 't' is
> > > provided and the regular expression doesn't match, then the final res=
ult
> > > is an empty string.
> > >
> > > Example:
> > >
> > > =3D> echo ${foo}
> > >
> > > =3D> setenv foo
> > > =3D> setexpr foo gsub e a bar
> > > =3D> echo ${foo}
> > >
> > > =3D>
> > >
> > > The variable ${foo} should contain "bar" and the lack of match should=
n't
> > > be considered an error.
> > >
> > > This patch fixes the erroneous behavior by removing the return
> > > statement and breaking out of the loop in case of lack of match.
> > >
> > > Also add a test for the no match case.
> > >
> > > Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
> > > ---
> > > Changes in V2:
> > >  - update documentation to describe the behavior
> > >
> > >  cmd/setexpr.c             |  9 ++++-----
> > >  doc/usage/cmd/setexpr.rst |  1 +
> > >  test/cmd/setexpr.c        | 10 ++++++++++
> > >  3 files changed, 15 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/cmd/setexpr.c b/cmd/setexpr.c
> > > index 233471f6cb..ab76824a32 100644
> > > --- a/cmd/setexpr.c
> > > +++ b/cmd/setexpr.c
> > > @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_siz=
e, char *nbuf, uint nbuf_size,
> > >                 if (res =3D=3D 0) {
> > >                         if (loop =3D=3D 0) {
> > >                                 debug("%s: No match\n", data);
> > > -                               return 1;
> >
> > This patch actually changed the return value from command.
> > In board/xilinx/zynqmp/zynqmp_kria.env we have
> >
> > bootcmd=3Dsetenv model $board_name && if setexpr model gsub
> > .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter*
> > $k26_starter; then run som_cc_boot; else run som_mmc_boot; run
> > som_cc_boot; fi
> >
> > and this patch actually breaked it because we rely on return value.
> > Changing return value is not described and I want to know if this
> > patch should be fixed
> > or we should update our commands to match new return value.
>
> Massimilano, any comment on this?
>
> This change broke also our use case - our board is no longer booting
> with v2024.10 U-Boot. I do not think we should change something like
> that without a clear reason and I was not able to understand it from the
> commit message.

The reason why I proposed the patch was that I found the behavior of setexp=
r
gsub not consistent with the behavior of the same function in gawk, which,
according to the commit message that introduced gsub/sub, both commands are
closely modeled after. Also I didn't see a particular reason for returning =
an
empty string or throwing an error when doing a string substitution that pro=
vides
no match, so IMHO it was a bug.

From a quick grep on the master branch it seems that the command is used on=
ly in
board/xilinx/zynqmp/zynqmp_kria.env and include/env/ti/ti_common.env. In th=
e
first I see it has already been fixed and in the second the change has no
impact.

It's unfortunate that it broke the boot of your board, maybe something as i=
t has
been done for the zynqmp_kria is feasible according to your use of the comm=
and?

Regards,
Massimiliano
