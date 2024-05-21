Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA001C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 20:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A776A883B1;
	Tue, 21 May 2024 22:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q017A5Tg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A696D883AF; Tue, 21 May 2024 22:15:17 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6672188363
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 22:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-574d1a1c36aso9085561a12.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716322514; x=1716927314;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fkiVTvyxSB4/75j0GuvVvPZIg+79guC/X6rggKHxqUY=;
 b=Q017A5TgRjY6RaI6tSS/2QZX5iRWx3xWQkOAW9pInI794ToeICxWKUmxh4BfJyMSZj
 YDBlb4Zf3X58BBKWdon9yuYlKiTioS8tgbt159Wn3FK3zmCLMpwmW9D0SurKNFc0dn7X
 cS/b3pwHZ/PIgwcNUtcisQZgBUM56MqeXW2Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716322514; x=1716927314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkiVTvyxSB4/75j0GuvVvPZIg+79guC/X6rggKHxqUY=;
 b=D41pq5PecBGxf/48RJ3Ku9pUfhNCYU/qgtcoDgwX2oX32QtthgaLji2zOF3clXj70c
 2XrcLIVuuomKmraTcRoyTiOfY/MY8hxCiIIeNiCT0u5WAW+a/SR69+ZGUlA9Gu53EYfi
 6RTEdVmE9sqFv0Pk9QcTMOyIvOi5RJ8G6xfOMPoN85gobOz/Viqonfcn1T8T7xgIg1j5
 jcBM4URt1aEsQB3M/I4VQaQAOI6dNtzJZ4fZyjCtAzQ6EaZyCfc3cgigaoxkjPXklnT1
 DZF+TQKOGeyqP6eF+3kn10JHD4fgFynWJ3rzthc6zd5IoDni8d7AT7BYXMvV/HEdbbx+
 ywZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNuesas+gEkbQZWDJbQfliokN8WGchVqlnb1FsM2NDJ5fH3Rm5YGvB1KmTK0dBe83AwNoCLkhQErbJWpCkhxViBjbkqQ==
X-Gm-Message-State: AOJu0YxUalOr5gtp2yNRu9bCoBVNS5hEXxnR5/TFEZzakOclSjY5OHIX
 AgFwyCwfUb60dPAOqQ7hr2iQwyOq8CpxgizRMBikkG4CklF9XZMt10+4bs6Pjn1r4rhfp9olKn3
 z2xlRpbzzxVeTF4M8ViygoHXuu/7P/DExsW63i7gyWQjYXcIG
X-Google-Smtp-Source: AGHT+IHQZuoXxxcZL9DnfuxA7jVhHZ/kLEDkX8TfHO+56v644DdVJ9XOVKLbPJyiNGJagchMz2J/wIYt5r7D8+dPgps=
X-Received: by 2002:aa7:d294:0:b0:574:eb43:3865 with SMTP id
 4fb4d7f45d1cf-574eb433921mr13249006a12.32.1716322513650; Tue, 21 May 2024
 13:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
 <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
 <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
 <CAOf5uwktymi4uvZTBA5hJ6EfdyytteSUDM_b2TyPKFJsu2LLSQ@mail.gmail.com>
 <89eef6cf-c2c1-24ac-225f-e104580e99b8@marvell.com>
In-Reply-To: <89eef6cf-c2c1-24ac-225f-e104580e99b8@marvell.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 21 May 2024 22:15:01 +0200
Message-ID: <CAOf5uw=ct9u=K-F_WHOaR0n7oKJ_Xq2MAOU4Aewg_0fLR+cAYw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip
 return on page read
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: Tom Rini <trini@konsulko.com>, Chris Packham <judge.packham@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Heiko Schocher <hs@denx.de>, Stefan Roese <sr@denx.de>
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

Hi Dario

Can you add to next pull?

Michael

On Tue, May 21, 2024, 4:31=E2=80=AFPM Ravi Minnikanti <rminnikanti@marvell.=
com>
wrote:

