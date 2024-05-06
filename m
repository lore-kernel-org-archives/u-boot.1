Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F03C25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 18:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B9988623;
	Mon,  6 May 2024 20:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fXGUq6iV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B41288623; Mon,  6 May 2024 20:29:12 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2840C882E9
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 20:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so364504266b.1
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715020149; x=1715624949;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rDFxAroKJF293sHSxs3tSghAUuS4CT/Ss42V4M8Cjo=;
 b=fXGUq6iVEcgb+2HCj/jqFaJJ9Tj/WPwRe1qGUC7k2229Ojm78jAQTUhUcfzBOd7U9k
 7NQnKX2KTSZVBwDniBusa8N66Fkq7aF0+uHFzalL1TvQW2PXXm25lhPA24TkKILNpFV7
 +GQRFIKntXm7w3dgHDhem+nhTZ6wGVso0f1ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715020149; x=1715624949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rDFxAroKJF293sHSxs3tSghAUuS4CT/Ss42V4M8Cjo=;
 b=X/tlT3OOIvcCrpsbCapuCQ/xaGizZbNz23YrH51yQNO0hsu/aCDg4Pe0Rik2ZFeLs7
 jdK84NZMkGSoE7VaO+ErCR2dwMxJFG9FL1WsYKgv5G4Mr8jFBQfoHQZweEqSsb2lacJB
 13c5ysEuAKMDEwqnQY+ephXGvOs5pKgU4roN4blpadbNSOWnpldHyhFc0FPPf2jNIAIZ
 XDak0kAHedNPg0OvBkoob1c/8bo5pn2OOpHkNOG1lbAT2KPtacyF7imo7YDqSm8H+nh1
 sIb3j+SR0/VyZDPsXd4ZRcDWPXVEHt038aWC4mkomu3KfSTW1LleeoIsaRV1kwVaXyYR
 v13g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyoUrKmBE7bD0CCoDzApp7kE4WuDNExbAjaB54Ub2f2HSxyZdQT7831MBgR3QVnK3D51rewE2hXjA80ogv5qGPrhKbKw==
X-Gm-Message-State: AOJu0YxtkoT3WvYNztwESOCsrnnO0KbBiGC0SuKcaBgPlzwD/Ql/WOXM
 7iDwkgZMTF4WUAHxBadvv4tQOTDCfTK2yq9cBZCizQ6r5pExmcHeZWpbm8HvmNTt7YYQhUOfONY
 HR3cVp/aiPYBJXWbSzWjgP/fKhi3CLmd+QFK1uw==
X-Google-Smtp-Source: AGHT+IGXbQYi6Y3yVQpfJhCqgpvHrY3a/DKYfoPYYjtc8JkfuyrHs2k5brQDvX3L0yKa8UZsqLHsxe5Hn9UNzDyzxPE=
X-Received: by 2002:a17:906:34d9:b0:a55:5698:3ea6 with SMTP id
 a640c23a62f3a-a59e4e34f9bmr35784866b.29.1715020149458; Mon, 06 May 2024
 11:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
 <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
 <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
In-Reply-To: <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 6 May 2024 20:28:58 +0200
Message-ID: <CAOf5uwktymi4uvZTBA5hJ6EfdyytteSUDM_b2TyPKFJsu2LLSQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
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

