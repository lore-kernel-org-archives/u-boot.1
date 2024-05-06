Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B1C4345F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 07:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC7187F6F;
	Mon,  6 May 2024 09:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="molUN7CX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F8787FB6; Mon,  6 May 2024 09:36:07 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2724C87F8B
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 09:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59a0168c75so383153666b.1
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714980964; x=1715585764;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMEejgVw62+LfwhtD6UZPQz3iucUJGkR6/oijPpXhPA=;
 b=molUN7CXpVLj+2TtTvoiK5iL0os9JGSy+d5hsyAUfjH24Kj6rrgmTtAeg0dVdFW9bv
 cqQyGKSSIQSo5D88CpYCLhkQKgPvHG5RZsspjx1ipP4Lqo9v8+3ICtAya0nAjRru40Hr
 0RtLrD7rvlJpWrWWvi/8aA/MVERZ62aM6A7EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714980964; x=1715585764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMEejgVw62+LfwhtD6UZPQz3iucUJGkR6/oijPpXhPA=;
 b=d0kL9NCZ8/eHqHbfnoWJ2rCOnMuHlQF5hwMC/wExzVkGz8ziaRwyNBmaxuB/su9BDS
 XYQIhoc/WkvuNnit25ba1qm86lR1Be+Xbq1xNVDv/TRSwBnK0X5zAjem4v2zZ9/fR2Ib
 KcubSdSTpU3hLMdLWrb01nnBaXQtnBkO1ZSOMQl813CbqL6pSOsavZbEgea6fu8EMtkz
 2supzsCSrQ4oPILOO/DHOEYi1C/Fo4ezkJtdVkyLPf1A1HOqhsSFUa1VN0ZGkRN6GnMu
 wIC4PWMofANBFq8FoKf1fBcw+pb4pbUHkZuOmIwTb1hgm7BYdYFy7aCww1qlxI+h8WTG
 hhcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl0YWIc7XNEqMozEoe7SnJDSPoEDxJqBJ2dBWb3QnlzySKTpZAdwaiC/U5N3syOSlJZhcxT9fvYBSHWLtR5Uo+p3AEYg==
X-Gm-Message-State: AOJu0Yw//M5iWlAZ5m3cQkVmLdE7XCAlwYgOtccsWY2g1ETtmyoEa+rT
 JIP8srxJkWQCwuRoAPCG0nvsz8he8UzG/Y6qfYscvnIiWgTgihTLi3AASGkdJ6SQqWy2P3WhtIY
 ebJ/C78UfdbVtQ43Kdw1JVtS+TJaFegaTCddUEw==
X-Google-Smtp-Source: AGHT+IHyC+7J8qXg1sxBHuZ642fsg85UXIUgaw6FxdNW85FA+8DyXnz2OpKM0sdV1ROxNWj1GW4J3Xk8Ldk4y5ZSjsM=
X-Received: by 2002:a50:8d13:0:b0:572:9b20:fd with SMTP id
 s19-20020a508d13000000b005729b2000fdmr5606102eds.31.1714980964400; 
 Mon, 06 May 2024 00:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
In-Reply-To: <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 6 May 2024 09:35:53 +0200
Message-ID: <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip
 return on page read
To: Ravi Minnikanti <rminnikanti@marvell.com>
Cc: Chris Packham <judge.packham@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 hs@denx.de, trini@konsulko.com, sr@denx.de
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

Hi Ravi

On Tue, Apr 30, 2024 at 6:25=E2=80=AFAM Ravi Minnikanti <rminnikanti@marvel=
l.com> wrote:
>
> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
>
> > ----------------------------------------------------------------------
> > On Mon, Apr 29, 2024 at 6:22=E2=80=AFPM Chris Packham <judge.packham@gm=
ail.com> wrote:
> >>
> >> On Sun, Apr 28, 2024 at 4:15=E2=80=AFAM Ravi Minnikanti <rminnikanti@m=
arvell.com> wrote:
> >>>
> >>> Once a page is read with higher bitflips all subsequent reads
> >>> are returning the same bitflip value even though they have none.
> >>> max_bitflip variable is not being reset to 0 across page reads.
> >>>
> >>> This is causing problems like incorrectly
> >>> marking erase blocks bad by UBI and causing read failures.
> >>>
> >>> Verified the change with both MTD reads and UBI.
> >>> This change is inline with other NFC drivers.
> >>>
> >>> Sample error log where a block is marked bad incorrectly:
> >>>
> >>> ubi0: fixable bit-flip detected at PEB 125
> >>> ubi0: run torture test for PEB 125
> >>> ubi0: fixable bit-flip detected at PEB 125
> >>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> >>> must be bad
> >>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> >>> ubi0: mark PEB 125 as bad
> >>>
> >>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> >>
> >> Looks good to me
> >>
> >> Reviewed-by: Chris Packham <judge.packham@gmail.com>
> >>
> >>> ---
> >>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/ra=
w/pxa3xx_nand.c
> >>> index 1d9a6d107b..d2a4faad56 100644
> >>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_=
nand_info *info, int command)
> >>>         info->ecc_err_cnt       =3D 0;
> >>>         info->ndcb3             =3D 0;
> >>>         info->need_wait         =3D 0;
> >>> +       /*
> >>> +        * Reset max_bitflips to zero. Once command is complete,
> >>> +        * max_bitflips for this READ is returned in ecc.read_page()
> >>> +        */
> >>> +       info->max_bitflips      =3D 0;
> >>>
> >
> > Why this should not be put to 0 in read_page instead on prepare_start_c=
ommand?
> >
> > Michael
> >
>
> ecc.read_page is invoked after the read command execution.
> First chip->cmdfunc is executed with NAND_CMD_READ0 and then ecc.read_pag=
e is invoked
> to read the page from buffer. So, by the time read_page is invoked, info-=
>max_bitflips
> must already have the bit flip value.
>

All the other implementation has a slight different way to handle.
From what you said the reset should
be done on for NAND_CMD_READ0 command and should be sufficient.
Technically should be moved
in switch and not unconditionally.

Michael

> Thanks, Ravi.
>
> >>>         switch (command) {
> >>>         case NAND_CMD_READ0:
> >>> --
> >>> 2.17.1
> >
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