> Hi,
>
> Can you please merge this PR, if there are no more review comments?
>
> Thanks,
> Ravi
> On 5/6/24 11:28, Michael Nazzareno Trimarchi wrote:
>
> > ----------------------------------------------------------------------
> > Hi Ravi
> >
> > On Mon, May 6, 2024 at 7:33=E2=80=AFPM Ravi Minnikanti <rminnikanti@mar=
vell.com>
> wrote:
> >>
> >> On 5/6/24 00:35, Michael Nazzareno Trimarchi wrote:
> >>> Hi Ravi
> >>>
> >>> On Tue, Apr 30, 2024 at 6:25=E2=80=AFAM Ravi Minnikanti <
> rminnikanti@marvell.com> wrote:
> >>>>
> >>>> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
> >>>>
> >>>>>
> ----------------------------------------------------------------------
> >>>>> On Mon, Apr 29, 2024 at 6:22=E2=80=AFPM Chris Packham <
> judge.packham@gmail.com> wrote:
> >>>>>>
> >>>>>> On Sun, Apr 28, 2024 at 4:15=E2=80=AFAM Ravi Minnikanti <
> rminnikanti@marvell.com> wrote:
> >>>>>>>
> >>>>>>> Once a page is read with higher bitflips all subsequent reads
> >>>>>>> are returning the same bitflip value even though they have none.
> >>>>>>> max_bitflip variable is not being reset to 0 across page reads.
> >>>>>>>
> >>>>>>> This is causing problems like incorrectly
> >>>>>>> marking erase blocks bad by UBI and causing read failures.
> >>>>>>>
> >>>>>>> Verified the change with both MTD reads and UBI.
> >>>>>>> This change is inline with other NFC drivers.
> >>>>>>>
> >>>>>>> Sample error log where a block is marked bad incorrectly:
> >>>>>>>
> >>>>>>> ubi0: fixable bit-flip detected at PEB 125
> >>>>>>> ubi0: run torture test for PEB 125
> >>>>>>> ubi0: fixable bit-flip detected at PEB 125
> >>>>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> >>>>>>> must be bad
> >>>>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> >>>>>>> ubi0: mark PEB 125 as bad
> >>>>>>>
> >>>>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> >>>>>>
> >>>>>> Looks good to me
> >>>>>>
> >>>>>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
> >>>>>>
> >>>>>>> ---
> >>>>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
> >>>>>>>  1 file changed, 5 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c
> b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>>>>>> index 1d9a6d107b..d2a4faad56 100644
> >>>>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>>>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>>>>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct
> pxa3xx_nand_info *info, int command)
> >>>>>>>         info->ecc_err_cnt       =3D 0;
> >>>>>>>         info->ndcb3             =3D 0;
> >>>>>>>         info->need_wait         =3D 0;
> >>>>>>> +       /*
> >>>>>>> +        * Reset max_bitflips to zero. Once command is complete,
> >>>>>>> +        * max_bitflips for this READ is returned in
> ecc.read_page()
> >>>>>>> +        */
> >>>>>>> +       info->max_bitflips      =3D 0;
> >>>>>>>
> >>>>>
> >>>>> Why this should not be put to 0 in read_page instead on
> prepare_start_command?
> >>>>>
> >>>>> Michael
> >>>>>
> >>>>
> >>>> ecc.read_page is invoked after the read command execution.
> >>>> First chip->cmdfunc is executed with NAND_CMD_READ0 and then
> ecc.read_page is invoked
> >>>> to read the page from buffer. So, by the time read_page is invoked,
> info->max_bitflips
> >>>> must already have the bit flip value.
> >>>>
> >>>
> >>> All the other implementation has a slight different way to handle.
> >>> From what you said the reset should
> >>> be done on for NAND_CMD_READ0 command and should be sufficient.
> >>> Technically should be moved
> >>> in switch and not unconditionally.
> >>>
> >>> Michael
> >>>
> >>
> >> max_bitflip is not being reset to 0 across page reads.
> >> Once a page is read with higher bitflips all subsequent reads
> >> are returning the same bitflip value even though they have none.
> >>
> >> This is causing problems like incorrectly
> >> marking erase blocks bad by UBI and read failures.
> >>
> >> Tested it with both MTD reads and UBI attach.
> >> This change is inline with other NFC drivers.
> >>
> >> Sample error log where a block is marked bad incorrectly:
> >>
> >> ubi0: fixable bit-flip detected at PEB 125
> >> ubi0: run torture test for PEB 125
> >> ubi0: fixable bit-flip detected at PEB 125
> >> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> >> must be bad
> >> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> >> ubi0: mark PEB 125 as bad
> >>
> >> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> >> ---
> >>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c
> b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >> index 1d9a6d107b..97f250483f 100644
> >> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> >> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >> @@ -803,6 +803,11 @@ static void prepare_start_command(struct
> pxa3xx_nand_info *info, int command)
> >>
> >>         switch (command) {
> >>         case NAND_CMD_READ0:
> >> +               /*
> >> +                * Reset max_bitflips to zero. Once command is complet=
e,
> >> +                * max_bitflips for this READ is returned in
> ecc.read_page()
> >> +                */
> >> +               info->max_bitflips =3D 0;
> >>         case NAND_CMD_READOOB:
> >>         case NAND_CMD_PAGEPROG:
> >>                 if (!info->force_raw)
> >> --
> >> 2.17.1
> >>
> >> Thanks Michael. Fixed it.
> >>
> >>>> Thanks, Ravi.
> >>>>
> >>>>>>>         switch (command) {
> >>>>>>>         case NAND_CMD_READ0:
> >>>>>>> --
> >>>>>>> 2.17.1
> >>>>>
> >>>>
> >>>
> >>>
> >
> > Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> >
> >
>