On Mon, May 6, 2024 at 7:33=E2=80=AFPM Ravi Minnikanti <rminnikanti@marvell=
.com> wrote:
>
> On 5/6/24 00:35, Michael Nazzareno Trimarchi wrote:
> > Hi Ravi
> >
> > On Tue, Apr 30, 2024 at 6:25=E2=80=AFAM Ravi Minnikanti <rminnikanti@ma=
rvell.com> wrote:
> >>
> >> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
> >>
> >>> ---------------------------------------------------------------------=
-
> >>> On Mon, Apr 29, 2024 at 6:22=E2=80=AFPM Chris Packham <judge.packham@=
gmail.com> wrote:
> >>>>
> >>>> On Sun, Apr 28, 2024 at 4:15=E2=80=AFAM Ravi Minnikanti <rminnikanti=
@marvell.com> wrote:
> >>>>>
> >>>>> Once a page is read with higher bitflips all subsequent reads
> >>>>> are returning the same bitflip value even though they have none.
> >>>>> max_bitflip variable is not being reset to 0 across page reads.
> >>>>>
> >>>>> This is causing problems like incorrectly
> >>>>> marking erase blocks bad by UBI and causing read failures.
> >>>>>
> >>>>> Verified the change with both MTD reads and UBI.
> >>>>> This change is inline with other NFC drivers.
> >>>>>
> >>>>> Sample error log where a block is marked bad incorrectly:
> >>>>>
> >>>>> ubi0: fixable bit-flip detected at PEB 125
> >>>>> ubi0: run torture test for PEB 125
> >>>>> ubi0: fixable bit-flip detected at PEB 125
> >>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> >>>>> must be bad
> >>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> >>>>> ubi0: mark PEB 125 as bad
> >>>>>
> >>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> >>>>
> >>>> Looks good to me
> >>>>
> >>>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
> >>>>
> >>>>> ---
> >>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
> >>>>>  1 file changed, 5 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/=
raw/pxa3xx_nand.c
> >>>>> index 1d9a6d107b..d2a4faad56 100644
> >>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> >>>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3x=
x_nand_info *info, int command)
> >>>>>         info->ecc_err_cnt       =3D 0;
> >>>>>         info->ndcb3             =3D 0;
> >>>>>         info->need_wait         =3D 0;
> >>>>> +       /*
> >>>>> +        * Reset max_bitflips to zero. Once command is complete,
> >>>>> +        * max_bitflips for this READ is returned in ecc.read_page(=
)
> >>>>> +        */
> >>>>> +       info->max_bitflips      =3D 0;
> >>>>>
> >>>
> >>> Why this should not be put to 0 in read_page instead on prepare_start=
_command?
> >>>
> >>> Michael
> >>>
> >>
> >> ecc.read_page is invoked after the read command execution.
> >> First chip->cmdfunc is executed with NAND_CMD_READ0 and then ecc.read_=
page is invoked
> >> to read the page from buffer. So, by the time read_page is invoked, in=
fo->max_bitflips
> >> must already have the bit flip value.
> >>
> >
> > All the other implementation has a slight different way to handle.
> > From what you said the reset should
> > be done on for NAND_CMD_READ0 command and should be sufficient.
> > Technically should be moved
> > in switch and not unconditionally.
> >
> > Michael
> >
>
> max_bitflip is not being reset to 0 across page reads.
> Once a page is read with higher bitflips all subsequent reads
> are returning the same bitflip value even though they have none.
>
> This is causing problems like incorrectly
> marking erase blocks bad by UBI and read failures.
>
> Tested it with both MTD reads and UBI attach.
> This change is inline with other NFC drivers.
>
> Sample error log where a block is marked bad incorrectly:
>
> ubi0: fixable bit-flip detected at PEB 125
> ubi0: run torture test for PEB 125
> ubi0: fixable bit-flip detected at PEB 125
> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> must be bad
> ubi0 error: erase_worker: failed to erase PEB 125, error -5
> ubi0: mark PEB 125 as bad
>
> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> ---
>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/px=
a3xx_nand.c
> index 1d9a6d107b..97f250483f 100644
> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> @@ -803,6 +803,11 @@ static void prepare_start_command(struct pxa3xx_nand=
_info *info, int command)
>
>         switch (command) {
>         case NAND_CMD_READ0:
> +               /*
> +                * Reset max_bitflips to zero. Once command is complete,
> +                * max_bitflips for this READ is returned in ecc.read_pag=
e()
> +                */
> +               info->max_bitflips =3D 0;
>         case NAND_CMD_READOOB:
>         case NAND_CMD_PAGEPROG:
>                 if (!info->force_raw)
> --
> 2.17.1
>
> Thanks Michael. Fixed it.
>
> >> Thanks, Ravi.
> >>
> >>>>>         switch (command) {
> >>>>>         case NAND_CMD_READ0:
> >>>>> --
> >>>>> 2.17.1
> >>>
> >>
> >
> >

Acked-by: Michael Trimarchi <michael@amarulasolutions.com>



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
